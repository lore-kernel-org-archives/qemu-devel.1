Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A440FC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F19E24679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g101rQg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F19E24679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiFWJ-0006Ub-K6
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 05:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iiFTf-0002RE-Nm
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iiFTe-0003FO-G0
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:25:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25189
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iiFTe-0003Bw-8y
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576837545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28rxh/Vzt6Z9Ae4E9kA+iijN5GKcnki3DuXw/wYz7Dk=;
 b=g101rQg6uJnJn8zr2gj9ILpjDxyePUHvHcVflTWJcujeewIeYcO1REhcFTx9hlbd5GXkO9
 OUdJKWQw8n6hUvsoCtMSHmJH557gS5gEE3MUCdQFqbL7GST7FXQBu9XOxhBKclD9NwKJUM
 Xs8wEBEoCbtums5Pa1UrWKjK2Uq4ULw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-EQ1he_rQPbm6aXbbL1PB_w-1; Fri, 20 Dec 2019 05:25:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65E5618FF663;
 Fri, 20 Dec 2019 10:25:40 +0000 (UTC)
Received: from localhost (unknown [10.36.118.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 360BA60C18;
 Fri, 20 Dec 2019 10:25:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] virtio-blk: fix out-of-bounds access to bitmap in
 notify_guest_bh
Date: Fri, 20 Dec 2019 10:25:20 +0000
Message-Id: <20191220102520.1637190-4-stefanha@redhat.com>
In-Reply-To: <20191220102520.1637190-1-stefanha@redhat.com>
References: <20191220102520.1637190-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: EQ1he_rQPbm6aXbbL1PB_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Xie Yongji <xieyongji@baidu.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Chai Wen <chaiwen@baidu.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Hangjing <lihangjing@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Hangjing <lihangjing@baidu.com>

When the number of a virtio-blk device's virtqueues is larger than
BITS_PER_LONG, the out-of-bounds access to bitmap[ ] will occur.

Fixes: e21737ab15 ("virtio-blk: multiqueue batch notify")
Cc: qemu-stable@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Li Hangjing <lihangjing@baidu.com>
Reviewed-by: Xie Yongji <xieyongji@baidu.com>
Reviewed-by: Chai Wen <chaiwen@baidu.com>
Message-id: 20191216023050.48620-1-lihangjing@baidu.com
Message-Id: <20191216023050.48620-1-lihangjing@baidu.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/dataplane/virtio-blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-bl=
k.c
index 119906a5fe..1b52e8159c 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -67,7 +67,7 @@ static void notify_guest_bh(void *opaque)
     memset(s->batch_notify_vqs, 0, sizeof(bitmap));
=20
     for (j =3D 0; j < nvqs; j +=3D BITS_PER_LONG) {
-        unsigned long bits =3D bitmap[j];
+        unsigned long bits =3D bitmap[j / BITS_PER_LONG];
=20
         while (bits !=3D 0) {
             unsigned i =3D j + ctzl(bits);
--=20
2.23.0


