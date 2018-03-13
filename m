Received: from eggs.gnu.org ([2001:4830:134:3::10]:58855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiv-0006Yn-0i
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiu-0004IN-01
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:49 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsit-0004Hv-PL
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:47 -0400
Received: by mail-wm0-x242.google.com with SMTP id s206so16181396wme.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:47:19 +0100
Message-Id: <20180313224719.4954-70-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 69/69] tcg: fix cpu_io_recompile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

cpu_io_recompile() function was broken by
the commit 9b990ee5a3cc6aa38f81266fb0c6ef37a36c45b9. Instead of regenerating
the block starting from PC of the original block, it just set the instruction
counter for TCG. In most cases this was unnoticed, but in icount mode
there was an exception for incorrect usage of CF_LAST_IO flag.
This patch recovers recompilation of the original block and also
configures translation for executing single IO instruction which
caused a recompilation.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20180227095338.1060.27385.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 accel/tcg/translate-all.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 67795cd78c..5ad1b919bc 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1728,7 +1728,8 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     CPUArchState *env = cpu->env_ptr;
 #endif
     TranslationBlock *tb;
-    uint32_t n;
+    uint32_t n, flags;
+    target_ulong pc, cs_base;
 
     tb_lock();
     tb = tb_find_pc(retaddr);
@@ -1766,8 +1767,14 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
         cpu_abort(cpu, "TB too big during recompile");
     }
 
-    /* Adjust the execution state of the next TB.  */
-    cpu->cflags_next_tb = curr_cflags() | CF_LAST_IO | n;
+    pc = tb->pc;
+    cs_base = tb->cs_base;
+    flags = tb->flags;
+    tb_phys_invalidate(tb, -1);
+
+    /* Execute one IO instruction without caching
+       instead of creating large TB. */
+    cpu->cflags_next_tb = curr_cflags() | CF_LAST_IO | CF_NOCACHE | 1;
 
     if (tb->cflags & CF_NOCACHE) {
         if (tb->orig_tb) {
@@ -1778,6 +1785,11 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
         tb_remove(tb);
     }
 
+    /* Generate new TB instead of the current one. */
+    /* FIXME: In theory this could raise an exception.  In practice
+       we have already translated the block once so it's probably ok.  */
+    tb_gen_code(cpu, pc, cs_base, flags, curr_cflags() | CF_LAST_IO | n);
+
     /* TODO: If env->pc != tb->pc (i.e. the faulting instruction was not
      * the first in the TB) then we end up generating a whole new TB and
      *  repeating the fault, which is horribly inefficient.
-- 
2.14.3
