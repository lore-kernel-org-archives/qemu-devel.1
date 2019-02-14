Received: from eggs.gnu.org ([209.51.188.92]:53818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKs-0007ix-SH
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKs-0004fT-1L
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:14 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMKr-0004f3-Qr
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:13 -0500
Received: by mail-wr1-x441.google.com with SMTP id f14so7751399wrg.1
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.11 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:42 +0000
Message-Id: <20190214190603.25030-7-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/27] target/arm: relax permission checks for
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

From: Alex Bennée <alex.bennee@linaro.org>

Although technically not visible to userspace the kernel does make
them visible via a trap and emulate ABI. We provide a new permission
mask (PL0U_R) which maps to PL0_R for CONFIG_USER builds and adjust
the minimum permission check accordingly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190205190224.2198-2-alex.bennee@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 12 ++++++++++++
 target/arm/helper.c |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 47238e42458..c92c097b449 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2226,6 +2226,18 @@ static inline bool cptype_valid(int cptype)
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
index e1ef2f35237..88cf4976039 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6857,7 +6857,11 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
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
