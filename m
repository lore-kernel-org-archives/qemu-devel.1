Received: from eggs.gnu.org ([2001:4830:134:3::10]:59541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cc0H8-0004Mm-4H
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 20:45:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cc0H5-0006ip-2R
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 20:45:26 -0500
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:35543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cc0H4-0006iB-TA
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 20:45:22 -0500
Received: by mail-yb0-x241.google.com with SMTP id j82so853275ybg.2
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 17:45:21 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu,  9 Feb 2017 20:45:19 -0500
Message-Id: <20170210014519.12413-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tcg: handle EXCP_ATOMIC exception properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The current method of executing atomic code in a guest uses
cpu_exec_step_atomic() from the outermost loop. This causes an abort()
when single stepping over atomic code since debug exception longjmp
will point to the the setlongjmp in cpu_exec(). Another issue with
this mechanism is that the flags which were set in atomic execution
will be lost since we do not call cpu_exec_enter().

The following patch moves atomic exception handling to the exception
handler where all these issues are taken care of. The change in
start_exclusive() is necessary since now the cpu in atomic execution
will have its running flag set, but we do not want to count it as
pending.

Thanks to Alex for helping me debug the issue.

CC: Alex Bennée <alex.bennee@linaro.org>
CC: Richard Henderson <rth@twiddle.net>
CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 cpu-exec.c    | 2 ++
 cpus-common.c | 2 +-
 cpus.c        | 4 ----
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index b0ddada8c1..dceacfc5dd 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -427,6 +427,8 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
             *ret = cpu->exception_index;
             if (*ret == EXCP_DEBUG) {
                 cpu_handle_debug_exception(cpu);
+            } else if (*ret == EXCP_ATOMIC) {
+                cpu_exec_step_atomic(cpu);
             }
             cpu->exception_index = -1;
             return true;
diff --git a/cpus-common.c b/cpus-common.c
index 59f751ecf9..7b859752ea 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -192,7 +192,7 @@ void start_exclusive(void)
     smp_mb();
     running_cpus = 0;
     CPU_FOREACH(other_cpu) {
-        if (atomic_read(&other_cpu->running)) {
+        if (atomic_read(&other_cpu->running) && !qemu_cpu_is_self(other_cpu)) {
             other_cpu->has_waiter = true;
             running_cpus++;
             qemu_cpu_kick(other_cpu);
diff --git a/cpus.c b/cpus.c
index e1b82bcd49..981f23d52b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1461,10 +1461,6 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                  */
                 g_assert(cpu->halted);
                 break;
-            case EXCP_ATOMIC:
-                qemu_mutex_unlock_iothread();
-                cpu_exec_step_atomic(cpu);
-                qemu_mutex_lock_iothread();
             default:
                 /* Ignore everything else? */
                 break;
-- 
2.11.0
