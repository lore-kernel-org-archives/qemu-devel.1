Received: from eggs.gnu.org ([2001:4830:134:3::10]:45283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEMJV-0005DB-2q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEMJU-00013P-7D
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:02:57 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:40993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEMJT-00010V-VE
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:02:56 -0400
Received: by mail-lf0-x241.google.com with SMTP id o123-v6so28162670lfe.8
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 15:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-28-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-28-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 22:02:28 +0000
Message-ID: <CAKmqyKPrQtTOFOavyKy99BT340B8UyLDj+u6cFXOgNhR43q-DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 27/29] target-microblaze: mmu: Add a
 configurable output address mask
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

On Thu, May 3, 2018 at 2:32 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
wrote:

> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

> Add a configurable output address mask, used to mimic the
> configurable physical address bit width.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/microblaze/cpu.c | 1 +
>   target/microblaze/mmu.c | 1 +
>   target/microblaze/mmu.h | 1 +
>   3 files changed, 3 insertions(+)

> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 2b3f8fa374..d0649fdaaa 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -128,6 +128,7 @@ static void mb_cpu_reset(CPUState *s)
>       env->mmu.c_mmu = 3;
>       env->mmu.c_mmu_tlb_access = 3;
>       env->mmu.c_mmu_zones = 16;
> +    env->mmu.c_addr_mask = MAKE_64BIT_MASK(0, cpu->cfg.addr_size);
>   #endif
>   }

> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index a379968618..166c79908c 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -164,6 +164,7 @@ unsigned int mmu_translate(struct microblaze_mmu *mmu,
>               tlb_rpn = d & TLB_RPN_MASK;

>               lu->vaddr = tlb_tag;
> +            lu->paddr = tlb_rpn & mmu->c_addr_mask;
>               lu->paddr = tlb_rpn;
>               lu->size = tlb_size;
>               lu->err = ERR_HIT;
> diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
> index 1714caf82e..9fbdf38f36 100644
> --- a/target/microblaze/mmu.h
> +++ b/target/microblaze/mmu.h
> @@ -72,6 +72,7 @@ struct microblaze_mmu
>       int c_mmu;
>       int c_mmu_tlb_access;
>       int c_mmu_zones;
> +    uint64_t c_addr_mask; /* Mask to apply to physical addresses.  */
>   };

>   struct microblaze_mmu_lookup
> --
> 2.14.1
