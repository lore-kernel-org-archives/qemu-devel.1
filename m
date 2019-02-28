Received: from eggs.gnu.org ([209.51.188.92]:36336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYo-0001Eu-8l
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYn-0003cl-2G
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:06 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:46732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzJYm-0003Os-PY
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:04 -0500
Received: by mail-wr1-x431.google.com with SMTP id i16so21421168wrs.13
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:08:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c17sm13153241wrs.17.2019.02.28.03.08.54 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Feb 2019 03:08:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 11:08:23 +0000
Message-Id: <20190228110835.16159-5-peter.maydell@linaro.org>
In-Reply-To: <20190228110835.16159-1-peter.maydell@linaro.org>
References: <20190228110835.16159-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/16] target/arm/arm-powerctl: Add new
 arm_set_cpu_on_and_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently the Arm arm-powerctl.h APIs allow:
 * arm_set_cpu_on(), which powers on a CPU and sets its
   initial PC and other startup state
 * arm_reset_cpu(), which resets a CPU which is already on
   (and fails if the CPU is powered off)

but there is no way to say "power on a CPU as if it had
just come out of reset and don't do anything else to it".

Add a new function arm_set_cpu_on_and_reset(), which does this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190219125808.25174-5-peter.maydell@linaro.org
---
 target/arm/arm-powerctl.h | 16 +++++++++++
 target/arm/arm-powerctl.c | 56 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/target/arm/arm-powerctl.h b/target/arm/arm-powerctl.h
index 04353923c06..37c8a04f0a9 100644
--- a/target/arm/arm-powerctl.h
+++ b/target/arm/arm-powerctl.h
@@ -74,4 +74,20 @@ int arm_set_cpu_off(uint64_t cpuid);
  */
 int arm_reset_cpu(uint64_t cpuid);
 
+/*
+ * arm_set_cpu_on_and_reset:
+ * @cpuid: the id of the CPU we want to star
+ *
+ * Start the cpu designated by @cpuid and put it through its normal
+ * CPU reset process. The CPU will start in the way it is architected
+ * to start after a power-on reset.
+ *
+ * Returns: QEMU_ARM_POWERCTL_RET_SUCCESS on success.
+ * QEMU_ARM_POWERCTL_INVALID_PARAM if there is no CPU with that ID.
+ * QEMU_ARM_POWERCTL_ALREADY_ON if the CPU is already on.
+ * QEMU_ARM_POWERCTL_ON_PENDING if the CPU is already partway through
+ * powering on.
+ */
+int arm_set_cpu_on_and_reset(uint64_t cpuid);
+
 #endif
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index f9de5164e55..f77a950db67 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -228,6 +228,62 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
     return QEMU_ARM_POWERCTL_RET_SUCCESS;
 }
 
+static void arm_set_cpu_on_and_reset_async_work(CPUState *target_cpu_state,
+                                                run_on_cpu_data data)
+{
+    ARMCPU *target_cpu = ARM_CPU(target_cpu_state);
+
+    /* Initialize the cpu we are turning on */
+    cpu_reset(target_cpu_state);
+    target_cpu_state->halted = 0;
+
+    /* Finally set the power status */
+    assert(qemu_mutex_iothread_locked());
+    target_cpu->power_state = PSCI_ON;
+}
+
+int arm_set_cpu_on_and_reset(uint64_t cpuid)
+{
+    CPUState *target_cpu_state;
+    ARMCPU *target_cpu;
+
+    assert(qemu_mutex_iothread_locked());
+
+    /* Retrieve the cpu we are powering up */
+    target_cpu_state = arm_get_cpu_by_id(cpuid);
+    if (!target_cpu_state) {
+        /* The cpu was not found */
+        return QEMU_ARM_POWERCTL_INVALID_PARAM;
+    }
+
+    target_cpu = ARM_CPU(target_cpu_state);
+    if (target_cpu->power_state == PSCI_ON) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "[ARM]%s: CPU %" PRId64 " is already on\n",
+                      __func__, cpuid);
+        return QEMU_ARM_POWERCTL_ALREADY_ON;
+    }
+
+    /*
+     * If another CPU has powered the target on we are in the state
+     * ON_PENDING and additional attempts to power on the CPU should
+     * fail (see 6.6 Implementation CPU_ON/CPU_OFF races in the PSCI
+     * spec)
+     */
+    if (target_cpu->power_state == PSCI_ON_PENDING) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "[ARM]%s: CPU %" PRId64 " is already powering on\n",
+                      __func__, cpuid);
+        return QEMU_ARM_POWERCTL_ON_PENDING;
+    }
+
+    async_run_on_cpu(target_cpu_state, arm_set_cpu_on_and_reset_async_work,
+                     RUN_ON_CPU_NULL);
+
+    /* We are good to go */
+    return QEMU_ARM_POWERCTL_RET_SUCCESS;
+}
+
 static void arm_set_cpu_off_async_work(CPUState *target_cpu_state,
                                        run_on_cpu_data data)
 {
-- 
2.20.1
