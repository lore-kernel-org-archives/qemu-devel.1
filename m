Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CD4C5ACD7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7C72076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TycGZsNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7C72076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWis-0007Se-7d
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 07:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1jEWi3-0006wJ-NU
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1jEWi1-0005ZX-OP
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:18:03 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1jEWi1-0005RN-Db
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:18:01 -0400
Received: by mail-wr1-x442.google.com with SMTP id b2so23579323wrj.10
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 04:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ikyW55czFnf5P5aS5SiVI/9ZH7l4FRuZVOLjX6KmPZk=;
 b=TycGZsNMzHTj7E90fW44wQKHBpKf5vBexQQvx6KTLI2tIMd/AbNokaSOqMn7RwChar
 qt4ZprOoL/YyYpdycdOr0k/GyUaxnuUA7uFeCMgzrjUakhbZTkuRz6RbzuJypoe/QA36
 GIiiORZVcfRab6R2Hce9C/60WLoZ/sC6HrJ8eYYCDHvUPbYPqaMe0ylNkHKeSZylySBb
 GREuccQr4PTROR9kW2Q65KJqXEtYiUwILPArorTor071Da5KtxSUU7uEjXY0d/sYZSPf
 M6+gg261O2AhWfvFEJ0oQvRPMQi5orQUuc4tm/Y8A6h9IVX27kmkOBiJF5TLeWF2cgeI
 TlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ikyW55czFnf5P5aS5SiVI/9ZH7l4FRuZVOLjX6KmPZk=;
 b=uY/C3SyBxW2lEB0bg5rgd7mG/d8u5IEE+y8WZLXyV0/u668NDpuRWXoyRzNN31Atzy
 SxrpvX0b6L+zgn+v+6A03eBgzYZTiE37kBlhonCsw7MUrjmvHHuYMjo0S499cnP8wt9G
 XOHwICmBWD27EhMnI9oXCYnpkY9KL6wOB5KkQU+WEeGiehYYaSuPe6bvyMT/m2sRv3pm
 gmjPvNtQ87ffQs4RU43WJjYh2G5zESZOM+lA9D4xCjYzMYR8KKqjhW7JeEVupFts/4Pk
 viickEOqb3oG8YB5UTGURbcDSQNV9tEZK5+7dXM7g0mFQ1kMmsTl5o/U3gTRnE7PqC8L
 z1SA==
X-Gm-Message-State: ANhLgQ0RDowVivu60Ne02P1Pgi6Nkl0740cibmRa0hMZAt2EJ7rjq4iG
 nuN2pjDaboFaLClAefcbAY4FOA==
X-Google-Smtp-Source: ADFU+vtDJsrPwIydfezSSDiQQajp28Dh2m/0E7Kr8XUy3G+/2DOIvxM+HiLQpcmafQRfK6kK7WCOyA==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr5359515wrs.179.1584530280113; 
 Wed, 18 Mar 2020 04:18:00 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id d63sm3443039wmd.44.2020.03.18.04.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 04:17:58 -0700 (PDT)
Date: Wed, 18 Mar 2020 12:17:51 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Bharat Bhushan <bharatb.linux@gmail.com>
Subject: Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for attach/detach
Message-ID: <20200318111751.GA1382151@myrica>
References: <CAAeCc_ksAdoNJcFWkoB4YcySAb5Hw7D+kLyHx-Nt0hZJY17AXA@mail.gmail.com>
 <CAAeCc_nnM-DGCyXjFJuk-6L8F+Oetq076SEjeV8kUAGxfJVQTw@mail.gmail.com>
 <cc447790-d1c5-784b-9706-fbcd76f0c94b@redhat.com>
 <CAAeCc_mSobL4oGcK-J3WJJq8BCS6M_oyPTrzJ9bk8yFgsUDBUw@mail.gmail.com>
 <20200316101124.GA304669@myrica>
 <CAAeCc_kJq_TjbZxf3Un5rpwBrNrz-8gdL_SMS-gP_0=rARf0WQ@mail.gmail.com>
 <20200317085304.GA1057687@myrica>
 <CAAeCc_n8_sY0EJODeo_PrOZ22zp8nUMOmGx2tBewz8jLaU30kA@mail.gmail.com>
 <20200317155929.GB1057687@myrica>
 <CAAeCc_k_7Ny1Kf2ZiAAJe2xms2bdK-DqB1S2ro+omxp0EWi28g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <CAAeCc_k_7Ny1Kf2ZiAAJe2xms2bdK-DqB1S2ro+omxp0EWi28g@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, drjones@redhat.com, peterx@redhat.com,
 qemu-devel@nongnu.org, Auger Eric <eric.auger@redhat.com>,
 alex.williamson@redhat.com, qemu-arm@nongnu.org,
 Bharat Bhushan <bbhushan2@marvell.com>, linuc.decode@gmail.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 18, 2020 at 03:47:44PM +0530, Bharat Bhushan wrote:
> Hi Jean,
> 
> On Tue, Mar 17, 2020 at 9:29 PM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > On Tue, Mar 17, 2020 at 02:46:55PM +0530, Bharat Bhushan wrote:
> > > Hi Jean,
> > >
> > > On Tue, Mar 17, 2020 at 2:23 PM Jean-Philippe Brucker
> > > <jean-philippe@linaro.org> wrote:
> > > >
> > > > On Tue, Mar 17, 2020 at 12:40:39PM +0530, Bharat Bhushan wrote:
> > > > > Hi Jean,
> > > > >
> > > > > On Mon, Mar 16, 2020 at 3:41 PM Jean-Philippe Brucker
> > > > > <jean-philippe@linaro.org> wrote:
> > > > > >
> > > > > > Hi Bharat,
> > > > > >
> > > > > > Could you Cc me on your next posting?  Unfortunately I don't have much
> > > > > > hardware for testing this at the moment, but I might be able to help a
> > > > > > little on the review.
> > > > > >
> > > > > > On Mon, Mar 16, 2020 at 02:40:00PM +0530, Bharat Bhushan wrote:
> > > > > > > > >>> First issue is: your guest can use 4K page and your host can use 64KB
> > > > > > > > >>> pages. In that case VFIO_DMA_MAP will fail with -EINVAL. We must devise
> > > > > > > > >>> a way to pass the host settings to the VIRTIO-IOMMU device.
> > > > > > > > >>>
> > > > > > > > >>> Even with 64KB pages, it did not work for me. I have obviously not the
> > > > > > > > >>> storm of VFIO_DMA_MAP failures but I have some, most probably due to
> > > > > > > > >>> some wrong notifications somewhere. I will try to investigate on my side.
> > > > > > > > >>>
> > > > > > > > >>> Did you test with VFIO on your side?
> > > > > > > > >>
> > > > > > > > >> I did not tried with different page sizes, only tested with 4K page size.
> > > > > > > > >>
> > > > > > > > >> Yes it works, I tested with two n/w device assigned to VM, both interfaces works
> > > > > > > > >>
> > > > > > > > >> First I will try with 64k page size.
> > > > > > > > >
> > > > > > > > > 64K page size does not work for me as well,
> > > > > > > > >
> > > > > > > > > I think we are not passing correct page_size_mask here
> > > > > > > > > (config.page_size_mask is set to TARGET_PAGE_MASK ( which is
> > > > > > > > > 0xfffffffffffff000))
> > > > > > > > I guess you mean with guest using 4K and host using 64K.
> > > > > > > > >
> > > > > > > > > We need to set this correctly as per host page size, correct?
> > > > > > > > Yes that's correct. We need to put in place a control path to retrieve
> > > > > > > > the page settings on host through VFIO to inform the virtio-iommu device.
> > > > > > > >
> > > > > > > > Besides this issue, did you try with 64kB on host and guest?
> > > > > > >
> > > > > > > I tried Followings
> > > > > > >   - 4k host and 4k guest  - it works with v7 version
> > > > > > >   - 64k host and 64k guest - it does not work with v7
> > > > > > >     hard-coded config.page_size_mask to 0xffffffffffff0000 and it works
> > > > > >
> > > > > > You might get this from the iova_pgsize bitmap returned by
> > > > > > VFIO_IOMMU_GET_INFO. The virtio config.page_size_mask is global so there
> > > > > > is the usual problem of aggregating consistent properties, but I'm
> > > > > > guessing using the host page size as a granule here is safe enough.
> > > > > >
> > > > > > If it is a problem, we can add a PROBE property for page size mask,
> > > > > > allowing to define per-endpoint page masks. I have kernel patches
> > > > > > somewhere to do just that.
> > > > >
> > > > > I do not see we need page size mask per endpoint.
> > > > >
> > > > > While I am trying to understand what "page-size-mask" guest will work with
> > > > >
> > > > > - 4K page size host and 4k page size guest
> > > > >   config.page_size_mask = 0xffffffffffff000 will work
> > > > >
> > > > > - 64K page size host and 64k page size guest
> > > > >   config.page_size_mask = 0xfffffffffff0000 will work
> > > > >
> > > > > - 64K page size host and 4k page size guest
> > > > >    1) config.page_size_mask = 0xffffffffffff000 will also not work as
> > > > > VFIO in host expect iova and size to be aligned to 64k (PAGE_SIZE in
> > > > > host)
> > > > >    2) config.page_size_mask = 0xfffffffffff0000 will not work, iova
> > > > > initialization (in guest) expect minimum page-size supported by h/w to
> > > > > be equal to 4k (PAGE_SIZE in guest)
> > > > >        Should we look to relax this in iova allocation code?
> > > >
> > > > Oh right, that's not great. Maybe the BUG_ON() can be removed, I'll ask on
> > > > the list.
> > >
> > > yes, the BUG_ON in iova_init.
> > > I tried with removing same and it worked, but not analyzed side effects.
> >
> > It might break the assumption from device drivers that mapping a page is
> > safe. For example they call alloc_page() followed by dma_map_page(). In
> > our situation dma-iommu.c will oblige and create one 64k mapping to one 4k
> > physical page. As a result the endpoint can access the neighbouring 60k of
> > memory.
> >
> > This isn't too terrible. After all, even when the page sizes match, device
> > drivers can call dma_map_single() on sub-page buffers, which will also let
> > the endpoint access a whole page. The solution, if you don't trust the
> > endpoint, is to use bounce buffers.
> >
> > But I suspect it's not as simple as removing the BUG_ON(), we'll need to
> > go over dma-iommu.c first. And it seems like assigning endpoints to guest
> > userspace won't work either in this config. In vfio_dma_do_map():
> >
> >         mask = ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) - 1;
> >
> >         WARN_ON(mask & PAGE_MASK);
> 
> Yes, Agree
> 
> >
> > If I read this correctly the WARN will trigger in a 4k guest under 64k
> > host, right?  So maybe we can just say that this config isn't supported,
> > unless it's an important use-case for virtio-iommu?
> 
> I sent v8 version of patch and with that guest and host with same page
> size should work.
> While i have not yet added analyzed how to mark 4k guest and 64k host
> as un-supported configuration, will analyze and send patch.

I don't think there is anything to do for QEMU, it's Linux that doesn't
support the configuration. We could add something like the attached patch,
in the virtio-iommu driver, to abort more gracefully than with a BUG_ON().

Thanks,
Jean

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-iommu-virtio-Reject-IOMMU-page-granule-larger-than-P.patch"

From 1fa08800c94f7ad6720b7e6fe26a65ed3d6ce715 Mon Sep 17 00:00:00 2001
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Wed, 18 Mar 2020 11:59:19 +0100
Subject: [PATCH] iommu/virtio: Reject IOMMU page granule larger than PAGE_SIZE

We don't currently support IOMMUs with a page granule larger than the
system page size. Currently the IOVA allocator has a BUG_ON() in this
case, and VFIO has a WARN_ON().

It might be possible to remove these obstacles if necessary. If the host
uses 64kB pages and the guest uses 4kB, then a device driver calling
alloc_page() followed by dma_map_page() will create a 64kB mapping for a
4kB physical page, allowing the endpoint to access the neighbouring 60kB
of memory. This problem could be worked around with bounce buffers.

For the moment, rather than triggering the IOVA BUG_ON() on mismatched
page sizes, abort the virtio-iommu probe with an error message.

Reported-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 6d4e3c2a2ddb..80d5d8f621ab 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -998,6 +998,7 @@ static int viommu_probe(struct virtio_device *vdev)
 	struct device *parent_dev = vdev->dev.parent;
 	struct viommu_dev *viommu = NULL;
 	struct device *dev = &vdev->dev;
+	unsigned long viommu_page_size;
 	u64 input_start = 0;
 	u64 input_end = -1UL;
 	int ret;
@@ -1028,6 +1029,14 @@ static int viommu_probe(struct virtio_device *vdev)
 		goto err_free_vqs;
 	}
 
+	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
+	if (viommu_page_size > PAGE_SIZE) {
+		dev_err(dev, "granule 0x%lx larger than system page size 0x%lx\n",
+			viommu_page_size, PAGE_SIZE);
+		ret = -EINVAL;
+		goto err_free_vqs;
+	}
+
 	viommu->map_flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
 	viommu->last_domain = ~0U;
 
-- 
2.25.1


--tThc/1wpZn/ma/RB--

