Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56D6C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13E42467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wvuxt5h/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13E42467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6tOW-0008Nr-ON
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6tNw-0007rI-CK
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6tNv-0000Pr-9M
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:53:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45198
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6tNv-0000Mu-5F
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582710822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ao2aSRHWfywR/cBul0O8Tym+Bi61eo+4TSSTHa1bOj0=;
 b=Wvuxt5h/hGMQP6PzPFsSISsHe8rwsouu5nRRvhdzmtbvvo6k4VhUg2xoXFruxm9ML8OBqz
 AOTNS7hCT8KcARkXHXDimEu4u/6LDyLJI9BS5E0+U1N1ae+itjiGR5LqWU3GEaxwrOWCjG
 qWC+MljsseBZSq/massZsutDmQ8RiuQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-righ6pfxNVCxie-T2IdG2g-1; Wed, 26 Feb 2020 04:53:38 -0500
X-MC-Unique: righ6pfxNVCxie-T2IdG2g-1
Received: by mail-qk1-f198.google.com with SMTP id a10so3414036qkg.11
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Nb7JWOdVKx5PXc7GxFD9jzC/TqFyeZh7wn6KaCuQ1G8=;
 b=BMJdgKKh4JtaouzF+U7XLU6O2Ktd9mxABnC6rbfdut/vkkPSWxDdtLeqoO6jhtWmdA
 VpNEBQ7vIQ3mI00ZWU6HtCw2ErDBTN4jjiP0yca+PH54Hr4Cd42HL8XQsWttceVGamMA
 6CPfRBxLxsfreuUF5/XjWUD46Ex1qfLQWGvY0GgAtT9FYH068P2fifFeMBPcrQAinPD0
 HNziAx49BnhPxOqU8tjlkT7ogA/uvk+/WjHtmej6hImjIA5yX//2UGe30cTE7BqF+lmz
 LHppovak98vVvZcVVttRxtoD3+4ZVTxdx52z3V9o3KmBFUmilFXCVKfpVVX/qawZpCcJ
 iuhA==
X-Gm-Message-State: APjAAAXV4U3c8LhQ5TUkzhwfkCcMW6FLr5rfhM8mfSuQOsNdL1fI+T22
 jKBGRByAbGGoV63rUC91Rh5ba1dTdErYX6MTMv0yDb3u7EY43pvn4sZhRwtp9iu7CszAWR0q6K7
 7z2h/FCiYOvrjF9I=
X-Received: by 2002:ac8:60cf:: with SMTP id i15mr3807792qtm.6.1582710817994;
 Wed, 26 Feb 2020 01:53:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4//I2EUjuqlPAXh+8gx6zr3L632bD8wWLrHqLvccadWrQNY9/iG5Ko3PIrYRktx7UKS96LQ==
X-Received: by 2002:ac8:60cf:: with SMTP id i15mr3807775qtm.6.1582710817717;
 Wed, 26 Feb 2020 01:53:37 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 a14sm864135qkk.73.2020.02.26.01.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:53:36 -0800 (PST)
Date: Wed, 26 Feb 2020 04:53:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200226045128-mutt-send-email-mst@kernel.org>
References: <20200226094357.25061-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226094357.25061-1-jasowang@redhat.com>
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
Cc: pasic@linux.ibm.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 05:43:57PM +0800, Jason Wang wrote:
> We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditionally on
> platform without IOMMU support. This can lead unnecessary IOTLB
> transactions which will damage the performance.
>=20
> Fixing this by check whether the device is backed by IOMMU and disable
> device IOTLB.
>=20
> Reported-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")

Well it's just an optimization, isn't it?
I don't think it's justified to push this to everyone using
vhost with IOTLB, is it?
If you disagree, could you comment a bit on which configurations where test=
ed?

> Cc: qemu-stable@nongnu.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Halil could you test this pls? Does this help your performance issue?

> ---
> Changes from V1:
> - do not check acked_features
> - reuse vhost_dev_has_iommu()
> ---
>  hw/virtio/vhost.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 9edfadc81d..9182a00495 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -290,7 +290,14 @@ static int vhost_dev_has_iommu(struct vhost_dev *dev=
)
>  {
>      VirtIODevice *vdev =3D dev->vdev;
> =20
> -    return virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> +    /*
> +     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
> +     * incremental memory mapping API via IOTLB API. For platform that
> +     * does not have IOMMU, there's no need to enable this feature
> +     * which may cause unnecessary IOTLB miss/update trnasactions.
> +     */
> +    return vdev->dma_as !=3D &address_space_memory &&
> +           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
>  }
> =20
>  static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
> @@ -765,6 +772,9 @@ static int vhost_dev_set_features(struct vhost_dev *d=
ev,
>      if (enable_log) {
>          features |=3D 0x1ULL << VHOST_F_LOG_ALL;
>      }
> +    if (!vhost_dev_has_iommu(dev)) {
> +        features &=3D ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
> +    }
>      r =3D dev->vhost_ops->vhost_set_features(dev, features);
>      if (r < 0) {
>          VHOST_OPS_DEBUG("vhost_set_features failed");
> --=20
> 2.19.1


