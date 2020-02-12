Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3CBC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CCC206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anIyMXyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CCC206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1meO-0004Uw-Lj
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 02:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1md3-00036c-LZ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1md2-0008MP-0q
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:40:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1md1-0008M1-SQ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581493211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mrHbuaMlnERkGtyLRhbM6jrYlqM8KMZduIIgctHI/SM=;
 b=anIyMXyub+Np/ROlsEYjho3cBZSjpkFbwVZLLcjc6nUhxoXAU/GP7mI/DgBpxgK/41hjQq
 hsIWsOcdiLi0i36yjoF+i59j3G9c1RkCRTUfTU9LDIjcnecjcn//48xZipyHo3t30bG4bG
 G7/1Sv5UWgmYmsqy8aC44/QV0hKvJ3A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-j-azpxgmMTSP_z62io9-bA-1; Wed, 12 Feb 2020 02:40:09 -0500
Received: by mail-qv1-f69.google.com with SMTP id d7so904370qvq.12
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 23:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xVKePZgaphaDI35OhGGqEmHTyZDPeJtIwjix5bHryQw=;
 b=LNcV5UKM2NB7DodEsn3p8axe9HJkgXTc0FUAoue8w7PzSwJ79GUoKW+IzsFb/eL3xZ
 g3Hciouda2qSSkn83dwQEjMixJ/RLHds2kF3Y1tUHIGMZyePmTcjxWYagwgtF5vl/OPy
 xuMHLyc30i02kJZMQwQsq5PEmf+TIgUxQNwryAewe+/YGqcsTWzcvZn3NzP7Ua++HGga
 vqrC8U89wqZk13d6u8wFlOAa7KUUaUotQ9I5nuFs/CsWIHtz71tcBchjc9HAYeqU+DKU
 LCeSKD4pAN8D075QKOjYh4XIn8hSrT6N2XCj5XrMiIez6h5pV4NgRBc12uPyNtC5jih9
 w/4g==
X-Gm-Message-State: APjAAAWb6j3TGKaZY0aJrsR2dEubHFsje3WMlpuEeCwTZtUiagX+IomC
 NGOx0x1IYoLx/q/Ecz8QOl7hAIiG56K3XG570fuvTaIAgjHfnPJnymbzn9Cgs/tmGYJ5hgiqbgN
 6+8FpjzS/MsrMQ/I=
X-Received: by 2002:a37:2e44:: with SMTP id u65mr4852229qkh.262.1581493209133; 
 Tue, 11 Feb 2020 23:40:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyy+Ry1Zatw1m0sXpMx8HYxWWQ4COR7G3iFEl3z4TO+wr2swYRITwLGNXj+PQF406l4DPKOmQ==
X-Received: by 2002:a37:2e44:: with SMTP id u65mr4852208qkh.262.1581493208834; 
 Tue, 11 Feb 2020 23:40:08 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id i28sm3841339qtc.57.2020.02.11.23.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 23:40:08 -0800 (PST)
Date: Wed, 12 Feb 2020 02:40:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zha Bin <zhabin@linux.alibaba.com>
Subject: Re: [PATCH v2 3/5] virtio-mmio: create a generic MSI irq domain
Message-ID: <20200212023540-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c52548758eefe1fe7078d3b6f10492a001c0636.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <4c52548758eefe1fe7078d3b6f10492a001c0636.1581305609.git.zhabin@linux.alibaba.com>
X-MC-Unique: j-azpxgmMTSP_z62io9-bA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
>=20
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

So each instance of including this header will create its own
copy of the variables. That won't do the right thing.


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

It does not look like anyone cleans up this domain.
So how does this work with a modular virtio mmio?
what happens when you unload the module?


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


