Received: from eggs.gnu.org ([209.51.188.92]:45277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtn6V-0008Fy-K5
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtmwg-0005ys-W0
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:18:56 -0500
Date: Wed, 13 Feb 2019 16:18:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213051814.GU1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-20-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="abhKGpAWOHR+b9c1"
Content-Disposition: inline
In-Reply-To: <20190128094625.4428-20-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 19/19] target/ppc: Add support for
 LPCR:HEIC on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--abhKGpAWOHR+b9c1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 10:46:25AM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> This controls whether the External Interrupt (0x500) can be
> delivered to the hypervisor or not.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/excp_helper.c        | 5 ++++-
>  target/ppc/translate_init.inc.c | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index d171a5eb6236..39bedbb11db0 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -827,7 +827,10 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>      /* External interrupt can ignore MSR:EE under some circumstances */
>      if (env->pending_interrupts & (1 << PPC_INTERRUPT_EXT)) {
>          bool lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
> -        if (async_deliver || (env->has_hv_mode && msr_hv =3D=3D 0 && !lp=
es0)) {
> +        bool heic =3D !!(env->spr[SPR_LPCR] & LPCR_HEIC);
> +        /* HEIC blocks delivery to the hypervisor */
> +        if ((async_deliver && !(heic && msr_hv && !msr_pr)) ||
> +            (env->has_hv_mode && msr_hv =3D=3D 0 && !lpes0)) {
>              powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_EXTERNAL);
>              return;
>          }
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 7f25215f0192..63ded33ea7ea 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8823,7 +8823,10 @@ static bool cpu_has_work_POWER9(CPUState *cs)
>          /* External Exception */
>          if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
>              (env->spr[SPR_LPCR] & LPCR_EEE)) {
> -            return true;
> +            bool heic =3D !!(env->spr[SPR_LPCR] & LPCR_HEIC);
> +            if (heic =3D=3D 0 || !msr_hv || msr_pr) {
> +                return true;
> +            }
>          }
>          /* Decrementer Exception */
>          if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DECR)) &&

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--abhKGpAWOHR+b9c1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjqJYACgkQbDjKyiDZ
s5LbWA/+LHD0iweW0XRcU148UqmDRiO1ikmWOJZEjuB+AIxeyD3xAhc3Di77oZC+
BqE08geb6qpGIvXhjZlF6zF4oKXz++p8uQdTQtRsCns3Ke8St2UIx94d+MY/xKym
NxczOv6Axvk99iTkqnbu80A8nhzJKjDxdylrjU3Is76i88BrkZxz4kexwrp+BIWv
wLjMrdBXJF8AgC1a1tlUcg2pG5IqcgUPQVd7OL7isKNI4zG0XwUW+n/s80WzcBqS
EzJT8bTVbcxPLpJGFktZbHk2XSe3peI6IkQiptiikJx+/ehoXzwIgWgebkJZ68LA
R+q+u69uRXnxfYOnglLCK7ZdPv2kccLPoCznM6TlqadielLMvGPe/bVl/+J+OArZ
V+IBP1zJ6aQBS4fr1dKIFU+r9wVfH8j90vuPu+vtiR/Xqcw88QYFVb16NNO4Of5K
iCLFasn0f0HO/ABes7wk4LaUMEaPFIU42N5LIHJgQCNrqFe5ZbNIFfS7XQothxnd
0I1RSl32thAN3p3t4mnaQRRme+2jFdU4sl8XfFRmTGvQUV5oC7JvQjz3/vC5fRxh
HtRPtoR+jOPknvY1pRJekixhIg3wAqrECM4fIv+MfCLVGvy7vBXm8P6yfpBaulsc
vDiiqK0mT5Cy/9G41RotZQj0QSk2vN1N+KzDGmjnprugRse8HDk=
=BSt8
-----END PGP SIGNATURE-----

--abhKGpAWOHR+b9c1--
