Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB1CC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 21:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6652072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 21:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9kiKnps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6652072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7mwF-0005M3-66
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 17:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k7mvX-0004vs-CD
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 17:44:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46767
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k7mvU-000177-Q8
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 17:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597700659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zO/wc6C6xl3r+AmzjgbammJepSsmyqjIC9y579iOO88=;
 b=B9kiKnpsOVH5dMrD+zICyeKw36UQQtQAK7XGVhlaCfcIB/UlhBe/sW2lB7Matu53tZ67kf
 kIfy4h+webZYo/P5vvQYUUrt/PyL/jf+deNKuTjuPdBJTZSHmrU2jiWZaDTgsCe6uM6E5E
 4gP2ohVJYCI20SOQSlYW2Rb4K/3SCT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-f5InSApsNIGoSRh1marwAA-1; Mon, 17 Aug 2020 17:44:17 -0400
X-MC-Unique: f5InSApsNIGoSRh1marwAA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B86E10074AF;
 Mon, 17 Aug 2020 21:44:16 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6685F7A1C5;
 Mon, 17 Aug 2020 21:44:04 +0000 (UTC)
Date: Mon, 17 Aug 2020 15:44:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 18/32] osdep: import MADV_DOEXEC
Message-ID: <20200817154403.39ee42c6@x1.home>
In-Reply-To: <1750879d-70f8-72db-0eb3-86caa75ad3a0@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-19-git-send-email-steven.sistare@oracle.com>
 <51c859fb-3340-e361-1945-0ec2a393a34d@oracle.com>
 <20200817144856.16c703da@x1.home>
 <1750879d-70f8-72db-0eb3-86caa75ad3a0@oracle.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 16:43:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Aug 2020 17:20:57 -0400
Steven Sistare <steven.sistare@oracle.com> wrote:

> On 8/17/2020 4:48 PM, Alex Williamson wrote:
> > On Mon, 17 Aug 2020 14:30:51 -0400
> > Steven Sistare <steven.sistare@oracle.com> wrote:
> >   
> >> On 7/30/2020 11:14 AM, Steve Sistare wrote:  
> >>> Anonymous memory segments used by the guest are preserved across a re-exec
> >>> of qemu, mapped at the same VA, via a proposed madvise(MADV_DOEXEC) option
> >>> in the Linux kernel. For the madvise patches, see:
> >>>
> >>> https://lore.kernel.org/lkml/1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com/
> >>>
> >>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >>> ---
> >>>  include/qemu/osdep.h | 7 +++++++
> >>>  1 file changed, 7 insertions(+)    
> >>
> >> Hi Alex,
> >>   The MADV_DOEXEC functionality, which is a pre-requisite for the entire qemu 
> >> live update series, is getting a chilly reception on lkml.  We could instead 
> >> create guest memory using memfd_create and preserve the fd across exec.  However, 
> >> the subsequent mmap(fd) will return a different VA than was used previously, 
> >> which  is a problem for memory that was registered with vfio, as the original VA 
> >> is remembered in the kernel struct vfio_dma and used in various kernel functions, 
> >> such as vfio_iommu_replay.
> >>
> >> To fix, we could provide a VFIO_IOMMU_REMAP_DMA ioctl taking iova, size, and
> >> new_vaddr.  The implementation finds an exact match for (iova, size) and replaces 
> >> vaddr with new_vaddr.  Flags cannot be changed.
> >>
> >> memfd_create plus VFIO_IOMMU_REMAP_DMA would replace MADV_DOEXEC.
> >> vfio on any form of shared memory (shm, dax, etc) could also be preserved across
> >> exec with shmat/mmap plus VFIO_IOMMU_REMAP_DMA.
> >>
> >> What do you think  
> > 
> > Your new REMAP ioctl would have parameters identical to the MAP_DMA
> > ioctl, so I think we should just use one of the flag bits on the
> > existing MAP_DMA ioctl for this variant.  
> 
> Sounds good.
> 
> > Reading through the discussion on the kernel side there seems to be
> > some confusion around why vfio needs the vaddr beyond the user call to
> > MAP_DMA though.  Originally this was used to test for virtually
> > contiguous mappings for merging and splitting purposes.  This is
> > defunct in the v2 interface, however the vaddr is now used largely for
> > mdev devices.  If an mdev device is not backed by an IOMMU device and
> > does not share a container with an IOMMU device, then a user MAP_DMA
> > ioctl essentially just registers the translation within the vfio
> > container.  The mdev vendor driver can then later either request pages
> > to be pinned for device DMA or can perform copy_to/from_user() to
> > simulate DMA via the CPU.
> > 
> > Therefore I don't see that there's a simple re-architecture of the vfio
> > IOMMU backend that could drop vaddr use.    
> 
> Yes.  I did not explain on lkml as you do here (thanks), but I reached the 
> same conclusion.
> 
> > I'm a bit concerned this new
> > remap proposal also raises the question of how do we prevent userspace
> > remapping vaddrs racing with asynchronous kernel use of the previous
> > vaddrs.    
> 
> Agreed.  After a quick glance at the code, holding iommu->lock during 
> remap might be sufficient, but it needs more study.

Unless you're suggesting an extended hold of the lock across the entire
re-exec of QEMU, that's only going to prevent a race between a remap
and a vendor driver pin or access, the time between the previous vaddr
becoming invalid and the remap is unprotected.

> > Are we expecting guest drivers/agents to quiesce the device,
> > or maybe relying on clearing bus-master, for PCI devices, to halt DMA?  
> 
> No.  We want to support any guest, and the guest is not aware that qemu
> live update is occurring.
> 
> > The vfio migration interface we've developed does have a mechanism to
> > stop a device, would we need to use this here?  If we do have a
> > mechanism to quiesce the device, is the only reason we're not unmapping
> > everything and remapping it into the new address space the latency in
> > performing that operation?  Thanks,  
> 
> Same answer - we don't require that the guest has vfio migration support.

QEMU toggling the runstate of the device via the vfio migration
interface could be done transparently to the guest, but if your
intention is to support any device (where none currently support the
migration interface) perhaps it's a moot point.  It seems like this
scheme only works with IOMMU backed devices where the device can
continue to operate against pinned pages, anything that might need to
dynamically pin pages against the process vaddr as it's running async
to the QEMU re-exec needs to be blocked or stopped.  Thanks,

Alex


