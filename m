Received: from eggs.gnu.org ([2001:4830:134:3::10]:35951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eo9WE-0002U0-Ee
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eo9W9-0008J2-GH
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:07:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eo9W9-0008Ie-8V
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:07:41 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1KF2cBP135369
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 10:07:39 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g8n8sae2j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 10:07:38 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 20 Feb 2018 15:07:36 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 20 Feb 2018 16:07:13 +0100
Message-Id: <20180220150713.6056-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] 390x/cpumodel: document S390FeatDef.bit
 not applicable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

The 'bit' field of the 'S390FeatDef' structure is not applicable to all
it's instances. Currently a this field is not applicable, and remains
unused, iff the feature is of type S390_FEAT_TYPE_MISC. Having the value 0
specified for multiple such feature definition  was a little confusing,
as it's a perfectly legit bit value, and as usually the value of the bit
field is ought to be unique for each feature.

Let's document this, and hopefully reduce the potential for confusion.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---

Hi!

This may be an overkill. A comment where the misc features
are defined would do to, but I think this is nicer. So
I decided to try it with this approach first.

---
 target/s390x/cpu_features.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index a5619f2893..34fddfe78b 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -23,6 +23,13 @@
         .desc = _desc,                               \
     }
 
+/*
+ * For some feature types (e.g. S390_FEAT_TYPE_MISC) S390FeatDef.bit
+ * is not applicable, as there is no corresponding feature block. See
+ * s390_fill_feat_block() and it's usages.
+ */
+#define FEAT_BIT_NA -1
+
 /* indexed by feature number for easy lookup */
 static const S390FeatDef s390_features[] = {
     FEAT_INIT("esan3", S390_FEAT_TYPE_STFL, 0, "Instructions marked as n3"),
@@ -123,8 +130,8 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("ib", S390_FEAT_TYPE_SCLP_CPU, 42, "SIE: Intervention bypass facility"),
     FEAT_INIT("cei", S390_FEAT_TYPE_SCLP_CPU, 43, "SIE: Conditional-external-interception facility"),
 
-    FEAT_INIT("dateh2", S390_FEAT_TYPE_MISC, 0, "DAT-enhancement facility 2"),
-    FEAT_INIT("cmm", S390_FEAT_TYPE_MISC, 0, "Collaborative-memory-management facility"),
+    FEAT_INIT("dateh2", S390_FEAT_TYPE_MISC, FEAT_BIT_NA, "DAT-enhancement facility 2"),
+    FEAT_INIT("cmm", S390_FEAT_TYPE_MISC, FEAT_BIT_NA, "Collaborative-memory-management facility"),
 
     FEAT_INIT("plo-cl", S390_FEAT_TYPE_PLO, 0, "PLO Compare and load (32 bit in general registers)"),
     FEAT_INIT("plo-clg", S390_FEAT_TYPE_PLO, 1, "PLO Compare and load (64 bit in parameter list)"),
-- 
2.13.5
