Received: from eggs.gnu.org ([209.51.188.92]:49169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gsENO-0001EV-Ju
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 17:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gsENM-0007Fo-OD
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 17:12:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gsENK-0007EY-Md
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 17:12:00 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x18MAJ1V030731
	for <qemu-devel@nongnu.org>; Fri, 8 Feb 2019 17:11:55 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qheny8wm5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 17:11:55 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Fri, 8 Feb 2019 22:11:54 -0000
From: Collin Walling <walling@linux.ibm.com>
Date: Fri,  8 Feb 2019 17:11:10 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190208221111.25237-1-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 1/2] s390x/cpumodel: default enable mepoch for
 z14 and later
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

Latest systems and host kernels support mepoch, which is a
feature that was meant to be supported for z14 GA1 from the
get-go. Let's copy it to the z14 GA1 default CPU model.

Machines s390-ccw-virtio-3.1 and older will retain the old CPU
models and will not provide this bit in the default model.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c  | 1 +
 target/s390x/gen-features.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fd9d0b0542..32c5027345 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -757,6 +757,7 @@ DEFINE_CCW_MACHINE(4_0, "4.0", true);
 static void ccw_machine_3_1_instance_options(MachineState *machine)
 {
     ccw_machine_4_0_instance_options(machine);
+    s390_cpudef_featoff_greater(14, 1, S390_FEAT_MULTIPLE_EPOCH);
 }
 
 static void ccw_machine_3_1_class_options(MachineClass *mc)
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 70015eaaf5..d258d67dca 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -550,6 +550,7 @@ static uint16_t default_GEN14_GA1[] = {
     S390_FEAT_GROUP_MSA_EXT_6,
     S390_FEAT_GROUP_MSA_EXT_7,
     S390_FEAT_GROUP_MSA_EXT_8,
+    S390_FEAT_MULTIPLE_EPOCH,
 };
 
 /* QEMU (CPU model) features */
-- 
2.20.1
