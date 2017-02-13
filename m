Received: from eggs.gnu.org ([2001:4830:134:3::10]:49767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd8Ra-0002Qn-Ep
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 23:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd8RX-00026P-Cb
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 23:40:54 -0500
Date: Mon, 13 Feb 2017 15:34:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213043433.GV25381@umbus>
References: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
	<1486704360-27361-10-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WN2ELtqJJ9aZ3yHj"
Content-Disposition: inline
In-Reply-To: <1486704360-27361-10-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V2 09/10] target/ppc/POWER9: Add
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
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com


--WN2ELtqJJ9aZ3yHj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 04:25:59PM +1100, Suraj Jitindar Singh wrote:
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
> index a3a23d8..cc8ab1f 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8776,10 +8776,54 @@ static bool ppc_pvr_match_power9(PowerPCCPUClass =
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
> @@ -8790,6 +8834,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
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

--WN2ELtqJJ9aZ3yHj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoTdZAAoJEGw4ysog2bOSsVIQAJr1F/shUYJP1p/FnuQD+Xp8
LIIpL997+mVNUJbqr3edNPlWFY/vC+E/rubcgY4Gbi16SBikGZP513vyX/GVIrYF
B8xS0Fa393TRXfpNAh/5HiYbz7tCoQRVUOfjkjlvYCIOwXBGMgshi/x506eJdZ7X
Ml/HTWedZrlQiHUPYoC1FF3lJn9WkG7QJl5605qloE6A1DntpXy4ofnhDbHCXR8q
CBfoT1MM7kOdXL6AQsFutA1KAuKJIpGYK1s7zSTVo2Mk1mf6rUmupXGjXh82Cz4H
B3YNmziQBkhB/d1d5Y559figgmTPm5AY6Y8ijYFTKNAnK15CPfI6Z+B3/fnorAP1
bU9fmXe1JD6xNcMB2/xKSgyac9Q/X9qNzU0uCTZGbu9lMYmC1r5lT9pYkY3lrEvH
zh5KLmkOe8lzmgT0WbGMluhB5z47d8PtZtBQh2jeQkYB3ioFdvkObgn+KPnubzkc
vSFLi7zE/ySJi8wxE0wnkZ4RIfSROAtWjL33JzMevy32MnYLHRU6mjX0INMQ7s4B
hToVh0XChNvw8kCCZt/+gJ7t4oM5ZNkw7wAtFM/Vz0f0wHhZ/eSyPzATKuhXpCRX
gdpolmzeicRE29wfOT30f9NLoeRppYHF5/HCVFojTGxFdpiHsaZs4Lu5hmBH2dM+
PCundMs4zEEFp22Kp9LR
=6V6L
-----END PGP SIGNATURE-----

--WN2ELtqJJ9aZ3yHj--
