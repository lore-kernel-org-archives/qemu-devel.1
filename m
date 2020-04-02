Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EF8C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E8A2077D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3GSzdjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E8A2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJwjD-0004o6-4s
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 06:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1jJwh3-0001RC-OI
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1jJwh2-0000Uf-CR
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38912
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1jJwh2-0000TO-8o
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585821803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kep3V9mG5AJTYZhlUeT2WOe008YTZEEiwjQV6Q9cMjM=;
 b=N3GSzdjGxmwQNtOMw63/E+cmJB8zYyTo5OltD+1NTwSMLf7QJyZlA0g6uH/9VycEWu/Qw4
 f46qZNEcl9M8LacX66ZHG/Y+IYyuPP31KsXA/sIp7amU6PMIVimw+b04QSPP9wqyDuRsrs
 Q6sat3ugFBiSpoj3QclypAPhebHjDFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-QymQzCAcOsuahTgZarNpnw-1; Thu, 02 Apr 2020 06:03:20 -0400
X-MC-Unique: QymQzCAcOsuahTgZarNpnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E27F8017F5;
 Thu,  2 Apr 2020 10:03:19 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-198.ams2.redhat.com
 [10.36.113.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4413B5DA2C;
 Thu,  2 Apr 2020 10:03:17 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 3/5] qmp: add QMP command virtio-queue-status
Date: Thu,  2 Apr 2020 12:03:00 +0200
Message-Id: <20200402100302.833267-4-lvivier@redhat.com>
In-Reply-To: <20200402100302.833267-1-lvivier@redhat.com>
References: <20200402100302.833267-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

This new command shows internal status of a VirtQueue.
(vrings and indexes).

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/virtio-stub.c |  6 +++
 hw/virtio/virtio.c      | 35 +++++++++++++++
 qapi/virtio.json        | 98 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/hw/virtio/virtio-stub.c b/hw/virtio/virtio-stub.c
index 8fe2d6cd8892..5b4ed6fd531e 100644
--- a/hw/virtio/virtio-stub.c
+++ b/hw/virtio/virtio-stub.c
@@ -17,3 +17,9 @@ VirtioStatus *qmp_virtio_status(const char* path, Error *=
*errp)
 {
     return qmp_virtio_unsupported(errp);
 }
+
+VirtQueueStatus *qmp_virtio_queue_status(const char *path, uint16_t queue,
+                                         Error **errp)
+{
+    return qmp_virtio_unsupported(errp);
+}
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 7f6e21e4ab2c..271d4ca3417f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3855,6 +3855,41 @@ static VirtIODevice *virtio_device_find(const char *=
path)
     return NULL;
 }
=20
+VirtQueueStatus *qmp_virtio_queue_status(const char *path, uint16_t queue,
+                                         Error **errp)
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
 VirtioStatus *qmp_virtio_status(const char* path, Error **errp)
 {
     VirtIODevice *vdev;
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 2af4d95b9893..ab70500d919b 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -117,3 +117,101 @@
   'data': { 'path': 'str' },
   'returns': 'VirtioStatus'
 }
+
+##
+# @VirtQueueStatus:
+#
+# Status of a VirtQueue
+#
+# @queue_index: VirtQueue queue_index
+#
+# @inuse: VirtQueue inuse
+#
+# @vring_num: VirtQueue vring.num
+#
+# @vring_num_default: VirtQueue vring.num_default
+#
+# @vring_align: VirtQueue vring.align
+#
+# @vring_desc: VirtQueue vring.desc
+#
+# @vring_avail: VirtQueue vring.avail
+#
+# @vring_used: VirtQueue vring.used
+#
+# @last_avail_idx: VirtQueue last_avail_idx
+#
+# @shadow_avail_idx: VirtQueue shadow_avail_idx
+#
+# @used_idx: VirtQueue used_idx
+#
+# @signalled_used: VirtQueue signalled_used
+#
+# @signalled_used_valid: VirtQueue signalled_used_valid
+#
+# Since: 5.1
+#
+##
+
+{ 'struct': 'VirtQueueStatus',
+  'data': {
+    'queue_index': 'uint16',
+    'inuse': 'uint32',
+    'vring_num': 'int',
+    'vring_num_default': 'int',
+    'vring_align': 'int',
+    'vring_desc': 'uint64',
+    'vring_avail': 'uint64',
+    'vring_used': 'uint64',
+    'last_avail_idx': 'uint16',
+    'shadow_avail_idx': 'uint16',
+    'used_idx': 'uint16',
+    'signalled_used': 'uint16',
+    'signalled_used_valid': 'uint16'
+  }
+}
+
+##
+# @virtio-queue-status:
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
+# -> { "execute": "virtio-queue-status",
+#      "arguments": {
+#          "path": "/machine/peripheral-anon/device[3]/virtio-backend",
+#          "queue": 0
+#      }
+#   }
+# <- { "return": {
+#      "signalled_used": 373,
+#      "inuse": 0,
+#      "vring_desc": 864411648,
+#      "vring_num_default": 256,
+#      "signalled_used_valid": 1,
+#      "vring_avail": 864415744,
+#      "last_avail_idx": 373,
+#      "queue_index": 0,
+#      "vring_used": 864416320,
+#      "shadow_avail_idx": 619,
+#      "used_idx": 373,
+#      "vring_num": 256,
+#      "vring_align": 4096
+#      }
+#    }
+#
+##
+
+{ 'command': 'virtio-queue-status',
+  'data': { 'path': 'str', 'queue': 'uint16' },
+  'returns': 'VirtQueueStatus'
+}
--=20
2.25.1


