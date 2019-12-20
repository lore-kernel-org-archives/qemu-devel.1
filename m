Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBD5C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674EE2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="f4tYxpl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674EE2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHmo-0006MQ-I9
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <antonkuchin@yandex-team.ru>) id 1iiHm9-0005hV-01
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <antonkuchin@yandex-team.ru>) id 1iiHm5-0002NH-Rs
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:52:58 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:42100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <antonkuchin@yandex-team.ru>)
 id 1iiHm5-00024Y-2d
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:52:57 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id B307E2E1435;
 Fri, 20 Dec 2019 15:52:52 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net
 (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 uXEJCKdFzr-qpEOaQCj; Fri, 20 Dec 2019 15:52:52 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1576846372; bh=Iu3UL1w8SxSMzA4FDC+4pEn/VK8m32gfNbIWWDQHzaA=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=f4tYxpl+gLh4tzRFNoNe4H9ewRZp4+7ZFLQY5e8gSOriKm38kpVBye6hkSUhaq/xM
 1UXSD3EBBGz6Eg1atLgZd2jIcmpESSMxblV5+fzEz9xLcicfpIwDacdHy6AAerDN5R
 DUDkELed+YHwBO1jV1sxZrsrj7VtX7V9PljKYSvg=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:3ee1:a1ff:fe4b:4744])
 by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 jMDccCIVpa-qpVCIuWL; Fri, 20 Dec 2019 15:52:51 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Anton Kuchin <antonkuchin@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] virtio: Change order of appling runstate to device and bus
Date: Fri, 20 Dec 2019 15:52:45 +0300
Message-Id: <20191220125245.7679-1-antonkuchin@yandex-team.ru>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Anton Kuchin <antonkuchin@yandex-team.ru>, yc-core@yandex-team.ru,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On transition to running first apply state to bus and then to device
so device can access bus functions correctly. When going to stopped
notify device first and then the bus.

Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
---
 hw/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 04716b5f6c..2ea2edba10 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3096,7 +3096,7 @@ static void virtio_vmstate_change(void *opaque, int=
 running, RunState state)
     bool backend_run =3D running && virtio_device_started(vdev, vdev->st=
atus);
     vdev->vm_running =3D running;
=20
-    if (backend_run) {
+    if (!backend_run) {
         virtio_set_status(vdev, vdev->status);
     }
=20
@@ -3104,7 +3104,7 @@ static void virtio_vmstate_change(void *opaque, int=
 running, RunState state)
         k->vmstate_change(qbus->parent, backend_run);
     }
=20
-    if (!backend_run) {
+    if (backend_run) {
         virtio_set_status(vdev, vdev->status);
     }
 }
--=20
2.20.1


