Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C252C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1083E2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Evxa8A3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1083E2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWh0q-0006wj-7x
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 09:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jWguY-0005B0-8K
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:50:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37078
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jWguV-0004Fs-Pg
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588859398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k3Z66kkuiR9aG62JuAgsT0L+YxBIBApb6k2KUo4EdNc=;
 b=Evxa8A3AmIzB4PUg8H7T7v915bQF61D5RxtfXvLrmpf1jLMj1TLlRtFM/lJILRN6et8VLh
 ms9iavQgPNr79G52nGYqZ3jCaY7ahpyubXY20VGDxLK+k9WJSkzsTEt6tCovu+iHGfOR8j
 0tIDSvAHMAMWRxEzpreCbfXJRUD/tFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-EbLiiLPFPme6a93fqTBVbQ-1; Thu, 07 May 2020 09:49:55 -0400
X-MC-Unique: EbLiiLPFPme6a93fqTBVbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B2AB872FE1;
 Thu,  7 May 2020 13:49:54 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-114-199.ams2.redhat.com
 [10.36.114.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E92E10013BD;
 Thu,  7 May 2020 13:49:33 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: lvivier@redhat.com,
	qemu-devel@nongnu.org
Subject: [RFC v4 4/6] qmp: add QMP command x-debug-virtio-queue-status
Date: Thu,  7 May 2020 15:47:58 +0200
Message-Id: <20200507134800.10837-5-lvivier@redhat.com>
In-Reply-To: <20200507134800.10837-1-lvivier@redhat.com>
References: <20200507134800.10837-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This new command shows internal status of a VirtQueue.
(vrings and indexes).

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/virtio-stub.c |  6 +++
 hw/virtio/virtio.c      | 35 +++++++++++++++
 qapi/virtio.json        | 98 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/hw/virtio/virtio-stub.c b/hw/virtio/virtio-stub.c
index ddb592f72eee..3c1bf172acf6 100644
--- a/hw/virtio/virtio-stub.c
+++ b/hw/virtio/virtio-stub.c
@@ -17,3 +17,9 @@ VirtioStatus *qmp_x_debug_virtio_status(const char* path,=
 Error **errp)
 {
     return qmp_virtio_unsupported(errp);
 }
+
+VirtQueueStatus *qmp_x_debug_virtio_queue_status(const char *path,
+                                                 uint16_t queue, Error **e=
rrp)
+{
+    return qmp_virtio_unsupported(errp);
+}
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 59bf6ef651a6..57552bf05014 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3877,6 +3877,41 @@ static VirtIODevice *virtio_device_find(const char *=
path)
     return NULL;
 }
=20
+VirtQueueStatus *qmp_x_debug_virtio_queue_status(const char *path,
+                                                 uint16_t queue, Error **e=
rrp)
+{
+    VirtIODevice *vdev;
+    VirtQueueStatus *status;
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
+
+    status =3D g_new0(VirtQueueStatus, 1);
+    status->queue_index =3D vdev->vq[queue].queue_index;
+    status->inuse =3D vdev->vq[queue].inuse;
+    status->vring_num =3D vdev->vq[queue].vring.num;
+    status->vring_num_default =3D vdev->vq[queue].vring.num_default;
+    status->vring_align =3D vdev->vq[queue].vring.align;
+    status->vring_desc =3D vdev->vq[queue].vring.desc;
+    status->vring_avail =3D vdev->vq[queue].vring.avail;
+    status->vring_used =3D vdev->vq[queue].vring.used;
+    status->last_avail_idx =3D vdev->vq[queue].last_avail_idx;
+    status->shadow_avail_idx =3D vdev->vq[queue].shadow_avail_idx;
+    status->used_idx =3D vdev->vq[queue].used_idx;
+    status->signalled_used =3D vdev->vq[queue].signalled_used;
+    status->signalled_used_valid =3D vdev->vq[queue].signalled_used_valid;
+
+    return status;
+}
+
 #define CONVERT_FEATURES(type, map)                \
     ({                                           \
         type *list =3D NULL;                         \
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 69dd107d0c9b..43c234a9fc69 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -308,3 +308,101 @@
   'data': { 'path': 'str' },
   'returns': 'VirtioStatus'
 }
+
+##
+# @VirtQueueStatus:
+#
+# Status of a VirtQueue
+#
+# @queue-index: VirtQueue queue_index
+#
+# @inuse: VirtQueue inuse
+#
+# @vring-num: VirtQueue vring.num
+#
+# @vring-num-default: VirtQueue vring.num_default
+#
+# @vring-align: VirtQueue vring.align
+#
+# @vring-desc: VirtQueue vring.desc
+#
+# @vring-avail: VirtQueue vring.avail
+#
+# @vring-used: VirtQueue vring.used
+#
+# @last-avail-idx: VirtQueue last_avail_idx
+#
+# @shadow-avail-idx: VirtQueue shadow_avail_idx
+#
+# @used-idx: VirtQueue used_idx
+#
+# @signalled-used: VirtQueue signalled_used
+#
+# @signalled-used-valid: VirtQueue signalled_used_valid
+#
+# Since: 5.1
+#
+##
+
+{ 'struct': 'VirtQueueStatus',
+  'data': {
+    'queue-index': 'uint16',
+    'inuse': 'uint32',
+    'vring-num': 'int',
+    'vring-num-default': 'int',
+    'vring-align': 'int',
+    'vring-desc': 'uint64',
+    'vring-avail': 'uint64',
+    'vring-used': 'uint64',
+    'last-avail-idx': 'uint16',
+    'shadow-avail-idx': 'uint16',
+    'used-idx': 'uint16',
+    'signalled-used': 'uint16',
+    'signalled-used-valid': 'uint16'
+  }
+}
+
+##
+# @x-debug-virtio-queue-status:
+#
+# Return the status of a given VirtQueue
+#
+# @path: QOBject path of the VirtIODevice
+#
+# @queue: queue number to examine
+#
+# Returns: Status of the VirtQueue
+#
+# Since: 5.1
+#
+# Example:
+#
+# -> { "execute": "x-debug-virtio-queue-status",
+#      "arguments": {
+#          "path": "/machine/peripheral-anon/device[3]/virtio-backend",
+#          "queue": 0
+#      }
+#   }
+# <- { "return": {
+#      "signalled-used": 373,
+#      "inuse": 0,
+#      "vring-desc": 864411648,
+#      "vring-num-default": 256,
+#      "signalled-used-valid": 1,
+#      "vring-avail": 864415744,
+#      "last-avail-idx": 373,
+#      "queue-index": 0,
+#      "vring-used": 864416320,
+#      "shadow-avail-idx": 619,
+#      "used-idx": 373,
+#      "vring-num": 256,
+#      "vring-align": 4096
+#      }
+#    }
+#
+##
+
+{ 'command': 'x-debug-virtio-queue-status',
+  'data': { 'path': 'str', 'queue': 'uint16' },
+  'returns': 'VirtQueueStatus'
+}
--=20
2.26.2


