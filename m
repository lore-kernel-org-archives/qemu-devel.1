Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D1BC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3622073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4PnygfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3622073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWgz9-0003iX-J9
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 09:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jWgto-0004Cm-RB
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:49:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56095
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jWgtm-0003se-Rz
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588859353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZ9Pe/WVczrEDvhE3PiCnPpVn9zjTs2i3Rv4vtfTtuc=;
 b=K4PnygfJORNWcAuDO8we35Xv0nmk5WmVB9VFkHIjXQpMvxv+Tg+d25MNdsFyxJLS9jdUBr
 zWEXdpksIiFGDLiEmGhP9dPQWoHfCPXqbK1mHZ2ulerTXRcP8SjQlB+Qyos6zWAVTCHWGq
 ye87wLqOTUhWR43dFPA8lu50Kgv/3Qo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-O0QCBrzBPWOGXjXupxifJg-1; Thu, 07 May 2020 09:49:11 -0400
X-MC-Unique: O0QCBrzBPWOGXjXupxifJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 470DE460;
 Thu,  7 May 2020 13:49:10 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-114-199.ams2.redhat.com
 [10.36.114.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA45510013BD;
 Thu,  7 May 2020 13:48:48 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: lvivier@redhat.com,
	qemu-devel@nongnu.org
Subject: [RFC v4 2/6] qmp: add QMP command x-debug-virtio-status
Date: Thu,  7 May 2020 15:47:56 +0200
Message-Id: <20200507134800.10837-3-lvivier@redhat.com>
In-Reply-To: <20200507134800.10837-1-lvivier@redhat.com>
References: <20200507134800.10837-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lvivier@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
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

This new command shows the status of a VirtIODevice
(features, endianness and number of virtqueues)

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/virtio-stub.c |  5 +++
 hw/virtio/virtio.c      | 50 +++++++++++++++++++++++++++
 qapi/virtio.json        | 76 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)

diff --git a/hw/virtio/virtio-stub.c b/hw/virtio/virtio-stub.c
index d4a88f5753a9..ddb592f72eee 100644
--- a/hw/virtio/virtio-stub.c
+++ b/hw/virtio/virtio-stub.c
@@ -12,3 +12,8 @@ VirtioInfoList *qmp_x_debug_query_virtio(Error **errp)
 {
     return qmp_virtio_unsupported(errp);
 }
+
+VirtioStatus *qmp_x_debug_virtio_status(const char* path, Error **errp)
+{
+    return qmp_virtio_unsupported(errp);
+}
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 05b640bcc267..af69e874258d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3840,6 +3840,56 @@ VirtioInfoList *qmp_x_debug_query_virtio(Error **err=
p)
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
+VirtioStatus *qmp_x_debug_virtio_status(const char* path, Error **errp)
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
+        status->device_endian =3D VIRTIO_STATUS_ENDIANNESS_LITTLE;
+        break;
+    case VIRTIO_DEVICE_ENDIAN_BIG:
+        status->device_endian =3D VIRTIO_STATUS_ENDIANNESS_BIG;
+        break;
+    default:
+        status->device_endian =3D VIRTIO_STATUS_ENDIANNESS_UNKNOWN;
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
index da59a118dbfb..9142818d198c 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -66,3 +66,79 @@
 ##
=20
 { 'command': 'x-debug-query-virtio', 'returns': ['VirtioInfo'] }
+
+##
+# @VirtioStatusEndianness:
+#
+# Enumeration of endianness for VirtioDevice
+#
+# Since: 5.1
+##
+{ 'enum': 'VirtioStatusEndianness',
+  'data': [ 'unknown', 'little', 'big' ]
+}
+
+##
+# @VirtioStatus:
+#
+# @device-id: VirtIODevice status
+#
+# @device-endian: VirtIODevice device_endian
+#
+# @guest-features: VirtIODevice guest_features
+#
+# @host-features: VirtIODevice host_features
+#
+# @backend-features: VirtIODevice backend_features
+#
+# @num-vqs: number of VirtIODevice queues
+#
+# Since: 5.1
+#
+##
+
+{ 'struct': 'VirtioStatus',
+  'data': {
+    'device-id': 'int',
+    'device-endian': 'VirtioStatusEndianness',
+    'guest-features': 'uint64',
+    'host-features': 'uint64',
+    'backend-features': 'uint64',
+    'num-vqs': 'uint16'
+  }
+}
+
+##
+# @x-debug-virtio-status:
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
+# -> { "execute": "x-debug-virtio-status",
+#      "arguments": {
+#          "path": "/machine/peripheral-anon/device[3]/virtio-backend"
+#      }
+#   }
+# <- { "return": {
+#          "backend-features": 0,
+#          "guest-features": 5111807911,
+#          "num-vqs": 3,
+#          "host-features": 6337593319,
+#          "device-endian": "little",
+#          "device-id": 1
+#      }
+#    }
+#
+##
+
+{ 'command': 'x-debug-virtio-status',
+  'data': { 'path': 'str' },
+  'returns': 'VirtioStatus'
+}
--=20
2.26.2


