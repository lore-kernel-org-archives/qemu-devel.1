Received: from eggs.gnu.org ([2001:4830:134:3::10]:34460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fOO2f-0000iz-2T
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fOO2c-0007tG-7X
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:55:01 -0400
Date: Thu, 31 May 2018 15:54:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180531155453.40c1188e@redhat.com>
In-Reply-To: <c0e1637b-e4f9-5436-a050-edd69961e7d0@redhat.com>
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-2-david@redhat.com>
	<20180529152714.232f952c@redhat.com>
	<cb69838b-e346-503c-f86d-9a0746c6c1e6@redhat.com>
	<20180530145708.42bfd237@redhat.com>
	<c0e1637b-e4f9-5436-a050-edd69961e7d0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 01/14] memory-device: drop assert
 related to align and start of address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On Wed, 30 May 2018 16:06:59 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 30.05.2018 14:57, Igor Mammedov wrote:
> > On Tue, 29 May 2018 18:02:06 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 29.05.2018 15:27, Igor Mammedov wrote:  
> >>> On Thu, 17 May 2018 10:15:14 +0200
> >>> David Hildenbrand <david@redhat.com> wrote:
> >>>     
> >>>> The start of the address space does not have to be aligned for the
> >>>> search. Handle this case explicitly when starting the search for a new
> >>>> address.    
> >>> That's true,
> >>> but commit message doesn't explain why address_space_start
> >>> should be allowed to be non aligned.
> >>>
> >>> At least with this assert we would notice early that
> >>> board allocating misaligned address space.
> >>> I'd keep the assert unless there is a good reason to drop it.    
> >>
> >> That reason might be that I can easily crash QEMU
> >>
> >>  ./x86_64-softmmu/qemu-system-x86_64 -m 256M,maxmem=20G,slots=2 -object
> >> memory-backend-file,id=mem0,size=8192M,mem-path=/dev/zero,align=8192M
> >> -device pc-dimm,id=dimm1,memdev=mem0
> >>
> >> ERROR:hw/mem/memory-device.c:146:memory_device_get_free_addr: assertion
> >> failed: (QEMU_ALIGN_UP(address_space_start, align) == address_space_start)  
> > it looks like a different issue.
> > As I remember user visible 'align' property was added as duct tape since
> > we can't figure out alignment for DAX device no the host,
> > so it was left upto upper layers to magically figure that out.
> > 
> > However we probably shouldn't allow arbitrary or bigger aligment
> > than max page size supported by target machine/cpu
> > (i.e. currently hardcoded address_space_start alignment),
> > as it creates unnecessary fragmentation and not counted in size
> > of hotplug region (for x86 we count in additional 1Gb per memory device).
> > 
> > How about turning that assert into error check that
> > inhibits plugging in devices with alignment values
> > larger than address_space_start alignment?  
> 
> 
> Let me explain a little bit why I don't like such restrictions (for
> which I don't see a need yet):
(*) being conservative is good here because we can always relax restrictions
in future if it's needed without breaking users, but we can't take away
something thing that's been shipped (and if we do it, it typically
introduces a bunch of compat code to keep old machines working).
Also beside of giving as some freedom of movement in the future,
restrictions also to some degree prevent user from misconfiguration)

> virtio-mem devices will later have a certain block size (e.g. 4MB). I
> want to give devices during resource assignment the possibility to
> specify their alignment requirements.
size and alignment are 2 diffrent things here, alignment in our design
is dictated by backing storage page size and for performance reasons
HVA and GPA should be aligned on the same boundary, users are free
to pick another GPA manually as far as it has the same alignment.
But for automatic placement we use backend's alignment to make placement
as compact as possible but still keeping GPA aligned with HVA.

> For said virtio-mem device, this would e.g. be 4MB. (see patch 10 and 14
> of how this call "get_align" comes into play), because the addresses of
> the memory blocks are all aligned by e.g. 4MB. This is what is
> guaranteed by the device specification.
where does this 4Mb magic comes from and why block must be aligned
on this size?
 
> E.g. for DIMMs we might want to allow to specify the section size (e.g.
> 128MB on x86), otherwise e.g. Linux is not able to add all memory. (but
> we should not hardcode this, as this is a Linux specific requirement -
> still it would be nice to specify)
true, it's guest specific and we do not have restrictions here.
The only restriction we have here is that size must be multiple of
backing storage page size (i.e. alignment) so that guest would
be able to use tail page.

> So in general, a memory device might have some alignment that is to be
> taken care of.
Do we really need introducing frontend specific alignment?
I'd try reuse backend's one and go for frontend's only in case we have to.

> I don't understand right now why an upper limit on the alignment would
> make sense at all. We can easily handle it during our search. And we
> have to handle it either way during the search, if we plug some device
> with strange sizes (e.g. 1MB DIMM).
> 
> Of course, we might end up fragmenting guest physical memory, but that
> is purely a setup issue (choosing sizes of devices + main memory
> properly). I don't see a reason to error out (and of course also not to
> assert out :) ).
Agreed about assert, but I'd still prefer error out there so that users
won't crate insane config and then complain (see below and *).

Upper alignment value is useful for proper sizing of hotplug address space,
so that user could plug #slots devices upto #maxmem specified on CLI.
It's still possible to misconfigure using manual placement, but default
one just works, user either consumes all memory #maxmem and/or #slots.

There is no misunderstanding in case of error here as it works same as
on baremetal, one doesn't have a free place to put more memory or all
memory one asked for is already there.

So it might be that #slots decoupling from memory device a premature
action and we can still use it with virtio-mem/pmem.
