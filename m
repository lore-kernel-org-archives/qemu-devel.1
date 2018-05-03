Received: from eggs.gnu.org ([2001:4830:134:3::10]:44861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKbM-0005sF-DV
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKbL-0005dM-B1
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:13:16 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:32936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEKbL-0005bZ-3H
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:13:15 -0400
Received: by mail-lf0-x243.google.com with SMTP id m18-v6so27822862lfb.0
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 13:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-9-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-9-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 20:12:48 +0000
Message-ID: <CAKmqyKNKO8y98ZEiGt9i1w6fPbYspeZ8Rvjp3+8uUTGWdfwK7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 08/29] target-microblaze: Remove USE_MMU
 PVR checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Iglesias <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>

On Thu, May 3, 2018 at 2:31 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
wrote:

> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

> We already have a CPU property to control if a core has
> an MMU or not. Remove USE_MMU PVR checks in favor of
> looking at the property.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/microblaze/helper.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)

> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index 387d4aca5a..a9f4ca93e3 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -54,21 +54,11 @@ int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr
address, int size, int rw,
>       MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
>       CPUMBState *env = &cpu->env;
>       unsigned int hit;
> -    unsigned int mmu_available;
>       int r = 1;
>       int prot;

> -    mmu_available = 0;
> -    if (cpu->cfg.use_mmu) {
> -        mmu_available = 1;
> -        if ((cpu->cfg.pvr == C_PVR_FULL) &&
> -            (env->pvr.regs[11] & PVR11_USE_MMU) != PVR11_USE_MMU) {
> -            mmu_available = 0;
> -        }
> -    }
> -
>       /* Translate if the MMU is available and enabled.  */
> -    if (mmu_available && (env->sregs[SR_MSR] & MSR_VM)) {
> +    if (cpu->cfg.use_mmu && (env->sregs[SR_MSR] & MSR_VM)) {
>           uint32_t vaddr, paddr;
>           struct microblaze_mmu_lookup lu;

> --
> 2.14.1
