Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D43DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A1420863
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCwVOL4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A1420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGZc-0006Fo-Ld
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iZGTO-00007y-81
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:40:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iZGTN-0002Ik-1S
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:40:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33744
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iZGTM-0002Gm-Ti
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574696420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RBpsFCVeMRCzlLpskwT+ExfayS9Zv6LYuKZdvR/1r7k=;
 b=UCwVOL4GwrRGj1ZlSD/Jw2YZ5nfQ4wurhJYqN8ux1SsveK9hN1qSTQcoX2cbQEmF3tLbCR
 IAzxFb44sPIwcGws5PcRbxy8ckwCnzSjU256dvQIDBVRIAkuxgFcJfyQcAJxnK0CtXVNvY
 TUwAYfPZ1dVWnkit/gHN/fjqmBJxvgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-VYFjNEEsNN2gp2x3m_iziw-1; Mon, 25 Nov 2019 10:40:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79F77802B9F;
 Mon, 25 Nov 2019 15:40:15 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-31.pek2.redhat.com
 [10.72.12.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 728E85D9CA;
 Mon, 25 Nov 2019 15:40:11 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 1/4] net/virtio: fix dev_unplug_pending
Date: Mon, 25 Nov 2019 23:40:04 +0800
Message-Id: <1574696407-4188-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1574696407-4188-1-git-send-email-jasowang@redhat.com>
References: <1574696407-4188-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: VYFjNEEsNN2gp2x3m_iziw-1
X-Mimecast-Spam-Score: 0
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
Cc: Jason Wang <jasowang@redhat.com>, Jens Freimann <jfreimann@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jens Freimann <jfreimann@redhat.com>

.dev_unplug_pending is set up by virtio-net code indepent of failover
support was set for the device or not. This gives a wrong result when
we check for existing primary devices in migration code.

Fix this by actually calling dev_unplug_pending() instead of just
checking if the function pointer was set. When the feature was not
negotiated dev_unplug_pending() will always return false. This prevents
us from going into the wait-unplug state when there's no primary device
present.

Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 3 +++
 migration/savevm.c  | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 97a5113..946039c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3124,6 +3124,9 @@ static bool primary_unplug_pending(void *opaque)
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VirtIONet *n =3D VIRTIO_NET(vdev);
=20
+    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
+        return false;
+    }
     return n->primary_dev ? n->primary_dev->pending_deleted_event : false;
 }
=20
diff --git a/migration/savevm.c b/migration/savevm.c
index 966a9c3..a71b930 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1119,7 +1119,8 @@ int qemu_savevm_nr_failover_devices(void)
     int n =3D 0;
=20
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (se->vmsd && se->vmsd->dev_unplug_pending) {
+        if (se->vmsd && se->vmsd->dev_unplug_pending &&
+            se->vmsd->dev_unplug_pending(se->opaque)) {
             n++;
         }
     }
--=20
2.5.0


