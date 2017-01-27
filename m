Received: from eggs.gnu.org ([2001:4830:134:3::10]:56007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cXCJk-0006Sf-5X
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 14:36:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cXCJg-0006Lu-Vz
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 14:36:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cXCJg-0006Lh-NA
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 14:36:12 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<874m0peu50.fsf@dusky.pond.sub.org>
	<533e0b17-4d60-a584-5680-559834013c68@web.de>
Date: Fri, 27 Jan 2017 20:36:09 +0100
In-Reply-To: <533e0b17-4d60-a584-5680-559834013c68@web.de> (Jan Kiszka's
	message of "Wed, 25 Jan 2017 10:18:43 +0100")
Message-ID: <87inp05m8m.fsf@dusky.pond.sub.org>
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

> On 2017-01-23 15:19, Markus Armbruster wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> Hi,
>>>
>>> some of you may know that we are using a shared memory device similar to
>>> ivshmem in the partitioning hypervisor Jailhouse [1].
>>>
>>> We started as being compatible to the original ivshmem that QEMU
>>> implements, but we quickly deviated in some details, and in the recent
>>> months even more. Some of the deviations are related to making the
>>> implementation simpler. The new ivshmem takes <500 LoC - Jailhouse is
>> 
>> Compare: hw/misc/ivshmem.c ~1000 SLOC, measured with sloccount.
>
> That difference comes from remote/migration support and general QEMU
> integration - likely not very telling due to the different environments.

Plausible.

>>> aiming at safety critical systems and, therefore, a small code base.
>>> Other changes address deficits in the original design, like missing
>>> life-cycle management.
>>>
>>> Now the question is if there is interest in defining a common new
>>> revision of this device and maybe also of some protocols used on top,
>>> such as virtual network links. Ideally, this would enable us to share
>>> Linux drivers. We will definitely go for upstreaming at least a network
>>> driver such as [2], a UIO driver and maybe also a serial port/console.
>>>
>>> I've attached a first draft of the specification of our new ivshmem
>>> device. A working implementation can be found in the wip/ivshmem2 branch
>>> of Jailhouse [3], the corresponding ivshmem-net driver in [4].
>>>
>>> Deviations from the original design:
>>>
>>> - Only two peers per link
>> 
>> Uh, define "link".
>
> VMs are linked via a common shared memory. Interrupt delivery follows
> that route as well.
>
>> 
>>>   This simplifies the implementation and also the interfaces (think of
>>>   life-cycle management in a multi-peer environment). Moreover, we do
>>>   not have an urgent use case for multiple peers, thus also not
>>>   reference for a protocol that could be used in such setups. If someone
>>>   else happens to share such a protocol, it would be possible to discuss
>>>   potential extensions and their implications.
>>>
>>> - Side-band registers to discover and configure share memory regions
>>>
>>>   This was one of the first changes: We removed the memory regions from
>>>   the PCI BARs and gave them special configuration space registers. By
>>>   now, these registers are embedded in a PCI capability. The reasons are
>>>   that Jailhouse does not allow to relocate the regions in guest address
>>>   space (but other hypervisors may if they like to) and that we now have
>>>   up to three of them.
>> 
>> I'm afraid I don't quite understand the change, nor the rationale.  I
>> guess I could figure out the former by studying the specification.
>
> a) It's a Jailhouse thing (we disallow the guest to move the regions
>    around in its address space)
> b) With 3 regions + MSI-X + MMIO registers, we run out of BARs (or
>    would have to downgrade them to 32 bit)

Have you considered putting your three shared memory regions in memory
consecutively, so they can be covered by a single BAR?  Similar to how a
single BAR covers both MSI-X table and PBA.

>>> - Changed PCI base class code to 0xff (unspecified class)
>> 
>> Changed from 0x5 (memory controller).
>
> Right.
>
>> 
>>>   This allows us to define our own sub classes and interfaces. That is
>>>   now exploited for specifying the shared memory protocol the two
>>>   connected peers should use. It also allows the Linux drivers to match
>>>   on that.
>>>
>>> - INTx interrupts support is back
>>>
>>>   This is needed on target platforms without MSI controllers, i.e.
>>>   without the required guest support. Namely some PCI-less ARM SoCs
>>>   required the reintroduction. While doing this, we also took care of
>>>   keeping the MMIO registers free of privileged controls so that a
>>>   guest OS can map them safely into a guest userspace application.
>> 
>> So you need interrupt capability.  Current upstream ivshmem requires a
>> server such as the one in contrib/ivshmem-server/.  What about yours?
>
> IIRC, the need for a server with QEMU/KVM is related to live migration.
> Jailhouse is simpler, all guests are managed by the same hypervisor
> instance, and there is no migration. That makes interrupt delivery much
> simpler as well. However, the device spec should not exclude other
> architectures.

The server doesn't really help with live migration.  It's used to dole
out file descriptors for shared memory and interrupt signalling, and to
notify of peer connect/disconnect.

>> The interrupt feature enables me to guess a definition of "link": A and
>> B are peers of the same link if they can interrupt each other.
>> 
>> Does your ivshmem2 support interrupt-less operation similar to
>> ivshmem-plain?
>
> Each receiver of interrupts is free to enable that - or leave it off as
> it is the default after reset. But currently the spec demands that
> either MSI-X or INTx is reported as available to the guests. We could
> extend it to permit reporting no interrupts support if there is a good
> case for it.

I think the case for interrupt-incapable ivshmem-plain is that
interrupt-capable ivshmem-doorbell requires a server, and is therefore a
bit more complex to set up, and has additional failure modes.

If that wasn't the case, a single device variant would make more sense.

Besides, contrib/ivshmem-server/ is not fit for production use.

> I will have to look into the details of the client-server structure of
> QEMU's ivshmem again to answer the question under with restriction we
> can make it both simpler and more robust. As Jailhouse has no live
> migration support, requirements on ivshmem related to that may only be
> addressed by chance so far.

Here's how live migration works with QEMU's ivshmem: exactly one peer
(the "master") migrates with its ivshmem device, all others need to hot
unplug ivshmem, migrate, hot plug it back after the master completed its
migration.  The master connects to the new server on the destination on
startup, then live migration copies over the shared memory.  The other
peers connect to the new server when they get their ivshmem hot plugged
again.

>>> And then there are some extensions of the original ivshmem:
>>>
>>> - Multiple shared memory regions, including unidirectional ones
>>>
>>>   It is now possible to expose up to three different shared memory
>>>   regions: The first one is read/writable for both sides. The second
>>>   region is read/writable for the local peer and read-only for the
>>>   remote peer (useful for output queues). And the third is read-only
>>>   locally but read/writable remotely (ie. for input queues).
>>>   Unidirectional regions prevent that the receiver of some data can
>>>   interfere with the sender while it is still building the message, a
>>>   property that is not only useful for safety critical communication,
>>>   we are sure.
>>>
>>> - Life-cycle management via local and remote state
>>>
>>>   Each device can now signal its own state in form of a value to the
>>>   remote side, which triggers an event there.
>> 
>> How are "events" related to interrupts?
>
> Confusing term chosen here: an interrupt is triggered on the remote side
> (if it has interrupts enabled).

Got it.

>>>                                               Moreover, state changes
>>>   done by the hypervisor to one peer are signalled to the other side.
>>>   And we introduced a write-to-shared-memory mechanism for the
>>>   respective remote state so that guests do not have to issue an MMIO
>>>   access in order to check the state.
>>>
>>> So, this is our proposal. Would be great to hear some opinions if you
>>> see value in adding support for such an "ivshmem 2.0" device to QEMU as
>>> well and expand its ecosystem towards Linux upstream, maybe also DPDK
>>> again. If you see problems in the new design /wrt what QEMU provides so
>>> far with its ivshmem device, let's discuss how to resolve them. Looking
>>> forward to any feedback!
>> 
>> My general opinion on ivshmem is well-known, but I repeat it for the
>> record: merging it was a mistake, and using it is probably a mistake.  I
>> detailed my concerns in "Why I advise against using ivshmem"[*].
>> 
>> My philosophical concerns remain.  Perhaps you can assuage them.
>> 
>> Only some of my practical concerns have since been addressed.  In part
>> by myself, because having a flawed implementation of a bad idea is
>> strictly worse than the same with flaws corrected as far as practical.
>> But even today, docs/specs/ivshmem-spec.txt is a rather depressing read.
>
> I agree.
>
>> 
>> However, there's one thing that's still worse than a more or less flawed
>> implementation of a bad idea: two implementations of a bad idea.  Could
>> ivshmem2 be done in a way that permits *replacing* ivshmem?
>
> If people see the need for having a common ivshmem2, that should of
> course be designed to replace the original version of QEMU. I wouldn't
> like to design it being backward compatible, but the new version should
> provide all useful and required features of the old one.

Nobody likes to provide backward compability, but everybody likes to
take advantage of it :)

Seriously, I can't say whether feature parity would suffice, or whether
we need full backward compatibility.

> Of course, I'm careful with investing much time into expanding the
> existing, for Jailhouse possibly sufficient design if there no real
> interest in continuing the ivshmem support in QEMU - because of
> vhost-pci or other reasons. But if that interest exists, it would be
> beneficial for us to have QEMU supporting a compatible version and using
> the same guest drivers. Then I would start looking into concrete patches
> for it as well.

Interest is difficult for me to gauge, not least because alternatives
are still being worked on.

> Jan
>
>> 
>>> [1] https://github.com/siemens/jailhouse
>>> [2]
>>> http://git.kiszka.org/?p=linux.git;a=blob;f=drivers/net/ivshmem-net.c;h=0e770ca293a4aca14a55ac0e66871b09c82647af;hb=refs/heads/queues/jailhouse
>>> [3] https://github.com/siemens/jailhouse/commits/wip/ivshmem2
>>> [4]
>>> http://git.kiszka.org/?p=linux.git;a=shortlog;h=refs/heads/queues/jailhouse-ivshmem2
>> 
>> [*] http://lists.gnu.org/archive/html/qemu-devel/2014-06/msg02968.html
>> 
