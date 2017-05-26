Received: from eggs.gnu.org ([2001:4830:134:3::10]:53328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dEFm0-0004tx-Hh
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dEFly-0007Ld-CW
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:59:24 -0400
Received: from mail-lf0-x229.google.com ([2a00:1450:4010:c07::229]:34092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dEFly-0007IL-00
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:59:22 -0400
Received: by mail-lf0-x229.google.com with SMTP id 99so6576039lfu.1
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 06:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20170424130355.31324-1-marcandre.lureau@redhat.com>
	<CABdb736pFG7yK+C_J-WWRbX+e-bk62TejQ_GtObxyFmV5t350w@mail.gmail.com>
	<CAJ+F1CJPEZNUPrYseN3JD+gAtwJ-rLQVRBLdXTQVSwaBTdNGHA@mail.gmail.com>
	<20170502091723.3a3b4e42@nial.brq.redhat.com>
	<CAJ+F1CJ-tvPdX1QLYKWg6M_cattYcBDO25Hfp+rfBpnCZbwFtA@mail.gmail.com>
	<20170504154103.69a8eaa8@nial.brq.redhat.com>
In-Reply-To: <20170504154103.69a8eaa8@nial.brq.redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 May 2017 13:59:09 +0000
Message-ID: <CAJ+F1C+z7aizkCJOsYnzjhgU7cXGkKy3HzejE_Yv_NzoRvcmZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ladi Prosek <lprosek@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, anderson@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Thu, May 4, 2017 at 5:41 PM Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 02 May 2017 19:03:15 +0000
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>
> > Hi
> >
> > On Tue, May 2, 2017 at 11:17 AM Igor Mammedov <imammedo@redhat.com>
> wrote:
> >
> > > On Fri, 28 Apr 2017 14:28:38 +0000
> > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> > >
> > > > Hi
> > > >
> > > > On Fri, Apr 28, 2017 at 6:12 PM Ladi Prosek <lprosek@redhat.com>
> wrote:
> > > >
> > > > > On Mon, Apr 24, 2017 at 3:03 PM, Marc-Andr=C3=A9 Lureau
> > > > > <marcandre.lureau@redhat.com> wrote:
> > > > > > The VM coreinfo (vmcoreinfo) device is an emulated device which
> > > > > > exposes a 4k memory range to the guest to store various
> informations
> > > > > > useful to debug the guest OS. (it is greatly inspired by the
> VMGENID
> > > > > > device implementation)
> > > > > >
> > > > > > This is an early-boot alternative to the qemu-ga VMDUMP_INFO
> event
> > > > > > proposed in "[PATCH 00/21] WIP: dump: add kaslr support".
> > > > > >
> > > > > > If deemed more appropriate, we can consider writing to fw_cfg
> > > directly
> > > > > > instead of guest memory, now that qemu 2.9 supports it again.
> > > > > >
> > > > > > The proof-of-concept kernel module:
> > > > > >
> https://github.com/elmarco/vmgenid-test/blob/master/qemuvmci-test.c
> > > > >
> > > > > Here's a proof-of-concept Windows driver:
> > > > >
> > > > >
> > >
> https://github.com/ladipro/kvm-guest-drivers-windows/tree/vmcoreinfo/vmco=
reinfo
> > > > >
> > > > > I just wanted to be sure that it's possible to evaluate the ADDR
> > > > > method in Windows.
> > > > >
> > > > > From a practical point of view it is unfortunate that this would
> be a
> > > > > completely new device. For Windows guests it means another driver
> > > > > binary and all the overhead associated with deploying it on VMs.
> Would
> > > > > it be too crazy to add this functionality to the pvpanic device?
> The
> > > > > mechanics could stay the same but it would be done under the
> existing
> > > > > ACPI\QEMU0001 device.
> > > > >
> > > >
> > > > pvpanic is under _SB.PCI0.ISA, that could be problematic
> > > >
> > > > and _STA is a name field.
> > > >
> > > > Someone with more experience with ACPI could tell us if that make
> sense
> > > to
> > > > merge both and how.
> > > >
> > > > Can't you handle 2 ACPI devices in the same windows driver instead?
> > > we use QEMU0001 to reserve IO ports for pvpanic device,
> > > ASL wise there shouldn't problems with adding _ADDR method to it
> > >
> > > but then we probably should fold vmcoreinfo into pvpanic device
> > > as well (QEMU and linux driver)
> > >
> > >
> > pvpanic is x86-only afaict.
> There is nothing that forces it to be x86 specific (beside being ISA
> device),
> ARM also can benefit from/use pvpanic if you make it pci device or just
> plain
> Device.
>

Could someone advise on a recommended solution here?

Should we make a PCI variant of pvpanic and add the proposed vmcoreinfo
ACPI/mem to it ?

Tbh, I think I prefer to have seperate devices since they work differently
and vmcoreinfo doesn't require any bus device.

thanks

>
> > While I think vmcoreinfo would work fine with
> > any acpi-able arch.
> I don't insist on it but it's worth a try, probably a lot of code could b=
e
> shared between both (including AML part/which makes DSDT smaller little
> bit)
>
>
> > I think I would rather modify the windows driver to support both pvpani=
c
> &
> > vmcoreinfo, even if it's not typical for driver to implement several
> > devices.
> >
> > >
> > > > > +Storage Format:
> > > > > > +---------------
> > > > > > +
> > > > > > +The content is expected to use little-endian format.
> > > > > > +
> > > > > > +In order to implement an OVMF "SDT Header Probe Suppressor", t=
he
> > > > > contents of
> > > > > > +the vmcoreinfo blob has 40 bytes of padding:
> > > > > > +
> > > > > > ++-----------------------------------+
> > > > > > +| SSDT with OEM Table ID =3D VMCOREIN |
> > > > > > ++-----------------------------------+
> > > > > > +| ...                               |       TOP OF PAGE
> > > > > > +| VCIA dword object ----------------|----->
> > > > > +---------------------------+
> > > > > > +| ...                               |       | fw-allocated
> array for
> > > > > |
> > > > > > +| _STA method referring to VCIA     |       | "etc/vmcoreinfo"
> > > > > |
> > > > > > +| ...                               |
> > > > >  +---------------------------+
> > > > > > +| ADDR method referring to VCIA     |       |  0: OVMF SDT
> Header
> > > probe
> > > > > |
> > > > > > +| ...                               |       |     suppressor
> > > > > |
> > > > > > ++-----------------------------------+       | 40: uint32 versi=
on
> > > field
> > > > > |
> > > > > > +                                            | 44: info content=
s
> > > > >  |
> > > > > > +                                            |     ....
> > > > > |
> > > > > > +
> > > > > +---------------------------+
> > > > > > +                                            END OF PAGE
> > > > > > +
> > > > > > +Version 0 content:
> > > > > > +
> > > > > > + uint64 paddr:
> > > > > > +  Physical address of the Linux vmcoreinfo ELF note.
> > > > >
> > > > > Or physical address of the Windows crash dump header :p
> > > > >
> > > >
> > > > Is there support for Windows crash dump in qemu?
> > > >
> > > >
> > > > > Do we want to have an additional discriminator field to tell what
> kind
> > > > > of information was written by the guest or would Windows use a
> > > > > different version?
> > > > >
> > > > >
> > > > I guess a different version would be ok.
> > > >
> > > > Thanks a lot for looking at it!
> > >
> > > --
> > Marc-Andr=C3=A9 Lureau
>
> --
Marc-Andr=C3=A9 Lureau
