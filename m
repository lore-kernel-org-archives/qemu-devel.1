Received: from eggs.gnu.org ([2001:4830:134:3::10]:58843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkhh7-0004Qh-BL
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 23:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkhh4-0002Pv-5u
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 23:21:01 -0400
Date: Wed, 1 Aug 2018 11:02:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180801010211.GL2708@umbus.fritz.box>
References: <20180731112006.737F77456B6@zero.eik.bme.hu>
	<c577eb87cb5094a63b58771ac7df6c06@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DXIF1lRUlMsbZ3S1"
Content-Disposition: inline
In-Reply-To: <c577eb87cb5094a63b58771ac7df6c06@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupts with multiple
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>


--DXIF1lRUlMsbZ3S1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2018 at 11:55:02PM +0200, Sebastian Bauer wrote:
> Am 2018-07-31 13:08, schrieb BALATON Zoltan:
> > The four interrupts of the PCI bus are connected to the same UIC pin
> > on the real Sam460ex. Evidence for this can be found in the UBoot
> > source for the Sam460ex in the Sam460ex.c file where
> > PCI_INTERRUPT_LINE is written. Change the ppc440_pcix model to behave
> > more like this.
> >=20
> > This fixes the problem that can be observed when adding further PCI
> > cards that got their interrupt rotated to other interrupts than PCI
> > INT A. In particular, the bug was observed with an additional OHCI PCI
> > card or an ES1370 sound device.
> [...]
> > diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> > index 0999efc..9c77183 100644
> > --- a/hw/ppc/sam460ex.c
> > +++ b/hw/ppc/sam460ex.c
> > @@ -515,10 +515,8 @@ static void sam460ex_init(MachineState *machine)
> >=20
> >      /* PCI bus */
> >      ppc460ex_pcie_init(env);
> > -    /* FIXME: is this correct? */
> > -    dev =3D sysbus_create_varargs("ppc440-pcix-host", 0xc0ec00000,
> > -                                uic[1][0], uic[1][20], uic[1][21],
> > uic[1][22],
> > -                                NULL);
> > +    /* All PCI irqs are connected to the same UIC pin (cf. UBoot
> > source) */
> > +    dev =3D sysbus_create_simple("ppc440-pcix-host", 0xc0ec00000,
> > uic[1][0]);
> >      pci_bus =3D (PCIBus *)qdev_get_child_bus(dev, "pci.0");
> >      if (!pci_bus) {
> >          error_report("couldn't create PCI controller!");
>=20
> I'm fine with that change. I tested it with an additional OHCI controller=
 on
> an emulated SAM machine under guest AmigaOS and it works.
>=20
> Tested-by: Sebastian Bauer <mail@sebastianbauer.info>
>=20
> Better usage of QOM etc. can IMO be done at a later time point as this fi=
xes
> an unpleasant bug and any side change will just increase the probability =
to
> introduce new bugs.

Thanks, applied to ppc-for-3.0.  I hope to send a pull request for
that today.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DXIF1lRUlMsbZ3S1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlthBpEACgkQbDjKyiDZ
s5J0rw/7BBno/vpQ1/Xm2jrAjLtjXQhaj7ru/l652y3TBIyx8dsCW9gxofUpbWA6
0SjRXFdRcNRBmK9NTd6yWXYO9AFfydHRseH+i8/pUGPZhP3WctSSEOsy9ATdMGBg
MnOxBIlhrtEs5/VkpnptZmZgEjmRvvVMlT+jafjpnEtDgdJhuHPcKXz98Fae8XiX
bdLAnnztQTXAlgPKB16+nkkD9vmAhFrgGFtA/kfSPYqA/1tqBKoJkPdQl8O1bu+b
LyTYKY9qmXyCHThLmJamjKPqxwKs47EgzJrbXAZmWmO7ysC2Dm8ib6ubnWZqxiKp
8jAhBNdnQkAPHMt//WuRQgiEm3/87EWgssEHhsMV1sVNo8zihhfnJ5p2+Xdx91pt
1KP0jQSSEGqP9dbY9K3NGODMW1kD83oz+tbZy/PUr0k32jkR8jD4Lwb8zuwb5HxH
JV8ZVw+2Ni78KqT6SypfHLBHrWTQMg8usMX6ZImWxIE754KDRHJnUEvKTtZgG58I
gEqAsxjO3l6nqcDoMAn+0+IJe0R8Hd+8vpvXkcibmHK+LGKDWSdfeCm70W8BmwiH
16n8ieH7hSDlqVyDaDr9qQH2kDKPU7l227UiHeRKbbwp1uFVRsAnePokED2jiFkE
HmWm7d6Ctd6xjM8ndNUhUTttYTriNtj3jkCEF+CpyxqpzaWiN2g=
=IOkT
-----END PGP SIGNATURE-----

--DXIF1lRUlMsbZ3S1--
