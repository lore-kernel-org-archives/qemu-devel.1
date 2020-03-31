Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E6BC2D0E8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CABAD20B80
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3sRsyK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABAD20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJBpv-0005hy-19
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jJBnv-0004Jb-1b
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jJBnu-0002Nn-4G
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:59:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59065
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jJBnu-0002N9-0i
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585641560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s1tFEKlyjDQ9zhIy7PWTrqY99x9gUcOyNdcdTidqZf4=;
 b=W3sRsyK0dADAjUXJoY08xB3VQNHfkwSUsvIj9g48S1DD0lMyhaS1X1QIJT4wIcOqVeOSE7
 9ONmXyqD4iiVw47tifp4pvj9AQSP/kjrlNLhBA/PsZKqA3zLZzYmUFsXsEvsobczsbprdf
 qSlJUZqGzp9NQW2tszIKq6RDAFcVUGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-n0fwKjrANGqWZ81KUI7CNA-1; Tue, 31 Mar 2020 03:59:18 -0400
X-MC-Unique: n0fwKjrANGqWZ81KUI7CNA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4580149C0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:59:17 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-112-123.ams2.redhat.com
 [10.36.112.123])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 416B6953D6;
 Tue, 31 Mar 2020 07:59:11 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] vhost-vsock: fix double close() in the realize() error path
Date: Tue, 31 Mar 2020 09:59:10 +0200
Message-Id: <20200331075910.42529-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vhost_dev_cleanup() closes the vhostfd parameter passed to
vhost_dev_init(), so this patch avoids closing it twice in
the vhost_vsock_device_realize() error path.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/virtio/vhost-vsock.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 9f9093e196..09b6b07f94 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -364,12 +364,16 @@ static void vhost_vsock_device_realize(DeviceState *d=
ev, Error **errp)
=20
 err_vhost_dev:
     vhost_dev_cleanup(&vsock->vhost_dev);
+    /* vhost_dev_cleanup() closes the vhostfd passed to vhost_dev_init() *=
/
+    vhostfd =3D -1;
 err_virtio:
     virtio_delete_queue(vsock->recv_vq);
     virtio_delete_queue(vsock->trans_vq);
     virtio_delete_queue(vsock->event_vq);
     virtio_cleanup(vdev);
-    close(vhostfd);
+    if (vhostfd >=3D 0) {
+        close(vhostfd);
+    }
     return;
 }
=20
--=20
2.25.1


