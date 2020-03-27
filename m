Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A6FC2D0E7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5192320705
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnRquW5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5192320705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHkZK-0001XV-D6
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 04:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jHkYc-000149-C7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jHkYb-000214-3G
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:41:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jHkYa-0001yv-VZ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585298496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6eZxDaforrTqZ54RIJXv0J7hKmHs4F5vm3Li+7V5lxw=;
 b=dnRquW5gYW+jchhbWhI3UzbD9phrJrg9W5bsSGOmMLwhdvbMJoD1gE6e2oKk/oBzv902Z3
 rQ6bbUuUB5pA6C71vvxQj51mLG+Kc1j5RFFQTIG6x1rS5MPi82h4tdOU5sEhuNBN1lC3XR
 1YRZtJnBn9xKzCQ2VJGtRA2077cqvX0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-MjwruxLvP6CZbjr55I-9Jg-1; Fri, 27 Mar 2020 04:41:34 -0400
X-MC-Unique: MjwruxLvP6CZbjr55I-9Jg-1
Received: by mail-wr1-f72.google.com with SMTP id f15so4235632wrt.4
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 01:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sG795bJPUV9MYfXQdwk0iRdo2GYE85XmnFET8Eb2JYY=;
 b=lZKB8FgXCEEBDH7aHq+8iZPJCIZ/HQMZoUzMKehKCqzZ/PR/M60yy4zNC+rwtyGLgQ
 3JkEsobisux0zEZ5JLkt8G7WDR2lKYYwy+eAh9CFJHXFnYrioIWx2U8E6teLpoWDPuyO
 nJ+JWLoexd3Ym0HRTAzHBxj4FONYGDTvw/etfEdBFVO5s6KMg3yaPjAwB8iv3WRZMhg5
 HoETKvAxsrOKVkGpe0uU8VTDaETCyJeqMwLt84IbOQvc5d8r2l56BFHmhUc2gp+rg8O3
 dinss2EhSDCwYYukj1xoZz+YDvrETe14eVMQkTEWD83JBiCddCLz0c4tFwjiV05aJuR2
 AlQg==
X-Gm-Message-State: ANhLgQ04tB0diq8zwMfeh4yI8Lr0r8DAhE9WDZACvWBz27Cy7AnDACpn
 eGlGBmZMfwyb0UVX5gENSyljhupBz3KSMyj6OPShcxmA3/f1Kdv0ySDuGIyos3bqWTOd/tuZl+E
 7rgLsCtKzJXQkHlE=
X-Received: by 2002:a1c:2b43:: with SMTP id r64mr536096wmr.77.1585298492967;
 Fri, 27 Mar 2020 01:41:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt++OBsFltt521WfkvP6lW/0Ifm2lWt8/YQ9NwEQ6zBu1AvP8rM0YQUS/BQV4jfOLlVDva6mg==
X-Received: by 2002:a1c:2b43:: with SMTP id r64mr536076wmr.77.1585298492755;
 Fri, 27 Mar 2020 01:41:32 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id t21sm6998873wmt.43.2020.03.27.01.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 01:41:32 -0700 (PDT)
Date: Fri, 27 Mar 2020 09:41:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH 1/2] virtio-blk: delete vqs on the error path in realize()
Message-ID: <20200327084129.o6xdbwshijkqhnlt@steredhat>
References: <20200327035650.2085-1-pannengyuan@huawei.com>
 <20200327035650.2085-2-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200327035650.2085-2-pannengyuan@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 27, 2020 at 11:56:49AM +0800, Pan Nengyuan wrote:
> virtio_vqs forgot to free on the error path in realize(). Fix that.
>=20
> The asan stack:
> Direct leak of 14336 byte(s) in 1 object(s) allocated from:
>     #0 0x7f58b93fd970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
>     #1 0x7f58b858249d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>     #2 0x5562cc627f49 in virtio_add_queue /mnt/sdb/qemu/hw/virtio/virtio.=
c:2413
>     #3 0x5562cc4b524a in virtio_blk_device_realize /mnt/sdb/qemu/hw/block=
/virtio-blk.c:1202
>     #4 0x5562cc613050 in virtio_device_realize /mnt/sdb/qemu/hw/virtio/vi=
rtio.c:3615
>     #5 0x5562ccb7a568 in device_set_realized /mnt/sdb/qemu/hw/core/qdev.c=
:891
>     #6 0x5562cd39cd45 in property_set_bool /mnt/sdb/qemu/qom/object.c:223=
8
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> ---
>  hw/block/virtio-blk.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 142863a3b2..a6682c2ced 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1204,8 +1204,7 @@ static void virtio_blk_device_realize(DeviceState *=
dev, Error **errp)
>      virtio_blk_data_plane_create(vdev, conf, &s->dataplane, &err);
>      if (err !=3D NULL) {
>          error_propagate(errp, err);
> -        virtio_cleanup(vdev);
> -        return;
> +        goto fail;
>      }
> =20
>      s->change =3D qemu_add_vm_change_state_handler(virtio_blk_dma_restar=
t_cb, s);
> @@ -1218,6 +1217,11 @@ static void virtio_blk_device_realize(DeviceState =
*dev, Error **errp)
>                           conf->conf.lcyls,
>                           conf->conf.lheads,
>                           conf->conf.lsecs);

I think we should add a return here, otherwise we will remove the virt
queues also in the success case.

Thanks,
Stefano

> +fail:
> +    for (i =3D 0; i < conf->num_queues; i++) {
> +        virtio_del_queue(vdev, i);
> +    }
> +    virtio_cleanup(vdev);
>  }
> =20
>  static void virtio_blk_device_unrealize(DeviceState *dev, Error **errp)
> --=20
> 2.18.2
>=20
>=20


