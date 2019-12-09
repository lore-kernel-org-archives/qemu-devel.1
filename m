Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36069C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A3020828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRUhrhqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A3020828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieGvS-0007pu-5E
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 06:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ieGtj-0006dH-G8
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ieGti-0005Ru-C6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:08:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29372
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ieGti-0005PF-8N
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575889693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RPrMiZ0v1PSesIhe9HmFaiZvHLOIGv64ZoBzOchACrU=;
 b=CRUhrhqXnbhvOwhi5/Y25CZi5N2npo1yqmI1B2foGIdQFlbsijpbvzFiLMv73yD6q3Hpbb
 tXrt4FWDbM1ZrE5jI0nbMydv6/cVGIt+atyjdAtV1Eq/n2bLpE8lY7cDggqKIU3gQek66Q
 EYRdlpItvXnykFN7xE8gjQxEpUz2ZH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-K4elXz4EMqeLhOrhnKhp0Q-1; Mon, 09 Dec 2019 06:08:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2401018B9FD7
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 11:08:11 +0000 (UTC)
Received: from localhost (ovpn-117-247.ams2.redhat.com [10.36.117.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 077EB100EBA4;
 Mon,  9 Dec 2019 11:08:00 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio-fs: fix MSI-X nvectors calculation
Date: Mon,  9 Dec 2019 11:07:59 +0000
Message-Id: <20191209110759.35227-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: K4elXz4EMqeLhOrhnKhp0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Vivek Goyal <vgoyal@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following MSI-X vectors are required:
 * VIRTIO Configuration Change
 * hiprio virtqueue
 * requests virtqueues

Fix the calculation to reserve enough MSI-X vectors.  Otherwise guest
drivers fall back to a sub-optional configuration where all virtqueues
share a single vector.

This change does not break live migration compatibility since
vhost-user-fs-pci devices are not migratable yet.

Reported-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/vhost-user-fs-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
index 933a3f265b..e3a649d4a6 100644
--- a/hw/virtio/vhost-user-fs-pci.c
+++ b/hw/virtio/vhost-user-fs-pci.c
@@ -40,7 +40,8 @@ static void vhost_user_fs_pci_realize(VirtIOPCIProxy *vpc=
i_dev, Error **errp)
     DeviceState *vdev =3D DEVICE(&dev->vdev);
=20
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D dev->vdev.conf.num_request_queues + 1;
+        /* Also reserve config change and hiprio queue vectors */
+        vpci_dev->nvectors =3D dev->vdev.conf.num_request_queues + 2;
     }
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
--=20
2.23.0


