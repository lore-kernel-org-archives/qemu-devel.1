Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398ADC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D2E20777
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ci7W8HJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D2E20777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFNXZ-00062K-70
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 15:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jFNWk-0005DB-5D
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jFNWi-0003HC-Pm
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:41:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24597)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jFNWi-0003EP-KC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584733311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJ40QxRG0OlYWuzwDUDKkNSHifuUoZHuj8C6hMwyzYc=;
 b=Ci7W8HJ9FFJtUPKPqhRAHrYbIgaG1nxLiFZINT8BUCMuRywqw40p1zbZ3Nxv9O/HTZgNAW
 RlLiaIYGZEVNHiF8tIRkeLRNnqYdsPpExL6c5dW8boV7FCGy66wb3l0JWHPuY+yZ8uch4n
 dYRSFuw0zAadrl0LJ+Ypd5eAnFBYdQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-jzy-x6bGOB2sQYPzmScm1A-1; Fri, 20 Mar 2020 15:41:47 -0400
X-MC-Unique: jzy-x6bGOB2sQYPzmScm1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6223E477;
 Fri, 20 Mar 2020 19:41:45 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B2125C219;
 Fri, 20 Mar 2020 19:41:43 +0000 (UTC)
Date: Fri, 20 Mar 2020 13:41:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH v14 Kernel 7/7] vfio: Selective dirty page tracking if
 IOMMU backed device pins pages
Message-ID: <20200320134142.3abe56ea@w520.home>
In-Reply-To: <20200319062433.GH4641@joy-OptiPlex-7040>
References: <1584560474-19946-1-git-send-email-kwankhede@nvidia.com>
 <1584560474-19946-8-git-send-email-kwankhede@nvidia.com>
 <20200319062433.GH4641@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Mar 2020 02:24:33 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:
> On Thu, Mar 19, 2020 at 03:41:14AM +0800, Kirti Wankhede wrote:
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index 912629320719..deec09f4b0f6 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -72,6 +72,7 @@ struct vfio_iommu {
> >  	bool			v2;
> >  	bool			nesting;
> >  	bool			dirty_page_tracking;
> > +	bool			pinned_page_dirty_scope;
> >  };
> >  
> >  struct vfio_domain {
> > @@ -99,6 +100,7 @@ struct vfio_group {
> >  	struct iommu_group	*iommu_group;
> >  	struct list_head	next;
> >  	bool			mdev_group;	/* An mdev group */
> > +	bool			pinned_page_dirty_scope;
> >  };
> >  
> >  struct vfio_iova {
> > @@ -132,6 +134,10 @@ struct vfio_regions {
> >  static int put_pfn(unsigned long pfn, int prot);
> >  static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu);
> >  
> > +static struct vfio_group *vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
> > +					       struct iommu_group *iommu_group);
> > +
> > +static void update_pinned_page_dirty_scope(struct vfio_iommu *iommu);
> >  /*
> >   * This code handles mapping and unmapping of user data buffers
> >   * into DMA'ble space using the IOMMU
> > @@ -556,11 +562,13 @@ static int vfio_unpin_page_external(struct vfio_dma *dma, dma_addr_t iova,
> >  }
> >  
> >  static int vfio_iommu_type1_pin_pages(void *iommu_data,
> > +				      struct iommu_group *iommu_group,
> >  				      unsigned long *user_pfn,
> >  				      int npage, int prot,
> >  				      unsigned long *phys_pfn)
> >  {
> >  	struct vfio_iommu *iommu = iommu_data;
> > +	struct vfio_group *group;
> >  	int i, j, ret;
> >  	unsigned long remote_vaddr;
> >  	struct vfio_dma *dma;
> > @@ -630,8 +638,14 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
> >  				   (vpfn->iova - dma->iova) >> pgshift, 1);
> >  		}
> >  	}  
> 
> Could you provide an interface lightweight than vfio_pin_pages for pass-through
> devices? e.g. vfio_mark_iova_dirty()
> 
> Or at least allowing phys_pfn to be empty for pass-through devices.
> 
> This is really inefficient:
> bitmap_set(dma->bitmap, (vpfn->iova - dma->iova) / pgsize, 1));
> i.e.
> in order to mark an iova dirty, it has to go through iova ---> pfn --> iova
> while acquiring pfn is not necessary for pass-through devices.

I think this would be possible, but I don't think it should be gating
to this series.  We don't have such consumers yet.  Thanks,

Alex


