Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1A8C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2547F20776
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4LT7Hcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2547F20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEZti-0002X0-Am
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharatb.linux@gmail.com>) id 1jEZn2-00085M-AJ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharatb.linux@gmail.com>) id 1jEZn0-0005xE-Rw
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:35:24 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:34711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bharatb.linux@gmail.com>)
 id 1jEZn0-0005vD-KZ; Wed, 18 Mar 2020 10:35:22 -0400
Received: by mail-qk1-x741.google.com with SMTP id f3so39032980qkh.1;
 Wed, 18 Mar 2020 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1zY6kt8FtxFx7OpmNp1j1dQSSVOqMnX77gpHTli89F0=;
 b=i4LT7HcuPZVbM06C35VOsyxaF0plNxj18vgib2KXessROmC4E3r2oKZKy3xDedMksu
 LOFXs3Y1i2cl0g9n+rYMjDY1mbYOFXUG40pVhsj2kFstfmUoXzCtfLDJ4I75PgJIPSHI
 MHIxIm1YlTc77NvewiUlOEeJGFSV3VEMT20zqe7ucH3CMgVGc4HfEZFx3JE0TmUVUovq
 itiFEUPMloJEn9ArUKIzkugT8u6VXhImHfoGLYIb39845Ifo8GIEpdeSVJehEJ8EMr0N
 czObGYGSnDp6F3TtN4pAUaxxuiR6Evmc7GShDQeyD7qBavzOox0AdHyv7V+Ioieepj+U
 HxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1zY6kt8FtxFx7OpmNp1j1dQSSVOqMnX77gpHTli89F0=;
 b=rNzU7O3uxiAaw8l5Gty3ztJu2xLK48zwHIUo4QIpJAIrY+6/qC4k3+NBvWJGLC/g74
 fM5amvFKvkzD7h0BMnbnai1Zs1E8C4rKf7My12zqh/aL9C+px/LOG3vvIvVP/glO9JbW
 28lZcJyx5Bxzj8Qh+eY3l3W3NnlO6Fl3krV9+MIPaLXv7RJbjA6DIoRB33Kmbq9Li+to
 egQEOAI1fi03AKFOy2V8y70pcRplHN8kW1BX5Fr5mJ1mopdrSBp/FZ397iwSVw9yKAzP
 N0k3tWGovpVgzbKfr56bosHkGMl4Wg/t4ELklfVmuwAJMebKzrYPKmMBzSkgEM9WwNyK
 yEzA==
X-Gm-Message-State: ANhLgQ0OhoziZS1xMtYLQRZKDEm2ptiSLbWWoThpAJWUf66W0CNeI19e
 MBRm37sCvsk9GA6A3Uokmzrl8HhTGjSPo1vOXMk=
X-Google-Smtp-Source: ADFU+vusiyGPAGQOstrIA7xDWI9EuMeODcv7g4YecrEeKHfiLAeLUCdzgSVn1AaPaeXglI55q2uOw4WG9Wvgj6HDXDo=
X-Received: by 2002:a05:620a:10ae:: with SMTP id
 h14mr4305427qkk.170.1584542121798; 
 Wed, 18 Mar 2020 07:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200318101159.8767-1-bbhushan2@marvell.com>
 <20200318101159.8767-5-bbhushan2@marvell.com>
 <3da60c1b-6897-7ab1-3a67-bec44fa00a54@redhat.com>
In-Reply-To: <3da60c1b-6897-7ab1-3a67-bec44fa00a54@redhat.com>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Wed, 18 Mar 2020 20:05:10 +0530
Message-ID: <CAAeCc_nVJXsvEw6iqcs9UEvLJNFyPmHnPnN0VUvzUFtVvjCQsQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] virtio-iommu: set supported page size mask
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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

Hi Eric,

On Wed, Mar 18, 2020 at 4:58 PM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Bharat,
>
> On 3/18/20 11:11 AM, Bharat Bhushan wrote:
> > Add optional interface to set page size mask.
> > Currently this is set global configuration and not
> > per endpoint.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> > v7->v8:
> >  - new patch
> >
> >  hw/virtio/virtio-iommu.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> > index 4cee8083bc..c00a55348d 100644
> > --- a/hw/virtio/virtio-iommu.c
> > +++ b/hw/virtio/virtio-iommu.c
> > @@ -650,6 +650,15 @@ static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
> >      return (ua > ub) - (ua < ub);
> >  }
> >
> > +static void virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
> > +                                            uint64_t page_size_mask)
> > +{
> > +    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
> > +    VirtIOIOMMU *s = sdev->viommu;
> > +
> > +    s->config.page_size_mask = page_size_mask;
> The problem is page_size_mask is global to the VIRTIO-IOMMU.
>
> - Can't different VFIO containers impose different/inconsistent settings?
> - VFIO devices can be hotplugged.

This is possible if we different iommu's, which we support. correct?

> So we may start with some default
> page_size_mask which is latter overriden by a host imposed one. Assume
> you first launch the VM with a virtio NIC. This uses 64K. Then you
> hotplug a VFIO device behind a physical IOMMU which only supports 4K
> pages. Isn't it a valid scenario?

So we need to expose page_size_mask per endpoint?

Thanks
-Bharat

>
> Thanks
>
> Eric
>
> > +}
> > +
> >  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
> >  {
> >      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > @@ -865,6 +874,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
> >      IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
> >
> >      imrc->translate = virtio_iommu_translate;
> > +    imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
> >  }
> >
> >  static const TypeInfo virtio_iommu_info = {
> >
>

