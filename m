Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4109C282CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617D02084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617D02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33564 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEt7V-00054n-IC
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 06:09:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt2t-0000n7-JP
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt2q-0003Xc-UR
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:04:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hEt2m-0003Ts-9T; Fri, 12 Apr 2019 06:04:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7720E3DBDF;
	Fri, 12 Apr 2019 10:04:23 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C831219750;
	Fri, 12 Apr 2019 10:04:18 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Fri, 12 Apr 2019 12:03:29 +0200
Message-Id: <20190412100354.6409-3-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 12 Apr 2019 10:04:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v3 02/27] vfio/common: Introduce
 vfio_set_irq_signaling helper
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yi.l.liu@intel.com, mst@redhat.com, jean-philippe.brucker@arm.com,
	peterx@redhat.com, alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412100329.v75QMp9LBPmsiF6guZ-Art6Cz_doT9TMKBSn8wbB7FA@z>

The code used to assign an interrupt index/subindex to an
eventfd is duplicated many times. Let's introduce an helper that
allows to set/unset the signaling for an ACTION_TRIGGER or
ACTION_UNMASK action.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

This is a follow-up to
[PATCH v2 0/2] vfio-pci: Introduce vfio_set_event_handler().
It looks to me that introducing vfio_set_irq_signaling() has more
benefits in term of code reduction and the helper abstraction
looks cleaner.
---
 hw/vfio/common.c              |  61 +++++++++
 hw/vfio/pci.c                 | 224 ++++++++--------------------------
 hw/vfio/platform.c            |  55 +++------
 include/hw/vfio/vfio-common.h |   2 +
 4 files changed, 134 insertions(+), 208 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4374cc6176..f88fd10ca3 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -95,6 +95,67 @@ void vfio_mask_single_irqindex(VFIODevice *vbasedev, i=
nt index)
     ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
 }
=20
+static inline const char *action_to_str(int action)
+{
+    switch (action) {
+    case VFIO_IRQ_SET_ACTION_MASK:
+        return "MASK";
+    case VFIO_IRQ_SET_ACTION_UNMASK:
+        return "UNMASK";
+    case VFIO_IRQ_SET_ACTION_TRIGGER:
+        return "TRIGGER";
+    default:
+        return "UNKNOWN ACTION";
+    }
+}
+
+int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex=
,
+                           int action, int fd, Error **errp)
+{
+    struct vfio_irq_info irq_info =3D { .argsz =3D sizeof(irq_info),
+                                      .index =3D index };
+    struct vfio_irq_set *irq_set;
+    int argsz, ret =3D 0;
+    int32_t *pfd;
+
+    ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    if (ret < 0) {
+        error_setg_errno(errp, errno, "index %d does not exist", index);
+        goto error;
+    }
+    if (irq_info.count < subindex + 1) {
+        error_setg_errno(errp, errno, "subindex %d does not exist", subi=
ndex);
+        goto error;
+    }
+
+    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
+
+    irq_set =3D g_malloc0(argsz);
+    irq_set->argsz =3D argsz;
+    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD | action;
+    irq_set->index =3D index;
+    irq_set->start =3D subindex;
+    irq_set->count =3D 1;
+    pfd =3D (int32_t *)&irq_set->data;
+    *pfd =3D fd;
+
+    ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set);
+
+    g_free(irq_set);
+
+    if (ret) {
+        error_setg_errno(errp, -ret, "VFIO_DEVICE_SET_IRQS failure");
+        goto error;
+    }
+    return 0;
+error:
+    error_prepend(errp,
+                  "Failed to %s %s eventfd signaling for interrupt [%d,%=
d]: ",
+                  fd < 0 ? "tear down" : "set up", action_to_str(action)=
,
+                  index, subindex);
+    return ret;
+}
+
 /*
  * IO Port/MMIO - Beware of the endians, VFIO is always little endian
  */
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 504019c458..cd93ff6fa3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -113,9 +113,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev,=
 Error **errp)
         .gsi =3D vdev->intx.route.irq,
         .flags =3D KVM_IRQFD_FLAG_RESAMPLE,
     };
-    struct vfio_irq_set *irq_set;
-    int ret, argsz;
-    int32_t *pfd;
+    Error *err =3D NULL;
=20
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
         vdev->intx.route.mode !=3D PCI_INTX_ENABLED ||
@@ -143,22 +141,10 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vde=
v, Error **errp)
         goto fail_irqfd;
     }
=20
-    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
-
-    irq_set =3D g_malloc0(argsz);
-    irq_set->argsz =3D argsz;
-    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_U=
NMASK;
-    irq_set->index =3D VFIO_PCI_INTX_IRQ_INDEX;
-    irq_set->start =3D 0;
-    irq_set->count =3D 1;
-    pfd =3D (int32_t *)&irq_set->data;
-
-    *pfd =3D irqfd.resamplefd;
-
-    ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
-    g_free(irq_set);
-    if (ret) {
-        error_setg_errno(errp, -ret, "failed to setup INTx unmask fd");
+    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX,=
 0,
+                               VFIO_IRQ_SET_ACTION_UNMASK,
+                               irqfd.resamplefd, &err)) {
+        error_propagate(errp, err);
         goto fail_vfio;
     }
=20
@@ -262,10 +248,10 @@ static void vfio_intx_update(PCIDevice *pdev)
 static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
     uint8_t pin =3D vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN,=
 1);
-    int ret, argsz, retval =3D 0;
-    struct vfio_irq_set *irq_set;
-    int32_t *pfd;
     Error *err =3D NULL;
+    int32_t fd;
+    int ret;
+
=20
     if (!pin) {
         return 0;
@@ -292,27 +278,15 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Er=
ror **errp)
         error_setg_errno(errp, -ret, "event_notifier_init failed");
         return ret;
     }
+    fd =3D event_notifier_get_fd(&vdev->intx.interrupt);
+    qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
=20
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
+    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX,=
 0,
+                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+        error_propagate(errp, err);
+        qemu_set_fd_handler(fd, NULL, NULL, vdev);
         event_notifier_cleanup(&vdev->intx.interrupt);
-        retval =3D -errno;
-        goto cleanup;
+        return -errno;
     }
=20
     vfio_intx_enable_kvm(vdev, &err);
@@ -323,11 +297,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Err=
or **errp)
     vdev->interrupt =3D VFIO_INT_INTx;
=20
     trace_vfio_intx_enable(vdev->vbasedev.name);
-
-cleanup:
-    g_free(irq_set);
-
-    return retval;
+    return 0;
 }
=20
 static void vfio_intx_disable(VFIOPCIDevice *vdev)
@@ -530,31 +500,19 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev,=
 unsigned int nr,
             error_report("vfio: failed to enable vectors, %d", ret);
         }
     } else {
-        int argsz;
-        struct vfio_irq_set *irq_set;
-        int32_t *pfd;
-
-        argsz =3D sizeof(*irq_set) + sizeof(*pfd);
-
-        irq_set =3D g_malloc0(argsz);
-        irq_set->argsz =3D argsz;
-        irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
-                         VFIO_IRQ_SET_ACTION_TRIGGER;
-        irq_set->index =3D VFIO_PCI_MSIX_IRQ_INDEX;
-        irq_set->start =3D nr;
-        irq_set->count =3D 1;
-        pfd =3D (int32_t *)&irq_set->data;
+        Error *err =3D NULL;
+        int32_t fd;
=20
         if (vector->virq >=3D 0) {
-            *pfd =3D event_notifier_get_fd(&vector->kvm_interrupt);
+            fd =3D event_notifier_get_fd(&vector->kvm_interrupt);
         } else {
-            *pfd =3D event_notifier_get_fd(&vector->interrupt);
+            fd =3D event_notifier_get_fd(&vector->interrupt);
         }
=20
-        ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
-        g_free(irq_set);
-        if (ret) {
-            error_report("vfio: failed to modify vector, %d", ret);
+        if (vfio_set_irq_signaling(&vdev->vbasedev,
+                                     VFIO_PCI_MSIX_IRQ_INDEX, nr,
+                                     VFIO_IRQ_SET_ACTION_TRIGGER, fd, &e=
rr)) {
+            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name)=
;
         }
     }
=20
@@ -591,26 +549,10 @@ static void vfio_msix_vector_release(PCIDevice *pde=
v, unsigned int nr)
      * be re-asserted on unmask.  Nothing to do if already using QEMU mo=
de.
      */
     if (vector->virq >=3D 0) {
-        int argsz;
-        struct vfio_irq_set *irq_set;
-        int32_t *pfd;
+        int32_t fd =3D event_notifier_get_fd(&vector->interrupt);
=20
-        argsz =3D sizeof(*irq_set) + sizeof(*pfd);
-
-        irq_set =3D g_malloc0(argsz);
-        irq_set->argsz =3D argsz;
-        irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
-                         VFIO_IRQ_SET_ACTION_TRIGGER;
-        irq_set->index =3D VFIO_PCI_MSIX_IRQ_INDEX;
-        irq_set->start =3D nr;
-        irq_set->count =3D 1;
-        pfd =3D (int32_t *)&irq_set->data;
-
-        *pfd =3D event_notifier_get_fd(&vector->interrupt);
-
-        ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
-
-        g_free(irq_set);
+        vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,=
 nr,
+                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, NULL);
     }
 }
=20
@@ -2629,10 +2571,8 @@ static void vfio_err_notifier_handler(void *opaque=
)
  */
 static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
 {
-    int ret;
-    int argsz;
-    struct vfio_irq_set *irq_set;
-    int32_t *pfd;
+    Error *err =3D NULL;
+    int32_t fd;
=20
     if (!vdev->pci_aer) {
         return;
@@ -2644,58 +2584,30 @@ static void vfio_register_err_notifier(VFIOPCIDev=
ice *vdev)
         return;
     }
=20
-    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
+    fd =3D event_notifier_get_fd(&vdev->err_notifier);
+    qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
=20
-    irq_set =3D g_malloc0(argsz);
-    irq_set->argsz =3D argsz;
-    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
-                     VFIO_IRQ_SET_ACTION_TRIGGER;
-    irq_set->index =3D VFIO_PCI_ERR_IRQ_INDEX;
-    irq_set->start =3D 0;
-    irq_set->count =3D 1;
-    pfd =3D (int32_t *)&irq_set->data;
-
-    *pfd =3D event_notifier_get_fd(&vdev->err_notifier);
-    qemu_set_fd_handler(*pfd, vfio_err_notifier_handler, NULL, vdev);
-
-    ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
-    if (ret) {
-        error_report("vfio: Failed to set up error notification");
-        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
+    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, =
0,
+                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        qemu_set_fd_handler(fd, NULL, NULL, vdev);
         event_notifier_cleanup(&vdev->err_notifier);
         vdev->pci_aer =3D false;
     }
-    g_free(irq_set);
 }
=20
 static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
 {
-    int argsz;
-    struct vfio_irq_set *irq_set;
-    int32_t *pfd;
-    int ret;
+    Error *err =3D NULL;
=20
     if (!vdev->pci_aer) {
         return;
     }
=20
-    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
-
-    irq_set =3D g_malloc0(argsz);
-    irq_set->argsz =3D argsz;
-    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
-                     VFIO_IRQ_SET_ACTION_TRIGGER;
-    irq_set->index =3D VFIO_PCI_ERR_IRQ_INDEX;
-    irq_set->start =3D 0;
-    irq_set->count =3D 1;
-    pfd =3D (int32_t *)&irq_set->data;
-    *pfd =3D -1;
-
-    ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
-    if (ret) {
-        error_report("vfio: Failed to de-assign error fd: %m");
+    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, =
0,
+                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
-    g_free(irq_set);
     qemu_set_fd_handler(event_notifier_get_fd(&vdev->err_notifier),
                         NULL, NULL, vdev);
     event_notifier_cleanup(&vdev->err_notifier);
@@ -2718,77 +2630,43 @@ static void vfio_req_notifier_handler(void *opaqu=
e)
=20
 static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
 {
-    struct vfio_irq_info irq_info =3D { .argsz =3D sizeof(irq_info),
-                                      .index =3D VFIO_PCI_REQ_IRQ_INDEX =
};
-    int argsz;
-    struct vfio_irq_set *irq_set;
-    int32_t *pfd;
+    Error *err =3D NULL;
+    int32_t fd;
=20
     if (!(vdev->features & VFIO_FEATURE_ENABLE_REQ)) {
         return;
     }
=20
-    if (ioctl(vdev->vbasedev.fd,
-              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count=
 < 1) {
-        return;
-    }
-
     if (event_notifier_init(&vdev->req_notifier, 0)) {
         error_report("vfio: Unable to init event notifier for device req=
uest");
         return;
     }
=20
-    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
+    fd =3D event_notifier_get_fd(&vdev->req_notifier);
+    qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
=20
-    irq_set =3D g_malloc0(argsz);
-    irq_set->argsz =3D argsz;
-    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
-                     VFIO_IRQ_SET_ACTION_TRIGGER;
-    irq_set->index =3D VFIO_PCI_REQ_IRQ_INDEX;
-    irq_set->start =3D 0;
-    irq_set->count =3D 1;
-    pfd =3D (int32_t *)&irq_set->data;
-
-    *pfd =3D event_notifier_get_fd(&vdev->req_notifier);
-    qemu_set_fd_handler(*pfd, vfio_req_notifier_handler, NULL, vdev);
-
-    if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
-        error_report("vfio: Failed to set up device request notification=
");
-        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
+    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, =
0,
+                           VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        qemu_set_fd_handler(fd, NULL, NULL, vdev);
         event_notifier_cleanup(&vdev->req_notifier);
     } else {
         vdev->req_enabled =3D true;
     }
-
-    g_free(irq_set);
 }
=20
 static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
 {
-    int argsz;
-    struct vfio_irq_set *irq_set;
-    int32_t *pfd;
+    Error *err =3D NULL;
=20
     if (!vdev->req_enabled) {
         return;
     }
=20
-    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
-
-    irq_set =3D g_malloc0(argsz);
-    irq_set->argsz =3D argsz;
-    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
-                     VFIO_IRQ_SET_ACTION_TRIGGER;
-    irq_set->index =3D VFIO_PCI_REQ_IRQ_INDEX;
-    irq_set->start =3D 0;
-    irq_set->count =3D 1;
-    pfd =3D (int32_t *)&irq_set->data;
-    *pfd =3D -1;
-
-    if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
-        error_report("vfio: Failed to de-assign device request fd: %m");
+    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, =
0,
+                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
-    g_free(irq_set);
     qemu_set_fd_handler(event_notifier_get_fd(&vdev->req_notifier),
                         NULL, NULL, vdev);
     event_notifier_cleanup(&vdev->req_notifier);
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 398db38f14..d60f391439 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -106,26 +106,19 @@ static int vfio_set_trigger_eventfd(VFIOINTp *intp,
                                     eventfd_user_side_handler_t handler)
 {
     VFIODevice *vbasedev =3D &intp->vdev->vbasedev;
-    struct vfio_irq_set *irq_set;
-    int argsz, ret;
-    int32_t *pfd;
+    int32_t fd =3D event_notifier_get_fd(intp->interrupt);
+    Error *err =3D NULL;
+    int ret;
=20
-    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
-    irq_set =3D g_malloc0(argsz);
-    irq_set->argsz =3D argsz;
-    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_T=
RIGGER;
-    irq_set->index =3D intp->pin;
-    irq_set->start =3D 0;
-    irq_set->count =3D 1;
-    pfd =3D (int32_t *)&irq_set->data;
-    *pfd =3D event_notifier_get_fd(intp->interrupt);
-    qemu_set_fd_handler(*pfd, (IOHandler *)handler, NULL, intp);
-    ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set);
-    if (ret < 0) {
-        error_report("vfio: Failed to set trigger eventfd: %m");
-        qemu_set_fd_handler(*pfd, NULL, NULL, NULL);
+    qemu_set_fd_handler(fd, (IOHandler *)handler, NULL, intp);
+
+    ret =3D vfio_set_irq_signaling(vbasedev, intp->pin, 0,
+                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err);
+    if (ret) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
+        qemu_set_fd_handler(fd, NULL, NULL, NULL);
     }
-    g_free(irq_set);
+
     return ret;
 }
=20
@@ -361,26 +354,18 @@ static void vfio_start_eventfd_injection(SysBusDevi=
ce *sbdev, qemu_irq irq)
  */
 static int vfio_set_resample_eventfd(VFIOINTp *intp)
 {
+    int32_t fd =3D event_notifier_get_fd(intp->unmask);
     VFIODevice *vbasedev =3D &intp->vdev->vbasedev;
-    struct vfio_irq_set *irq_set;
-    int argsz, ret;
-    int32_t *pfd;
+    Error *err =3D NULL;
+    int ret;
=20
-    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
-    irq_set =3D g_malloc0(argsz);
-    irq_set->argsz =3D argsz;
-    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_U=
NMASK;
-    irq_set->index =3D intp->pin;
-    irq_set->start =3D 0;
-    irq_set->count =3D 1;
-    pfd =3D (int32_t *)&irq_set->data;
-    *pfd =3D event_notifier_get_fd(intp->unmask);
-    qemu_set_fd_handler(*pfd, NULL, NULL, NULL);
-    ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set);
-    g_free(irq_set);
-    if (ret < 0) {
-        error_report("vfio: Failed to set resample eventfd: %m");
+    qemu_set_fd_handler(fd, NULL, NULL, NULL);
+    ret =3D vfio_set_irq_signaling(vbasedev, intp->pin, 0,
+                                 VFIO_IRQ_SET_ACTION_UNMASK, fd, &err);
+    if (ret) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
     }
+
     return ret;
 }
=20
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
index 1155b79678..686d99ff8c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -167,6 +167,8 @@ void vfio_put_base_device(VFIODevice *vbasedev);
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
 void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
+int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex=
,
+                           int action, int fd, Error **errp);
 void vfio_region_write(void *opaque, hwaddr addr,
                            uint64_t data, unsigned size);
 uint64_t vfio_region_read(void *opaque,
--=20
2.20.1


