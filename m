Received: from eggs.gnu.org ([2001:4830:134:3::10]:56347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJD1-00084O-W4
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCz-0002Cj-5V
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:51 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52509)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJCy-0001t1-Tj
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:49 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:04:49 -0500
Message-Id: <20181213050453.9677-70-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 69/73] cpu: rename all_cpu_threads_idle to
 qemu_tcg_rr_all_cpu_threads_idle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This function is only called from TCG rr mode, so add
a prefix to mark this as well as an assertion.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/cpus.c b/cpus.c
index fa66d84bc7..b89d3790d7 100644
--- a/cpus.c
+++ b/cpus.c
@@ -211,10 +211,12 @@ static bool cpu_thread_is_idle(CPUState *cpu)
     return true;
 }
 
-static bool all_cpu_threads_idle(void)
+static bool qemu_tcg_rr_all_cpu_threads_idle(void)
 {
     CPUState *cpu;
 
+    g_assert(qemu_is_tcg_rr());
+
     CPU_FOREACH(cpu) {
         if (!cpu_thread_is_idle(cpu)) {
             return false;
@@ -692,7 +694,7 @@ void qemu_start_warp_timer(void)
     }
 
     if (replay_mode != REPLAY_MODE_PLAY) {
-        if (!all_cpu_threads_idle()) {
+        if (!qemu_tcg_rr_all_cpu_threads_idle()) {
             return;
         }
 
@@ -1325,7 +1327,7 @@ static void qemu_tcg_rr_wait_io_event(void)
 {
     CPUState *cpu;
 
-    while (all_cpu_threads_idle()) {
+    while (qemu_tcg_rr_all_cpu_threads_idle()) {
         stop_tcg_kick_timer();
         qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
     }
@@ -1659,7 +1661,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             atomic_mb_set(&cpu->exit_request, 0);
         }
 
-        if (use_icount && all_cpu_threads_idle()) {
+        if (use_icount && qemu_tcg_rr_all_cpu_threads_idle()) {
             /*
              * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
              * in the main_loop, wake it up in order to start the warp timer.
-- 
2.17.1
