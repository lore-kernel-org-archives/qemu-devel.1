Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECC8C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 21:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7380024125
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 21:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1gcJ9Bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7380024125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu1Nm-0000eS-JX
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 16:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amorenoz@redhat.com>) id 1iu1Mv-00009k-FA
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amorenoz@redhat.com>) id 1iu1Ms-0002Kq-Iq
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:47:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54764
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amorenoz@redhat.com>) id 1iu1Ms-0002KI-99
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579643245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UMiy88bOQtu4xqt4S9ELD7gw90pvQESxI0GR2ETqe+M=;
 b=D1gcJ9BlTzntvn+WfEK0hAlx3k/oxMXZBNAtwcKiVNk0RCCSTsoMRNu+wkks+U0LuRaqa+
 FmvAZFQmBIel03C0DJsGpRVBL4GZczeSVMf9iPzPdmGIXAh6drtSY/DTZJrOwq7KbMLxJ8
 nsazYQSSQ3ZbTLn66J9mn6tdJxcV9mo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-n5nbgkltOBq9KnmrqiXlmw-1; Tue, 21 Jan 2020 16:46:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F01A10120B1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 21:46:14 +0000 (UTC)
Received: from amorenoz.users.ipa.redhat.com (ovpn-204-34.brq.redhat.com
 [10.40.204.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B126C1001B2C;
 Tue, 21 Jan 2020 21:46:04 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] vhost-user: only set slave channel for first vq
Date: Tue, 21 Jan 2020 22:45:53 +0100
Message-Id: <20200121214553.28459-1-amorenoz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: n5nbgkltOBq9KnmrqiXlmw-1
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
Cc: marcandre.lureau@redhat.com, jasowang@redhat.com,
 Adrian Moreno <amorenoz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When multiqueue is enabled, a vhost_dev is created for each queue
pair. However, only one slave channel is needed.

Fixes: 4bbeeba023f2 (vhost-user: add slave-req-fd support)
Cc: marcandre.lureau@redhat.com
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 hw/virtio/vhost-user.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index d27a10fcc6..68a8db0ace 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1458,9 +1458,11 @@ static int vhost_user_backend_init(struct vhost_dev =
*dev, void *opaque)
                    "VHOST_USER_PROTOCOL_F_LOG_SHMFD feature.");
     }
=20
-    err =3D vhost_setup_slave_channel(dev);
-    if (err < 0) {
-        return err;
+    if (dev->vq_index =3D=3D 0) {
+        err =3D vhost_setup_slave_channel(dev);
+        if (err < 0) {
+            return err;
+        }
     }
=20
     u->postcopy_notifier.notify =3D vhost_user_postcopy_notifier;
--=20
2.21.1


