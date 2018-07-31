Received: from eggs.gnu.org ([2001:4830:134:3::10]:45393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkIQy-0000Ds-4d
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 20:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkIQu-0007rV-V1
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 20:22:40 -0400
Date: Tue, 31 Jul 2018 10:18:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180731001847.GF2708@umbus.fritz.box>
References: <20180730043904.17023-1-mail@sebastianbauer.info>
	<alpine.BSF.2.21.1807301254450.49677@zero.eik.bme.hu>
	<fbaa741e42e50457a0ba9c7654e1d03d@sebastianbauer.info>
	<alpine.BSF.2.21.1807310009440.24147@zero.eik.bme.hu>
	<CAFEAcA8VqaqSzc4NBwjR4F8TMAHD2vhdMMi0fwkTj1fiX=wjyQ@mail.gmail.com>
	<alpine.BSF.2.21.1807310111280.24147@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1807310111280.24147@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupt connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Maydell <peter.maydell@linaro.org>, Sebastian Bauer <mail@sebastianbauer.info>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2018 at 01:31:46AM +0200, BALATON Zoltan wrote:
> On Tue, 31 Jul 2018, Peter Maydell wrote:
> > On 30 July 2018 at 23:37, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > QEMU's implementation of qemu_irq signal lines is that the destination
> > end provides the qemu_irq, which under the hood is a pointer to a
> > struct containing a pointer to the function in the destination device
> > which gets called when the source end says "the line level has changed".
> > This means that there won't be a compile time or runtime error if you
> > pass that qemu_irq to multiple sources (ie device outputs) simultaneous=
ly.
> > But the behaviour will be wrong, because the destination will see all
> > the "level is 0", "level is 1" calls from all the sources intermingled,=
 eg
> >=20
> > device A output:   ____|^^^^^^^^^^^^^|______
> >=20
> > device B output:   _______|^^^^^|___________
> >=20
> > destination sees:  ____|^^^^^^^^|___________
> >=20
> > (because the destination gets the "level now 0" call when B's output
> > goes to zero). To get the desired behaviour:
> >=20
> > logical OR:        ____|^^^^^^^^^^^^^|_____
> >=20
> > you need an OR gate. (I'm assuming wired-OR because that's the
> > usual thing when several devices share an interrupt.)
> >=20
> > If your testing involves a setup which doesn't happen to assert
> > several of the interrupt lines simultaneously you won't notice this
> > problem.
>=20
> I think the testing with SATA and USB mouse on a PCI card is likely to
> assert several interrupts simultanelously (eg. when moving the mouse while
> loading stuff from disk) but the OS might have some ways to still recover
> from this so maybe we won't notice it anyway. As this is now confirmed th=
at
> using the same irq multiple times is wrong I think we need a better fix.
>=20
> David, can you please drop this patch, we'll come up with a different fix.

Done.  Should have looked at that patch a bit closer.

> > > Probably we can just change the map function in ppc440_pcix.c to alwa=
ys
> > > return the first line then what's specified for other lines should not
> > > matter and the above problem is avoided. We could even get rid of tho=
se
> > > additional irqs by changing ppc440_pcix.c to only model a single line=
 but
> > > I'd need someone with better understanding of this to confirm that I =
got
> > > this right.
> >=20
> > I think that would also fix the bug. The logically preferable
> > approach would depend rather on what the actual hardware does:
> > is there a PCI controller chip with 4 interrupt outputs which
> > the board wires together to a single interrupt controller line,
> > or does the PCI controller chip itself have just one output
> > and do the merging of the different PCI interrupts itself?
>=20
> Hmm, don't really know. The PCI controller is part of the SoC but we don't
> have the manual of this SoC. The physical board itself also has a single =
PCI
> slot so however it's wired internally it's only using one irq for that. N=
ot
> sure what other internal PCI devices are there. A comment in U-Boot sourc=
es
> says this (it lists PCIB twice but maybe that's meant to be PCID?):
>=20
> // IRQ2  =3D PCI_INT (PCIA, PCIB, PCIC, PCIB)
>=20
> So that suggests probably there are 4 PCI irqs that are wired together but
> probably this is inside the SoC. It could also be read as there's only a
> single PCI_INT that delivers all four PCI interrupts. So if we go from th=
at
> either adding an OR gate to sam460ex.c that ORs together the PCI lines and
> connects it to uic[1][0] would work, or changing ppc440_pcix.c to provide=
 a
> single PCI interrupt? We don't really have definitive info other than this
> comment so whatever Sebastian prefers and you approve is fine with me.
>=20
> Thank you,
> BALATON Zoltan
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltfquQACgkQbDjKyiDZ
s5JpXRAAnsM5W6KJYHFuCY9YLDP14hOA632RgjWhDuc4X5RVBjDBjkkfrtELfvJz
RiWZNzRiyF+g3/sIQLDmAckSLAmvC/OCqmPldCBAGPJa6+4ijftHvAemsOxzobkf
io4pqdRLqwy9w9OLkFYZ46sN5VFru/ECkeT+HwDtVYycop1C6kxZ4g9Id4r1UsJw
j4CHIpalO7e12hemMp1r13lD1tQ5/mf/xi7Vio69luM4oRX98w5agbNacwMvB+Og
6ZCjC4hKeRU1ZBezshZ3de/pK9uB3uc9mjIJQb4da36qS4QUM5XSi/QNn4EUA+IA
zprgZ+itWOrhCbabL+OBsNjUSfHHzAECSNLxbfiOR74jLsMMBqYIf7Nw0PEZPh16
enuEH5CPK1W6La53LSYjeaIGyq/Vky7TTFAY+1bn1PkWnJBq+qdGL8brFlnsOgTA
Yn5LB63gAuaWOkGm4o7YAKTPTank38U0RckJ1t6I9fx+ESix3ZOrDWs9VNgjzS1S
X1iXivAeNVt64rkJMP0zb7TxH6cLrT4uWA+W9eBGkRF4r0fbEfnmuR4Rettr4FKf
cdnZhiHV4kLwlXQdcTdXZgOAoqkUQOMjFL4uSCsfbral51ulK76QdSz0J+8G4Cnr
hzCDQY1FqiPz3tONx/+mk1EPxuwS9HdQO9vcnn5j3vTYa7EIrMU=
=8jvy
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
