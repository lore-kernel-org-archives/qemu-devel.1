Received: from eggs.gnu.org ([2001:4830:134:3::10]:33491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzDpp-00024J-Lt
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzDm5-0005ya-5n
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:26:12 -0400
Date: Mon, 10 Sep 2018 10:49:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180910004907.GA2890@umbus.fritz.box>
References: <20180827110544.12256-1-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.1808271903170.61025@zero.eik.bme.hu>
	<df6be48b-1bff-b48e-d698-da1c6fea7961@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <df6be48b-1bff-b48e-d698-da1c6fea7961@ilande.co.uk>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] 40p: fix PCI interrupt routing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, hpoussin@reactos.org, qemu-devel@nongnu.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 08, 2018 at 09:47:55AM +0100, Mark Cave-Ayland wrote:
> On 27/08/18 18:12, BALATON Zoltan wrote:
>=20
> > On Mon, 27 Aug 2018, Mark Cave-Ayland wrote:
> >> According to the PReP specification section 6.1.6 "System Interrupt
> >> Assignments", all PCI interrupts are routed via IRQ 15.
> >>
> >> With this patch applied it is now possible to boot the sandalfoot
> >> zImage all the way through to a working userspace when using
> >> OpenBIOS.
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> ---
> >> hw/ppc/prep.c | 9 +++++----
> >> 1 file changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> >> index 162b27a3b8..e82c1355d9 100644
> >> --- a/hw/ppc/prep.c
> >> +++ b/hw/ppc/prep.c
> >> @@ -668,10 +668,11 @@ static void ibm_40p_init(MachineState *machine)
> >> =A0=A0=A0 dev =3D DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), =
"i82378"));
> >> =A0=A0=A0 qdev_connect_gpio_out(dev, 0,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 cpu->env.irq_inputs[PPC6xx_INPUT_INT]);
> >> -=A0=A0=A0 sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(dev, 15));
> >> -=A0=A0=A0 sysbus_connect_irq(pcihost, 1, qdev_get_gpio_in(dev, 13));
> >> -=A0=A0=A0 sysbus_connect_irq(pcihost, 2, qdev_get_gpio_in(dev, 15));
> >> -=A0=A0=A0 sysbus_connect_irq(pcihost, 3, qdev_get_gpio_in(dev, 13));
> >> +=A0=A0=A0 /* According to PReP specification section 6.1.6 "System In=
terrupt
> >> +=A0=A0=A0=A0 * Assignments", all PCI interrupts are routed via IRQ 15=
 */
> >> +=A0=A0=A0 for (i =3D 0; i < PCI_NUM_PINS; i++) {
> >> +=A0=A0=A0=A0=A0=A0=A0 sysbus_connect_irq(pcihost, i, qdev_get_gpio_in=
(dev, 15));
> >> +=A0=A0=A0 }
> >=20
> > I'm not sure but this looks similar to what we had with sam460ex:
> >=20
> > http://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00359.html
> >=20
> > I think you may not connect multiple interrupts to the same host irq
> > line this way but you either need an OR gate or handle it within the
> > mapping in the PCI host model (which is what we ended up with for the
> > sam460ex). Peter's suggestion was to do whichever matches real hardware
> > the most if you can find out that (as noted here also with more
> > explanation that could be useful):
> >=20
> > http://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00360.html
> >=20
> > But I could be mistaken in this case, haven't checked it in detail.
>=20
> Thanks for the pointer. I now have a follow-up patchset that implements
> this, however it seems the real 40p machine has a routing quirk: the LSI
> SCSI device is separately routed to IRQ 13. So while it's not quite a
> pure OR of the 4 PCI IRQs, it's fairly close...

That's very common on pre-Express PCI machines: on-board PCI devices
have their LSIs wired directly to the system interrupt controller
rather than through the PCI interrupt pins.  I think that's a separate
issue from the routing of the PCI irq pins.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluVv4IACgkQbDjKyiDZ
s5I95xAApBqdPhYQqSypwMdv1LTFOx6P22M7t4IiLAOBOH2eYwUXZQkICW0IUHzo
Eymy6KZFLTrt7qrpsTwvC6YJivy5qX74ZY8rGWYnGp4vYJExs9RS3eVKssSMUxw4
sma/OPnYvP2qE+N407qv0HtTWTRj22ShMPInCDzFWdCk/1YSXplQWVBQAvyRQYtV
iR2gg6UckzOEoCflHsYjRMqySAgEwgMsVmQTJJEC3v4opBfJ2QghZWjiE+YFElYU
V5QUZ5Jnhhj/QjqX3TNUYvtgqT/GUft6MbqYS2CK9uNs9boCamwCWj/QOJYlnFeO
iqgUzujg77YDxzlfumwm78xqjHQewsxvOssEbKlvyKGmzAnBr4jnmOH5A14qTpqT
ZSj3zxQGGvEK5wft4sYlDrVmnDz7qm8thyIr5IPZKJqOqFD5kVzJLXOGkKg+FQgJ
a4RvqjKZMtvOXANibur2+d5Oi//YtcgxC2T4PhoosLltOv7ElAFrq3GdkMLlc5hD
aNybPTZIpF35w9BMTTfR4tT/630au8ZZEIF8biRIoFt7Jd4RFEDMzR50hPxpC/hp
af3A6LXOpb0WU6dKUI2TTwR2ZarBVc9+8N3LDNvATHSiCqF1/trIwD0PZFvRwsEW
qNGQgR98l/MFdhRZNZknHVDCyzU7N/9qY+0ohh83vWFz9DJPrQY=
=BwJQ
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
