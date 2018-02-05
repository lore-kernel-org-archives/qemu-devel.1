Received: from eggs.gnu.org ([2001:4830:134:3::10]:44438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eicmI-0003f4-Fu
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:09:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eicmE-0007Mn-Fa
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:09:30 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon,  5 Feb 2018 10:09:12 +0100
Message-Id: <20180205090912.6110-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH] s390x/cpumodel: model PTFF subfunctions for
 Multiple-epoch facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

For now, the kernel does not properly indicate configured CPU subfunctions
to the guest, but simply uses the host values (as support in KVM is still
missing). That's why we missed to model the PTFF subfunctions that come
with Multiple-epoch facility.

Let's properly add these, along with a new feature group.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_features.c     |  5 +++++
 target/s390x/cpu_features_def.h |  4 ++++
 target/s390x/gen-features.c     | 10 ++++++++++
 3 files changed, 19 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 85d10b5710..8606e52ca0 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -156,8 +156,12 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("ptff-qpc", S390_FEAT_TYPE_PTFF, 3, "PTFF Query Physical Clock"),
     FEAT_INIT("ptff-qui", S390_FEAT_TYPE_PTFF, 4, "PTFF Query UTC Information"),
     FEAT_INIT("ptff-qtou", S390_FEAT_TYPE_PTFF, 5, "PTFF Query TOD Offset User"),
+    FEAT_INIT("ptff-qsie", S390_FEAT_TYPE_PTFF, 10, "PTFF Query Steering Information Extended"),
+    FEAT_INIT("ptff-qtoue", S390_FEAT_TYPE_PTFF, 13, "PTFF Query TOD Offset User Extended"),
     FEAT_INIT("ptff-sto", S390_FEAT_TYPE_PTFF, 65, "PTFF Set TOD Offset"),
     FEAT_INIT("ptff-stou", S390_FEAT_TYPE_PTFF, 69, "PTFF Set TOD Offset User"),
+    FEAT_INIT("ptff-stoe", S390_FEAT_TYPE_PTFF, 73, "PTFF Set TOD Offset Extended"),
+    FEAT_INIT("ptff-stoue", S390_FEAT_TYPE_PTFF, 77, "PTFF Set TOD Offset User Extended"),
 
     FEAT_INIT("kmac-dea", S390_FEAT_TYPE_KMAC, 1, "KMAC DEA"),
     FEAT_INIT("kmac-tdea-128", S390_FEAT_TYPE_KMAC, 2, "KMAC TDEA-128"),
@@ -445,6 +449,7 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("plo", PLO, "Perform-locked-operation facility"),
     FEAT_GROUP_INIT("tods", TOD_CLOCK_STEERING, "Tod-clock-steering facility"),
     FEAT_GROUP_INIT("gen13ptff", GEN13_PTFF, "PTFF enhancements introduced with z13"),
+    FEAT_GROUP_INIT("mepochptff", MEPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
     FEAT_GROUP_INIT("msa", MSA, "Message-security-assist facility"),
     FEAT_GROUP_INIT("msa1", MSA_EXT_1, "Message-security-assist-extension 1 facility"),
     FEAT_GROUP_INIT("msa2", MSA_EXT_2, "Message-security-assist-extension 2 facility"),
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 4d930871b4..7c5915c7b2 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -151,8 +151,12 @@ typedef enum {
     S390_FEAT_PTFF_QPT,
     S390_FEAT_PTFF_QUI,
     S390_FEAT_PTFF_QTOU,
+    S390_FEAT_PTFF_QSIE,
+    S390_FEAT_PTFF_QTOUE,
     S390_FEAT_PTFF_STO,
     S390_FEAT_PTFF_STOU,
+    S390_FEAT_PTFF_STOE,
+    S390_FEAT_PTFF_STOUE,
 
     /* KMAC */
     S390_FEAT_KMAC_DEA,
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 58b6ac484e..8c04ff913f 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -59,6 +59,12 @@
     S390_FEAT_PTFF_QTOU, \
     S390_FEAT_PTFF_STOU
 
+#define S390_FEAT_GROUP_MEPOCH_PTFF \
+    S390_FEAT_PTFF_QSIE, \
+    S390_FEAT_PTFF_QTOUE, \
+    S390_FEAT_PTFF_STOE, \
+    S390_FEAT_PTFF_STOUE
+
 #define S390_FEAT_GROUP_MSA \
     S390_FEAT_MSA, \
     S390_FEAT_KMAC_DEA, \
@@ -219,6 +225,9 @@ static uint16_t group_TOD_CLOCK_STEERING[] = {
 static uint16_t group_GEN13_PTFF[] = {
     S390_FEAT_GROUP_GEN13_PTFF,
 };
+static uint16_t group_MEPOCH_PTFF[] = {
+    S390_FEAT_GROUP_MEPOCH_PTFF,
+};
 static uint16_t group_MSA[] = {
     S390_FEAT_GROUP_MSA,
 };
@@ -665,6 +674,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(PLO),
     FEAT_GROUP_INITIALIZER(TOD_CLOCK_STEERING),
     FEAT_GROUP_INITIALIZER(GEN13_PTFF),
+    FEAT_GROUP_INITIALIZER(MEPOCH_PTFF),
     FEAT_GROUP_INITIALIZER(MSA),
     FEAT_GROUP_INITIALIZER(MSA_EXT_1),
     FEAT_GROUP_INITIALIZER(MSA_EXT_2),
-- 
2.14.3
