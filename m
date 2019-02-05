Received: from eggs.gnu.org ([209.51.188.92]:52959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gr5zc-0007p6-8i
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gr5zZ-0004Hc-Nd
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:47 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gr5zZ-00042q-F7
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:45 -0500
Received: by mail-wr1-x442.google.com with SMTP id q15so4818203wro.12
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 11:02:28 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  5 Feb 2019 19:02:19 +0000
Message-Id: <20190205190224.2198-2-alex.bennee@linaro.org>
In-Reply-To: <20190205190224.2198-1-alex.bennee@linaro.org>
References: <20190205190224.2198-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/6] target/arm: relax permission checks for
 HWCAP_CPUID registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Although technically not visible to userspace the kernel does make
them visible via a trap and emulate ABI. We provide a new permission
mask (PL0U_R) which maps to PL0_R for CONFIG_USER builds and adjust
the minimum permission check accordingly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.h    | 12 ++++++++++++
 target/arm/helper.c |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a68bcc9fed..1616632dcb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2211,6 +2211,18 @@ static inline bool cptype_valid(int cptype)
 #define PL0_R (0x02 | PL1_R)
 #define PL0_W (0x01 | PL1_W)
 
+/*
+ * For user-mode some registers are accessible to EL0 via a kernel
+ * trap-and-emulate ABI. In this case we define the read permissions
+ * as actually being PL0_R. However some bits of any given register
+ * may still be masked.
+ */
+#ifdef CONFIG_USER_ONLY
+#define PL0U_R PL0_R
+#else
+#define PL0U_R PL1_R
+#endif
+
 #define PL3_RW (PL3_R | PL3_W)
 #define PL2_RW (PL2_R | PL2_W)
 #define PL1_RW (PL1_R | PL1_W)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d070879894..5857c0ba96 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6851,7 +6851,11 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
     if (r->state != ARM_CP_STATE_AA32) {
         int mask = 0;
         switch (r->opc1) {
-        case 0: case 1: case 2:
+        case 0:
+            /* min_EL EL1, but some accessible to EL0 via kernel ABI */
+            mask = PL0U_R | PL1_RW;
+            break;
+        case 1: case 2:
             /* min_EL EL1 */
             mask = PL1_RW;
             break;
-- 
2.20.1
