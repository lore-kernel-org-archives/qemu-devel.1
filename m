Received: from eggs.gnu.org ([2001:4830:134:3::10]:34053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUVuk-0006E3-KD
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUVug-0000J3-JF
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:27:38 -0400
Date: Mon, 10 Jul 2017 20:26:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170710102655.GE4083@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-4-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
In-Reply-To: <1499274819-15607-4-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 03/26] target/ppc/POWER9: add
 POWERPC_EXCP_POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 07:13:16PM +0200, C=E9dric Le Goater wrote:
> Prepare ground for the new exception model XIVE of POWER9.

I'm a bit confused by this.  The excp_model is about the CPU core's
irq model, not the external irq controller's.

Now.. I could imagine the POWER9 having a different core model that
came along with XIVE, but I can't see this new model being used for
anything anywhere in the rest of the series.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  target/ppc/cpu-qom.h        | 2 ++
>  target/ppc/excp_helper.c    | 9 ++++++---
>  target/ppc/translate.c      | 3 ++-
>  target/ppc/translate_init.c | 2 +-
>  4 files changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index d0cf6ca2a971..d7b78cf3f71c 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -132,6 +132,8 @@ enum powerpc_excp_t {
>      POWERPC_EXCP_POWER7,
>      /* POWER8 exception model           */
>      POWERPC_EXCP_POWER8,
> +    /* POWER9 exception model           */
> +    POWERPC_EXCP_POWER9,
>  };
> =20
>  /***********************************************************************=
******/
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 3a9f0861e773..dc7dff36a580 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -148,9 +148,11 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>       */
>  #if defined(TARGET_PPC64)
>      if (excp_model =3D=3D POWERPC_EXCP_POWER7 ||
> -        excp_model =3D=3D POWERPC_EXCP_POWER8) {
> +        excp_model =3D=3D POWERPC_EXCP_POWER8 ||
> +        excp_model =3D=3D POWERPC_EXCP_POWER9) {
>          lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
> -        if (excp_model =3D=3D POWERPC_EXCP_POWER8) {
> +        if (excp_model =3D=3D POWERPC_EXCP_POWER8 ||
> +            excp_model =3D=3D POWERPC_EXCP_POWER9) {
>              ail =3D (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
>          } else {
>              ail =3D 0;
> @@ -651,7 +653,8 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
>          if (!(new_msr & MSR_HVB) && (env->spr[SPR_LPCR] & LPCR_ILE)) {
>              new_msr |=3D (target_ulong)1 << MSR_LE;
>          }
> -    } else if (excp_model =3D=3D POWERPC_EXCP_POWER8) {
> +    } else if (excp_model =3D=3D POWERPC_EXCP_POWER8 ||
> +               excp_model =3D=3D POWERPC_EXCP_POWER9) {
>          if (new_msr & MSR_HVB) {
>              if (env->spr[SPR_HID0] & HID0_HILE) {
>                  new_msr |=3D (target_ulong)1 << MSR_LE;
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index c0cd64d927c2..2d8c1b9e6836 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -7064,7 +7064,8 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fpri=
ntf_function cpu_fprintf,
> =20
>  #if defined(TARGET_PPC64)
>      if (env->excp_model =3D=3D POWERPC_EXCP_POWER7 ||
> -        env->excp_model =3D=3D POWERPC_EXCP_POWER8) {
> +        env->excp_model =3D=3D POWERPC_EXCP_POWER8 ||
> +        env->excp_model =3D=3D POWERPC_EXCP_POWER9) {
>          cpu_fprintf(f, "HSRR0 " TARGET_FMT_lx " HSRR1 " TARGET_FMT_lx "\=
n",
>                      env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
>      }
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 53aff5a7b734..b8c7b8150318 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8962,7 +8962,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>      pcc->sps =3D &POWER7_POWER8_sps;
>      pcc->radix_page_info =3D &POWER9_radix_page_info;
>  #endif
> -    pcc->excp_model =3D POWERPC_EXCP_POWER8;
> +    pcc->excp_model =3D POWERPC_EXCP_POWER9;
>      pcc->bus_model =3D PPC_FLAGS_INPUT_POWER7;
>      pcc->bfd_mach =3D bfd_mach_ppc64;
>      pcc->flags =3D POWERPC_FLAG_VRE | POWERPC_FLAG_SE |

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZY1ZuAAoJEGw4ysog2bOSeSoP/AvFhN7sCTtI+4k0YO97KUPw
ubXEQx9SPmiyVl0dXMhgsSGATVHjY3+OmF+1XE4eg0Ytl4yqPhyf0OYhwznRzsyr
ff45cI2MKGUddUKP6+KP5/Ec0cgF0/KWGQYFGGzGt+YGJnznVz1cFg/1AJnUEk9v
T+kzOk+n7LWXLx8y331MF6xz+X8CmKQIxfIs4yHGkU5GZLuJK35YUaQTmPL/T9vJ
zDrdSrLKjbSwmiVpVpFL6qEMZVLvggJlnT5ID5UQdv37xu2B66gygJ1GYHIk+HbL
5F6w4ETgepAN9+iGZDCEY0XmHnbtzhJUZ/W/D7LpvLCJ4nYTVOAmp2a3kC1fHtiP
yUZ2BDcA4t2akiV+1XMhaKjA/8hBPnFn+CRdyg8na94WYUYS0tR/d64l3tUHHy1t
vmPdA3J5DlTP2N6O0YOpANgWIKzns4GSmpq/veryd6n/HkboX6WFf0Agf0ivgVsa
cUpfLkuXT2xlPRfxD92/zX1+pEo/h/+nKT36P7tL3Ly9Io3E9qvU5brDY5z+Az1D
lwy2giThVCrn+tCGktQN07iEQZJ5Cq/O3dePUgS3NAXYIiCK5vaaajYTG1pzJThp
obtJ6OYwYTeodT1BiZUU5XnB0ch8FBYArXNkgCDeGc0y12hBGf+BMwkBZ6R6wQLM
ky5ljc0VnEG8FLK7Kwvn
=3euF
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
