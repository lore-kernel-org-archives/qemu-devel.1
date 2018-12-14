Received: from eggs.gnu.org ([2001:4830:134:3::10]:55611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxW-0004On-Bx
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxR-0005Jj-GQ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:21 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxP-0005Iy-K2
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:15 -0500
Received: by mail-oi1-x242.google.com with SMTP id x202so3606881oif.13
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:23:44 -0600
Message-Id: <20181214052410.11863-2-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-1-richard.henderson@linaro.org>
References: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 01/27] target/arm: Add state for the
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
Cc: peter.maydell@linaro.org

Add storage space for the 5 encryption keys.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
----
v2: Remove pointless double migration.
    Use a struct to make it clear which half is which.
---
 target/arm/cpu.h | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c943f35dd9..39d4afdfe6 100644
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
@@ -3324,6 +3337,21 @@ static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
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
2.17.2
