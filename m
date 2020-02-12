Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6D2C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54545206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMUqswCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54545206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1mUA-0007Ak-Gr
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 02:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1mTJ-0006XV-Nf
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1mTH-0005gl-GF
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:30:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24801
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1mTH-0005gZ-Bs
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581492606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VR+eMMCh5fBQCk6SyclM0g2Ko01df0pB+L538/AEFFI=;
 b=FMUqswCKDzxboreJaQYArjI6yAI6ynhyfVevy8kXkcRi4df+i7rrM37CpQOOOjTpDsFCxg
 PmDA+gR4iYwA5RJT+RrJ4KPRlqmjHdNf3kZPe6mUtdpXuGMWPJYxrPCacQ5ufdEQ6M+ACI
 DFb5IXBDzBA5hk6fqQl4oF75enOJlvA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-sb4qsCb6OWGQwisU5GM1aA-1; Wed, 12 Feb 2020 02:30:04 -0500
Received: by mail-qv1-f69.google.com with SMTP id v3so915853qvm.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 23:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4x1as1g2yZr98MHN4k/1ke02no9RwRCiPwFENwA3Qiw=;
 b=pOSAf7Y4FFqczPb6XhjMnrARbRZGOaUmUJb7CEOxup6TFfd+AZgF0O+VU0D6gGBzx7
 sYfVHGwm7gjKZ1pGAyUrIjua+1/ZVvqDnyjt8S4OP9IykaP6qVlJwI7KLEI4DBmMQuyd
 CmPfBycLiwb/EEPNtLX5/YB6j6Q3SSg7whC4y6mGKOqEUwjLlsVx07EsN0WSVR9av8/j
 892/ybJhuDa/CvgN/uPlvP4joeR1j+LETG9WjoPdOqHKQwyqb9ofueLpWmvChuIKp6FA
 cCCTmdEbpbB7RnAIARMmm8sqZuqdAspvUcJY2ddfKPKcDi7foOnweEvftHCr1HTWReQP
 xz/Q==
X-Gm-Message-State: APjAAAUNVb/xHM+/cHpU/4wKYVpd56Vwsawy4+Q8KIXNttyRKp2mwZt5
 jRhAOJKQTkUtwRmZz8Gb06elMLa5+rEY5Q0WtwaAuGGPGs8Wougp2CsUiSjdD0rWcNwnuCw1pcx
 EhMoZ3E54kXVBt/U=
X-Received: by 2002:ac8:969:: with SMTP id z38mr17806306qth.203.1581492603950; 
 Tue, 11 Feb 2020 23:30:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBSlkyW/UAB2wFI1BlviEOXV5VuXHDYwkwFSa1AA0YFbOLTQt3Gy0zGbRq/HqurS0H3MZ2ew==
X-Received: by 2002:ac8:969:: with SMTP id z38mr17806294qth.203.1581492603714; 
 Tue, 11 Feb 2020 23:30:03 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id n4sm3602146qti.55.2020.02.11.23.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 23:30:02 -0800 (PST)
Date: Wed, 12 Feb 2020 02:29:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Liu, Jing2" <jing2.liu@linux.intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 2/5] virtio-mmio: refactor common
 functionality
Message-ID: <20200212022842-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <0268807dc26ecdf5620de9000758d05ca0b21f3f.1581305609.git.zhabin@linux.alibaba.com>
 <20200211061758-mutt-send-email-mst@kernel.org>
 <787bac48-3fd0-316a-a99a-8c93154dc8e2@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <787bac48-3fd0-316a-a99a-8c93154dc8e2@linux.intel.com>
X-MC-Unique: sb4qsCb6OWGQwisU5GM1aA-1
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
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>,
 slp@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 10:58:13AM +0800, Liu, Jing2 wrote:
>=20
> On 2/11/2020 7:19 PM, Michael S. Tsirkin wrote:
> > On Mon, Feb 10, 2020 at 05:05:18PM +0800, Zha Bin wrote:
> > > From: Liu Jiang <gerry@linux.alibaba.com>
> > >=20
> > > Common functionality is refactored into virtio_mmio_common.h
> > > in order to MSI support in later patch set.
> > >=20
> > > Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> > > Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> > > Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> > > Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
> > > Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> > > Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > What does this proliferation of header files achieve?
> > common with what?
>=20
> We're considering that the virtio mmio structure is useful for virtio mmi=
o
> msi file so refactor out.

I would not put msi in a separate file either.

> e.g. to get the base of virtio_mmio_device from struct msi_desc *desc.
>=20
> Jing
>=20
>=20
> > > ---
> > >   drivers/virtio/virtio_mmio.c        | 21 +--------------------
> > >   drivers/virtio/virtio_mmio_common.h | 31 ++++++++++++++++++++++++++=
+++++
> > >   2 files changed, 32 insertions(+), 20 deletions(-)
> > >   create mode 100644 drivers/virtio/virtio_mmio_common.h
> > >=20
> > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmi=
o.c
> > > index 1733ab97..41e1c93 100644
> > > --- a/drivers/virtio/virtio_mmio.c
> > > +++ b/drivers/virtio/virtio_mmio.c
> > > @@ -61,13 +61,12 @@
> > >   #include <linux/io.h>
> > >   #include <linux/list.h>
> > >   #include <linux/module.h>
> > > -#include <linux/platform_device.h>
> > >   #include <linux/slab.h>
> > >   #include <linux/spinlock.h>
> > > -#include <linux/virtio.h>
> > >   #include <linux/virtio_config.h>
> > >   #include <uapi/linux/virtio_mmio.h>
> > >   #include <linux/virtio_ring.h>
> > > +#include "virtio_mmio_common.h"
> > > @@ -77,24 +76,6 @@
> > > -#define to_virtio_mmio_device(_plat_dev) \
> > > -=09container_of(_plat_dev, struct virtio_mmio_device, vdev)
> > > -
> > > -struct virtio_mmio_device {
> > > -=09struct virtio_device vdev;
> > > -=09struct platform_device *pdev;
> > > -
> > > -=09void __iomem *base;
> > > -=09unsigned long version;
> > > -
> > > -=09/* a list of queues so we can dispatch IRQs */
> > > -=09spinlock_t lock;
> > > -=09struct list_head virtqueues;
> > > -
> > > -=09unsigned short notify_base;
> > > -=09unsigned short notify_multiplier;
> > > -};
> > > -
> > >   struct virtio_mmio_vq_info {
> > >   =09/* the actual virtqueue */
> > >   =09struct virtqueue *vq;
> > > diff --git a/drivers/virtio/virtio_mmio_common.h b/drivers/virtio/vir=
tio_mmio_common.h
> > > new file mode 100644
> > > index 0000000..90cb304
> > > --- /dev/null
> > > +++ b/drivers/virtio/virtio_mmio_common.h
> > > @@ -0,0 +1,31 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +#ifndef _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
> > > +#define _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
> > > +/*
> > > + * Virtio MMIO driver - common functionality for all device versions
> > > + *
> > > + * This module allows virtio devices to be used over a memory-mapped=
 device.
> > > + */
> > > +
> > > +#include <linux/platform_device.h>
> > > +#include <linux/virtio.h>
> > > +
> > > +#define to_virtio_mmio_device(_plat_dev) \
> > > +=09container_of(_plat_dev, struct virtio_mmio_device, vdev)
> > > +
> > > +struct virtio_mmio_device {
> > > +=09struct virtio_device vdev;
> > > +=09struct platform_device *pdev;
> > > +
> > > +=09void __iomem *base;
> > > +=09unsigned long version;
> > > +
> > > +=09/* a list of queues so we can dispatch IRQs */
> > > +=09spinlock_t lock;
> > > +=09struct list_head virtqueues;
> > > +
> > > +=09unsigned short notify_base;
> > > +=09unsigned short notify_multiplier;
> > > +};
> > > +
> > > +#endif
> > > --=20
> > > 1.8.3.1
> >=20
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >=20


