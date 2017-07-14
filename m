Received: from eggs.gnu.org ([2001:4830:134:3::10]:40845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW8zv-0001j3-Vj
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 18:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW8zr-0004V1-3q
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 18:23:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dW8zq-0004UU-Qx
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 18:23:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7096E7A195
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 22:23:37 +0000 (UTC)
Date: Sat, 15 Jul 2017 01:23:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170715011517-mutt-send-email-mst@kernel.org>
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<20170714222705-mutt-send-email-mst@kernel.org>
	<71fd872e-ca59-169d-07fb-5e304713fa84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <71fd872e-ca59-169d-07fb-5e304713fa84@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, anderson@redhat.com, imammedo@redhat.com

On Fri, Jul 14, 2017 at 10:21:43PM +0200, Laszlo Ersek wrote:
> On 07/14/17 21:59, Michael S. Tsirkin wrote:
> > On Fri, Jul 14, 2017 at 08:20:03PM +0200, Marc-Andr=E9 Lureau wrote:
> >> Recent linux kernels enable KASLR to randomize phys/virt memory
> >> addresses. This series aims to provide enough information in qemu
> >> dumps so that crash utility can work with randomized kernel too (it
> >> hasn't been tested on other archs than x86 though, help welcome).
> >>
> >> The vmcoreinfo device is an emulated ACPI device that exposes a 4k
> >> memory range to the guest to store various informations useful to
> >> debug the guest OS. (it is greatly inspired by the VMGENID device
> >> implementation). The version field with value 0 is meant to give
> >> paddr/size of the VMCOREINFO ELF PT_NOTE, other values can be used f=
or
> >> different purposes or OSes. (note: some wanted to see pvpanic someho=
w
> >> merged with this device, I have no clear idea how to do that, nor do=
 I
> >> think this is a good idea since the devices are quite different, use=
d
> >> at different time for different purposes. And it can be done as a
> >> future iteration if it is appropriate, feel free to send patches)
> >=20
> > First, I think you underestimate the difficulty of maintaining
> > compatibility.
> >=20
> > Second, this seems racy - how do you know when is guest done writing =
out
> > the data?
>=20
> What data exactly?
>=20
> The guest kernel module points the fields in the "vmcoreinfo page" to
> the then-existent vmcoreinfo ELF note. At that point, the ELF note is
> complete.

When does this happen?

> If we catch the guest with a dump request while the kernel module is
> setting up the fields (i.e., the fields are not consistent), then we'll
> catch that in our sanity checks, and the note won't be extracted.

Are there assumptions about e.g. in which order pa and size
are written out then? Atomicity of these writes?

> This
> is no different from the case when you simply dump the guest RAM before
> the module got invoked.
>=20
> > Given you have very little data to export (PA, size - do
> > you even need size?)
>=20
> Yes, it tells us in advance how much memory to allocate before we copy
> out the vmcoreinfo ELF note (and we enforce a sanity limit on the size)=
.
>=20
> > - how about just using an ACPI method do it,
>=20
> Do what exactly?

Pass address + size to host - that's what the interface is doing,
isn't it?

> > instead of exporting a physical addess and storing address there.  Th=
is
> > way you can add more methods as you add functionality.
>=20
> I'm not saying this is a bad idea (especially because I don't fully
> understand your point), but I will say that I'm quite sad that you are
> sending Marc-Andr=E9 back to the drawing board after he posted v4 -- al=
so
> invalidating my review efforts. :/
>=20
> Laszlo

You are right, I should have looked at this sooner. Early RFC
suggested writing into fw cfg directly. I couldn't find any
discussion around this - why was this abandoned?

--=20
MST
