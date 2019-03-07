Received: from eggs.gnu.org ([209.51.188.92]:38707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h234z-0002yv-0F
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h234x-0002s3-OC
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:36 -0500
Date: Fri, 8 Mar 2019 10:22:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307232257.GS7722@umbus.fritz.box>
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
	<20190307180520.13868-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8N5nZmKALFZnI1Hj"
Content-Disposition: inline
In-Reply-To: <20190307180520.13868-2-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v2 1/7] target/ppc: introduce single
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


--8N5nZmKALFZnI1Hj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 06:05:14PM +0000, Mark Cave-Ayland wrote:
> Instead of having multiple copies of the offset calculation logic, move i=
t to a
> single fpr_offset() function.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Applied, thanks.

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

--8N5nZmKALFZnI1Hj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBp88ACgkQbDjKyiDZ
s5L2Bw//dsi9rAr1ejY0bxzvaTPiM7xKZgIBIDjRrwNv1CIzd6ZuG0AYGxJHyiYO
+IBeBxLoal04YYWruAVduhw+/29/7+4T2Sru1mFeojxOaMe54up+RyHVWjKWQKOF
gil1x5dNrqOAIMFWIFsE03IMIzTsL8mOEGv4ti+m/1+RyD2HRbTfkmbsubpmM33m
RaDGg2NDjns6ighuSywyjirugLqKlhuLRd+7MGbutQHo8LRVW98ocbnFkf3pAQiW
ZelUIU807KFYE7mY2nwvC1eb+8VyARhUsyAOZsUaQTVR5onBuEB+yCIP158ZYs+R
3ycjr3S4fhsJjXOYFQ/yeMxTNkMrB83tEqMjbiMfsId9ebHRjn63TLRXPsThGSNF
lH/WNOcg2umKnF+/B07Ij7gr4aw61fjcSeC8bKdkLbptNyoQhZec+rvWdg+9I40S
GuUc7xLAM0xy5W8qNaVMQKtb21AIi8StPUBz5xEK2O6WDFJkEn9rsDr506QbbYS7
0lnwmKOttYKYE00H4uOVLw9jTqwETItJ/43cCYSKwj7HKeqBkuWCO1roFa+LQNlv
20aaSsyqNPrPyOXGwcOuXb0BhJ+2LKfTTy97aqlHvBwbVMq1yi2Gim8zzbQuw73g
ltRdkxpPqxUb/2L7SkGOomwfyveY1T/HG9bHM+T97HKIqvEl8To=
=27Mu
-----END PGP SIGNATURE-----

--8N5nZmKALFZnI1Hj--
