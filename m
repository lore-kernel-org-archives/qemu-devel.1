Received: from eggs.gnu.org ([2001:4830:134:3::10]:37883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1eyGDC-0001Jv-P6
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1eyGD8-0003hh-34
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:17:54 -0400
References: <20180320022319.17199-1-david@gibson.dropbear.id.au>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <18756d48-12ba-6702-4b0d-75e67ac21b6e@redhat.com>
Date: Tue, 20 Mar 2018 13:17:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180320022319.17199-1-david@gibson.dropbear.id.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ymTggsuarFlr0rTpZYWWcw4RsBfTS6LpS"
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix backwards migration of
 msr_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, lvivier@redhat.com, wei.guo.simon@gmail.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ymTggsuarFlr0rTpZYWWcw4RsBfTS6LpS
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org,
 lvivier@redhat.com, wei.guo.simon@gmail.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Message-ID: <18756d48-12ba-6702-4b0d-75e67ac21b6e@redhat.com>
Subject: Re: [PATCH] target/ppc: Fix backwards migration of msr_mask
References: <20180320022319.17199-1-david@gibson.dropbear.id.au>
In-Reply-To: <20180320022319.17199-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 20.3.2018 v 03:23 David Gibson napsal(a):
> 21b786f "PowerPC: Add TS bits into msr_mask" added the transaction stat=
es
> to msr_mask for recent POWER CPUs to allow correct migration of machine=
s
> that are in certain interim transactional memory states.
>=20
> This was correct, but unfortunately breaks backwards of pseries-2.7 and=

> earlier machine types which (stupidly) transferred the msr_mask in the
> migration stream and failed if it wasn't equal on each end.
>=20
> This works around the problem by masking out the new MSR bits in the
> compatibility code to send the msr_mask on old machine types.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Thanks, migration to 2.6.2 works again.

Tested-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>=20

>  target/ppc/machine.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index e475206c6a..0634cdb295 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -190,7 +190,15 @@ static int cpu_pre_save(void *opaque)
> =20
>      /* Hacks for migration compatibility between 2.6, 2.7 & 2.8 */
>      if (cpu->pre_2_8_migration) {
> -        cpu->mig_msr_mask =3D env->msr_mask;
> +        /* Mask out bits that got added to msr_mask since the versions=

> +         * which stupidly included it in the migration stream. */
> +        target_ulong metamask =3D 0
> +#if defined(TARGET_PPC64)
> +            | (1ULL << MSR_TS0)
> +            | (1ULL << MSR_TS1)
> +#endif
> +            ;
> +        cpu->mig_msr_mask =3D env->msr_mask & ~metamask;
>          cpu->mig_insns_flags =3D env->insns_flags & insns_compat_mask;=

>          cpu->mig_insns_flags2 =3D env->insns_flags2 & insns_compat_mas=
k2;
>          cpu->mig_nb_BATs =3D env->nb_BATs;
>=20



--ymTggsuarFlr0rTpZYWWcw4RsBfTS6LpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFHBAEBCAAxFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAlqw++ATHGxkb2t0b3JA
cmVkaGF0LmNvbQAKCRAms2Lkf88iwTEwCAC1E8Np0QkNQ60zmcGKBSWlph5cbAA5
fpr91YInXcQGvGm1s4kdpas6FR+g9ziCNt9D5g0EDyrllvfu7aAs8Uu2iLnwjIdf
LShtPmzAFT5nf4L5zkJJvcS4fmlrh7B3FDx/qypSczEIu8LaMoSzQRCWb9GosCCp
ElLwe2bZzMiYOSY+spF03bUjYdyOdUSShZNczktNgtcPQkEDu30Cv6G8yWSaVRk8
F+PRI9lxiOIDnnC02IUBk4FpvBKsVaXTNCp64GOch+Xh1EsQXy+dHHIl7LZeR+fU
LbRSl5WzSC751Uvu9F5+KwdoqXFD/qkyWR2OFBzIBoOuYTcxcIZr2iBy
=95Gf
-----END PGP SIGNATURE-----

--ymTggsuarFlr0rTpZYWWcw4RsBfTS6LpS--
