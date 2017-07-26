Received: from eggs.gnu.org ([2001:4830:134:3::10]:49185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daOV9-0008BC-F2
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daOV6-0005i7-SL
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:45:31 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:43720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1daOV6-0005h7-LT
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:45:28 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id BC634116851
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 17:45:24 +0200 (CEST)
Date: Wed, 26 Jul 2017 17:45:14 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170726174514.393c9be9@bahia.lan>
In-Reply-To: <150101588183.26979.18259704887837340588@loki>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100572350.27487.14857589060586322098.stgit@bahia>
	<150101588183.26979.18259704887837340588@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/J/A=disi47qA9Ybw605LDKF";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [for-2.11 PATCH 19/26] spapr: populate PHB DRC
 entries for root DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/J/A=disi47qA9Ybw605LDKF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jul 2017 15:51:21 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Quoting Greg Kurz (2017-07-25 13:02:03)
> > From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> >=20
> > This add entries to the root OF node to advertise our PHBs as being
> > DR-capable in accordance with PAPR specification.
> >=20
> > Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > Changes since RFC:
> > - rebased against ppc-for-2.10
> > - use error_report
> > ---
> >  hw/ppc/spapr.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 5950c009ab7e..632040f35ecc 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1151,6 +1151,16 @@ static void *spapr_build_fdt(sPAPRMachineState *=
spapr,
> >          exit(1);
> >      }
> >=20
> > +    if (smc->dr_phb_enabled) {
> > +        int offset =3D fdt_path_offset(fdt, "/");
> > +        ret =3D spapr_drc_populate_dt(fdt, offset, NULL,
> > +                                    SPAPR_DR_CONNECTOR_TYPE_PHB); =20
>=20
> This might actually clobber LMB/MEM entries added earlier since they both
> try to create the /ibm,drc* entries in / from scratch.
>  =20

Oh, looking at the description of fdt_setprop() in <libfdt.h>, I guess you'=
re
probably right.

> If that's the case, we can arrange the code something like:
>  =20
>   uint32_t root_drc_types =3D 0;
>  =20
>   if (smc->dr_lmb_enabled) {
>       root_drc_types |=3D SPAPR_DR_CONNECTOR_TYPE_LMB;
>   }
>  =20
>   if (smc->dr_phb_enabled) {
>       root_drc_types |=3D SPAPR_DR_CONNECTOR_TYPE_PHB;
>   }
>  =20
>   ...
>  =20
>   if (root_drc_types) {
>     int offset =3D fdt_path_offset(fdt, "/");
>     ret =3D spapr_drc_populate_dt(fdt, offset, NULL, root_drc_types);
>   }
>=20

Good idea. I'll do just that.

Thanks!

>=20
> > +        if (ret < 0) {
> > +            error_report("Couldn't set up PHB DR device tree propertie=
s");
> > +            exit(1);
> > +        }
> > +    }
> > +
> >      return fdt;
> >  }
> >=20
> >  =20
>=20


--Sig_/J/A=disi47qA9Ybw605LDKF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll4uQoACgkQAvw66wEB28IWUwCfXwk4frHtwwUTdG1X3CZJopL4
JBsAoKg2vib42qZr+Ykwxef02+snhftw
=S1M/
-----END PGP SIGNATURE-----

--Sig_/J/A=disi47qA9Ybw605LDKF--
