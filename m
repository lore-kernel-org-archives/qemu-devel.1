Received: from eggs.gnu.org ([2001:4830:134:3::10]:51635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dWA1O-0005XZ-Bo
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dWA1J-0008DG-EJ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:29:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dWA1J-0008D2-5M
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:29:13 -0400
Date: Sat, 15 Jul 2017 02:29:09 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170715021021-mutt-send-email-mst@kernel.org>
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<20170714222705-mutt-send-email-mst@kernel.org>
	<71fd872e-ca59-169d-07fb-5e304713fa84@redhat.com>
	<20170715011517-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJZ2p_i-SCi-s5=-xcmg4wORv6B_7kjCyRGb5r8oDBWCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJZ2p_i-SCi-s5=-xcmg4wORv6B_7kjCyRGb5r8oDBWCQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/8] KASLR kernel dump support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dave Anderson <anderson@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On Sat, Jul 15, 2017 at 12:31:36AM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Sat, Jul 15, 2017 at 12:23 AM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> > On Fri, Jul 14, 2017 at 10:21:43PM +0200, Laszlo Ersek wrote:
> >> On 07/14/17 21:59, Michael S. Tsirkin wrote:
> >> > On Fri, Jul 14, 2017 at 08:20:03PM +0200, Marc-Andr=E9 Lureau wrot=
e:
> >> >> Recent linux kernels enable KASLR to randomize phys/virt memory
> >> >> addresses. This series aims to provide enough information in qemu
> >> >> dumps so that crash utility can work with randomized kernel too (=
it
> >> >> hasn't been tested on other archs than x86 though, help welcome).
> >> >>
> >> >> The vmcoreinfo device is an emulated ACPI device that exposes a 4=
k
> >> >> memory range to the guest to store various informations useful to
> >> >> debug the guest OS. (it is greatly inspired by the VMGENID device
> >> >> implementation). The version field with value 0 is meant to give
> >> >> paddr/size of the VMCOREINFO ELF PT_NOTE, other values can be use=
d for
> >> >> different purposes or OSes. (note: some wanted to see pvpanic som=
ehow
> >> >> merged with this device, I have no clear idea how to do that, nor=
 do I
> >> >> think this is a good idea since the devices are quite different, =
used
> >> >> at different time for different purposes. And it can be done as a
> >> >> future iteration if it is appropriate, feel free to send patches)
> >> >
> >> > First, I think you underestimate the difficulty of maintaining
> >> > compatibility.
> >> >
> >> > Second, this seems racy - how do you know when is guest done writi=
ng out
> >> > the data?
> >>
> >> What data exactly?
> >>
> >> The guest kernel module points the fields in the "vmcoreinfo page" t=
o
> >> the then-existent vmcoreinfo ELF note. At that point, the ELF note i=
s
> >> complete.
> >
> > When does this happen?
>=20
> Very early boot afaik. But the exact details on when to expose it is
> left to the kernel side. For now, it's a test module I load manually.
>=20
> >
> >> If we catch the guest with a dump request while the kernel module is
> >> setting up the fields (i.e., the fields are not consistent), then we=
'll
> >> catch that in our sanity checks, and the note won't be extracted.
> >
> > Are there assumptions about e.g. in which order pa and size
> > are written out then? Atomicity of these writes?
>=20
> I expect it to be atomic, but as Laszlo said, the code should be quite
> careful when trying to read the data.

Same when writing it out.  Worth documenting too.

> >
> >> This
> >> is no different from the case when you simply dump the guest RAM bef=
ore
> >> the module got invoked.
> >>
> >> > Given you have very little data to export (PA, size - do
> >> > you even need size?)
> >>
> >> Yes, it tells us in advance how much memory to allocate before we co=
py
> >> out the vmcoreinfo ELF note (and we enforce a sanity limit on the si=
ze).
> >>
> >> > - how about just using an ACPI method do it,
> >>
> >> Do what exactly?
> >
> > Pass address + size to host - that's what the interface is doing,
> > isn't it?
> >
>=20
>=20
> The memory region is meant to be usable for other OS, or to export
> more details in the future.

That's the issue. You will never be able to increment version
just to add more data because that will break old hypervisors.

> I think if we add a method, it would be to
> tell qemu that the memory has been written, but it may still be
> corrupted at the time we read it. So I am not sure it will really help

So don't. Just pass PA and size to method as arguments and let it figure
out how to pass it to QEMU. To extend, you will simply add another
method - which one is present tells you what does hypervisor
support, which one is called tells you what does guest support.

What to do there internally? I don't mind it if it sticks this data
in reserved memory like you did here. And then you won't need to
reserve a full 4K, just a couple of bytes as it will be safe to extend.

>=20
> >> > instead of exporting a physical addess and storing address there. =
 This
> >> > way you can add more methods as you add functionality.
> >>
> >> I'm not saying this is a bad idea (especially because I don't fully
> >> understand your point), but I will say that I'm quite sad that you a=
re
> >> sending Marc-Andr=E9 back to the drawing board after he posted v4 --=
 also
> >> invalidating my review efforts. :/
> >>
> >> Laszlo
> >
> > You are right, I should have looked at this sooner. Early RFC
> > suggested writing into fw cfg directly. I couldn't find any
> > discussion around this - why was this abandoned?
>=20
> Violation (or rather abuse) of layers iirc

Hmm.  I tried to find discussion about that and failed.  It is available
through QEMU0002 in ACPI - would it be OK if guests went through that?
I do not mind the extra indirection so much, but I don't think
host/guest interface compatibility issues are fully thought through.

>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
