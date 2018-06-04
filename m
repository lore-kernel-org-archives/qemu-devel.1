Received: from eggs.gnu.org ([2001:4830:134:3::10]:33787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPpKk-0003T1-VM
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPpKk-00070H-2s
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:15:38 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPpKj-000707-Tx
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:15:38 -0400
Received: by mail-ot0-x243.google.com with SMTP id q17-v6so26980070otg.2
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 06:15:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180529105011.1914-28-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
	<20180529105011.1914-28-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 14:15:17 +0100
Message-ID: <CAFEAcA9PQV8toYAFxHUA7cwre64FGPVuTwCiUPROocKyMU2NWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 27/38] target-microblaze: mmu: Add a
 configurable output address mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 29 May 2018 at 11:50, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add a configurable output address mask, used to mimic the
> configurable physical address bit width.
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/cpu.c | 1 +
>  target/microblaze/mmu.c | 1 +
>  target/microblaze/mmu.h | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 6ee15ac800..71fc8d09fe 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -128,6 +128,7 @@ static void mb_cpu_reset(CPUState *s)
>      env->mmu.c_mmu = 3;
>      env->mmu.c_mmu_tlb_access = 3;
>      env->mmu.c_mmu_zones = 16;
> +    env->mmu.c_addr_mask = MAKE_64BIT_MASK(0, cpu->cfg.addr_size);
>  #endif
>  }
>
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index a379968618..166c79908c 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -164,6 +164,7 @@ unsigned int mmu_translate(struct microblaze_mmu *mmu,
>              tlb_rpn = d & TLB_RPN_MASK;
>
>              lu->vaddr = tlb_tag;
> +            lu->paddr = tlb_rpn & mmu->c_addr_mask;
>              lu->paddr = tlb_rpn;
>              lu->size = tlb_size;
>              lu->err = ERR_HIT;

Coverity points out (CID 1391441) that the line added here
has no effect, because we immediately overwrite lu->paddr in
the following line. What was the intention here ?

thanks
-- PMM
