Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CAAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1369021569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/EqqGoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1369021569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugHe-0002iU-GZ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iueEM-0005eF-J1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iueEL-0002iH-8R
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:17:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27943
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iueEL-0002i0-5F
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579792632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6tLMZZuLaHZ7+9S5a5Q4dO5dyShTG2/4H+EPaxCb43s=;
 b=R/EqqGocI37H/V32OASl9/RlETDeLFI5cLptqtdy5rikpoNkmgVfRRjAVC6Exe0Z6a6qtI
 sHq8QxvJ/N1L1SCRZgQfPuzUIQ6lIAnf2hQxGSMS48cWGqmIJpTXyCSj9x8hGtg3CEiu8/
 Q07KyCr/Yt9vSxXfjGAClvtpW0rCXz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-BpVsLgrlMyeEa2jOq8f8OA-1; Thu, 23 Jan 2020 10:17:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A5F2106BC2A;
 Thu, 23 Jan 2020 15:17:08 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-204-119.brq.redhat.com
 [10.40.204.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 661F15DAA4;
 Thu, 23 Jan 2020 15:17:06 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 1/2] virtio-rng: prepare the introduction of a control queue
Date: Thu, 23 Jan 2020 16:16:59 +0100
Message-Id: <20200123151700.1367857-2-lvivier@redhat.com>
In-Reply-To: <20200123151700.1367857-1-lvivier@redhat.com>
References: <20200123151700.1367857-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: BpVsLgrlMyeEa2jOq8f8OA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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

Rename the existing vq to input_vq and use virtio_delete_queue()
rather than virtio_del_queue().

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/virtio-rng.c         | 18 +++++++++---------
 include/hw/virtio/virtio-rng.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index b498a2033263..a0bca55bef55 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -25,7 +25,7 @@
 static bool is_guest_ready(VirtIORNG *vrng)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(vrng);
-    if (virtio_queue_ready(vrng->vq)
+    if (virtio_queue_ready(vrng->input_vq)
         && (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
         return true;
     }
@@ -69,7 +69,7 @@ static void chr_read(void *opaque, const void *buf, size_=
t size)
=20
     offset =3D 0;
     while (offset < size) {
-        elem =3D virtqueue_pop(vrng->vq, sizeof(VirtQueueElement));
+        elem =3D virtqueue_pop(vrng->input_vq, sizeof(VirtQueueElement));
         if (!elem) {
             break;
         }
@@ -78,13 +78,13 @@ static void chr_read(void *opaque, const void *buf, siz=
e_t size)
                            0, buf + offset, size - offset);
         offset +=3D len;
=20
-        virtqueue_push(vrng->vq, elem, len);
+        virtqueue_push(vrng->input_vq, elem, len);
         trace_virtio_rng_pushed(vrng, len);
         g_free(elem);
     }
-    virtio_notify(vdev, vrng->vq);
+    virtio_notify(vdev, vrng->input_vq);
=20
-    if (!virtio_queue_empty(vrng->vq)) {
+    if (!virtio_queue_empty(vrng->input_vq)) {
         /* If we didn't drain the queue, call virtio_rng_process
          * to take care of asking for more data as appropriate.
          */
@@ -112,7 +112,7 @@ static void virtio_rng_process(VirtIORNG *vrng)
     } else {
         quota =3D MIN((uint64_t)vrng->quota_remaining, (uint64_t)UINT32_MA=
X);
     }
-    size =3D get_request_size(vrng->vq, quota);
+    size =3D get_request_size(vrng->input_vq, quota);
=20
     trace_virtio_rng_request(vrng, size, quota);
=20
@@ -122,7 +122,7 @@ static void virtio_rng_process(VirtIORNG *vrng)
     }
 }
=20
-static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
+static void virtio_rng_handle_input(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIORNG *vrng =3D VIRTIO_RNG(vdev);
     virtio_rng_process(vrng);
@@ -220,7 +220,7 @@ static void virtio_rng_device_realize(DeviceState *dev,=
 Error **errp)
=20
     virtio_init(vdev, "virtio-rng", VIRTIO_ID_RNG, 0);
=20
-    vrng->vq =3D virtio_add_queue(vdev, 8, handle_input);
+    vrng->input_vq =3D virtio_add_queue(vdev, 8, virtio_rng_handle_input);
     vrng->quota_remaining =3D vrng->conf.max_bytes;
     vrng->rate_limit_timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                                check_rate_limit, vrng);
@@ -238,7 +238,7 @@ static void virtio_rng_device_unrealize(DeviceState *de=
v, Error **errp)
     qemu_del_vm_change_state_handler(vrng->vmstate);
     timer_del(vrng->rate_limit_timer);
     timer_free(vrng->rate_limit_timer);
-    virtio_del_queue(vdev, 0);
+    virtio_delete_queue(vrng->input_vq);
     virtio_cleanup(vdev);
 }
=20
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rng.=
h
index bd05d734b87d..d77daf126828 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -32,7 +32,7 @@ typedef struct VirtIORNG {
     VirtIODevice parent_obj;
=20
     /* Only one vq - guest puts buffer(s) on it when it needs entropy */
-    VirtQueue *vq;
+    VirtQueue *input_vq;
=20
     VirtIORNGConf conf;
=20
--=20
2.23.0


