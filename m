Received: from eggs.gnu.org ([2001:4830:134:3::10]:53706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdFSS-0005QB-7r
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdFSP-0002db-LB
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:10:16 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cdFSP-0002cv-FR
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:10:13 -0500
Received: by mail-wr0-x22c.google.com with SMTP id o16so149174400wra.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 04:10:13 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 13 Feb 2017 12:10:05 +0000
Message-Id: <20170213121017.12907-13-alex.bennee@linaro.org>
In-Reply-To: <20170213121017.12907-1-alex.bennee@linaro.org>
References: <20170213121017.12907-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v12 12/24] tcg: handle EXCP_ATOMIC exception
 for system emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net
Cc: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

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
[AJB: tweak title, merge with new patches]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
[PENDING, CHANGES] Reviewed-by: Richard Henderson <rth@twiddle.net>
CC: Richard Henderson <rth@twiddle.net>
CC: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c | 14 +++++++++++---
 cpus.c     |  9 +++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index b0ddada8c1..e61f5747c8 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -228,6 +228,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
 
 static void cpu_exec_step(CPUState *cpu)
 {
+    CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchState *env = (CPUArchState *)cpu->env_ptr;
     TranslationBlock *tb;
     target_ulong cs_base, pc;
@@ -239,9 +240,16 @@ static void cpu_exec_step(CPUState *cpu)
                      1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
     tb->orig_tb = NULL;
     tb_unlock();
-    /* execute the generated code */
-    trace_exec_tb_nocache(tb, pc);
-    cpu_tb_exec(cpu, tb);
+
+    cc->cpu_exec_enter(cpu);
+
+    if (sigsetjmp(cpu->jmp_env, 0) == 0) {
+        /* execute the generated code */
+        trace_exec_tb_nocache(tb, pc);
+        cpu_tb_exec(cpu, tb);
+    }
+
+    cc->cpu_exec_exit(cpu);
     tb_lock();
     tb_phys_invalidate(tb, -1);
     tb_free(tb);
diff --git a/cpus.c b/cpus.c
index 25897edbd3..cb44544fcf 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1347,6 +1347,11 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
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
@@ -1457,6 +1462,10 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
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
