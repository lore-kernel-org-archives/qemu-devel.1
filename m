Received: from eggs.gnu.org ([2001:4830:134:3::10]:46239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwQXj-000507-7F
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwQXf-0003Th-Fx
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:23:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46904
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dwQXf-0003TA-9N
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:23:11 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8PAJdNE107612
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 06:23:08 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d6wak26xx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 06:23:08 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 25 Sep 2017 11:23:06 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 25 Sep 2017 12:23:02 +0200
In-Reply-To: <20170925102302.60587-1-borntraeger@de.ibm.com>
References: <20170925102302.60587-1-borntraeger@de.ibm.com>
Message-Id: <20170925102302.60587-3-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] s390/kvm: Support for get/set of extended
 TOD-Clock for guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: "Collin L. Walling" <walling@linux.vnet.ibm.com>

Provides an interface for getting and setting the guest's extended
TOD-Clock via a single ioctl to kvm. If the ioctl fails because it
is not support by kvm, then we fall back to the old style of
retrieving the clock via two ioctls.

If kvm fails to set a nonzero epoch index, then we ultimately fail
the migration altogether and the guest will resume normally on the
original host machine.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c |  8 +++-----
 target/s390x/cpu.c         | 26 +++++++++++++++++++-------
 target/s390x/kvm-stub.c    | 10 ++++++++++
 target/s390x/kvm.c         | 35 +++++++++++++++++++++++++++++++++++
 target/s390x/kvm_s390x.h   |  2 ++
 5 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fafbc6d..bad09f5 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -213,13 +213,11 @@ static int gtod_load(QEMUFile *f, void *opaque, int version_id)
 
     r = s390_set_clock(&tod_high, &tod_low);
     if (r) {
-        warn_report("Unable to set guest clock for migration: %s",
-                    strerror(-r));
-        error_printf("Guest clock will not be restored "
-                     "which could cause the guest to hang.");
+        error_report("Unable to set guest clock value. "
+                     "s390_get_clock returned error %d.\n", r);
     }
 
-    return 0;
+    return r;
 }
 
 static SaveVMHandlers savevm_gtod = {
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 34538c3..c8f1219 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -357,22 +357,34 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
 
 int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
 {
+    int r = 0;
+
     if (kvm_enabled()) {
-        return kvm_s390_get_clock(tod_high, tod_low);
+        r = kvm_s390_get_clock_ext(tod_high, tod_low);
+        if (r == -ENXIO) {
+            return kvm_s390_get_clock(tod_high, tod_low);
+        }
+    } else {
+        /* Fixme TCG */
+        *tod_high = 0;
+        *tod_low = 0;
     }
-    /* Fixme TCG */
-    *tod_high = 0;
-    *tod_low = 0;
-    return 0;
+
+    return r;
 }
 
 int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
 {
+    int r = 0;
+
     if (kvm_enabled()) {
-        return kvm_s390_set_clock(tod_high, tod_low);
+        r = kvm_s390_set_clock_ext(tod_high, tod_low);
+        if (r == -ENXIO) {
+            return kvm_s390_set_clock(tod_high, tod_low);
+        }
     }
     /* Fixme TCG */
-    return 0;
+    return r;
 }
 
 int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit)
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index 261e1cd..43f02c2 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -68,11 +68,21 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
     return -ENOSYS;
 }
 
+int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
+{
+    return -ENOSYS;
+}
+
 int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
 {
     return -ENOSYS;
 }
 
+int kvm_s390_set_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
+{
+    return -ENOSYS;
+}
+
 void kvm_s390_enable_css_support(S390CPU *cpu)
 {
 }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index ebb75ca..ef7374c 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -643,6 +643,25 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
     return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
 }
 
+int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
+{
+    int r;
+
+    struct kvm_s390_vm_tod_clock gtod;
+
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_TOD,
+        .attr = KVM_S390_VM_TOD_EXT,
+        .addr = (uint64_t)(&gtod),
+    };
+
+    r = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+    *tod_high = gtod.epoch_idx;
+    *tod_low  = gtod.tod;
+
+    return r;
+}
+
 int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
 {
     int r;
@@ -663,6 +682,22 @@ int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
+int kvm_s390_set_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
+{
+    struct kvm_s390_vm_tod_clock gtod = {
+        .epoch_idx = *tod_high,
+        .tod  = *tod_low,
+    };
+
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_TOD,
+        .attr = KVM_S390_VM_TOD_EXT,
+        .addr = (uint64_t)(&gtod),
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
+}
+
 /**
  * kvm_s390_mem_op:
  * @addr:      the logical start address in guest memory
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 2d594bd..501fc5a 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -29,7 +29,9 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
 int kvm_s390_get_ri(void);
 int kvm_s390_get_gs(void);
 int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
+int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_clock);
+int kvm_s390_set_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
 void kvm_s390_enable_css_support(S390CPU *cpu);
 int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
-- 
2.9.4
