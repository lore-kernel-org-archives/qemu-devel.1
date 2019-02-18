Received: from eggs.gnu.org ([209.51.188.92]:52402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqQ-00072L-2x
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqP-0006q2-9D
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:18 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 18 Feb 2019 12:11:49 +0100
Message-Id: <20190218111153.22681-7-cohuck@redhat.com>
In-Reply-To: <20190218111153.22681-1-cohuck@redhat.com>
References: <20190218111153.22681-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 06/10] s390x/cpumodel: mepochptff: warn when no
 mepoch and re-align group init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Collin Walling <walling@linux.ibm.com>

The extended PTFF features (qsie, qtoue, stoe, stoue) are dependent
on the multiple-epoch facility (mepoch). Let's print a warning if these
features are enabled without mepoch.

While we're at it, let's move the FEAT_GROUP_INIT for mepochptff down
the s390_feature_groups list so it can be properly indexed with its
generated S390FeatGroup enum.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Message-Id: <20190212011657.18324-1-walling@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_features.c | 2 +-
 target/s390x/cpu_models.c   | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 60cfeba48f4e..1843c84aaadc 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -456,7 +456,6 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("plo", PLO, "Perform-locked-operation facility"),
     FEAT_GROUP_INIT("tods", TOD_CLOCK_STEERING, "Tod-clock-steering facility"),
     FEAT_GROUP_INIT("gen13ptff", GEN13_PTFF, "PTFF enhancements introduced with z13"),
-    FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
     FEAT_GROUP_INIT("msa", MSA, "Message-security-assist facility"),
     FEAT_GROUP_INIT("msa1", MSA_EXT_1, "Message-security-assist-extension 1 facility"),
     FEAT_GROUP_INIT("msa2", MSA_EXT_2, "Message-security-assist-extension 2 facility"),
@@ -466,6 +465,7 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("msa6", MSA_EXT_6, "Message-security-assist-extension 6 facility"),
     FEAT_GROUP_INIT("msa7", MSA_EXT_7, "Message-security-assist-extension 7 facility"),
     FEAT_GROUP_INIT("msa8", MSA_EXT_8, "Message-security-assist-extension 8 facility"),
+    FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
 };
 
 const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group)
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 249011fd62f5..8002412f9af1 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -788,6 +788,10 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
         { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
         { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
+        { S390_FEAT_PTFF_QSIE, S390_FEAT_MULTIPLE_EPOCH },
+        { S390_FEAT_PTFF_QTOUE, S390_FEAT_MULTIPLE_EPOCH },
+        { S390_FEAT_PTFF_STOE, S390_FEAT_MULTIPLE_EPOCH },
+        { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
     };
     int i;
 
-- 
2.17.2
