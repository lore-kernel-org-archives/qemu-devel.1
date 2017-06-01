Received: from eggs.gnu.org ([2001:4830:134:3::10]:35204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcY-00017D-EQ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcW-0006BC-Uw
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:50 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcW-0006AO-OC
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:48 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcV-0007S0-I1
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:47 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:25 +0100
Message-Id: <1496337035-30213-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/27] armv7m: Classify faults as MemManage or
 BusFault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Davidsaver <mdavidsaver@gmail.com>

General logic is that operations stopped by the MPU are MemManage,
and those which go through the MPU and are caught by the unassigned
handle are BusFault. Distinguish these by looking at the
exception.fsr values, and set the CFSR bits and (if appropriate)
fill in the BFAR or MMFAR with the exception address.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Message-id: 1493122030-32191-12-git-send-email-peter.maydell@linaro.org
[PMM: i-side faults do not set BFAR/MMFAR, only d-side;
 added some CPU_LOG_INT logging]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/arm/helper.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 180b490..c9d94c5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6342,10 +6342,49 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         break;
     case EXCP_PREFETCH_ABORT:
     case EXCP_DATA_ABORT:
-        /* TODO: if we implemented the MPU registers, this is where we
-         * should set the MMFAR, etc from exception.fsr and exception.vaddress.
+        /* Note that for M profile we don't have a guest facing FSR, but
+         * the env->exception.fsr will be populated by the code that
+         * raises the fault, in the A profile short-descriptor format.
          */
-        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM);
+        switch (env->exception.fsr & 0xf) {
+        case 0x8: /* External Abort */
+            switch (cs->exception_index) {
+            case EXCP_PREFETCH_ABORT:
+                env->v7m.cfsr |= R_V7M_CFSR_PRECISERR_MASK;
+                qemu_log_mask(CPU_LOG_INT, "...with CFSR.PRECISERR\n");
+                break;
+            case EXCP_DATA_ABORT:
+                env->v7m.cfsr |=
+                    (R_V7M_CFSR_IBUSERR_MASK | R_V7M_CFSR_BFARVALID_MASK);
+                env->v7m.bfar = env->exception.vaddress;
+                qemu_log_mask(CPU_LOG_INT,
+                              "...with CFSR.IBUSERR and BFAR 0x%x\n",
+                              env->v7m.bfar);
+                break;
+            }
+            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_BUS);
+            break;
+        default:
+            /* All other FSR values are either MPU faults or "can't happen
+             * for M profile" cases.
+             */
+            switch (cs->exception_index) {
+            case EXCP_PREFETCH_ABORT:
+                env->v7m.cfsr |= R_V7M_CFSR_IACCVIOL_MASK;
+                qemu_log_mask(CPU_LOG_INT, "...with CFSR.IACCVIOL\n");
+                break;
+            case EXCP_DATA_ABORT:
+                env->v7m.cfsr |=
+                    (R_V7M_CFSR_DACCVIOL_MASK | R_V7M_CFSR_MMARVALID_MASK);
+                env->v7m.mmfar = env->exception.vaddress;
+                qemu_log_mask(CPU_LOG_INT,
+                              "...with CFSR.DACCVIOL and MMFAR 0x%x\n",
+                              env->v7m.mmfar);
+                break;
+            }
+            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM);
+            break;
+        }
         break;
     case EXCP_BKPT:
         if (semihosting_enabled()) {
-- 
2.7.4
