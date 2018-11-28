Received: from eggs.gnu.org ([2001:4830:134:3::10]:36586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRwGK-00057V-8D
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRwGG-0000ad-6V
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:36:03 -0500
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:37421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gRwGG-0000Zj-0W
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:36:00 -0500
Received: from player695.ha.ovh.net (unknown [10.109.159.68])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 5038D1758E9
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 10:35:58 +0100 (CET)
Date: Wed, 28 Nov 2018 10:35:51 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181128103551.42397998@bahia.lan>
In-Reply-To: <20181128025714.GW2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-13-clg@kaod.org>
	<20181128025714.GW2251@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/R373uGJiE0gTyYHa7YUTi5t";
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

--Sig_/R373uGJiE0gTyYHa7YUTi5t
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Nov 2018 13:57:14 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Nov 16, 2018 at 11:57:05AM +0100, C=C3=A9dric Le Goater wrote:
> > We will need to use xics_max_server_number() to create the sPAPRXive
> > object modeling the interrupt controller of the machine which is
> > created before the CPUs.
> >=20
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org> =20
>=20
> My only concern here is that this moves the spapr_set_vsmt_mode()
> before some of the sanity checks in spapr_init_cpus().  Are we certain
> there are no edge cases that could cause badness?
>=20

The early checks in spapr_init_cpus() filter out topologies that would
result in partially filled cores. They're only related to the rest of
the code that creates the boot CPUs. Before commit 1a5008fc17,
spapr_set_vsmt_mode() was even being called before spapr_init_cpus().
The rationale to move it there was to ensure it is called before the
first user of spapr->vsmt, which happens to be a call to
xics_max_server_number().

Now that xics_max_server_number() needs to be called even earlier, I think a
better change is to have xics_max_server_number() to call spapr_set_vsmt_mo=
de()
if spapr->vsmt isn't set.

> > ---
> >  hw/ppc/spapr.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 7afd1a175bf2..50cb9f9f4a02 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2466,11 +2466,6 @@ static void spapr_init_cpus(sPAPRMachineState *s=
papr)
> >          boot_cores_nr =3D possible_cpus->len;
> >      }
> > =20
> > -    /* VSMT must be set in order to be able to compute VCPU ids, ie to
> > -     * call xics_max_server_number() or spapr_vcpu_id().
> > -     */
> > -    spapr_set_vsmt_mode(spapr, &error_fatal);
> > -
> >      if (smc->pre_2_10_has_unused_icps) {
> >          int i;
> > =20
> > @@ -2593,6 +2588,11 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >      /* Setup a load limit for the ramdisk leaving room for SLOF and FD=
T */
> >      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> > =20
> > +    /* VSMT must be set in order to be able to compute VCPU ids, ie to
> > +     * call xics_max_server_number() or spapr_vcpu_id().
> > +     */
> > +    spapr_set_vsmt_mode(spapr, &error_fatal);
> > +
> >      /* Set up Interrupt Controller before we create the VCPUs */
> >      smc->irq->init(spapr, &error_fatal);
> >   =20
>=20


--Sig_/R373uGJiE0gTyYHa7YUTi5t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlv+YXgACgkQcdTV5YIv
c9b42A//RM/9+nPFVffkvCdc50kev2WIdDEdFGV/EiV3Pa76OyZZYJlCILz1WvBl
AeLmKg5GN3hZZfBMUyzpoUEIF6ReTbqFiH7mtq8JBM93YNU+iWOInIYdqSSytWuI
Mato7kErReDkgIGG838laQvWIVbfU8BnfP7KVLZKDcYTVXzVHJYL0qNc9ViuNbLS
qffISi0PPjrHc8moHSpEwlPFmGI4fFtFocmSb0icS3K3kKsRzGznzeZl0aUlb+U/
OqIRwkHO6taoLYl/jZVkpwiism2VX1AVue+0jCIvpgKwFVirrmXDbumse8hy/PPE
oewukSrngextqh/kRx2P7U0IyiseA44O5FDo/qREauwY55UtYsKhK/YLpYbAMjrS
kXvEUdubDW601FKjDlcKGsH5pCV3UEqzV6JYACKTlp4NHbJKTBcsOUnbqbO4kdSD
2ibqroJZVOWX3CJzoK35T+hsqvk6p9RJeNLKnoPmNFypQdDjEU3tHpg5oaLZiRBE
6XSOwjnzPLwS7lzgROmo8HsIlFbDKts+MpjVgNQhsE5xN59e32irsrxdQwAtD2a1
eX5+U8NKXVJcqMAZQpNvtJwArkIccw5PKeTAJ1c3SkfCEe++AFm8cZyDb9s6T2pT
KbcadmDy2WKoSOFzfhD6v0fWTgwz5A8Be+IAHQypwI4evFLKOWM=
=mLFy
-----END PGP SIGNATURE-----

--Sig_/R373uGJiE0gTyYHa7YUTi5t--
