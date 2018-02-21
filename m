Received: from eggs.gnu.org ([2001:4830:134:3::10]:34664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eoXia-0001pm-4p
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eoXiU-0007Wg-Bo
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:58:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eoXiU-0007AW-35
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:58:02 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1LGueHF021451
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 11:56:42 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g9cprg49k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 11:56:41 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 21 Feb 2018 16:56:36 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 17:56:28 +0100
Message-Id: <20180221165628.78946-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/1] 390x/cpumodel: document S390FeatDef.bit
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
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

The 'bit' field of the 'S390FeatDef' structure is not applicable to all
its instances. Currently this field is not applicable, and remains
unused, iff the feature is of type S390_FEAT_TYPE_MISC. Having the value 0
specified for multiple such feature definition  was a little confusing,
as it's a perfectly legit bit value, and as the value of the bit
field is usually ought to be unique for each feature of a given
feature type.

Let us introduce a specialized macro for defining features of type
S390_FEAT_TYPE_MISC so, that one does not have to specify neither bit nor
type (as the later is implied).

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---

v1 -> v2
* Specialized feature initializer macro for type MISC that does not
  require a bit value instead of defining a 'not a bit number' (that
  is extremal) bit number.
---
 target/s390x/cpu_features.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index a5619f2893..3b9e2745e9 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -23,6 +23,10 @@
         .desc = _desc,                               \
     }
 
+/* S390FeatDef.bit is not applicable as there is no feature block. */
+#define FEAT_INIT_MISC(_name, _desc)                 \
+            FEAT_INIT(_name, S390_FEAT_TYPE_MISC, 0, _desc)
+
 /* indexed by feature number for easy lookup */
 static const S390FeatDef s390_features[] = {
     FEAT_INIT("esan3", S390_FEAT_TYPE_STFL, 0, "Instructions marked as n3"),
@@ -123,8 +127,8 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("ib", S390_FEAT_TYPE_SCLP_CPU, 42, "SIE: Intervention bypass facility"),
     FEAT_INIT("cei", S390_FEAT_TYPE_SCLP_CPU, 43, "SIE: Conditional-external-interception facility"),
 
-    FEAT_INIT("dateh2", S390_FEAT_TYPE_MISC, 0, "DAT-enhancement facility 2"),
-    FEAT_INIT("cmm", S390_FEAT_TYPE_MISC, 0, "Collaborative-memory-management facility"),
+    FEAT_INIT_MISC("dateh2", "DAT-enhancement facility 2"),
+    FEAT_INIT_MISC("cmm", "Collaborative-memory-management facility"),
 
     FEAT_INIT("plo-cl", S390_FEAT_TYPE_PLO, 0, "PLO Compare and load (32 bit in general registers)"),
     FEAT_INIT("plo-clg", S390_FEAT_TYPE_PLO, 1, "PLO Compare and load (64 bit in parameter list)"),
-- 
2.13.5
