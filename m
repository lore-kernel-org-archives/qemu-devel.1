Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83ADC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2ED205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBahea8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2ED205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQTvt-0007yf-OB
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 06:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58212 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1jQTuC-0006Fz-1h
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:44:00 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1jQTuB-0007A3-AW
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:43:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49025
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jQTuA-00078n-SX
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587379438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68zcpC9k81t800nLNJDYA9V3jbLASwP5qT+sd5lfxSI=;
 b=KBahea8oH1Saa5Q6Cg9fA2u97UBGvMjC6tCgE2HBl9OoRsBTKnVATQ6Sj+G6i40PKmuxtA
 Rmuayo5/CzneKhxdU30lZeGaFCo8qF8yuJGbr+WJjNjgyyayjKPNjuYaBnASgQruAjxHyV
 mZLAewSDpjisjX4Z+Ezs3CX+nTveuvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-wGhhSnn5N3eu_PEBznCHsw-1; Mon, 20 Apr 2020 06:43:54 -0400
X-MC-Unique: wGhhSnn5N3eu_PEBznCHsw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87F8C18CA240;
 Mon, 20 Apr 2020 10:43:53 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-114-254.ams2.redhat.com
 [10.36.114.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD9455DA76;
 Mon, 20 Apr 2020 10:43:32 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC v2 5/6] qmp: add QMP command virtio-queue-element
Date: Mon, 20 Apr 2020 12:41:44 +0200
Message-Id: <20200420104145.205297-6-lvivier@redhat.com>
In-Reply-To: <20200420104145.205297-1-lvivier@redhat.com>
References: <20200420104145.205297-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lvivier@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:32:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Amit Shah <amit@kernel.org>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This new command shows the information of a VirtQueue element.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v2: don't check if the queue is empty to allow to display
        old elements
        use enum for desc flags
        manage indirect desc

 hw/virtio/virtio-stub.c |   7 +++
 hw/virtio/virtio.c      | 128 ++++++++++++++++++++++++++++++++++++++++
 qapi/virtio.json        |  94 +++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)

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
index dd0b57fb9441..cb2d6c605372 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4033,6 +4033,134 @@ VirtioStatus *qmp_virtio_status(const char* path, E=
rror **errp)
     return status;
 }
=20
+static VirtioRingDescFlagsList *qmp_decode_vring_desc_flags(uint16_t flags=
)
+{
+    VirtioRingDescFlagsList *list =3D NULL;
+    VirtioRingDescFlagsList *node;
+    int i;
+    struct {
+        uint16_t flag;
+        VirtioRingDescFlags value;
+    } map[] =3D {
+        { VRING_DESC_F_NEXT, VIRTIO_RING_DESC_FLAGS_NEXT },
+        { VRING_DESC_F_WRITE, VIRTIO_RING_DESC_FLAGS_WRITE },
+        { VRING_DESC_F_INDIRECT, VIRTIO_RING_DESC_FLAGS_INDIRECT },
+        { 1 << VRING_PACKED_DESC_F_AVAIL, VIRTIO_RING_DESC_FLAGS_AVAIL },
+        { 1 << VRING_PACKED_DESC_F_USED, VIRTIO_RING_DESC_FLAGS_USED },
+        { 0, -1 }
+    };
+
+    for (i =3D 0; map[i].flag; i++) {
+        if ((map[i].flag & flags) =3D=3D 0) {
+            continue;
+        }
+        node =3D g_malloc0(sizeof(VirtioRingDescFlagsList));
+        node->value =3D map[i].value;
+        node->next =3D list;
+        list =3D node;
+    }
+
+    return list;
+}
+
+VirtioQueueElement *qmp_virtio_queue_element(const char* path, uint16_t qu=
eue,
+                                             bool has_index, uint16_t inde=
x,
+                                             Error **errp)
+{
+    VirtIODevice *vdev;
+    VirtQueue *vq;
+    VirtioQueueElement *element =3D NULL;
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
+        MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INVA=
LID;
+        MemoryRegionCache *desc_cache;
+        VRingDesc desc;
+        VirtioRingDescList *list =3D NULL;
+        VirtioRingDescList *node;
+        int rc;
+
+        RCU_READ_LOCK_GUARD();
+
+        max =3D vq->vring.num;
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
+            int64_t len;
+
+            len =3D address_space_cache_init(&indirect_desc_cache, vdev->d=
ma_as,
+                                           desc.addr, desc.len, false);
+            desc_cache =3D &indirect_desc_cache;
+            if (len < desc.len) {
+                error_setg(errp, "Cannot map indirect buffer");
+                goto done;
+            }
+            i =3D 0;
+            vring_split_desc_read(vdev, &desc, desc_cache, i);
+        }
+
+        element =3D g_new0(VirtioQueueElement, 1);
+        element->index =3D head;
+        element->ndescs =3D 0;
+
+        do {
+            node =3D g_new0(VirtioRingDescList, 1);
+            node->value =3D g_new0(VirtioRingDesc, 1);
+            node->value->addr =3D desc.addr;
+            node->value->len =3D desc.len;
+            node->value->flags =3D qmp_decode_vring_desc_flags(desc.flags)=
;
+            node->next =3D list;
+            list =3D node;
+
+            element->ndescs++;
+
+            rc =3D virtqueue_split_read_next_desc(vdev, &desc, desc_cache,
+                                                max, &i);
+        } while (rc =3D=3D VIRTQUEUE_READ_DESC_MORE);
+
+        element->descs =3D list;
+done:
+        address_space_cache_destroy(&indirect_desc_cache);
+    }
+
+    return element;
+}
+
 static const TypeInfo virtio_device_info =3D {
     .name =3D TYPE_VIRTIO_DEVICE,
     .parent =3D TYPE_DEVICE,
diff --git a/qapi/virtio.json b/qapi/virtio.json
index a53a6609567a..c9c1d19cb038 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -406,3 +406,97 @@
   'data': { 'path': 'str', 'queue': 'uint16' },
   'returns': 'VirtQueueStatus'
 }
+
+##
+# @VirtioRingDescFlags:
+#
+# An enumeration of the virtio ring descriptor flags
+#
+# Since: 5.1
+#
+##
+
+{ 'enum': 'VirtioRingDescFlags',
+  'data': [ 'next', 'write', 'indirect', 'avail', 'used' ]
+}
+
+##
+# @VirtioRingDesc:
+#
+# @addr: guest physical address of the descriptor data
+#
+# @len: length of the descriptor data
+#
+# @flags: descriptor flags
+#
+# Since: 5.1
+#
+##
+
+{ 'struct': 'VirtioRingDesc',
+  'data': {
+    'addr': 'uint64',
+    'len': 'uint32',
+    'flags': [ 'VirtioRingDescFlags' ]
+  }
+}
+
+##
+# @VirtioQueueElement:
+#
+# @index: index of the element in the queue
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
+#         "index": 24,
+#         "ndescs": 1,
+#         "descs": [
+#             { "flags": ["write"], "len": 1536, "addr": 2027557376 }
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
2.25.2


