Received: from eggs.gnu.org ([2001:4830:134:3::10]:39604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5S3z-00007e-TB
	for qemu-devel@nongnu.org; Tue, 02 May 2017 03:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5S3v-0005qF-Ft
	for qemu-devel@nongnu.org; Tue, 02 May 2017 03:17:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d5S3v-0005pi-6U
	for qemu-devel@nongnu.org; Tue, 02 May 2017 03:17:31 -0400
Date: Tue, 2 May 2017 09:17:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170502091723.3a3b4e42@nial.brq.redhat.com>
In-Reply-To: <CAJ+F1CJPEZNUPrYseN3JD+gAtwJ-rLQVRBLdXTQVSwaBTdNGHA@mail.gmail.com>
References: <20170424130355.31324-1-marcandre.lureau@redhat.com>
	<CABdb736pFG7yK+C_J-WWRbX+e-bk62TejQ_GtObxyFmV5t350w@mail.gmail.com>
	<CAJ+F1CJPEZNUPrYseN3JD+gAtwJ-rLQVRBLdXTQVSwaBTdNGHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] RFC: vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Ladi Prosek <lprosek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, anderson@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, 28 Apr 2017 14:28:38 +0000
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Fri, Apr 28, 2017 at 6:12 PM Ladi Prosek <lprosek@redhat.com> wrote:
>=20
> > On Mon, Apr 24, 2017 at 3:03 PM, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote: =20
> > > The VM coreinfo (vmcoreinfo) device is an emulated device which
> > > exposes a 4k memory range to the guest to store various informations
> > > useful to debug the guest OS. (it is greatly inspired by the VMGENID
> > > device implementation)
> > >
> > > This is an early-boot alternative to the qemu-ga VMDUMP_INFO event
> > > proposed in "[PATCH 00/21] WIP: dump: add kaslr support".
> > >
> > > If deemed more appropriate, we can consider writing to fw_cfg directly
> > > instead of guest memory, now that qemu 2.9 supports it again.
> > >
> > > The proof-of-concept kernel module:
> > > https://github.com/elmarco/vmgenid-test/blob/master/qemuvmci-test.c =
=20
> >
> > Here's a proof-of-concept Windows driver:
> >
> > https://github.com/ladipro/kvm-guest-drivers-windows/tree/vmcoreinfo/vm=
coreinfo
> >
> > I just wanted to be sure that it's possible to evaluate the ADDR
> > method in Windows.
> >
> > From a practical point of view it is unfortunate that this would be a
> > completely new device. For Windows guests it means another driver
> > binary and all the overhead associated with deploying it on VMs. Would
> > it be too crazy to add this functionality to the pvpanic device? The
> > mechanics could stay the same but it would be done under the existing
> > ACPI\QEMU0001 device.
> > =20
>=20
> pvpanic is under _SB.PCI0.ISA, that could be problematic
>=20
> and _STA is a name field.
>=20
> Someone with more experience with ACPI could tell us if that make sense to
> merge both and how.
>=20
> Can't you handle 2 ACPI devices in the same windows driver instead?
we use QEMU0001 to reserve IO ports for pvpanic device,
ASL wise there shouldn't problems with adding _ADDR method to it

but then we probably should fold vmcoreinfo into pvpanic device
as well (QEMU and linux driver)

>=20
> > +Storage Format: =20
> > > +---------------
> > > +
> > > +The content is expected to use little-endian format.
> > > +
> > > +In order to implement an OVMF "SDT Header Probe Suppressor", the =20
> > contents of =20
> > > +the vmcoreinfo blob has 40 bytes of padding:
> > > +
> > > ++-----------------------------------+
> > > +| SSDT with OEM Table ID =3D VMCOREIN |
> > > ++-----------------------------------+
> > > +| ...                               |       TOP OF PAGE
> > > +| VCIA dword object ----------------|-----> =20
> > +---------------------------+ =20
> > > +| ...                               |       | fw-allocated array for=
 =20
> > | =20
> > > +| _STA method referring to VCIA     |       | "etc/vmcoreinfo" =20
> > | =20
> > > +| ...                               | =20
> >  +---------------------------+ =20
> > > +| ADDR method referring to VCIA     |       |  0: OVMF SDT Header pr=
obe =20
> > | =20
> > > +| ...                               |       |     suppressor =20
> > | =20
> > > ++-----------------------------------+       | 40: uint32 version fie=
ld =20
> > | =20
> > > +                                            | 44: info contents =20
> >  | =20
> > > +                                            |     .... =20
> > | =20
> > > + =20
> > +---------------------------+ =20
> > > +                                            END OF PAGE
> > > +
> > > +Version 0 content:
> > > +
> > > + uint64 paddr:
> > > +  Physical address of the Linux vmcoreinfo ELF note. =20
> >
> > Or physical address of the Windows crash dump header :p
> > =20
>=20
> Is there support for Windows crash dump in qemu?
>=20
>=20
> > Do we want to have an additional discriminator field to tell what kind
> > of information was written by the guest or would Windows use a
> > different version?
> >
> > =20
> I guess a different version would be ok.
>=20
> Thanks a lot for looking at it!
