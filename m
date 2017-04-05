Received: from eggs.gnu.org ([2001:4830:134:3::10]:54634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvkvz-0004ha-7c
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvkvw-0000Kx-QW
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:15 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cvkvw-0000KU-Ks
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:12 -0400
Received: by mail-wr0-x22a.google.com with SMTP id t20so14817886wra.1
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 06:25:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  5 Apr 2017 14:25:01 +0100
Message-Id: <20170405132503.32125-11-alex.bennee@linaro.org>
In-Reply-To: <20170405132503.32125-1-alex.bennee@linaro.org>
References: <20170405132503.32125-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 10/12] cpu-exec: update icount after each
 TB_EXIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dovgaluk@ispras.ru, rth@twiddle.net, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

There is no particular reason we shouldn't update the global system
icount time as we exit each TranslationBlock run. This ensures the
main-loop doesn't have to wait until we exit to the outer loop for
executed instructions to be credited to timer_state.

The prepare_icount_for_run function is slightly tweaked to match the
logic we run in cpu_loop_exec_tb.

Based on Paolo's original suggestion.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpu-exec.c | 14 +++++++-------
 cpus.c     | 18 +++++-------------
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 748cb66bca..63a56d0407 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -600,13 +600,13 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     /* Instruction counter expired.  */
     assert(use_icount);
 #ifndef CONFIG_USER_ONLY
-    if (cpu->icount_extra) {
-        /* Refill decrementer and continue execution.  */
-        cpu->icount_extra += insns_left;
-        insns_left = MIN(0xffff, cpu->icount_extra);
-        cpu->icount_extra -= insns_left;
-        cpu->icount_decr.u16.low = insns_left;
-    } else {
+    /* Ensure global icount has gone forward */
+    cpu_update_icount(cpu);
+    /* Refill decrementer and continue execution.  */
+    insns_left = MIN(0xffff, cpu->icount_budget);
+    cpu->icount_decr.u16.low = insns_left;
+    cpu->icount_extra = cpu->icount_budget - insns_left;
+    if (!cpu->icount_extra) {
         /* Execute any remaining instructions, then let the main loop
          * handle the next event.
          */
diff --git a/cpus.c b/cpus.c
index 71c3baba87..ff75af449a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1204,8 +1204,7 @@ static void handle_icount_deadline(void)
 static void prepare_icount_for_run(CPUState *cpu)
 {
     if (use_icount) {
-        int64_t count;
-        int decr;
+        int insns_left;
 
         /* These should always be cleared by process_icount_data after
          * each vCPU execution. However u16.high can be raised
@@ -1214,17 +1213,10 @@ static void prepare_icount_for_run(CPUState *cpu)
         g_assert(cpu->icount_decr.u16.low == 0);
         g_assert(cpu->icount_extra == 0);
 
-
-        count = tcg_get_icount_limit();
-
-        /* To calculate what we have executed so far we need to know
-         * what we originally budgeted to run this cycle */
-        cpu->icount_budget = count;
-
-        decr = (count > 0xffff) ? 0xffff : count;
-        count -= decr;
-        cpu->icount_decr.u16.low = decr;
-        cpu->icount_extra = count;
+        cpu->icount_budget = tcg_get_icount_limit();
+        insns_left = MIN(0xffff, cpu->icount_budget);
+        cpu->icount_decr.u16.low = insns_left;
+        cpu->icount_extra = cpu->icount_budget - insns_left;
     }
 }
 
-- 
2.11.0
