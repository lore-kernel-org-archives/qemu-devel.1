Received: from eggs.gnu.org ([209.51.188.92]:34166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gs47q-0004cP-Ez
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gs47o-0001l7-Vl
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:15:18 -0500
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:44154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gs47o-0001XK-JI
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:15:16 -0500
Received: from player159.ha.ovh.net (unknown [10.109.143.208])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id A3D651D5752
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 12:15:13 +0100 (CET)
Date: Fri, 8 Feb 2019 12:15:03 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190208121503.38e8c9ae@bahia.lan>
In-Reply-To: <20190207230647.GC518@umbus.fritz.box>
References: <154956051753.218871.1505640778712413716.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190207230647.GC518@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_//CifRGEMIys8iGwEXCWJ9gn";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr_pci: Fix interrupt leak
 in rtas_ibm_change_msi() error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-stable@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>

--Sig_//CifRGEMIys8iGwEXCWJ9gn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Feb 2019 10:06:47 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Feb 07, 2019 at 06:28:37PM +0100, Greg Kurz wrote:
> > Now that IRQ allocation has been split in two (first allocate IRQ numbe=
rs,
> > then claim them), if the claiming fails, we must release the IRQs.
> >=20
> > Fixes: 4fe75a8ccd80 "spapr: split the IRQ allocation sequence"
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Applied to ppc-for-4.0, thanks.
>=20

Oops I've just realized there's an off-by-one error...

> > ---
> >  hw/ppc/spapr_pci.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 41d81f4a8500..6fe3c10c8d4c 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -393,6 +393,12 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, s=
PAPRMachineState *spapr,
> >      for (i =3D 0; i < req_num; i++) {
> >          spapr_irq_claim(spapr, irq + i, false, &err);
> >          if (err) {
> > +            if (i) {
> > +                spapr_irq_free(spapr, irq, i + 1);

... here. It should actually be:

+                spapr_irq_free(spapr, irq, i);

Can you fix this in your tree or should I post a v2 ?

> > +            }
> > +            if (!smc->legacy_irq_allocation) {
> > +                spapr_irq_msi_free(spapr, irq, req_num);
> > +            }
> >              error_reportf_err(err, "Can't allocate MSIs for device %x:=
 ",
> >                                config_addr);
> >              rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> >  =20
>=20


--Sig_//CifRGEMIys8iGwEXCWJ9gn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlxdZLcACgkQcdTV5YIv
c9aSdg//UDz9R57QJrMB+z1Hxzc6nZRO8dAoS7JLX85BKtY3M75XMnLSjqJO0pHu
+1vUcVfyBbCWQ3Cn9QXgrFnFHB3idw+TURs+05iT7Fm03Hp4BjFljOTuC2dVWzBI
5R3nRYFXPR3CAeKzpgD5tQj5CKgSOqUSjojRNHBo3jaoCkDBKZ8L2vNsakMqa5Sp
fIIKjMiHbngDuwaO2nXp7Vk2gpGldYHJQRbe+O7Yai5u6NSVeOzYKGYfab62c6rW
fqArEMjWHWPwP0cOcNnXHyYJkZhy0/BOFGh2518yl2crRj+rL8WkhPPqYhZfwxfq
vjYWmBZIK+feClCGV7qBQXrXPhEjZmBonKG2M4lhglZIF5brvTj5X0lP0dAXJv44
AikooK/avsvSPfMp6w6R3YADOW6syEGfV16MuPFv88RJNwbjvBKIeyEZayqHX77h
vU23FiezYTJrhxGOI6Rd67XSlYiZbBCptbdO4yu8TxtD3gyQgOr4GYS/PQmZJV3M
APWwj6oziFcvn3nn98MQDyMTQfaC72FKIxIeTZxvGsxHue3JR2hsVcyeA5eckr3U
y/RtegOgc5pnQc0wOwmdc7E5h5Qv7nrJJlHo0xnJR166DLijqm6UFYStcqD1DD0W
6l7ybOn4Ru7Xzyn4Qz0+q8nje+9QmWVIAojy4EVmCfZSN+nnC0Y=
=1DRw
-----END PGP SIGNATURE-----

--Sig_//CifRGEMIys8iGwEXCWJ9gn--
