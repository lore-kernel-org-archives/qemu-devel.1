Received: from eggs.gnu.org ([2001:4830:134:3::10]:56894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDR-0007ui-E0
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDQ-0000iw-66
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f5sDP-0000er-VM
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDN-0007d4-5f
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 13:17:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 13:17:21 +0100
Message-Id: <20180410121724.8549-10-peter.maydell@linaro.org>
In-Reply-To: <20180410121724.8549-1-peter.maydell@linaro.org>
References: <20180410121724.8549-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/12] cpus.c: ensure running CPU recalculates
 icount deadlines on timer expiry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When we run in TCG icount mode, we calculate the number of instructions
to execute using tcg_get_icount_limit(), which ensures that we stop
execution at the next timer deadline. However there is a bug where
currently we do not recalculate that limit if the guest reprograms
a timer so that the next deadline moves closer, and so we will
continue execution until the original limit and fire the timer
later than we should.

Fix this bug in qemu_timer_notify_cb(): if we are currently running
a VCPU in icount mode, we simply need to kick it out of the main
loop and back to tcg_cpu_exec(), where it will recalculate the
icount limit. If we are not currently running a VCPU, then we
retain the existing logic for waking up a halted CPU.

Cc: qemu-stable@nongnu.org
Fixes: https://bugs.launchpad.net/qemu/+bug/1754038
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180406123838.21249-1-peter.maydell@linaro.org
---
 cpus.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 2e6701795b..38eba8bff3 100644
--- a/cpus.c
+++ b/cpus.c
@@ -892,11 +892,19 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
         return;
     }
 
-    if (!qemu_in_vcpu_thread() && first_cpu) {
+    if (qemu_in_vcpu_thread()) {
+        /* A CPU is currently running; kick it back out to the
+         * tcg_cpu_exec() loop so it will recalculate its
+         * icount deadline immediately.
+         */
+        qemu_cpu_kick(current_cpu);
+    } else if (first_cpu) {
         /* qemu_cpu_kick is not enough to kick a halted CPU out of
          * qemu_tcg_wait_io_event.  async_run_on_cpu, instead,
          * causes cpu_thread_is_idle to return false.  This way,
          * handle_icount_deadline can run.
+         * If we have no CPUs at all for some reason, we don't
+         * need to do anything.
          */
         async_run_on_cpu(first_cpu, do_nothing, RUN_ON_CPU_NULL);
     }
-- 
2.16.2
