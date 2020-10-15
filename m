Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CFFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DAC206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/OIO1pG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DAC206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTA0l-0003yK-IM
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 16:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kT9zw-0003WX-4f
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kT9zs-0004XK-Uy
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602794230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tfjr/IPCCMUy9U3+0hoskJJ8BI0PnDnK3xxIJIf8XjU=;
 b=U/OIO1pGMOtb6/wHB5IdvVe/qZT0gVClFB9V7JoQP5aDrr2KaC69qV4pZKn96MrzprgA2E
 juaqqwVmc2sb0WbYcluk5XJGVa5/zW2Kut3oicFpuu13gFpyRkyeswL5944u4ptQsBh2zK
 P0/aR0TyFaZhZO1dwttuL2aTuTXtjN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-IDl3NvmOMOaB-v0PqJCY8w-1; Thu, 15 Oct 2020 16:37:08 -0400
X-MC-Unique: IDl3NvmOMOaB-v0PqJCY8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D612B100746A;
 Thu, 15 Oct 2020 20:37:06 +0000 (UTC)
Received: from w520.home (ovpn-113-35.phx2.redhat.com [10.3.113.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9ABCE60CD0;
 Thu, 15 Oct 2020 20:36:56 +0000 (UTC)
Date: Thu, 15 Oct 2020 14:36:54 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 18/32] osdep: import MADV_DOEXEC
Message-ID: <20201015143654.166e0639@w520.home>
In-Reply-To: <894a2344-025f-572e-1120-7a14b08e6f39@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-19-git-send-email-steven.sistare@oracle.com>
 <51c859fb-3340-e361-1945-0ec2a393a34d@oracle.com>
 <20200817144856.16c703da@x1.home>
 <1750879d-70f8-72db-0eb3-86caa75ad3a0@oracle.com>
 <20200817154403.39ee42c6@x1.home> <20200817204242.6b384ef7@x1.home>
 <64d3c11a-dda4-a9ed-0bdd-621a0b4f6f75@oracle.com>
 <20200824163013.69f154ad@x1.home>
 <894a2344-025f-572e-1120-7a14b08e6f39@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Anthony Yznaga <anthony.yznaga@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 8 Oct 2020 12:32:35 -0400
Steven Sistare <steven.sistare@oracle.com> wrote:

> On 8/24/2020 6:30 PM, Alex Williamson wrote:
> > On Wed, 19 Aug 2020 17:52:26 -0400
> > Steven Sistare <steven.sistare@oracle.com> wrote:  
> >> On 8/17/2020 10:42 PM, Alex Williamson wrote:  
> >>> On Mon, 17 Aug 2020 15:44:03 -0600
> >>> Alex Williamson <alex.williamson@redhat.com> wrote:  
> >>>> On Mon, 17 Aug 2020 17:20:57 -0400
> >>>> Steven Sistare <steven.sistare@oracle.com> wrote:  
> >>>>> On 8/17/2020 4:48 PM, Alex Williamson wrote:      
> >>>>>> On Mon, 17 Aug 2020 14:30:51 -0400
> >>>>>> Steven Sistare <steven.sistare@oracle.com> wrote:
> >>>>>>         
> >>>>>>> On 7/30/2020 11:14 AM, Steve Sistare wrote:        
> >>>>>>>> Anonymous memory segments used by the guest are preserved across a re-exec
> >>>>>>>> of qemu, mapped at the same VA, via a proposed madvise(MADV_DOEXEC) option
> >>>>>>>> in the Linux kernel. For the madvise patches, see:
> >>>>>>>>
> >>>>>>>> https://lore.kernel.org/lkml/1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com/
> >>>>>>>>
> >>>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >>>>>>>> ---
> >>>>>>>>  include/qemu/osdep.h | 7 +++++++
> >>>>>>>>  1 file changed, 7 insertions(+)          
> >>>>>>>
> >>>>>>> Hi Alex,
> >>>>>>>   The MADV_DOEXEC functionality, which is a pre-requisite for the entire qemu 
> >>>>>>> live update series, is getting a chilly reception on lkml.  We could instead 
> >>>>>>> create guest memory using memfd_create and preserve the fd across exec.  However, 
> >>>>>>> the subsequent mmap(fd) will return a different VA than was used previously, 
> >>>>>>> which  is a problem for memory that was registered with vfio, as the original VA 
> >>>>>>> is remembered in the kernel struct vfio_dma and used in various kernel functions, 
> >>>>>>> such as vfio_iommu_replay.
> >>>>>>>
> >>>>>>> To fix, we could provide a VFIO_IOMMU_REMAP_DMA ioctl taking iova, size, and
> >>>>>>> new_vaddr.  The implementation finds an exact match for (iova, size) and replaces 
> >>>>>>> vaddr with new_vaddr.  Flags cannot be changed.
> >>>>>>>
> >>>>>>> memfd_create plus VFIO_IOMMU_REMAP_DMA would replace MADV_DOEXEC.
> >>>>>>> vfio on any form of shared memory (shm, dax, etc) could also be preserved across
> >>>>>>> exec with shmat/mmap plus VFIO_IOMMU_REMAP_DMA.
> >>>>>>>
> >>>>>>> What do you think        
> >>>>>>
> >>>>>> Your new REMAP ioctl would have parameters identical to the MAP_DMA
> >>>>>> ioctl, so I think we should just use one of the flag bits on the
> >>>>>> existing MAP_DMA ioctl for this variant.        
> >>>>>
> >>>>> Sounds good.
> >>>>>       
> >>>>>> Reading through the discussion on the kernel side there seems to be
> >>>>>> some confusion around why vfio needs the vaddr beyond the user call to
> >>>>>> MAP_DMA though.  Originally this was used to test for virtually
> >>>>>> contiguous mappings for merging and splitting purposes.  This is
> >>>>>> defunct in the v2 interface, however the vaddr is now used largely for
> >>>>>> mdev devices.  If an mdev device is not backed by an IOMMU device and
> >>>>>> does not share a container with an IOMMU device, then a user MAP_DMA
> >>>>>> ioctl essentially just registers the translation within the vfio
> >>>>>> container.  The mdev vendor driver can then later either request pages
> >>>>>> to be pinned for device DMA or can perform copy_to/from_user() to
> >>>>>> simulate DMA via the CPU.
> >>>>>>
> >>>>>> Therefore I don't see that there's a simple re-architecture of the vfio
> >>>>>> IOMMU backend that could drop vaddr use.          
> >>>>>
> >>>>> Yes.  I did not explain on lkml as you do here (thanks), but I reached the 
> >>>>> same conclusion.
> >>>>>       
> >>>>>> I'm a bit concerned this new
> >>>>>> remap proposal also raises the question of how do we prevent userspace
> >>>>>> remapping vaddrs racing with asynchronous kernel use of the previous
> >>>>>> vaddrs.          
> >>>>>
> >>>>> Agreed.  After a quick glance at the code, holding iommu->lock during 
> >>>>> remap might be sufficient, but it needs more study.      
> >>>>
> >>>> Unless you're suggesting an extended hold of the lock across the entire
> >>>> re-exec of QEMU, that's only going to prevent a race between a remap
> >>>> and a vendor driver pin or access, the time between the previous vaddr
> >>>> becoming invalid and the remap is unprotected.    
> >>
> >> OK.  What if we exclude mediated devices?  Its appears they are the only
> >> ones where the kernel may async'ly use the vaddr, via call chains ending in 
> >> vfio_iommu_type1_pin_pages or vfio_iommu_type1_dma_rw_chunk.
> >>
> >> The other functions that use dma->vaddr are
> >>     vfio_dma_do_map 
> >>     vfio_pin_map_dma 
> >>     vfio_iommu_replay 
> >>     vfio_pin_pages_remote
> >> and they are all initiated via userland ioctl (if I have traced all the code 
> >> paths correctly).  Thus iommu->lock would protect them.
> >>
> >> We would block live update in qemu if the config includes a mediated device.
> >>
> >> VFIO_IOMMU_REMAP_DMA would return EINVAL if the container has a mediated device.  
> > 
> > That's not a solution I'd really be in favor of.  We're eliminating an
> > entire class of devices because they _might_ make use of these
> > interfaces, but anyone can add a vfio bus driver, even exposing the
> > same device API, and maybe make use of some of these interfaces in that
> > driver.  Maybe we'd even have reason to do it in vfio-pci if we had
> > reason to virtualize some aspect of a device.  I think we're setting
> > ourselves up for a very complicated support scenario if we just
> > arbitrarily decide to deny drivers using certain interfaces.
> >   
> >>>>>> Are we expecting guest drivers/agents to quiesce the device,
> >>>>>> or maybe relying on clearing bus-master, for PCI devices, to halt DMA?        
> >>>>>
> >>>>> No.  We want to support any guest, and the guest is not aware that qemu
> >>>>> live update is occurring.
> >>>>>       
> >>>>>> The vfio migration interface we've developed does have a mechanism to
> >>>>>> stop a device, would we need to use this here?  If we do have a
> >>>>>> mechanism to quiesce the device, is the only reason we're not unmapping
> >>>>>> everything and remapping it into the new address space the latency in
> >>>>>> performing that operation?  Thanks,        
> >>>>>
> >>>>> Same answer - we don't require that the guest has vfio migration support.      
> >>>>
> >>>> QEMU toggling the runstate of the device via the vfio migration
> >>>> interface could be done transparently to the guest, but if your
> >>>> intention is to support any device (where none currently support the
> >>>> migration interface) perhaps it's a moot point.      
> >>
> >> That sounds useful when devices support.  Can you give me some function names
> >> or references so I can study this qemu-based "vfio migration interface".  
> > 
> > The uAPI is documented in commit a8a24f3f6e38.  We're still waiting on
> > the QEMU support or implementation in an mdev vendor driver.
> > Essentially migration exposes a new region of the device which would be
> > implemented by the vendor driver.  A register within that region
> > manipulates the device state, so a device could be stopped by clearing
> > the 'run' bit in that register.
> >   
> >>>> It seems like this
> >>>> scheme only works with IOMMU backed devices where the device can
> >>>> continue to operate against pinned pages, anything that might need to
> >>>> dynamically pin pages against the process vaddr as it's running async
> >>>> to the QEMU re-exec needs to be blocked or stopped.  Thanks,    
> >>
> >> Yes, true of this remap proposal.
> >>
> >> I wanted to unconditionally support all devices, which is why I think that
> >>
> >> MADV_DOEXEC is a nifty solution.  If you agree, please add your voice to the
> >> lkml discussion.  
> 
> Hi Alex, here is a modified proposal to remap vaddr in the face of async requests
> from mediated device drivers.
> 
> Define a new flag VFIO_DMA_MAP_FLAG_REMAP for use with VFIO_IOMMU_UNMAP_DMA and
> VFIO_IOMMU_MAP_DMA.
> 
> VFIO_IOMMU_UNMAP_DMA  flags=VFIO_DMA_MAP_FLAG_REMAP
>   Discard vaddr on the existing dma region defined by (iova, size), but keep the
>   struct vfio_dma.  Subsequent translation requests are blocked.
>   The implementation sets a flag in struct vfio_dma.  vfio_pin_pages() and
>   vfio_dma_rw() acquire iommu->lock, check the flag, and retry.
>   Called before exec.
> 
> VFIO_IOMMU_MAP_DMA  flags=VFIO_DMA_MAP_FLAG_REMAP
>   Remap the region (iova, size) to vaddr, and resume translation requests.
>   Called after exec.
> 
> Unfortunately, remap as defined above has an undesirable side effect.  The mdev
> driver may use kernel worker threads which serve requests from multiple clients
> (eg i915/gvt workload_thread).  A process that fails to call MAP_DMA with REMAP,
> or is tardy doing so, will delay other processes who are stuck waiting in
> vfio_pin_pages or vfio_dma_rw.  This is unacceptable, and I mention this scheme in
> case I am misinterpreting the code (maybe they do not share a single struct vfio_iommu
> instance?), or in case you see a way to salvage it.

Right, that's my first thought when I hear that the pin and dma_rw paths
are blocked as well, we cannot rely on userspace to unblock anything.
A malicious user may hold out just to see how long until the host
becomes unusable.  Userspace determines how many groups share a
vfio_iommu.

> Here is a more robust implementation.  It only works for dma regions backed by
> a file, such as memfd or shm.
> 
> VFIO_IOMMU_UNMAP_DMA  flags=VFIO_DMA_MAP_FLAG_REMAP
>   Find the file and offset for iova, and save the struct file pointer in
>   struct vfio_dma.  In vfio_pin_pages and vfio_dma_rw and their descendants,
>   if file* is set, then call pagecache_get_page() to get the pfn, instead of
>   get_user_pages.
> 
> VFIO_IOMMU_MAP_DMA  flags=VFIO_DMA_MAP_FLAG_REMAP
>   Remap the region (iova, size) to vaddr and drop the file reference.
> 
> This begs the question of whether we can always use pagecache_get_page, and
> eliminate the dependency on vaddr.  The translation performance could be
> different, though.
> 
> I have not implemented this yet.  Any thoughts before I do?

That's a pretty hefty usage restriction, but what I take from it is
that these are mechanisms which provide a fallback lookup path that can
service callers in the interim during the gap of the range being
remapped.  The callers are always providing an IOVA and wishing to do
something to the memory referenced by that IOVA, we just need a
translation mechanism.  The IOMMU itself is also such an alternative
lookup, via iommu_iova_to_phys(), but of course requiring an
IOMMU-backed device is just another usage restriction, potentially one
that's not even apparent to the user.

Is a more general solution to make sure there's always an IOVA-to-phys
lookup mechanism available, implementing one if not provided by the
IOMMU or memory backing interface?  We'd need to adapt the dma_rw
interface to work on either a VA or PA, and pinning pages on
UNMAP+REMAP, plus stashing them in a translation structure, plus
dynamically adapting to changes (ex. the IOMMU backed device being
removed, leaving a non-IOMMU backed device in the vfio_iommu) all
sounds pretty complicated, especially as the vfio-iommu-type1 backend
becomes stretched to be more and more fragile.  Possibly it's still
feasible though.  Thanks,

Alex


