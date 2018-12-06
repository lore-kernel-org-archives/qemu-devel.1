Received: from eggs.gnu.org ([2001:4830:134:3::10]:47928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gV255-0007nJ-Uq
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 17:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gV24z-00039f-Ln
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 17:25:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44400
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gV24z-00038M-CW
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 17:25:09 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB6MJ23v023043
	for <qemu-devel@nongnu.org>; Thu, 6 Dec 2018 17:25:08 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p7cf4088u-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 17:25:08 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 6 Dec 2018 22:25:08 -0000
From: Collin Walling <walling@linux.ibm.com>
Date: Thu,  6 Dec 2018 17:24:17 -0500
In-Reply-To: <1544135058-21380-1-git-send-email-walling@linux.ibm.com>
References: <1544135058-21380-1-git-send-email-walling@linux.ibm.com>
Message-Id: <1544135058-21380-3-git-send-email-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/3] s390: cpu feature for diagnose 318
 andlimit max VCPUs to 247
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, borntraeger@de.ibm.com, thuth@redhat.com

Diagnose 318 is a new z14.2 CPU feature. Since we are able to emulate
it entirely via KVM, we can add guest support for earlier models. A
new CPU feature for diagnose 318 (shortened to diag318) will be made
available to guests starting with the zEC12-full CPU model.

The z14.2 adds a new read SCP info byte (let's call it byte 134) to
detect the availability of diag318. Because of this, we have room for
one less VCPU and thus limit the max VPUs supported in a configuration
to 247 (down from 248).

Signed-off-by: Collin Walling <walling@linux.ibm.com>.
---
 hw/s390x/sclp.c                 | 2 ++
 include/hw/s390x/sclp.h         | 2 ++
 target/s390x/cpu.h              | 2 +-
 target/s390x/cpu_features.c     | 3 +++
 target/s390x/cpu_features.h     | 1 +
 target/s390x/cpu_features_def.h | 3 +++
 target/s390x/gen-features.c     | 1 +
 target/s390x/kvm.c              | 1 +
 8 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 4510a80..183c627 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -73,6 +73,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
                          read_info->conf_char);
     s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
                          read_info->conf_char_ext);
+    /* Read Info byte 134 */
+    s390_get_feat_block(S390_FEAT_TYPE_SCLP_BYTE_134, read_info->byte_134);
 
     read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
                                         SCLP_HAS_IOA_RECONFIG);
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index f9db243..eb12ba2 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -133,6 +133,8 @@ typedef struct ReadInfo {
     uint16_t highest_cpu;
     uint8_t  _reserved5[124 - 122];     /* 122-123 */
     uint32_t hmfai;
+    uint8_t  _reserved7[134 - 128];     /* 128-133 */
+    uint8_t  byte_134[1];
     struct CPUEntry entries[0];
 } QEMU_PACKED ReadInfo;
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 8c2320e..594b4a4 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -52,7 +52,7 @@
 
 #define MMU_USER_IDX 0
 
-#define S390_MAX_CPUS 248
+#define S390_MAX_CPUS 247
 
 typedef struct PSW {
     uint64_t mask;
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 60cfeba..d05afa5 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -121,6 +121,9 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("pfmfi", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 9, "SIE: PFMF interpretation facility"),
     FEAT_INIT("ibs", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-suppression facility"),
 
+    /* SCLP SCCB Byte 134 */
+    FEAT_INIT("diag318", S390_FEAT_TYPE_SCLP_BYTE_134, 0, "SIE: Diagnose 318"),
+
     FEAT_INIT("sief2", S390_FEAT_TYPE_SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)"),
     FEAT_INIT("skey", S390_FEAT_TYPE_SCLP_CPU, 5, "SIE: Storage-key facility"),
     FEAT_INIT("gpereh", S390_FEAT_TYPE_SCLP_CPU, 10, "SIE: Guest-PER enhancement facility"),
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index effe790..e7248df 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -23,6 +23,7 @@ typedef enum {
     S390_FEAT_TYPE_STFL,
     S390_FEAT_TYPE_SCLP_CONF_CHAR,
     S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
+    S390_FEAT_TYPE_SCLP_BYTE_134,
     S390_FEAT_TYPE_SCLP_CPU,
     S390_FEAT_TYPE_MISC,
     S390_FEAT_TYPE_PLO,
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 5fc7e7b..d99da1d 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -109,6 +109,9 @@ typedef enum {
     S390_FEAT_SIE_PFMFI,
     S390_FEAT_SIE_IBS,
 
+    /* Read Info Byte 134 */
+    S390_FEAT_DIAG318,
+
     /* Sclp Cpu */
     S390_FEAT_SIE_F2,
     S390_FEAT_SIE_SKEY,
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 70015ea..a3d1457 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -450,6 +450,7 @@ static uint16_t full_GEN12_GA1[] = {
     S390_FEAT_AP_QUERY_CONFIG_INFO,
     S390_FEAT_AP_FACILITIES_TEST,
     S390_FEAT_AP,
+    S390_FEAT_DIAG318,
 };
 
 static uint16_t full_GEN12_GA2[] = {
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 2ebf26a..3915e36 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2142,6 +2142,7 @@ static int kvm_to_feat[][2] = {
     { KVM_S390_VM_CPU_FEAT_PFMFI, S390_FEAT_SIE_PFMFI},
     { KVM_S390_VM_CPU_FEAT_SIGPIF, S390_FEAT_SIE_SIGPIF},
     { KVM_S390_VM_CPU_FEAT_KSS, S390_FEAT_SIE_KSS},
+    { KVM_S390_VM_CPU_FEAT_DIAG318, S390_FEAT_DIAG318},
 };
 
 static int query_cpu_feat(S390FeatBitmap features)
-- 
2.7.4
