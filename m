Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818C3C33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD9F2070E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5GJFkgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD9F2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioyvq-0006V1-CT
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 19:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1ioyut-00055J-5L
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1ioyuq-00059I-0G
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:09:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53044
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1ioyup-00058C-KR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578442178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvsR3l042aE6tbJjyXLqRgr/i4kZNDwa9CXx/uDAqCA=;
 b=F5GJFkgp8/3A3LJal6IyTBAmPj6RvJaHhTLOaNdrdmLykAUaFhpS/8UGdFG+11lovVvEdg
 xkp9ZCpb8xSbymulGrflwp6SsDTLVGIrpAWKMZ/vMuQspReXyH8OZ4JG9Rf91gg2G4AvmO
 S4/aL+M5ZjDL7iHPMPSyPWRbVmNUJuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-P76lbGjzNSS3NgVr5OM5pQ-1; Tue, 07 Jan 2020 19:09:34 -0500
X-MC-Unique: P76lbGjzNSS3NgVr5OM5pQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12718107ACC4;
 Wed,  8 Jan 2020 00:09:32 +0000 (UTC)
Received: from w520.home (ovpn-116-26.phx2.redhat.com [10.3.116.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B67B160CD3;
 Wed,  8 Jan 2020 00:09:29 +0000 (UTC)
Date: Tue, 7 Jan 2020 17:09:29 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v11 Kernel 6/6] vfio: Selective dirty page tracking if
 IOMMU backed device pins pages
Message-ID: <20200107170929.74c9c92e@w520.home>
In-Reply-To: <66512c1f-aedc-a718-8594-b52d266f4b60@nvidia.com>
References: <1576602651-15430-1-git-send-email-kwankhede@nvidia.com>
 <1576602651-15430-7-git-send-email-kwankhede@nvidia.com>
 <20191217171219.7cc3fc1d@x1.home>
 <66512c1f-aedc-a718-8594-b52d266f4b60@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jan 2020 02:15:01 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 12/18/2019 5:42 AM, Alex Williamson wrote:
> > On Tue, 17 Dec 2019 22:40:51 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> 
> <snip>
> 
> > 
> > This will fail when there are devices within the IOMMU group that are
> > not represented as vfio_devices.  My original suggestion was:
> > 
> > On Thu, 14 Nov 2019 14:06:25 -0700
> > Alex Williamson <alex.williamson@redhat.com> wrote:  
> >> I think it does so by pinning pages.  Is it acceptable that if the
> >> vendor driver pins any pages, then from that point forward we consider
> >> the IOMMU group dirty page scope to be limited to pinned pages?  There
> >> are complications around non-singleton IOMMU groups, but I think we're
> >> already leaning towards that being a non-worthwhile problem to solve.
> >> So if we require that only singleton IOMMU groups can pin pages and we  
> > 
> > We could tag vfio_groups as singleton at vfio_add_group_dev() time with
> > an iommu_group_for_each_dev() walk so that we can cache the value on
> > the struct vfio_group.   
> 
> I don't think iommu_group_for_each_dev() is required. Checking 
> group->device_list in vfio_add_group_dev() if there are more than one 
> device should work, right?
> 
>          list_for_each_entry(vdev, &group->device_list, group_next) {
>                  if (group->is_singleton) {
>                          group->is_singleton = false;
>                          break;
>                  } else {
>                          group->is_singleton = true;
>                  }
>          }

Hmm, I think you're taking a different approach to this than I was
thinking.  Re-reading my previous comments, the fact that both vfio.c
and vfio_iommu_type1.c each have their own private struct vfio_group
makes things rather unclear.  I was intending to use the struct
iommu_group as the object vfio.c provides to type1.c to associate the
pinning.  This would require that not only the vfio view of devices in
the group to be singleton, but also the actual iommu group to be
singleton.  Otherwise the set of devices vfio.c has in the group might
only be a subset of the group.  Maybe a merger of the approaches is
easier though.

Tracking whether the vfio.c view of a group is singleton is even easier
than above, we could simply add a device_count field to vfio_group,
increment it in vfio_group_create_device() and decrement it in
vfio_device_release().  vfio_pin_pages() could return error if
device_count is not 1.  We could still add the iommu_group pointer to
the type1 pin_pages callback, but perhaps type1 simply assumes that the
group is singleton when pin pages is called and it's vfio.c's
responsibility to maintain that group as singleton once pages have been
pinned.  vfio.c would therefore also need to set a field on the
vfio_group if pages have been pinned such that vfio_add_group_dev()
could return error if a new device attempts to join the group.  We'd
need to make sure that field is cleared when the group is released from
use and pay attention to races that might occur between adding devices
to a group and pinning pages.

> > vfio_group_nb_add_dev() could update this if
> > the IOMMU group composition changes.   
> 
> I don't see vfio_group_nb_add_dev() calls vfio_add_group_dev() (?)
> If checking is_singleton is taken care in vfio_group_nb_add_dev(), which 
> is the only place where vfio_group is allocated, that should work, I think.

This was relative to maintaining that the iommu group itself is
singleton, not just the vfio view of the group.  If we use the latter
as our basis, then you're right, we should need this, but vfio.c would
need to enforce that the group remains singleton if it has pinned
pages.  Does that make sense?  Thanks,

Alex

> > vfio_pin_pages() could return
> > -EINVAL if (!group->is_singleton).
> >   
> >> pass the IOMMU group as a parameter to
> >> vfio_iommu_driver_ops.pin_pages(), then the type1 backend can set a
> >> flag on its local vfio_group struct to indicate dirty page scope is
> >> limited to pinned pages.  
> > 
> > ie. vfio_iommu_type1_unpin_pages() calls find_iommu_group() on each
> > domain in domain_list and the external_domain using the struct
> > iommu_group pointer provided by vfio-core.  We set a new attribute on
> > the vfio_group to indicate that vfio_group has (at some point) pinned
> > pages.
> >   
> >>   We might want to keep a flag on the
> >> vfio_iommu struct to indicate if all of the vfio_groups for each
> >> vfio_domain in the vfio_iommu.domain_list dirty page scope limited to
> >> pinned pages as an optimization to avoid walking lists too often.  Then
> >> we could test if vfio_iommu.domain_list is not empty and this new flag
> >> does not limit the dirty page scope, then everything within each
> >> vfio_dma is considered dirty.  
> > 
> > So at the point where we change vfio_group.has_pinned_pages from false
> > to true, or a group is added or removed, we walk all the groups in the
> > vfio_iommu and if they all have has_pinned_pages set, we can set a
> > vfio_iommu.pinned_page_dirty_scope flag to true.  If that flag is
> > already true on page pinning, we can skip the lookup.
> > 
> > I still like this approach better, it doesn't require a callback from
> > type1 to vfio-core and it doesn't require a heavy weight walking for
> > group devices and vfio data structures every time we fill a bitmap.
> > Did you run into issues trying to implement this approach?   
> 
> Thanks for elaborative steps.
> This works. Changing this last commit.
> 
> Thanks,
> Kirti
> 


