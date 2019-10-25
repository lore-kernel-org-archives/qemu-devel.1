Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2F4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C960C21D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXjFX46a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C960C21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNvEI-00076s-Ax
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eperezma@redhat.com>) id 1iNv5A-00013M-JM
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eperezma@redhat.com>) id 1iNv59-00082X-Cy
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27479
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eperezma@redhat.com>) id 1iNv59-00082K-9W
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571992587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwwBNIm4icU6T5Xp+zsrPLUK4URRyVnXz5sXZbtDH4A=;
 b=EXjFX46agD1ycDt9YlOe9VVMSgmkG0kgIGfbPoXdStrAGkQKPtfLZWsVvP8yqP3hERFeqF
 AivURb/YiT9l7pW1fuowlrqO5kMyTbDj7z/7vAJx3J/IzjQbr+1qaU08/W1vJ/bIGKJBE/
 /Es4R9CBIGlDQz7W2PziQTFDfUEJb5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-g071UDhGNvKo-cxoOpUmLg-1; Fri, 25 Oct 2019 04:36:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A03B11800E00;
 Fri, 25 Oct 2019 08:36:22 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.36.118.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1811D60BE0;
 Fri, 25 Oct 2019 08:36:09 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 4/8] virtio: Free rnd virqueue at unrealize()
Date: Fri, 25 Oct 2019 10:35:23 +0200
Message-Id: <20191025083527.30803-5-eperezma@redhat.com>
In-Reply-To: <20191025083527.30803-1-eperezma@redhat.com>
References: <20191025083527.30803-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: g071UDhGNvKo-cxoOpUmLg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function virtio_del_queue was not called at unrealize() callback.

This was detected due to add an allocated element on the vq introduce
in future commits (used_elems) and running address sanitizer memory
leak detector.

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 hw/virtio/virtio-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index e93bed020f..b498a20332 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -238,6 +238,7 @@ static void virtio_rng_device_unrealize(DeviceState *de=
v, Error **errp)
     qemu_del_vm_change_state_handler(vrng->vmstate);
     timer_del(vrng->rate_limit_timer);
     timer_free(vrng->rate_limit_timer);
+    virtio_del_queue(vdev, 0);
     virtio_cleanup(vdev);
 }
=20
--=20
2.16.5


