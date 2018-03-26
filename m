Received: from eggs.gnu.org ([2001:4830:134:3::10]:57237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ6-0006eF-3G
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ3-00070R-Ce
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:04 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:42063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SJ3-0006zw-5g
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:01 -0400
Received: by mail-wr0-x22f.google.com with SMTP id s18so18939419wrg.9
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:37:01 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:38 +0200
Message-Id: <1522071403-52486-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/16] tcg: Really fix cpu_io_recompile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

We have confused the number of instructions that have been
executed in the TB with the number of instructions needed
to repeat the I/O instruction.

We have used cpu_restore_state_from_tb, which means that
the guest pc is pointing to the I/O instruction.  The only
time the answer to the later question is not 1 is when
MIPS or SH4 need to re-execute the branch for the delay
slot as well.

We must rely on cpu->cflags_next_tb to generate the next TB,
as otherwise we have a race condition with other guest cpus
within the TB cache.

Fixes: 0790f86861079b1932679d0f011e431aaf4ee9e2
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180319031545.29359-1-richard.henderson@linaro.org>
Tested-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/translate-all.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5ad1b91..d419060 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1728,8 +1728,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     CPUArchState *env = cpu->env_ptr;
 #endif
     TranslationBlock *tb;
-    uint32_t n, flags;
-    target_ulong pc, cs_base;
+    uint32_t n;
 
     tb_lock();
     tb = tb_find_pc(retaddr);
@@ -1737,44 +1736,33 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
         cpu_abort(cpu, "cpu_io_recompile: could not find TB for pc=%p",
                   (void *)retaddr);
     }
-    n = cpu->icount_decr.u16.low + tb->icount;
     cpu_restore_state_from_tb(cpu, tb, retaddr);
-    /* Calculate how many instructions had been executed before the fault
-       occurred.  */
-    n = n - cpu->icount_decr.u16.low;
-    /* Generate a new TB ending on the I/O insn.  */
-    n++;
+
     /* On MIPS and SH, delay slot instructions can only be restarted if
        they were already the first instruction in the TB.  If this is not
        the first instruction in a TB then re-execute the preceding
        branch.  */
+    n = 1;
 #if defined(TARGET_MIPS)
-    if ((env->hflags & MIPS_HFLAG_BMASK) != 0 && n > 1) {
+    if ((env->hflags & MIPS_HFLAG_BMASK) != 0
+        && env->active_tc.PC != tb->pc) {
         env->active_tc.PC -= (env->hflags & MIPS_HFLAG_B16 ? 2 : 4);
         cpu->icount_decr.u16.low++;
         env->hflags &= ~MIPS_HFLAG_BMASK;
+        n = 2;
     }
 #elif defined(TARGET_SH4)
     if ((env->flags & ((DELAY_SLOT | DELAY_SLOT_CONDITIONAL))) != 0
-            && n > 1) {
+        && env->pc != tb->pc) {
         env->pc -= 2;
         cpu->icount_decr.u16.low++;
         env->flags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
+        n = 2;
     }
 #endif
-    /* This should never happen.  */
-    if (n > CF_COUNT_MASK) {
-        cpu_abort(cpu, "TB too big during recompile");
-    }
 
-    pc = tb->pc;
-    cs_base = tb->cs_base;
-    flags = tb->flags;
-    tb_phys_invalidate(tb, -1);
-
-    /* Execute one IO instruction without caching
-       instead of creating large TB. */
-    cpu->cflags_next_tb = curr_cflags() | CF_LAST_IO | CF_NOCACHE | 1;
+    /* Generate a new TB executing the I/O insn.  */
+    cpu->cflags_next_tb = curr_cflags() | CF_LAST_IO | n;
 
     if (tb->cflags & CF_NOCACHE) {
         if (tb->orig_tb) {
@@ -1785,11 +1773,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
         tb_remove(tb);
     }
 
-    /* Generate new TB instead of the current one. */
-    /* FIXME: In theory this could raise an exception.  In practice
-       we have already translated the block once so it's probably ok.  */
-    tb_gen_code(cpu, pc, cs_base, flags, curr_cflags() | CF_LAST_IO | n);
-
     /* TODO: If env->pc != tb->pc (i.e. the faulting instruction was not
      * the first in the TB) then we end up generating a whole new TB and
      *  repeating the fault, which is horribly inefficient.
-- 
1.8.3.1
