Received: from eggs.gnu.org ([209.51.188.92]:60398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eM-0006xM-Ml
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eL-0001Wg-8g
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx5eK-0001MA-T5
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 437DD356EA
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 07:53:29 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 08:53:13 +0100
Message-Id: <20190222075326.9850-3-kraxel@redhat.com>
In-Reply-To: <20190222075326.9850-1-kraxel@redhat.com>
References: <20190222075326.9850-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/15] spice: set device address and device
 display ID in QXL interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>

From: Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD <lhrazky@redhat.com>

Calls the new SPICE QXL interface function spice_qxl_set_device_info to
set the hardware address of the graphics device represented by the QXL
interface (e.g. a PCI path) and the device display IDs (the IDs of the
device's monitors that belong to this QXL interface).

Also stops using the deprecated spice_qxl_set_max_monitors, the new
interface function replaces it.

Signed-off-by: Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD <lhrazky@redhat.com>
Message-Id: <20190215150919.8263-1-lhrazky@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/spice-display.h |  4 ++++
 hw/display/qxl.c           | 14 ++++++++++++-
 ui/spice-core.c            | 51 ++++++++++++++++++++++++++++++++++++++++=
++++++
 ui/spice-display.c         | 11 ++++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 87a84a59d4e0..53c3612c3202 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -179,3 +179,7 @@ void qemu_spice_wakeup(SimpleSpiceDisplay *ssd);
 void qemu_spice_display_start(void);
 void qemu_spice_display_stop(void);
 int qemu_spice_display_is_running(SimpleSpiceDisplay *ssd);
+
+bool qemu_spice_fill_device_address(QemuConsole *con,
+                                    char *device_address,
+                                    size_t size);
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index da8fd5a40a14..c8ce5781e037 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -276,7 +276,8 @@ static void qxl_spice_monitors_config_async(PCIQXLDev=
ice *qxl, int replay)
                     QXL_COOKIE_TYPE_POST_LOAD_MONITORS_CONFIG,
                     0));
     } else {
-#if SPICE_SERVER_VERSION >=3D 0x000c06 /* release 0.12.6 */
+/* >=3D release 0.12.6, < release 0.14.2 */
+#if SPICE_SERVER_VERSION >=3D 0x000c06 && SPICE_SERVER_VERSION < 0x000e0=
2
         if (qxl->max_outputs) {
             spice_qxl_set_max_monitors(&qxl->ssd.qxl, qxl->max_outputs);
         }
@@ -2188,6 +2189,17 @@ static void qxl_realize_common(PCIQXLDevice *qxl, =
Error **errp)
                    SPICE_INTERFACE_QXL_MAJOR, SPICE_INTERFACE_QXL_MINOR)=
;
         return;
     }
+
+#if SPICE_SERVER_VERSION >=3D 0x000e02 /* release 0.14.2 */
+    char device_address[256] =3D "";
+    if (qemu_spice_fill_device_address(qxl->vga.con, device_address, 256=
)) {
+        spice_qxl_set_device_info(&qxl->ssd.qxl,
+                                  device_address,
+                                  0,
+                                  qxl->max_outputs);
+    }
+#endif
+
     qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
=20
     qxl->update_irq =3D qemu_bh_new(qxl_update_irq_bh, qxl);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index a40fb2c00dab..37fae3c42405 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -34,6 +34,7 @@
 #include "qemu/option.h"
 #include "migration/misc.h"
 #include "hw/hw.h"
+#include "hw/pci/pci_bus.h"
 #include "ui/spice-display.h"
=20
 /* core bits */
@@ -863,6 +864,56 @@ bool qemu_spice_have_display_interface(QemuConsole *=
con)
     return false;
 }
=20
+/*
+ * Recursively (in reverse order) appends addresses of PCI devices as it=
 moves
+ * up in the PCI hierarchy.
+ *
+ * @returns true on success, false when the buffer wasn't large enough
+ */
+static bool append_pci_address(char *buf, size_t buf_size, const PCIDevi=
ce *pci)
+{
+    PCIBus *bus =3D pci_get_bus(pci);
+    /*
+     * equivalent to if (!pci_bus_is_root(bus)), but the function is not=
 built
+     * with PCI_CONFIG=3Dn, avoid using an #ifdef by checking directly
+     */
+    if (bus->parent_dev !=3D NULL) {
+        append_pci_address(buf, buf_size, bus->parent_dev);
+    }
+
+    size_t len =3D strlen(buf);
+    ssize_t written =3D snprintf(buf + len, buf_size - len, "/%02x.%x",
+        PCI_SLOT(pci->devfn), PCI_FUNC(pci->devfn));
+
+    return written > 0 && written < buf_size - len;
+}
+
+bool qemu_spice_fill_device_address(QemuConsole *con,
+                                    char *device_address,
+                                    size_t size)
+{
+    DeviceState *dev =3D DEVICE(object_property_get_link(OBJECT(con),
+                                                       "device",
+                                                       &error_abort));
+    PCIDevice *pci =3D (PCIDevice *) object_dynamic_cast(OBJECT(dev),
+                                                       TYPE_PCI_DEVICE);
+
+    if (pci =3D=3D NULL) {
+        warn_report("Setting device address of a display device to SPICE=
: "
+                    "Not a PCI device.");
+        return false;
+    }
+
+    strncpy(device_address, "pci/0000", size);
+    if (!append_pci_address(device_address, size, pci)) {
+        warn_report("Setting device address of a display device to SPICE=
: "
+            "Too many PCI devices in the chain.");
+        return false;
+    }
+
+    return true;
+}
+
 int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *co=
n)
 {
     if (g_slist_find(spice_consoles, con)) {
diff --git a/ui/spice-display.c b/ui/spice-display.c
index aea6f6ebceda..a5e26479a866 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1147,6 +1147,17 @@ static void qemu_spice_display_init_one(QemuConsol=
e *con)
=20
     ssd->qxl.base.sif =3D &dpy_interface.base;
     qemu_spice_add_display_interface(&ssd->qxl, con);
+
+#if SPICE_SERVER_VERSION >=3D 0x000e02 /* release 0.14.2 */
+    char device_address[256] =3D "";
+    if (qemu_spice_fill_device_address(con, device_address, 256)) {
+        spice_qxl_set_device_info(&ssd->qxl,
+                                  device_address,
+                                  qemu_console_get_head(con),
+                                  1);
+    }
+#endif
+
     qemu_spice_create_host_memslot(ssd);
=20
     register_displaychangelistener(&ssd->dcl);
--=20
2.9.3
