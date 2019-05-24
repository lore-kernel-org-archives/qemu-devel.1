Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B28DC282E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A78217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A78217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58650 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUF5J-00026o-DG
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:38:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hUF3v-0001Em-3l
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hUF3s-0008Tk-RH
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:37:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hUF3r-0008QE-BL
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:37:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D5E33082B44;
	Fri, 24 May 2019 18:36:51 +0000 (UTC)
Received: from localhost (ovpn-117-142.ams2.redhat.com [10.36.117.142])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5B2415B2F7;
	Fri, 24 May 2019 18:36:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Date: Fri, 24 May 2019 19:36:36 +0100
Message-Id: <20190524183638.20745-2-stefanha@redhat.com>
In-Reply-To: <20190524183638.20745-1-stefanha@redhat.com>
References: <20190524183638.20745-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 24 May 2019 18:36:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v3 1/3] virtio: add vdc->vmchange_state() callback
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The core virtio code invokes ->set_status() followed by
->ioeventfd_start() when the guest resumes execution.  Both of these
functions are also called in other cases unrelated to vm change state.

This patch introduces ->vmstate_change() so that devices can act on
guest pause/resume.  The existing qemu_add_vm_change_state_handler() API
isn't usable by virtio devices since the ordering between vm change
state handlers is undefined.  The new ->vmstate_change() callback is
always invoked after ->set_status() and ->ioeventfd_start() when
resuming a guest.

A later patch makes use of this new callback.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio.h | 7 +++++++
 hw/virtio/virtio.c         | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 27c0efc3d0..5742efa1d7 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -158,6 +158,13 @@ typedef struct VirtioDeviceClass {
     void (*save)(VirtIODevice *vdev, QEMUFile *f);
     int (*load)(VirtIODevice *vdev, QEMUFile *f, int version_id);
     const VMStateDescription *vmsd;
+
+    /* Called when the device should start/stop running because the gues=
t was
+     * resumed/paused.  Note that this takes VIRTIO_CONFIG_S_DRIVER_OK i=
nto
+     * account so running is true iff the guest is resumed and the guest=
 driver
+     * has already indicated it is ready.
+     */
+    void (*vmstate_change)(VirtIODevice *vdev, bool running);
 } VirtioDeviceClass;
=20
 void virtio_instance_init_common(Object *proxy_obj, void *data,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4805727b53..cdf869456b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2291,6 +2291,7 @@ static void virtio_vmstate_change(void *opaque, int=
 running, RunState state)
     VirtIODevice *vdev =3D opaque;
     BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
     bool backend_run =3D running && vdev->started;
     vdev->vm_running =3D running;
=20
@@ -2298,10 +2299,18 @@ static void virtio_vmstate_change(void *opaque, i=
nt running, RunState state)
         virtio_set_status(vdev, vdev->status);
     }
=20
+    if (!backend_run && vdc->vmstate_change) {
+        vdc->vmstate_change(vdev, backend_run);
+    }
+
     if (k->vmstate_change) {
         k->vmstate_change(qbus->parent, backend_run);
     }
=20
+    if (backend_run && vdc->vmstate_change) {
+        vdc->vmstate_change(vdev, backend_run);
+    }
+
     if (!backend_run) {
         virtio_set_status(vdev, vdev->status);
     }
--=20
2.21.0


