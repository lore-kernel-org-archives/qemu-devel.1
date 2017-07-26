Received: from eggs.gnu.org ([2001:4830:134:3::10]:51053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daNoq-0002xL-8L
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daNol-0000Zy-CN
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:01:48 -0400
Received: from 1.mo5.mail-out.ovh.net ([188.165.57.91]:43259)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1daNol-0000Xa-7H
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:01:43 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5BE6A116343
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 17:01:40 +0200 (CEST)
Date: Wed, 26 Jul 2017 17:01:30 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170726170130.1f84a523@bahia.lan>
In-Reply-To: <20170726054718.GI8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100572350.27487.14857589060586322098.stgit@bahia>
	<20170726054718.GI8978@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/DZFx+xLGJ2k6x3Fy5uydhWK";
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

--Sig_/DZFx+xLGJ2k6x3Fy5uydhWK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jul 2017 15:47:18 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jul 25, 2017 at 08:02:03PM +0200, Greg Kurz wrote:
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
> > =20
> > +    if (smc->dr_phb_enabled) {
> > +        int offset =3D fdt_path_offset(fdt, "/"); =20
>=20
> Offset of the root node is guaranteed to be 0, so you don't need fdt_path=
_offset().
>=20

Oh, I didn't know that.

BTW, there are two other places that also need to be fixed then:

$ git grep -n 'fdt_path_offset(fdt, "/")'
hw/ppc/pnv.c:95:        cpus_offset =3D fdt_add_subnode(fdt, fdt_path_offse=
t(fdt, "/"),
hw/ppc/spapr.c:355:            cpus_offset =3D fdt_add_subnode(fdt, fdt_pat=
h_offset(fdt, "/"),

I'll send a patch.

> > +        ret =3D spapr_drc_populate_dt(fdt, offset, NULL,
> > +                                    SPAPR_DR_CONNECTOR_TYPE_PHB);
> > +        if (ret < 0) {
> > +            error_report("Couldn't set up PHB DR device tree propertie=
s");
> > +            exit(1);
> > +        }
> > +    }
> > +
> >      return fdt;
> >  }
> > =20
> >  =20
>=20


--Sig_/DZFx+xLGJ2k6x3Fy5uydhWK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll4rsoACgkQAvw66wEB28Kr1gCeIaJXPo9+ybpQNm1OL/14GirA
7JYAnjFMrLgxZaj+VkPEkF2kylQF5g1Z
=1zLp
-----END PGP SIGNATURE-----

--Sig_/DZFx+xLGJ2k6x3Fy5uydhWK--
