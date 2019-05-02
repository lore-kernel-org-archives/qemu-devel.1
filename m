Received: from eggs.gnu.org ([209.51.188.92]:43335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEL8-0004Ky-WC
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEL6-0002NH-Au
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hMEL6-0002Mi-3C
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:40 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  2 May 2019 18:13:10 +0200
Message-Id: <20190502161310.15624-9-thuth@redhat.com>
In-Reply-To: <20190502161310.15624-1-thuth@redhat.com>
References: <20190502161310.15624-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/8] hw/pci-host: Use object_initialize_child
 for correct reference counting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Helge Deller <deller@gmx.de>, Eduardo Otubo <otubo@redhat.com>

Both functions, object_initialize() and object_property_add_child() incre=
ase
the reference counter of the new object, so one of the references has to =
be
dropped afterwards to get the reference counting right. Otherwise the chi=
ld
object might not be properly cleaned up when the parent gets destroyed.
Some functions of the pci-host devices miss to drop one of the references=
.
Fix it by using object_initialize_child() instead, which takes care of
calling object_initialize(), object_property_add_child() and object_unref=
()
in the right order.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190430191552.4027-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/pci-host/designware.c  | 4 ++--
 hw/pci-host/gpex.c        | 5 +++--
 hw/pci-host/q35.c         | 4 ++--
 hw/pci-host/xilinx-pcie.c | 4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 29ea313798..64ad21d295 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -721,8 +721,8 @@ static void designware_pcie_host_init(Object *obj)
     DesignwarePCIEHost *s =3D DESIGNWARE_PCIE_HOST(obj);
     DesignwarePCIERoot *root =3D &s->root;
=20
-    object_initialize(root, sizeof(*root), TYPE_DESIGNWARE_PCIE_ROOT);
-    object_property_add_child(obj, "root", OBJECT(root), NULL);
+    object_initialize_child(obj, "root",  root, sizeof(*root),
+                            TYPE_DESIGNWARE_PCIE_ROOT, &error_abort, NUL=
L);
     qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 2583b151a4..1bafffcc34 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -29,6 +29,7 @@
  * http://www.firmware.org/1275/practice/imap/imap0_9d.pdf
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci-host/gpex.h"
=20
@@ -120,8 +121,8 @@ static void gpex_host_initfn(Object *obj)
     GPEXHost *s =3D GPEX_HOST(obj);
     GPEXRootState *root =3D &s->gpex_root;
=20
-    object_initialize(root, sizeof(*root), TYPE_GPEX_ROOT_DEVICE);
-    object_property_add_child(obj, "gpex_root", OBJECT(root), NULL);
+    object_initialize_child(obj, "gpex_root",  root, sizeof(*root),
+                            TYPE_GPEX_ROOT_DEVICE, &error_abort, NULL);
     qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 7b871b5734..960939f5ed 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -216,8 +216,8 @@ static void q35_host_initfn(Object *obj)
     memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops, ph=
b,
                           "pci-conf-data", 4);
=20
-    object_initialize(&s->mch, sizeof(s->mch), TYPE_MCH_PCI_DEVICE);
-    object_property_add_child(OBJECT(s), "mch", OBJECT(&s->mch), NULL);
+    object_initialize_child(OBJECT(s), "mch",  &s->mch, sizeof(s->mch),
+                            TYPE_MCH_PCI_DEVICE, &error_abort, NULL);
     qdev_prop_set_int32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(&s->mch), "multifunction", false);
     /* mch's object_initialize resets the default value, set it again */
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 60309afe9e..ceb00e23e6 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -149,8 +149,8 @@ static void xilinx_pcie_host_init(Object *obj)
     XilinxPCIEHost *s =3D XILINX_PCIE_HOST(obj);
     XilinxPCIERoot *root =3D &s->root;
=20
-    object_initialize(root, sizeof(*root), TYPE_XILINX_PCIE_ROOT);
-    object_property_add_child(obj, "root", OBJECT(root), NULL);
+    object_initialize_child(obj, "root",  root, sizeof(*root),
+                            TYPE_XILINX_PCIE_ROOT, &error_abort, NULL);
     qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
--=20
2.21.0
