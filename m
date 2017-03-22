Received: from eggs.gnu.org ([2001:4830:134:3::10]:35131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=0SF/=27=redhat.com=mst@kernel.org>)
	id 1cqihm-0002vk-Hd
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=0SF/=27=redhat.com=mst@kernel.org>)
	id 1cqihl-0007Ct-DI
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:46 -0400
Received: from mail.kernel.org ([198.145.29.136]:38758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=0SF/=27=redhat.com=mst@kernel.org>)
	id 1cqihl-0007CS-3Z
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:45 -0400
Date: Wed, 22 Mar 2017 18:01:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1490198476-12244-4-git-send-email-mst@redhat.com>
References: <1490198476-12244-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490198476-12244-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] hw/acpi/vmgenid: prevent device realization
 on pre-2.5 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Laszlo Ersek <lersek@redhat.com>

The WRITE_POINTER linker/loader command that underlies VMGENID depends on
commit baf2d5bfbac0 ("fw-cfg: support writeable blobs", 2017-01-12), which
in turn depends on fw_cfg DMA.

DMA for fw_cfg is enabled in 2.5+ machine types only (see commit
e6915b5f3a87, "fw_cfg: unbreak migration compatibility for 2.4 and earlier
machines", 2016-02-18).

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/vmgenid.h |  1 +
 include/hw/compat.h       |  4 ++++
 hw/acpi/vmgenid.c         | 14 ++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index db7fa0e..8578476 100644
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
index fc8c3e0..5d5be91 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -131,6 +131,10 @@
         .driver   = "fw_cfg_io",\
         .property = "dma_enabled",\
         .value    = "off",\
+    },{\
+        .driver   = "vmgenid",\
+        .property = "x-write-pointer-available",\
+        .value    = "off",\
     },
 
 #define HW_COMPAT_2_3 \
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 7a3ad17..c3ddcc8 100644
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
MST
