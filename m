Received: from eggs.gnu.org ([2001:4830:134:3::10]:58998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDUv-0007xn-Qo
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDUt-0007C8-63
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:41 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDUt-0007BU-0I
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:39 -0500
Received: by mail-ot1-x343.google.com with SMTP id f18so3327754otl.11
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:36:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:06 -0600
Message-Id: <20181207103631.28193-2-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-1-richard.henderson@linaro.org>
References: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 01/26] target/arm: Add state for the
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
Cc: peter.maydell@linaro.org, ramana.radhakrishnan@arm.com

Add storage space for the 5 encryption keys.  Migrate them when
the extension is enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h     | 23 +++++++++++++++++++++++
 target/arm/machine.c | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c943f35dd9..0766e32a1b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -605,6 +605,14 @@ typedef struct CPUARMState {
         uint32_t cregs[16];
     } iwmmxt;
 
+#ifdef TARGET_AARCH64
+    uint64_t apia_key[2];
+    uint64_t apib_key[2];
+    uint64_t apda_key[2];
+    uint64_t apdb_key[2];
+    uint64_t apga_key[2];
+#endif
+
 #if defined(CONFIG_USER_ONLY)
     /* For usermode syscall translation.  */
     int eabi;
@@ -3324,6 +3332,21 @@ static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
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
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 7a22ebc209..340b36084c 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -169,6 +169,28 @@ static const VMStateDescription vmstate_sve = {
         VMSTATE_END_OF_LIST()
     }
 };
+
+static bool pauth_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    return cpu_isar_feature(aa64_pauth, cpu);
+}
+
+static const VMStateDescription vmstate_pauth = {
+    .name = "cpu/pauth",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pauth_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.apia_key, ARMCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.apib_key, ARMCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.apda_key, ARMCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.apdb_key, ARMCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.apga_key, ARMCPU, 2),
+        VMSTATE_END_OF_LIST()
+    }
+};
 #endif /* AARCH64 */
 
 static bool serror_needed(void *opaque)
@@ -795,6 +817,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_m_security,
 #ifdef TARGET_AARCH64
         &vmstate_sve,
+        &vmstate_pauth,
 #endif
         &vmstate_serror,
         &vmstate_irq_line_state,
-- 
2.17.2
