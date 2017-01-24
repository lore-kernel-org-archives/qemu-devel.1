Received: from eggs.gnu.org ([2001:4830:134:3::10]:35178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvLn-00060p-Hc
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvLm-0005kq-Pp
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:07 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38516)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvLm-0005km-Hx
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:06 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 24 Jan 2017 10:17:08 +0300
Message-ID: <20170124071708.4572.64023.stgit@PASHA-ISP>
In-Reply-To: <20170124071654.4572.41407.stgit@PASHA-ISP>
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 02/14] replay: improve interrupt handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, dovgaluk@ispras.ru, kraxel@redhat.com, pbonzini@redhat.com

This patch improves interrupt handling in record/replay mode.
Now "interrupt" event is saved only when cc->cpu_exec_interrupt returns true.
This patch also adds missing return to cpu_exec_interrupt function.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 cpu-exec.c               |    2 +-
 target/i386/seg_helper.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 4188fed..fa08c73 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -508,8 +508,8 @@ static inline void cpu_handle_interrupt(CPUState *cpu,
            True when it is, and we should restart on a new TB,
            and via longjmp via cpu_loop_exit.  */
         else {
-            replay_interrupt();
             if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
+                replay_interrupt();
                 *last_tb = NULL;
             }
             /* The target hook may have updated the 'cpu->interrupt_request';
diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index fb79f31..d24574d 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -1331,6 +1331,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 #endif
     if (interrupt_request & CPU_INTERRUPT_SIPI) {
         do_cpu_sipi(cpu);
+        ret = true;
     } else if (env->hflags2 & HF2_GIF_MASK) {
         if ((interrupt_request & CPU_INTERRUPT_SMI) &&
             !(env->hflags & HF_SMM_MASK)) {
