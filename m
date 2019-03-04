Received: from eggs.gnu.org ([209.51.188.92]:58488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0gNq-0005Az-Ah
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 00:43:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0gNm-0005fT-Li
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 00:43:24 -0500
Date: Mon, 4 Mar 2019 16:37:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190304053752.GJ7792@umbus.fritz.box>
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cN519qCC4CN1mUcX"
Content-Disposition: inline
In-Reply-To: <20190303172343.13406-2-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 1/8] target/ppc: introduce single
 fpr_offset() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org


--cN519qCC4CN1mUcX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 03, 2019 at 05:23:36PM +0000, Mark Cave-Ayland wrote:
> Instead of having multiple copies of the offset calculation logic, move i=
t to a
> single fpr_offset() function.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-4.0, thanks.

> ---
>  target/ppc/cpu.h       | 7 ++++++-
>  target/ppc/translate.c | 4 ++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 26604ddf98..4bb4e42670 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2563,9 +2563,14 @@ static inline bool lsw_reg_in_range(int start, int=
 nregs, int rx)
>  }
> =20
>  /* Accessors for FP, VMX and VSX registers */
> +static inline int fpr_offset(int i)
> +{
> +    return offsetof(CPUPPCState, vsr[i].u64[0]);
> +}
> +
>  static inline uint64_t *cpu_fpr_ptr(CPUPPCState *env, int i)
>  {
> -    return &env->vsr[i].u64[0];
> +    return (uint64_t *)((uintptr_t)env + fpr_offset(i));
>  }
> =20
>  static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 819221f246..3b1992faf1 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6677,12 +6677,12 @@ GEN_TM_PRIV_NOOP(trechkpt);
> =20
>  static inline void get_fpr(TCGv_i64 dst, int regno)
>  {
> -    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, vsr[regno].u64[0]=
));
> +    tcg_gen_ld_i64(dst, cpu_env, fpr_offset(regno));
>  }
> =20
>  static inline void set_fpr(int regno, TCGv_i64 src)
>  {
> -    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[regno].u64[0]=
));
> +    tcg_gen_st_i64(src, cpu_env, fpr_offset(regno));
>  }
> =20
>  static inline void get_avr64(TCGv_i64 dst, int regno, bool high)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cN519qCC4CN1mUcX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx8ubAACgkQbDjKyiDZ
s5I5Bg/3UTSXLDewIbboTEeP2hQvuz+tihmIL7aHLx6PQeVNJKZx85vWUgPpfdzS
RPFxx2OcBmQpoj99E6IaEWMNoMsodenSSfjiCvYyz36iONzvEyIxY8OtxoBSR7h6
OrFQAPCKwKPDC/sFtekty8+USjsqDQ7090mHZ5MsN8BAaDRju/BjI0aM/e/5IcWX
2JboVwE3hn5MUj5VBYoXzngUYDKJhFreV9mLRFp0z9r2yOA2VtIevdsHCY9hj8MI
l7Lw4jmVzR8dMi0MvNGcygv6ZR+n1mqzWIoT6ZR3VRUsq+Nk8PUEwD3TYNY65mdD
2bPkHbozo4zr5KUmyg+KjHLaL0oBVtDIPidlLoHaDDxkOXPdboLU4MmoT8SAVxf4
zbVnS4LFlNAdFDJJ98G8gIAWdpIXrh0/Y4eOof6pgifkSvaTN+A6nIn1TrhxpzL3
KdctY/uthQPaPFi5W/+qQCuEVJYK66seWvqTr403i9gPItYuYmDTBsKDlARI5gNM
iT+QkMi8oMJUjsaWH5nBbM9uuVR+AKB/Wfs92T8Cljdr7Cu96qak5LFCmqVE0+Co
GWXioocotGeZ3P+k+WHKcMB2QYB++h9T/UsiVcHZwEy+XmVzOoQiYYDapZG6O1Mg
R/xMjtptcMxP+ObNFkhACTgAGhMXRcDDR1aR6QoD2Vfl5rMm8w==
=RUs5
-----END PGP SIGNATURE-----

--cN519qCC4CN1mUcX--
