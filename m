Received: from eggs.gnu.org ([2001:4830:134:3::10]:56508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cpvyk-0003uG-V8
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cpvyi-0000Nb-RA
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:00:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cpvyi-0000My-Il
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:00:00 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Mon, 20 Mar 2017 12:59:50 +0100
Message-Id: <20170320115951.25345-2-lersek@redhat.com>
In-Reply-To: <20170320115951.25345-1-lersek@redhat.com>
References: <20170320115951.25345-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] hw/acpi/vmgenid: prevent device
 realization on pre-2.9 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>

The WRITE_POINTER linker/loader command that underlies VMGENID depends on
commit baf2d5bfbac0 ("fw-cfg: support writeable blobs", 2017-01-12). That
commit is not available in 2.8.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 include/hw/acpi/vmgenid.h |  1 +
 include/hw/compat.h       |  4 ++++
 hw/acpi/vmgenid.c         | 14 ++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index db7fa0e63303..8578476baebe 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -21,6 +21,7 @@ typedef struct VmGenIdState {
     DeviceClass parent_obj;
     QemuUUID guid;                /* The 128-bit GUID seen by the guest */
     uint8_t vmgenid_addr_le[8];   /* Address of the GUID (little-endian) */
+    bool write_pointer_available;
 } VmGenIdState;
 
 static inline Object *find_vmgenid_dev(void)
diff --git a/include/hw/compat.h b/include/hw/compat.h
index fc8c3e060007..c9caa8cd1bdd 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -42,6 +42,10 @@
         .driver   = "isa-cirrus-vga",\
         .property = "vgamem_mb",\
         .value    = "8",\
+    },{\
+        .driver   = "vmgenid",\
+        .property = "x-write-pointer-available",\
+        .value    = "off",\
     },
 
 #define HW_COMPAT_2_7 \
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 7a3ad17d66ef..c3ddcc8e7cb0 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -205,9 +205,22 @@ static void vmgenid_handle_reset(void *opaque)
     memset(vms->vmgenid_addr_le, 0, ARRAY_SIZE(vms->vmgenid_addr_le));
 }
 
+static Property vmgenid_properties[] = {
+    DEFINE_PROP_BOOL("x-write-pointer-available", VmGenIdState,
+                     write_pointer_available, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void vmgenid_realize(DeviceState *dev, Error **errp)
 {
     VmGenIdState *vms = VMGENID(dev);
+
+    if (!vms->write_pointer_available) {
+        error_setg(errp, "%s requires DMA write support in fw_cfg, "
+                   "which this machine type does not provide", VMGENID_DEVICE);
+        return;
+    }
+
     qemu_register_reset(vmgenid_handle_reset, vms);
 }
 
@@ -218,6 +231,7 @@ static void vmgenid_device_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_vmgenid;
     dc->realize = vmgenid_realize;
     dc->hotpluggable = false;
+    dc->props = vmgenid_properties;
 
     object_class_property_add_str(klass, VMGENID_GUID, NULL,
                                   vmgenid_set_guid, NULL);
-- 
2.9.3
