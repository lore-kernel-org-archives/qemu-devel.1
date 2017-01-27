Received: from eggs.gnu.org ([2001:4830:134:3::10]:33270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qj-0004pu-7g
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qh-0003mm-Jf
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:57 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6qh-0003mZ-DB
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:55 -0500
Received: by mail-wm0-x244.google.com with SMTP id d140so58621656wmd.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:45:55 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:10 +0100
Message-Id: <1485524749-118532-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/41] replay: improve interrupt handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch improves interrupt handling in record/replay mode.
Now "interrupt" event is saved only when cc->cpu_exec_interrupt returns true.
This patch also adds missing return to cpu_exec_interrupt function.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20170124071708.4572.64023.stgit@PASHA-ISP>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c               | 2 +-
 target/i386/seg_helper.c | 1 +
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
-- 
1.8.3.1
