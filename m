Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7B5C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B012072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQZ9tHJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B012072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGIh4-0006QT-3B
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 04:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharatb.linux@gmail.com>) id 1jGIgA-0005qf-VR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharatb.linux@gmail.com>) id 1jGIg9-0001pY-TP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:43:26 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:35082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bharatb.linux@gmail.com>)
 id 1jGIg9-0001pJ-Nn; Mon, 23 Mar 2020 04:43:25 -0400
Received: by mail-qk1-x744.google.com with SMTP id k13so2673008qki.2;
 Mon, 23 Mar 2020 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7OcFTB2KbnTgJqYJ3I8tRvFdDgVPyjMvLszgu2VeGrs=;
 b=IQZ9tHJIGmF0j+AMfuxYyrsJRjRzWP4F7VDevtEw+vLOSk2iUL2nVOXD3oGV15cqlO
 9bdzu407oRhNnGZlpKb7DFcv6Htf3VtoZAPibDIcd1VqQVp6hlqwzwu6Ox1/Gj+NKTKm
 hJAQPI/BODq264AVYCuBBoXdbO4F+M5qNTcxescM5vXq0ua2RQ/tOawv7nZK/l7v7ebn
 4jdlnrwNFTJUsPJGvvPQvqt6zmAfSS/+U7iXGbc4s6vFrB97t11+vatPvJjay3/buMk9
 vwLL81ognxcRG9QRnld6jlyKR0HZyuksf0BgOFej3V0ckpU/RgjjJ/6pvuoI3H/ZtbN7
 PuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7OcFTB2KbnTgJqYJ3I8tRvFdDgVPyjMvLszgu2VeGrs=;
 b=TeS9AaegVdLZGB/YToF46ipcS3I9lwj/Htm6sw0BOvZzumxAX1o6XBX7CXCpbT+OTz
 nXANucoyt3X49/VBRziNm1wAGog6VadwQydzOX+DjN+EucFS35fhi2AQNpdPdlqaKuTF
 paZB0JvVEx/0pctEcSsQIlqCNzEiJSoAd/5n1g4BkJPHWZO6QvyIGwN5koRx/GDT4VGN
 IwrpkWwE27DWsapnFUyF1RpLjYgYn849jHMU4n9l7/5zidDBg3PRqVGVHXPEXtP/rD5t
 jp1sggSOYMLsQ3KMOmG3yGv83QC1jlzPFcbwTm/m1GC8vXFemErH2Lxlmo2GJtStf7O2
 IzAA==
X-Gm-Message-State: ANhLgQ282do0+UwRAWU8jm5vVBbBEYtRvB3UDgLHGidIxLcVwsJxHTXM
 2gk7jRK81eX31Ou2WIuOUfEDCqkqG7jqXWCg4qA=
X-Google-Smtp-Source: ADFU+vt1MNzfH4JqR3vuuY9tGjRzoz1gPvx9gJzBzRXXM3lqSkr3hZxJf2Fb3fjZOpCBjjLP2r0svYqpcRpksZnZ57s=
X-Received: by 2002:a05:620a:7f8:: with SMTP id
 k24mr19755001qkk.228.1584953004888; 
 Mon, 23 Mar 2020 01:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200318101159.8767-1-bbhushan2@marvell.com>
 <20200318101159.8767-5-bbhushan2@marvell.com>
 <3da60c1b-6897-7ab1-3a67-bec44fa00a54@redhat.com>
 <CAAeCc_nVJXsvEw6iqcs9UEvLJNFyPmHnPnN0VUvzUFtVvjCQsQ@mail.gmail.com>
In-Reply-To: <CAAeCc_nVJXsvEw6iqcs9UEvLJNFyPmHnPnN0VUvzUFtVvjCQsQ@mail.gmail.com>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Mon, 23 Mar 2020 14:13:13 +0530
Message-ID: <CAAeCc_kyXE6SpYpv=yJWKtNaE=0_OvP-uH3gipEeNm7as8e1gw@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] virtio-iommu: set supported page size mask
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: "Zhong, Yang" <yang.zhong@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, drjones@redhat.com, peterx@redhat.com,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Bharat Bhushan <bbhushan2@marvell.com>, linuc.decode@gmail.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric/Jean,

On Wed, Mar 18, 2020 at 8:05 PM Bharat Bhushan <bharatb.linux@gmail.com> wrote:
>
> Hi Eric,
>
> On Wed, Mar 18, 2020 at 4:58 PM Auger Eric <eric.auger@redhat.com> wrote:
> >
> > Hi Bharat,
> >
> > On 3/18/20 11:11 AM, Bharat Bhushan wrote:
> > > Add optional interface to set page size mask.
> > > Currently this is set global configuration and not
> > > per endpoint.
> > >
> > > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > > ---
> > > v7->v8:
> > >  - new patch
> > >
> > >  hw/virtio/virtio-iommu.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> > > index 4cee8083bc..c00a55348d 100644
> > > --- a/hw/virtio/virtio-iommu.c
> > > +++ b/hw/virtio/virtio-iommu.c
> > > @@ -650,6 +650,15 @@ static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
> > >      return (ua > ub) - (ua < ub);
> > >  }
> > >
> > > +static void virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
> > > +                                            uint64_t page_size_mask)
> > > +{
> > > +    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
> > > +    VirtIOIOMMU *s = sdev->viommu;
> > > +
> > > +    s->config.page_size_mask = page_size_mask;
> > The problem is page_size_mask is global to the VIRTIO-IOMMU.
> >
> > - Can't different VFIO containers impose different/inconsistent settings?
> > - VFIO devices can be hotplugged.
>
> This is possible if we different iommu's, which we support. correct?
>
> > So we may start with some default
> > page_size_mask which is latter overriden by a host imposed one. Assume
> > you first launch the VM with a virtio NIC. This uses 64K. Then you
> > hotplug a VFIO device behind a physical IOMMU which only supports 4K
> > pages. Isn't it a valid scenario?
>
> So we need to expose page_size_mask per endpoint?

Just sent Linux RFC patch to use page-size-mask per endpoint.
QEMU changes are also ready, will share soon.

Thanks
-Bharat

>
> Thanks
> -Bharat
>
> >
> > Thanks
> >
> > Eric
> >
> > > +}
> > > +
> > >  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
> > >  {
> > >      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > > @@ -865,6 +874,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
> > >      IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
> > >
> > >      imrc->translate = virtio_iommu_translate;
> > > +    imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
> > >  }
> > >
> > >  static const TypeInfo virtio_iommu_info = {
> > >
> >

