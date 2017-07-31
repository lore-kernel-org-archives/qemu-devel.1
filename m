Received: from eggs.gnu.org ([2001:4830:134:3::10]:56004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9ir-0001dV-Rl
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9iq-0003hW-UJ
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:22:57 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dc9iq-0003ax-MY
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:22:56 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9ii-0000tz-QN
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:22:48 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2017 13:22:44 +0100
Message-Id: <1501503765-15639-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
References: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 6/7] target/arm: Migrate MPU_RNR register state
 for M profile cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The PMSAv7 region number register is migrated for R profile
cores using the cpreg scheme, but M profile doesn't use
cpregs, and so we weren't migrating the MPU_RNR register state
at all. Fix that by adding a migration subsection for the
M profile case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1501153150-19984-6-git-send-email-peter.maydell@linaro.org
---
 target/arm/machine.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 93c1a78..1f66da4 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -171,6 +171,29 @@ static const VMStateDescription vmstate_pmsav7 = {
     }
 };
 
+static bool pmsav7_rnr_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+
+    /* For R profile cores pmsav7.rnr is migrated via the cpreg
+     * "RGNR" definition in helper.h. For M profile we have to
+     * migrate it separately.
+     */
+    return arm_feature(env, ARM_FEATURE_M);
+}
+
+static const VMStateDescription vmstate_pmsav7_rnr = {
+    .name = "cpu/pmsav7-rnr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pmsav7_rnr_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.pmsav7.rnr, ARMCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
                     VMStateField *field)
 {
@@ -377,6 +400,11 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_iwmmxt,
         &vmstate_m,
         &vmstate_thumb2ee,
+        /* pmsav7_rnr must come before pmsav7 so that we have the
+         * region number before we test it in the VMSTATE_VALIDATE
+         * in vmstate_pmsav7.
+         */
+        &vmstate_pmsav7_rnr,
         &vmstate_pmsav7,
         NULL
     }
-- 
2.7.4
