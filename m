Received: from eggs.gnu.org ([2001:4830:134:3::10]:44343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dQFNh-0002om-3c
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dQFNX-0003XH-4z
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:59:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dQFNW-0003VZ-Qe
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:59:43 -0400
Date: Wed, 28 Jun 2017 09:59:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170628095938.1329c358@w520.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D1956B@SHSMSX101.ccr.corp.intel.com>
References: <1491301684-24367-1-git-send-email-yulei.zhang@intel.com>
	<20170626141906.6e38b235@w520.home>
	<01FDBDDE256B79498DC57789713132D469DCC1EE@SHSMSX101.ccr.corp.intel.com>
	<20170627134431.5947c771@w520.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D1956B@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 5/5] vifo: introduce new VFIO ioctl
 VFIO_DEVICE_PCI_GET_DIRTY_BITMAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Zhang, Yulei" <yulei.zhang@intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "Zheng, Xiao" <xiao.zheng@intel.com>, "Wang, Zhi
	A" <zhi.a.wang@intel.com>

On Wed, 28 Jun 2017 06:04:10 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Wednesday, June 28, 2017 3:45 AM
> > 
> > On Tue, 27 Jun 2017 08:56:01 +0000
> > "Zhang, Yulei" <yulei.zhang@intel.com> wrote:
> > > > > diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> > > > > index fa17848..aa73ee1 100644
> > > > > --- a/linux-headers/linux/vfio.h
> > > > > +++ b/linux-headers/linux/vfio.h
> > > > > @@ -502,6 +502,20 @@ struct vfio_pci_status_set{
> > > > >
> > > > >  #define VFIO_DEVICE_PCI_STATUS_SET	_IO(VFIO_TYPE, VFIO_BASE +  
> > 14)  
> > > > >
> > > > > +/**
> > > > > + * VFIO_DEVICE_PCI_GET_DIRTY_BITMAP - _IOW(VFIO_TYPE,  
> > VFIO_BASE +  
> > > > 15,  
> > > > > + *				    struct vfio_pci_get_dirty_bitmap)
> > > > > + *
> > > > > + * Return: 0 on success, -errno on failure.
> > > > > + */
> > > > > +struct vfio_pci_get_dirty_bitmap{
> > > > > +	__u64	       start_addr;
> > > > > +	__u64	       page_nr;
> > > > > +	__u8           dirty_bitmap[];
> > > > > +};
> > > > > +
> > > > > +#define VFIO_DEVICE_PCI_GET_DIRTY_BITMAP _IO(VFIO_TYPE,  
> > VFIO_BASE  
> > > > + 15)  
> > > > > +  
> > > >
> > > > Dirty since when?  Since the last time we asked?  Since the device was
> > > > stopped?  Why is anything dirtied after the device is stopped?  Is this
> > > > any pages the device has ever touched?  Thanks,
> > > >
> > > > Alex  
> > > Dirty since the device start operation and before it was stopped. We track
> > > down all the guest pages that device was using before it was stopped, and
> > > leverage this dirty bitmap for page sync during migration.  
> > 
> > I don't understand how this is useful or efficient.  This implies that
> > the device is always tracking dirtied pages even when we don't care
> > about migration.  Don't we want to enable dirty logging at some point
> > and track dirty pages since then?  Otherwise we can just assume the
> > device dirties all pages and get rid of this ioctl.  Thanks,
> >   
> 
> Agree. Regarding to interface definition we'd better follow general
> dirty logging scheme as Alex pointed out, possibly through another
> ioctl cmd to enable/disable logging. However vendor specific 
> implementation may choose to ignore the cmd while always tracking 
> dirty pages, as on Intel Processor Graphics. Below is some background.
> 
> CPU dirty logging is done through either CPU page fault or HW dirty
> bit logging (e.g. Intel PML). However there is a gap in DMA side today. 
> DMA page fault requires both IOMMU and device support (through 
> PCI ATS/PRS), which is not widely available today and mostly for 
> special types of workloads (e.g. Shared Virtual Memory). Regarding
> to dirty bit, at least VTd doesn't support it today.
> 
> So the alternative option is to rely on mediation layer to track the
> dirty pages, since workload submissions on vGPU are mediated. It's
> feasible for simple devices such as NIC, which has a clear definition
> of descriptors so it's easy to scan and capture which pages will be
> dirtied. However doing same thing for complex GPU (meaning
> to scan all GPU commands, shader instructions, indirect structures, 
> etc.) is weigh too complex and insufficient. Today we only scan
> privileged commands for security purpose which is only a very 
> small portion of all possible cmd set.
> 
> Then in reality we choose a simplified approach. instead of tracking
> incrementally dirtied pages since last query, we treat all pages which
> are currently mapped in GPU page tables as dirtied. To avoid overhead
> of walking global page table (GGTT) and all active per-process page
> tables (PPGTTs) upon query, we choose to always maintain a bitmap 
> which is updated when mediating guest updates to those GTT entries. 
> It adds negligible overhead at run-time since those operations are 
> already mediated.
> 
> Every time when Qemu tries to query dirty map, it likely will get
> a similar large dirty bitmap (not exactly same since GPU page tables
> are being changed) then will exit iterative memory copy very soon,
> which will ends up like below:
> 
> 1st round: Qemu copies all the memory (say 4GB) to another machine
> 2nd round: Qemu queries vGPU dirty map (usually in several hundreds
> of MBs) and combine with CPU dirty map to copy
> 3rd round: Qemu will get similar size of dirty pages then exit the 
> pre-copy phase since dirty set doesn't converge
> 
> Although it's not that efficient, no need to stop service for whole 4GB
> memory copy still saves a lot. In our measurement the service 
> shutdown time is ~300ms over 10Gb link when running 3D benchmarks
> (e.g. 3DMark, Heaven, etc.) and media transcoding workloads, while
> copying whole system memory may easily take seconds to trigger TDR.
> though service shutdown time is bigger than usual server-based scenario,
> it's somehow OK for interactive usages (e.g. VDI) or offline transcoding 
> usages. You may take a look at our demo at:
> 
> https://www.youtube.com/watch?v=y2SkU5JODIY
> 
> In a nutshell, our current dirty logging implementation is a bit
> awkward due to arch limitation, but it does work well for some 
> scenarios. Most importantly I agree we should design interface 
> in a more general way to enable/disable dirty logging as stated
> earlier.
> 
> Hope above makes the whole background clearer. :-)

Thanks Kevin.  So really it's not really a dirty bitmap, it's just a
bitmap of pages that the device has access to and may have dirtied.
Don't we have this more generally in the vfio type1 IOMMU backend?  For
a mediated device, we know all the pages that the vendor driver has
asked to be pinned.  Should we perhaps make this interface on the vfio
container rather than the device?  Any mediated device can provide this
level of detail without specific vendor support.  If we had DMA page
faulting, this would be the natural place to put it as well, so maybe
we should design the interface there to support everything similarly.
Thanks,

Alex
