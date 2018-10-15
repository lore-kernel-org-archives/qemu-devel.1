Received: from eggs.gnu.org ([2001:4830:134:3::10]:51099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gC6oP-0003zY-Dv
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gC6oM-0004HS-0M
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:37:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gC6oL-0004Gd-Nc
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:37:45 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 15 Oct 2018 11:37:40 -0600
Message-ID: <153962505999.21502.18117965523253898791.stgit@gimli.home>
In-Reply-To: <153962488126.21502.17134983449941187881.stgit@gimli.home>
References: <153962488126.21502.17134983449941187881.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/6] vfio-pci: make vfio-pci device more QOM
 conventional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liq3ea@gmail.com>, Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Li Qiang <liq3ea@gmail.com>

Define a TYPE_VFIO_PCI and drop DO_UPCAST.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |   29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a0047f4942c8..8b73582d51e8 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -37,6 +37,9 @@
=20
 #define MSIX_CAP_LENGTH 12
=20
+#define TYPE_VFIO_PCI "vfio-pci"
+#define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
+
 static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
=20
@@ -222,7 +225,7 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev=
)
=20
 static void vfio_intx_update(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
     PCIINTxRoute route;
     Error *err =3D NULL;
=20
@@ -477,7 +480,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *v=
ector, MSIMessage msg,
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
-    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
     VFIOMSIVector *vector;
     int ret;
=20
@@ -574,7 +577,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
=20
 static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 {
-    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
     VFIOMSIVector *vector =3D &vdev->msi_vectors[nr];
=20
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
@@ -1086,7 +1089,7 @@ static const MemoryRegionOps vfio_vga_ops =3D {
  */
 static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 {
-    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
     VFIORegion *region =3D &vdev->bars[bar].region;
     MemoryRegion *mmap_mr, *region_mr, *base_mr;
     PCIIORegion *r;
@@ -1132,7 +1135,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDev=
ice *pdev, int bar)
  */
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
-    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
     uint32_t emu_bits =3D 0, emu_val =3D 0, phys_val =3D 0, val;
=20
     memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
@@ -1165,7 +1168,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint=
32_t addr, int len)
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
-    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
     uint32_t val_le =3D cpu_to_le32(val);
=20
     trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
@@ -2801,7 +2804,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDev=
ice *vdev)
=20
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
-    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
     char *tmp, *subsys, group_path[PATH_MAX], *group_name;
@@ -3088,8 +3091,7 @@ error:
=20
 static void vfio_instance_finalize(Object *obj)
 {
-    PCIDevice *pci_dev =3D PCI_DEVICE(obj);
-    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pci_dev);
+    VFIOPCIDevice *vdev =3D PCI_VFIO(obj);
     VFIOGroup *group =3D vdev->vbasedev.group;
=20
     vfio_display_finalize(vdev);
@@ -3109,7 +3111,7 @@ static void vfio_instance_finalize(Object *obj)
=20
 static void vfio_exitfn(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
=20
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
@@ -3124,8 +3126,7 @@ static void vfio_exitfn(PCIDevice *pdev)
=20
 static void vfio_pci_reset(DeviceState *dev)
 {
-    PCIDevice *pdev =3D DO_UPCAST(PCIDevice, qdev, dev);
-    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIOPCIDevice *vdev =3D PCI_VFIO(dev);
=20
     trace_vfio_pci_reset(vdev->vbasedev.name);
=20
@@ -3165,7 +3166,7 @@ post_reset:
 static void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev =3D PCI_DEVICE(obj);
-    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, PCI_DEVICE(ob=
j));
+    VFIOPCIDevice *vdev =3D PCI_VFIO(obj);
=20
     device_add_bootindex_property(obj, &vdev->bootindex,
                                   "bootindex", NULL,
@@ -3249,7 +3250,7 @@ static void vfio_pci_dev_class_init(ObjectClass *kl=
ass, void *data)
 }
=20
 static const TypeInfo vfio_pci_dev_info =3D {
-    .name =3D "vfio-pci",
+    .name =3D TYPE_VFIO_PCI,
     .parent =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(VFIOPCIDevice),
     .class_init =3D vfio_pci_dev_class_init,
