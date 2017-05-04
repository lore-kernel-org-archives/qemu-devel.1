Received: from eggs.gnu.org ([2001:4830:134:3::10]:51259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6H0O-0000A2-5Q
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6H0L-0000cG-2W
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:41:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d6H0K-0000bQ-PC
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:41:13 -0400
Date: Thu, 4 May 2017 15:41:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170504154103.69a8eaa8@nial.brq.redhat.com>
In-Reply-To: <CAJ+F1CJ-tvPdX1QLYKWg6M_cattYcBDO25Hfp+rfBpnCZbwFtA@mail.gmail.com>
References: <20170424130355.31324-1-marcandre.lureau@redhat.com>
	<CABdb736pFG7yK+C_J-WWRbX+e-bk62TejQ_GtObxyFmV5t350w@mail.gmail.com>
	<CAJ+F1CJPEZNUPrYseN3JD+gAtwJ-rLQVRBLdXTQVSwaBTdNGHA@mail.gmail.com>
	<20170502091723.3a3b4e42@nial.brq.redhat.com>
	<CAJ+F1CJ-tvPdX1QLYKWg6M_cattYcBDO25Hfp+rfBpnCZbwFtA@mail.gmail.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ladi Prosek <lprosek@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, anderson@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 02 May 2017 19:03:15 +0000
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Tue, May 2, 2017 at 11:17 AM Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > On Fri, 28 Apr 2017 14:28:38 +0000
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> > =20
> > > Hi
> > >
> > > On Fri, Apr 28, 2017 at 6:12 PM Ladi Prosek <lprosek@redhat.com> wrot=
e:
> > > =20
> > > > On Mon, Apr 24, 2017 at 3:03 PM, Marc-Andr=C3=A9 Lureau
> > > > <marcandre.lureau@redhat.com> wrote: =20
> > > > > The VM coreinfo (vmcoreinfo) device is an emulated device which
> > > > > exposes a 4k memory range to the guest to store various informati=
ons
> > > > > useful to debug the guest OS. (it is greatly inspired by the VMGE=
NID
> > > > > device implementation)
> > > > >
> > > > > This is an early-boot alternative to the qemu-ga VMDUMP_INFO event
> > > > > proposed in "[PATCH 00/21] WIP: dump: add kaslr support".
> > > > >
> > > > > If deemed more appropriate, we can consider writing to fw_cfg =20
> > directly =20
> > > > > instead of guest memory, now that qemu 2.9 supports it again.
> > > > >
> > > > > The proof-of-concept kernel module:
> > > > > https://github.com/elmarco/vmgenid-test/blob/master/qemuvmci-test=
.c =20
> > > >
> > > > Here's a proof-of-concept Windows driver:
> > > >
> > > > =20
> > https://github.com/ladipro/kvm-guest-drivers-windows/tree/vmcoreinfo/vm=
coreinfo =20
> > > >
> > > > I just wanted to be sure that it's possible to evaluate the ADDR
> > > > method in Windows.
> > > >
> > > > From a practical point of view it is unfortunate that this would be=
 a
> > > > completely new device. For Windows guests it means another driver
> > > > binary and all the overhead associated with deploying it on VMs. Wo=
uld
> > > > it be too crazy to add this functionality to the pvpanic device? The
> > > > mechanics could stay the same but it would be done under the existi=
ng
> > > > ACPI\QEMU0001 device.
> > > > =20
> > >
> > > pvpanic is under _SB.PCI0.ISA, that could be problematic
> > >
> > > and _STA is a name field.
> > >
> > > Someone with more experience with ACPI could tell us if that make sen=
se =20
> > to =20
> > > merge both and how.
> > >
> > > Can't you handle 2 ACPI devices in the same windows driver instead? =
=20
> > we use QEMU0001 to reserve IO ports for pvpanic device,
> > ASL wise there shouldn't problems with adding _ADDR method to it
> >
> > but then we probably should fold vmcoreinfo into pvpanic device
> > as well (QEMU and linux driver)
> >
> > =20
> pvpanic is x86-only afaict.
There is nothing that forces it to be x86 specific (beside being ISA device=
),
ARM also can benefit from/use pvpanic if you make it pci device or just pla=
in
Device.

> While I think vmcoreinfo would work fine with
> any acpi-able arch.
I don't insist on it but it's worth a try, probably a lot of code could be
shared between both (including AML part/which makes DSDT smaller little bit)


> I think I would rather modify the windows driver to support both pvpanic &
> vmcoreinfo, even if it's not typical for driver to implement several
> devices.
>=20
> > =20
> > > > +Storage Format: =20
> > > > > +---------------
> > > > > +
> > > > > +The content is expected to use little-endian format.
> > > > > +
> > > > > +In order to implement an OVMF "SDT Header Probe Suppressor", the=
 =20
> > > > contents of =20
> > > > > +the vmcoreinfo blob has 40 bytes of padding:
> > > > > +
> > > > > ++-----------------------------------+
> > > > > +| SSDT with OEM Table ID =3D VMCOREIN |
> > > > > ++-----------------------------------+
> > > > > +| ...                               |       TOP OF PAGE
> > > > > +| VCIA dword object ----------------|-----> =20
> > > > +---------------------------+ =20
> > > > > +| ...                               |       | fw-allocated array=
 for =20
> > > > | =20
> > > > > +| _STA method referring to VCIA     |       | "etc/vmcoreinfo" =
=20
> > > > | =20
> > > > > +| ...                               | =20
> > > >  +---------------------------+ =20
> > > > > +| ADDR method referring to VCIA     |       |  0: OVMF SDT Heade=
r =20
> > probe =20
> > > > | =20
> > > > > +| ...                               |       |     suppressor =20
> > > > | =20
> > > > > ++-----------------------------------+       | 40: uint32 version=
 =20
> > field =20
> > > > | =20
> > > > > +                                            | 44: info contents =
=20
> > > >  | =20
> > > > > +                                            |     .... =20
> > > > | =20
> > > > > + =20
> > > > +---------------------------+ =20
> > > > > +                                            END OF PAGE
> > > > > +
> > > > > +Version 0 content:
> > > > > +
> > > > > + uint64 paddr:
> > > > > +  Physical address of the Linux vmcoreinfo ELF note. =20
> > > >
> > > > Or physical address of the Windows crash dump header :p
> > > > =20
> > >
> > > Is there support for Windows crash dump in qemu?
> > >
> > > =20
> > > > Do we want to have an additional discriminator field to tell what k=
ind
> > > > of information was written by the guest or would Windows use a
> > > > different version?
> > > >
> > > > =20
> > > I guess a different version would be ok.
> > >
> > > Thanks a lot for looking at it! =20
> >
> > -- =20
> Marc-Andr=C3=A9 Lureau
