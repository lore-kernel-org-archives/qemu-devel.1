Received: from eggs.gnu.org ([209.51.188.92]:33382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL2GT-0001YM-BW
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL2Bj-0000Pd-Eo
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:03:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hL2Bj-0000Od-2p
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:03:03 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3T8s8SX141767
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:03:01 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s5wg0j1kx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:03:01 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 29 Apr 2019 10:03:00 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 29 Apr 2019 05:02:47 -0400
In-Reply-To: <20190429090250.7648-1-borntraeger@de.ibm.com>
References: <20190429090250.7648-1-borntraeger@de.ibm.com>
Message-Id: <20190429090250.7648-7-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v3 6/9] s390x/cpumodel: enhanced sort facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

add the enhanced sort facility.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_features.c     | 10 ++++++++++
 target/s390x/cpu_features.h     |  1 +
 target/s390x/cpu_features_def.h |  8 ++++++++
 target/s390x/gen-features.c     | 14 ++++++++++++++
 target/s390x/kvm.c              |  6 ++++++
 5 files changed, 39 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 35873253be..1d19b3072e 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -109,6 +109,7 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security-assist-extension-8 facility (excluding subfunctions)"),
     FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
     FEAT_INIT("vxeh2", S390_FEAT_TYPE_STFL, 148, "Vector Enhancements facility 2"),
+    FEAT_INIT("esort-base", S390_FEAT_TYPE_STFL, 150, "Enhanced-sort facility (excluding subfunctions)"),
     FEAT_INIT("vxbeh", S390_FEAT_TYPE_STFL, 152, "Vector BCD enhancements facility 1"),
     FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)"),
     FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
@@ -340,6 +341,12 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("kdsa-eddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 44, "KDSA EdDSA-Sign-Ed448"),
     FEAT_INIT("kdsa-eeddsa-sign-ed25519", S390_FEAT_TYPE_KDSA, 48, "KDSA Encrypted-EdDSA-Sign-Ed25519"),
     FEAT_INIT("kdsa-eeddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 52, "KDSA Encrypted-EdDSA-Sign-Ed448"),
+
+    FEAT_INIT("sortl-sflr", S390_FEAT_TYPE_SORTL, 1, "SORTL SFLR"),
+    FEAT_INIT("sortl-svlr", S390_FEAT_TYPE_SORTL, 2, "SORTL SVLR"),
+    FEAT_INIT("sortl-32", S390_FEAT_TYPE_SORTL, 130, "SORTL 32 input lists"),
+    FEAT_INIT("sortl-128", S390_FEAT_TYPE_SORTL, 132, "SORTL 128 input lists"),
+    FEAT_INIT("sortl-f0", S390_FEAT_TYPE_SORTL, 192, "SORTL format 0 parameter-block"),
 };
 
 const S390FeatDef *s390_feat_def(S390Feat feat)
@@ -403,6 +410,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
     case S390_FEAT_TYPE_PPNO:
     case S390_FEAT_TYPE_KMA:
     case S390_FEAT_TYPE_KDSA:
+    case S390_FEAT_TYPE_SORTL:
         set_be_bit(0, data); /* query is always available */
         break;
     default:
@@ -430,6 +438,7 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
        nr_bits = 16384;
        break;
     case S390_FEAT_TYPE_PLO:
+    case S390_FEAT_TYPE_SORTL:
        nr_bits = 256;
        break;
     default:
@@ -501,6 +510,7 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("msa9", MSA_EXT_9, "Message-security-assist-extension 9 facility"),
     FEAT_GROUP_INIT("msa9_pckmo", MSA_EXT_9_PCKMO, "Message-security-assist-extension 9 PCKMO subfunctions"),
     FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
+    FEAT_GROUP_INIT("esort", ENH_SORT, "Enhanced-sort facility"),
 };
 
 const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group)
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 5ffd3db083..3b8c5b25dd 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -40,6 +40,7 @@ typedef enum {
     S390_FEAT_TYPE_PPNO,
     S390_FEAT_TYPE_KMA,
     S390_FEAT_TYPE_KDSA,
+    S390_FEAT_TYPE_SORTL,
 } S390FeatType;
 
 /* Definition of a CPU feature */
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index ce2223c9d7..bb8585847f 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -97,6 +97,7 @@ typedef enum {
     S390_FEAT_MSA_EXT_8,
     S390_FEAT_CMM_NT,
     S390_FEAT_VECTOR_ENH2,
+    S390_FEAT_ESORT_BASE,
     S390_FEAT_VECTOR_BCD_ENH,
     S390_FEAT_MSA_EXT_9,
     S390_FEAT_ETOKEN,
@@ -346,6 +347,13 @@ typedef enum {
     S390_FEAT_EEDDSA_SIGN_ED25519,
     S390_FEAT_EEDDSA_SIGN_ED448,
 
+    /* SORTL */
+    S390_FEAT_SORTL_SFLR,
+    S390_FEAT_SORTL_SVLR,
+    S390_FEAT_SORTL_32,
+    S390_FEAT_SORTL_128,
+    S390_FEAT_SORTL_F0,
+
     S390_FEAT_MAX,
 } S390Feat;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index a2f9e2b43f..0a62cc5631 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -245,6 +245,15 @@
     S390_FEAT_PCKMO_ECC_ED25519, \
     S390_FEAT_PCKMO_ECC_ED448
 
+#define S390_FEAT_GROUP_ENH_SORT \
+    S390_FEAT_ESORT_BASE, \
+    S390_FEAT_SORTL_SFLR, \
+    S390_FEAT_SORTL_SVLR, \
+    S390_FEAT_SORTL_32, \
+    S390_FEAT_SORTL_128, \
+    S390_FEAT_SORTL_F0
+
+
 /* cpu feature groups */
 static uint16_t group_PLO[] = {
     S390_FEAT_GROUP_PLO,
@@ -294,6 +303,10 @@ static uint16_t group_MSA_EXT_9_PCKMO[] = {
     S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
 };
 
+static uint16_t group_ENH_SORT[] = {
+    S390_FEAT_GROUP_ENH_SORT,
+};
+
 /* Base features (in order of release)
  * Only non-hypervisor managed features belong here.
  * Base feature sets are static meaning they do not change in future QEMU
@@ -752,6 +765,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(MSA_EXT_9),
     FEAT_GROUP_INITIALIZER(MSA_EXT_9_PCKMO),
     FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
+    FEAT_GROUP_INITIALIZER(ENH_SORT),
 };
 
 #define QEMU_FEAT_INITIALIZER(_name)                   \
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index de0b984b68..f91f436a31 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2076,6 +2076,9 @@ static int query_cpu_subfunc(S390FeatBitmap features)
     if (test_bit(S390_FEAT_MSA_EXT_9, features)) {
         s390_add_from_feat_block(features, S390_FEAT_TYPE_KDSA, prop.kdsa);
     }
+    if (test_bit(S390_FEAT_ESORT_BASE, features)) {
+        s390_add_from_feat_block(features, S390_FEAT_TYPE_SORTL, prop.sortl);
+    }
     return 0;
 }
 
@@ -2123,6 +2126,9 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
     if (test_bit(S390_FEAT_MSA_EXT_9, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_KDSA, prop.kdsa);
     }
+    if (test_bit(S390_FEAT_ESORT_BASE, features)) {
+        s390_fill_feat_block(features, S390_FEAT_TYPE_SORTL, prop.sortl);
+    }
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
-- 
2.17.1
