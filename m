Received: from eggs.gnu.org ([2001:4830:134:3::10]:43827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wj-0002Pt-Ev
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wh-0006OW-Ub
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:17 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:18 +0100
Message-Id: <20180209092524.31348-24-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 23/29] s390x/cpumodel: model PTFF subfunctions
 for Multiple-epoch facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

For now, the kernel does not properly indicate configured CPU subfunctions
to the guest, but simply uses the host values (as support in KVM is still
missing). That's why we missed to model the PTFF subfunctions that come
with Multiple-epoch facility.

Let's properly add these, along with a new feature group.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180205102935.14736-1-david@redhat.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_features.c     |  5 +++++
 target/s390x/cpu_features_def.h |  4 ++++
 target/s390x/gen-features.c     | 11 +++++++++++
 target/s390x/kvm.c              |  8 ++++++++
 4 files changed, 28 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 85d10b5710..a5619f2893 100644
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
+    FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
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
index 89a140c9a7..f6211b4e6b 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -59,6 +59,12 @@
     S390_FEAT_PTFF_QTOU, \
     S390_FEAT_PTFF_STOU
 
+#define S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF \
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
+static uint16_t group_MULTIPLE_EPOCH_PTFF[] = {
+    S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
+};
 static uint16_t group_MSA[] = {
     S390_FEAT_GROUP_MSA,
 };
@@ -466,6 +475,7 @@ static uint16_t full_GEN14_GA1[] = {
     S390_FEAT_CMM_NT,
     S390_FEAT_HPMA2,
     S390_FEAT_SIE_KSS,
+    S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
 };
 
 /* Default features (in order of release)
@@ -668,6 +678,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(PLO),
     FEAT_GROUP_INITIALIZER(TOD_CLOCK_STEERING),
     FEAT_GROUP_INITIALIZER(GEN13_PTFF),
+    FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
     FEAT_GROUP_INITIALIZER(MSA),
     FEAT_GROUP_INITIALIZER(MSA_EXT_1),
     FEAT_GROUP_INITIALIZER(MSA_EXT_2),
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index bfd14723f1..deb870921b 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2221,6 +2221,14 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         return;
     }
 
+    /* PTFF subfunctions might be indicated although kernel support missing */
+    if (!test_bit(S390_FEAT_MULTIPLE_EPOCH, model->features)) {
+        clear_bit(S390_FEAT_PTFF_QSIE, model->features);
+        clear_bit(S390_FEAT_PTFF_QTOUE, model->features);
+        clear_bit(S390_FEAT_PTFF_STOE, model->features);
+        clear_bit(S390_FEAT_PTFF_STOUE, model->features);
+    }
+
     /* with cpu model support, CMM is only indicated if really available */
     if (kvm_s390_cmma_available()) {
         set_bit(S390_FEAT_CMM, model->features);
-- 
2.13.6
