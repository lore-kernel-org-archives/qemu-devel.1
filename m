Received: from eggs.gnu.org ([209.51.188.92]:44611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gubSO-0001LI-8S
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gubSN-0002li-49
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:15:00 -0500
Date: Fri, 15 Feb 2019 12:14:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190215100058.20015-14-mark.cave-ayland@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.9999.1902151213560.10116@zero.eik.bme.hu>
References: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
	<20190215100058.20015-14-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 13/17] target/ppc: Use
 mtvscr/mfvscr for vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

On Fri, 15 Feb 2019, Mark Cave-Ayland wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
>
> This is required before changing the representation of the register.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> target/ppc/machine.c | 44 +++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index eff30053b0..756b6d2971 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -10,6 +10,7 @@
> #include "migration/cpu.h"
> #include "qapi/error.h"
> #include "kvm_ppc.h"
> +#include "exec/helper-proto.h"
>
> static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
> {
> @@ -17,7 +18,7 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
>     CPUPPCState *env = &cpu->env;
>     unsigned int i, j;
>     target_ulong sdr1;
> -    uint32_t fpscr;
> +    uint32_t fpscr, vscr;
> #if defined(TARGET_PPC64)
>     int32_t slb_nr;
> #endif
> @@ -84,7 +85,8 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
>     if (!cpu->vhyp) {
>         ppc_store_sdr1(env, sdr1);
>     }
> -    qemu_get_be32s(f, &env->vscr);
> +    qemu_get_be32s(f, &vscr);
> +    helper_mtvscr(env, vscr);
>     qemu_get_be64s(f, &env->spe_acc);
>     qemu_get_be32s(f, &env->spe_fscr);
>     qemu_get_betls(f, &env->msr_mask);
> @@ -429,6 +431,28 @@ static bool altivec_needed(void *opaque)
>     return (cpu->env.insns_flags & PPC_ALTIVEC);
> }
>
> +static int get_vscr(QEMUFile *f, void *opaque, size_t size,
> +                    const VMStateField *field)
> +{
> +    PowerPCCPU *cpu = opaque;
> +    helper_mtvscr(&cpu->env, qemu_get_be32(f));
> +    return 0;
> +}
> +
> +static int put_vscr(QEMUFile *f, void *opaque, size_t size,
> +                    const VMStateField *field, QJSON *vmdesc)
> +{
> +    PowerPCCPU *cpu = opaque;
> +    qemu_put_be32(f, helper_mfvscr(&cpu->env));
> +    return 0;
> +}
> +
> +static const VMStateInfo vmstate_vscr = {
> +    .name = "cpu/altivec/vscr",
> +    .get = get_vscr,
> +    .put = put_vscr,
> +};
> +
> static const VMStateDescription vmstate_altivec = {
>     .name = "cpu/altivec",
>     .version_id = 1,
> @@ -436,7 +460,21 @@ static const VMStateDescription vmstate_altivec = {
>     .needed = altivec_needed,
>     .fields = (VMStateField[]) {
>         VMSTATE_AVR_ARRAY(env.vsr, PowerPCCPU, 32),
> -        VMSTATE_UINT32(env.vscr, PowerPCCPU),
> +        /*
> +         * Save the architecture value of the vscr, not the internally
> +         * expanded version.  Since this architecture value does not
> +         * exist in memory to be stored, this requires a but of hoop

Typo: but -> bit

Regards,
BALATON Zoltan

> +         * jumping.  We want OFFSET=0 so that we effectively pass CPU
> +         * to the helper functions.
> +         */
> +        {
> +            .name = "vscr",
> +            .version_id = 0,
> +            .size = sizeof(uint32_t),
> +            .info = &vmstate_vscr,
> +            .flags = VMS_SINGLE,
> +            .offset = 0
> +        },
>         VMSTATE_END_OF_LIST()
>     },
> };
>
