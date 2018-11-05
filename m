Received: from eggs.gnu.org ([2001:4830:134:3::10]:60482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQf-0007st-NY
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQd-00037L-Mq
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjQd-000348-6E
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:47 -0500
Date: Mon, 5 Nov 2018 13:16:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-22-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/33] pci-testdev: add optional memory bar
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Gerd Hoffmann <kraxel@redhat.com>

Add memory bar to pci-testdev.  Size is configurable using the membar
property.  Setting the size to zero (default) turns it off.  Can be used
to check whether guests handle large pci bars correctly.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/pci-testdev.txt | 15 ++++++++++-----
 hw/misc/pci-testdev.c      | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/docs/specs/pci-testdev.txt b/docs/specs/pci-testdev.txt
index 128ae222ef..4280a1e73c 100644
--- a/docs/specs/pci-testdev.txt
+++ b/docs/specs/pci-testdev.txt
@@ -1,11 +1,11 @@
 pci-test is a device used for testing low level IO
=20
-device implements up to two BARs: BAR0 and BAR1.
-Each BAR can be memory or IO. Guests must detect
-BAR type and act accordingly.
+device implements up to three BARs: BAR0, BAR1 and BAR2.
+Each of BAR 0+1 can be memory or IO. Guests must detect
+BAR types and act accordingly.
=20
-Each BAR size is up to 4K bytes.
-Each BAR starts with the following header:
+BAR 0+1 size is up to 4K bytes each.
+BAR 0+1 starts with the following header:
=20
 typedef struct PCITestDevHdr {
     uint8_t test;  <- write-only, starts a given test number
@@ -24,3 +24,8 @@ All registers are little endian.
 device is expected to always implement tests 0 to N on each BAR, and to =
add new
 tests with higher numbers.  In this way a guest can scan test numbers un=
til it
 detects an access type that it does not support on this BAR, then stop.
+
+BAR2 is a 64bit memory bar, without backing storage.  It is disabled
+by default and can be enabled using the membar=3D<size> property.  This
+can be used to test whether guests handle pci bars of a specific
+(possibly quite large) size correctly.
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 32041f535f..1282d151cb 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -85,6 +85,9 @@ typedef struct PCITestDevState {
     MemoryRegion portio;
     IOTest *tests;
     int current;
+
+    uint64_t membar_size;
+    MemoryRegion membar;
 } PCITestDevState;
=20
 #define TYPE_PCI_TEST_DEV "pci-testdev"
@@ -253,6 +256,16 @@ static void pci_testdev_realize(PCIDevice *pci_dev, =
Error **errp)
     pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio=
);
     pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &d->portio);
=20
+    if (d->membar_size) {
+        memory_region_init(&d->membar, OBJECT(d), "pci-testdev-membar",
+                           d->membar_size);
+        pci_register_bar(pci_dev, 2,
+                         PCI_BASE_ADDRESS_SPACE_MEMORY |
+                         PCI_BASE_ADDRESS_MEM_PREFETCH |
+                         PCI_BASE_ADDRESS_MEM_TYPE_64,
+                         &d->membar);
+    }
+
     d->current =3D -1;
     d->tests =3D g_malloc0(IOTEST_MAX * sizeof *d->tests);
     for (i =3D 0; i < IOTEST_MAX; ++i) {
@@ -305,6 +318,11 @@ static void qdev_pci_testdev_reset(DeviceState *dev)
     pci_testdev_reset(d);
 }
=20
+static Property pci_testdev_properties[] =3D {
+    DEFINE_PROP_SIZE("membar", PCITestDevState, membar_size, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pci_testdev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -319,6 +337,7 @@ static void pci_testdev_class_init(ObjectClass *klass=
, void *data)
     dc->desc =3D "PCI Test Device";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->reset =3D qdev_pci_testdev_reset;
+    dc->props =3D pci_testdev_properties;
 }
=20
 static const TypeInfo pci_testdev_info =3D {
--=20
MST
