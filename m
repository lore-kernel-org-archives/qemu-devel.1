Received: from eggs.gnu.org ([209.51.188.92]:56849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gtMhX-0000tj-Nz
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:17:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gtMhF-0006CA-TY
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:17:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35218
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gtMh8-00062j-S3
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:17:08 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1C18Jp4006278
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:17:02 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qkghk8aee-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:17:02 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 12 Feb 2019 01:17:01 -0000
From: Collin Walling <walling@linux.ibm.com>
Date: Mon, 11 Feb 2019 20:16:55 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190212011657.18324-1-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/3] s390x/cpumodel: mepochptff: warn when
 no mepoch and re-align group init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com, rth@twiddle.net

The extended PTFF features (qsie, qtoue, stoe, stoue) are dependent
on the multiple-epoch facility (mepoch). Let's print a warning if these
features are enabled without mepoch.

While we're at it, let's move the FEAT_GROUP_INIT for mepochptff down
the s390_feature_groups list so it can be properly indexed with its
generated S390FeatGroup enum.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 target/s390x/cpu_features.c | 2 +-
 target/s390x/cpu_models.c   | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 60cfeba48f..1843c84aaa 100644
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
index 7c253ff308..b42b5fd327 100644
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
2.20.1
