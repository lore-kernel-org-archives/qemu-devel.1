Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AB2C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 08:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB8D2073A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 08:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjYXY2dR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB8D2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ireGB-0001Z7-UR
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 03:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1ireFU-0000aA-SE
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 03:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1ireFR-0002q2-Vw
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 03:41:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29369
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ireFR-0002pO-Or
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 03:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579077716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Li5yFHTZDnbommSICa/okdUUSjHqrhxj/alteQZt8Y=;
 b=XjYXY2dRsNljffu5v0RpdvohAIuyEUQSOfHn1Gs02wIbg+kiEe5wXgfc43txZyF9jIDhQG
 ONsd2L0/dtOvJkXzRYkR6ftDRPbhhe34w9sKfCEubD/cX9CWWcxqAN7lgXFyCRvS1OPN7j
 gGV5VCIl6r0PboMmG6pEzj3hEWucv+Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-9qddHU3mPQmteXcSLvVXkw-1; Wed, 15 Jan 2020 03:41:55 -0500
Received: by mail-wr1-f70.google.com with SMTP id f17so7728259wrt.19
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 00:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FyCCq0r7FL0R2BpGqamEHWOaR3qR6zg5T1gUXw1ybaI=;
 b=rRMjMRzaPdwuJTGNhbyPwPM5AOOVlmIbOsjKQii8dKB7yLYLQH7KFpnZD/l19SHhFg
 otCV8/j1yfKcJuZgSon5mOsvQtejqIfSpB/VdpqUKA82//UyDfocmZgVaWNVwGe2T5V8
 rQRpnPrXfRLcZhMqJPHcGAUhk49AusIs0tCVT36Uo/gIJIcIQa0WlPxJz/tLOOtDYXfb
 OrjgjK1iSwxdSA345NppZi0NTpl+aRbTvlFyEF29HPuWPiAPCiV8o0CGd69Hx6Wr+2sT
 EDOfpmb7gDE7ZvLJf2vjWaqPtFxm9MwSe4e6nKwq4txQrXGS1aUQda0jMKvPY9NdZED5
 GFKQ==
X-Gm-Message-State: APjAAAVWeyZDAI3Jn7vMrAmXMD6S54fWj3GyKGyiJmVEzFuQN6p/ZXJB
 LeqiLHvj9R5SQy/QeSZlaehgyO4YQde6Wg5afeNgNY0byHs0NKA+aPOKPpuudE7KtxLOXjBSMk7
 HtShAdiv5oTnx8i8=
X-Received: by 2002:a1c:8095:: with SMTP id b143mr33170416wmd.7.1579077714502; 
 Wed, 15 Jan 2020 00:41:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzpIfmJYSjBiO+CCgHAUylpSy5nKTN+tUHkIL1rNEsT5jsMswTU2Yt3kJ0MTSo5Zd9zIIZKVQ==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr33170400wmd.7.1579077714266; 
 Wed, 15 Jan 2020 00:41:54 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it.
 [79.31.49.84])
 by smtp.gmail.com with ESMTPSA id z83sm23139642wmg.2.2020.01.15.00.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 00:41:53 -0800 (PST)
Date: Wed, 15 Jan 2020 09:41:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH v2] vhost-vsock: delete vqs in vhost_vsock_unrealize to
 avoid memleaks
Message-ID: <20200115084151.hetsvjih2dloxjsp@steredhat>
References: <20200115062535.50644-1-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200115062535.50644-1-pannengyuan@huawei.com>
X-MC-Unique: 9qddHU3mPQmteXcSLvVXkw-1
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

On Wed, Jan 15, 2020 at 02:25:35PM +0800, pannengyuan@huawei.com wrote:
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
> Changes V2 to V1:
> - delete virtqueues after vhost cleanup to avoid use-after-free
> - aslo delete virtqueues in the error path of realize()
> ---
>  hw/virtio/vhost-vsock.c         | 12 ++++++++++--
>  include/hw/virtio/vhost-vsock.h |  2 ++
>  2 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index f5744363a8..b6cee479bb 100644
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
> @@ -363,6 +365,9 @@ static void vhost_vsock_device_realize(DeviceState *d=
ev, Error **errp)
>  err_vhost_dev:
>      vhost_dev_cleanup(&vsock->vhost_dev);
>  err_virtio:
> +    virtio_delete_queue(vsock->recv_vq);
> +    virtio_delete_queue(vsock->trans_vq);
> +    virtio_delete_queue(vsock->event_vq);
>      virtio_cleanup(vdev);
>      close(vhostfd);
>      return;
> @@ -379,6 +384,9 @@ static void vhost_vsock_device_unrealize(DeviceState =
*dev, Error **errp)
>      vhost_vsock_set_status(vdev, 0);
> =20
>      vhost_dev_cleanup(&vsock->vhost_dev);
> +    virtio_delete_queue(vsock->recv_vq);
> +    virtio_delete_queue(vsock->trans_vq);
> +    virtio_delete_queue(vsock->event_vq);
>      virtio_cleanup(vdev);
>  }
> =20
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


