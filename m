Received: from eggs.gnu.org ([2001:4830:134:3::10]:56830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anderson@redhat.com>) id 1dekJE-0007Ax-GO
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anderson@redhat.com>) id 1dekJ9-00054B-CM
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:51:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anderson@redhat.com>) id 1dekJ9-00051B-2Q
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:51:07 -0400
Date: Mon, 7 Aug 2017 11:44:29 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1399552535.41617312.1502120669060.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAJ+F1CLH6R7jfQNsTdeUyDB8JsNjvpK1eAcpviiLMwZtr07M_g@mail.gmail.com>
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<CAJ+F1CJW1pCqJMN3JmGunFKswNnR=J74+Z_m5Lj5WYT2Z1ZoPQ@mail.gmail.com>
	<20170715012551-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJP2DSo-khn+do0YG_ALDXrqBi6wEPH=m+W59rPfRTuiA@mail.gmail.com>
	<20170715023159-mutt-send-email-mst@kernel.org>
	<CAJ+F1C+F+HjHxzrq0usibfYUidpBW8DQUS72pDAv7xC6O14t3Q@mail.gmail.com>
	<20170726195844-mutt-send-email-mst@kernel.org>
	<CAJ+F1CLH6R7jfQNsTdeUyDB8JsNjvpK1eAcpviiLMwZtr07M_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/8] acpi: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>



----- Original Message -----
> Hi Dave
>=20
> On Wed, Jul 26, 2017 at 10:21 AM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > On Sat, Jul 15, 2017 at 01:47:50AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> >> >
> >> > There's more info scattered in other places.
> >> >
> >> > Why do you get to document it? Because you are the one exposing it
> >> > across the hypervisor/vm boundary where it will need to be
> >> > understood by people/tools not running within guest.
> >> >
> >> > So "just read the script in qemu source" is not how an interface
> >> > should be documented.
> >>
> >> I don't understand the issue, it's a kernel ELF note that qemu passes
> >> for dump/crash tools in the dump headers/sections.
> >
> > The way it looks to me, this patchset is exposing an internal kernel
> > detail and making it part of ABI maybe it already is, my point was 1.
> > should we get a confirmation from upstream it's not going to change? 2.
> > if it's ABI let's document what do we expect to be there.
>=20
>=20
> Could you help explain the expectations and stability guarantees of
> vmcoreinfo ELF note ?
>=20
> I am a bit stuck here, after all, vmcoreinfo is mostly used by crash
> so I thought you could help.

Sorry for the delay, I'm just back from vacation...

The vmcoreinfo string data is *primarily* used by the makedumpfile facility=
,
because it needs to find its way around the dumped kernel memory without ha=
ving
the the vmlinux file's debuginfo data when it's running in the second kerne=
l.

Since crash utilizes the vmlinux file, it only reads a small handful of=20
the vmcoreinfo items for things like phys_base that cannot be gleaned
from the vmlinux debuginfo data. =20

Anyway, I'm not sure what you mean by "expectations and stability guarantee=
s"?
It's just a block of ASCII string data of a given size that simply needs
to be transferred to the vmcore.  New strings may be added to it at any
time, but that shouldn't have any impact on what you're doing.

Dave
=20
=20
> The only thing qemu does with it is try to get NUMBER(phys_base)=3D
> field to update the phys_base used in the various dump headers. (this
> could be dropped, and qemu ignoring the note content, if the debug
> tools take vmcoreinfo values  with higher priority than other header
> fields)
>=20
> > But again since there's not a whole lot of documentation here
> > that you provided, I might be misunderstanding completely.
>=20
> Because there isn't much available in the kernel either, except
> Documentation/ABI/testing/sysfs-kernel-vmcoreinfo.
>=20
>=20
> --
> Marc-Andr=C3=A9 Lureau
>=20
