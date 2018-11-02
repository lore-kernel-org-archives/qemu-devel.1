Received: from eggs.gnu.org ([2001:4830:134:3::10]:39684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gIWj6-0001so-4e
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gIWj3-0004I6-3s
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60134
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gIWj2-0004BO-Rs
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA2ATg7d031795
	for <qemu-devel@nongnu.org>; Fri, 2 Nov 2018 06:30:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nghj988x5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 06:30:36 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 2 Nov 2018 10:30:33 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri,  2 Nov 2018 11:30:20 +0100
In-Reply-To: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
References: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1541154621-22423-5-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v1 4/5] s390x/vfio: ap: Intercepting AP Queue
 Interrupt Control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

From: Pierre Morel <pmorel@linux.vnet.ibm.com>

We intercept the PQAP(AQIC) instruction.

Until we implement AQIC we return a PGM_OPERATION.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 hw/vfio/ap.c                 | 10 ++++++++++
 include/hw/s390x/ap-device.h |  9 +++++++++
 target/s390x/kvm.c           | 20 ++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 3962bb74e5..d8d9cadc46 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -38,6 +38,16 @@ typedef struct VFIOAPDevice {
 #define VFIO_AP_DEVICE(obj) \
         OBJECT_CHECK(VFIOAPDevice, (obj), VFIO_AP_DEVICE_TYPE)
 
+/*
+ * ap_pqap
+ * @env: environment pointing to registers
+ * return value: Code Condition
+ */
+int ap_pqap(CPUS390XState *env)
+{
+    return -PGM_OPERATION;
+}
+
 static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
 {
     vdev->needs_reset = false;
diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
index 765e9082a3..a83ea096c7 100644
--- a/include/hw/s390x/ap-device.h
+++ b/include/hw/s390x/ap-device.h
@@ -19,4 +19,13 @@ typedef struct APDevice {
 #define AP_DEVICE(obj) \
     OBJECT_CHECK(APDevice, (obj), AP_DEVICE_TYPE)
 
+#define AP_DEVICE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(APDeviceClass, (obj), AP_DEVICE_TYPE)
+
+#define AP_DEVICE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(APDeviceClass, (klass), AP_DEVICE_TYPE)
+
+#include "cpu.h"
+int ap_pqap(CPUS390XState *env);
+
 #endif /* HW_S390X_AP_DEVICE_H */
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 2ebf26adfe..3eac59549d 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -45,6 +45,7 @@
 #include "trace.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
+#include "hw/s390x/ap-device.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/ebcdic.h"
 #include "exec/memattrs.h"
@@ -88,6 +89,7 @@
 #define PRIV_B2_CHSC                    0x5f
 #define PRIV_B2_SIGA                    0x74
 #define PRIV_B2_XSCH                    0x76
+#define PRIV_B2_PQAP                    0xaf
 
 #define PRIV_EB_SQBS                    0x8a
 #define PRIV_EB_PCISTB                  0xd0
@@ -1154,6 +1156,21 @@ static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
     return 0;
 }
 
+static int kvm_ap_pqap(S390CPU *cpu, uint16_t ipbh0)
+{
+    int r;
+
+    r = ap_pqap(&cpu->env);
+
+    if (r < 0) {
+        kvm_s390_program_interrupt(cpu, -r);
+    } else {
+        setcc(cpu, r);
+    }
+
+    return 0;
+}
+
 static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
 {
     CPUS390XState *env = &cpu->env;
@@ -1216,6 +1233,9 @@ static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
     case PRIV_B2_SCLP_CALL:
         rc = kvm_sclp_service_call(cpu, run, ipbh0);
         break;
+    case PRIV_B2_PQAP:
+        rc = kvm_ap_pqap(cpu, ipbh0);
+        break;
     default:
         rc = -1;
         DPRINTF("KVM: unhandled PRIV: 0xb2%x\n", ipa1);
-- 
2.17.0
