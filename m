Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCEFC2D0D1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7ABD24679
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMVp1uj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7ABD24679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii10Q-0007EJ-Lo
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1ii0yR-0005J2-4o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1ii0yO-00023b-4k
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:56:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42259
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1ii0yN-0001ui-IC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576781790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50ypp4twcT7h3+0B/Lg/fNtkFrCt7aoByDDwvMuuMiQ=;
 b=UMVp1uj/8lekcWC7bYg83gA1r3mrlTp4DcKXsdgNKKi+8y/74TYDlqxdrhdNq/J9m2Akf+
 ceyUGY4n59N/ERy+49oQW0wYW1aVazhgbREkQzjDO0hR/fHDRQo06eiOTd8g1XXbWG6Lxl
 CGHybQegGPtcSmSHcu0de4IkICr/ftE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-w_dsgI9dOZK8MOwxNR9XOA-1; Thu, 19 Dec 2019 13:56:26 -0500
X-MC-Unique: w_dsgI9dOZK8MOwxNR9XOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04ABA107ACC9;
 Thu, 19 Dec 2019 18:56:24 +0000 (UTC)
Received: from x1.home (ovpn-116-26.phx2.redhat.com [10.3.116.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D127100EBAA;
 Thu, 19 Dec 2019 18:56:22 +0000 (UTC)
Date: Thu, 19 Dec 2019 11:56:21 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v10 Kernel 4/5] vfio iommu: Implementation of ioctl to
 for dirty pages tracking.
Message-ID: <20191219115621.67e2fe7c@x1.home>
In-Reply-To: <6667e0b4-f3da-6283-3f27-c1cba3d13117@nvidia.com>
References: <1576527700-21805-1-git-send-email-kwankhede@nvidia.com>
 <1576527700-21805-5-git-send-email-kwankhede@nvidia.com>
 <20191217051513.GE21868@joy-OptiPlex-7040>
 <17ac4c3b-5f7c-0e52-2c2b-d847d4d4e3b1@nvidia.com>
 <20191218143902.3c9b06df@x1.home>
 <6667e0b4-f3da-6283-3f27-c1cba3d13117@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 Yan Zhao <yan.y.zhao@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Dec 2019 00:12:30 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 12/19/2019 3:09 AM, Alex Williamson wrote:
> > On Tue, 17 Dec 2019 14:54:14 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> On 12/17/2019 10:45 AM, Yan Zhao wrote:  
> >>> On Tue, Dec 17, 2019 at 04:21:39AM +0800, Kirti Wankhede wrote:  
> >>>> +		} else if (range.flags &
> >>>> +				 VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP) {
> >>>> +			uint64_t iommu_pgmask;
> >>>> +			unsigned long pgshift = __ffs(range.pgsize);
> >>>> +			unsigned long *bitmap;
> >>>> +			long bsize;
> >>>> +
> >>>> +			iommu_pgmask =
> >>>> +			 ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) - 1;
> >>>> +
> >>>> +			if (((range.pgsize - 1) & iommu_pgmask) !=
> >>>> +			    (range.pgsize - 1))
> >>>> +				return -EINVAL;
> >>>> +
> >>>> +			if (range.iova & iommu_pgmask)
> >>>> +				return -EINVAL;
> >>>> +			if (!range.size || range.size > SIZE_MAX)
> >>>> +				return -EINVAL;
> >>>> +			if (range.iova + range.size < range.iova)
> >>>> +				return -EINVAL;
> >>>> +
> >>>> +			bsize = verify_bitmap_size(range.size >> pgshift,
> >>>> +						   range.bitmap_size);
> >>>> +			if (bsize)
> >>>> +				return ret;
> >>>> +
> >>>> +			bitmap = kmalloc(bsize, GFP_KERNEL);
> >>>> +			if (!bitmap)
> >>>> +				return -ENOMEM;
> >>>> +
> >>>> +			ret = copy_from_user(bitmap,
> >>>> +			     (void __user *)range.bitmap, bsize) ? -EFAULT : 0;
> >>>> +			if (ret)
> >>>> +				goto bitmap_exit;
> >>>> +
> >>>> +			iommu->dirty_page_tracking = false;  
> >>> why iommu->dirty_page_tracking is false here?
> >>> suppose this ioctl can be called several times.
> >>>      
> >>
> >> This ioctl can be called several times, but once this ioctl is called
> >> that means vCPUs are stopped and VFIO devices are stopped (i.e. in
> >> stop-and-copy phase) and dirty pages bitmap are being queried by user.  
> > 
> > Do not assume how userspace works or its intent.  If dirty tracking is
> > on, it should remain on until the user turns it off.  We cannot assume
> > userspace uses a one-shot approach.  Thanks,
> >   
> 
> Dirty tracking should be on until user turns it off or user reads 
> bitmap, right? This ioctl is used to read bitmap.

No, dirty bitmap tracking is on until the user turns it off, period.
Retrieving the bitmap is probably only looking at a portion of the
container address space at a time, anything else would place
impractical requirements on the user allocated bitmap.  We also need to
support a usage model where the user is making successive calls, where
each should report pages dirtied since the previous call.  If the user
is required to re-enable tracking, there's an irreconcilable gap
between the call to retrieve the dirty bitmap and their opportunity to
re-enable dirty tracking.  It's fundamentally broken to automatically
disable tracking on read.  Thanks,

Alex


