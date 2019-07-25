Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410B3C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A0FD20840
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0FD20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqaWL-00064y-D6
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46695)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqaWB-0005bE-89
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqaW9-0002y2-O4
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:58:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41287)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqaW9-0002vE-FS
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:58:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id v22so35946573qkj.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 02:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FeNtfL0wo68RDO0TuROfhiuzTqwTx2GfZEg77is6vuQ=;
 b=PXxKGT+dYABHjY+LlxHIDcw/yviLhnG8Z7K+R8yHsXRQe+AbUBvyOoqVOj+67ty+tX
 3j6vk3c4ZaVSRlyOLNRqY3F9t3YLU/qpliLmlq3g3pTF7fQzAEoJC+TBNkwFPYX32tgS
 n0wIymFbg9GuuV3fjfHPIPIfsd5/jvHfzqSCKDSYxysXXfK+TRdC0e+Mnb/bGQk1YSjl
 GnpdRAI8EyRcKcT4kcUel2e/7dIzAacWrZXiyo9JpNQRamVQiWVGCB4x8joxxs4Dj7v0
 Nt0sgOFASetvtFBmzqEH1Lr6PIEvcRFepQakzSOLrG9zE++VDa6v1Km7bVN837eRCFuU
 vt8w==
X-Gm-Message-State: APjAAAWNQl8jk7q4j5qrbcng5YVbWR7+eveu0d6KUChsIYAZfAXLGS06
 lnYJXw9MohNZXpUmZFo74xenyA==
X-Google-Smtp-Source: APXvYqxcbdiYz7Z6jvqnf03ibeXdcGUl8HHmB+bxepD6YujWoXN3tr5+GQ00Gf213htUFZFXMg08sg==
X-Received: by 2002:a37:3c9:: with SMTP id 192mr57161372qkd.37.1564048711804; 
 Thu, 25 Jul 2019 02:58:31 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 s127sm21728828qkd.107.2019.07.25.02.58.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 02:58:30 -0700 (PDT)
Date: Thu, 25 Jul 2019 05:58:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <20190725055523-mutt-send-email-mst@kernel.org>
References: <20190702121106.28374-1-slp@redhat.com>
 <20190702121106.28374-2-slp@redhat.com>
 <aca80a5c-40b9-ca31-2e22-c2bf5005f7e5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aca80a5c-40b9-ca31-2e22-c2bf5005f7e5@oracle.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.196
Subject: Re: [Qemu-devel] [PATCH v3 1/4] hw/virtio: Factorize virtio-mmio
 headers
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
Cc: ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>, maran.wilson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com,
 sgarzare@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 10:46:00AM +0100, Liam Merwick wrote:
> On 02/07/2019 13:11, Sergio Lopez wrote:
> > Put QOM and main struct definition in a separate header file, so it
> > can be accesed from other components.
> 
> typo: accesed -> accessed
> 
> > 
> > This is needed for the microvm machine type implementation.
> > 
> > Signed-off-by: Sergio Lopez <slp@redhat.com>
> 
> One nit below, either way
> 
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> 
> > ---
> >   hw/virtio/virtio-mmio.c | 35 +-----------------------
> >   hw/virtio/virtio-mmio.h | 60 +++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 61 insertions(+), 34 deletions(-)
> >   create mode 100644 hw/virtio/virtio-mmio.h
> > 
> > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> > index 97b7f35496..87c7fe4d8d 100644
> > --- a/hw/virtio/virtio-mmio.c
> > +++ b/hw/virtio/virtio-mmio.c
> > @@ -26,44 +26,11 @@
> >   #include "qemu/host-utils.h"
> >   #include "qemu/module.h"
> >   #include "sysemu/kvm.h"
> > -#include "hw/virtio/virtio-bus.h"
> > +#include "virtio-mmio.h"
> 
> 
> Virtually all the other includes of virtio-xxx.h files in hw/virtio use the
> full path - e.g. "hw/virtio/virtio-mmio.h" - maybe do the same to be
> consistent.

That's for headers under include/.
Local ones are ok with a short name.


> 
> >   #include "qemu/error-report.h"
> >   #include "qemu/log.h"
> >   #include "trace.h"
> > -/* QOM macros */
> > -/* virtio-mmio-bus */
> > -#define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
> > -#define VIRTIO_MMIO_BUS(obj) \
> > -        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
> > -#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
> > -        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
> > -#define VIRTIO_MMIO_BUS_CLASS(klass) \
> > -        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_BUS)
> > -
> > -/* virtio-mmio */
> > -#define TYPE_VIRTIO_MMIO "virtio-mmio"
> > -#define VIRTIO_MMIO(obj) \
> > -        OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
> > -
> > -#define VIRT_MAGIC 0x74726976 /* 'virt' */
> > -#define VIRT_VERSION 1
> > -#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
> > -
> > -typedef struct {
> > -    /* Generic */
> > -    SysBusDevice parent_obj;
> > -    MemoryRegion iomem;
> > -    qemu_irq irq;
> > -    /* Guest accessible state needing migration and reset */
> > -    uint32_t host_features_sel;
> > -    uint32_t guest_features_sel;
> > -    uint32_t guest_page_shift;
> > -    /* virtio-bus */
> > -    VirtioBusState bus;
> > -    bool format_transport_address;
> > -} VirtIOMMIOProxy;
> > -
> >   static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
> >   {
> >       return kvm_eventfds_enabled();
> > diff --git a/hw/virtio/virtio-mmio.h b/hw/virtio/virtio-mmio.h
> > new file mode 100644
> > index 0000000000..2f3973f8c7
> > --- /dev/null
> > +++ b/hw/virtio/virtio-mmio.h
> > @@ -0,0 +1,60 @@
> > +/*
> > + * Virtio MMIO bindings
> > + *
> > + * Copyright (c) 2011 Linaro Limited
> > + *
> > + * Author:
> > + *  Peter Maydell <peter.maydell@linaro.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License; either version 2
> > + * of the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef QEMU_VIRTIO_MMIO_H
> > +#define QEMU_VIRTIO_MMIO_H
> > +
> > +#include "hw/virtio/virtio-bus.h"
> > +
> > +/* QOM macros */
> > +/* virtio-mmio-bus */
> > +#define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
> > +#define VIRTIO_MMIO_BUS(obj) \
> > +        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
> > +#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
> > +        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
> > +#define VIRTIO_MMIO_BUS_CLASS(klass) \
> > +        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_BUS)
> > +
> > +/* virtio-mmio */
> > +#define TYPE_VIRTIO_MMIO "virtio-mmio"
> > +#define VIRTIO_MMIO(obj) \
> > +        OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
> > +
> > +#define VIRT_MAGIC 0x74726976 /* 'virt' */
> > +#define VIRT_VERSION 1
> > +#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
> > +
> > +typedef struct {
> > +    /* Generic */
> > +    SysBusDevice parent_obj;
> > +    MemoryRegion iomem;
> > +    qemu_irq irq;
> > +    /* Guest accessible state needing migration and reset */
> > +    uint32_t host_features_sel;
> > +    uint32_t guest_features_sel;
> > +    uint32_t guest_page_shift;
> > +    /* virtio-bus */
> > +    VirtioBusState bus;
> > +    bool format_transport_address;
> > +} VirtIOMMIOProxy;


I'm repeating myself, but still: if you insist on virtio mmio, please
implement virtio 1 and use that with microvm. We can't keep carrying
legacy interface into every new machine type.

> > +
> > +#endif
> > 

