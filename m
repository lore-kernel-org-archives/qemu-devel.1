Received: from eggs.gnu.org ([2001:4830:134:3::10]:47276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIb3Y-0002Rq-5r
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIb3O-0008NN-AG
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:36:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59340 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fIb3O-0008N9-4N
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:35:50 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 15 May 2018 16:35:48 +0200
Message-Id: <20180515143548.29841-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] memory: get rid of
 memory_region_init_reservation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The function has been deprecated for 2.5 years, and there are just a handful
of users.  Convert them to memory_region_init_io with NULL callbacks,
and while at it pass the right device as the owner.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/memory.txt |  5 ++---
 hw/i386/kvm/i8254.c   |  2 +-
 hw/i386/kvm/i8259.c   |  4 ++--
 hw/i386/kvm/ioapic.c  |  2 +-
 include/exec/memory.h | 23 -----------------------
 5 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/docs/devel/memory.txt b/docs/devel/memory.txt
index 8ed810f8b9..c1dee1252c 100644
--- a/docs/devel/memory.txt
+++ b/docs/devel/memory.txt
@@ -77,9 +77,8 @@ MemoryRegion):
 - reservation region: a reservation region is primarily for debugging.
   It claims I/O space that is not supposed to be handled by QEMU itself.
   The typical use is to track parts of the address space which will be
-  handled by the host kernel when KVM is enabled.
-  You initialize these with memory_region_init_reservation(), or by
-  passing a NULL callback parameter to memory_region_init_io().
+  handled by the host kernel when KVM is enabled.  You initialize these
+  by passing a NULL callback parameter to memory_region_init_io().
 
 It is valid to add subregions to a region which is not a pure container
 (that is, to an MMIO, RAM or ROM region). This means that the region
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 13f20f47d9..b11c5cf9b8 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -293,7 +293,7 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_init_reservation(&pit->ioports, NULL, "kvm-pit", 4);
+    memory_region_init_io(&pit->ioports, OBJECT(dev), NULL, "kvm-pit", 4);
 
     qdev_init_gpio_in(dev, kvm_pit_irq_control, 1);
 
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 05394cdb7b..73e005dd98 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -121,8 +121,8 @@ static void kvm_pic_realize(DeviceState *dev, Error **errp)
     PICCommonState *s = PIC_COMMON(dev);
     KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
 
-    memory_region_init_reservation(&s->base_io, NULL, "kvm-pic", 2);
-    memory_region_init_reservation(&s->elcr_io, NULL, "kvm-elcr", 1);
+    memory_region_init_io(&s->base_io, OBJECT(dev), NULL, "kvm-pic", 2);
+    memory_region_init_io(&s->elcr_io, OBJECT(dev), NULL, "kvm-elcr", 1);
 
     kpc->parent_realize(dev, errp);
 }
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 98ca480792..ee68553444 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -142,7 +142,7 @@ static void kvm_ioapic_realize(DeviceState *dev, Error **errp)
 {
     IOAPICCommonState *s = IOAPIC_COMMON(dev);
 
-    memory_region_init_reservation(&s->io_memory, NULL, "kvm-ioapic", 0x1000);
+    memory_region_init_io(&s->io_memory, OBJECT(dev), NULL, "kvm-ioapic", 0x1000);
     /*
      * KVM ioapic only supports 0x11 now. This will only be used when
      * we want to dump ioapic version.
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4fa1227f13..a116d936fc 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -675,29 +675,6 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
                                              uint64_t size,
                                              Error **errp);
 
-/**
- * memory_region_init_reservation: Initialize a memory region that reserves
- *                                 I/O space.
- *
- * A reservation region primarily serves debugging purposes.  It claims I/O
- * space that is not supposed to be handled by QEMU itself.  Any access via
- * the memory API will cause an abort().
- * This function is deprecated. Use memory_region_init_io() with NULL
- * callbacks instead.
- *
- * @mr: the #MemoryRegion to be initialized
- * @owner: the object that tracks the region's reference count
- * @name: used for debugging; not visible to the user or ABI
- * @size: size of the region.
- */
-static inline void memory_region_init_reservation(MemoryRegion *mr,
-                                    Object *owner,
-                                    const char *name,
-                                    uint64_t size)
-{
-    memory_region_init_io(mr, owner, NULL, mr, name, size);
-}
-
 /**
  * memory_region_init_iommu: Initialize a memory region of a custom type
  * that translates addresses
-- 
2.17.0
