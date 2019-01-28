Received: from eggs.gnu.org ([209.51.188.92]:60152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1goAst-00024b-QO
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1goAss-0003Wm-5z
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:39:47 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1goAsr-0003Ty-HL
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:39:45 -0500
Received: by mail-wm1-x342.google.com with SMTP id m1so14933824wml.2
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:39:43 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 28 Jan 2019 17:39:37 +0000
Message-Id: <20190128173940.25813-2-alex.bennee@linaro.org>
In-Reply-To: <20190128173940.25813-1-alex.bennee@linaro.org>
References: <20190128173940.25813-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/4] target/arm: relax permission checks for
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
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

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
index ff81db420d..3b3c359cca 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2202,6 +2202,18 @@ static inline bool cptype_valid(int cptype)
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
index 92666e5208..42c1c0b144 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6731,7 +6731,11 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
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
2.17.1
