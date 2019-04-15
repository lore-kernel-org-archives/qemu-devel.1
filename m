Received: from eggs.gnu.org ([209.51.188.92]:56699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hFq4A-0004Yj-7X
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 21:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hFptj-0000WC-9j
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 20:55:01 -0400
Date: Mon, 15 Apr 2019 10:20:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190415002047.GA32705@umbus.fritz.box>
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-4-git-send-email-atar4qemu@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <1555103178-21894-4-git-send-email-atar4qemu@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] target/ppc: improve performance of
 large BAT invalidations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel@nongnu.org, hpoussin@reactos.org, qemu-ppc@nongnu.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2019 at 11:06:17PM +0200, Artyom Tarasenko wrote:
> Performing a complete flush is ~ 100 times faster than flushing
> 256MiB of 4KiB pages. Set a limit of 1024 pages and perform a complete
> flush afterwards.
>=20
> This patch significantly speeds up AIX 5.1 and NetBSD-ofppc.
>=20
> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>

LGTM, applied to ppc-for-4.1.

> ---
>  target/ppc/mmu_helper.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 4a6be4d..d7eed3a 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1809,6 +1809,13 @@ static inline void do_invalidate_BAT(CPUPPCState *=
env, target_ulong BATu,
> =20
>      base =3D BATu & ~0x0001FFFF;
>      end =3D base + mask + 0x00020000;
> +    if (((end - base) >> TARGET_PAGE_BITS) > 1024) {
> +        /* Flushing 1024 4K pages is slower than a complete flush */
> +        LOG_BATS("Flush all BATs\n");
> +        tlb_flush(CPU(cs));
> +        LOG_BATS("Flush done\n");
> +        return;
> +    }
>      LOG_BATS("Flush BAT from " TARGET_FMT_lx " to " TARGET_FMT_lx " ("
>               TARGET_FMT_lx ")\n", base, end, mask);
>      for (page =3D base; page !=3D end; page +=3D TARGET_PAGE_SIZE) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyzzl0ACgkQbDjKyiDZ
s5KXXA//VpfkuOsyFMvbdXoOvaTCyyq5ZSDHDEas+UqYWvkQWGShB+50xgUJxz78
6ElBShMxFiaFPKsXm+jEAHXyxT1x3vO2mkQBM3tjVpB5Igs8HhR9G4dIuch3WPC6
6mfQlFjvnCZhYbg+YJJn4XQ5o/GLOrrrk5NtVYMNVoD66RzcisGCQFUqt1M/6aGi
CYJ22I7luzD2FgUJOuQD5tTf/sdkGcisO5WVZ2v/WdnH8NaD9XLn5c/2Ug3iPIEj
GRwYuTgXidP8Kpi3ZuNs/CHPXzXl423fx7o/AZrb0KmIZimC5mHyIx4klNLfK8R8
MacwR5RFBvfMWD9lmA208JGdtXPRHaBHnod8tX7qAVjn6Po6gHFUDpFinVbD1mcQ
mOxSzV2WEMQT8hCXAy57cNmcfxoN9qp9tZlx9ZHnNxk11jzVZVU4VN95XLufduz+
O8tme71ZWNAPm1LwRrdmhHS/Vr4h+m79Te3bW+IdudhZ6z5OxjPhNA1tgntyW6TJ
jH0YMYftdxvOuWNKzO/DlAN/aO4TC+jGwLVxAv4GOmnA+8l6rzrt1tva1maQTF+/
N5q0/o1s2DD5lvzAxdJsA4pejQcyZOR8qK3tNLCcYx8FXfC/+VVB4dPjH3yltdJJ
PIp8jCNbNfh0rV/t9acKIC33DPVcxbK7KvCUePDCn/ZfptjPliM=
=nDXG
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
