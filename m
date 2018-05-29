Received: from eggs.gnu.org ([2001:4830:134:3::10]:55561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fNo6f-0006sc-4H
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fNo6d-0003ih-Sv
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:32:45 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:40831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fNo6d-0003hj-I9
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:32:43 -0400
Received: by mail-lf0-x242.google.com with SMTP id q11-v6so1349916lfc.7
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 16:32:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-4-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-4-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 May 2018 16:32:11 -0700
Message-ID: <CAKmqyKPLde0_zt7qm0rVOFUBDBH3AvUf_oRgNafBkFy_ysgeUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 03/30] RISC-V: Use atomic_cmpxchg to
 update PLIC bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On Tue, May 22, 2018 at 5:14 PM, Michael Clark <mjc@sifive.com> wrote:
> The PLIC previously used a mutex to protect against concurrent
> access to the claimed and pending bitfields. Instead of using
> a mutex, we update the bitfields using atomic_cmpxchg.
>
> Rename sifive_plic_num_irqs_pending to sifive_plic_irqs_pending
> and add an early out if any interrupts are pending as the
> count of pending interrupts is not used.
>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_plic.c         | 49 +++++++++++++++++++-----------------------
>  include/hw/riscv/sifive_plic.h |  1 -
>  2 files changed, 22 insertions(+), 28 deletions(-)
>
> diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
> index 874de2ebaf77..1af23c76e603 100644
> --- a/hw/riscv/sifive_plic.c
> +++ b/hw/riscv/sifive_plic.c
> @@ -81,36 +81,32 @@ static void sifive_plic_print_state(SiFivePLICState *plic)
>      }
>  }
>
> -static
> -void sifive_plic_set_pending(SiFivePLICState *plic, int irq, bool pending)
> +static uint32_t atomic_set_masked(uint32_t *a, uint32_t mask, uint32_t value)
>  {
> -    qemu_mutex_lock(&plic->lock);
> -    uint32_t word = irq >> 5;
> -    if (pending) {
> -        plic->pending[word] |= (1 << (irq & 31));
> -    } else {
> -        plic->pending[word] &= ~(1 << (irq & 31));
> -    }
> -    qemu_mutex_unlock(&plic->lock);
> +    uint32_t old, new, cmp = atomic_read(a);
> +
> +    do {
> +        old = cmp;
> +        new = (old & ~mask) | (value & mask);
> +        cmp = atomic_cmpxchg(a, old, new);
> +    } while (old != cmp);
> +
> +    return old;
>  }
>
> -static
> -void sifive_plic_set_claimed(SiFivePLICState *plic, int irq, bool claimed)
> +static void sifive_plic_set_pending(SiFivePLICState *plic, int irq, bool level)
>  {
> -    qemu_mutex_lock(&plic->lock);
> -    uint32_t word = irq >> 5;
> -    if (claimed) {
> -        plic->claimed[word] |= (1 << (irq & 31));
> -    } else {
> -        plic->claimed[word] &= ~(1 << (irq & 31));
> -    }
> -    qemu_mutex_unlock(&plic->lock);
> +    atomic_set_masked(&plic->pending[irq >> 5], 1 << (irq & 31), -!!level);
>  }
>
> -static
> -int sifive_plic_num_irqs_pending(SiFivePLICState *plic, uint32_t addrid)
> +static void sifive_plic_set_claimed(SiFivePLICState *plic, int irq, bool level)
>  {
> -    int i, j, count = 0;
> +    atomic_set_masked(&plic->claimed[irq >> 5], 1 << (irq & 31), -!!level);
> +}
> +
> +static int sifive_plic_irqs_pending(SiFivePLICState *plic, uint32_t addrid)
> +{
> +    int i, j;
>      for (i = 0; i < plic->bitfield_words; i++) {
>          uint32_t pending_enabled_not_claimed =
>              (plic->pending[i] & ~plic->claimed[i]) &
> @@ -123,11 +119,11 @@ int sifive_plic_num_irqs_pending(SiFivePLICState *plic, uint32_t addrid)
>              uint32_t prio = plic->source_priority[irq];
>              int enabled = pending_enabled_not_claimed & (1 << j);
>              if (enabled && prio > plic->target_priority[addrid]) {
> -                count++;
> +                return 1;
>              }
>          }
>      }
> -    return count;
> +    return 0;
>  }
>
>  static void sifive_plic_update(SiFivePLICState *plic)
> @@ -143,7 +139,7 @@ static void sifive_plic_update(SiFivePLICState *plic)
>          if (!env) {
>              continue;
>          }
> -        int level = sifive_plic_num_irqs_pending(plic, addrid) > 0;
> +        int level = sifive_plic_irqs_pending(plic, addrid);
>          switch (mode) {
>          case PLICMode_M:
>              riscv_set_local_interrupt(RISCV_CPU(cpu), MIP_MEIP, level);
> @@ -440,7 +436,6 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
>      memory_region_init_io(&plic->mmio, OBJECT(dev), &sifive_plic_ops, plic,
>                            TYPE_SIFIVE_PLIC, plic->aperture_size);
>      parse_hart_config(plic);
> -    qemu_mutex_init(&plic->lock);
>      plic->bitfield_words = (plic->num_sources + 31) >> 5;
>      plic->source_priority = g_new0(uint32_t, plic->num_sources);
>      plic->target_priority = g_new(uint32_t, plic->num_addrs);
> diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_plic.h
> index 11a5a98df1f9..ff09a288261e 100644
> --- a/include/hw/riscv/sifive_plic.h
> +++ b/include/hw/riscv/sifive_plic.h
> @@ -55,7 +55,6 @@ typedef struct SiFivePLICState {
>      uint32_t *pending;
>      uint32_t *claimed;
>      uint32_t *enable;
> -    QemuMutex lock;
>      qemu_irq *irqs;
>
>      /* config */
> --
> 2.7.0
>
>
