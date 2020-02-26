Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A591C4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DB121556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/un15Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DB121556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6qrk-0001We-FA
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6qqc-00013J-PO
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6qqb-0005Ya-Ol
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:11:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31324
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6qqb-0005TK-Jt
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582701068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7lXWaOJsbx/jQpEUw2LKaTHTDcWqnLfGdEwHbB2he2g=;
 b=O/un15MrhwZx4+DI0D3Nr6dzPbBtozZfDJM3ZnanS2DuU8wsIbQCRdhp2z09tCFAWvp/Tu
 FiYWhc+LAPHRBBwE27oD7qFCP4LgqyEW//o8jZt5m2oJTEsslqFgwSYxMg7Xa+9VWg99KH
 DgspkB5Y0z92wuBelhocMc25paZjd74=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-rRxcs8a3MA6c5cfdzQ8Hbw-1; Wed, 26 Feb 2020 02:11:06 -0500
X-MC-Unique: rRxcs8a3MA6c5cfdzQ8Hbw-1
Received: by mail-qk1-f199.google.com with SMTP id o22so2879374qko.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Fpl/hzWIr/GnKc61dYozzHyTfEmb0tklX0xQgMh3Sag=;
 b=NVoQUfQLXmQDDm6j8EKYtzL5ovhF7iHkuyc3KUpuq959zlpiU6uTxAU7VUgLXhpS8v
 ZSwCs+FSGX9mi29bsNF+/DL38UE9xXlvNuFTd3jYYV3jFI0nkTkRk4UV6iHIVxBGJthW
 8/3rnCjc6Q/arsLM46k+WPvmR9bh9q/p+y/4RNna42iJE8ZpZSMNdOSpU7a5wzMhofLY
 Cn+pf84UZbxd7ryGz/yvRrGnYSxAfyTV/BhEuPnYJzP2gQG3Z+p9MxOpLeo8IPJji8GC
 g1+bFQaP6aJXb6aB8WQu3SdQcCBM6rr+ZrmBCEMR32sEnzP1efbgvrEmMgryYZ2lxVji
 T/+g==
X-Gm-Message-State: APjAAAUrLroJnZyEfobU9D96a/yGh6PhFmH1kD4mFFxC3Te1j+zGevql
 E1IieFdOFEEQq9nV+kMOspT8tkyQjngXrFHxaycUaHRswjGvCA2iv99iXig3y/nkIhBm2XIFFvg
 tmtGN4GbD+GgT9fk=
X-Received: by 2002:a37:9f92:: with SMTP id i140mr3740548qke.353.1582701066433; 
 Tue, 25 Feb 2020 23:11:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9nTSjE3O+/x3W+Vws/gdPwXcx39qYcoOdu+B9jbAdcGhEGNvKy8Nsr6wkf8u6UivK5f77aw==
X-Received: by 2002:a37:9f92:: with SMTP id i140mr3740533qke.353.1582701066200; 
 Tue, 25 Feb 2020 23:11:06 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 t55sm657325qte.24.2020.02.25.23.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:11:05 -0800 (PST)
Date: Wed, 26 Feb 2020 02:11:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200226020836-mutt-send-email-mst@kernel.org>
References: <20200226070647.8103-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226070647.8103-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pasic@linux.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 03:06:47PM +0800, Jason Wang wrote:
> We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditionally on
> platform without IOMMU support. This can lead unnecessary IOTLB
> transactions which will damage the performance.
>=20
> Fixing this by check whether the device is backed by IOMMU and disable
> device IOTLB.
>=20
> Reported-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/virtio/vhost.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 9edfadc81d..6e12c3d2de 100644
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
> +           virtio_has_feature(dev->acked_features, VIRTIO_F_IOMMU_PLATFO=
RM);
>  }
> =20
>  static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,

Why check acked_features and not host features here?
I'd worry that if we do it like this, userspace driver
within guest can clear the feature and make device access
memory directly.

> @@ -765,6 +772,9 @@ static int vhost_dev_set_features(struct vhost_dev *d=
ev,
>      if (enable_log) {
>          features |=3D 0x1ULL << VHOST_F_LOG_ALL;
>      }
> +    if (dev->vdev->dma_as =3D=3D &address_space_memory) {
> +        features &=3D ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
> +    }


That's a guest visible change. Which seems at best unnecessary.

>      r =3D dev->vhost_ops->vhost_set_features(dev, features);
>      if (r < 0) {
>          VHOST_OPS_DEBUG("vhost_set_features failed");
> --=20
> 2.19.1


