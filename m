Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F89C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4752074D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gId4pP80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4752074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJwjA-0004jF-BD
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 06:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1jJwgz-0001K3-8N
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1jJwgy-0000Rs-0s
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22083
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1jJwgx-0000RF-Pu
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585821799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3I/cokbs6mFo+fIVGu+390hXkIUUIIvuyOMxyh2eEc=;
 b=gId4pP804dH1TjfLzNfD6e8PAhCiwXInsnZCI/kAgEvFX9EkBtHZNnPXTetIhxrKw0JtX9
 PoMMEt0g5NFwiqz6GVyMYsmCvVF1LFtUXWecOrxuWTZ2l2jYeCbUs63YdBw4lvgr3eZTyS
 0m4jHc5CHnXWoZXKNDRQFl7y3IvIjB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-1hTzJb0ZOhS8NcwnyZgGbA-1; Thu, 02 Apr 2020 06:03:17 -0400
X-MC-Unique: 1hTzJb0ZOhS8NcwnyZgGbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFBE018A5526;
 Thu,  2 Apr 2020 10:03:16 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-198.ams2.redhat.com
 [10.36.113.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B34E75DA66;
 Thu,  2 Apr 2020 10:03:14 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 2/5] qmp: add QMP command virtio-status
Date: Thu,  2 Apr 2020 12:02:59 +0200
Message-Id: <20200402100302.833267-3-lvivier@redhat.com>
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

This new command shows the status of a VirtIODevice
(features, endianness and number of virtqueues)

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/virtio-stub.c |  5 ++++
 hw/virtio/virtio.c      | 51 ++++++++++++++++++++++++++++++++
 qapi/virtio.json        | 65 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)

diff --git a/hw/virtio/virtio-stub.c b/hw/virtio/virtio-stub.c
index d9e4a815ecf1..8fe2d6cd8892 100644
--- a/hw/virtio/virtio-stub.c
+++ b/hw/virtio/virtio-stub.c
@@ -12,3 +12,8 @@ VirtioInfoList *qmp_query_virtio(Error **errp)
 {
     return qmp_virtio_unsupported(errp);
 }
+
+VirtioStatus *qmp_virtio_status(const char* path, Error **errp)
+{
+    return qmp_virtio_unsupported(errp);
+}
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3cebc3d169c8..7f6e21e4ab2c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3839,6 +3839,57 @@ VirtioInfoList *qmp_query_virtio(Error **errp)
     return list;
 }
=20
+static VirtIODevice *virtio_device_find(const char *path)
+{
+    VirtIODevice *vdev;
+
+    QTAILQ_FOREACH(vdev, &virtio_list, next) {
+        DeviceState *dev =3D DEVICE(vdev);
+
+        if (strcmp(dev->canonical_path, path) !=3D 0) {
+            continue;
+        }
+        return vdev;
+    }
+
+    return NULL;
+}
+
+VirtioStatus *qmp_virtio_status(const char* path, Error **errp)
+{
+    VirtIODevice *vdev;
+    VirtioStatus *status;
+
+    vdev =3D virtio_device_find(path);
+    if (vdev =3D=3D NULL) {
+        error_setg(errp, "Path %s is not a VirtIO device", path);
+        return NULL;
+    }
+
+    status =3D g_new0(VirtioStatus, 1);
+    status->guest_features =3D vdev->guest_features;
+    status->host_features =3D vdev->host_features;
+    status->backend_features =3D vdev->backend_features;
+    status->device_id =3D vdev->device_id;
+
+    switch (vdev->device_endian) {
+    case VIRTIO_DEVICE_ENDIAN_LITTLE:
+        status->device_endian =3D g_strdup("little");
+        break;
+    case VIRTIO_DEVICE_ENDIAN_BIG:
+        status->device_endian =3D g_strdup("big");
+        break;
+    case VIRTIO_DEVICE_ENDIAN_UNKNOWN:
+    default:
+        status->device_endian =3D g_strdup("unknown");
+        break;
+    }
+
+    status->num_vqs =3D virtio_get_num_queues(vdev);
+
+    return status;
+}
+
 static const TypeInfo virtio_device_info =3D {
     .name =3D TYPE_VIRTIO_DEVICE,
     .parent =3D TYPE_DEVICE,
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 2a95d08a8b9e..2af4d95b9893 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -52,3 +52,68 @@
 ##
=20
 { 'command': 'query-virtio', 'returns': ['VirtioInfo'] }
+
+##
+# @VirtioStatus:
+#
+# @device_id: VirtIODevice status
+#
+# @device_endian: VirtIODevice device_endian
+#
+# @guest_features: VirtIODevice guest_features
+#
+# @host_features: VirtIODevice host_features
+#
+# @backend_features: VirtIODevice backend_features
+#
+# @num_vqs: number of VirtIODevice queues
+#
+# Since: 5.1
+#
+##
+
+{ 'struct': 'VirtioStatus',
+  'data': {
+    'device_id': 'int',
+    'device_endian': 'str',
+    'guest_features': 'uint64',
+    'host_features': 'uint64',
+    'backend_features': 'uint64',
+    'num_vqs': 'uint16'
+  }
+}
+
+##
+# @virtio-status:
+#
+# Return the status of virtio device
+#
+# @path: QOBject path of the VirtIODevice
+#
+# Returns: status of the VirtIODevice
+#
+# Since: 5.1
+#
+# Example:
+#
+# -> { "execute": "virtio-status",
+#      "arguments": {
+#          "path": "/machine/peripheral-anon/device[3]/virtio-backend"
+#      }
+#   }
+# <- { "return": {
+#          "backend_features": 0,
+#          "guest_features": 5111807911,
+#          "num_vqs": 3,
+#          "host_features": 6337593319,
+#          "device_endian": "little",
+#          "device_id": 1
+#      }
+#    }
+#
+##
+
+{ 'command': 'virtio-status',
+  'data': { 'path': 'str' },
+  'returns': 'VirtioStatus'
+}
--=20
2.25.1


