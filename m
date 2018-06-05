Received: from eggs.gnu.org ([2001:4830:134:3::10]:41134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQF6L-0000V8-Oh
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQF6H-0007Xn-TY
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:46:29 -0400
Received: from 8.mo7.mail-out.ovh.net ([46.105.77.114]:44026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQF6H-0007X9-Mq
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:46:25 -0400
Received: from player687.ha.ovh.net (unknown [10.109.108.30])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 1CFC0B01D9
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 18:46:24 +0200 (CEST)
Date: Tue, 5 Jun 2018 18:46:12 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180605184612.42099707@bahia.lan>
In-Reply-To: <20180604005322.GE4251@umbus>
References: <20180507180835.4b7b9222@bahia.lan>
	<20180507165242.46502-1-leandro.lupori@gmail.com>
	<20180604005322.GE4251@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/ZMns9gSWvj3KpzTmX1SoaU.";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3] target/ppc: Allow PIR read in
 privileged mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: luporl <leandro.lupori@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

--Sig_/ZMns9gSWvj3KpzTmX1SoaU.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Jun 2018 10:53:22 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, May 07, 2018 at 01:52:42PM -0300, luporl wrote:
> > According to PowerISA, the PIR register should be readable in privileged
> > mode also, not only in hypervisor privileged mode.
> >=20
> > PowerISA 3.0 - 4.3.3 Processor Identification Register
> >=20
> > "Read access to the PIR is privileged; write access is not
> > provided." =20
>=20
> Yes... but a little further down it says "The PIR is a hypervisor
> resource".  Looking at the older 2.07 ISA, it says that
> guest-supervisor mode reads to the PIR should be redirected to the
> GPIR register, which this change won't accomplish.
>=20

Hmmm, there are two definitions for the PIR, one in Book III-S (4.3.3)
and one in Book III-E (5.3.3). It looks like you're referring to the
latter...

[Category:Embedded.Hypervisor]
Read accesses to the PIR in guest supervisor state are
mapped to the GPIR.

The Book III-S definition doesn't mention the GPIR.

> So, I'm not sure what to make of this.
>=20
> >=20
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Cc: Alexander Graf <agraf@suse.de>
> > Cc: qemu-ppc@nongnu.org
> > Signed-off-by: Leandro Lupori <leandro.lupori@gmail.com>
> > Reviewed-by: Jose Ricardo Ziviani <joserz@linux.ibm.com>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > ---
> > Changes in v2:
> > - added my Signed-off-by, maintainers CC and Jose's Reviewed-by tags
> >=20
> > Changes in v3:
> > - added subsystem name, version tag and summary of changes
> > - added the section of PowerISA that describes PIR access privileges
> >=20
> >  target/ppc/translate_init.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > index a72be6d121..7b56e3ffb9 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -7816,7 +7816,7 @@ static void gen_spr_book3s_ids(CPUPPCState *env)
> >      /* Processor identification */
> >      spr_register_hv(env, SPR_PIR, "PIR",
> >                   SPR_NOACCESS, SPR_NOACCESS,
> > -                 SPR_NOACCESS, SPR_NOACCESS,
> > +                 &spr_read_generic, SPR_NOACCESS,
> >                   &spr_read_generic, NULL,
> >                   0x00000000);
> >      spr_register_hv(env, SPR_HID0, "HID0", =20
>=20


--Sig_/ZMns9gSWvj3KpzTmX1SoaU.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsWvlQACgkQcdTV5YIv
c9byzw/+MRY9tQG+k1RA9uyjLoWZsLXggQdqz355oqam+rXqkPjbFxGNzlwtoiZ0
jwwwRqBQwQ0iBCRSgjP3gIKIAedAq9CtqeOiE6Kpp2T8Jczb8VTRjsv4pXuJSDqt
SL+KShPTpftpiYkhwqZhPz1IsBJgh5QKlneFEAiiIvB5D2VVq+JATdV1l8qNPXGJ
JzxEuuApiEoWFfnecUiBtdzThtka8U5w0DCShPJbMIr86+3qF4wW4BuTwcZi7eYa
aCIsoriyl+3vyG6yztD9SGmKE7l0/5pV5uu3wlBpvyxMuUIWn0olgaiTovplDlEN
fYosfq0QybTHNpaGeabhtLjXxB5fCuLDYBYXwjtzvcXo8PEx/U6YfNyDWBPHIjwq
0lKYq7SaPcAZgrREcDCWwAACLskQMsicy24S7FhsrRpmgLaUwMl1iAdgy2NvSAcF
e/Ro3epl4YW94tSHxlttLyqUSpPq54azzN2tLzKs5ayLO8Jv1AE4Ruf8t+pyhCoF
QZd7TqGYqapLIPHhMhY/asgk/Z6XEk9AxmoQFJ7BgWTR2d/TRkmyDaIG0quu6YNB
zVNyciPlIansUcTTtxK8trYBVJ9opWAbTYjuOEvbEGprXoBV9K3hBzH3jI+XKYty
xTJYYb91iHZ7g3Kt47taJ0BzoGIb7CJ5W9IhgPibSBWVfov/xKw=
=fRK2
-----END PGP SIGNATURE-----

--Sig_/ZMns9gSWvj3KpzTmX1SoaU.--
