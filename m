Received: from eggs.gnu.org ([209.51.188.92]:59461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hEO2X-0004DS-6R
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 20:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hEO2V-0003ZA-7W
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 20:58:05 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:45713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hEO2T-0003Wc-7D
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 20:58:01 -0400
Received: by mail-oi1-x22b.google.com with SMTP id y84so3435209oia.12
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 17:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <5CADFEB7.01C57B.25694@m12-14.163.com>
	<e7a59573-5252-71b7-210b-5a8335f5a5c1@redhat.com>
In-Reply-To: <e7a59573-5252-71b7-210b-5a8335f5a5c1@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 11 Apr 2019 08:57:22 +0800
Message-ID: <CAKXe6S+w4A6YubgQib5H2QXE=eLFLWFQE-mOHYBM5PTXKaYAOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
	=?utf-8?q?Questions_about_acpi_interrupt_link_devic?=
	=?utf-8?b?ZSdzIOKAmF9QUlMnIGZpZWxk?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "liq3ea@gmail.com" <liq3ea@gmail.com>

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:55=E5=86=99=E9=81=93=EF=BC=9A

> On 10/04/19 16:33, Li Qiang wrote:
> > Hi all,
> >
> >
> >
> > I see the link device =E2=80=98_PRS=E2=80=99  uses irq line 5, 10, 11 i=
n
> > =E2=80=98build_link_dev=E2=80=99 function.
> >
> > But I never see the 5 lines uses in the guest, just uses 10 and 11.
> >
> > Why this happen?  Maybe related with the guest?
>
> Because the MADT table tells the guest to only use lines 10 and 11.  The
> BIOS configures the chipset that way.
>
>
Hi Paolo,

I read the MADT spec, and found that it may related with 'Entry Type 2 :
Interrupt Source Override'.
However, in build_madt function, I found following code when fill interrupt
source overide.

#define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
        if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
            /* No need for a INT source override structure. */
            continue;
        }

Seems the madt doesn't play a role?

Also in the seabios code, I see the pci interrupt linking device is routed
hard-coded by pci_irqs.
So this means the seabios doesn't use the madt/dsdt table to configure PCI
interrupt routing?

Thanks,
Li Qiang

const u8 pci_irqs[4] =3D {
    10, 10, 11, 11
};

static void piix_isa_bridge_setup(struct pci_device *pci, void *arg)
{
    int i, irq;
    u8 elcr[2];

    elcr[0] =3D 0x00;
    elcr[1] =3D 0x00;
    for (i =3D 0; i < 4; i++) {
        irq =3D pci_irqs[i];
        /* set to trigger level */
        elcr[irq >> 3] |=3D (1 << (irq & 7));
        /* activate irq remapping in PIIX */
        pci_config_writeb(pci->bdf, 0x60 + i, irq);
    }
    outb(elcr[0], PIIX_PORT_ELCR1);
    outb(elcr[1], PIIX_PORT_ELCR2);
    dprintf(1, "PIIX3/PIIX4 init: elcr=3D%02x %02x\n", elcr[0], elcr[1]);
}

Paolo
>
>
