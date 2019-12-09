Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF125C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9AC12073D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMot1G3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AC12073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieM91-0004eM-QH
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 11:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ieM89-0003m7-9L
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ieM86-0000CB-GT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:43:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21837
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ieM86-0000BV-CM
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575909804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqhO5wQRtbCoA2F8LWdaIxBVcTgPzuKnPF5cRMFDKvE=;
 b=fMot1G3NqlNqdcIrDQOT4fU6H87p22EfwQK+7j0zTZh0T0WyLuBUnDyqs5+jYD8llq6jAm
 3F2VgvYwM2mKmJqfdJ+e6o5BqvDHxze/IYiAuI4GUkQhgsiNErW254cPK8n3OnpeKkOEVE
 8NZbCShrG8YLWkF2DCmgFZGl+rTLcrE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-8T2qrbBTPaCLCTIwoWchlw-1; Mon, 09 Dec 2019 11:43:21 -0500
Received: by mail-qt1-f197.google.com with SMTP id 42so10380601qtc.19
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 08:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xSBb20qbydsUzSxKFXZFrMLiwYxaTAtXYqCQ176ms+w=;
 b=tod0zm/bHTvzNmrSRainf5lthEc9f4qYvYAbnknwisxbUw1VY/7LJl7zHIpTxzfmCX
 7XQiqyMFy1xZL25hyVU9VhVQOlP2eQpbovQZ61o8sP6Q2n1i04aWyhNc8YuEsPCCkSYX
 Wcj8Fz883INI2/uvHf1wS8gm7YYuj1UDksjJTqypj0yEYHVLjWIc1uAXcqLNK/NCF0x0
 Ero7XpGDHVrXIP6nu0cbH+VU8wY708QdHhLb9FNFVSuGy4dUmlm8uwOP2Us0q7S76Yjg
 kTgkbuaYLPO86iy0gU3Z3xcPW7ftk3DcemFTZkOrpYqrVN0NSx+pOJZKci/geJzVYs3d
 AU8w==
X-Gm-Message-State: APjAAAWu8QuzInncf0olIU1B7Yw1iC/wiQS+i8mXMCBCVziIxXUmj9Pg
 trtw/lMqvxGHCY1oN2RpXU+y611GfZFqnCzawisd0WqBYZRNYR4Mm3/cEbJRK+orDF2Uiw468GP
 g6cmNBNdOZBTjcrI=
X-Received: by 2002:aed:3786:: with SMTP id j6mr2822440qtb.62.1575909800875;
 Mon, 09 Dec 2019 08:43:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/cbycUqCTvsfvQNZDTAzw7I2ys2pqkxL62NQMb2BCK4H2S2IBsWpgIYKcI+m8a8RKJtuMvw==
X-Received: by 2002:aed:3786:: with SMTP id j6mr2822407qtb.62.1575909800606;
 Mon, 09 Dec 2019 08:43:20 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id r41sm34317qtr.60.2019.12.09.08.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 08:43:19 -0800 (PST)
Date: Mon, 9 Dec 2019 11:43:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH v2 1/3] virtio: add ability to delete vq through a pointer
Message-ID: <20191209114042-mutt-send-email-mst@kernel.org>
References: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
X-MC-Unique: 8T2qrbBTPaCLCTIwoWchlw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 04, 2019 at 03:31:54PM +0800, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> Devices tend to maintain vq pointers, allow deleting them trough a vq poi=
nter.

You want to also mention something about clearing
.used_elems to avoid chances of double free.

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>


So let's just name the new one virtio_del_queue then,
and drop the old one.


> ---
> Changes v2 to v1:
> - add a new function virtio_delete_queue to cleanup vq through a vq point=
er
> ---
>  hw/virtio/virtio.c         | 16 +++++++++++-----
>  include/hw/virtio/virtio.h |  2 ++
>  2 files changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 04716b5..6de3cfd 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2330,17 +2330,23 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, i=
nt queue_size,
>      return &vdev->vq[i];
>  }
> =20
> +void virtio_delete_queue(VirtQueue *vq)
> +{
> +    vq->vring.num =3D 0;
> +    vq->vring.num_default =3D 0;
> +    vq->handle_output =3D NULL;
> +    vq->handle_aio_output =3D NULL;
> +    g_free(vq->used_elems);
> +    vq->used_elems =3D NULL;
> +}
> +
>  void virtio_del_queue(VirtIODevice *vdev, int n)
>  {
>      if (n < 0 || n >=3D VIRTIO_QUEUE_MAX) {
>          abort();
>      }
> =20
> -    vdev->vq[n].vring.num =3D 0;
> -    vdev->vq[n].vring.num_default =3D 0;
> -    vdev->vq[n].handle_output =3D NULL;
> -    vdev->vq[n].handle_aio_output =3D NULL;
> -    g_free(vdev->vq[n].used_elems);
> +    virtio_delete_queue(&vdev->vq[n]);
>  }
> =20
>  static void virtio_set_isr(VirtIODevice *vdev, int value)
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c32a815..e18756d 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -183,6 +183,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int q=
ueue_size,
> =20
>  void virtio_del_queue(VirtIODevice *vdev, int n);
> =20
> +void virtio_delete_queue(VirtQueue *vq);
> +
>  void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
>                      unsigned int len);
>  void virtqueue_flush(VirtQueue *vq, unsigned int count);
> --=20
> 2.7.2.windows.1
>=20


