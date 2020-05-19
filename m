Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DDFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5D6207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DL3pNcD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5D6207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4aT-0000C4-A7
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jb4ZF-0006zM-2p
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:54:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jb4ZE-0000yO-0r
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589903646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvazmUOdOf/bNdnHfUgyTxq+WDNdBaoeA71aXx2iyCY=;
 b=DL3pNcD/FPz31sI1bCZ8HAK2sdce+fSVAfQc0aTWAzXrvf8S30diIm11cZ9BpHmcmnDV69
 OtAXvQZmWA+T6WnIiIulaBRHcedT1maQyYr0JUbvAIevkT4+b4szXua42YtG5maW67GW32
 WCrFdlR8D+1PlmsD3Az58tLq8h4MeZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-GOniji0fNR6uq00iBaf5Rw-1; Tue, 19 May 2020 11:54:02 -0400
X-MC-Unique: GOniji0fNR6uq00iBaf5Rw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C4B418FE860;
 Tue, 19 May 2020 15:53:59 +0000 (UTC)
Received: from x1.home (ovpn-112-50.phx2.redhat.com [10.3.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A075100164D;
 Tue, 19 May 2020 15:53:57 +0000 (UTC)
Date: Tue, 19 May 2020 09:53:56 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH Kernel v20 4/8] vfio iommu: Add ioctl definition for
 dirty pages tracking
Message-ID: <20200519095356.5d1f6ffa@x1.home>
In-Reply-To: <20200519173507.3cd131dd.cohuck@redhat.com>
References: <1589488667-9683-1-git-send-email-kwankhede@nvidia.com>
 <1589488667-9683-5-git-send-email-kwankhede@nvidia.com>
 <20200515125916.78723321.cohuck@redhat.com>
 <bdb9c1d3-e673-5bb1-aced-f7443f4dfe58@nvidia.com>
 <20200519173507.3cd131dd.cohuck@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, cjia@nvidia.com,
 kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 May 2020 17:35:07 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 15 May 2020 23:05:24 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> > On 5/15/2020 4:29 PM, Cornelia Huck wrote:  
> > > On Fri, 15 May 2020 02:07:43 +0530
> > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > >     
> > >> IOMMU container maintains a list of all pages pinned by vfio_pin_pages API.
> > >> All pages pinned by vendor driver through this API should be considered as
> > >> dirty during migration. When container consists of IOMMU capable device and
> > >> all pages are pinned and mapped, then all pages are marked dirty.
> > >> Added support to start/stop dirtied pages tracking and to get bitmap of all
> > >> dirtied pages for requested IO virtual address range.
> > >>
> > >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> > >> ---
> > >>   include/uapi/linux/vfio.h | 55 +++++++++++++++++++++++++++++++++++++++++++++++
> > >>   1 file changed, 55 insertions(+)  
> 
> (...)
> 
> > >> + * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP flag set,
> > >> + * IOCTL returns dirty pages bitmap for IOMMU container during migration for
> > >> + * given IOVA range.    
> > > 
> > > "Calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_GET_BITMAP returns the
> > > dirty pages bitmap for the IOMMU container for a given IOVA range." ?
> > > 
> > > Q: How does this interact with the two other operations? I imagine
> > > getting an empty bitmap before _START     
> > 
> > No, if dirty page tracking is not started, get_bitmap IOCTL will fail 
> > with -EINVAL.
> >   
> > > and a bitmap-in-progress between
> > > _START and _STOP. > After _STOP, will subsequent calls always give the
> > > same bitmap?
> > >    
> > 
> > No, return -EINVAL.  
> 
> Maybe add
> 
> "If the IOCTL has not yet been called with
> VFIO_IOMMU_DIRTY_PAGES_FLAG_START, or if it has been called with
> VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP, calling it with
> VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP will return -EINVAL." ?

Let's not specify ourselves into a corner, I think we can simply say
that the dirty bitmap is only available while dirty logging is enabled.
We certainly don't need to specify specific errno values that'll trip
us up later.

> > >> User must provide data[] as the structure
> > >> + * vfio_iommu_type1_dirty_bitmap_get through which user provides IOVA range and
> > >> + * pgsize.    
> > > 
> > > "The user must specify the IOVA range and the pgsize through the
> > > vfio_iommu_type1_dirty_bitmap_get structure in the data[] portion."
> > > 
> > > ?
> > >     
> > >> This interface supports to get bitmap of smallest supported pgsize
> > >> + * only and can be modified in future to get bitmap of specified pgsize.    
> > > 
> > > That's a current restriction? How can the user find out whether it has
> > > been lifted (or, more generally, find out which pgsize values are
> > > supported)?    
> > 
> > Migration capability is added to IOMMU info chain. That gives supported 
> > pgsize bitmap by IOMMU driver.  
> 
> Add that info?
> 
> "The supported pgsize values for this interface are reported via the
> migration capability in the IOMMU info chain."
> 
> >   
> > >     
> > >> + * User must allocate memory for bitmap, zero the bitmap memory  and set size
> > >> + * of allocated memory in bitmap.size field.    
> > > 
> > > "The user must provide a zeroed memory area for the bitmap memory and
> > > specify its size in bitmap.size."
> > > 
> > > ?
> > >     
> > >> One bit is used to represent one
> > >> + * page consecutively starting from iova offset. User should provide page size
> > >> + * in bitmap.pgsize field.    
> > > 
> > > s/User/The user/
> > > 
> > > Is that the 'pgsize' the comment above talks about?
> > >     
> > 
> > By specifying pgsize here user can ask for bitmap of specific pgsize.  
> 
> "The user should provide the page size for the bitmap in the
> bitmap.pgsize field." ?
> 
> >   
> > >> Bit set in bitmap indicates page at that offset from
> > >> + * iova is dirty.    
> > > 
> > > "A bit set in the bitmap indicates that the page at that offset from
> > > iova is dirty." ?
> > >     
> > >> Caller must set argsz including size of structure
> > >> + * vfio_iommu_type1_dirty_bitmap_get.    
> > > 
> > > s/Caller/The caller/
> > > 
> > > Does argz also include the size of the bitmap?    
> > 
> > No.  
> 
> "The caller must set argsz to a value including the size of stuct
> vfio_io_type1_dirty_bitmap_get, but excluding the size of the actual
> bitmap." ?

Yes, it wouldn't make sense for argsz to include the size of the bitmap
itself, that's accessed independently via a user provided pointer and
we have a separate size field for that.  Thanks,

Alex


