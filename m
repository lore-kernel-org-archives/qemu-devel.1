Received: from eggs.gnu.org ([2001:4830:134:3::10]:59438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1egu9T-0008Eo-6O
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1egu9O-00006H-7k
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:18:19 -0500
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d]:50843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1egu9O-00005n-00
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:18:14 -0500
Received: by mail-it0-x22d.google.com with SMTP id x128so5772210ite.0
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 07:18:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180131095351.GY21802@cbox>
References: <20180124212246.2352-1-wei@redhat.com>
	<20180125200525.GC2442@work-vm>
	<6e27688f-1350-62f5-23ff-7855ea502be9@redhat.com>
	<CAFEAcA_9HJBETLvsUs9dk=Hw-G_eswNt3R+o+fs70vM9buAeBA@mail.gmail.com>
	<20180126194559.GI2610@work-vm>
	<CAFEAcA_QgROXb-7ZbWhL6zM5RmqLK5hyU7Whh+-7REMsXghQmA@mail.gmail.com>
	<20180129095330.GA2408@work-vm>
	<CAFEAcA97sfayAEypoArqg4zt5eiv-D9_VoXkeTqz3wn2LutF5Q@mail.gmail.com>
	<a7c01a48-786b-81d7-7af8-fe80a15283f6@arm.com>
	<20180131095351.GY21802@cbox>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 31 Jan 2018 15:18:12 +0000
Message-ID: <CAKv+Gu-NAcUTpEUXCLudHTCFAf=Yb28q3AET9d4ED9A9z7dMfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V1 1/1] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Andrew Jones <drjones@redhat.com>

On 31 January 2018 at 09:53, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Mon, Jan 29, 2018 at 10:32:12AM +0000, Marc Zyngier wrote:
>> On 29/01/18 10:04, Peter Maydell wrote:
>> > On 29 January 2018 at 09:53, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>> >> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> >>> On 26 January 2018 at 19:46, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>> >>>> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> >>>>> I think the correct fix here is that your test code should turn
>> >>>>> its MMU on. Trying to treat guest RAM as uncacheable doesn't work
>> >>>>> for Arm KVM guests (for the same reason that VGA device video memory
>> >>>>> doesn't work). If it's RAM your guest has to arrange to map it as
>> >>>>> Normal Cacheable, and then everything should work fine.
>> >>>>
>> >>>> Does this cause problems with migrating at just the wrong point during
>> >>>> a VM boot?
>> >>>
>> >>> It wouldn't surprise me if it did, but I don't think I've ever
>> >>> tried to provoke that problem...
>> >>
>> >> If you think it'll get the RAM contents wrong, it might be best to fail
>> >> the migration if you can detect the cache is disabled in the guest.
>> >
>> > I guess QEMU could look at the value of the "MMU disabled/enabled" bit
>> > in the guest's system registers, and refuse migration if it's off...
>> >
>> > (cc'd Marc, Christoffer to check that I don't have the wrong end
>> > of the stick about how thin the ice is in the period before the
>> > guest turns on its MMU...)
>>
>> Once MMU and caches are on, we should be in a reasonable place for QEMU
>> to have a consistent view of the memory. The trick is to prevent the
>> vcpus from changing that. A guest could perfectly turn off its MMU at
>> any given time if it needs to (and it is actually required on some HW if
>> you want to mitigate headlining CVEs), and KVM won't know about that.
>>
>
> (Clarification: KVM can detect this is it bother to check the VCPU's
> system registers, but we don't trap to KVM when the VCPU turns off its
> caches, right?)
>
>> You may have to pause the vcpus before starting the migration, or
>> introduce a new KVM feature that would automatically pause a vcpu that
>> is trying to disable its MMU while the migration is on. This would
>> involve trapping all the virtual memory related system registers, with
>> an obvious cost. But that cost would be limited to the time it takes to
>> migrate the memory, so maybe that's acceptable.
>>
> Is that even sufficient?
>
> What if the following happened. (1) guest turns off MMU, (2) guest
> writes some data directly to ram (3) qemu stops the vcpu (4) qemu reads
> guest ram.  QEMU's view of guest ram is now incorrect (stale,
> incoherent, ...).
>
> I'm also not really sure if pausing one VCPU because it turned off its
> MMU will go very well when trying to migrate a large VM (wouldn't this
> ask for all the other VCPUs beginning to complain that the stopped VCPU
> appears to be dead?).  As a short-term 'fix' it's probably better to
> refuse migration if you detect that a VCPU had begun turning off its
> MMU.
>
> On the larger scale of thins; this appears to me to be another case of
> us really needing some way to coherently access memory between QEMU and
> the VM, but in the case of the VCPU turning off the MMU prior to
> migration, we don't even know where it may have written data, and I'm
> therefore not really sure what the 'proper' solution would be.
>
> (cc'ing Ard who has has thought about this problem before in the context
> of UEFI and VGA.)
>

Actually, the VGA case is much simpler because the host is not
expected to write to the framebuffer, only read from it, and the guest
is not expected to create a cacheable mapping for it, so any
incoherency can be trivially solved by cache invalidation on the host
side. (Note that this has nothing to do with DMA coherency, but only
with PCI MMIO BARs that are backed by DRAM in the host)

In the migration case, it is much more complicated, and I think
capturing the state of the VM in a way that takes incoherency between
caches and main memory into account is simply infeasible (i.e., the
act of recording the state of guest RAM via a cached mapping may evict
clean cachelines that are out of sync, and so it is impossible to
record both the cached *and* the delta with the uncached state)

I wonder how difficult it would be to
a) enable trapping of the MMU system register when a guest CPU is
found to have its MMU off at migration time
b) allow the guest CPU to complete whatever it thinks it needs to be
doing with the MMU off
c) once it re-enables the MMU, proceed with capturing the memory state

Full disclosure: I know very little about KVM migration ...
