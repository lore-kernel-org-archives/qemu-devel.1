Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF78DC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5FA2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+4VDCDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5FA2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6acK-0003V7-Ts
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6aJa-0004L2-VX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6aJX-0001TH-Ei
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:31:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20435
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6aJX-0001Rd-9z
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582637514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTsJ/8+pgAJA8aCEg9n/FH0oFAs/lK8brgom/Sq5Y68=;
 b=Q+4VDCDFZI/82btVxKjX7Abz6myGpx6wTagDLkRSyAlqNGbpA59jO2e1a0x22nH5luY4tQ
 iY8hFe9ZeiNh4RRf2iUTB2yaf+dF2X1p2Y08YZ89KgYSYNTPzy9ol27DiYVygr2rJP6dtp
 TEAjxPau4dP8XpuoXjm+Y30bwKhcfO8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-ilsNRPbbPeO2tmxaGBArsw-1; Tue, 25 Feb 2020 08:31:51 -0500
X-MC-Unique: ilsNRPbbPeO2tmxaGBArsw-1
Received: by mail-qv1-f72.google.com with SMTP id cp3so12886375qvb.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 05:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bdDMtQeb45LkMtjpYYrGARJmB+J3Cf2I9ttM8Mqc1LA=;
 b=X0yT+PqNqoB30wCjmCri3MF43zqeq+pEvYRJ6VfLGAM97XTRomYgP/x4rrKQJ/FVCe
 vb11y7z9ndB8cBWJ0N89t/+PjGEpv492IXqmaAG8H389or9v2SJDrJdmYyKC77SUP+KV
 KOuWcpNkPucEqaIbzknipL9TX6cSp2aDVVAiBr/u1J7nWUR8ab4VNQkcQSeUk6/IO21d
 i90DOttnjAnPZ/DCTZTkFoaj31kh/BX6vi2ZYz/7mpKfoQevgRpfpnqSdTLjcojsjaK2
 JJhZmN9WTsarkjSMNRPhaRpOa5TbUGVfQuqeffvpMXxgxYTQCT2kMacYGzXJ2IM/9ML6
 Iuyw==
X-Gm-Message-State: APjAAAXhF4qxx0Hwx+M8Jan8w0W27NSwOI1w0DILubwfATsoQQHTFaTC
 pB+xHjw2iHLPYBWuUdIaGYoROHztfInLkvgrJXVdZzowfKuZKpqxwmksYwfBWpOJ6o1fLeww5OP
 QlDgcdz/YrxKq2gs=
X-Received: by 2002:a05:6214:38c:: with SMTP id
 l12mr50614390qvy.224.1582637511171; 
 Tue, 25 Feb 2020 05:31:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqyE+xzwFNoH8U60ZdPkEe7q9JnNVz0eZkP1aFKf03/+dH5f6d3W27+/p2/nFzOlVApD0Wnnzw==
X-Received: by 2002:a05:6214:38c:: with SMTP id
 l12mr50614367qvy.224.1582637510971; 
 Tue, 25 Feb 2020 05:31:50 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 t37sm7793929qth.0.2020.02.25.05.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 05:31:50 -0800 (PST)
Date: Tue, 25 Feb 2020 08:31:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH 2/2] vhost-use-blk: convert to new virtio_delete_queue
Message-ID: <20200225083133-mutt-send-email-mst@kernel.org>
References: <20200213012807.45552-1-pannengyuan@huawei.com>
 <20200213012807.45552-3-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200213012807.45552-3-pannengyuan@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 09:28:07AM +0800, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> use the new virtio_delete_queue function to cleanup.
>=20
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

typo in subject use-blk->user-blk


> ---
>  hw/block/vhost-user-blk.c          | 11 +++++++----
>  include/hw/virtio/vhost-user-blk.h |  1 +
>  2 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 2eba8b9db0..ed6a5cc03b 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -420,9 +420,10 @@ static void vhost_user_blk_device_realize(DeviceStat=
e *dev, Error **errp)
>      virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
>                  sizeof(struct virtio_blk_config));
> =20
> +    s->virtqs =3D g_new0(VirtQueue *, s->num_queues);
>      for (i =3D 0; i < s->num_queues; i++) {
> -        virtio_add_queue(vdev, s->queue_size,
> -                         vhost_user_blk_handle_output);
> +        s->virtqs[i] =3D virtio_add_queue(vdev, s->queue_size,
> +                                        vhost_user_blk_handle_output);
>      }
> =20
>      s->inflight =3D g_new0(struct vhost_inflight, 1);
> @@ -461,8 +462,9 @@ virtio_err:
>      g_free(s->vqs);
>      g_free(s->inflight);
>      for (i =3D 0; i < s->num_queues; i++) {
> -        virtio_del_queue(vdev, i);
> +        virtio_delete_queue(s->virtqs[i]);
>      }
> +    g_free(s->virtqs);
>      virtio_cleanup(vdev);
>      vhost_user_cleanup(&s->vhost_user);
>  }
> @@ -482,8 +484,9 @@ static void vhost_user_blk_device_unrealize(DeviceSta=
te *dev, Error **errp)
>      g_free(s->inflight);
> =20
>      for (i =3D 0; i < s->num_queues; i++) {
> -        virtio_del_queue(vdev, i);
> +        virtio_delete_queue(s->virtqs[i]);
>      }
> +    g_free(s->virtqs);
>      virtio_cleanup(vdev);
>      vhost_user_cleanup(&s->vhost_user);
>  }
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost=
-user-blk.h
> index 108bfadeeb..f68911f6f0 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -37,6 +37,7 @@ typedef struct VHostUserBlk {
>      struct vhost_inflight *inflight;
>      VhostUserState vhost_user;
>      struct vhost_virtqueue *vqs;
> +    VirtQueue **virtqs;
>      guint watch;
>      bool connected;
>  } VHostUserBlk;
> --=20
> 2.21.0.windows.1
>=20


