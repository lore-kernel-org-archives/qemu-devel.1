Received: from eggs.gnu.org ([2001:4830:134:3::10]:59635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVgaL-0004Th-2X
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVgaH-0005WK-UH
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:03:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVgaH-0005Vx-Jg
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:03:21 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DG2m5N139635
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 12:03:20 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpb5jtj63-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 12:03:18 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 13 Jul 2017 17:03:14 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Jul 2017 18:03:03 +0200
In-Reply-To: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
References: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499961789-127874-2-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 1/7] s390x/cpumodel: wire up new hardware
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

Some new guest features have been introduced recently. Lets wire
them up in the CPU model.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[split patch]
---
 include/hw/s390x/sclp.h         |  3 +--
 target/s390x/cpu_features.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 target/s390x/cpu_features.h     |  4 ++++
 target/s390x/cpu_features_def.h | 41 ++++++++++++++++++++++++++++++++++++++++-
 target/s390x/cpu_models.c       | 25 +++++++++++++++++++++++++
 target/s390x/gen-features.c     | 39 +++++++++++++++++++++++++++++++++++++++
 target/s390x/kvm.c              | 10 ++++++++++
 7 files changed, 160 insertions(+), 3 deletions(-)

diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index 3008a51..e71d526 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -123,8 +123,7 @@ typedef struct ReadInfo {
     uint64_t facilities;                /* 48-55 */
     uint8_t  _reserved0[76 - 56];       /* 56-75 */
     uint32_t ibc_val;
-    uint8_t  conf_char[96 - 80];        /* 80-95 */
-    uint8_t  _reserved4[99 - 96];       /* 96-98 */
+    uint8_t  conf_char[99 - 80];        /* 80-98 */
     uint8_t mha_pow;
     uint32_t rnsize2;
     uint64_t rnmax2;
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 8ab5cd7..e5a3f71 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -59,6 +59,7 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("exrl", S390_FEAT_TYPE_STFL, 35, "Execute-extensions facility"),
     FEAT_INIT("emon", S390_FEAT_TYPE_STFL, 36, "Enhanced-monitor facility"),
     FEAT_INIT("fpe", S390_FEAT_TYPE_STFL, 37, "Floating-point extension facility"),
+    FEAT_INIT("opc", S390_FEAT_TYPE_STFL, 38, "Order Preserving Compression facility"),
     FEAT_INIT("sprogp", S390_FEAT_TYPE_STFL, 40, "Set-program-parameters facility"),
     FEAT_INIT("fpseh", S390_FEAT_TYPE_STFL, 41, "Floating-point-support-enhancement facilities"),
     FEAT_INIT("dfp", S390_FEAT_TYPE_STFL, 42, "DFP (decimal-floating-point) facility"),
@@ -72,7 +73,11 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("ltlbc", S390_FEAT_TYPE_STFL, 51, "Local-TLB-clearing facility"),
     FEAT_INIT("iacc2", S390_FEAT_TYPE_STFL, 52, "Interlocked-access facility 2"),
     FEAT_INIT("stfle53", S390_FEAT_TYPE_STFL, 53, "Various facilities introduced with z13"),
+    FEAT_INIT("eec", S390_FEAT_TYPE_STFL, 54, "Entropy encoding compression facility"),
     FEAT_INIT("msa5-base", S390_FEAT_TYPE_STFL, 57, "Message-security-assist-extension-5 facility (excluding subfunctions)"),
+    FEAT_INIT("minste2", S390_FEAT_TYPE_STFL, 58, "Miscellaneous-instruction-extensions facility 2"),
+    FEAT_INIT("sema", S390_FEAT_TYPE_STFL, 59, "Semaphore-assist facility"),
+    FEAT_INIT("tsi", S390_FEAT_TYPE_STFL, 60, "Time-slice Instrumentation facility"),
     FEAT_INIT("ri", S390_FEAT_TYPE_STFL, 64, "CPU runtime-instrumentation facility"),
     FEAT_INIT("zpci", S390_FEAT_TYPE_STFL, 69, "z/PCI facility"),
     FEAT_INIT("aen", S390_FEAT_TYPE_STFL, 71, "General-purpose-adapter-event-notification facility"),
@@ -85,10 +90,22 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("edat2", S390_FEAT_TYPE_STFL, 78, "Enhanced-DAT facility 2"),
     FEAT_INIT("dfppc", S390_FEAT_TYPE_STFL, 80, "Decimal-floating-point packed-conversion facility"),
     FEAT_INIT("vx", S390_FEAT_TYPE_STFL, 129, "Vector facility"),
+    FEAT_INIT("iep", S390_FEAT_TYPE_STFL, 130, "Instruction-execution-protection facility"),
+    FEAT_INIT("sea_esop2", S390_FEAT_TYPE_STFL, 131, "Side-effect-access facility and Enhanced-suppression-on-protection facility 2"),
+    FEAT_INIT("gs", S390_FEAT_TYPE_STFL, 133, "Guarded-storage facility"),
+    FEAT_INIT("vxpd", S390_FEAT_TYPE_STFL, 134, "Vector packed decimal facility"),
+    FEAT_INIT("vxeh", S390_FEAT_TYPE_STFL, 135, "Vector enhancements facility"),
+    FEAT_INIT("mepoch", S390_FEAT_TYPE_STFL, 139, "Multiple-epoch facility"),
+    FEAT_INIT("tpei", S390_FEAT_TYPE_STFL, 144, "Test-pending-external-interruption facility"),
+    FEAT_INIT("irbm", S390_FEAT_TYPE_STFL, 145, "Insert-reference-bits-multiple facility"),
+    FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security-assist-extension-8 facility (excluding subfunctions)"),
+    FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
 
     /* SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
     FEAT_INIT("gsls", S390_FEAT_TYPE_SCLP_CONF_CHAR, 40, "SIE: Guest-storage-limit-suppression facility"),
     FEAT_INIT("esop", S390_FEAT_TYPE_SCLP_CONF_CHAR, 46, "Enhanced-suppression-on-protection facility"),
+    FEAT_INIT("hpma2", S390_FEAT_TYPE_SCLP_CONF_CHAR, 90, "Host page management assist 2 Facility"), /* 91-2 */
+    FEAT_INIT("kss", S390_FEAT_TYPE_SCLP_CONF_CHAR, 151, "SIE: Keyless-subset facility"),  /* 98-7 */
 
     /* SCLP SCCB Byte 116 - 119 (bit numbers relative to byte-116) */
     FEAT_INIT("64bscao", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 0, "SIE: 64-bit-SCAO facility"),
@@ -187,11 +204,23 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("kimd-sha-1", S390_FEAT_TYPE_KIMD, 1, "KIMD SHA-1"),
     FEAT_INIT("kimd-sha-256", S390_FEAT_TYPE_KIMD, 2, "KIMD SHA-256"),
     FEAT_INIT("kimd-sha-512", S390_FEAT_TYPE_KIMD, 3, "KIMD SHA-512"),
+    FEAT_INIT("kimd-sha3-224", S390_FEAT_TYPE_KIMD, 32, "KIMD SHA3-224"),
+    FEAT_INIT("kimd-sha3-256", S390_FEAT_TYPE_KIMD, 33, "KIMD SHA3-256"),
+    FEAT_INIT("kimd-sha3-384", S390_FEAT_TYPE_KIMD, 34, "KIMD SHA3-384"),
+    FEAT_INIT("kimd-sha3-512", S390_FEAT_TYPE_KIMD, 35, "KIMD SHA3-512"),
+    FEAT_INIT("kimd-shake-128", S390_FEAT_TYPE_KIMD, 36, "KIMD SHAKE-128"),
+    FEAT_INIT("kimd-shake-256", S390_FEAT_TYPE_KIMD, 37, "KIMD SHAKE-256"),
     FEAT_INIT("kimd-ghash", S390_FEAT_TYPE_KIMD, 65, "KIMD GHASH"),
 
     FEAT_INIT("klmd-sha-1", S390_FEAT_TYPE_KLMD, 1, "KLMD SHA-1"),
     FEAT_INIT("klmd-sha-256", S390_FEAT_TYPE_KLMD, 2, "KLMD SHA-256"),
     FEAT_INIT("klmd-sha-512", S390_FEAT_TYPE_KLMD, 3, "KLMD SHA-512"),
+    FEAT_INIT("klmd-sha3-224", S390_FEAT_TYPE_KLMD, 32, "KLMD SHA3-224"),
+    FEAT_INIT("klmd-sha3-256", S390_FEAT_TYPE_KLMD, 33, "KLMD SHA3-256"),
+    FEAT_INIT("klmd-sha3-384", S390_FEAT_TYPE_KLMD, 34, "KLMD SHA3-384"),
+    FEAT_INIT("klmd-sha3-512", S390_FEAT_TYPE_KLMD, 35, "KLMD SHA3-512"),
+    FEAT_INIT("klmd-shake-128", S390_FEAT_TYPE_KLMD, 36, "KLMD SHAKE-128"),
+    FEAT_INIT("klmd-shake-256", S390_FEAT_TYPE_KLMD, 37, "KLMD SHAKE-256"),
 
     FEAT_INIT("pckmo-edea", S390_FEAT_TYPE_PCKMO, 1, "PCKMO Encrypted-DEA-Key"),
     FEAT_INIT("pckmo-etdea-128", S390_FEAT_TYPE_PCKMO, 2, "PCKMO Encrypted-TDEA-128-Key"),
@@ -257,6 +286,15 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("pcc-xts-eaes-256", S390_FEAT_TYPE_PCC, 60, "PCC Compute-XTS-Parameter-Using-Encrypted-AES-256"),
 
     FEAT_INIT("ppno-sha-512-drng", S390_FEAT_TYPE_PPNO, 3, "PPNO SHA-512-DRNG"),
+    FEAT_INIT("prno-trng-qrtcr", S390_FEAT_TYPE_PPNO, 112, "PRNO TRNG-Query-Raw-to-Conditioned-Ratio"),
+    FEAT_INIT("prno-trng", S390_FEAT_TYPE_PPNO, 114, "PRNO TRNG"),
+
+    FEAT_INIT("kma-gcm-aes-128", S390_FEAT_TYPE_KMA, 18, "KMA GCM-AES-128"),
+    FEAT_INIT("kma-gcm-aes-192", S390_FEAT_TYPE_KMA, 19, "KMA GCM-AES-192"),
+    FEAT_INIT("kma-gcm-aes-256", S390_FEAT_TYPE_KMA, 20, "KMA GCM-AES-256"),
+    FEAT_INIT("kma-gcm-eaes-128", S390_FEAT_TYPE_KMA, 26, "KMA GCM-Encrypted-AES-128"),
+    FEAT_INIT("kma-gcm-eaes-192", S390_FEAT_TYPE_KMA, 27, "KMA GCM-Encrypted-AES-192"),
+    FEAT_INIT("kma-gcm-eaes-256", S390_FEAT_TYPE_KMA, 28, "KMA GCM-Encrypted-AES-256"),
 };
 
 const S390FeatDef *s390_feat_def(S390Feat feat)
@@ -389,6 +427,9 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("msa3", MSA_EXT_3, "Message-security-assist-extension 3 facility"),
     FEAT_GROUP_INIT("msa4", MSA_EXT_4, "Message-security-assist-extension 4 facility"),
     FEAT_GROUP_INIT("msa5", MSA_EXT_5, "Message-security-assist-extension 5 facility"),
+    FEAT_GROUP_INIT("msa6", MSA_EXT_6, "Message-security-assist-extension 6 facility"),
+    FEAT_GROUP_INIT("msa7", MSA_EXT_7, "Message-security-assist-extension 7 facility"),
+    FEAT_GROUP_INIT("msa8", MSA_EXT_8, "Message-security-assist-extension 8 facility"),
 };
 
 const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group)
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index d669121..14bc311 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -37,6 +37,7 @@ typedef enum {
     S390_FEAT_TYPE_KMO,
     S390_FEAT_TYPE_PCC,
     S390_FEAT_TYPE_PPNO,
+    S390_FEAT_TYPE_KMA,
 } S390FeatType;
 
 /* Definition of a CPU feature */
@@ -74,6 +75,9 @@ typedef enum {
     S390_FEAT_GROUP_MSA_EXT_3,
     S390_FEAT_GROUP_MSA_EXT_4,
     S390_FEAT_GROUP_MSA_EXT_5,
+    S390_FEAT_GROUP_MSA_EXT_6,
+    S390_FEAT_GROUP_MSA_EXT_7,
+    S390_FEAT_GROUP_MSA_EXT_8,
     S390_FEAT_GROUP_MAX,
 } S390FeatGroup;
 
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index c939a00..4b6d4e9 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -50,6 +50,7 @@ typedef enum {
     S390_FEAT_EXECUTE_EXT,
     S390_FEAT_ENHANCED_MONITOR,
     S390_FEAT_FLOATING_POINT_EXT,
+    S390_FEAT_ORDER_PRESERVING_COMPRESSION,
     S390_FEAT_SET_PROGRAM_PARAMETERS,
     S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
     S390_FEAT_DFP,
@@ -63,7 +64,11 @@ typedef enum {
     S390_FEAT_LOCAL_TLB_CLEARING,
     S390_FEAT_INTERLOCKED_ACCESS_2,
     S390_FEAT_STFLE_53,
+    S390_FEAT_ENTROPY_ENC_COMP,
     S390_FEAT_MSA_EXT_5,
+    S390_FEAT_MISC_INSTRUCTION_EXT,
+    S390_FEAT_SEMAPHORE_ASSIST,
+    S390_FEAT_TIME_SLICE_INSTRUMENTATION,
     S390_FEAT_RUNTIME_INSTRUMENTATION,
     S390_FEAT_ZPCI,
     S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
@@ -76,10 +81,22 @@ typedef enum {
     S390_FEAT_EDAT_2,
     S390_FEAT_DFP_PACKED_CONVERSION,
     S390_FEAT_VECTOR,
+    S390_FEAT_INSTRUCTION_EXEC_PROT,
+    S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
+    S390_FEAT_GUARDED_STORAGE,
+    S390_FEAT_VECTOR_PACKED_DECIMAL,
+    S390_FEAT_VECTOR_ENH,
+    S390_FEAT_MULTIPLE_EPOCH,
+    S390_FEAT_TEST_PENDING_EXT_INTERRUPTION,
+    S390_FEAT_INSERT_REFERENCE_BITS_MULT,
+    S390_FEAT_MSA_EXT_8,
+    S390_FEAT_CMM_NT,
 
     /* Sclp Conf Char */
     S390_FEAT_SIE_GSLS,
     S390_FEAT_ESOP,
+    S390_FEAT_HPMA2,
+    S390_FEAT_SIE_KSS,
 
     /* Sclp Conf Char Ext */
     S390_FEAT_SIE_64BSCAO,
@@ -186,12 +203,24 @@ typedef enum {
     S390_FEAT_KIMD_SHA_1,
     S390_FEAT_KIMD_SHA_256,
     S390_FEAT_KIMD_SHA_512,
+    S390_FEAT_KIMD_SHA3_224,
+    S390_FEAT_KIMD_SHA3_256,
+    S390_FEAT_KIMD_SHA3_384,
+    S390_FEAT_KIMD_SHA3_512,
+    S390_FEAT_KIMD_SHAKE_128,
+    S390_FEAT_KIMD_SHAKE_256,
     S390_FEAT_KIMD_GHASH,
 
     /* KLMD */
     S390_FEAT_KLMD_SHA_1,
     S390_FEAT_KLMD_SHA_256,
     S390_FEAT_KLMD_SHA_512,
+    S390_FEAT_KLMD_SHA3_224,
+    S390_FEAT_KLMD_SHA3_256,
+    S390_FEAT_KLMD_SHA3_384,
+    S390_FEAT_KLMD_SHA3_512,
+    S390_FEAT_KLMD_SHAKE_128,
+    S390_FEAT_KLMD_SHAKE_256,
 
     /* PCKMO */
     S390_FEAT_PCKMO_EDEA,
@@ -261,8 +290,18 @@ typedef enum {
     S390_FEAT_PCC_XTS_EAES_128,
     S390_FEAT_PCC_XTS_EAES_256,
 
-    /* PPNO */
+    /* PPNO/PRNO */
     S390_FEAT_PPNO_SHA_512_DRNG,
+    S390_FEAT_PRNO_TRNG_QRTCR,
+    S390_FEAT_PRNO_TRNG,
+
+    /* KMA */
+    S390_FEAT_KMA_GCM_AES_128,
+    S390_FEAT_KMA_GCM_AES_192,
+    S390_FEAT_KMA_GCM_AES_256 ,
+    S390_FEAT_KMA_GCM_EAES_128,
+    S390_FEAT_KMA_GCM_EAES_192,
+    S390_FEAT_KMA_GCM_EAES_256,
     S390_FEAT_MAX,
 } S390Feat;
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index fd3f459..16100ec 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -697,6 +697,31 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_SIE_CMMA, S390_FEAT_CMM },
         { S390_FEAT_SIE_CMMA, S390_FEAT_SIE_GSLS },
         { S390_FEAT_SIE_PFMFI, S390_FEAT_EDAT },
+        { S390_FEAT_MSA_EXT_8, S390_FEAT_MSA_EXT_3 },
+        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
+        { S390_FEAT_VECTOR_PACKED_DECIMAL, S390_FEAT_VECTOR },
+        { S390_FEAT_VECTOR_ENH, S390_FEAT_VECTOR },
+        { S390_FEAT_INSTRUCTION_EXEC_PROT, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
+        { S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2, S390_FEAT_ESOP },
+        { S390_FEAT_CMM_NT, S390_FEAT_CMM },
+        { S390_FEAT_GUARDED_STORAGE, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
+        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_STORE_CLOCK_FAST },
+        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
+        { S390_FEAT_SEMAPHORE_ASSIST, S390_FEAT_STFLE_49 },
+        { S390_FEAT_KIMD_SHA3_224, S390_FEAT_MSA },
+        { S390_FEAT_KIMD_SHA3_256, S390_FEAT_MSA },
+        { S390_FEAT_KIMD_SHA3_384, S390_FEAT_MSA },
+        { S390_FEAT_KIMD_SHA3_512, S390_FEAT_MSA },
+        { S390_FEAT_KIMD_SHAKE_128, S390_FEAT_MSA },
+        { S390_FEAT_KIMD_SHAKE_256, S390_FEAT_MSA },
+        { S390_FEAT_KLMD_SHA3_224, S390_FEAT_MSA },
+        { S390_FEAT_KLMD_SHA3_256, S390_FEAT_MSA },
+        { S390_FEAT_KLMD_SHA3_384, S390_FEAT_MSA },
+        { S390_FEAT_KLMD_SHA3_512, S390_FEAT_MSA },
+        { S390_FEAT_KLMD_SHAKE_128, S390_FEAT_MSA },
+        { S390_FEAT_KLMD_SHAKE_256, S390_FEAT_MSA },
+        { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
+        { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
     };
     int i;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 622ee24..33404e4 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -182,6 +182,33 @@
     S390_FEAT_MSA_EXT_5, \
     S390_FEAT_PPNO_SHA_512_DRNG
 
+#define S390_FEAT_GROUP_MSA_EXT_6 \
+    S390_FEAT_KIMD_SHA3_224, \
+    S390_FEAT_KIMD_SHA3_256, \
+    S390_FEAT_KIMD_SHA3_384, \
+    S390_FEAT_KIMD_SHA3_512, \
+    S390_FEAT_KIMD_SHAKE_128, \
+    S390_FEAT_KIMD_SHAKE_256, \
+    S390_FEAT_KLMD_SHA3_224, \
+    S390_FEAT_KLMD_SHA3_256, \
+    S390_FEAT_KLMD_SHA3_384, \
+    S390_FEAT_KLMD_SHA3_512, \
+    S390_FEAT_KLMD_SHAKE_128, \
+    S390_FEAT_KLMD_SHAKE_256
+
+#define S390_FEAT_GROUP_MSA_EXT_7 \
+    S390_FEAT_PRNO_TRNG_QRTCR, \
+    S390_FEAT_PRNO_TRNG
+
+#define S390_FEAT_GROUP_MSA_EXT_8 \
+    S390_FEAT_MSA_EXT_8, \
+    S390_FEAT_KMA_GCM_AES_128, \
+    S390_FEAT_KMA_GCM_AES_192, \
+    S390_FEAT_KMA_GCM_AES_256 , \
+    S390_FEAT_KMA_GCM_EAES_128, \
+    S390_FEAT_KMA_GCM_EAES_192, \
+    S390_FEAT_KMA_GCM_EAES_256
+
 /* cpu feature groups */
 static uint16_t group_PLO[] = {
     S390_FEAT_GROUP_PLO,
@@ -210,6 +237,15 @@ static uint16_t group_MSA_EXT_4[] = {
 static uint16_t group_MSA_EXT_5[] = {
     S390_FEAT_GROUP_MSA_EXT_5,
 };
+static uint16_t group_MSA_EXT_6[] = {
+    S390_FEAT_GROUP_MSA_EXT_6,
+};
+static uint16_t group_MSA_EXT_7[] = {
+    S390_FEAT_GROUP_MSA_EXT_7,
+};
+static uint16_t group_MSA_EXT_8[] = {
+    S390_FEAT_GROUP_MSA_EXT_8,
+};
 
 /* Base features (in order of release)
  * Only non-hypervisor managed features belong here.
@@ -548,6 +584,9 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(MSA_EXT_3),
     FEAT_GROUP_INITIALIZER(MSA_EXT_4),
     FEAT_GROUP_INITIALIZER(MSA_EXT_5),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_6),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_7),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_8),
 };
 
 static void set_bits(uint64_t list[], BitSpec bits)
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 1901153..3a80f1f 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2447,6 +2447,9 @@ static int query_cpu_subfunc(S390FeatBitmap features)
     if (test_bit(S390_FEAT_MSA_EXT_5, features)) {
         s390_add_from_feat_block(features, S390_FEAT_TYPE_PPNO, prop.ppno);
     }
+    if (test_bit(S390_FEAT_MSA_EXT_8, features)) {
+        s390_add_from_feat_block(features, S390_FEAT_TYPE_KMA, prop.kma);
+    }
     return 0;
 }
 
@@ -2500,6 +2503,10 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
         s390_fill_feat_block(features, S390_FEAT_TYPE_PPNO, prop.ppno);
         prop.ppno[0] |= 0x80; /* query is always available */
     }
+    if (test_bit(S390_FEAT_MSA_EXT_8, features)) {
+        s390_fill_feat_block(features, S390_FEAT_TYPE_KMA, prop.kma);
+        prop.kma[0] |= 0x80; /* query is always available */
+    }
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
@@ -2636,6 +2643,9 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
     /* with cpu model support, CMM is only indicated if really available */
     if (kvm_s390_cmma_available()) {
         set_bit(S390_FEAT_CMM, model->features);
+    } else {
+        /* no cmm -> no cmm nt */
+        clear_bit(S390_FEAT_CMM_NT, model->features);
     }
 
     /* set zpci and aen facilities */
-- 
2.7.4
