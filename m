Received: from eggs.gnu.org ([209.51.188.92]:42834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbJ-0002d6-Gv
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbA-0007AM-Gb
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:24 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVb5-00076w-He
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:15 -0500
Received: by mail-wr1-x441.google.com with SMTP id p4so15416290wrt.7
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.12 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:21 +0000
Message-Id: <20190118145805.6852-6-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/49] target/arm: Add state for the
 ARMv8.3-PAuth extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Add storage space for the 5 encryption keys.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6f606eb97b1..8b891bbc308 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -201,11 +201,16 @@ typedef struct ARMVectorReg {
     uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
 } ARMVectorReg;
 
-/* In AArch32 mode, predicate registers do not exist at all.  */
 #ifdef TARGET_AARCH64
+/* In AArch32 mode, predicate registers do not exist at all.  */
 typedef struct ARMPredicateReg {
     uint64_t p[2 * ARM_MAX_VQ / 8] QEMU_ALIGNED(16);
 } ARMPredicateReg;
+
+/* In AArch32 mode, PAC keys do not exist at all.  */
+typedef struct ARMPACKey {
+    uint64_t lo, hi;
+} ARMPACKey;
 #endif
 
 
@@ -605,6 +610,14 @@ typedef struct CPUARMState {
         uint32_t cregs[16];
     } iwmmxt;
 
+#ifdef TARGET_AARCH64
+    ARMPACKey apia_key;
+    ARMPACKey apib_key;
+    ARMPACKey apda_key;
+    ARMPACKey apdb_key;
+    ARMPACKey apga_key;
+#endif
+
 #if defined(CONFIG_USER_ONLY)
     /* For usermode syscall translation.  */
     int eabi;
@@ -3264,6 +3277,21 @@ static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
 }
 
+static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
+{
+    /*
+     * Note that while QEMU will only implement the architected algorithm
+     * QARMA, and thus APA+GPA, the host cpu for kvm may use implementation
+     * defined algorithms, and thus API+GPI, and this predicate controls
+     * migration of the 128-bit keys.
+     */
+    return (id->id_aa64isar1 &
+            (FIELD_DP64(0, ID_AA64ISAR1, APA, -1) |
+             FIELD_DP64(0, ID_AA64ISAR1, API, -1) |
+             FIELD_DP64(0, ID_AA64ISAR1, GPA, -1) |
+             FIELD_DP64(0, ID_AA64ISAR1, GPI, -1))) != 0;
+}
+
 static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
-- 
2.20.1
