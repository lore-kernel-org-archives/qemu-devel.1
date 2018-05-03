Received: from eggs.gnu.org ([2001:4830:134:3::10]:58826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE8ej-000787-7P
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE8ef-0001a0-T3
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:27:57 -0400
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:33727)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fE8ef-0001Z2-N2
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:27:53 -0400
Received: from player714.ha.ovh.net (unknown [10.109.122.16])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 33654A3308
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 09:27:52 +0200 (CEST)
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
	<20180503062145.17899-7-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7864254a-51b2-4f3b-83f9-e856a97bc9d1@kaod.org>
Date: Thu, 3 May 2018 09:27:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180503062145.17899-7-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/8] target/ppc: Delay initialization of
 LPCR_UPRT for secondary cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com

On 05/03/2018 08:21 AM, David Gibson wrote:
> In cpu_ppc_set_papr() the UPRT and GTSE bits of the LPCR default value =
are
> initialized based on on ppc64_radix_guest().  Which seems reasonable,
> except that ppc64_radix_guest() is based on spapr->patb_entry which is
> only set up in spapr_machine_reset, called _after_ cpu_ppc_set_papr() f=
or
> boot cpus.  Well, and the fact that modifying the SPR default value for=
 an
> instance rather than a class is kind of yucky.
>=20
> The initialization here is really only necessary or valid for
> hotplugged cpus; the base cpu initialization already sets a value
> that's good enough for the boot cpus until the guest uses an hcall to
> configure it's preferred MMU mode.
>=20
> So, move this initialization to the rtas_start_cpu() path, at which poi=
nt
> ppc64_radix_guest() will have a sensible value, to make sure secondary =
cpus
> come up in an MMU mode matching the existing cpus.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr_rtas.c         | 12 ++++++++++++
>  target/ppc/translate_init.c | 16 ----------------
>  2 files changed, 12 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 840d198a8d..652233bdf1 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -47,6 +47,7 @@
>  #include "trace.h"
>  #include "hw/ppc/fdt.h"
>  #include "target/ppc/mmu-hash64.h"
> +#include "target/ppc/mmu-book3s-v3.h"
> =20
>  static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState =
*spapr,
>                                     uint32_t token, uint32_t nargs,
> @@ -165,6 +166,17 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sP=
APRMachineState *spapr,
>      if (!pcc->interrupts_big_endian(callcpu)) {
>          lpcr |=3D LPCR_ILE;
>      }
> +    if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> +        /*
> +         * New cpus are expected to start in the same radix/hash mode
> +         * as the existing CPUs
> +         */
> +        if (ppc64_radix_guest(callcpu)) {
> +            lpcr |=3D LPCR_UPRT | LPCR_GTSE;
> +        } else {
> +            lpcr &=3D ~(LPCR_UPRT | LPCR_GTSE);
> +        }
> +    }
>      ppc_store_lpcr(newcpu, lpcr);
> =20
>      /*
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 3fd380dad6..d92a84c622 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8914,22 +8914,6 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtua=
lHypervisor *vhyp)
>      lpcr->default_value &=3D ~LPCR_RMLS;
>      lpcr->default_value |=3D 1ull << LPCR_RMLS_SHIFT;
> =20
> -    if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> -        /* By default we choose legacy mode and switch to new hash or =
radix
> -         * when a register process table hcall is made. So disable pro=
cess
> -         * tables and guest translation shootdown by default
> -         *
> -         * Hot-plugged CPUs inherit from the guest radix setting under
> -         * KVM but not under TCG. Update the default LPCR to keep new
> -         * CPUs in sync when radix is enabled.
> -         */
> -        if (ppc64_radix_guest(cpu)) {
> -            lpcr->default_value |=3D LPCR_UPRT | LPCR_GTSE;
> -        } else {
> -            lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
> -        }
> -    }
> -
>      /* Only enable Power-saving mode Exit Cause exceptions on the boot
>       * CPU. The RTAS command start-cpu will enable them on secondaries=
.
>       */
>=20
