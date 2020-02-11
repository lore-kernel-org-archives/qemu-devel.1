Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B63DC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB3A20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZWXURz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB3A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1TZf-0006Do-Kj
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 06:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1TXD-0003fK-AE
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:16:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1TXB-0003oQ-Jk
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:16:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60833
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1TXB-0003o2-DE
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581419813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXUIX0TCePu4uu8HzOv4jpqSTk1UM4mo0txy21Z5Ibs=;
 b=BZWXURz7lDT07Ic8rgW09xF+I0zLz0p8WU/OCy27h8jq5KZ4xyZRWanZo03X9jkjcrIV/l
 iFZ45tfhvXYDoWaBgKOCRowsNorN3D+vuMVcKxmZPFTCgpZPZNCNXxEPKpbAb0tMQjqBeX
 rPJtu7XG3vIWknlKvl/1LEP6lR1oS40=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-mH8h3bElPtaSqnrktLWnRw-1; Tue, 11 Feb 2020 06:16:51 -0500
Received: by mail-qv1-f71.google.com with SMTP id dw11so6902865qvb.16
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 03:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vKGNGn2it1JwwsYxCfUMczjolXl+hAYY/ftpLhJ2kO0=;
 b=ATHstxBCRCLfATwFp0IUz0Uhlq2COEwbGI+DCsqOI1Zhb20O8JSvIlGxGB/EQHjxlN
 jhTzmofnJAZp/FZN+0hVupVTEVIUvZKeoRJCwscJ7bD4heDauc38lWXJeBhn6NqP/CUW
 nIdNfGZCpvdY3V9Kvi+9zhLBFCANvxCU0/1lD0HwLrCp3YanvNLCtfce+cvaq13jqsME
 FzVFJmiUQeG5sTCUD91LP+Oo+gKLk2tl2/dim/q4P9lOE46qWDRK6sDtwsvV8WQF0+QG
 oI8hyfs4V/8frKe2aUHicpn6TPMpe1zoQDBZD56TqIh+Uu2D40ED01qYQehp6oUSMP3o
 mA3g==
X-Gm-Message-State: APjAAAUlS4nTWeWMBD04qBsziQQczWMS0rMR3xbCmbyiVH/eEJyZc3WY
 UcLSCNUL22sN4a06UzC0ldcFLW1xIKG7uZ2M7A/gR5q/yin3bJIRNQF4CD5XNHL/LCvkQMHKwyT
 EWkINyaC30Uj8nww=
X-Received: by 2002:a37:8683:: with SMTP id i125mr2161811qkd.491.1581419811123; 
 Tue, 11 Feb 2020 03:16:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzpubveRI33Yzc0hGrHTQqqdWpmrDXHJXaUUgY3HWWAVkliyxjcqXfwsVPK/NbnSdEAahm0Yw==
X-Received: by 2002:a37:8683:: with SMTP id i125mr2161788qkd.491.1581419810854; 
 Tue, 11 Feb 2020 03:16:50 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id d25sm1788100qka.39.2020.02.11.03.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 03:16:50 -0800 (PST)
Date: Tue, 11 Feb 2020 06:16:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zha Bin <zhabin@linux.alibaba.com>
Subject: Re: [PATCH v2 3/5] virtio-mmio: create a generic MSI irq domain
Message-ID: <20200211061503-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c52548758eefe1fe7078d3b6f10492a001c0636.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <4c52548758eefe1fe7078d3b6f10492a001c0636.1581305609.git.zhabin@linux.alibaba.com>
X-MC-Unique: mH8h3bElPtaSqnrktLWnRw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Mon, Feb 10, 2020 at 05:05:19PM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>=20
> Create a generic irq domain for all architectures which
> supports virtio-mmio. The device offering VIRTIO_F_MMIO_MSI
> feature bit can use this irq domain.
>=20
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  drivers/base/platform-msi.c      |  4 +-
>  drivers/virtio/Kconfig           |  9 ++++
>  drivers/virtio/virtio_mmio_msi.h | 93 ++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/msi.h              |  1 +
>  4 files changed, 105 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/virtio/virtio_mmio_msi.h


This patch needs to copy maintainers for drivers/base/platform-msi.c and
include/linux/msi.h

> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index 8da314b..45752f1 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -31,12 +31,11 @@ struct platform_msi_priv_data {
>  /* The devid allocator */
>  static DEFINE_IDA(platform_msi_devid_ida);
> =20
> -#ifdef GENERIC_MSI_DOMAIN_OPS
>  /*
>   * Convert an msi_desc to a globaly unique identifier (per-device
>   * devid + msi_desc position in the msi_list).
>   */
> -static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
> +irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
>  {
>  =09u32 devid;
> =20
> @@ -45,6 +44,7 @@ static irq_hw_number_t platform_msi_calc_hwirq(struct m=
si_desc *desc)
>  =09return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
>  }
> =20
> +#ifdef GENERIC_MSI_DOMAIN_OPS
>  static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc=
 *desc)
>  {
>  =09arg->desc =3D desc;
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 078615c..551a9f7 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -84,6 +84,15 @@ config VIRTIO_MMIO
> =20
>   =09 If unsure, say N.
> =20
> +config VIRTIO_MMIO_MSI
> +=09bool "Memory-mapped virtio device MSI"
> +=09depends on VIRTIO_MMIO && GENERIC_MSI_IRQ_DOMAIN && GENERIC_MSI_IRQ
> +=09help
> +=09 This allows device drivers to support msi interrupt handling for
> +=09 virtio-mmio devices. It can improve performance greatly.
> +
> +=09 If unsure, say N.
> +
>  config VIRTIO_MMIO_CMDLINE_DEVICES
>  =09bool "Memory mapped virtio devices parameter parsing"
>  =09depends on VIRTIO_MMIO
> diff --git a/drivers/virtio/virtio_mmio_msi.h b/drivers/virtio/virtio_mmi=
o_msi.h
> new file mode 100644
> index 0000000..27cb2af
> --- /dev/null
> +++ b/drivers/virtio/virtio_mmio_msi.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _DRIVERS_VIRTIO_VIRTIO_MMIO_MSI_H
> +#define _DRIVERS_VIRTIO_VIRTIO_MMIO_MSI_H
> +
> +#ifdef CONFIG_VIRTIO_MMIO_MSI
> +
> +#include <linux/msi.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/platform_device.h>
> +
> +static irq_hw_number_t mmio_msi_hwirq;
> +static struct irq_domain *mmio_msi_domain;
> +
> +struct irq_domain *__weak arch_msi_root_irq_domain(void)
> +{
> +=09return NULL;
> +}
> +
> +void __weak irq_msi_compose_msg(struct irq_data *data, struct msi_msg *m=
sg)
> +{
> +}
> +
> +static void mmio_msi_mask_irq(struct irq_data *data)
> +{
> +}
> +
> +static void mmio_msi_unmask_irq(struct irq_data *data)
> +{
> +}
> +
> +static struct irq_chip mmio_msi_controller =3D {
> +=09.name=09=09=09=3D "VIRTIO-MMIO-MSI",
> +=09.irq_mask=09=09=3D mmio_msi_mask_irq,
> +=09.irq_unmask=09=09=3D mmio_msi_unmask_irq,
> +=09.irq_ack=09=09=3D irq_chip_ack_parent,
> +=09.irq_retrigger=09=09=3D irq_chip_retrigger_hierarchy,
> +=09.irq_compose_msi_msg=09=3D irq_msi_compose_msg,
> +=09.flags=09=09=09=3D IRQCHIP_SKIP_SET_WAKE,
> +};
> +
> +static int mmio_msi_prepare(struct irq_domain *domain, struct device *de=
v,
> +=09=09=09=09int nvec, msi_alloc_info_t *arg)
> +{
> +=09memset(arg, 0, sizeof(*arg));
> +=09return 0;
> +}
> +
> +static void mmio_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *de=
sc)
> +{
> +=09mmio_msi_hwirq =3D platform_msi_calc_hwirq(desc);
> +}


This call isn't exported to modules. How will it work when virtio is
modular?

> +
> +static irq_hw_number_t mmio_msi_get_hwirq(struct msi_domain_info *info,
> +=09=09=09=09=09      msi_alloc_info_t *arg)
> +{
> +=09return mmio_msi_hwirq;
> +}
> +
> +static struct msi_domain_ops mmio_msi_domain_ops =3D {
> +=09.msi_prepare=09=3D mmio_msi_prepare,
> +=09.set_desc=09=3D mmio_msi_set_desc,
> +=09.get_hwirq=09=3D mmio_msi_get_hwirq,
> +};
> +
> +static struct msi_domain_info mmio_msi_domain_info =3D {
> +=09.flags          =3D MSI_FLAG_USE_DEF_DOM_OPS |
> +=09=09=09  MSI_FLAG_USE_DEF_CHIP_OPS |
> +=09=09=09  MSI_FLAG_ACTIVATE_EARLY,
> +=09.ops            =3D &mmio_msi_domain_ops,
> +=09.chip           =3D &mmio_msi_controller,
> +=09.handler        =3D handle_edge_irq,
> +=09.handler_name   =3D "edge",
> +};
> +
> +static inline void mmio_msi_create_irq_domain(void)
> +{
> +=09struct fwnode_handle *fn;
> +=09struct irq_domain *parent =3D arch_msi_root_irq_domain();
> +
> +=09fn =3D irq_domain_alloc_named_fwnode("VIRTIO-MMIO-MSI");
> +=09if (fn && parent) {
> +=09=09mmio_msi_domain =3D
> +=09=09=09platform_msi_create_irq_domain(fn,
> +=09=09=09=09&mmio_msi_domain_info, parent);
> +=09=09irq_domain_free_fwnode(fn);
> +=09}
> +}
> +#else
> +static inline void mmio_msi_create_irq_domain(void) {}
> +#endif
> +
> +#endif
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 8ad679e..ee5f566 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -362,6 +362,7 @@ int platform_msi_domain_alloc(struct irq_domain *doma=
in, unsigned int virq,
>  void platform_msi_domain_free(struct irq_domain *domain, unsigned int vi=
rq,
>  =09=09=09      unsigned int nvec);
>  void *platform_msi_get_host_data(struct irq_domain *domain);
> +irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc);
>  #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
> =20
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> --=20
> 1.8.3.1


