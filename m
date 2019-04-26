Received: from eggs.gnu.org ([209.51.188.92]:50408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJykV-0001vc-Ae
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJykU-00035n-D5
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:10:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hJykU-00033o-26
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:10:34 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3QB8dfW085147
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:10:32 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s3y20nmt9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:10:27 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 26 Apr 2019 12:10:22 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 26 Apr 2019 07:10:02 -0400
In-Reply-To: <20190426111003.21246-1-borntraeger@de.ibm.com>
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
Message-Id: <20190426111003.21246-10-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v2 09/10] s390x/cpumodel: disable csske and bpb
 from gen15 cpu models onwards
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

These facilities are deprecated and no longer needed.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/gen-features.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 6260f56dc1..c346b76bdf 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -13,6 +13,7 @@
 
 #include <inttypes.h>
 #include <stdio.h>
+#include <string.h>
 #include "cpu_features_def.h"
 
 #define ARRAY_SIZE(array) (sizeof(array) / sizeof(array[0]))
@@ -833,6 +834,11 @@ static void set_bits(uint64_t list[], BitSpec bits)
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
@@ -843,6 +849,12 @@ static void print_feature_defs(void)
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
