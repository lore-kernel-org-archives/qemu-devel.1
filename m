Received: from eggs.gnu.org ([2001:4830:134:3::10]:46628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYmdF-0004RG-Ki
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 23:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYmdE-0006xu-1s
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 23:34:57 -0500
Date: Wed, 1 Feb 2017 15:34:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201043441.GS30639@umbus.fritz.box>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-14-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kLVKJMuKEUFaIs8+"
Content-Disposition: inline
In-Reply-To: <1484288903-18807-14-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 13/17] target/ppc/POWER9: Add
 cpu_has_work function for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--kLVKJMuKEUFaIs8+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 05:28:19PM +1100, Suraj Jitindar Singh wrote:
> The cpu has work function is used to mask interrupts used to determine
> if there is work for the cpu based on the LPCR. Add a function to do this
> for POWER9 and add it to the POWER9 cpu definition. This is similar to th=
at
> for POWER8 except using the LPCR bits as defined for POWER9.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/translate_init.c | 45 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 87297a7..9db004d 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8797,10 +8797,54 @@ static bool ppc_pvr_match_power9(PowerPCCPUClass =
*pcc, uint32_t pvr)
>      return false;
>  }
> =20
> +static bool cpu_has_work_POWER9(CPUState *cs)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (cs->halted) {
> +        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
> +            return false;
> +        }
> +        /* External Exception */
> +        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
> +            (env->spr[SPR_LPCR] & LPCR_EEE)) {
> +            return true;
> +        }
> +        /* Decrementer Exception */
> +        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DECR)) &&
> +            (env->spr[SPR_LPCR] & LPCR_DEE)) {
> +            return true;
> +        }
> +        /* Machine Check or Hypervisor Maintenance Exception */
> +        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_MCK |
> +            1u << PPC_INTERRUPT_HMI)) && (env->spr[SPR_LPCR] & LPCR_OEE)=
) {
> +            return true;
> +        }
> +        /* Privileged Doorbell Exception */
> +        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DOORBELL)) &&
> +            (env->spr[SPR_LPCR] & LPCR_PDEE)) {
> +            return true;
> +        }
> +        /* Hypervisor Doorbell Exception */
> +        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_HDOORBELL)) =
&&
> +            (env->spr[SPR_LPCR] & LPCR_HDEE)) {
> +            return true;
> +        }
> +        if (env->pending_interrupts & (1u << PPC_INTERRUPT_RESET)) {
> +            return true;
> +        }
> +        return false;
> +    } else {
> +        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
> +    }
> +}
> +
>  POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
> +    CPUClass *cc =3D CPU_CLASS(oc);
> =20
>      dc->fw_name =3D "PowerPC,POWER9";
>      dc->desc =3D "POWER9";
> @@ -8811,6 +8855,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>                           PCR_COMPAT_2_05;
>      pcc->init_proc =3D init_proc_POWER9;
>      pcc->check_pow =3D check_pow_nocheck;
> +    cc->has_work =3D cpu_has_work_POWER9;
>      pcc->insns_flags =3D PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MF=
TB |
>                         PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
>                         PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kLVKJMuKEUFaIs8+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkWVhAAoJEGw4ysog2bOSXNgP+wWk/D44/vQ2DOEAexH3mQPa
aBjrzEfiex07UNLG24FOr5OcWk1SmAp1HhSFPNhkCPwUOWaxO9EoTZC3F+KT2N5Y
iiWNKYb8sN22XBpyH0pZNDqi+7kFUZfbjDjoNtJ35opRLTGIAG8TohVUOg0lB8sw
2rWCGPHV+ZbYr8WBr6EGKQIVRPCum9SZIymCiTu/3Woxwd9lCNB6KJiclJ/H/hfH
rTx4Kj4WCO/6MDWdX0tXObhyOGrW/clnEwN5CY8cyMWCBkRQZGChlaGUxV8dAt5J
r4KgsLlBWKirpZ8m4UJVa5eRgi1iFlzvgVN40hR43cxMyT9pe/hhpny465T6+j9t
TBHMUZhJj3mBVxetutUbb/g5sIGzBbspU5uTUwmojE2qUpCxcWK8zAQcnFmbxL9Q
9A3x8VmHFg9q06f7KC2khTgqPHcK60/cAAKGySt91wv9AxQSRznY3WIaJXJTYVgG
4HmczWkZHUBTfwyLaAs2HpxrdVpS8ys8ks8B5X8yoE1+DJEAdDM/fFpxIsdH6AN0
vYKIUhCPbANgnGOVHtPOjVFNv7A+ZQjGN4Ayqb36bwtxrBVavY3FiBxXgsmgxaKe
+PRKiL0NMeXGrarP6VIgqRhK8mk38sMZfvCkNd6T9jJKLO4KJyKslMMJ20kx32pB
Wl6U0uVR6yH/jJO0SfMm
=dc1X
-----END PGP SIGNATURE-----

--kLVKJMuKEUFaIs8+--
