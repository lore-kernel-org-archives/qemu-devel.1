Received: from eggs.gnu.org ([2001:4830:134:3::10]:33814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYAk6-0006GY-CD
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYAk4-0005Ao-Gq
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:44:18 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 27 Jun 2018 15:44:03 +0200
Message-Id: <20180627134410.4901-3-david@redhat.com>
In-Reply-To: <20180627134410.4901-1-david@redhat.com>
References: <20180627134410.4901-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/9] s390x/kvm: pass values instead of
 pointers to kvm_s390_set_clock_*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

We are going to factor out the TOD into a separate device and use const
pointers for device class functions where possible. We are passing right
now ordinary pointers that should never be touched when setting the TOD.
Let's just pass the values directly.

Note that s390_set_clock() will be removed in a follow-on patch and
therefore its calling convention is not changed.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.c       |  4 ++--
 target/s390x/kvm-stub.c  |  4 ++--
 target/s390x/kvm.c       | 12 ++++++------
 target/s390x/kvm_s390x.h |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index c268065887..68512e3e54 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -413,9 +413,9 @@ int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
     int r = 0;
 
     if (kvm_enabled()) {
-        r = kvm_s390_set_clock_ext(tod_high, tod_low);
+        r = kvm_s390_set_clock_ext(*tod_high, *tod_low);
         if (r == -ENXIO) {
-            return kvm_s390_set_clock(tod_high, tod_low);
+            return kvm_s390_set_clock(*tod_high, *tod_low);
         }
     }
     /* Fixme TCG */
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index 29b10542cc..bf7795e47a 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -60,12 +60,12 @@ int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
     return -ENOSYS;
 }
 
-int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
+int kvm_s390_set_clock(uint8_t tod_high, uint64_t tod_low)
 {
     return -ENOSYS;
 }
 
-int kvm_s390_set_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
+int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_low)
 {
     return -ENOSYS;
 }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index ac370da281..8bcd832123 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -666,13 +666,13 @@ int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
     return r;
 }
 
-int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
+int kvm_s390_set_clock(uint8_t tod_high, uint64_t tod_low)
 {
     int r;
     struct kvm_device_attr attr = {
         .group = KVM_S390_VM_TOD,
         .attr = KVM_S390_VM_TOD_LOW,
-        .addr = (uint64_t)tod_low,
+        .addr = (uint64_t)&tod_low,
     };
 
     r = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
@@ -681,15 +681,15 @@ int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
     }
 
     attr.attr = KVM_S390_VM_TOD_HIGH;
-    attr.addr = (uint64_t)tod_high;
+    attr.addr = (uint64_t)&tod_high;
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
-int kvm_s390_set_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
+int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_low)
 {
     struct kvm_s390_vm_tod_clock gtod = {
-        .epoch_idx = *tod_high,
-        .tod  = *tod_low,
+        .epoch_idx = tod_high,
+        .tod  = tod_low,
     };
     struct kvm_device_attr attr = {
         .group = KVM_S390_VM_TOD,
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index c383bf4ee9..36eb34bf99 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -25,8 +25,8 @@ int kvm_s390_get_ri(void);
 int kvm_s390_get_gs(void);
 int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
-int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_clock);
-int kvm_s390_set_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
+int kvm_s390_set_clock(uint8_t tod_high, uint64_t tod_clock);
+int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_clock);
 void kvm_s390_enable_css_support(S390CPU *cpu);
 int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
-- 
2.17.1
