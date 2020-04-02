Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87D2C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FE72077D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvbYu3Tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FE72077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJwi1-0002rm-9m
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 06:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1jJwh6-0001WE-QP
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1jJwh5-0000Vc-2a
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35739
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1jJwh4-0000VR-Us
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585821806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y90R9B+sf9jiqO/bPRDIc8KgaAKqA+0F5s8vPipXh24=;
 b=DvbYu3Tc0oM1wq6Ce1jZGjJDmlLqSz4+pnk/OTazh6a1jk2pz/4vDd96Dj2NSZ/Gw7pLNN
 T4Ejq8gWtjeSw9zQsWFthXUSS5cgxAXeEMgUUK5GtcDVBndPOzfrityagDjj7ZVZx0Ndeu
 Hr65yquq/77blVWuy3sqw3gjZfbCOTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-pl439HljPsKIi2N_sKJEZQ-1; Thu, 02 Apr 2020 06:03:23 -0400
X-MC-Unique: pl439HljPsKIi2N_sKJEZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 353B48017F3;
 Thu,  2 Apr 2020 10:03:22 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-198.ams2.redhat.com
 [10.36.113.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E399A5DA76;
 Thu,  2 Apr 2020 10:03:19 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 4/5] qmp: add QMP command virtio-queue-element
Date: Thu,  2 Apr 2020 12:03:01 +0200
Message-Id: <20200402100302.833267-5-lvivier@redhat.com>
In-Reply-To: <20200402100302.833267-1-lvivier@redhat.com>
References: <20200402100302.833267-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This new command shows the information of a VirtQueue element.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/virtio-stub.c |  7 ++++
 hw/virtio/virtio.c      | 85 +++++++++++++++++++++++++++++++++++++++++
 qapi/virtio.json        | 85 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)

diff --git a/hw/virtio/virtio-stub.c b/hw/virtio/virtio-stub.c
index 5b4ed6fd531e..693f5eac409f 100644
--- a/hw/virtio/virtio-stub.c
+++ b/hw/virtio/virtio-stub.c
@@ -23,3 +23,10 @@ VirtQueueStatus *qmp_virtio_queue_status(const char *pat=
h, uint16_t queue,
 {
     return qmp_virtio_unsupported(errp);
 }
+
+VirtioQueueElement *qmp_virtio_queue_element(const char* path, uint16_t qu=
eue,
+                                             bool has_index, uint16_t inde=
x,
+                                             Error **errp)
+{
+    return qmp_virtio_unsupported(errp);
+}
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 271d4ca3417f..28848b9e64cf 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3925,6 +3925,91 @@ VirtioStatus *qmp_virtio_status(const char* path, Er=
ror **errp)
     return status;
 }
=20
+VirtioQueueElement *qmp_virtio_queue_element(const char* path, uint16_t qu=
eue,
+                                             bool has_index, uint16_t inde=
x,
+                                             Error **errp)
+{
+    VirtIODevice *vdev;
+    VirtQueue *vq;
+    VirtioQueueElement *element;
+
+    vdev =3D virtio_device_find(path);
+    if (vdev =3D=3D NULL) {
+        error_setg(errp, "Path %s is not a VirtIO device", path);
+        return NULL;
+    }
+
+    if (queue >=3D VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, queue))=
 {
+        error_setg(errp, "Invalid virtqueue number %d", queue);
+        return NULL;
+    }
+    vq =3D &vdev->vq[queue];
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        error_setg(errp, "Packed ring not supported");
+        return NULL;
+    } else {
+        unsigned int head, i, max;
+        VRingMemoryRegionCaches *caches;
+        MemoryRegionCache *desc_cache;
+        VRingDesc desc;
+
+        RCU_READ_LOCK_GUARD();
+        if (virtio_queue_empty_rcu(vq)) {
+            error_setg(errp, "Queue is empty");
+            return NULL;
+        }
+        /*
+         * Needed after virtio_queue_empty(), see comment in
+         * virtqueue_num_heads().
+         */
+        smp_rmb();
+
+        max =3D vq->vring.num;
+
+        if (vq->inuse >=3D vq->vring.num) {
+            error_setg(errp, "Queue size exceeded");
+            return NULL;
+        }
+
+        if (!has_index) {
+            head =3D vring_avail_ring(vq, vq->last_avail_idx % vq->vring.n=
um);
+        } else {
+            head =3D vring_avail_ring(vq, index % vq->vring.num);
+        }
+        i =3D head;
+
+        caches =3D vring_get_region_caches(vq);
+        if (!caches) {
+            error_setg(errp, "Region caches not initialized");
+            return NULL;
+        }
+
+        if (caches->desc.len < max * sizeof(VRingDesc)) {
+            error_setg(errp, "Cannot map descriptor ring");
+            return NULL;
+        }
+
+        desc_cache =3D &caches->desc;
+        vring_split_desc_read(vdev, &desc, desc_cache, i);
+        if (desc.flags & VRING_DESC_F_INDIRECT) {
+            error_setg(errp, "Unsupported indirect buffer feature");
+            return NULL;
+        }
+
+        element =3D g_new0(VirtioQueueElement, 1);
+        element->index =3D head;
+        element->ndescs =3D 1;
+        element->descs =3D g_new0(VirtioRingDescList, 1);
+        element->descs->value =3D g_new0(VirtioRingDesc, 1);
+        element->descs->value->addr =3D desc.addr;
+        element->descs->value->len =3D desc.len;
+        element->descs->value->flags =3D desc.flags;
+    }
+
+    return element;
+}
+
 static const TypeInfo virtio_device_info =3D {
     .name =3D TYPE_VIRTIO_DEVICE,
     .parent =3D TYPE_DEVICE,
diff --git a/qapi/virtio.json b/qapi/virtio.json
index ab70500d919b..3e8865511217 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -215,3 +215,88 @@
   'data': { 'path': 'str', 'queue': 'uint16' },
   'returns': 'VirtQueueStatus'
 }
+
+##
+# @VirtioRingDesc:
+#
+# @addr: guest physical address of the descriptor data
+#
+# @len: length of the descriptor data
+#
+# @flags: descriptor flags (write-only, read-only, ...)
+#
+# Since: 5.1
+#
+##
+
+{ 'struct': 'VirtioRingDesc',
+  'data': {
+    'addr': 'uint64',
+    'len': 'uint32',
+    'flags': 'uint16'
+  }
+}
+
+##
+# @VirtioQueueElement:
+#
+# @index: index of the element in the queue
+#
+# @len: length of the element data
+#
+# @ndescs: number of descriptors
+#
+# @descs: list of the descriptors
+#
+# Since: 5.1
+#
+##
+
+{ 'struct': 'VirtioQueueElement',
+  'data': {
+    'index': 'uint32',
+    'len': 'uint32',
+    'ndescs': 'uint32',
+    'descs': ['VirtioRingDesc']
+  }
+}
+
+##
+# @virtio-queue-element:
+#
+# Return the information about an element queue (by default head)
+#
+# @path: QOBject path of the VirtIODevice
+#
+# @queue: queue number to examine
+#
+# @index: the index in the queue, by default head
+#
+# Returns: the element information
+#
+# Since: 5.1
+#
+# Example:
+#
+# -> { "execute": "virtio-queue-element",
+#      "arguments": {
+#          "path": "/machine/peripheral-anon/device[3]/virtio-backend",
+#          "queue": 0
+#      }
+#   }
+# -> { "return": {
+#         "index": 109,
+#         "len": 0,
+#         "ndescs": 1,
+#         "descs": [
+#             { "flags": 2, "len": 2048, "addr": 853145600 }
+#         ]
+#      }
+#   }
+#
+##
+
+{ 'command': 'virtio-queue-element',
+  'data': { 'path': 'str', 'queue': 'uint16', '*index': 'uint16' },
+  'returns': 'VirtioQueueElement'
+}
--=20
2.25.1


