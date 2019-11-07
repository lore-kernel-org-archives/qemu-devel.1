Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD92C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A012087E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oo4RjFXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A012087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSnTV-0002SG-HO
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 14:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iSnRs-0001NP-9I
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iSnRq-0008WJ-4n
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:28:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59885
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iSnRq-0008Vn-14
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573154881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ShqYAUE5QiCFY7MJ/v0mrQWsfecWkN91u+xbjdRw0b0=;
 b=Oo4RjFXPLt2arCHdQuXyyP1iK2lJIh49aVgqWxjfoUA9BUUL24uM/CilEiXDF+HEZPltg3
 bJb6t9i6EsHsiDRkmK27g7EFWRACllOabcbh+TIzYigFI0iWFa3S48YVUhnfSW/KKaQPsP
 olgqkBw2ongFxDyEfVvEyo3T79MFxuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-ejkqC6-bNdmd4b0R4MEnDg-1; Thu, 07 Nov 2019 14:28:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3976B800C61
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 19:27:59 +0000 (UTC)
Received: from localhost (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 159515C57C;
 Thu,  7 Nov 2019 19:27:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] virtio-input: fix memory leak on unrealize
Date: Thu,  7 Nov 2019 23:27:29 +0400
Message-Id: <20191107192731.17330-2-marcandre.lureau@redhat.com>
In-Reply-To: <20191107192731.17330-1-marcandre.lureau@redhat.com>
References: <20191107192731.17330-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ejkqC6-bNdmd4b0R4MEnDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Spotted by ASAN + minor stylistic change.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/input/virtio-input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 51617a5885..ec54e46ad6 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -275,6 +275,7 @@ static void virtio_input_finalize(Object *obj)
=20
     g_free(vinput->queue);
 }
+
 static void virtio_input_device_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIOInputClass *vic =3D VIRTIO_INPUT_GET_CLASS(dev);
@@ -288,6 +289,8 @@ static void virtio_input_device_unrealize(DeviceState *=
dev, Error **errp)
             return;
         }
     }
+    virtio_del_queue(vdev, 0);
+    virtio_del_queue(vdev, 1);
     virtio_cleanup(vdev);
 }
=20
--=20
2.24.0.rc0.20.gd81542e6f3


