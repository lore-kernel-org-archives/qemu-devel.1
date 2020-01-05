Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3CFC3F68F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 12:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D265218AC
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 12:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cdw5iExu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D265218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io4vi-0000yk-J9
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 07:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io4v6-0000LC-Tx
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:22:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io4v3-0000xN-P5
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:22:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58294
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io4v3-0000vK-Fv
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578226928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IH5QF3iqckj8q8DnwRxJZM4JLwshHjJJWzeJ55aSIeE=;
 b=Cdw5iExuJFb8nGI5eCLBjndB9KAX5VdyWUKg0EmX9lprqyiMgFdBzgjJTQPWwZ9IIlj6lD
 zQwmAHRPKfjrobn3QlyfaoR+BKfFE99tGa954Rh8ZIUer4j+ldVOQsZhHZbvsYsin6YCXp
 xbAYfypQf+0257jgDSgIJZ7dxJpS0qs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-pHLQLGrJPo6UxASxwm7XHg-1; Sun, 05 Jan 2020 07:22:04 -0500
Received: by mail-qt1-f200.google.com with SMTP id o24so27542435qtr.17
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 04:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WKgWyMWonycXfiVxA7C2vZERF7NLA3hFD7tlaZSjepo=;
 b=MWTnBCDpzQFuGd7Igw7pMBZUIl9QtzMncBjKC7VKMSyGu0ptva3XQTJccoExMVpMZI
 jjh21fAVxH/s22Mw/79M1mO/3OScikMkAxkzlYh3qO0VTlr2ztD9rMKLhY+NZz8VWTn9
 0HOOsGoIvwirVBuraNz2XDKzr5APubOsrGma85E0NfTwP2ry4vt4kV6lkdom3A2m3cP+
 tte/C4zK2FUoA9x86Pf3w1imj2DFv7NRiMVIxQeLrUqndQMs8Vgc7veGkJG69Ym50EX4
 amkvAN5zKSlhYpfxbCng+WtwVm8S5TbSJp7gleGjyTaQfZVnIFvloU4LkQPRf2hQL6ng
 bLog==
X-Gm-Message-State: APjAAAUNd41tUo01FBPht9Uvf9YAaaELnXle7h2zdEjyhV9iOFdYAB5i
 KSQ4zEzJWcorgmqd1Mr5ft5qnW6P9sXISp0eq+K+y4ql0+y3ioYKbligrd/2GhtlZxq3ETnP/Lp
 4KIH9jrWP2d0l1gA=
X-Received: by 2002:a05:620a:1315:: with SMTP id
 o21mr67685355qkj.116.1578226923744; 
 Sun, 05 Jan 2020 04:22:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwIUIdbz7AxLT7ywj9QOW1f/MM2X1r9g1KI1vvGR9UN5SOQLjCk6xqmf0rfGF8lLDqM9Xd38g==
X-Received: by 2002:a05:620a:1315:: with SMTP id
 o21mr67685344qkj.116.1578226923503; 
 Sun, 05 Jan 2020 04:22:03 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id g9sm19090734qkm.9.2020.01.05.04.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 04:22:02 -0800 (PST)
Date: Sun, 5 Jan 2020 07:21:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH 1/2] virtio: reset region cache when on queue deletion
Message-ID: <20200105071859-mutt-send-email-mst@kernel.org>
References: <20191226043649.14481-1-yuri.benditovich@daynix.com>
 <20191226043649.14481-2-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20191226043649.14481-2-yuri.benditovich@daynix.com>
X-MC-Unique: pHLQLGrJPo6UxASxwm7XHg-1
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
Cc: yan@daynix.com, jasowang@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 26, 2019 at 06:36:48AM +0200, Yuri Benditovich wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
> Fix leak of region reference that prevents complete
> device deletion on hot unplug.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>

I rebased this on top of my tree.

Got this:


commit f3dee6a062c1f4445768296ee39070bab9863372
Author: Yuri Benditovich <yuri.benditovich@daynix.com>
Date:   Thu Dec 26 06:36:48 2019 +0200

    virtio: reset region cache when on queue deletion
   =20
    https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
    Fix leak of region reference that prevents complete
    device deletion on hot unplug.
   =20
    Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
    Message-Id: <20191226043649.14481-2-yuri.benditovich@daynix.com>

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 95d8ff8508..7b861e0ca0 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2344,6 +2344,7 @@ void virtio_delete_queue(VirtQueue *vq)
     vq->handle_aio_output =3D NULL;
     g_free(vq->used_elems);
     vq->used_elems =3D NULL;
+    virtio_virtqueue_reset_region_cache(vq);
 }
=20
 void virtio_del_queue(VirtIODevice *vdev, int n)

Can you confirm pls?


