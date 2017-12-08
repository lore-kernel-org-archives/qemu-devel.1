Received: from eggs.gnu.org ([2001:4830:134:3::10]:58492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eNDLg-00024x-5S
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:45:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eNDLe-0005jI-Ba
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:45:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eNDLe-0005gs-4Z
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:45:30 -0500
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri,  8 Dec 2017 08:45:12 +0100
Message-Id: <20171208074515.1553-2-lprosek@redhat.com>
In-Reply-To: <20171208074515.1553-1-lprosek@redhat.com>
References: <20171208074515.1553-1-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/4] ivshmem: Don't update non-existent MSI
 routes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, geoff@hostfission.com, marcandre.lureau@redhat.com, armbru@redhat.com

As of commit 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications"=
),
QEMU crashes with:

  kvm_irqchip_commit_routes: Assertion `ret =3D=3D 0' failed.

if the ivshmem device is configured with more vectors than what the serve=
r
supports. This is caused by the ivshmem_vector_unmask() being called on
vectors that have not been initialized by ivshmem_add_kvm_msi_virq().

This commit fixes it by adding a simple check to the mask and unmask
callbacks.

Note that the opposite mismatch, if the server supplies more vectors than
what the device is configured for, is already handled and leads to output
like:

  Too many eventfd received, device has 1 vectors

To reproduce the assert, run:

  ivshmem-server -n 0

and QEMU with:

  -device ivshmem-doorbell,chardev=3Div
  -chardev socket,path=3D/tmp/ivshmem_socket,id=3Div

then load the Windows driver, at the time of writing available at:

https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/ivshm=
em

The issue is believed to have been masked by other guest drivers, notably
Linux ones, not enabling MSI-X on the device.

Fixes: 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications")
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/ivshmem.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index a5a46827fe..6e46669744 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -317,6 +317,10 @@ static int ivshmem_vector_unmask(PCIDevice *dev, uns=
igned vector,
     int ret;
=20
     IVSHMEM_DPRINTF("vector unmask %p %d\n", dev, vector);
+    if (!v->pdev) {
+        error_report("ivshmem: vector %d route does not exist", vector);
+        return -EINVAL;
+    }
=20
     ret =3D kvm_irqchip_update_msi_route(kvm_state, v->virq, msg, dev);
     if (ret < 0) {
@@ -331,12 +335,16 @@ static void ivshmem_vector_mask(PCIDevice *dev, uns=
igned vector)
 {
     IVShmemState *s =3D IVSHMEM_COMMON(dev);
     EventNotifier *n =3D &s->peers[s->vm_id].eventfds[vector];
+    MSIVector *v =3D &s->msi_vectors[vector];
     int ret;
=20
     IVSHMEM_DPRINTF("vector mask %p %d\n", dev, vector);
+    if (!v->pdev) {
+        error_report("ivshmem: vector %d route does not exist", vector);
+        return;
+    }
=20
-    ret =3D kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n,
-                                                s->msi_vectors[vector].v=
irq);
+    ret =3D kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n, v->virq)=
;
     if (ret !=3D 0) {
         error_report("remove_irqfd_notifier_gsi failed");
     }
--=20
2.13.6
