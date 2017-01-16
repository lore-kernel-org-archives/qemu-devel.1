Received: from eggs.gnu.org ([2001:4830:134:3::10]:55781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cT6bS-0008Bo-VM
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cT6bQ-0001i1-Jf
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:41:39 -0500
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:35657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cT6bQ-0001hq-Do
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:41:36 -0500
Received: by mail-yw0-x243.google.com with SMTP id 17so8641504ywk.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 04:41:36 -0800 (PST)
MIME-Version: 1.0
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
In-Reply-To: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Jan 2017 12:41:24 +0000
Message-ID: <CAJ+F1C+WV7OhxpYb3RgmtRjXU7_kfygr2jh2cawYwZq8MMrJGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Towards an ivshmem 2.0?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Jailhouse <jailhouse-dev@googlegroups.com>
Cc: Wei Wang <wei.w.wang@intel.com>, Markus Armbruster <armbru@redhat.com>

Hi

On Mon, Jan 16, 2017 at 12:37 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Hi,
>
> some of you may know that we are using a shared memory device similar to
> ivshmem in the partitioning hypervisor Jailhouse [1].
>
> We started as being compatible to the original ivshmem that QEMU
> implements, but we quickly deviated in some details, and in the recent
> months even more. Some of the deviations are related to making the
> implementation simpler. The new ivshmem takes <500 LoC - Jailhouse is
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
>
This sounds like duplicating efforts done with virtio and vhost-pci. Have
you looked at Wei Wang proposal?

I've attached a first draft of the specification of our new ivshmem
> device. A working implementation can be found in the wip/ivshmem2 branch
> of Jailhouse [3], the corresponding ivshmem-net driver in [4].
>

You don't have qemu branch, right?


>
> Deviations from the original design:
>
> - Only two peers per link
>
>
sound sane, that's also what vhost-pci aims to afaik


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
>

 Sorry, I can't comment on that.


> - Changed PCI base class code to 0xff (unspecified class)
>
>   This allows us to define our own sub classes and interfaces. That is
>   now exploited for specifying the shared memory protocol the two
>   connected peers should use. It also allows the Linux drivers to match
>   on that.
>
>
Why not, but it worries me that you are going to invent protocols similar
to virtio devices, aren't you?


> - INTx interrupts support is back
>
>   This is needed on target platforms without MSI controllers, i.e.
>   without the required guest support. Namely some PCI-less ARM SoCs
>   required the reintroduction. While doing this, we also took care of
>   keeping the MMIO registers free of privileged controls so that a
>   guest OS can map them safely into a guest userspace application.
>
>
Right, it's not completely removed from ivshmem qemu upstream, although it
should probably be allowed to setup a doorbell-ivshmem with msi=3Doff (this
may be quite trivial to add back)


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

Sounds like a good idea, and something we may want in virtio too

>
> - Life-cycle management via local and remote state
>
>   Each device can now signal its own state in form of a value to the
>   remote side, which triggers an event there. Moreover, state changes
>   done by the hypervisor to one peer are signalled to the other side.
>   And we introduced a write-to-shared-memory mechanism for the
>   respective remote state so that guests do not have to issue an MMIO
>   access in order to check the state.
>

There is also ongoing work to better support disconnect/reconnect in
virtio.


>
> So, this is our proposal. Would be great to hear some opinions if you
> see value in adding support for such an "ivshmem 2.0" device to QEMU as
> well and expand its ecosystem towards Linux upstream, maybe also DPDK
> again. If you see problems in the new design /wrt what QEMU provides so
> far with its ivshmem device, let's discuss how to resolve them. Looking
> forward to any feedback!
>
>
My feeling is that ivshmem is not being actively developped in qemu, but
rather virtio-based solutions (vhost-pci for vm2vm).

Jan
>
> [1] https://github.com/siemens/jailhouse
> [2]
>
> http://git.kiszka.org/?p=3Dlinux.git;a=3Dblob;f=3Ddrivers/net/ivshmem-net=
.c;h=3D0e770ca293a4aca14a55ac0e66871b09c82647af;hb=3Drefs/heads/queues/jail=
house
> [3] https://github.com/siemens/jailhouse/commits/wip/ivshmem2
> [4]
>
> http://git.kiszka.org/?p=3Dlinux.git;a=3Dshortlog;h=3Drefs/heads/queues/j=
ailhouse-ivshmem2
>
> --
> Siemens AG, Corporate Technology, CT RDA ITP SES-DE
> Corporate Competence Center Embedded Linux
>
--=20
Marc-Andr=C3=A9 Lureau
