Received: from eggs.gnu.org ([2001:4830:134:3::10]:52756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXTuZ-0004od-9e
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXTuW-00051b-RP
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:15 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fXTuW-00050l-LH
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:12 -0400
Received: by mail-wr0-x242.google.com with SMTP id l14-v6so9164250wrq.13
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:00:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 25 Jun 2018 17:00:06 +0100
Message-Id: <20180625160009.17437-3-alex.bennee@linaro.org>
In-Reply-To: <20180625160009.17437-1-alex.bennee@linaro.org>
References: <20180625160009.17437-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/5] target/arm: relax permission checks for
 HWCAP_CPUID registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Although technically not visible to userspace the kernel does make
them visible via trap and emulate. For user mode we can provide the
value directly but we need to relax our permission checks to do this.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6e6b1762e8..9d81feb124 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5813,7 +5813,19 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
     if (r->state != ARM_CP_STATE_AA32) {
         int mask = 0;
         switch (r->opc1) {
-        case 0: case 1: case 2:
+        case 0:
+#ifdef CONFIG_USER_ONLY
+            /* Some AArch64 CPU ID/feature are exported to userspace
+             * by the kernel (see HWCAP_CPUID) */
+            if (r->opc0 == 3 && r->crn == 0 &&
+                (r->crm == 0 ||
+                 (r->crm >= 4 && r->crm <= 7))) {
+                mask = PL0_R;
+                break;
+            }
+#endif
+            /* fall-through */
+        case 1: case 2:
             /* min_EL EL1 */
             mask = PL1_RW;
             break;
-- 
2.17.1
