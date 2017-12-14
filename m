Received: from eggs.gnu.org ([2001:4830:134:3::10]:36881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePVpB-0007Y2-Kg
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:53:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePVp8-00064m-GH
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:53:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePVp8-00063s-7b
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:53:26 -0500
Date: Thu, 14 Dec 2017 15:53:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171214155314.GB4380@work-vm>
References: <20171213180807.7066-1-dgilbert@redhat.com>
	<20171213180807.7066-5-dgilbert@redhat.com>
	<dd448e34-6a23-17d2-3cce-580c08c6de9f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd448e34-6a23-17d2-3cce-580c08c6de9f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/6] vhost: add regions to temporary list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, maxime.coquelin@redhat.com, groug@kaod.org, mst@redhat.com

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 13/12/2017 19:08, Dr. David Alan Gilbert (git) wrote:
> > +    if (dev->tmp_mem->nregions) {
> > +        /* Since we already have at least one region, lets see if
> > +         * this extends it; since we're scanning in order, we only
> > +         * have to look at the last one, and the FlatView that calls
> > +         * us shouldn't have overlaps.
> > +         */
> > +        struct vhost_memory_region *prev_vmr = dev->tmp_mem->regions +
> > +                                               (dev->tmp_mem->nregions - 1);
> > +        uint64_t prev_gpa_start = prev_vmr->guest_phys_addr;
> > +        uint64_t prev_gpa_end   = range_get_last(prev_gpa_start,
> > +                                                 prev_vmr->memory_size);
> > +        uint64_t prev_host_start = prev_vmr->userspace_addr;
> > +        uint64_t prev_host_end   = range_get_last(prev_host_start,
> > +                                                  prev_vmr->memory_size);
> > +
> > +        if (prev_gpa_end + 1 == mrs_gpa &&
> > +            prev_host_end + 1 == mrs_host &&
> > +            (!dev->vhost_ops->vhost_backend_can_merge ||
> > +                dev->vhost_ops->vhost_backend_can_merge(dev,
> > +                    mrs_host, mrs_size,
> > +                    prev_host_start, prev_vmr->memory_size))) {
> > +            /* The two regions abut */
> > +            need_add = false;
> > +            mrs_size = mrs_size + prev_vmr->memory_size;
> > +            prev_vmr->memory_size = mrs_size;
> > +            trace_vhost_region_add_tmp_abut(section->mr->name, mrs_size);
> > +        }
> > +    }
> 
> Interesting, in which cases does this actually trigger?

:vhost_section vga-lowmem:0
:vhost_section /objects/mem:1
:vhost_region_add_tmp /objects/mem: 0x0+0xa0000 @ 0x7ff1f5a08000
:vhost_section vga.vram:0
:vhost_section vga-lowmem:0
:vhost_section /objects/mem:1
:vhost_region_add_tmp /objects/mem: 0xc0000+0xa000 @ 0x7ff1f5ac8000
:vhost_section /objects/mem:1
:vhost_region_add_tmp /objects/mem: 0xca000+0x3000 @ 0x7ff1f5ad2000
>vhost_region_add_tmp_abut /objects/mem: 0xd000
:vhost_section /objects/mem:1
:vhost_region_add_tmp /objects/mem: 0xcd000+0x1f000 @ 0x7ff1f5ad5000
>vhost_region_add_tmp_abut /objects/mem: 0x2c000
:vhost_section /objects/mem:1
:vhost_region_add_tmp /objects/mem: 0xec000+0x4000 @ 0x7ff1f5af4000
>vhost_region_add_tmp_abut /objects/mem: 0x30000
:vhost_section /objects/mem:1
:vhost_region_add_tmp /objects/mem: 0xf0000+0x10000 @ 0x7ff1f5af8000
>vhost_region_add_tmp_abut /objects/mem: 0x40000
:vhost_section /objects/mem:1
:vhost_region_add_tmp /objects/mem: 0x100000+0x3ff00000 @ 0x7ff1f5b08000
>vhost_region_add_tmp_abut /objects/mem: 0x3ff40000
:vhost_section vga.vram:0
:vhost_section vga ioports remapped:0
:vhost_section bochs dispi interface:0
:vhost_section qemu extended regs:0
:vhost_section msix-table:0
:vhost_section msix-pba:0
:vhost_section kvm-ioapic:0
:vhost_section hpet:0
:vhost_section kvm-apic-msi:0
:vhost_section pc.bios:0
:vhost_commit Started: 1 Changed: 0

So it's not unusual for us to piece them back together into one
chunk.

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
