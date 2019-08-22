Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC7CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3527B2089E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3527B2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0pSn-0006Ma-CH
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 11:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i0pP7-000383-OV
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i0pP6-0003vs-Ng
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:53:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i0pP4-0003tN-Jp; Thu, 22 Aug 2019 11:53:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0B602BFD2;
 Thu, 22 Aug 2019 15:53:33 +0000 (UTC)
Received: from localhost (ovpn-116-61.ams2.redhat.com [10.36.116.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C13621001925;
 Thu, 22 Aug 2019 15:53:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 16:53:02 +0100
Message-Id: <20190822155302.20916-3-stefanha@redhat.com>
In-Reply-To: <20190822155302.20916-1-stefanha@redhat.com>
References: <20190822155302.20916-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 22 Aug 2019 15:53:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/2] vhost-user-scsi: prevent using
 uninitialized vqs
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

Of the 3 virtqueues, seabios only sets cmd, leaving ctrl
and event without a physical address. This can cause
vhost_verify_ring_part_mapping to return ENOMEM, causing
the following logs:

qemu-system-x86_64: Unable to map available ring for ring 0
qemu-system-x86_64: Verify ring failure on region 0

The qemu commit e6cc11d64fc998c11a4dfcde8fda3fc33a74d844
has already resolved the issue for vhost scsi devices but
the fix was never applied to vhost-user scsi devices.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 1560299717-177734-1-git-send-email-raphael.norwitz@nutanix.co=
m
Message-Id: <1560299717-177734-1-git-send-email-raphael.norwitz@nutanix.c=
om>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/vhost-user-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 31c9d34637..6a6c15dd32 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -93,7 +93,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, E=
rror **errp)
     }
=20
     vsc->dev.nvqs =3D 2 + vs->conf.num_queues;
-    vsc->dev.vqs =3D g_new(struct vhost_virtqueue, vsc->dev.nvqs);
+    vsc->dev.vqs =3D g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
     vsc->dev.vq_index =3D 0;
     vsc->dev.backend_features =3D 0;
     vqs =3D vsc->dev.vqs;
--=20
2.21.0


