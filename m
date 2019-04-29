Received: from eggs.gnu.org ([209.51.188.92]:33382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL2GK-0001YM-VH
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL2Bw-0000a0-5t
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:03:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39912
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hL2Bw-0000Tl-1W
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:03:16 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3T8reel057729
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:03:05 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s5w0gb6am-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:03:04 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 29 Apr 2019 10:03:03 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 29 Apr 2019 05:02:49 -0400
In-Reply-To: <20190429090250.7648-1-borntraeger@de.ibm.com>
References: <20190429090250.7648-1-borntraeger@de.ibm.com>
Message-Id: <20190429090250.7648-9-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v3 8/9] s390x/cpumodel: add gen15 defintions
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

add several new features (msa9, sort, deflate, additional vector
instructions, new general purpose instructions) to generation 15.

Also disable csske and bpb from the default and base models >=15.
This will allow to migrate gen15 machines to future machines that
do not have these features.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/gen-features.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 8fc2e8e72f..c346b76bdf 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -13,6 +13,7 @@
 
 #include <inttypes.h>
 #include <stdio.h>
+#include <string.h>
 #include "cpu_features_def.h"
 
 #define ARRAY_SIZE(array) (sizeof(array) / sizeof(array[0]))
@@ -419,6 +420,10 @@ static uint16_t base_GEN14_GA1[] = {
 
 #define base_GEN14_GA2 EmptyFeat
 
+static uint16_t base_GEN15_GA1[] = {
+    S390_FEAT_MISC_INSTRUCTION_EXT3,
+};
+
 /* Full features (in order of release)
  * Automatically includes corresponding base features.
  * Full features are all features this hardware supports even if kvm/QEMU do not
@@ -548,6 +553,16 @@ static uint16_t full_GEN14_GA1[] = {
 
 #define full_GEN14_GA2 EmptyFeat
 
+static uint16_t full_GEN15_GA1[] = {
+    S390_FEAT_VECTOR_ENH2,
+    S390_FEAT_GROUP_ENH_SORT,
+    S390_FEAT_GROUP_DEFLATE_CONVERSION,
+    S390_FEAT_VECTOR_BCD_ENH,
+    S390_FEAT_GROUP_MSA_EXT_9,
+    S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
+    S390_FEAT_ETOKEN,
+};
+
 /* Default features (in order of release)
  * Automatically includes corresponding base features.
  * Default features are all features this version of QEMU supports for this
@@ -624,6 +639,16 @@ static uint16_t default_GEN14_GA1[] = {
 
 #define default_GEN14_GA2 EmptyFeat
 
+static uint16_t default_GEN15_GA1[] = {
+    S390_FEAT_VECTOR_ENH2,
+    S390_FEAT_GROUP_ENH_SORT,
+    S390_FEAT_GROUP_DEFLATE_CONVERSION,
+    S390_FEAT_VECTOR_BCD_ENH,
+    S390_FEAT_GROUP_MSA_EXT_9,
+    S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
+    S390_FEAT_ETOKEN,
+};
+
 /* QEMU (CPU model) features */
 
 static uint16_t qemu_V2_11[] = {
@@ -740,6 +765,7 @@ static CpuFeatDefSpec CpuFeatDef[] = {
     CPU_FEAT_INITIALIZER(GEN13_GA2),
     CPU_FEAT_INITIALIZER(GEN14_GA1),
     CPU_FEAT_INITIALIZER(GEN14_GA2),
+    CPU_FEAT_INITIALIZER(GEN15_GA1),
 };
 
 #define FEAT_GROUP_INITIALIZER(_name)                  \
@@ -808,6 +834,11 @@ static void set_bits(uint64_t list[], BitSpec bits)
     }
 }
 
+static inline void clear_bit(uint64_t list[], unsigned long nr)
+{
+    list[nr / 64] &= ~(1ULL << (nr % 64));
+}
+
 static void print_feature_defs(void)
 {
     uint64_t base_feat[S390_FEAT_MAX / 64 + 1] = {};
@@ -818,6 +849,12 @@ static void print_feature_defs(void)
     printf("\n/* CPU model feature list data */\n");
 
     for (i = 0; i < ARRAY_SIZE(CpuFeatDef); i++) {
+        /* With gen15 CSSKE and BPB are deprecated */
+        if (strcmp(CpuFeatDef[i].name, "S390_FEAT_LIST_GEN15_GA1") == 0) {
+            clear_bit(base_feat, S390_FEAT_CONDITIONAL_SSKE);
+            clear_bit(default_feat, S390_FEAT_CONDITIONAL_SSKE);
+            clear_bit(default_feat, S390_FEAT_BPB);
+        }
         set_bits(base_feat, CpuFeatDef[i].base_bits);
         /* add the base to the default features */
         set_bits(default_feat, CpuFeatDef[i].base_bits);
-- 
2.17.1
