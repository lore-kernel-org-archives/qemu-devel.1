Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95028C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624F920714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCsRoueV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624F920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Tai-0007SO-JC
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 06:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1TZZ-0006Hl-0H
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:19:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1TZW-0005Z3-OI
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:19:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29498
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1TZW-0005YQ-Jm
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581419958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cOZVQxmhcACBiEyvfJiPPgEZwxwrY/rcJZro8baG7hs=;
 b=QCsRoueVIWrJl3qjH9mQp806sSAeK0JDrTEzFawXxjUDcexXhwuUem66dtWNyRrUP1EHNJ
 tmhJEO1YL5VPR47Yj+4FfdRjANc3o7LZaSYqrVq4mYYL/kWJlhoWkHHOdndrV0O5jLF6Yn
 +36D/GVjNErmDsVApSPaMUQ5URspn4o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-BcJkP-C0PfW5RsexFj8DVQ-1; Tue, 11 Feb 2020 06:19:14 -0500
Received: by mail-qv1-f71.google.com with SMTP id u11so6920991qvo.8
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 03:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zSGk4DByZIhPCN8YAGetuggpX02PP2LILdI0T2sXvxE=;
 b=c8X2BN3OaXoqd/RkFb3MxSE9970rJtKcG9pQACFyx7AzqPpGWLX7ZrrGnvnjn/6DtL
 kl8JrJxULw8ldTOM3XFCWucVvk8CtrMU9QNNlhCtJNPF1U77Dyw7dzP6rb3uqXz35Ojl
 hnpvSGYSUZl+yFOB57H1Pn4tHfAEnL7sGzyqEKHd9FePuey6smeH7XpQB69kFZqmfmBe
 vxqt1tDsUzmTtLQDPZuPqsWrXQUwyS5G0noIURo8iwRRsMbUCdEB0jBr+2ublTdRYPvi
 mrVEuwhV0jNaPVi4/xXLSJgu3mUUyovs4IZsoHVt6aqlHSVsYslW/+Ub07dyPqvQgc9D
 IUjw==
X-Gm-Message-State: APjAAAU5hN9Y2yaEb0C39kaFdtzuyesD6Z+TdpGW9hv8qDBsOKIMru6e
 JM4ZRNtAPTM5DlP4TeexLzmkzuE2gwmHgyyZeMaZVkczRFWqhxkQWOwQUCC6+7dE6wexE37zzt/
 mDDVlP9EjeRH/2og=
X-Received: by 2002:a05:6214:118d:: with SMTP id
 t13mr2296515qvv.5.1581419953558; 
 Tue, 11 Feb 2020 03:19:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYkabWO8BaOzkqEcEDtxnu6+npU98PB75JpNvCUUh3RdtmsBY+hd7Uve9DjDBn8TDJQxQngQ==
X-Received: by 2002:a05:6214:118d:: with SMTP id
 t13mr2296501qvv.5.1581419953351; 
 Tue, 11 Feb 2020 03:19:13 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id 73sm1920892qtg.40.2020.02.11.03.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 03:19:12 -0800 (PST)
Date: Tue, 11 Feb 2020 06:19:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zha Bin <zhabin@linux.alibaba.com>
Subject: Re: [PATCH v2 2/5] virtio-mmio: refactor common functionality
Message-ID: <20200211061758-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <0268807dc26ecdf5620de9000758d05ca0b21f3f.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <0268807dc26ecdf5620de9000758d05ca0b21f3f.1581305609.git.zhabin@linux.alibaba.com>
X-MC-Unique: BcJkP-C0PfW5RsexFj8DVQ-1
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
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, jasowang@redhat.com,
 jing2.liu@linux.intel.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 10, 2020 at 05:05:18PM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>=20
> Common functionality is refactored into virtio_mmio_common.h
> in order to MSI support in later patch set.
>=20
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>

What does this proliferation of header files achieve?
common with what?

> ---
>  drivers/virtio/virtio_mmio.c        | 21 +--------------------
>  drivers/virtio/virtio_mmio_common.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 20 deletions(-)
>  create mode 100644 drivers/virtio/virtio_mmio_common.h
>=20
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 1733ab97..41e1c93 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -61,13 +61,12 @@
>  #include <linux/io.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> -#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> -#include <linux/virtio.h>
>  #include <linux/virtio_config.h>
>  #include <uapi/linux/virtio_mmio.h>
>  #include <linux/virtio_ring.h>
> +#include "virtio_mmio_common.h"
> =20
> =20
> =20
> @@ -77,24 +76,6 @@
> =20
> =20
> =20
> -#define to_virtio_mmio_device(_plat_dev) \
> -=09container_of(_plat_dev, struct virtio_mmio_device, vdev)
> -
> -struct virtio_mmio_device {
> -=09struct virtio_device vdev;
> -=09struct platform_device *pdev;
> -
> -=09void __iomem *base;
> -=09unsigned long version;
> -
> -=09/* a list of queues so we can dispatch IRQs */
> -=09spinlock_t lock;
> -=09struct list_head virtqueues;
> -
> -=09unsigned short notify_base;
> -=09unsigned short notify_multiplier;
> -};
> -
>  struct virtio_mmio_vq_info {
>  =09/* the actual virtqueue */
>  =09struct virtqueue *vq;
> diff --git a/drivers/virtio/virtio_mmio_common.h b/drivers/virtio/virtio_=
mmio_common.h
> new file mode 100644
> index 0000000..90cb304
> --- /dev/null
> +++ b/drivers/virtio/virtio_mmio_common.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
> +#define _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
> +/*
> + * Virtio MMIO driver - common functionality for all device versions
> + *
> + * This module allows virtio devices to be used over a memory-mapped dev=
ice.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/virtio.h>
> +
> +#define to_virtio_mmio_device(_plat_dev) \
> +=09container_of(_plat_dev, struct virtio_mmio_device, vdev)
> +
> +struct virtio_mmio_device {
> +=09struct virtio_device vdev;
> +=09struct platform_device *pdev;
> +
> +=09void __iomem *base;
> +=09unsigned long version;
> +
> +=09/* a list of queues so we can dispatch IRQs */
> +=09spinlock_t lock;
> +=09struct list_head virtqueues;
> +
> +=09unsigned short notify_base;
> +=09unsigned short notify_multiplier;
> +};
> +
> +#endif
> --=20
> 1.8.3.1


