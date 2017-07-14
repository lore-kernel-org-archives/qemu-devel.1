Received: from eggs.gnu.org ([2001:4830:134:3::10]:55906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyOD-0007Xv-6K
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyOA-0003Xu-BL
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyOA-0003XT-2E
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:02 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EAwxsp047405
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:04:01 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpmft1qnt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:04:00 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:03:57 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:41:03 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-37-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 36/40] s390x/cpumodel: add esop/esop2 to z12
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

Add esop and esop2 features to z12 model where esop2 was originally
introduced. Disable esop and esop2 when using compatibility machine
v2.9 or earlier.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c  | 3 +++
 target/s390x/gen-features.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e484aed..657a45f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -30,6 +30,7 @@
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/css-bridge.h"
 #include "migration/register.h"
+#include "cpu_models.h"
 
 static const char *const reset_dev_types[] = {
     TYPE_VIRTUAL_CSS_BRIDGE,
@@ -503,6 +504,8 @@ DEFINE_CCW_MACHINE(2_10, "2.10", true);
 static void ccw_machine_2_9_instance_options(MachineState *machine)
 {
     ccw_machine_2_10_instance_options(machine);
+    s390_cpudef_featoff_greater(12, 1, S390_FEAT_ESOP);
+    s390_cpudef_featoff_greater(12, 1, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2);
     s390_cpudef_featoff_greater(12, 1, S390_FEAT_ZPCI);
     s390_cpudef_featoff_greater(12, 1, S390_FEAT_ADAPTER_INT_SUPPRESSION);
     s390_cpudef_featoff_greater(12, 1, S390_FEAT_ADAPTER_EVENT_NOTIFICATION);
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 33404e4..af14b11 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -429,6 +429,7 @@ static uint16_t full_GEN12_GA1[] = {
     S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
     S390_FEAT_ADAPTER_INT_SUPPRESSION,
     S390_FEAT_EDAT_2,
+    S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
 };
 
 static uint16_t full_GEN12_GA2[] = {
@@ -488,6 +489,8 @@ static uint16_t default_GEN12_GA1[] = {
     S390_FEAT_ZPCI,
     S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
     S390_FEAT_EDAT_2,
+    S390_FEAT_ESOP,
+    S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
 };
 
 #define default_GEN12_GA2 EmptyFeat
-- 
2.7.4
