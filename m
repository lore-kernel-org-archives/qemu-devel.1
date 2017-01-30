Received: from eggs.gnu.org ([2001:4830:134:3::10]:46234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cY6sv-0001gl-Ht
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cY6ss-0002A2-7M
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:00:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cY6sr-000287-VW
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:00:18 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<874m0peu50.fsf@dusky.pond.sub.org>
	<533e0b17-4d60-a584-5680-559834013c68@web.de>
	<87inp05m8m.fsf@dusky.pond.sub.org>
	<4504afce-c62e-c54f-33a3-483f16dc4530@web.de>
Date: Mon, 30 Jan 2017 09:00:13 +0100
In-Reply-To: <4504afce-c62e-c54f-33a3-483f16dc4530@web.de> (Jan Kiszka's
	message of "Sun, 29 Jan 2017 09:43:33 +0100")
Message-ID: <87inoxvuya.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Towards an ivshmem 2.0?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Jailhouse <jailhouse-dev@googlegroups.com>, qemu-devel <qemu-devel@nongnu.org>

Jan Kiszka <jan.kiszka@web.de> writes:

> On 2017-01-27 20:36, Markus Armbruster wrote:
>> Jan Kiszka <jan.kiszka@web.de> writes:
>> 
>>> On 2017-01-23 15:19, Markus Armbruster wrote:
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> Hi,
>>>>>
>>>>> some of you may know that we are using a shared memory device similar to
>>>>> ivshmem in the partitioning hypervisor Jailhouse [1].
>>>>>
>>>>> We started as being compatible to the original ivshmem that QEMU
>>>>> implements, but we quickly deviated in some details, and in the recent
>>>>> months even more. Some of the deviations are related to making the
>>>>> implementation simpler. The new ivshmem takes <500 LoC - Jailhouse is
>>>>
>>>> Compare: hw/misc/ivshmem.c ~1000 SLOC, measured with sloccount.
>>>
>>> That difference comes from remote/migration support and general QEMU
>>> integration - likely not very telling due to the different environments.
>> 
>> Plausible.
>> 
>>>>> aiming at safety critical systems and, therefore, a small code base.
>>>>> Other changes address deficits in the original design, like missing
>>>>> life-cycle management.
>>>>>
>>>>> Now the question is if there is interest in defining a common new
>>>>> revision of this device and maybe also of some protocols used on top,
>>>>> such as virtual network links. Ideally, this would enable us to share
>>>>> Linux drivers. We will definitely go for upstreaming at least a network
>>>>> driver such as [2], a UIO driver and maybe also a serial port/console.
>>>>>
>>>>> I've attached a first draft of the specification of our new ivshmem
>>>>> device. A working implementation can be found in the wip/ivshmem2 branch
>>>>> of Jailhouse [3], the corresponding ivshmem-net driver in [4].
>>>>>
>>>>> Deviations from the original design:
>>>>>
>>>>> - Only two peers per link
>>>>
>>>> Uh, define "link".
>>>
>>> VMs are linked via a common shared memory. Interrupt delivery follows
>>> that route as well.
>>>
>>>>
>>>>>   This simplifies the implementation and also the interfaces (think of
>>>>>   life-cycle management in a multi-peer environment). Moreover, we do
>>>>>   not have an urgent use case for multiple peers, thus also not
>>>>>   reference for a protocol that could be used in such setups. If someone
>>>>>   else happens to share such a protocol, it would be possible to discuss
>>>>>   potential extensions and their implications.
>>>>>
>>>>> - Side-band registers to discover and configure share memory regions
>>>>>
>>>>>   This was one of the first changes: We removed the memory regions from
>>>>>   the PCI BARs and gave them special configuration space registers. By
>>>>>   now, these registers are embedded in a PCI capability. The reasons are
>>>>>   that Jailhouse does not allow to relocate the regions in guest address
>>>>>   space (but other hypervisors may if they like to) and that we now have
>>>>>   up to three of them.
>>>>
>>>> I'm afraid I don't quite understand the change, nor the rationale.  I
>>>> guess I could figure out the former by studying the specification.
>>>
>>> a) It's a Jailhouse thing (we disallow the guest to move the regions
>>>    around in its address space)
>>> b) With 3 regions + MSI-X + MMIO registers, we run out of BARs (or
>>>    would have to downgrade them to 32 bit)
>> 
>> Have you considered putting your three shared memory regions in memory
>> consecutively, so they can be covered by a single BAR?  Similar to how a
>> single BAR covers both MSI-X table and PBA.
>
> Would still require to pass three times some size information (each
> region can be different or empty/non-existent).

Yes.  Precedence: location of MSI-X table and PBA are specified in the
MSI-X Capability Structure as offset and BIR.

>                                                 Moreover, a) is not
> possible then without ugly modifications to the guest because they
> expect BAR-based regions to be relocatable.

Can you explain why not letting the guest map the shared memory into its
address space on its own just like any other piece of device memory is a
requirement?

>>>>> - Changed PCI base class code to 0xff (unspecified class)
>>>>
>>>> Changed from 0x5 (memory controller).
>>>
>>> Right.
>>>
>>>>
>>>>>   This allows us to define our own sub classes and interfaces. That is
>>>>>   now exploited for specifying the shared memory protocol the two
>>>>>   connected peers should use. It also allows the Linux drivers to match
>>>>>   on that.
>>>>>
>>>>> - INTx interrupts support is back
>>>>>
>>>>>   This is needed on target platforms without MSI controllers, i.e.
>>>>>   without the required guest support. Namely some PCI-less ARM SoCs
>>>>>   required the reintroduction. While doing this, we also took care of
>>>>>   keeping the MMIO registers free of privileged controls so that a
>>>>>   guest OS can map them safely into a guest userspace application.
>>>>
>>>> So you need interrupt capability.  Current upstream ivshmem requires a
>>>> server such as the one in contrib/ivshmem-server/.  What about yours?
>>>
>>> IIRC, the need for a server with QEMU/KVM is related to live migration.
>>> Jailhouse is simpler, all guests are managed by the same hypervisor
>>> instance, and there is no migration. That makes interrupt delivery much
>>> simpler as well. However, the device spec should not exclude other
>>> architectures.
>> 
>> The server doesn't really help with live migration.  It's used to dole
>> out file descriptors for shared memory and interrupt signalling, and to
>> notify of peer connect/disconnect.
>
> That should be solvable directly between two peers.

Even between multiple peers, but it might complicate the peers.

Note that the current ivshmem client-server protocol doesn't support
graceful recovery from a server crash.  The clients can hobble on with
reduced functionality, though (see ivshmem-spec.txt).  Live migration
could be a way to recover, if the application permits it.

>>>> The interrupt feature enables me to guess a definition of "link": A and
>>>> B are peers of the same link if they can interrupt each other.
>>>>
>>>> Does your ivshmem2 support interrupt-less operation similar to
>>>> ivshmem-plain?
>>>
>>> Each receiver of interrupts is free to enable that - or leave it off as
>>> it is the default after reset. But currently the spec demands that
>>> either MSI-X or INTx is reported as available to the guests. We could
>>> extend it to permit reporting no interrupts support if there is a good
>>> case for it.
>> 
>> I think the case for interrupt-incapable ivshmem-plain is that
>> interrupt-capable ivshmem-doorbell requires a server, and is therefore a
>> bit more complex to set up, and has additional failure modes.
>> 
>> If that wasn't the case, a single device variant would make more sense.
>> 
>> Besides, contrib/ivshmem-server/ is not fit for production use.
>> 
>>> I will have to look into the details of the client-server structure of
>>> QEMU's ivshmem again to answer the question under with restriction we
>>> can make it both simpler and more robust. As Jailhouse has no live
>>> migration support, requirements on ivshmem related to that may only be
>>> addressed by chance so far.
>> 
>> Here's how live migration works with QEMU's ivshmem: exactly one peer
>> (the "master") migrates with its ivshmem device, all others need to hot
>> unplug ivshmem, migrate, hot plug it back after the master completed its
>> migration.  The master connects to the new server on the destination on
>> startup, then live migration copies over the shared memory.  The other
>> peers connect to the new server when they get their ivshmem hot plugged
>> again.
>
> OK, hot-plug is a simple answer to this problem. It would be even
> cleaner to support from the guest POV with the new state signalling
> mechanism of ivshmem2.

Yes, proper state signalling should make this cleaner.  Without it,
every protocol built on top of ivshmem needs to come up with its own
state signalling.  The robustness problems should be obvious.

This is one aspect of my objection to the idea "just share some memory,
it's simple": it's not a protocol.  It's at best a building block for
protocols.

With ivshmem-doorbell, peers get notified of connects and disconnects.
However, the device can't notify guest software.  Fixable with
additional registers and an interrupt.

The design of ivshmem-plain has peers knowing nothing about their peers,
so a fix would require a redesign.

[...]
