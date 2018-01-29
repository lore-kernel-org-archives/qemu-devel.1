Received: from eggs.gnu.org ([2001:4830:134:3::10]:48170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1eg6je-0006Mu-VQ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1eg6jZ-0001fp-0w
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:32:22 -0500
Received: from foss.arm.com ([217.140.101.70]:45906)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1eg6jY-0001ei-QT
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:32:16 -0500
References: <20180124212246.2352-1-wei@redhat.com>
	<20180125200525.GC2442@work-vm>
	<6e27688f-1350-62f5-23ff-7855ea502be9@redhat.com>
	<CAFEAcA_9HJBETLvsUs9dk=Hw-G_eswNt3R+o+fs70vM9buAeBA@mail.gmail.com>
	<20180126194559.GI2610@work-vm>
	<CAFEAcA_QgROXb-7ZbWhL6zM5RmqLK5hyU7Whh+-7REMsXghQmA@mail.gmail.com>
	<20180129095330.GA2408@work-vm>
	<CAFEAcA97sfayAEypoArqg4zt5eiv-D9_VoXkeTqz3wn2LutF5Q@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <a7c01a48-786b-81d7-7af8-fe80a15283f6@arm.com>
Date: Mon, 29 Jan 2018 10:32:12 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA97sfayAEypoArqg4zt5eiv-D9_VoXkeTqz3wn2LutF5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>

On 29/01/18 10:04, Peter Maydell wrote:
> On 29 January 2018 at 09:53, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>> * Peter Maydell (peter.maydell@linaro.org) wrote:
>>> On 26 January 2018 at 19:46, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>>>> * Peter Maydell (peter.maydell@linaro.org) wrote:
>>>>> I think the correct fix here is that your test code should turn
>>>>> its MMU on. Trying to treat guest RAM as uncacheable doesn't work
>>>>> for Arm KVM guests (for the same reason that VGA device video memory
>>>>> doesn't work). If it's RAM your guest has to arrange to map it as
>>>>> Normal Cacheable, and then everything should work fine.
>>>>
>>>> Does this cause problems with migrating at just the wrong point during
>>>> a VM boot?
>>>
>>> It wouldn't surprise me if it did, but I don't think I've ever
>>> tried to provoke that problem...
>>
>> If you think it'll get the RAM contents wrong, it might be best to fail
>> the migration if you can detect the cache is disabled in the guest.
> 
> I guess QEMU could look at the value of the "MMU disabled/enabled" bit
> in the guest's system registers, and refuse migration if it's off...
> 
> (cc'd Marc, Christoffer to check that I don't have the wrong end
> of the stick about how thin the ice is in the period before the
> guest turns on its MMU...)

Once MMU and caches are on, we should be in a reasonable place for QEMU
to have a consistent view of the memory. The trick is to prevent the
vcpus from changing that. A guest could perfectly turn off its MMU at
any given time if it needs to (and it is actually required on some HW if
you want to mitigate headlining CVEs), and KVM won't know about that.

You may have to pause the vcpus before starting the migration, or
introduce a new KVM feature that would automatically pause a vcpu that
is trying to disable its MMU while the migration is on. This would
involve trapping all the virtual memory related system registers, with
an obvious cost. But that cost would be limited to the time it takes to
migrate the memory, so maybe that's acceptable.

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny...
