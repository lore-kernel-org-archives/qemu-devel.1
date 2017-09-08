Received: from eggs.gnu.org ([2001:4830:134:3::10]:49216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK8B-0006sp-7J
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK89-0005G3-Qq
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dqK89-0005FL-HL
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:37 -0400
Date: Fri, 8 Sep 2017 17:19:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1504880304-12069-15-git-send-email-mst@redhat.com>
References: <1504880304-12069-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1504880304-12069-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/17] vmgenid: replace
 x-write-pointer-available hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This compat property sole function is to prevent the device from being
instantiated. Instead of requiring an extra compat property, check if
fw_cfg has DMA enabled.

fw_cfg is a built-in device that is initialized very early by the
machine init code.  We have at least one other device that also
assumes fw_cfg_find() can be safely used on realize: pvpanic.

This has the additional benefit of handling other cases properly, like:

  $ qemu-system-x86_64 -device vmgenid -machine none
  qemu-system-x86_64: -device vmgenid: vmgenid requires DMA write support=
 in fw_cfg, which this machine type does not provide
  $ qemu-system-x86_64 -device vmgenid -machine pc-i440fx-2.9 -global fw_=
cfg.dma_enabled=3Doff
  qemu-system-x86_64: -device vmgenid: vmgenid requires DMA write support=
 in fw_cfg, which this machine type does not provide
  $ qemu-system-x86_64 -device vmgenid -machine pc-i440fx-2.6 -global fw_=
cfg.dma_enabled=3Don
  [boots normally]

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Ben Warren <ben@skyportsystems.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/bios-linker-loader.h |  2 ++
 include/hw/acpi/vmgenid.h            |  1 -
 include/hw/compat.h                  |  4 ----
 hw/acpi/bios-linker-loader.c         | 10 ++++++++++
 hw/acpi/vmgenid.c                    |  9 +--------
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/hw/acpi/bios-linker-loader.h b/include/hw/acpi/bios-=
linker-loader.h
index efe17b0..a711dbc 100644
--- a/include/hw/acpi/bios-linker-loader.h
+++ b/include/hw/acpi/bios-linker-loader.h
@@ -7,6 +7,8 @@ typedef struct BIOSLinker {
     GArray *file_list;
 } BIOSLinker;
=20
+bool bios_linker_loader_can_write_pointer(void);
+
 BIOSLinker *bios_linker_loader_init(void);
=20
 void bios_linker_loader_alloc(BIOSLinker *linker,
diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index 7beb959..38586ec 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -21,7 +21,6 @@ typedef struct VmGenIdState {
     DeviceClass parent_obj;
     QemuUUID guid;                /* The 128-bit GUID seen by the guest =
*/
     uint8_t vmgenid_addr_le[8];   /* Address of the GUID (little-endian)=
 */
-    bool write_pointer_available;
 } VmGenIdState;
=20
 /* returns NULL unless there is exactly one device */
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 3e101f8..9cc14dd 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -153,10 +153,6 @@
         .driver   =3D "fw_cfg_io",\
         .property =3D "dma_enabled",\
         .value    =3D "off",\
-    },{\
-        .driver   =3D "vmgenid",\
-        .property =3D "x-write-pointer-available",\
-        .value    =3D "off",\
     },
=20
 #define HW_COMPAT_2_3 \
diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
index 046183a..d16b8bb 100644
--- a/hw/acpi/bios-linker-loader.c
+++ b/hw/acpi/bios-linker-loader.c
@@ -169,6 +169,16 @@ bios_linker_find_file(const BIOSLinker *linker, cons=
t char *name)
 }
=20
 /*
+ * board code must realize fw_cfg first, as a fixed device, before
+ * another device realize function call bios_linker_loader_can_write_poi=
nter()
+ */
+bool bios_linker_loader_can_write_pointer(void)
+{
+    FWCfgState *fw_cfg =3D fw_cfg_find();
+    return fw_cfg && fw_cfg_dma_enabled(fw_cfg);
+}
+
+/*
  * bios_linker_loader_alloc: ask guest to load file into guest memory.
  *
  * @linker: linker object instance
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 876723a..2876d8a 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -205,17 +205,11 @@ static void vmgenid_handle_reset(void *opaque)
     memset(vms->vmgenid_addr_le, 0, ARRAY_SIZE(vms->vmgenid_addr_le));
 }
=20
-static Property vmgenid_properties[] =3D {
-    DEFINE_PROP_BOOL("x-write-pointer-available", VmGenIdState,
-                     write_pointer_available, true),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void vmgenid_realize(DeviceState *dev, Error **errp)
 {
     VmGenIdState *vms =3D VMGENID(dev);
=20
-    if (!vms->write_pointer_available) {
+    if (!bios_linker_loader_can_write_pointer()) {
         error_setg(errp, "%s requires DMA write support in fw_cfg, "
                    "which this machine type does not provide", VMGENID_D=
EVICE);
         return;
@@ -239,7 +233,6 @@ static void vmgenid_device_class_init(ObjectClass *kl=
ass, void *data)
     dc->vmsd =3D &vmstate_vmgenid;
     dc->realize =3D vmgenid_realize;
     dc->hotpluggable =3D false;
-    dc->props =3D vmgenid_properties;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
=20
     object_class_property_add_str(klass, VMGENID_GUID, NULL,
--=20
MST
