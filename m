Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F44C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4682187F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsVEn8XV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4682187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irIOL-0001yI-4m
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 04:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1irINe-0001Xu-9V
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1irINY-0004vi-IE
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:20:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29530
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1irINY-0004v1-Dj
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578993651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wghb7L9IMc4YYzQHTiGuOnsC/jYF2lnW/fjG/x4IYBQ=;
 b=NsVEn8XV8Q8HGl/YK/QBBA04PzWbRq572lPTsFLhEUrjBtLGXqTkZqHXbzH8MigQS/FQq3
 +s+r7j+2AcZGrSSR/0iFISRxeDMbjKvNqZnetjrFcGQye9+MeJJ+buZlctsmptm4c07zMz
 49vG0B0kS5eq00lTnhxS1Qw3cgbe+2A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-RaXVesh4N764ZWC2As8r7g-1; Tue, 14 Jan 2020 04:20:46 -0500
Received: by mail-wr1-f69.google.com with SMTP id b13so6198149wrx.22
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 01:20:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6hfdVKScsqgNTeOg5viiiaxzM08I9cAKz3zbUAYWCCA=;
 b=ZJsCHRFKIALukxqKVxP29gnllGCWa6NHBEVhikuLIzspDMe5OjSSW7WsPQuvKJ3icy
 UYQ0KpWSJUhYOwJt55iQnOR+YRrnObfr9Egussgpxe6QboPAA1MDor7l21gX6l+KBy5x
 tQFkXPARXx7w85b7wpD77eyy8VWKOCn7CCjug87kxCP2ZwYJqvTsXuHV3OCowW4qpHCE
 BAyXnfI6+cPuE+/MuoqqwdG/j//bXH2E3TyQ1cXGPqdpR1PYdaO/O7jAvihAncdqddd1
 89mvKRe6/JTysovm/ZBeOpmwYVlplsZmm+qL3+h+JFjjc3ToQ1jIKD5lCf1sxnSP2yL1
 2UbQ==
X-Gm-Message-State: APjAAAVkfMZMNQDEEw0ViOxHd6+xOFNVtlEnKf6Wh59OBQDORkieMzM4
 7/ezq/T17zJacfoyE0fUJh8M+Y7t+nyzgUA0stII0ETPbYmlknuQfESlWD2z2TJW6NELHG9XD06
 vpAm4bui+yD78nFU=
X-Received: by 2002:adf:fa43:: with SMTP id y3mr152095wrr.65.1578993645540;
 Tue, 14 Jan 2020 01:20:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwiA8MV3T9yPgt2XVC11DQqLqerrofyh45xWYWX9Ug00pfKZe8fWn/yBdbz/x7Nb4A0KIqRbg==
X-Received: by 2002:adf:fa43:: with SMTP id y3mr152070wrr.65.1578993645284;
 Tue, 14 Jan 2020 01:20:45 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it.
 [79.31.49.84])
 by smtp.gmail.com with ESMTPSA id p17sm18782096wrx.20.2020.01.14.01.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 01:20:44 -0800 (PST)
Date: Tue, 14 Jan 2020 10:20:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH] vhost-vsock: delete vqs in vhost_vsock_unrealize to
 avoid memleaks
Message-ID: <20200114092042.vifebhj6dbm3cu5g@steredhat>
References: <20200114075229.40520-1-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200114075229.40520-1-pannengyuan@huawei.com>
X-MC-Unique: RaXVesh4N764ZWC2As8r7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: zhang.zhanghailiang@huawei.com, Euler Robot <euler.robot@huawei.com>,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 03:52:29PM +0800, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> Receive/transmit/event vqs forgot to cleanup in vhost_vsock_unrealize. Th=
is
> patch save receive/transmit vq pointer in realize() and cleanup vqs
> through those vq pointers in unrealize(). The leak stack is as follow:
>=20
> Direct leak of 21504 byte(s) in 3 object(s) allocated from:
>   #0 0x7f86a1356970 (/lib64/libasan.so.5+0xef970)  ??:?
>   #1 0x7f86a09aa49d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
>   #2 0x5604852f85ca (./x86_64-softmmu/qemu-system-x86_64+0x2c3e5ca)  /mnt=
/sdb/qemu/hw/virtio/virtio.c:2333
>   #3 0x560485356208 (./x86_64-softmmu/qemu-system-x86_64+0x2c9c208)  /mnt=
/sdb/qemu/hw/virtio/vhost-vsock.c:339
>   #4 0x560485305a17 (./x86_64-softmmu/qemu-system-x86_64+0x2c4ba17)  /mnt=
/sdb/qemu/hw/virtio/virtio.c:3531
>   #5 0x5604858e6b65 (./x86_64-softmmu/qemu-system-x86_64+0x322cb65)  /mnt=
/sdb/qemu/hw/core/qdev.c:865
>   #6 0x5604861e6c41 (./x86_64-softmmu/qemu-system-x86_64+0x3b2cc41)  /mnt=
/sdb/qemu/qom/object.c:2102
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  hw/virtio/vhost-vsock.c         | 9 +++++++--
>  include/hw/virtio/vhost-vsock.h | 2 ++
>  2 files changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index f5744363a8..896c0174c1 100644
> --- a/hw/virtio/vhost-vsock.c
> +++ b/hw/virtio/vhost-vsock.c
> @@ -335,8 +335,10 @@ static void vhost_vsock_device_realize(DeviceState *=
dev, Error **errp)
>                  sizeof(struct virtio_vsock_config));
> =20
>      /* Receive and transmit queues belong to vhost */
> -    virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE, vhost_vsock_handle_ou=
tput);
> -    virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE, vhost_vsock_handle_ou=
tput);
> +    vsock->recv_vq =3D virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
> +                                      vhost_vsock_handle_output);
> +    vsock->trans_vq =3D virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
> +                                       vhost_vsock_handle_output);
> =20
>      /* The event queue belongs to QEMU */
>      vsock->event_vq =3D virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
> @@ -378,6 +380,9 @@ static void vhost_vsock_device_unrealize(DeviceState =
*dev, Error **errp)
>      /* This will stop vhost backend if appropriate. */
>      vhost_vsock_set_status(vdev, 0);
> =20
> +    virtio_delete_queue(vsock->recv_vq);
> +    virtio_delete_queue(vsock->trans_vq);
> +    virtio_delete_queue(vsock->event_vq);
>      vhost_dev_cleanup(&vsock->vhost_dev);
>      virtio_cleanup(vdev);
>  }
> diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vs=
ock.h
> index d509d67c4a..bc5a988ee5 100644
> --- a/include/hw/virtio/vhost-vsock.h
> +++ b/include/hw/virtio/vhost-vsock.h
> @@ -33,6 +33,8 @@ typedef struct {
>      struct vhost_virtqueue vhost_vqs[2];
>      struct vhost_dev vhost_dev;
>      VirtQueue *event_vq;
> +    VirtQueue *recv_vq;
> +    VirtQueue *trans_vq;
>      QEMUTimer *post_load_timer;
> =20
>      /*< public >*/
> --=20
> 2.21.0.windows.1
>=20
>=20
>=20

--=20


