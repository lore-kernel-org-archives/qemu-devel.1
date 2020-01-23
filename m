Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ED1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B220C24125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXJ+9z7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B220C24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufpL-0000Cd-4V
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iueET-0005nD-Eu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iueEQ-0002m6-Up
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:17:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25992
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iueEQ-0002lv-RS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579792638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aeXBkPxcRcComiL4taCcDIFuNqJYa52PmMTzUfstOgo=;
 b=WXJ+9z7Gu7RdrDuke5OjoHj+Vm61oam9X/SxW2K0skRN6g0Z+SuIdxf+V+lUGdCWDmMNdX
 vCwVK+4H66X5lU4y0x0XXB6fz3Lwsr85lJ6bqt7mJXZK0bviiF/gXSjXPoRoDDLc/e8Pc2
 lEv0EdNT94QWjBzIVy9HLCFyqf+K8t8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-e0b89CPCPfmogjhjGqHUBA-1; Thu, 23 Jan 2020 10:17:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75664190B2A9;
 Thu, 23 Jan 2020 15:17:10 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-204-119.brq.redhat.com
 [10.40.204.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A13665DA87;
 Thu, 23 Jan 2020 15:17:08 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 2/2] virtio-rng: add a control queue
Date: Thu, 23 Jan 2020 16:17:00 +0100
Message-Id: <20200123151700.1367857-3-lvivier@redhat.com>
In-Reply-To: <20200123151700.1367857-1-lvivier@redhat.com>
References: <20200123151700.1367857-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: e0b89CPCPfmogjhjGqHUBA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the linux kernel wants to switch to another device it needs
to be able to flush the on-fly requests.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/core/machine.c                           |  1 +
 hw/virtio/trace-events                      |  6 ++
 hw/virtio/virtio-rng.c                      | 81 ++++++++++++++++++++-
 include/hw/virtio/virtio-rng.h              |  3 +-
 include/standard-headers/linux/virtio_rng.h | 14 ++++
 5 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 3e288bfceb7f..6c417dbdc02a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,6 +34,7 @@ GlobalProperty hw_compat_4_2[] =3D {
     { "vhost-blk-device", "seg_max_adjust", "off"},
     { "usb-host", "suppress-remote-wake", "off" },
     { "usb-redir", "suppress-remote-wake", "off" },
+    { "virtio-rng", "ctrl-queue", "off" },
 };
 const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
=20
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index e28ba48da621..95b77f3a3056 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -38,6 +38,12 @@ virtio_rng_popped(void *rng) "rng %p: elem popped"
 virtio_rng_pushed(void *rng, size_t len) "rng %p: %zd bytes pushed"
 virtio_rng_request(void *rng, size_t size, unsigned quota) "rng %p: %zd by=
tes requested, %u bytes quota left"
 virtio_rng_vm_state_change(void *rng, int running, int state) "rng %p: sta=
te change to running %d state %d"
+virtio_rng_ctrl(void *rng) "rng %p"
+virtio_rng_ctrl_popped(void *rng) "rng %p"
+virtio_rng_ctrl_pushed(void *rng) "rng %p"
+virtio_rng_flush(void *rng) "rng %p"
+virtio_rng_flush_popped(void *rng) "rng %p"
+virtio_rng_flush_pushed(void *rng) "rng %p"
=20
 # virtio-balloon.c
 #
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index a0bca55bef55..389aa8997f3d 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -128,9 +128,76 @@ static void virtio_rng_handle_input(VirtIODevice *vdev=
, VirtQueue *vq)
     virtio_rng_process(vrng);
 }
=20
-static uint64_t get_features(VirtIODevice *vdev, uint64_t f, Error **errp)
+static virtio_rng_ctrl_ack virtio_rng_flush(VirtIORNG *vrng)
 {
-    return f;
+    VirtQueueElement *elem;
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(vrng);
+
+    trace_virtio_rng_flush(vrng);
+    while (!virtio_queue_empty(vrng->input_vq)) {
+        elem =3D virtqueue_pop(vrng->input_vq, sizeof(VirtQueueElement));
+        if (!elem) {
+            break;
+        }
+        trace_virtio_rng_flush_popped(vrng);
+        virtqueue_push(vrng->input_vq, elem, 0);
+        trace_virtio_rng_flush_pushed(vrng);
+        g_free(elem);
+    }
+    virtio_notify(vdev, vrng->input_vq);
+
+    return VIRTIO_RNG_OK;
+}
+
+static void virtio_rng_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIORNG *vrng =3D VIRTIO_RNG(vdev);
+    VirtQueueElement *elem;
+    virtio_rng_ctrl_ack status =3D VIRTIO_RNG_ERR;
+    struct virtio_rng_ctrl_hdr ctrl;
+    size_t s;
+
+    trace_virtio_rng_ctrl(vrng);
+    for (;;) {
+        elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
+        if (!elem) {
+            break;
+        }
+        trace_virtio_rng_ctrl_popped(vrng);
+
+        if (iov_size(elem->in_sg, elem->in_num) < sizeof(status) ||
+            iov_size(elem->out_sg, elem->out_num) < sizeof(ctrl)) {
+            virtio_error(vdev, "virtio-rng ctrl missing headers");
+            virtqueue_detach_element(vq, elem, 0);
+            g_free(elem);
+            break;
+        }
+
+        s =3D iov_to_buf(elem->out_sg, elem->out_num, 0, &ctrl, sizeof(ctr=
l));
+        if (s !=3D sizeof(ctrl)) {
+            status =3D VIRTIO_RNG_ERR;
+        } else if (ctrl.cmd =3D=3D VIRTIO_RNG_CMD_FLUSH) {
+            status =3D virtio_rng_flush(vrng);
+        }
+
+        s =3D iov_from_buf(elem->in_sg, elem->in_num, 0, &status, sizeof(s=
tatus));
+        assert(s =3D=3D sizeof(status));
+
+        virtqueue_push(vq, elem, sizeof(status));
+        trace_virtio_rng_ctrl_pushed(vrng);
+        virtio_notify(vdev, vq);
+        g_free(elem);
+    }
+}
+
+static uint64_t virtio_rng_get_features(VirtIODevice *vdev, uint64_t featu=
res,
+                                        Error **errp)
+{
+    VirtIORNG *vrng =3D VIRTIO_RNG(vdev);
+
+    features |=3D vrng->conf.host_features;
+
+    return features;
 }
=20
 static void virtio_rng_vm_state_change(void *opaque, int running,
@@ -221,6 +288,9 @@ static void virtio_rng_device_realize(DeviceState *dev,=
 Error **errp)
     virtio_init(vdev, "virtio-rng", VIRTIO_ID_RNG, 0);
=20
     vrng->input_vq =3D virtio_add_queue(vdev, 8, virtio_rng_handle_input);
+    if (virtio_has_feature(vrng->conf.host_features, VIRTIO_RNG_F_CTRL_VQ)=
) {
+        vrng->ctrl_vq =3D virtio_add_queue(vdev, 8, virtio_rng_handle_ctrl=
);
+    }
     vrng->quota_remaining =3D vrng->conf.max_bytes;
     vrng->rate_limit_timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                                check_rate_limit, vrng);
@@ -238,6 +308,9 @@ static void virtio_rng_device_unrealize(DeviceState *de=
v, Error **errp)
     qemu_del_vm_change_state_handler(vrng->vmstate);
     timer_del(vrng->rate_limit_timer);
     timer_free(vrng->rate_limit_timer);
+    if (virtio_has_feature(vrng->conf.host_features, VIRTIO_RNG_F_CTRL_VQ)=
) {
+        virtio_delete_queue(vrng->ctrl_vq);
+    }
     virtio_delete_queue(vrng->input_vq);
     virtio_cleanup(vdev);
 }
@@ -261,6 +334,8 @@ static Property virtio_rng_properties[] =3D {
     DEFINE_PROP_UINT64("max-bytes", VirtIORNG, conf.max_bytes, INT64_MAX),
     DEFINE_PROP_UINT32("period", VirtIORNG, conf.period_ms, 1 << 16),
     DEFINE_PROP_LINK("rng", VirtIORNG, conf.rng, TYPE_RNG_BACKEND, RngBack=
end *),
+    DEFINE_PROP_BIT64("ctrl-queue", VirtIORNG, conf.host_features,
+                      VIRTIO_RNG_F_CTRL_VQ, true),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -274,7 +349,7 @@ static void virtio_rng_class_init(ObjectClass *klass, v=
oid *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     vdc->realize =3D virtio_rng_device_realize;
     vdc->unrealize =3D virtio_rng_device_unrealize;
-    vdc->get_features =3D get_features;
+    vdc->get_features =3D virtio_rng_get_features;
     vdc->set_status =3D virtio_rng_set_status;
 }
=20
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rng.=
h
index d77daf126828..abecec7b244a 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -26,13 +26,14 @@ struct VirtIORNGConf {
     RngBackend *rng;
     uint64_t max_bytes;
     uint32_t period_ms;
+    uint64_t host_features;
 };
=20
 typedef struct VirtIORNG {
     VirtIODevice parent_obj;
=20
-    /* Only one vq - guest puts buffer(s) on it when it needs entropy */
     VirtQueue *input_vq;
+    VirtQueue *ctrl_vq;
=20
     VirtIORNGConf conf;
=20
diff --git a/include/standard-headers/linux/virtio_rng.h b/include/standard=
-headers/linux/virtio_rng.h
index 60fc798bde18..b80e9298817e 100644
--- a/include/standard-headers/linux/virtio_rng.h
+++ b/include/standard-headers/linux/virtio_rng.h
@@ -5,4 +5,18 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_config.h"
=20
+/* The features bitmap for virtuio rng */
+#define VIRTIO_RNG_F_CTRL_VQ=09=090=09/* Device has control queue */
+
+struct virtio_rng_ctrl_hdr {
+=09uint8_t cmd;
+} QEMU_PACKED;
+
+#define VIRTIO_RNG_CMD_FLUSH 0
+
+typedef uint8_t virtio_rng_ctrl_ack;
+
+#define VIRTIO_RNG_OK=090
+#define VIRTIO_RNG_ERR=091
+
 #endif /* _LINUX_VIRTIO_RNG_H */
--=20
2.23.0


