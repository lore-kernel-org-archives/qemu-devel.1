Received: from eggs.gnu.org ([2001:4830:134:3::10]:34756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1cT73Q-00007o-1y
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1cT73K-00030z-Ux
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:10:32 -0500
Received: from goliath.siemens.de ([192.35.17.28]:52738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1cT73K-00030b-JI
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:10:26 -0500
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<CAJ+F1C+WV7OhxpYb3RgmtRjXU7_kfygr2jh2cawYwZq8MMrJGQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <79bc9757-3ba0-87c3-3502-a25a30e304a3@siemens.com>
Date: Mon, 16 Jan 2017 14:10:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+WV7OhxpYb3RgmtRjXU7_kfygr2jh2cawYwZq8MMrJGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Jailhouse <jailhouse-dev@googlegroups.com>
Cc: Wei Wang <wei.w.wang@intel.com>, Markus Armbruster <armbru@redhat.com>

Hi Marc-Andr=C3=A9,

On 2017-01-16 13:41, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Jan 16, 2017 at 12:37 PM Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
>=20
>     Hi,
>=20
>     some of you may know that we are using a shared memory device simil=
ar to
>     ivshmem in the partitioning hypervisor Jailhouse [1].
>=20
>     We started as being compatible to the original ivshmem that QEMU
>     implements, but we quickly deviated in some details, and in the rec=
ent
>     months even more. Some of the deviations are related to making the
>     implementation simpler. The new ivshmem takes <500 LoC - Jailhouse =
is
>     aiming at safety critical systems and, therefore, a small code base.
>     Other changes address deficits in the original design, like missing
>     life-cycle management.
>=20
>     Now the question is if there is interest in defining a common new
>     revision of this device and maybe also of some protocols used on to=
p,
>     such as virtual network links. Ideally, this would enable us to sha=
re
>     Linux drivers. We will definitely go for upstreaming at least a net=
work
>     driver such as [2], a UIO driver and maybe also a serial port/conso=
le.
>=20
>=20
> This sounds like duplicating efforts done with virtio and vhost-pci.
> Have you looked at Wei Wang proposal?

I didn't follow it recently, but the original concept was about
introducing an IOMMU model to the picture, and that's complexity-wise a
no-go for us (we can do this whole thing in less than 500 lines, even
virtio itself is more complex). IIUC, the alternative to an IOMMU is
mapping the whole frontend VM memory into the backend VM - that's
security/safety-wise an absolute no-go.

>=20
>     I've attached a first draft of the specification of our new ivshmem
>     device. A working implementation can be found in the wip/ivshmem2 b=
ranch
>     of Jailhouse [3], the corresponding ivshmem-net driver in [4].
>=20
>=20
> You don't have qemu branch, right?

Yes, not yet. I would look into creating a QEMU device model if there is
serious interest.

> =20
>=20
>=20
>     Deviations from the original design:
>=20
>     - Only two peers per link
>=20
>=20
> sound sane, that's also what vhost-pci aims to afaik
> =20
>=20
>       This simplifies the implementation and also the interfaces (think=
 of
>       life-cycle management in a multi-peer environment). Moreover, we =
do
>       not have an urgent use case for multiple peers, thus also not
>       reference for a protocol that could be used in such setups. If so=
meone
>       else happens to share such a protocol, it would be possible to di=
scuss
>       potential extensions and their implications.
>=20
>     - Side-band registers to discover and configure share memory region=
s
>=20
>       This was one of the first changes: We removed the memory regions =
from
>       the PCI BARs and gave them special configuration space registers.=
 By
>       now, these registers are embedded in a PCI capability. The reason=
s are
>       that Jailhouse does not allow to relocate the regions in guest ad=
dress
>       space (but other hypervisors may if they like to) and that we now=
 have
>       up to three of them.
>=20
>=20
>  Sorry, I can't comment on that.
>=20
>=20
>     - Changed PCI base class code to 0xff (unspecified class)
>=20
>       This allows us to define our own sub classes and interfaces. That=
 is
>       now exploited for specifying the shared memory protocol the two
>       connected peers should use. It also allows the Linux drivers to m=
atch
>       on that.
>=20
>=20
> Why not, but it worries me that you are going to invent protocols
> similar to virtio devices, aren't you?

That partly comes with the desire to simplify the transport (pure shared
memory). With ivshmem-net, we are at least reusing virtio rings and will
try to do this with the new (and faster) virtio ring format as well.

> =20
>=20
>     - INTx interrupts support is back
>=20
>       This is needed on target platforms without MSI controllers, i.e.
>       without the required guest support. Namely some PCI-less ARM SoCs
>       required the reintroduction. While doing this, we also took care =
of
>       keeping the MMIO registers free of privileged controls so that a
>       guest OS can map them safely into a guest userspace application.
>=20
>=20
> Right, it's not completely removed from ivshmem qemu upstream, although
> it should probably be allowed to setup a doorbell-ivshmem with msi=3Dof=
f
> (this may be quite trivial to add back)
> =20
>=20
>     And then there are some extensions of the original ivshmem:
>=20
>     - Multiple shared memory regions, including unidirectional ones
>=20
>       It is now possible to expose up to three different shared memory
>       regions: The first one is read/writable for both sides. The secon=
d
>       region is read/writable for the local peer and read-only for the
>       remote peer (useful for output queues). And the third is read-onl=
y
>       locally but read/writable remotely (ie. for input queues).
>       Unidirectional regions prevent that the receiver of some data can
>       interfere with the sender while it is still building the message,=
 a
>       property that is not only useful for safety critical communicatio=
n,
>       we are sure.
>=20
>=20
> Sounds like a good idea, and something we may want in virtio too
>=20
>=20
>     - Life-cycle management via local and remote state
>=20
>       Each device can now signal its own state in form of a value to th=
e
>       remote side, which triggers an event there. Moreover, state chang=
es
>       done by the hypervisor to one peer are signalled to the other sid=
e.
>       And we introduced a write-to-shared-memory mechanism for the
>       respective remote state so that guests do not have to issue an MM=
IO
>       access in order to check the state.
>=20
>=20
> There is also ongoing work to better support disconnect/reconnect in
> virtio.
> =20
>=20
>=20
>     So, this is our proposal. Would be great to hear some opinions if y=
ou
>     see value in adding support for such an "ivshmem 2.0" device to QEM=
U as
>     well and expand its ecosystem towards Linux upstream, maybe also DP=
DK
>     again. If you see problems in the new design /wrt what QEMU provide=
s so
>     far with its ivshmem device, let's discuss how to resolve them. Loo=
king
>     forward to any feedback!
>=20
>=20
> My feeling is that ivshmem is not being actively developped in qemu, bu=
t
> rather virtio-based solutions (vhost-pci for vm2vm).

As pointed out, for us it's most important to keep the design simple -
even at the price of "reinventing" some drivers for upstream (at least,
we do not need two sets of drivers because our interface is fully
symmetric). I don't see yet how vhost-pci could achieve the same, but
I'm open to learn more!

Thanks,
Jan

>=20
>     Jan
>=20
>     [1] https://github.com/siemens/jailhouse
>     [2]
>     http://git.kiszka.org/?p=3Dlinux.git;a=3Dblob;f=3Ddrivers/net/ivshm=
em-net.c;h=3D0e770ca293a4aca14a55ac0e66871b09c82647af;hb=3Drefs/heads/que=
ues/jailhouse
>     [3] https://github.com/siemens/jailhouse/commits/wip/ivshmem2
>     [4]
>     http://git.kiszka.org/?p=3Dlinux.git;a=3Dshortlog;h=3Drefs/heads/qu=
eues/jailhouse-ivshmem2
>=20
>     --
>     Siemens AG, Corporate Technology, CT RDA ITP SES-DE
>     Corporate Competence Center Embedded Linux
>=20
> --=20
> Marc-Andr=C3=A9 Lureau

--=20
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
