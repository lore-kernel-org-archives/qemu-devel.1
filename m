Received: from eggs.gnu.org ([2001:4830:134:3::10]:59275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PS0-0006qW-D1
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRw-0000EE-Al
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PRw-0000DM-2c
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:44 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:51 +0200
Message-Id: <20171006095956.27534-29-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 28/33] s390/kvm: Support for get/set of extended
 TOD-Clock for guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, "Collin L. Walling" <walling@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: "Collin L. Walling" <walling@linux.vnet.ibm.com>

Provides an interface for getting and setting the guest's extended
TOD-Clock via a single ioctl to kvm. If the ioctl fails because it
is not support by kvm, then we fall back to the old style of
retrieving the clock via two ioctls.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[split failure change from epoch index change]
Message-Id: <20171004105751.24655-2-borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
[some cosmetic fixes]
---
 target/s390x/cpu.c       | 26 +++++++++++++++++++-------
 target/s390x/kvm-stub.c  | 10 ++++++++++
 target/s390x/kvm.c       | 33 ++++++++++++++++++++++++++++++++-
 target/s390x/kvm_s390x.h |  2 ++
 4 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index f42e28ea25..4e1823a3e0 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -347,22 +347,34 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
 
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
index 261e1cdc44..43f02c2d69 100644
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
index 7f8c6c4993..d3700fc2c2 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -646,10 +646,26 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
     return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
 }
 
-int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
+int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
 {
     int r;
+    struct kvm_s390_vm_tod_clock gtod;
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_TOD,
+        .attr = KVM_S390_VM_TOD_EXT,
+        .addr = (uint64_t)&gtod,
+    };
+
+    r = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+    *tod_high = gtod.epoch_idx;
+    *tod_low  = gtod.tod;
 
+    return r;
+}
+
+int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
+{
+    int r;
     struct kvm_device_attr attr = {
         .group = KVM_S390_VM_TOD,
         .attr = KVM_S390_VM_TOD_LOW,
@@ -666,6 +682,21 @@ int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
+int kvm_s390_set_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
+{
+    struct kvm_s390_vm_tod_clock gtod = {
+        .epoch_idx = *tod_high,
+        .tod  = *tod_low,
+    };
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_TOD,
+        .attr = KVM_S390_VM_TOD_EXT,
+        .addr = (uint64_t)&gtod,
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
+}
+
 /**
  * kvm_s390_mem_op:
  * @addr:      the logical start address in guest memory
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 2d594bd4ee..501fc5aabd 100644
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
2.13.6
