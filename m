Received: from eggs.gnu.org ([209.51.188.92]:33074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gkEsQ-0004uq-Vm
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gkEsP-0007Nx-7C
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:07:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gkEsO-0007IV-5O
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:07:01 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 17 Jan 2019 22:06:32 +0100
Message-Id: <20190117210632.18567-3-eric.auger@redhat.com>
In-Reply-To: <20190117210632.18567-1-eric.auger@redhat.com>
References: <20190117210632.18567-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] vfio-pci: Use vfio_set_event_handler in
 vfio_intx_enable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com
Cc: aik@ozlabs.ru, cohuck@redhat.com

vfio_set_event_handler() can be used  in vfio_intx_enable()
to set the signalling associated with VFIO_PCI_INTX_IRQ_INDEX.

We also turn vfio_intx_enable() into a void function.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

vfio_set_event_handler cannot be used in vfio_intx_disable. The reason
is not a call sequence issue but the VFIO_DEVICE_SET_IRQS invoction.
vfio_disable_irqindex uses ACTION_TRIGGER/DATA_NONE/count=3D=3D0 whereas
the new helper uses ACTION_TRIGGER/DATA_EVENTFD/fd=3D=3D-1. Surprisingly
to me, both are not resulting into the same kernel actions. The first
one does a complete tear down of the INTx (vfio_intx_disable), while
the second - just taking care of a single index, the only one by the
way for INTx -, does an incomplete tear down (vfio_intx_set_signal).
If the last one is used, a subsequent setup of MSIx vectors fails.

v1 -> v2:
- turn vfio_intx_enable into a void function
- s/vfio_intx_enable_kvm/vfio_intx_enable in title and commit msg
---
 hw/vfio/pci.c | 51 +++++++++++++--------------------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3cae4c99ef..dcba7a1539 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -136,6 +136,9 @@ static void vfio_set_event_handler(VFIOPCIDevice *vde=
v,
     case VFIO_PCI_ERR_IRQ_INDEX:
         notifier =3D &vdev->err_notifier;
         break;
+    case VFIO_PCI_INTX_IRQ_INDEX:
+        notifier =3D &vdev->intx.interrupt;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -349,16 +352,13 @@ static void vfio_intx_update(PCIDevice *pdev)
     vfio_intx_eoi(&vdev->vbasedev);
 }
=20
-static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
+static void vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
     uint8_t pin =3D vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN,=
 1);
-    int ret, argsz, retval =3D 0;
-    struct vfio_irq_set *irq_set;
-    int32_t *pfd;
     Error *err =3D NULL;
=20
     if (!pin) {
-        return 0;
+        return;
     }
=20
     vfio_disable_interrupts(vdev);
@@ -377,32 +377,11 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Er=
ror **errp)
     }
 #endif
=20
-    ret =3D event_notifier_init(&vdev->intx.interrupt, 0);
-    if (ret) {
-        error_setg_errno(errp, -ret, "event_notifier_init failed");
-        return ret;
-    }
-
-    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
-
-    irq_set =3D g_malloc0(argsz);
-    irq_set->argsz =3D argsz;
-    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_T=
RIGGER;
-    irq_set->index =3D VFIO_PCI_INTX_IRQ_INDEX;
-    irq_set->start =3D 0;
-    irq_set->count =3D 1;
-    pfd =3D (int32_t *)&irq_set->data;
-
-    *pfd =3D event_notifier_get_fd(&vdev->intx.interrupt);
-    qemu_set_fd_handler(*pfd, vfio_intx_interrupt, NULL, vdev);
-
-    ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
-    if (ret) {
-        error_setg_errno(errp, -ret, "failed to setup INTx fd");
-        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
-        event_notifier_cleanup(&vdev->intx.interrupt);
-        retval =3D -errno;
-        goto cleanup;
+    vfio_set_event_handler(vdev, VFIO_PCI_INTX_IRQ_INDEX, true,
+                                 vfio_intx_interrupt, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
     }
=20
     vfio_intx_enable_kvm(vdev, &err);
@@ -413,11 +392,6 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Err=
or **errp)
     vdev->interrupt =3D VFIO_INT_INTx;
=20
     trace_vfio_intx_enable(vdev->vbasedev.name);
-
-cleanup:
-    g_free(irq_set);
-
-    return retval;
 }
=20
 static void vfio_intx_disable(VFIOPCIDevice *vdev)
@@ -2982,8 +2956,9 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
         vdev->intx.mmap_timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                                   vfio_intx_mmap_enable,=
 vdev);
         pci_device_set_intx_routing_notifier(&vdev->pdev, vfio_intx_upda=
te);
-        ret =3D vfio_intx_enable(vdev, errp);
-        if (ret) {
+        vfio_intx_enable(vdev, &err);
+        if (err) {
+            error_propagate(errp, err);
             goto out_teardown;
         }
     }
--=20
2.20.1
