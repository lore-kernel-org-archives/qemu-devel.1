Received: from eggs.gnu.org ([2001:4830:134:3::10]:43285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fuSlp-0006t2-De
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 21:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fuSlo-0003Zv-6a
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 21:26:13 -0400
Date: Tue, 28 Aug 2018 11:02:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180828010253.GD2222@umbus.fritz.box>
References: <20180827110544.12256-1-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.1808271903170.61025@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1808271903170.61025@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] 40p: fix PCI interrupt routing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, hpoussin@reactos.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 07:12:29PM +0200, BALATON Zoltan wrote:
> On Mon, 27 Aug 2018, Mark Cave-Ayland wrote:
> > According to the PReP specification section 6.1.6 "System Interrupt
> > Assignments", all PCI interrupts are routed via IRQ 15.
> >=20
> > With this patch applied it is now possible to boot the sandalfoot
> > zImage all the way through to a working userspace when using
> > OpenBIOS.
> >=20
> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > ---
> > hw/ppc/prep.c | 9 +++++----
> > 1 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> > index 162b27a3b8..e82c1355d9 100644
> > --- a/hw/ppc/prep.c
> > +++ b/hw/ppc/prep.c
> > @@ -668,10 +668,11 @@ static void ibm_40p_init(MachineState *machine)
> >     dev =3D DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), "i82378=
"));
> >     qdev_connect_gpio_out(dev, 0,
> >                           cpu->env.irq_inputs[PPC6xx_INPUT_INT]);
> > -    sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(dev, 15));
> > -    sysbus_connect_irq(pcihost, 1, qdev_get_gpio_in(dev, 13));
> > -    sysbus_connect_irq(pcihost, 2, qdev_get_gpio_in(dev, 15));
> > -    sysbus_connect_irq(pcihost, 3, qdev_get_gpio_in(dev, 13));
> > +    /* According to PReP specification section 6.1.6 "System Interrupt
> > +     * Assignments", all PCI interrupts are routed via IRQ 15 */
> > +    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> > +        sysbus_connect_irq(pcihost, i, qdev_get_gpio_in(dev, 15));
> > +    }
>=20
> I'm not sure but this looks similar to what we had with sam460ex:
>=20
> http://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00359.html
>=20
> I think you may not connect multiple interrupts to the same host irq line
> this way but you either need an OR gate or handle it within the mapping in
> the PCI host model (which is what we ended up with for the sam460ex).
> Peter's suggestion was to do whichever matches real hardware the most if =
you
> can find out that (as noted here also with more explanation that could be
> useful):
>=20
> http://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00360.html
>=20
> But I could be mistaken in this case, haven't checked it in detail.

Yeah..  I was thinking this looked very familiar.  I believe you do
need to construct the OR explicitly, not just wire all the irqs to the
same line.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluEnzoACgkQbDjKyiDZ
s5IXOQ/8CeURMtjnm5wBAn37JUA6tmRNjhQDpPu10nTmEbSG6d3Aw+fY0jbeagcL
J3N6hUs7rDpvxoPx+Fk5Fh6kI7PVDDZU/ps2WqS/mntXnfTl1OSR4+2qaekm2nY3
7nc+BYaTOeikeFL4ywYW+rlBL2KVii15mk/rki5QOWFAMMmVyrf0uWUmmfHqj8pT
s1V9dA1Hyhg+n6euQ7yG8PXL2SZjF+DoaO4ccB+DJL0N8H8dez4th/LbigrF24oI
8XJcpFwMq0yP/d13ytOjM4spzAYePyJ7F5IneUCqDga0mUYpSBJaZIfdOHr76yLn
KlELR264+G0KaV8t8W0+11uHWBC4R9TKP3WUirjiOPFO07TWUTJqXTgAqQksIrpu
AxOFxM+hvQMPh7xE8MhGKCc9RN7/TZGfkYuFgPvTXB4dldpnvyzz4kgQwF73K3ye
pbI4IphCw+Dob54LitQaEuaGE+9sZIdMmbmpIXp3KHVS3NFQb1RJrPlQp/alrzJj
5pEeCvL0a0KbSUV5BDeFFFDCyBsggYtrTaCUXPiE2m7t/BNI0UaOqQZPMSFpMJ6V
0XDHwhOjvxXY/GdygJNN7DnND6Q9UNIymG2bBor3GOc8R4W6hbnG/ByEkNgk2n3n
0emmfwiEl+hnVr0VMw82Utwk+ZzxeOA/qL6uqrc2bahMKLR3qpc=
=iWTP
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--
