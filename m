Received: from eggs.gnu.org ([2001:4830:134:3::10]:59886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fPn7h-0000pX-1z
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fPn7d-0005Ea-02
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:54:01 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-2-david@redhat.com>
	<20180529152714.232f952c@redhat.com>
	<cb69838b-e346-503c-f86d-9a0746c6c1e6@redhat.com>
	<20180530145708.42bfd237@redhat.com>
	<c0e1637b-e4f9-5436-a050-edd69961e7d0@redhat.com>
	<20180531155453.40c1188e@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <af65fc0d-d010-a8f5-9027-886053034b51@redhat.com>
Date: Mon, 4 Jun 2018 12:53:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180531155453.40c1188e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>


>> Let me explain a little bit why I don't like such restrictions (for
>> which I don't see a need yet):
> (*) being conservative is good here because we can always relax restrictions
> in future if it's needed without breaking users, but we can't take away
> something thing that's been shipped (and if we do it, it typically
> introduces a bunch of compat code to keep old machines working).
> Also beside of giving as some freedom of movement in the future,
> restrictions also to some degree prevent user from misconfiguration)

Right, but I consider a maximum on an alignment arbitrary (and even
difficult to implement - as you said, "max page size supported by target
machine/cpu" - there are even different huge page sizes e.g. on x86).

So I'd really vote against introducing such checks.

And another point against introducing a check for the maimum alignment
would be: There might be users with a specified alignment > max page
size. Changing the behavior will break these setups (strange but true).

> 
>> virtio-mem devices will later have a certain block size (e.g. 4MB). I
>> want to give devices during resource assignment the possibility to
>> specify their alignment requirements.
> size and alignment are 2 diffrent things here, alignment in our design
> is dictated by backing storage page size and for performance reasons
> HVA and GPA should be aligned on the same boundary, users are free
> to pick another GPA manually as far as it has the same alignment.
> But for automatic placement we use backend's alignment to make placement
> as compact as possible but still keeping GPA aligned with HVA.
> 
>> For said virtio-mem device, this would e.g. be 4MB. (see patch 10 and 14
>> of how this call "get_align" comes into play), because the addresses of
>> the memory blocks are all aligned by e.g. 4MB. This is what is
>> guaranteed by the device specification.
> where does this 4Mb magic comes from and why block must be aligned
> on this size?

(knowing it is hard to get the idea without the current prototype in
place, but that will be fixed soon)

virtio-mem works in blocks. The block size is the size in which memory
can be plugged or unplugged by the guest. It also determines the
granularity (and therefore the bitmap) we have to use to keep track of
unplugged memory. It is configurable (e.g. for migration purposes), but
might also depend on the backend memory type. E.g. if huge pages are
used in the host, the huge page size defines the minimum block size. But
consider the last part a special case. Huge pages will not be supported
for now.

The block size also defines the alignment that has to be used by the
guest for plugging/unplugging (because that's how blocks gets mapped to
the bitmap entries). So a virtio-mem device really needs a block-aligned
start address,

For now I use 4MB because it matches what guests (e.g. Linux) can
actually support and keeps the bitmap small. But as I said, it is
configurable. (-device virtio-mem,block_size=1MB, ...)

>  
>> E.g. for DIMMs we might want to allow to specify the section size (e.g.
>> 128MB on x86), otherwise e.g. Linux is not able to add all memory. (but
>> we should not hardcode this, as this is a Linux specific requirement -
>> still it would be nice to specify)
> true, it's guest specific and we do not have restrictions here.
> The only restriction we have here is that size must be multiple of
> backing storage page size (i.e. alignment) so that guest would
> be able to use tail page.
> 
>> So in general, a memory device might have some alignment that is to be
>> taken care of.
> Do we really need introducing frontend specific alignment?
> I'd try reuse backend's one and go for frontend's only in case we have to.

I think so. But I consider this a special case for virtio-mem.
(specified indirectly via block_size). For the remaining stuff, we might
be able to live with the memory backend aligment. And I agree that this
should be the default if possible.

> 
>> I don't understand right now why an upper limit on the alignment would
>> make sense at all. We can easily handle it during our search. And we
>> have to handle it either way during the search, if we plug some device
>> with strange sizes (e.g. 1MB DIMM).
>>
>> Of course, we might end up fragmenting guest physical memory, but that
>> is purely a setup issue (choosing sizes of devices + main memory
>> properly). I don't see a reason to error out (and of course also not to
>> assert out :) ).
> Agreed about assert, but I'd still prefer error out there so that users
> won't crate insane config and then complain (see below and *).
> 
> Upper alignment value is useful for proper sizing of hotplug address space,
> so that user could plug #slots devices upto #maxmem specified on CLI.
> It's still possible to misconfigure using manual placement, but default
> one just works, user either consumes all memory #maxmem and/or #slots.


Please not that it will still work in most cases. Only if people start
to define crazy alignments (like I did), crazy DIMM sizes (e.g. 1MB) or
crazy block sizes for virtio-mem, we might have a fragmented guest
physical memory. This should  usually not happen, but if so, we already
have error messages for reporting this "fragmented memory".

And I consider these "strange configs" similar as "strange manual
placement". Same result: fragmented memory, error out.

Personally, I don't think we have to guarantee that automatic placement
works in all scenarios that the user is able to come up with. It should
work in sane configurations, which is still that case.


> 
> There is no misunderstanding in case of error here as it works same as
> on baremetal, one doesn't have a free place to put more memory or all
> memory one asked for is already there.
> 
> So it might be that #slots decoupling from memory device a premature
> action and we can still use it with virtio-mem/pmem.
> 

I treat #slots on x86 as #acpi_slots, that's why I don't think they
apply here. I can see how they are used (on x86 only!) to size the
address space - but I consider this a "nice to have feature" that should
not be supposed to work in all possible scenarios.

E.g. powerpc already relies on sane user configs. #slots is not used to
size the guest address space. Similar things will apply on s390x.

-- 

Thanks,

David / dhildenb
