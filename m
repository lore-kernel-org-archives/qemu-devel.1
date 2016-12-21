Received: from eggs.gnu.org ([2001:4830:134:3::10]:46596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJXRL-0004WL-9v
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 22:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJXRI-0005ce-2Q
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 22:19:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cJXRH-0005c7-Pv
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 22:19:35 -0500
Date: Wed, 21 Dec 2016 11:19:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161221031926.GC22006@pxdev.xzpeter.org>
References: <1482158486-18597-1-git-send-email-peterx@redhat.com>
	<20161219095650.0a3ac113@t450s.home>
	<20161220034441.GA19964@pxdev.xzpeter.org>
	<20161219215252.6b0a6e8b@t450s.home>
	<20161220063801.GB22006@pxdev.xzpeter.org>
	<20161220170433.011a5055@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161220170433.011a5055@t450s.home>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: allow dynamic switch of IOMMU
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, bd.aviv@gmail.com, david@gibson.dropbear.id.au

On Tue, Dec 20, 2016 at 05:04:33PM -0700, Alex Williamson wrote:
> On Tue, 20 Dec 2016 14:38:01 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Mon, Dec 19, 2016 at 09:52:52PM -0700, Alex Williamson wrote:
> > 
> > [...]
> > 
> > > > Yes, this patch just tried to move VT-d forward a bit, rather than do
> > > > it once and for all. I think we can do better than this in the future,
> > > > for example, one address space per guest IOMMU domain (as you have
> > > > mentioned before). However I suppose that will need more work (which I
> > > > still can't estimate on the amount of work). So I am considering to
> > > > enable the device assignments functionally first, then we can further
> > > > improve based on a workable version. Same thoughts apply to the IOMMU
> > > > replay RFC series.  
> > > 
> > > I'm not arguing against it, I'm just trying to set expectations for
> > > where this gets us.  An AddressSpace per guest iommu domain seems like
> > > the right model for QEMU, but it has some fundamental issues with
> > > vfio.  We currently tie a QEMU AddressSpace to a vfio container, which
> > > represents the host IOMMU context.  The AddressSpace of a device is
> > > currently assumed to be fixed in QEMU, guest IOMMU domains clearly
> > > are not.  vfio only let's us have access to a device while it's
> > > protected within a container.  Therefore in order to move a device to a
> > > different AddressSpace based on the guest domain configuration, we'd
> > > need to tear down the vfio configuration, including releasing the
> > > device.  
> > 
> > I assume this is VT-d specific issue, right? Looks like ppc is using a
> > totally differnet way to manage the mapping, and devices can share the
> > same address space.
> 
> It's only VT-d specific in that VT-d is the only vIOMMU we have for
> x86.  ppc has a much different host IOMMU architcture and their VM
> architecture requires an IOMMU.  The ppc model has a notion of
> preregistration to help with this, among other things.
> 
> > > > Regarding to the locked memory accounting issue: do we have existing
> > > > way to do the accounting? If so, would you (or anyone) please
> > > > elaborate a bit? If not, is that an ongoing/planned work?  
> > > 
> > > As I describe above, there's a vfio container per AddressSpace, each
> > > container is an IOMMU domain in the host.  In the guest, an IOMMU
> > > domain can include multiple AddressSpaces, one for each context entry
> > > that's part of the domain.  When the guest programs a translation for
> > > an IOMMU domain, that maps a guest IOVA to a guest physical address,
> > > for each AddressSpace.  Each AddressSpace is backed by a vfio
> > > container, which needs to pin the pages of that translation in order to
> > > get a host physical address, which then gets programmed into the host
> > > IOMMU domain with the guest-IOVA and host physical address.  The
> > > pinning process is where page accounting is done.  It's done per vfio
> > > context.  The worst case scenario for accounting is thus when VT-d is
> > > present but disabled (or in passthrough mode) as each AddressSpace
> > > duplicates address_space_memory and every page of guest memory is
> > > pinned and accounted for each vfio container.  
> > 
> > IIUC this accounting issue will solve itself if we can solve the
> > previous issue. While we don't have it now, so ...
> 
> Not sure what "previous issue" is referring to here.

Here I meant if we can let devices share the same VFIOAddressSpace in
the future for VT-d emulation (just like ppc), then we won't need to
worry about the duplicated accounting issue again. In that case, when
N devices are put into the same guest iommu domain, it'll share a
single VFIOAddressSpace in QEMU, and the mapping will be counted only
once.

But I think this does not solve the problem you mentioned below - yes
looks like guest user space driver can map the whole 39/48 bits
address space. That's something I failed to realize before...

> 
> > > That's the existing way we do accounting.  There is no current
> > > development that I'm aware of to change this.  As above, the simplest
> > > stop-gap solution is that libvirt would need to be aware when VT-d is
> > > present for a VM and use a different algorithm to set QEMU locked
> > > memory limit, but it's not without its downsides.  
> > 
> > ... here I think it's sensible to consider a specific algorithm for
> > vt-d use case. I am just curious about how should we define this
> > algorithm.
> > 
> > First of all, when the devices are not sharing domain (or say, one
> > guest iommu domain per assigned device), everything should be fine.
> 
> No, each domain could map the entire guest address space.  If we're
> talking about a domain per device for use with the Linux DMA API, then
> it's unlikely that the sum of mapped pages across all the domains will
> exceed the current libvirt set locked memory limit.  However, that's
> exactly the configuration where we expect to have abysmal performance.
> As soon as we recommend the guest boot with iommu=pt, then each
> container will be mapping and pinning the entire VM address space.
> 
> > No
> > special algorithm needed. IMHO the problem will happen only if there
> > are assigned devices that share a same address space (either system,
> > or specific iommu domain). In that case, the accounted value (or say,
> > current->mm->locked_vm iiuc) will be bigger than the real locked
> > memory size.
> > 
> > However, I think the problem is whether devices will be put into same
> > address space depends on guest behavior - the guest can either use
> > iommu=pt, or manually putting devices into the same guest iommu region
> > to achieve that. But from hypervisor POV, how should we estimate this?
> > Can we really?
> 
> The simple answer is that each device needs to be able to map the
> entire VM address space and therefore when a VM is configured with
> VT-d, libvirt needs to multiply the current locked memory settings for
> assigned devices by the number of devices (groups actually) assigned.
> There are (at least) two problems with this though.  The first is that
> we expect QEMU to use this increased locked memory limits for duplicate
> accounting of the same pages, but an exploited user process could take
> advantage of it and cause problems.  Not optimal.  The second problem
> relates to the usage of the IOVA address space and the assumption that
> a given container will map no more than the VM address space.  When no
> vIOMMU is exposed to the VM, QEMU manages the container IOVA space and
> we know that QEMU is only mapping VM RAM and therefore mappings are
> bound by the size of the VM.  With a vIOMMU, the guest is in control of
> the IOVA space and can map up to the limits of the vIOMMU.  The guest
> can map a single 4KB page to every IOVA up to that limit and we'll
> account that page each time.  So even valid (though perhaps not useful)
> cases within the guest can hit that locking limit.

So what will happen if a VM uses over the locked memory limit? Are we
only using cgroup so that the DMA_MAP ioctl() will just fail? Or there
is anything more to do with libvirt when VM exceeds this limitation?

Another question to vfio-pci module: I see that
vfio_listener_region_add() will crash the VM if it fails to do dma map
and we'll get this:

  hw_error("vfio: DMA mapping failed, unable to continue");

However in vfio_iommu_map_notify(), we don't have such a hard
requirement - when dma map fails, we just error_report() without quit
the VM. Could I ask why we are having different behavior here? Any
special concerns?

IMHO if the guest program abuse the vIOMMU mapping usage and reaches
the locked memory limit (I think for now N*VM_RAM_SIZE is fairly big
enough) that libvirt assigned to this VM, we should just crash the VM
to make sure it won't affect others (I assume using over N*VM_RAM_SIZE
for mapping is a hard clue that guest is doing something dangerous and
illegal).

[...]

> > I can totally understand that the performance will suck if dynamic
> > mapping is used. AFAIU this work will only be used with static dma
> > mapping like running DPDK in guest (besides other trivial goals, like,
> > development purpose).
> 
> We can't control how a feature is used, which is why I'm trying to make
> sure this doesn't come as a surprise to anyone.

Yes. Agree that we'd better try our best to let people know this
before they start to use it.

Thanks,

-- peterx
