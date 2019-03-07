Received: from eggs.gnu.org ([209.51.188.92]:38674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h234y-0002yq-3f
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h234w-0002qc-TF
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:36 -0500
Date: Fri, 8 Mar 2019 10:27:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307232734.GU7722@umbus.fritz.box>
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
	<20190307180520.13868-4-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kbZGpL0ScFxCd8mt"
Content-Disposition: inline
In-Reply-To: <20190307180520.13868-4-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v2 3/7] target/ppc: move Vsr* macros from
 internal.h to cpu.h
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


--kbZGpL0ScFxCd8mt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 06:05:16PM +0000, Mark Cave-Ayland wrote:
> It isn't possible to include internal.h from cpu.h so move the Vsr* macros
> into cpu.h alongside the other VMX/VSX register access functions.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  target/ppc/cpu.h      | 20 ++++++++++++++++++++
>  target/ppc/internal.h | 19 -------------------
>  2 files changed, 20 insertions(+), 19 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 4a7df13c2d..d0580c6b6d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2563,6 +2563,26 @@ static inline bool lsw_reg_in_range(int start, int=
 nregs, int rx)
>  }
> =20
>  /* Accessors for FP, VMX and VSX registers */
> +#if defined(HOST_WORDS_BIGENDIAN)
> +#define VsrB(i) u8[i]
> +#define VsrSB(i) s8[i]
> +#define VsrH(i) u16[i]
> +#define VsrSH(i) s16[i]
> +#define VsrW(i) u32[i]
> +#define VsrSW(i) s32[i]
> +#define VsrD(i) u64[i]
> +#define VsrSD(i) s64[i]
> +#else
> +#define VsrB(i) u8[15 - (i)]
> +#define VsrSB(i) s8[15 - (i)]
> +#define VsrH(i) u16[7 - (i)]
> +#define VsrSH(i) s16[7 - (i)]
> +#define VsrW(i) u32[3 - (i)]
> +#define VsrSW(i) s32[3 - (i)]
> +#define VsrD(i) u64[1 - (i)]
> +#define VsrSD(i) s64[1 - (i)]
> +#endif
> +
>  static inline int fpr_offset(int i)
>  {
>      return offsetof(CPUPPCState, vsr[i].u64[0]);
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index f26a71ffcf..3ebbdf4da4 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -204,25 +204,6 @@ EXTRACT_HELPER(IMM8, 11, 8);
>  EXTRACT_HELPER(DCMX, 16, 7);
>  EXTRACT_HELPER_SPLIT_3(DCMX_XV, 5, 16, 0, 1, 2, 5, 1, 6, 6);
> =20
> -#if defined(HOST_WORDS_BIGENDIAN)
> -#define VsrB(i) u8[i]
> -#define VsrSB(i) s8[i]
> -#define VsrH(i) u16[i]
> -#define VsrSH(i) s16[i]
> -#define VsrW(i) u32[i]
> -#define VsrSW(i) s32[i]
> -#define VsrD(i) u64[i]
> -#define VsrSD(i) s64[i]
> -#else
> -#define VsrB(i) u8[15 - (i)]
> -#define VsrSB(i) s8[15 - (i)]
> -#define VsrH(i) u16[7 - (i)]
> -#define VsrSH(i) s16[7 - (i)]
> -#define VsrW(i) u32[3 - (i)]
> -#define VsrSW(i) s32[3 - (i)]
> -#define VsrD(i) u64[1 - (i)]
> -#define VsrSD(i) s64[1 - (i)]
> -#endif
>  static inline void getVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
>  {
>      vsr->VsrD(0) =3D env->vsr[n].u64[0];

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kbZGpL0ScFxCd8mt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBqOUACgkQbDjKyiDZ
s5Jt+g/+JkMaUku0Y2+32ZTNmgDzQ5114UEkrXnubEg7ybN0OBgiyD/cVVHhB9AR
RO6CUfYhCwy+X03KlZyyCAik5UHrIQ6OItE3yndJEKzSfUPWfRSP4ZKgRQUsiYQJ
J8+HhxHBgZ26s1q672LuBCslQIYGg01iB/Kf2vHVzuyHAariabd8c36wSDtXKI6+
g/5I2KaDJNELtl29pWroaFkitLx2+yTJRAKK3V9fCff7/JLfHxuUv61nKujAadxZ
JtB6CwUpVjUfcOZEAw7x+v5sEpo7oz+4f0CpbSbsU5Dhn28RT/Rmt/Gnxwqu7o81
dzB/P1Voc3B2m2uFefILEpP26uCplft0pCEWwj3yeEYBRnN+D8I9So5LAQMMKsKi
+0zJN17ab/Lqq9MFVBKkoV14tEeUiI3YSCkbfpresLmHxW2/lzuAjH40WInkqcVO
R3h+FzqXSwzKi8DpOsbYuMZHVgbDYzcW4n48Xo85UOjDeyGbfFb/m4lAyYIzkBKV
FqzVYxBgFGWRSAoGohSmOazwYi8LgmU5uB0xsDCPSuYrx4J0AzOQXWKpuvWef7ok
jYlojXmZBxecx3UqYzFJaGi3rpFKLWC6wVP+trJTvzpnrJMZEP5el6s0h0a/GlUb
t4CHRjF6Ym9SNlFdliadqnkw0fomZee6mBT0V6E3n7ZwEvai2H4=
=BeBv
-----END PGP SIGNATURE-----

--kbZGpL0ScFxCd8mt--
