Received: from eggs.gnu.org ([2001:4830:134:3::10]:39564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1daRPY-0004JX-R2
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1daRPU-0005m5-0F
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:51:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1daRPT-0005l6-PT
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:51:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CC587D0D4
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 18:51:50 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 26 Jul 2017 12:45:57 -0600
Message-ID: <20170726184552.1315.40775.stgit@gimli.home>
In-Reply-To: <20170726184421.1315.42536.stgit@gimli.home>
References: <20170726184421.1315.42536.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] vfio/pci: fix use of freed memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

hw/vfio/pci.c:308:29: warning: Use of memory after it is freed
        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
                            ^~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d4051cb9513d..31e1edf44745 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -257,7 +257,7 @@ static void vfio_intx_update(PCIDevice *pdev)
 static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
     uint8_t pin =3D vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN,=
 1);
-    int ret, argsz;
+    int ret, argsz, retval =3D 0;
     struct vfio_irq_set *irq_set;
     int32_t *pfd;
     Error *err =3D NULL;
@@ -302,12 +302,12 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Er=
ror **errp)
     qemu_set_fd_handler(*pfd, vfio_intx_interrupt, NULL, vdev);
=20
     ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
-    g_free(irq_set);
     if (ret) {
         error_setg_errno(errp, -ret, "failed to setup INTx fd");
         qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
         event_notifier_cleanup(&vdev->intx.interrupt);
-        return -errno;
+        retval =3D -errno;
+        goto cleanup;
     }
=20
     vfio_intx_enable_kvm(vdev, &err);
@@ -319,7 +319,10 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Err=
or **errp)
=20
     trace_vfio_intx_enable(vdev->vbasedev.name);
=20
-    return 0;
+cleanup:
+    g_free(irq_set);
+
+    return retval;
 }
=20
 static void vfio_intx_disable(VFIOPCIDevice *vdev)
