Received: from eggs.gnu.org ([2001:4830:134:3::10]:54633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvkvz-0004hZ-7O
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvkvw-0000Kb-3D
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:15 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cvkvv-0000K4-Tp
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:12 -0400
Received: by mail-wr0-x22d.google.com with SMTP id k6so14523718wre.2
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 06:25:11 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  5 Apr 2017 14:25:00 +0100
Message-Id: <20170405132503.32125-10-alex.bennee@linaro.org>
In-Reply-To: <20170405132503.32125-1-alex.bennee@linaro.org>
References: <20170405132503.32125-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 09/12] cpus: introduce cpu_update_icount
 helper
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

By holding off updates to timer_state.qemu_icount we can run into
trouble when the non-vCPU thread needs to know the time. This helper
ensures we atomically update timers_state.qemu_icount based on what
has been currently executed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpus.c               | 16 ++++++++++++++--
 include/qemu/timer.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index 88eabdc19f..71c3baba87 100644
--- a/cpus.c
+++ b/cpus.c
@@ -232,12 +232,24 @@ static int64_t cpu_get_icount_executed(CPUState *cpu)
     return cpu->icount_budget - (cpu->icount_decr.u16.low + cpu->icount_extra);
 }
 
+/*
+ * Update the global shared timer_state.qemu_icount to take into
+ * account executed instructions. This is done by the TCG vCPU
+ * thread so the main-loop can see time has moved forward.
+ */
+void cpu_update_icount(CPUState *cpu)
+{
+    int64_t executed = cpu_get_icount_executed(cpu);
+    cpu->icount_budget -= executed;
+    atomic_add(&timers_state.qemu_icount, executed);
+}
+
 int64_t cpu_get_icount_raw(void)
 {
     int64_t icount;
     CPUState *cpu = current_cpu;
 
-    icount = timers_state.qemu_icount;
+    icount = atomic_read(&timers_state.qemu_icount);
     if (cpu && cpu->running) {
         if (!cpu->can_do_io) {
             fprintf(stderr, "Bad icount read\n");
@@ -1220,7 +1232,7 @@ static void process_icount_data(CPUState *cpu)
 {
     if (use_icount) {
         /* Account for executed instructions */
-        timers_state.qemu_icount += cpu_get_icount_executed(cpu);
+        cpu_update_icount(cpu);
 
         /* Reset the counters */
         cpu->icount_decr.u16.low = 0;
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index e1742f2f3d..8a1eb74839 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -869,6 +869,7 @@ int64_t cpu_get_icount_raw(void);
 int64_t cpu_get_icount(void);
 int64_t cpu_get_clock(void);
 int64_t cpu_icount_to_ns(int64_t icount);
+void    cpu_update_icount(CPUState *cpu);
 
 /*******************************************/
 /* host CPU ticks (if available) */
-- 
2.11.0
