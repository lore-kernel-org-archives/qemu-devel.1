Received: from eggs.gnu.org ([2001:4830:134:3::10]:53541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqv-0002X3-UE
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqs-00039T-0t
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:30 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxYqr-00038l-PP
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:25 -0400
Received: by mail-wr0-x22c.google.com with SMTP id c55so74645747wrc.3
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 05:55:25 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Apr 2017 13:55:20 +0100
Message-Id: <20170410125524.21008-8-alex.bennee@linaro.org>
In-Reply-To: <20170410125524.21008-1-alex.bennee@linaro.org>
References: <20170410125524.21008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/11] cpus: don't credit executed instructions
 before they have run
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Outside of the vCPU thread icount time will only be tracked against
timers_state.qemu_icount. We no longer credit cycles until they have
completed the run. Inside the vCPU thread we adjust for passage of
time by looking at how many have run so far. This is only valid inside
the vCPU thread while it is running.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/cpus.c b/cpus.c
index 6034b104c3..0ecb0b87f0 100644
--- a/cpus.c
+++ b/cpus.c
@@ -223,6 +223,15 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
     }
 }
 
+/* The current number of executed instructions is based on what we
+ * originally budgeted minus the current state of the decrementing
+ * icount counters in extra/u16.low.
+ */
+static int64_t cpu_get_icount_executed(CPUState *cpu)
+{
+    return cpu->icount_budget - (cpu->icount_decr.u16.low + cpu->icount_extra);
+}
+
 int64_t cpu_get_icount_raw(void)
 {
     int64_t icount;
@@ -234,7 +243,8 @@ int64_t cpu_get_icount_raw(void)
             fprintf(stderr, "Bad icount read\n");
             exit(1);
         }
-        icount -= (cpu->icount_decr.u16.low + cpu->icount_extra);
+        /* Take into account what has run */
+        icount += cpu_get_icount_executed(cpu);
     }
     return icount;
 }
@@ -1195,7 +1205,10 @@ static void prepare_icount_for_run(CPUState *cpu)
 
         count = tcg_get_icount_limit();
 
-        timers_state.qemu_icount += count;
+        /* To calculate what we have executed so far we need to know
+         * what we originally budgeted to run this cycle */
+        cpu->icount_budget = count;
+
         decr = (count > 0xffff) ? 0xffff : count;
         count -= decr;
         cpu->icount_decr.u16.low = decr;
@@ -1206,14 +1219,14 @@ static void prepare_icount_for_run(CPUState *cpu)
 static void process_icount_data(CPUState *cpu)
 {
     if (use_icount) {
-        /* Fold pending instructions back into the
-           instruction counter, and clear the interrupt flag.  */
-        timers_state.qemu_icount -= (cpu->icount_decr.u16.low
-                        + cpu->icount_extra);
+        /* Account for executed instructions */
+        timers_state.qemu_icount += cpu_get_icount_executed(cpu);
 
         /* Reset the counters */
         cpu->icount_decr.u16.low = 0;
         cpu->icount_extra = 0;
+        cpu->icount_budget = 0;
+
         replay_account_executed_instructions();
     }
 }
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index c3292efe1c..5d10359c8f 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -332,6 +332,7 @@ struct CPUState {
     /* updates protected by BQL */
     uint32_t interrupt_request;
     int singlestep_enabled;
+    int64_t icount_budget;
     int64_t icount_extra;
     sigjmp_buf jmp_env;
 
-- 
2.11.0
