Received: from eggs.gnu.org ([2001:4830:134:3::10]:42873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esjWD-00069E-Nf
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:22:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esjWC-00041u-F6
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:22:41 -0500
Date: Mon, 5 Mar 2018 17:22:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180305062233.GL2650@umbus.fritz.box>
References: <1519782697-13100-1-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rfwNdt5cNUUjB/69"
Content-Disposition: inline
In-Reply-To: <1519782697-13100-1-git-send-email-wei.guo.simon@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] PowerPC: Add TM bits into msr_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.guo.simon@gmail.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>


--rfwNdt5cNUUjB/69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 09:51:37AM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
>=20
> During migration, cpu_post_load() will use msr_mask to determine which
> PPC MSR bits will be sync to the target side. Hardware Transaction
> Memory(HTM) has been supported since Power8. This patch adds TM/TS bits
> into msr_mask for Power8, so that transactional application can be
> migrated across qemu.
>=20
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Sorry I've taken a while to respond to this.

This addresses a real bug, but doesn't get the details quite right.

First, the MSR_TM bit is *already* included in the msr_mask for POWER8
(it's a little above the context for this patch), though TS0 and TS1
were not.

Second, all MSR bits are sent to the far side, it's just that without
them in the MSR mask they'll be dropped instead of re-inserted into
KVM.  That's the only reason the msr_mask is relevant to KVM (and TCG
doesn't support HTM anyway).  The commit message needs to make that clearer.

> ---
>  target/ppc/translate_init.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 55c99c9..a438721 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8689,6 +8689,9 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
>                      (1ull << MSR_DR) |
>                      (1ull << MSR_PMM) |
>                      (1ull << MSR_RI) |
> +                    (1ull << MSR_TM) |
> +                    (1ull << MSR_TS0) |
> +                    (1ull << MSR_TS1) |
>                      (1ull << MSR_LE);
>      pcc->mmu_model =3D POWERPC_MMU_2_07;
>  #if defined(CONFIG_SOFTMMU)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rfwNdt5cNUUjB/69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqc4icACgkQbDjKyiDZ
s5IDPhAAhyijAY/mB8n+189t1fNRiO8wiBXih+zxhH2Dg9MHWdXiQJosLHxUsUv4
dB2OuHJSVeeU1ltu0RAP5NLiSpQ+U87gxUJs4Gzgg6wNgFG7wzHixY69HLh2ipNC
cMjE2FaiLp1ud99SUOw/iLF6Goel43QhDdg5DX3okZebyrRN4tEevphnYW08K7Ul
++/8FrJhJb2d1zOsbWPx0FgPJcRVvwHevoeNZPaJ3NLPK9kagLr6T+Vp9knDspLv
scHkuLPIFa8MpJ5zSHzVO3x7xtgTPXzDeA1dnA2qFLpJywJ/Z3XaG+UwcqUSssjq
0DmlI6f2/QG+gkac8wYJPYNS1weDZpiSJEAEOoIzbSVn6wfljR969EZZz9QttGoO
KQKzx3O5Tb7EwjfOUMWMlu3Rni7EB2NASzBFNlizyS9BwVu1wlD2V8wvUpFFyd+E
sGlTjcvnm7w3D3W3Pds1GE8jGuSQWrtZcZv3t3soH1GGuDecLMVRfQU7B+QZDdLc
Yr9225AzLolLAqfAS5Rt18FdE8RPIYOz5l3WV5lSOBIDbexY0qniVS7cx0ysWqxL
1cBXs+Q1doPl4nEzvWt4yCIn99FtLFH/9aq9njXzcED6I8GF9MeC7KW2PGyzqlNS
fSFXsEbsZgjB8If4RrPsDCDlTSrhq7vcolZwrVL67Zjfbm5RWvc=
=jD3Q
-----END PGP SIGNATURE-----

--rfwNdt5cNUUjB/69--
