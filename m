Received: from eggs.gnu.org ([209.51.188.92]:48325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1grwoB-0002iE-UM
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 22:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1grwo9-0002nS-4n
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 22:26:31 -0500
Date: Thu, 7 Feb 2019 20:26:20 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190207202620.23e9c063@x1.home>
In-Reply-To: <295fa9ca-29c1-33e6-5168-8991bc0ef7b1@ozlabs.ru>
References: <20190117025115.81178-1-aik@ozlabs.ru>
	<fbe0ca8e-4d52-d59c-4f8d-9a1f473a81df@gmail.com>
	<b82674e7-cc41-6bba-2f9e-9882bfd7afbd@ozlabs.ru>
	<20190207081830.4dcbb822@x1.home>
	<295fa9ca-29c1-33e6-5168-8991bc0ef7b1@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu 0/3] spapr_pci,
 vfio: NVIDIA V100 + P9 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>

On Fri, 8 Feb 2019 13:29:37 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 08/02/2019 02:18, Alex Williamson wrote:
> > On Thu, 7 Feb 2019 15:43:18 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >   
> >> On 07/02/2019 04:22, Daniel Henrique Barboza wrote:  
> >>> Based on this series, I've sent a Libvirt patch to allow a QEMU process
> >>> to inherit IPC_LOCK when using VFIO passthrough with the Tesla V100
> >>> GPU:
> >>>
> >>> https://www.redhat.com/archives/libvir-list/2019-February/msg00219.html
> >>>
> >>>
> >>> In that thread, Alex raised concerns about allowing QEMU to freely lock
> >>> all the memory it wants. Is this an issue to be considered in the review
> >>> of this series here?
> >>>
> >>> Reading the patches, specially patch 3/3, it seems to me that QEMU is
> >>> going to lock the KVM memory to populate the NUMA node with memory
> >>> of the GPU itself, so at first there is no risk of not taking over the
> >>> host RAM.
> >>> Am I missing something?    
> >>
> >>
> >> The GPU memory belongs to the device and not visible to the host as
> >> memory blocks and not covered by page structs, for the host it is more
> >> like MMIO which is passed through to the guest without that locked
> >> accounting, I'd expect libvirt to keep working as usual except that:
> >>
> >> when libvirt calculates the amount of memory needed for TCE tables
> >> (which is guestRAM/64k*8), now it needs to use the end of the last GPU
> >> RAM window as a guest RAM size. For example, in QEMU HMP "info mtree -f":
> >>
> >> FlatView #2
> >>  AS "memory", root: system
> >>  AS "cpu-memory-0", root: system
> >>  Root memory region: system
> >>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
> >>   0000010000000000-0000011fffffffff (prio 0, ram): nvlink2-mr
> >>
> >> So previously the DMA window would cover 0x7fffffff+1, now it has to
> >> cover 0x11fffffffff+1.  
> > 
> > This looks like a chicken and egg problem, you're saying libvirt needs
> > to query mtree to understand the extent of the GPU layout, but we need
> > to specify the locked memory limits in order for QEMU to start?  Is
> > libvirt supposed to start the VM with unlimited locked memory and fix
> > it at some indeterminate point in the future?  Run a dummy VM with
> > unlimited locked memory in order to determine the limits for the real
> > VM?  Neither of these sound practical.  Thanks,  
> 
> 
> QEMU maps GPU RAM at known locations (which only depends on the vPHB's
> index or can be set explicitely) and libvirt knows how many GPUs are
> passed so it is quite easy to calculate the required amount of memory.
> 
> Here is the window start calculation:
> https://github.com/aik/qemu/commit/7073cad3ae7708d657e01672bcf53092808b54fb#diff-662409c2a5a150fe231d07ea8384b920R3812
> 
> We do not exactly know the GPU RAM window size until QEMU reads it from
> VFIO/nvlink2 but we know that all existing hardware has a window of
> 128GB (the adapters I have access to only have 16/32GB on board).

So you're asking that libvirt add 128GB per GPU with magic nvlink
properties, which may be 8x what's actually necessary and libvirt
determines which GPUs to apply this to how?  Does libvirt need to sort
through device tree properties for this?  Thanks,

Alex
