Received: from eggs.gnu.org ([2001:4830:134:3::10]:55423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dY9cN-0004t8-Qa
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dY9cK-0001NC-JX
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:27:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50376
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dY9cK-0001M5-ER
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:27:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6KBOIDM045770
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 07:27:38 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2btpr84ybs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 07:27:37 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 20 Jul 2017 12:27:35 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 20 Jul 2017 13:27:31 +0200
In-Reply-To: <1500550051-7821-1-git-send-email-borntraeger@de.ibm.com>
References: <1500550051-7821-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500550051-7821-2-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] s390/cpumodel: remove KSS from the default
 model of z14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

The SIE_KSS feature will allow a guest to use KSS for a nested guest.
To create a nested guest the SIE_F2 facility is still necessary.
Since SIE_F2 is not part of the default model it does not make
a lot of sense to provide the SIE_KSS feature in the default model.
Let's also create a dependency check.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 target/s390x/cpu_models.c   | 1 +
 target/s390x/gen-features.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index f4e5bb6..d91b7b8 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -723,6 +723,7 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_KLMD_SHAKE_256, S390_FEAT_MSA },
         { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
         { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
+        { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
     };
     int i;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index cf69157..c8dc104 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -535,7 +535,6 @@ static uint16_t default_GEN14_GA1[] = {
     S390_FEAT_GROUP_MSA_EXT_6,
     S390_FEAT_GROUP_MSA_EXT_7,
     S390_FEAT_GROUP_MSA_EXT_8,
-    S390_FEAT_SIE_KSS,
 };
 
 /****** END FEATURE DEFS ******/
-- 
2.7.4
