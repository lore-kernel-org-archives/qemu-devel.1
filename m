Received: from eggs.gnu.org ([209.51.188.92]:50185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gs5gB-0003gS-Tv
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 07:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gs5gB-0004B2-2E
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 07:54:51 -0500
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:53374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gs5g6-00041s-Nu
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 07:54:47 -0500
Received: from player731.ha.ovh.net (unknown [10.109.146.86])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 2DB981F9B56
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 13:54:25 +0100 (CET)
Date: Fri, 8 Feb 2019 13:54:18 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190208135418.012a3fcc@bahia.lan>
In-Reply-To: <20190208113336.GA7230@umbus.fritz.box>
References: <154956051753.218871.1505640778712413716.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190207230647.GC518@umbus.fritz.box>
	<20190208121503.38e8c9ae@bahia.lan>
	<20190208113336.GA7230@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/4+7y3m0J8jijgtnmsw/UMIu";
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

--Sig_/4+7y3m0J8jijgtnmsw/UMIu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Feb 2019 22:33:36 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Feb 08, 2019 at 12:15:03PM +0100, Greg Kurz wrote:
> > On Fri, 8 Feb 2019 10:06:47 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Thu, Feb 07, 2019 at 06:28:37PM +0100, Greg Kurz wrote: =20
> > > > Now that IRQ allocation has been split in two (first allocate IRQ n=
umbers,
> > > > then claim them), if the claiming fails, we must release the IRQs.
> > > >=20
> > > > Fixes: 4fe75a8ccd80 "spapr: split the IRQ allocation sequence"
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>   =20
> > >=20
> > > Applied to ppc-for-4.0, thanks.
> > >  =20
> >=20
> > Oops I've just realized there's an off-by-one error...
> >  =20
> > > > ---
> > > >  hw/ppc/spapr_pci.c |    6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >=20
> > > > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > > > index 41d81f4a8500..6fe3c10c8d4c 100644
> > > > --- a/hw/ppc/spapr_pci.c
> > > > +++ b/hw/ppc/spapr_pci.c
> > > > @@ -393,6 +393,12 @@ static void rtas_ibm_change_msi(PowerPCCPU *cp=
u, sPAPRMachineState *spapr,
> > > >      for (i =3D 0; i < req_num; i++) {
> > > >          spapr_irq_claim(spapr, irq + i, false, &err);
> > > >          if (err) {
> > > > +            if (i) {
> > > > +                spapr_irq_free(spapr, irq, i + 1); =20
> >=20
> > ... here. It should actually be:
> >=20
> > +                spapr_irq_free(spapr, irq, i);
> >=20
> > Can you fix this in your tree or should I post a v2 ? =20
>=20
> Fixed up inline.
>=20

Thanks !

> >  =20
> > > > +            }
> > > > +            if (!smc->legacy_irq_allocation) {
> > > > +                spapr_irq_msi_free(spapr, irq, req_num);
> > > > +            }
> > > >              error_reportf_err(err, "Can't allocate MSIs for device=
 %x: ",
> > > >                                config_addr);
> > > >              rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > > >    =20
> > >  =20
> >  =20
>=20
>=20
>=20


--Sig_/4+7y3m0J8jijgtnmsw/UMIu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlxde/oACgkQcdTV5YIv
c9ZFUxAAjVYdbkGxX0H1hg9DQOuh2ecXyaSPSlAAFLUR1uNvI431lF9a+EAPgN0z
+Ywj3YmQ7b3u8p47pKdAlLr2XPOogqU0qVphhWhNr7RX1ewpCXq2n54m+3qJ7n5A
RFkWiAXPkI2/0ORpNduisKfJ2gZ8FNYstiF9DDlrwjsi23i7naWt8PFKcUaxU46M
4ICAx1cK9BBpEkYpEkINbL/NQJcvxUrm6nkNc/Zq/s6JVEFhS8Ufqx4RYFaqr3XW
g8BVfOX9QBMDRCuMZ3GDnA+wpAqko1jCS73OWMDirPQEWOlAq1xlxYagDaENonrj
dJG42rGRuggCif53KjRt0wHdprUiAvHMC9jUA87WjIQfK7hmR3WiH+0dRCe9HiMR
mbH74Pov2hHugHe0pEgdsNKQP/LJAXubAxPVzGrXCZd8/Afu4/9tjDLQAhFB/P06
nvQEahwylsZj/nG+59CPCukArVtsLFUl+e7B5FeiJTbYSPMnDPDiiDl4eN3Zoah1
pLWx2KYq8+iEv1/WmP/NIvE1v32Yo+9PK81jfmzw2E8+DOeIzu1ZpXawM02K8a0G
dk4HmNL/GHz+xziAR9WoWBOknzgp7DWhhreS6CXh52sv+jP2NaABDuu6VXdD/oqa
Eiafg+dgBsnPKAB6HueHGErg2pYIiloAEVFDPkA39/qO+6Nw1S8=
=S8N6
-----END PGP SIGNATURE-----

--Sig_/4+7y3m0J8jijgtnmsw/UMIu--
