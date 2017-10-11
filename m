Received: from eggs.gnu.org ([2001:4830:134:3::10]:36778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e2Amq-00089l-Lq
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 02:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e2Amp-0004M0-48
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 02:46:36 -0400
Date: Wed, 11 Oct 2017 17:45:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171011064558.GF10496@umbus.fritz.box>
References: <20171009154930.29095-1-clg@kaod.org>
	<20171009154930.29095-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline
In-Reply-To: <20171009154930.29095-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] spapr/rtas: disable the decrementer
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2017 at 05:49:28PM +0200, C=E9dric Le Goater wrote:
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
>=20
> Changes in v2:
>=20
>  - used a new routine ppc_cpu_pvr_match() to discriminate CPU versions
>  - removed the LPCR:PECE* enablement bit when the CPU is initialized
>    if it is a secondary
>=20
>  hw/ppc/spapr_rtas.c         | 20 ++++++++++++++++++++
>  target/ppc/translate_init.c | 19 +++++++++++++++++--
>  2 files changed, 37 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index cdf0b607a0a0..dfdbf1e2c6f8 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -46,6 +46,7 @@
>  #include "qemu/cutils.h"
>  #include "trace.h"
>  #include "hw/ppc/fdt.h"
> +#include "target/ppc/cpu-models.h"
> =20
>  static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
>                                     uint32_t token, uint32_t nargs,
> @@ -174,6 +175,15 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMa=
chineState *spapr,
>          kvm_cpu_synchronize_state(cs);
> =20
>          env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> +
> +        /* Enable DECR interrupt */
> +        if (ppc_cpu_pvr_match(cpu, CPU_POWERPC_LOGICAL_3_00)) {

Sorry, I didn't reply to your earlier mail in time.  Going via the PVR
in this way seems bonkers to me - I like it even less than checking
the mmu type.  After all, classifying a bunch of precise models (PVRs)
together by behaviour is kind of exactly what the CPU classes are for,
so using object_dynamic_case() (=3D=3Dinstance_of) is a better idea here.

> +            env->spr[SPR_LPCR] |=3D LPCR_DEE;
> +        } else {
> +            /* P7 and P8 both have same bit for DECR */
> +            env->spr[SPR_LPCR] |=3D LPCR_P8_PECE3;
> +        }
> +
>          env->nip =3D start;
>          env->gpr[3] =3D r3;
>          cs->halted =3D 0;

The other option I'm wondering about here is to actually add a
"shutdown" (or something) method to the cpu class, which does whatever
is necessary to put the vcpu into a quiescent state that won't be
woken up unless it's specifically requested.

> @@ -210,6 +220,16 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
>       * no need to bother with specific bits, we just clear it.
>       */
>      env->msr =3D 0;
> +
> +    /* Don't let the decremeter run on a CPU being stopped. This could
> +     * deliver an interrupt on a dying CPU and crash the guest.
> +     */
> +    if (ppc_cpu_pvr_match(cpu, CPU_POWERPC_LOGICAL_3_00)) {
> +        env->spr[SPR_LPCR] &=3D ~LPCR_DEE;
> +    } else {
> +        /* P7 and P8 both have same bit for DECR */
> +        env->spr[SPR_LPCR] &=3D ~LPCR_P8_PECE3;
> +    }
>  }
> =20
>  static inline int sysparm_st(target_ulong addr, target_ulong len,
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 0d6379fcc5b4..1a62159843e7 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8905,6 +8905,7 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHy=
pervisor *vhyp)
>      CPUPPCState *env =3D &cpu->env;
>      ppc_spr_t *lpcr =3D &env->spr_cb[SPR_LPCR];
>      ppc_spr_t *amor =3D &env->spr_cb[SPR_AMOR];
> +    CPUState *cs =3D CPU(cpu);
> =20
>      cpu->vhyp =3D vhyp;
> =20
> @@ -8946,8 +8947,15 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualH=
ypervisor *vhyp)
>          } else {
>              lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
>          }
> -        lpcr->default_value |=3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR=
_DEE |
> +        lpcr->default_value |=3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
>                                 LPCR_OEE;

But I guess we'd also need a "set_papr" method to go with that.

> +
> +        /* Only let the decremeter wake up the boot CPU. The RTAS
> +         * command start-cpu will enable it on secondaries.
> +         */
> +        if (cs =3D=3D first_cpu) {
> +            lpcr->default_value |=3D LPCR_DEE;
> +        }
>          break;
>      default:
>          /* P7 and P8 has slightly different PECE bits, mostly because P8=
 adds
> @@ -8955,7 +8963,14 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualH=
ypervisor *vhyp)
>           * will work as expected for both implementations
>           */
>          lpcr->default_value |=3D LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8=
_PECE2 |
> -                               LPCR_P8_PECE3 | LPCR_P8_PECE4;
> +                               LPCR_P8_PECE4;
> +
> +        /* Only let the decremeter wake up the boot CPU. The RTAS
> +         * command start-cpu will enable it on secondaries.
> +         */
> +        if (cs =3D=3D first_cpu) {
> +            lpcr->default_value |=3D LPCR_P8_PECE3;
> +        }
>      }
> =20
>      /* We should be followed by a CPU reset but update the active value

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlndviYACgkQbDjKyiDZ
s5JcTRAAuMWsFxfZqkwJZF3dd8paQW5K0Y2X/PgImLxyJGBPvQal5RbZ6i3qaoPR
9OSQz+PNHsydP/ylTejY8XAG73d09waOqyRPT43ejL3Uz5NAJfc3yAi55Mezvfah
1n4Ecsk6lqCg7JVauzwXFVs4YdrsYbmfS9JIo2h6x2bJaLRZ+jpzK73ebMgnRGM0
HDgrZ62Q7u43qln9g+gnXhwYZ+mJJh9X+RFnPPVc5DbCHpWbiTaSXiGKRs9HyZ/d
eYBtSSa5jsqdfu0bb+u3S9ygcgk+SP8MZjdp8qRhmSfibugDJsRShl1vxIFrQMZX
zIVKTXcGmt79kLq3Jr5ilzATnfi0kDCX9L/kDQ8zNk8h51ZRJ59VXWhHqrC6Byv9
Iam801SvD3B3O34skoM/qCJTI+RXfgMX432UEdnjTj+AzZU8yypppjgilGAFRzP0
TjsGZZhw/3WTKwC9xavrEZWO65M3yxLKpj7mEU55/Lx9TdEk2/QQzWk9y2H7THDH
vj8JBEyQZ7iUMm5BTPO3fVfMACudASotoid3NgnOa4fMVd7bd2HSZLliUtvc8Z9R
/zxQA9Mh2lPATxAzA12tm/yZBRNp12xYqSIA3VNXVq9hVYsUBIkoEH3RyV5z6+aB
ndIup/mtgnzTNT86S7ofweZDPBxQv75u3JnemskOHoovrtVPNrE=
=+Chg
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
