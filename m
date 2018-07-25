Received: from eggs.gnu.org ([2001:4830:134:3::10]:49025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mimu@linux.ibm.com>) id 1fiKu1-00038o-N2
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mimu@linux.ibm.com>) id 1fiKty-0007Wy-O3
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:36:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59984
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mimu@linux.ibm.com>) id 1fiKty-0007Ud-HA
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:36:30 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6PEY6rQ074908
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 10:36:27 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2keswyc3bs-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 10:36:27 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mimu@linux.ibm.com>;
	Wed, 25 Jul 2018 15:36:25 +0100
From: Michael Mueller <mimu@linux.ibm.com>
Date: Wed, 25 Jul 2018 16:36:17 +0200
Message-Id: <20180725143617.8731-1-mimu@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] s390x/cpumodel: enum type S390FeatGroup now
 gets generated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, Michael Mueller <mimu@linux.ibm.com>

The enumeration type S390FeatGroup is now generated as well.
This shall simplify the definition of new feature groups
without the requirement to modify existing code.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 target/s390x/cpu_features.c |  1 -
 target/s390x/cpu_features.h | 19 +------------------
 target/s390x/gen-features.c | 18 +++++++++++++++++-
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 3b9e2745e9..d623db34a6 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -13,7 +13,6 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "cpu_features.h"
-#include "gen-features.h"
 
 #define FEAT_INIT(_name, _type, _bit, _desc) \
     {                                                \
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 968b12fdfe..effe790271 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -16,6 +16,7 @@
 
 #include "qemu/bitmap.h"
 #include "cpu_features_def.h"
+#include "gen-features.h"
 
 /* CPU features are announced via different ways */
 typedef enum {
@@ -64,24 +65,6 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
 void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
                                void (*fn)(const char *name, void *opaque));
 
-/* static groups that will never change */
-typedef enum {
-    S390_FEAT_GROUP_PLO,
-    S390_FEAT_GROUP_TOD_CLOCK_STEERING,
-    S390_FEAT_GROUP_GEN13_PTFF_ENH,
-    S390_FEAT_GROUP_MSA,
-    S390_FEAT_GROUP_MSA_EXT_1,
-    S390_FEAT_GROUP_MSA_EXT_2,
-    S390_FEAT_GROUP_MSA_EXT_3,
-    S390_FEAT_GROUP_MSA_EXT_4,
-    S390_FEAT_GROUP_MSA_EXT_5,
-    S390_FEAT_GROUP_MSA_EXT_6,
-    S390_FEAT_GROUP_MSA_EXT_7,
-    S390_FEAT_GROUP_MSA_EXT_8,
-    S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
-    S390_FEAT_GROUP_MAX,
-} S390FeatGroup;
-
 /* Definition of a CPU feature group */
 typedef struct {
     const char *name;       /* name exposed to the user */
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 6626b6f565..2ca5ededb3 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -661,6 +661,7 @@ static CpuFeatDefSpec CpuFeatDef[] = {
 #define FEAT_GROUP_INITIALIZER(_name)                  \
     {                                                  \
         .name = "S390_FEAT_GROUP_LIST_" #_name,        \
+        .enum_name = "S390_FEAT_GROUP_" #_name,        \
         .bits =                                        \
             { .data = group_##_name,                   \
               .len = ARRAY_SIZE(group_##_name) },      \
@@ -668,6 +669,7 @@ static CpuFeatDefSpec CpuFeatDef[] = {
 
 typedef struct {
     const char *name;
+    const char *enum_name;
     BitSpec bits;
 } FeatGroupDefSpec;
 
@@ -678,7 +680,6 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(PLO),
     FEAT_GROUP_INITIALIZER(TOD_CLOCK_STEERING),
     FEAT_GROUP_INITIALIZER(GEN13_PTFF),
-    FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
     FEAT_GROUP_INITIALIZER(MSA),
     FEAT_GROUP_INITIALIZER(MSA_EXT_1),
     FEAT_GROUP_INITIALIZER(MSA_EXT_2),
@@ -688,6 +689,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(MSA_EXT_6),
     FEAT_GROUP_INITIALIZER(MSA_EXT_7),
     FEAT_GROUP_INITIALIZER(MSA_EXT_8),
+    FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
 };
 
 #define QEMU_FEAT_INITIALIZER(_name)                   \
@@ -810,6 +812,19 @@ static void print_feature_group_defs(void)
     }
 }
 
+static void print_feature_group_enum_type(void)
+{
+    int i;
+
+    printf("\n/* CPU feature group enum type */\n"
+           "typedef enum {\n");
+    for (i = 0; i < ARRAY_SIZE(FeatGroupDef); i++) {
+        printf("\t%s,\n", FeatGroupDef[i].enum_name);
+    }
+    printf("\tS390_FEAT_GROUP_MAX,\n"
+           "} S390FeatGroup;\n");
+}
+
 int main(int argc, char *argv[])
 {
     printf("/*\n"
@@ -826,6 +841,7 @@ int main(int argc, char *argv[])
     print_feature_defs();
     print_feature_group_defs();
     print_qemu_feature_defs();
+    print_feature_group_enum_type();
     printf("\n#endif\n");
     return 0;
 }
-- 
2.13.4
