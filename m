Received: from eggs.gnu.org ([2001:4830:134:3::10]:46563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebri4-0008B5-LA
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebri2-0007DU-Ed
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:41:12 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 17 Jan 2018 18:40:31 +0100
Message-Id: <20180117174047.6382-3-david@redhat.com>
In-Reply-To: <20180117174047.6382-1-david@redhat.com>
References: <20180117174047.6382-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/18] s390x/flic: simplify flic
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

This makes it clearer, which device is used for which accelerator.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/intc/s390_flic.c          |  7 +++++--
 hw/intc/s390_flic_kvm.c      | 12 ------------
 include/hw/s390x/s390_flic.h |  9 ---------
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 6eaf178d79..fc244fe775 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -40,8 +40,11 @@ void s390_flic_init(void)
 {
     DeviceState *dev;
 
-    dev = s390_flic_kvm_create();
-    if (!dev) {
+    if (kvm_enabled()) {
+        dev = qdev_create(NULL, TYPE_KVM_S390_FLIC);
+        object_property_add_child(qdev_get_machine(), TYPE_KVM_S390_FLIC,
+                                  OBJECT(dev), NULL);
+    } else {
         dev = qdev_create(NULL, TYPE_QEMU_S390_FLIC);
         object_property_add_child(qdev_get_machine(), TYPE_QEMU_S390_FLIC,
                                   OBJECT(dev), NULL);
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index d208cb81c4..0cb5feab0c 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -35,18 +35,6 @@ typedef struct KVMS390FLICState {
     bool clear_io_supported;
 } KVMS390FLICState;
 
-DeviceState *s390_flic_kvm_create(void)
-{
-    DeviceState *dev = NULL;
-
-    if (kvm_enabled()) {
-        dev = qdev_create(NULL, TYPE_KVM_S390_FLIC);
-        object_property_add_child(qdev_get_machine(), TYPE_KVM_S390_FLIC,
-                                  OBJECT(dev), NULL);
-    }
-    return dev;
-}
-
 /**
  * flic_get_all_irqs - store all pending irqs in buffer
  * @buf: pointer to buffer which is passed to kernel
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 7aab6ef7f0..5b00e936fa 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -91,13 +91,4 @@ void s390_flic_init(void);
 S390FLICState *s390_get_flic(void);
 bool ais_needed(void *opaque);
 
-#ifdef CONFIG_KVM
-DeviceState *s390_flic_kvm_create(void);
-#else
-static inline DeviceState *s390_flic_kvm_create(void)
-{
-    return NULL;
-}
-#endif
-
 #endif /* HW_S390_FLIC_H */
-- 
2.14.3
