Received: from eggs.gnu.org ([2001:4830:134:3::10]:46365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5ih-0002Jl-EP
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5if-0000F9-GN
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:07 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:20 -0500
Message-Id: <20180619014319.28272-55-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 054/113] cpus.c: ensure running CPU
 recalculates icount deadlines on timer expiry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

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
(cherry picked from commit c52e7132d7c885841500f5277f7305f62767fe1d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 cpus.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 114c29b6a0..96bb688d7b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -843,11 +843,19 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
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
2.11.0
