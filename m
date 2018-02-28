Received: from eggs.gnu.org ([2001:4830:134:3::10]:58439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqwTD-0004J0-6F
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqwT9-0008Ni-5E
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:48:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:9561)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eqwT8-0008N8-SE
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:48:07 -0500
Date: Wed, 28 Feb 2018 15:47:58 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180228074758.kjjaoyt3xg3q5imt@hz-desktop>
References: <20171207101812.23602-1-haozhong.zhang@intel.com>
	<20171207101812.23602-3-haozhong.zhang@intel.com>
	<20180227163728.GA1799@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227163728.GA1799@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [RFC QEMU PATCH v4 02/10] xen-hvm: create the
 hotplug memory region on Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 02/27/18 16:37 +0000, Anthony PERARD wrote:
> On Thu, Dec 07, 2017 at 06:18:04PM +0800, Haozhong Zhang wrote:
> > The guest physical address of vNVDIMM is allocated from the hotplug
> > memory region, which is not created when QEMU is used as Xen device
> > model. In order to use vNVDIMM for Xen HVM domains, this commit reuses
> > the code for pc machine type to create the hotplug memory region for
> > Xen HVM domains.
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > ---
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > ---
> >  hw/i386/pc.c          | 86 ++++++++++++++++++++++++++++-----------------------
> >  hw/i386/xen/xen-hvm.c |  2 ++
> >  include/hw/i386/pc.h  |  1 +
> >  3 files changed, 51 insertions(+), 38 deletions(-)
> > 
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 186545d2a4..9f46c8df79 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1315,6 +1315,53 @@ void xen_load_linux(PCMachineState *pcms)
> >      pcms->fw_cfg = fw_cfg;
> >  }
> >  
> > +void pc_memory_hotplug_init(PCMachineState *pcms, MemoryRegion *system_memory)
> 
> It might be better to have a separate patch which move the code into a function.

will move it to a separate patch

> 
> > +{
> > +    MachineState *machine = MACHINE(pcms);
> > +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> > +    ram_addr_t hotplug_mem_size = machine->maxram_size - machine->ram_size;
> > +
> > +    if (!pcmc->has_reserved_memory || machine->ram_size >= machine->maxram_size)
> > +        return;
> > +
> > +    if (memory_region_size(&pcms->hotplug_memory.mr)) {
> 
> This new check looks like to catch programming error, rather than user
> error. Would it be better to be an assert instead?

Well, this was a debugging check and I forgot to remove it before
sending the patch. I'll drop it in the next version.

Thanks,
Haozhong

> 
> > +        error_report("hotplug memory region has been initialized");
> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> 
> -- 
> Anthony PERARD
