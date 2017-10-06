Received: from eggs.gnu.org ([2001:4830:134:3::10]:45161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OeB-0003w6-N1
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Oe8-00053F-Fr
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:10:19 -0400
Date: Fri, 6 Oct 2017 20:07:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006090722.GD10961@umbus.fritz.box>
References: <20171005164959.26024-1-clg@kaod.org>
	<20171005164959.26024-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <20171005164959.26024-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] spapr/rtas: disable the decrementer
 interrupt when a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:49:58PM +0200, C=E9dric Le Goater wrote:
> When a CPU is stopped with the 'stop-self' RTAS call, its state
> 'halted' is switched to 1 and, in this case, the MSR is not taken into
> account anymore in the cpu_has_work() routine. Only the pending
> hardware interrupts are checked with their LPCR:PECE* enablement bit.
>=20
> If the DECR timer fires after 'stop-self' is called and before the CPU
> 'stop' state is reached, the nearly-dead CPU will have some work to do
> and the guest will crash. This case happens very frequently with the
> not yet upstream P9 XIVE exploitation mode. In XICS mode, the DECR is
> occasionally fired but after 'stop' state, so no work is to be done
> and the guest survives.
>=20
> I suspect there is a race between the QEMU mainloop triggering the
> timers and the TCG CPU thread but I could not quite identify the root
> cause. To be safe, let's disable the decrementer interrupt in the LPCR
> when the CPU is halted and reenable it when the CPU is restarted.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr_rtas.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index cdf0b607a0a0..2389220c9738 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -174,6 +174,15 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMa=
chineState *spapr,
>          kvm_cpu_synchronize_state(cs);
> =20
>          env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> +
> +        /* Enable DECR interrupt */
> +        if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {

Hm.  Checking mmu_model doesn't seem right to me.  I mean, it'll get
the right answer in practice, but the LPCR programming has nothing
whatsoever to do with the MMU.

I think explicitly checking if cpu_ is a POWER9 instance with
object_dynamic_cast would be a better option.

> +            env->spr[SPR_LPCR] |=3D LPCR_DEE;
> +        } else {
> +            /* P7 and P8 both have same bit for DECR */
> +            env->spr[SPR_LPCR] |=3D LPCR_P8_PECE3;
> +        }
> +
>          env->nip =3D start;
>          env->gpr[3] =3D r3;
>          cs->halted =3D 0;
> @@ -210,6 +219,13 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
>       * no need to bother with specific bits, we just clear it.
>       */
>      env->msr =3D 0;
> +
> +    if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> +        env->spr[SPR_LPCR] &=3D ~LPCR_DEE;
> +    } else {
> +        /* P7 and P8 both have same bit for DECR */
> +        env->spr[SPR_LPCR] &=3D ~LPCR_P8_PECE3;
> +    }
>  }
> =20
>  static inline int sysparm_st(target_ulong addr, target_ulong len,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXR8gACgkQbDjKyiDZ
s5JvKhAAkh/zGrJZ3mclKICMhImftevnBma+64wRgKUv91R4WsQqGC/pG2BIIi2U
7oRZFK48OMdnFzI+cvklLZnd/5IGhhUZSbZ2GOpEVI8DjCtKR8qfzJxgj248+LFs
wt4ZkdUHQ5gNZlgjtQDpf9CH2+EEVNbzPglT9LHLDYv6fyqE8VkTkymGILatfn+W
mRDqJyYv2DK+bhd1aJolWvCIL3AcAbz+WhwoFfsjDp7pHAHr9EHDpzjww3j+H57v
2swVY86O5I+mIeYwKv8nJwYXWqBHdmywmWyvamV7daMZJw95SdHa2jBkDthMjZjb
Pad4kAQ0mZB0bX+r07tVuaaQ4Q6Hz2ZO7fig1yqtRmeLlwUaJqKSn6D/QCgaB0Li
CqA1AlDg19r9QQr3Hh07RwhtQQwQZb+4osdedr9Idji1xvckc0ajnAAyOuSxlZD2
ynx8utWsCnTTvIIjZX8JX/j9Qn9bnj4GwoTdNHPMM4ZVvEjGv/d/zPzd8OMLgLfi
aa1hZK8437IADOhYAmI581NdraC1BdzRZEYLtKM6aVlAMyGdkbTOMYNnrz/XXsfA
frtOopp8cU9kRx7ng7aEKqgzuboX9V/FM8FLPBKLftF9tA5OMSN2Qx8oQy3Gno3E
uRKwc/G3wWHuEgrHp5CqbzVullQ4wGteZU7tHU9GyXLS8FnMTU8=
=E2i8
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
