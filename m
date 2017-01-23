Received: from eggs.gnu.org ([2001:4830:134:3::10]:42037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVfT0-0005uK-8p
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:19:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVfSx-0004s1-4D
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:19:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cVfSw-0004ro-Rn
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:19:27 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
Date: Mon, 23 Jan 2017 15:19:23 +0100
In-Reply-To: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com> (Jan Kiszka's
	message of "Mon, 16 Jan 2017 09:36:51 +0100")
Message-ID: <874m0peu50.fsf@dusky.pond.sub.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jailhouse <jailhouse-dev@googlegroups.com>

Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi,
>
> some of you may know that we are using a shared memory device similar to
> ivshmem in the partitioning hypervisor Jailhouse [1].
>
> We started as being compatible to the original ivshmem that QEMU
> implements, but we quickly deviated in some details, and in the recent
> months even more. Some of the deviations are related to making the
> implementation simpler. The new ivshmem takes <500 LoC - Jailhouse is

Compare: hw/misc/ivshmem.c ~1000 SLOC, measured with sloccount.

> aiming at safety critical systems and, therefore, a small code base.
> Other changes address deficits in the original design, like missing
> life-cycle management.
>
> Now the question is if there is interest in defining a common new
> revision of this device and maybe also of some protocols used on top,
> such as virtual network links. Ideally, this would enable us to share
> Linux drivers. We will definitely go for upstreaming at least a network
> driver such as [2], a UIO driver and maybe also a serial port/console.
>
> I've attached a first draft of the specification of our new ivshmem
> device. A working implementation can be found in the wip/ivshmem2 branch
> of Jailhouse [3], the corresponding ivshmem-net driver in [4].
>
> Deviations from the original design:
>
> - Only two peers per link

Uh, define "link".

>   This simplifies the implementation and also the interfaces (think of
>   life-cycle management in a multi-peer environment). Moreover, we do
>   not have an urgent use case for multiple peers, thus also not
>   reference for a protocol that could be used in such setups. If someone
>   else happens to share such a protocol, it would be possible to discuss
>   potential extensions and their implications.
>
> - Side-band registers to discover and configure share memory regions
>
>   This was one of the first changes: We removed the memory regions from
>   the PCI BARs and gave them special configuration space registers. By
>   now, these registers are embedded in a PCI capability. The reasons are
>   that Jailhouse does not allow to relocate the regions in guest address
>   space (but other hypervisors may if they like to) and that we now have
>   up to three of them.

I'm afraid I don't quite understand the change, nor the rationale.  I
guess I could figure out the former by studying the specification.

> - Changed PCI base class code to 0xff (unspecified class)

Changed from 0x5 (memory controller).

>   This allows us to define our own sub classes and interfaces. That is
>   now exploited for specifying the shared memory protocol the two
>   connected peers should use. It also allows the Linux drivers to match
>   on that.
>
> - INTx interrupts support is back
>
>   This is needed on target platforms without MSI controllers, i.e.
>   without the required guest support. Namely some PCI-less ARM SoCs
>   required the reintroduction. While doing this, we also took care of
>   keeping the MMIO registers free of privileged controls so that a
>   guest OS can map them safely into a guest userspace application.

So you need interrupt capability.  Current upstream ivshmem requires a
server such as the one in contrib/ivshmem-server/.  What about yours?

The interrupt feature enables me to guess a definition of "link": A and
B are peers of the same link if they can interrupt each other.

Does your ivshmem2 support interrupt-less operation similar to
ivshmem-plain?

> And then there are some extensions of the original ivshmem:
>
> - Multiple shared memory regions, including unidirectional ones
>
>   It is now possible to expose up to three different shared memory
>   regions: The first one is read/writable for both sides. The second
>   region is read/writable for the local peer and read-only for the
>   remote peer (useful for output queues). And the third is read-only
>   locally but read/writable remotely (ie. for input queues).
>   Unidirectional regions prevent that the receiver of some data can
>   interfere with the sender while it is still building the message, a
>   property that is not only useful for safety critical communication,
>   we are sure.
>
> - Life-cycle management via local and remote state
>
>   Each device can now signal its own state in form of a value to the
>   remote side, which triggers an event there.

How are "events" related to interrupts?

>                                               Moreover, state changes
>   done by the hypervisor to one peer are signalled to the other side.
>   And we introduced a write-to-shared-memory mechanism for the
>   respective remote state so that guests do not have to issue an MMIO
>   access in order to check the state.
>
> So, this is our proposal. Would be great to hear some opinions if you
> see value in adding support for such an "ivshmem 2.0" device to QEMU as
> well and expand its ecosystem towards Linux upstream, maybe also DPDK
> again. If you see problems in the new design /wrt what QEMU provides so
> far with its ivshmem device, let's discuss how to resolve them. Looking
> forward to any feedback!

My general opinion on ivshmem is well-known, but I repeat it for the
record: merging it was a mistake, and using it is probably a mistake.  I
detailed my concerns in "Why I advise against using ivshmem"[*].

My philosophical concerns remain.  Perhaps you can assuage them.

Only some of my practical concerns have since been addressed.  In part
by myself, because having a flawed implementation of a bad idea is
strictly worse than the same with flaws corrected as far as practical.
But even today, docs/specs/ivshmem-spec.txt is a rather depressing read.

However, there's one thing that's still worse than a more or less flawed
implementation of a bad idea: two implementations of a bad idea.  Could
ivshmem2 be done in a way that permits *replacing* ivshmem?

> [1] https://github.com/siemens/jailhouse
> [2]
> http://git.kiszka.org/?p=linux.git;a=blob;f=drivers/net/ivshmem-net.c;h=0e770ca293a4aca14a55ac0e66871b09c82647af;hb=refs/heads/queues/jailhouse
> [3] https://github.com/siemens/jailhouse/commits/wip/ivshmem2
> [4]
> http://git.kiszka.org/?p=linux.git;a=shortlog;h=refs/heads/queues/jailhouse-ivshmem2

[*] http://lists.gnu.org/archive/html/qemu-devel/2014-06/msg02968.html
