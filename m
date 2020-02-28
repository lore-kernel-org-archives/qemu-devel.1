Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBAEC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94262246A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94262246A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysgo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eS6-0006MM-Ra
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 07:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rka@sysgo.com>) id 1j7eRa-0005vN-AT
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rka@sysgo.com>) id 1j7eRX-0000fx-GX
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:08:36 -0500
Received: from mail.sysgo.com ([176.9.12.79]:50022)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <rka@sysgo.com>) id 1j7eRX-0000fq-7L
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:08:35 -0500
From: Roman Kapl <rka@sysgo.com>
To: 
Subject: [PATCH] vfio: avoid SET_ACTION_TRIGGER ioctls
Date: Fri, 28 Feb 2020 13:08:00 +0100
Message-Id: <20200228120800.5979-1-rka@sysgo.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 176.9.12.79
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 Roman Kapl <rka@sysgo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For MSI-X interrupts, remember what the last used eventfd was (KVM
bypass vs QEMU) and only call vfio_set_irq_signaling if it has changed.

This not only helps with performance, but it seems that interrupts can
be lost during VFIO_IRQ_SET_ACTION_TRIGGER. With the 'x-no-kvm-msix'
switch and this patch, SET_ACTION_TRIGGER is not called during
mask/unmask. This really only affects guests that actively use MSI-X mask=
ing.

Signed-off-by: Roman Kapl <rka@sysgo.com>
---

This patch scratches my particular itch. I am able to get our guest (whic=
h masks
MSI on each interrupt) running, without getting randomly stuck on waiting=
 for
interrupt. However, the solution is far from perfect (x-no-kvm-msix is re=
quired)
and pretty slow. I would be interested in hearing any ideas how to improv=
e this.
Some ideas:

1) Fix the kernel so that SET_ACTION_TRIGGER does not loose interrupts (I=
 think
the problem is there, but not 100% sure). I've tested on 5.3.0-40-generic
#32~18.04.1-Ubuntu SMP.

2) Add support for MASK/UNMASK for MSI-X in kernel and use that. But I do=
n't
know how to do PBA in that case. Another IOCTL? We could look at the real=
 PBA
array, if mapping is supported, but that seems hacky.

3) Twiddle the bits behing kernel's back, if it can be mapped?

Still, I think this patch does not hurt anything and could be applied if =
no-one
can think of a better way.

---

 hw/vfio/pci.c | 32 ++++++++++++++++++++++----------
 hw/vfio/pci.h |  2 ++
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e6569a7968..5f7ce91519 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -390,12 +390,16 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev,=
 bool msix)
          * MSI-X mask and pending bits are emulated, so we want to use t=
he
          * KVM signaling path only when configured and unmasked.
          */
-        if (vdev->msi_vectors[i].use) {
-            if (vdev->msi_vectors[i].virq < 0 ||
-                (msix && msix_is_masked(&vdev->pdev, i))) {
-                fd =3D event_notifier_get_fd(&vdev->msi_vectors[i].inter=
rupt);
+        VFIOMSIVector *vector =3D &vdev->msi_vectors[i];
+        if (vector->use) {
+            if (vector->virq < 0 ||
+                (msix && msix_is_masked(&vdev->pdev, i)))
+            {
+                vector->kvm_path_active =3D false;
+                fd =3D event_notifier_get_fd(&vector->interrupt);
             } else {
-                fd =3D event_notifier_get_fd(&vdev->msi_vectors[i].kvm_i=
nterrupt);
+                vector->kvm_path_active =3D true;
+                fd =3D event_notifier_get_fd(&vector->kvm_interrupt);
             }
         }
=20
@@ -509,17 +513,23 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev,=
 unsigned int nr,
     } else {
         Error *err =3D NULL;
         int32_t fd;
+        bool kvm_path;
=20
         if (vector->virq >=3D 0) {
             fd =3D event_notifier_get_fd(&vector->kvm_interrupt);
+            kvm_path =3D true;
         } else {
             fd =3D event_notifier_get_fd(&vector->interrupt);
+            kvm_path =3D false;
         }
=20
-        if (vfio_set_irq_signaling(&vdev->vbasedev,
-                                     VFIO_PCI_MSIX_IRQ_INDEX, nr,
-                                     VFIO_IRQ_SET_ACTION_TRIGGER, fd, &e=
rr)) {
-            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name)=
;
+        if (vector->kvm_path_active !=3D kvm_path) {
+            if (vfio_set_irq_signaling(&vdev->vbasedev,
+                                       VFIO_PCI_MSIX_IRQ_INDEX, nr,
+                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, =
&err)) {
+                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.n=
ame);
+            }
+            vector->kvm_path_active =3D kvm_path;
         }
     }
=20
@@ -555,13 +565,15 @@ static void vfio_msix_vector_release(PCIDevice *pde=
v, unsigned int nr)
      * core will mask the interrupt and set pending bits, allowing it to
      * be re-asserted on unmask.  Nothing to do if already using QEMU mo=
de.
      */
-    if (vector->virq >=3D 0) {
+    if (vector->virq >=3D 0 && vector->kvm_path_active) {
         int32_t fd =3D event_notifier_get_fd(&vector->interrupt);
         Error *err =3D NULL;
=20
         if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_IN=
DEX, nr,
                                    VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err=
)) {
             error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name)=
;
+        } else {
+            vector->kvm_path_active =3D false;
         }
     }
 }
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index b329d50338..b01d2676cf 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -91,6 +91,8 @@ typedef struct VFIOMSIVector {
      */
     EventNotifier interrupt;
     EventNotifier kvm_interrupt;
+    /* Set when the trigger action is set to the KVM bypass FD */
+    bool kvm_path_active;
     struct VFIOPCIDevice *vdev; /* back pointer to device */
     int virq;
     bool use;
--=20
2.22.0


