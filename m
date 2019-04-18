Received: from eggs.gnu.org ([209.51.188.92]:50746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH5GJ-0002m7-B3
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH5GF-0004Wc-Ns
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hH5GF-0004Tm-66
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3IBTUCH047911
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 07:31:21 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rxp2renkn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 07:31:20 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 18 Apr 2019 12:31:17 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 18 Apr 2019 13:31:08 +0200
In-Reply-To: <20190418113110.160664-1-borntraeger@de.ibm.com>
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190418113110.160664-9-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 08/10] s390x/cpumodel: add gen15 defintions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

add several new features (msa9, sort, deflate, additional vector
instructions, new general purpose instructions) to generation 15.

Also disable csske and bpb from the default model. This will allow to
migrate generation 15 machines to future machines that do not have these
features.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c  |  4 ++++
 target/s390x/gen-features.c | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3415948b2c..d7a9e487e0 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -594,6 +594,10 @@ static inline void s390_machine_initfn(Object *obj)
             " to upper case) to pass to machine loader, boot manager,"
             " and guest kernel",
             NULL);
+
+    /* deprecated functionality for gen15 and later */
+    s390_cpudef_featoff_greater(15, 1, S390_FEAT_BPB);
+    s390_cpudef_featoff_greater(15, 1, S390_FEAT_CONDITIONAL_SSKE);
 }
 
 static const TypeInfo ccw_machine_info = {
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 170226d3dd..4cf5a21cc1 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -418,6 +418,10 @@ static uint16_t base_GEN14_GA1[] = {
 
 #define base_GEN14_GA2 EmptyFeat
 
+static uint16_t base_GEN15_GA1[] = {
+    S390_FEAT_MISC_INSTRUCTION_EXT3,
+};
+
 /* Full features (in order of release)
  * Automatically includes corresponding base features.
  * Full features are all features this hardware supports even if kvm/QEMU do not
@@ -547,6 +551,16 @@ static uint16_t full_GEN14_GA1[] = {
 
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
@@ -623,6 +637,16 @@ static uint16_t default_GEN14_GA1[] = {
 
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
@@ -739,6 +763,7 @@ static CpuFeatDefSpec CpuFeatDef[] = {
     CPU_FEAT_INITIALIZER(GEN13_GA2),
     CPU_FEAT_INITIALIZER(GEN14_GA1),
     CPU_FEAT_INITIALIZER(GEN14_GA2),
+    CPU_FEAT_INITIALIZER(GEN15_GA1),
 };
 
 #define FEAT_GROUP_INITIALIZER(_name)                  \
-- 
2.19.1
