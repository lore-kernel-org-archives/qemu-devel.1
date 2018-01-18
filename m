Received: from eggs.gnu.org ([2001:4830:134:3::10]:35387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ec5zy-0003BG-RE
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ec5zw-0005Dj-9i
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:56:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47102
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ec5zw-0005Cj-16
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:56:36 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0I8sVH8005300
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 03:56:34 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fjqqmjc3k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 03:56:34 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 18 Jan 2018 08:56:32 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 18 Jan 2018 09:56:28 +0100
In-Reply-To: <20180118085628.40798-1-borntraeger@de.ibm.com>
References: <20180118085628.40798-1-borntraeger@de.ibm.com>
Message-Id: <20180118085628.40798-4-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v3 3/3] s390x/kvm: provide stfle.81
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

stfle.81 (ppa15) is a transparent facility that can be passed to the
guest without the need to implement hypervisor support. As this feature
can be provided by firmware we add it to all full models.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu_features.c     | 1 +
 target/s390x/cpu_features_def.h | 1 +
 target/s390x/gen-features.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 5d1c210..be72aec 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -89,6 +89,7 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("msa4-base", S390_FEAT_TYPE_STFL, 77, "Message-security-assist-extension-4 facility (excluding subfunctions)"),
     FEAT_INIT("edat2", S390_FEAT_TYPE_STFL, 78, "Enhanced-DAT facility 2"),
     FEAT_INIT("dfppc", S390_FEAT_TYPE_STFL, 80, "Decimal-floating-point packed-conversion facility"),
+    FEAT_INIT("ppa15", S390_FEAT_TYPE_STFL, 81, "PPA15 is installed"),
     FEAT_INIT("bpb", S390_FEAT_TYPE_STFL, 82, "Branch Prediction Blocking"),
     FEAT_INIT("vx", S390_FEAT_TYPE_STFL, 129, "Vector facility"),
     FEAT_INIT("iep", S390_FEAT_TYPE_STFL, 130, "Instruction-execution-protection facility"),
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 4487cfd..4d93087 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -80,6 +80,7 @@ typedef enum {
     S390_FEAT_MSA_EXT_4,
     S390_FEAT_EDAT_2,
     S390_FEAT_DFP_PACKED_CONVERSION,
+    S390_FEAT_PPA15,
     S390_FEAT_BPB,
     S390_FEAT_VECTOR,
     S390_FEAT_INSTRUCTION_EXEC_PROT,
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 563aced..0570f59 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -352,6 +352,7 @@ static uint16_t base_GEN14_GA1[] = {
  * support these features yet.
  */
 static uint16_t full_GEN7_GA1[] = {
+    S390_FEAT_PPA15,
     S390_FEAT_BPB,
     S390_FEAT_SIE_F2,
     S390_FEAT_SIE_SKEY,
-- 
2.9.4
