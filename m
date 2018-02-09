Received: from eggs.gnu.org ([2001:4830:134:3::10]:43638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wZ-0002He-Fe
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wY-0006D0-FN
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:07 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:13 +0100
Message-Id: <20180209092524.31348-19-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 18/29] s390x/kvm: cache the kvm flic in a
 central function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

This avoids tons of conversions when handling interrupts.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180129125623.21729-18-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/intc/s390_flic_kvm.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index d277ffdd2e..3f804ad52e 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -35,6 +35,17 @@ typedef struct KVMS390FLICState {
     bool clear_io_supported;
 } KVMS390FLICState;
 
+static KVMS390FLICState *s390_get_kvm_flic(S390FLICState *fs)
+{
+    static KVMS390FLICState *flic;
+
+    if (!flic) {
+        /* we only have one flic device, so this is fine to cache */
+        flic = KVM_S390_FLIC(fs);
+    }
+    return flic;
+}
+
 /**
  * flic_get_all_irqs - store all pending irqs in buffer
  * @buf: pointer to buffer which is passed to kernel
@@ -117,7 +128,7 @@ static void kvm_s390_inject_flic(S390FLICState *fs, struct kvm_s390_irq *irq)
     int r;
 
     if (use_flic) {
-        r = flic_enqueue_irqs(irq, sizeof(*irq), KVM_S390_FLIC(fs));
+        r = flic_enqueue_irqs(irq, sizeof(*irq), s390_get_kvm_flic(fs));
         if (r == -ENOSYS) {
             use_flic = false;
         }
@@ -174,7 +185,7 @@ static void kvm_s390_inject_crw_mchk(S390FLICState *fs)
 static int kvm_s390_clear_io_flic(S390FLICState *fs, uint16_t subchannel_id,
                            uint16_t subchannel_nr)
 {
-    KVMS390FLICState *flic = KVM_S390_FLIC(fs);
+    KVMS390FLICState *flic = s390_get_kvm_flic(fs);
     int rc;
     uint32_t sid = subchannel_id << 16 | subchannel_nr;
     struct kvm_device_attr attr = {
@@ -192,7 +203,7 @@ static int kvm_s390_clear_io_flic(S390FLICState *fs, uint16_t subchannel_id,
 static int kvm_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
                                     uint16_t mode)
 {
-    KVMS390FLICState *flic = KVM_S390_FLIC(fs);
+    KVMS390FLICState *flic = s390_get_kvm_flic(fs);
     struct kvm_s390_ais_req req = {
         .isc = isc,
         .mode = mode,
@@ -212,7 +223,7 @@ static int kvm_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
 static int kvm_s390_inject_airq(S390FLICState *fs, uint8_t type,
                                 uint8_t isc, uint8_t flags)
 {
-    KVMS390FLICState *flic = KVM_S390_FLIC(fs);
+    KVMS390FLICState *flic = s390_get_kvm_flic(fs);
     uint32_t id = css_get_adapter_id(type, isc);
     struct kvm_device_attr attr = {
         .group = KVM_DEV_FLIC_AIRQ_INJECT,
@@ -301,7 +312,7 @@ static int kvm_s390_io_adapter_map(S390FLICState *fs, uint32_t id,
         .group = KVM_DEV_FLIC_ADAPTER_MODIFY,
         .addr = (uint64_t)&req,
     };
-    KVMS390FLICState *flic = KVM_S390_FLIC(fs);
+    KVMS390FLICState *flic = s390_get_kvm_flic(fs);
     int r;
 
     if (!kvm_gsi_routing_enabled()) {
-- 
2.13.6
