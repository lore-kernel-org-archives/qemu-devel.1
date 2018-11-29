Received: from eggs.gnu.org ([2001:4830:134:3::10]:36691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gSGFY-0001Cq-Af
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 01:56:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gSGFU-00044j-Pu
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 01:56:36 -0500
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:52594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gSGFR-0003r7-4b
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 01:56:30 -0500
Received: from player697.ha.ovh.net (unknown [10.109.143.246])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 49C5A109E4A
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 07:56:25 +0100 (CET)
Date: Thu, 29 Nov 2018 07:56:18 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181129075618.4577f80f@bahia.lan>
In-Reply-To: <20181129010248.GN2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-13-clg@kaod.org>
	<20181128025714.GW2251@umbus.fritz.box>
	<20181128103551.42397998@bahia.lan>
	<20181129010248.GN2251@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/MgC9J+L_l+s__9ADWuUPRii";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 12/36] spapr: initialize VSMT
 before initializing the IRQ backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/MgC9J+L_l+s__9ADWuUPRii
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Nov 2018 12:02:48 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Nov 28, 2018 at 10:35:51AM +0100, Greg Kurz wrote:
> > On Wed, 28 Nov 2018 13:57:14 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Fri, Nov 16, 2018 at 11:57:05AM +0100, C=C3=A9dric Le Goater wrote=
: =20
> > > > We will need to use xics_max_server_number() to create the sPAPRXive
> > > > object modeling the interrupt controller of the machine which is
> > > > created before the CPUs.
> > > >=20
> > > > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>   =20
> > >=20
> > > My only concern here is that this moves the spapr_set_vsmt_mode()
> > > before some of the sanity checks in spapr_init_cpus().  Are we certain
> > > there are no edge cases that could cause badness?
> > >  =20
> >=20
> > The early checks in spapr_init_cpus() filter out topologies that would
> > result in partially filled cores. They're only related to the rest of
> > the code that creates the boot CPUs. Before commit 1a5008fc17,
> > spapr_set_vsmt_mode() was even being called before spapr_init_cpus().
> > The rationale to move it there was to ensure it is called before the
> > first user of spapr->vsmt, which happens to be a call to
> > xics_max_server_number(). =20
>=20
> Ok.
>=20
> > Now that xics_max_server_number() needs to be called even earlier, I th=
ink a
> > better change is to have xics_max_server_number() to call spapr_set_vsm=
t_mode()
> > if spapr->vsmt isn't set. =20
>=20
> I'd rather not do that, but instead move it statically to where it
> needs to be.  That sort of lazy/on-demand initialization can result in
> really confusing behaviours depending on when a seemingly innocuous
> data-returning function is called, so I consider it a code smell.
>=20

Fair enough, then:

Reviewed-by: Greg Kurz <groug@kaod.org>

> >  =20
> > > > ---
> > > >  hw/ppc/spapr.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 7afd1a175bf2..50cb9f9f4a02 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -2466,11 +2466,6 @@ static void spapr_init_cpus(sPAPRMachineStat=
e *spapr)
> > > >          boot_cores_nr =3D possible_cpus->len;
> > > >      }
> > > > =20
> > > > -    /* VSMT must be set in order to be able to compute VCPU ids, i=
e to
> > > > -     * call xics_max_server_number() or spapr_vcpu_id().
> > > > -     */
> > > > -    spapr_set_vsmt_mode(spapr, &error_fatal);
> > > > -
> > > >      if (smc->pre_2_10_has_unused_icps) {
> > > >          int i;
> > > > =20
> > > > @@ -2593,6 +2588,11 @@ static void spapr_machine_init(MachineState =
*machine)
> > > >      /* Setup a load limit for the ramdisk leaving room for SLOF an=
d FDT */
> > > >      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHE=
AD;
> > > > =20
> > > > +    /* VSMT must be set in order to be able to compute VCPU ids, i=
e to
> > > > +     * call xics_max_server_number() or spapr_vcpu_id().
> > > > +     */
> > > > +    spapr_set_vsmt_mode(spapr, &error_fatal);
> > > > +
> > > >      /* Set up Interrupt Controller before we create the VCPUs */
> > > >      smc->irq->init(spapr, &error_fatal);
> > > >     =20
> > >  =20
> >  =20
>=20
>=20
>=20


--Sig_/MgC9J+L_l+s__9ADWuUPRii
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlv/jZIACgkQcdTV5YIv
c9ba+g//ZvVRWo3FFpTJJxj9HaPkX4hWLxT3QLhljmhm5qYPGAR7NZu6ByCadNJH
+DkOKuYerQvvVUIiAlmLhGi/s8h0hJjz9Tsptk+0+q5MsRp3r9bsi3qy/XmFtig9
eNPdHEc4SzvYWuO8/xgFY1oO0hI7wmZijItnLyHNNMCH/FLV8RCdaPJSpabnf9nY
ggeZ+sUHSNe2Eg8S7Ogq/rqNtj6rkyDuQHa1A3PvT1/dMYTHVinK6kZi7B3gsWXW
TydMt9yQCrryXTR++3qQ2Mx/iO60+ZW5WCeySyQrvUIBLkw9uYP6YE3vEZ1uh5t8
3QLgFJFQOfartCSa+8X6mskfmfCzcBEW6nkKn/abUDrfyioQ5Q1xeyt8jXCTwS3k
CZnVhnzFyZS0O4wNXu58qr8G8jTmz0cKBBO9RfQ+GJPmVKq99rPJdU7yKSFFK/SW
6bZ3quHWUr4Z1nyHHYZ4geCe+MXPeFdlzFRmBCUP+n539VU6jpldc38goK5yCoPa
x6RLcPNHmpViAjStcX3sQ6lC1k1iPq6xPdkMDUybmVgiUhUFaaVrKw9uNiGRXEGA
RDRGzcxZy4SnETAcnaHTFLUPHGuzWCj6WH3zjA+WPUL7YGQYmcU+h2W+Js7hZ9XZ
1xgr7CqC8yy6sezbiPH7/zz623K7+U2XDf0raxYrVnwtHDwTggk=
=7+fq
-----END PGP SIGNATURE-----

--Sig_/MgC9J+L_l+s__9ADWuUPRii--
