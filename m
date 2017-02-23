Received: from eggs.gnu.org ([2001:4830:134:3::10]:44350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgy9A-0004LV-QK
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgy97-0006WI-LD
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:29:44 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cgy97-0006Uo-Ct
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:29:41 -0500
Received: by mail-wm0-x235.google.com with SMTP id r141so7047452wmg.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 10:29:41 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 23 Feb 2017 18:29:15 +0000
Message-Id: <20170223182927.7166-13-alex.bennee@linaro.org>
In-Reply-To: <20170223182927.7166-1-alex.bennee@linaro.org>
References: <20170223182927.7166-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 12/24] tcg: handle EXCP_ATOMIC exception
 for system emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

From: Pranith Kumar <bobby.prani@gmail.com>

The patch enables handling atomic code in the guest. This should be
preferably done in cpu_handle_exception(), but the current assumptions
regarding when we can execute atomic sections cause a deadlock.

The current mechanism discards the flags which were set in atomic
execution. We ensure they are properly saved by calling the
cc->cpu_exec_enter/leave() functions around the loop.

As we are running cpu_exec_step_atomic() from the outermost loop we
need to avoid an abort() when single stepping over atomic code since
debug exception longjmp will point to the the setlongjmp in
cpu_exec(). We do this by setting a new jmp_env so that it jumps back
here on an exception.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
[AJB: tweak title, merge with new patches, add mmap_lock]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
CC: Paolo Bonzini <pbonzini@redhat.com>

---
v13
  - merge in mttcg: Set jmp_env to handle exit from tb_gen_code
---
 cpu-exec.c | 43 +++++++++++++++++++++++++++++++------------
 cpus.c     |  9 +++++++++
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 2edd26e823..1a5ad4889d 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -228,24 +228,43 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
 
 static void cpu_exec_step(CPUState *cpu)
 {
+    CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchState *env = (CPUArchState *)cpu->env_ptr;
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
 
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
-    tb_lock();
-    tb = tb_gen_code(cpu, pc, cs_base, flags,
-                     1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
-    tb->orig_tb = NULL;
-    tb_unlock();
-    /* execute the generated code */
-    trace_exec_tb_nocache(tb, pc);
-    cpu_tb_exec(cpu, tb);
-    tb_lock();
-    tb_phys_invalidate(tb, -1);
-    tb_free(tb);
-    tb_unlock();
+    if (sigsetjmp(cpu->jmp_env, 0) == 0) {
+        mmap_lock();
+        tb_lock();
+        tb = tb_gen_code(cpu, pc, cs_base, flags,
+                         1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
+        tb->orig_tb = NULL;
+        tb_unlock();
+        mmap_unlock();
+
+        cc->cpu_exec_enter(cpu);
+        /* execute the generated code */
+        trace_exec_tb_nocache(tb, pc);
+        cpu_tb_exec(cpu, tb);
+        cc->cpu_exec_exit(cpu);
+
+        tb_lock();
+        tb_phys_invalidate(tb, -1);
+        tb_free(tb);
+        tb_unlock();
+    } else {
+        /* We may have exited due to another problem here, so we need
+         * to reset any tb_locks we may have taken but didn't release.
+         * The mmap_lock is dropped by tb_gen_code if it runs out of
+         * memory.
+         */
+#ifndef CONFIG_SOFTMMU
+        tcg_debug_assert(!have_mmap_lock());
+#endif
+        tb_lock_reset();
+    }
 }
 
 void cpu_exec_step_atomic(CPUState *cpu)
diff --git a/cpus.c b/cpus.c
index bfee326d30..8200ac6b75 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1348,6 +1348,11 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
                 if (r == EXCP_DEBUG) {
                     cpu_handle_guest_debug(cpu);
                     break;
+                } else if (r == EXCP_ATOMIC) {
+                    qemu_mutex_unlock_iothread();
+                    cpu_exec_step_atomic(cpu);
+                    qemu_mutex_lock_iothread();
+                    break;
                 }
             } else if (cpu->stop) {
                 if (cpu->unplug) {
@@ -1458,6 +1463,10 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                  */
                 g_assert(cpu->halted);
                 break;
+            case EXCP_ATOMIC:
+                qemu_mutex_unlock_iothread();
+                cpu_exec_step_atomic(cpu);
+                qemu_mutex_lock_iothread();
             default:
                 /* Ignore everything else? */
                 break;
-- 
2.11.0
