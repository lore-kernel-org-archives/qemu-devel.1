Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF56C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 16:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA29A2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 16:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TONvc7Fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA29A2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijQnl-0005Su-Av
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 11:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ijQll-0003H7-KY
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ijQlk-0005Na-Js
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:41:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ijQlk-0005NT-G9
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577119279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+1AiFYA4jwJXgwLDoVnwKQ62HQ9au7D6spvhTUBGU8=;
 b=TONvc7Fdi0GlXVuqYaDFe4KasptoH0DBn9v4CJFEy6hhNjiqyH/deX/YoJqvDO1ISXVOyX
 SPQ4Y9myZYJkbajIzCwiuBjcejzY3a3qFM60wBLnbWKIrlhwuDG/dXhQx+6Zb2mbqlYRtd
 TjjTKCIqMAw6UUV7z1oW6YN+07SV8B0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-L4tBkMXGPBGCJcXFYFma0w-1; Mon, 23 Dec 2019 11:41:16 -0500
Received: by mail-qv1-f72.google.com with SMTP id d7so11610122qvq.12
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 08:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1upHWGgN+kA2iqb9NZ9XxvQ8bHfo9CqfdVL2Jr4HnRY=;
 b=I0tgRYAqzGS+EvlOKmA5h9BWBuqGa/Xx8dlg0Q79E4fb4I9MJJQYkNpm+Zu+QqtcC6
 GqYQDZ0nbZg8PrsRkSnCHGrescL/FVc6nFWHrAnUKfvMYa/yrUliDaK+3IhDsBMys/sf
 p9slRf2j6yLuo2OfrD0NpSHkMOqp7K8tQf7n986ve5lMQL2Vepn9mBURYfGsWo+GD3RR
 haFin0SL6YcO/cMSR2vWgl7xWyXLte0cvGpmZOA3+dBnPBJy90kb1qoYNqS8iFYHdgcL
 cwtlg9UFyuoFdq3ss0BMqYBETK0s+4dfAQ1iJe3ZDvkGTeAGcY4jiMSTZLSIYX2SX9X6
 BSpA==
X-Gm-Message-State: APjAAAXu1eSZWFxh0ZPLDc5nDOlSDs5PqfmpnpY68jQdk04Jn8iIl/Zt
 qI4OYTTt4QwDhMlgTXGDAhoELlbGkvLtv+x2rUM9bu37Hqa1UcDatR0kHKbU/IqtdhdQ2BVHO3+
 7ZTvg66397WhX5fQ=
X-Received: by 2002:ac8:4a85:: with SMTP id l5mr23347946qtq.64.1577119275282; 
 Mon, 23 Dec 2019 08:41:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqyWejgYmH9XiIF66Q+SdPhfZFjQScNJOJk7dkqC7QrOTn3UQCjLdTlbwx0oNr691tMIQ2FTOA==
X-Received: by 2002:ac8:4a85:: with SMTP id l5mr23347936qtq.64.1577119275110; 
 Mon, 23 Dec 2019 08:41:15 -0800 (PST)
Received: from redhat.com (bzq-109-64-31-13.red.bezeqint.net. [109.64.31.13])
 by smtp.gmail.com with ESMTPSA id
 i14sm5878179qkl.133.2019.12.23.08.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 08:41:14 -0800 (PST)
Date: Mon, 23 Dec 2019 11:41:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/27] virtio-balloon: fix memory leak while attach
 virtio-balloon device
Message-ID: <20191223141536.72682-4-mst@redhat.com>
References: <20191223141536.72682-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191223141536.72682-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: L4tBkMXGPBGCJcXFYFma0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

ivq/dvq/svq/free_page_vq is forgot to cleanup in
virtio_balloon_device_unrealize, the memory leak stack is as follow:

Direct leak of 14336 byte(s) in 2 object(s) allocated from:
    #0 0x7f99fd9d8560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
    #1 0x7f99fcb20015 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x50015)
    #2 0x557d90638437 in virtio_add_queue hw/virtio/virtio.c:2327
    #3 0x557d9064401d in virtio_balloon_device_realize hw/virtio/virtio-bal=
loon.c:793
    #4 0x557d906356f7 in virtio_device_realize hw/virtio/virtio.c:3504
    #5 0x557d9073f081 in device_set_realized hw/core/qdev.c:876
    #6 0x557d908b1f4d in property_set_bool qom/object.c:2080
    #7 0x557d908b655e in object_property_set_qobject qom/qom-qobject.c:26

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <1575444716-17632-2-git-send-email-pannengyuan@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-balloon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 40b04f5180..57f3b9f22d 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -831,6 +831,13 @@ static void virtio_balloon_device_unrealize(DeviceStat=
e *dev, Error **errp)
     }
     balloon_stats_destroy_timer(s);
     qemu_remove_balloon_handler(s);
+
+    virtio_delete_queue(s->ivq);
+    virtio_delete_queue(s->dvq);
+    virtio_delete_queue(s->svq);
+    if (s->free_page_vq) {
+        virtio_delete_queue(s->free_page_vq);
+    }
     virtio_cleanup(vdev);
 }
=20
--=20
MST


