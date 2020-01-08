Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A63C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 23:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C515A20692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 23:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9sRfK1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C515A20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50267 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipKR1-0002Cp-Co
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 18:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1ipKPc-0000dT-3U
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 18:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1ipKIl-0005u9-6E
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 17:59:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60675
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1ipKIk-0005po-70
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 17:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578524385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OqLbt1MJpD/2l5pEoZdMNVoLWGTl0KHDQB1cd3hrBlI=;
 b=b9sRfK1t9UWQfhqhQc4u6aSJh9xUIHanbbvLwrm7ttCxMp19aIQtiLXGKlqylGVDpkW38K
 s8WqcLuMpb40A1TdbDZY7BW/m9Hbf3FxHcyu+g+EvdDYz/niovykI+006AuJ3jVPDMd8gW
 60Fgvfm62ayN/eT++/xnmZIqmNCc4II=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-5lA3Di29O3u2mxZAUm_foQ-1; Wed, 08 Jan 2020 17:59:41 -0500
X-MC-Unique: 5lA3Di29O3u2mxZAUm_foQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28159107ACC4;
 Wed,  8 Jan 2020 22:59:39 +0000 (UTC)
Received: from w520.home (ovpn-118-62.phx2.redhat.com [10.3.118.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 311095C241;
 Wed,  8 Jan 2020 22:59:37 +0000 (UTC)
Date: Wed, 8 Jan 2020 15:59:36 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v11 Kernel 6/6] vfio: Selective dirty page tracking if
 IOMMU backed device pins pages
Message-ID: <20200108155936.5e725eaa@w520.home>
In-Reply-To: <17069da7-279b-872f-db15-d9995cf46285@nvidia.com>
References: <1576602651-15430-1-git-send-email-kwankhede@nvidia.com>
 <1576602651-15430-7-git-send-email-kwankhede@nvidia.com>
 <20191217171219.7cc3fc1d@x1.home>
 <66512c1f-aedc-a718-8594-b52d266f4b60@nvidia.com>
 <20200107170929.74c9c92e@w520.home>
 <17069da7-279b-872f-db15-d9995cf46285@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On Thu, 9 Jan 2020 02:22:26 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 1/8/2020 5:39 AM, Alex Williamson wrote:
> > On Wed, 8 Jan 2020 02:15:01 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> On 12/18/2019 5:42 AM, Alex Williamson wrote:  
> >>> On Tue, 17 Dec 2019 22:40:51 +0530
> >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>      
> >>
> >> <snip>
> >>  
> >>>
> >>> This will fail when there are devices within the IOMMU group that are
> >>> not represented as vfio_devices.  My original suggestion was:
> >>>
> >>> On Thu, 14 Nov 2019 14:06:25 -0700
> >>> Alex Williamson <alex.williamson@redhat.com> wrote:  
> >>>> I think it does so by pinning pages.  Is it acceptable that if the
> >>>> vendor driver pins any pages, then from that point forward we consider
> >>>> the IOMMU group dirty page scope to be limited to pinned pages?  There
> >>>> are complications around non-singleton IOMMU groups, but I think we're
> >>>> already leaning towards that being a non-worthwhile problem to solve.
> >>>> So if we require that only singleton IOMMU groups can pin pages and we  
> >>>
> >>> We could tag vfio_groups as singleton at vfio_add_group_dev() time with
> >>> an iommu_group_for_each_dev() walk so that we can cache the value on
> >>> the struct vfio_group.  
> >>
> >> I don't think iommu_group_for_each_dev() is required. Checking
> >> group->device_list in vfio_add_group_dev() if there are more than one
> >> device should work, right?
> >>
> >>           list_for_each_entry(vdev, &group->device_list, group_next) {
> >>                   if (group->is_singleton) {
> >>                           group->is_singleton = false;
> >>                           break;
> >>                   } else {
> >>                           group->is_singleton = true;
> >>                   }
> >>           }  
> > 
> > Hmm, I think you're taking a different approach to this than I was
> > thinking.  Re-reading my previous comments, the fact that both vfio.c
> > and vfio_iommu_type1.c each have their own private struct vfio_group
> > makes things rather unclear.  I was intending to use the struct
> > iommu_group as the object vfio.c provides to type1.c to associate the
> > pinning.  This would require that not only the vfio view of devices in
> > the group to be singleton, but also the actual iommu group to be
> > singleton.  Otherwise the set of devices vfio.c has in the group might
> > only be a subset of the group.  Maybe a merger of the approaches is
> > easier though.
> > 
> > Tracking whether the vfio.c view of a group is singleton is even easier
> > than above, we could simply add a device_count field to vfio_group,
> > increment it in vfio_group_create_device() and decrement it in
> > vfio_device_release().  vfio_pin_pages() could return error if
> > device_count is not 1.  We could still add the iommu_group pointer to
> > the type1 pin_pages callback, but perhaps type1 simply assumes that the
> > group is singleton when pin pages is called and it's vfio.c's
> > responsibility to maintain that group as singleton once pages have been
> > pinned.  vfio.c would therefore also need to set a field on the
> > vfio_group if pages have been pinned such that vfio_add_group_dev()
> > could return error if a new device attempts to join the group.  We'd
> > need to make sure that field is cleared when the group is released from
> > use and pay attention to races that might occur between adding devices
> > to a group and pinning pages.
> >   
> 
> Thinking aloud, will adding singleton check could cause issues in near 
> future? - may be in future support for p2p and direct RDMA will be added 
> for mdev devices. In that case the two devices should be in same 
> iommu_domain, but should be in different iommu_group - is that 
> understanding correct?

The ACS redirection stuff is the only thing that actually changes iommu
grouping relative to p2p/RDMA and that's specifically for untranslated
DMA, aiui.  If we wanted translated p2p DMA to be routed downstream of
the IOMMU we'd need to enable ACS direct translation.  In any case,
those are about shortening the path for p2p between devices.  We
actually don't even need devices to be in the same iommu domain to
allow p2p, we only need the iommu domain for each respective device to
map the mmio spaces of the other device.  I don't think we're doing
anything here that would cause us trouble later in this space, but it's
also just a policy decision, we wouldn't be breaking ABI to change the
implementation later.
 
> >>> vfio_group_nb_add_dev() could update this if
> >>> the IOMMU group composition changes.  
> >>
> >> I don't see vfio_group_nb_add_dev() calls vfio_add_group_dev() (?)
> >> If checking is_singleton is taken care in vfio_group_nb_add_dev(), which
> >> is the only place where vfio_group is allocated, that should work, I think.  
> > 
> > This was relative to maintaining that the iommu group itself is
> > singleton, not just the vfio view of the group.  If we use the latter
> > as our basis, then you're right, we should need this, but vfio.c would
> > need to enforce that the group remains singleton if it has pinned
> > pages.  Does that make sense?  Thanks,
> >   
> 
> Which route should be taken - iommu_group view or vfio.c group view?

The latter seems easier, more flexible, and lower overhead as far as I
can see.  Thanks,

Alex


