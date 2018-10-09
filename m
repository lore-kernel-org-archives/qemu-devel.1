Received: from eggs.gnu.org ([2001:4830:134:3::10]:49274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1g9rn2-00049l-KA
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1g9rn1-0000W0-MG
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:11:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1g9rn1-0000VX-Cc
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:11:07 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Tue,  9 Oct 2018 15:10:52 +0200
Message-Id: <20181009131052.18500-3-lhrazky@redhat.com>
In-Reply-To: <20181009131052.18500-1-lhrazky@redhat.com>
References: <20181009131052.18500-1-lhrazky@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH qemu 2/2] spice: set PCI path and device
 display ID in QXL interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Calls new SPICE QXL interface functions to set:

* The hardware path of the graphics device represented by the QXL
  interface (e.g. a PCI path):
  spice_qxl_device_set_path(...)

* The device display IDs (the IDs of the device's monitors that belong
  to this QXL interface):
  spice_qxl_device_monitor_add_display_id(...)

Signed-off-by: Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD <lhrazky@redhat.com>
---
 hw/display/qxl.c   |  8 ++++++++
 ui/spice-core.c    | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 ui/spice-display.c |  5 +++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index e628cf1286..cdce678046 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2184,6 +2184,14 @@ static void qxl_realize_common(PCIQXLDevice *qxl, =
Error **errp)
                    SPICE_INTERFACE_QXL_MAJOR, SPICE_INTERFACE_QXL_MINOR)=
;
         return;
     }
+
+#if SPICE_SERVER_VERSION >=3D 0x000e02 /* release 0.14.2 */
+    // register all possible device display IDs to SPICE server
+    for (int i =3D 0; i < qxl->max_outputs; ++i) {
+        spice_qxl_device_monitor_add_display_id(&qxl->ssd.qxl, i);
+    }
+#endif
+
     qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
=20
     qxl->update_irq =3D qemu_bh_new(qxl_update_irq_bh, qxl);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index a4fbbc3898..eb1fb17174 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -35,6 +35,8 @@
 #include "qemu/option.h"
 #include "migration/misc.h"
 #include "hw/hw.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bus.h"
 #include "ui/spice-display.h"
=20
 /* core bits */
@@ -871,6 +873,26 @@ bool qemu_spice_have_display_interface(QemuConsole *=
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
+static bool append_pci_address_recursive(char *buf, size_t buf_size, con=
st PCIDevice *pci)
+{
+    PCIBus *bus =3D pci_get_bus(pci);
+    if (!pci_bus_is_root(bus)) {
+        append_pci_address_recursive(buf, buf_size, bus->parent_dev);
+    }
+
+    size_t len =3D strlen(buf);
+    size_t written =3D snprintf(buf + len, buf_size - len, "/%02x.%x",
+        PCI_SLOT(pci->devfn), PCI_FUNC(pci->devfn));
+
+    return written > 0 && written < buf_size - len;
+}
+
 int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *co=
n)
 {
     if (g_slist_find(spice_consoles, con)) {
@@ -878,7 +900,28 @@ int qemu_spice_add_display_interface(QXLInstance *qx=
lin, QemuConsole *con)
     }
     qxlin->id =3D qemu_console_get_index(con);
     spice_consoles =3D g_slist_append(spice_consoles, con);
-    return qemu_spice_add_interface(&qxlin->base);
+    int res =3D qemu_spice_add_interface(&qxlin->base);
+
+#if SPICE_SERVER_VERSION >=3D 0x000e02 /* release 0.14.2 */
+    DeviceState *dev =3D DEVICE(object_property_get_link(OBJECT(con), "d=
evice", &error_abort));
+    PCIDevice *pci =3D (PCIDevice *) object_dynamic_cast(OBJECT(dev), TY=
PE_PCI_DEVICE);
+
+    if (pci =3D=3D NULL) {
+        warn_report("Setting PCI path of a display device to SPICE: Not =
a PCI device.");
+        return res;
+    }
+
+    char device_path[128] =3D "pci/0000";  // hardcoded PCI domain 0000
+    if (!append_pci_address_recursive(device_path, sizeof(device_path), =
pci)) {
+        warn_report("Setting PCI path of a display device to SPICE: "
+            "Too many PCI devices in the chain.");
+        return res;
+    }
+
+    spice_qxl_device_set_path(qxlin, device_path);
+#endif
+
+    return res;
 }
=20
 static int qemu_spice_set_ticket(bool fail_if_conn, bool disconnect_if_c=
onn)
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 2f8adb6b9f..9c0d1b3fd2 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1129,6 +1129,11 @@ static void qemu_spice_display_init_one(QemuConsol=
e *con)
=20
     ssd->qxl.base.sif =3D &dpy_interface.base;
     qemu_spice_add_display_interface(&ssd->qxl, con);
+
+#if SPICE_SERVER_VERSION >=3D 0x000e02 /* release 0.14.2 */
+    spice_qxl_device_monitor_add_display_id(&ssd->qxl, qemu_console_get_=
head(con));
+#endif
+
     qemu_spice_create_host_memslot(ssd);
=20
     register_displaychangelistener(&ssd->dcl);
--=20
2.19.1
