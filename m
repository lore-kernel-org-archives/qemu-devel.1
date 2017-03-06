Received: from eggs.gnu.org ([2001:4830:134:3::10]:45959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckjn1-0002sv-UJ
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 22:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckjmy-0001jT-UH
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 22:58:28 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170305214857.9510-1-krzk@kernel.org>
	<20170305214857.9510-2-krzk@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <43e6ba5d-7138-7ac7-57e6-e3a0a53109de@amsat.org>
Date: Mon, 6 Mar 2017 00:58:19 -0300
MIME-Version: 1.0
In-Reply-To: <20170305214857.9510-2-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/3] hw/arm/exynos4210: Constify
 data pointed by few arguments and variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 03/05/2017 06:48 PM, Krzysztof Kozlowski wrote:
> In few places the function arguments and local variables are not
> modifying data passed through pointers so this can be made const for
> code safeness.  Also the static array exynos4210_uart_regs is not being
> modified.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/char/exynos4210_uart.c     | 10 +++++-----
>  hw/intc/exynos4210_combiner.c |  2 +-
>  hw/intc/exynos4210_gic.c      |  8 ++++----
>  hw/misc/exynos4210_pmu.c      |  2 +-
>  4 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> index b75f28d473bf..83e1be253255 100644
> --- a/hw/char/exynos4210_uart.c
> +++ b/hw/char/exynos4210_uart.c
> @@ -102,7 +102,7 @@ typedef struct Exynos4210UartReg {
>      uint32_t            reset_value;
>  } Exynos4210UartReg;
>
> -static Exynos4210UartReg exynos4210_uart_regs[] = {
> +static const Exynos4210UartReg exynos4210_uart_regs[] = {
>      {"ULCON",    ULCON,    0x00000000},
>      {"UCON",     UCON,     0x00003000},
>      {"UFCON",    UFCON,    0x00000000},
> @@ -220,7 +220,7 @@ static uint8_t fifo_retrieve(Exynos4210UartFIFO *q)
>      return  ret;
>  }
>
> -static int fifo_elements_number(Exynos4210UartFIFO *q)
> +static int fifo_elements_number(const Exynos4210UartFIFO *q)
>  {
>      if (q->sp < q->rp) {
>          return q->size - q->rp + q->sp;
> @@ -229,7 +229,7 @@ static int fifo_elements_number(Exynos4210UartFIFO *q)
>      return q->sp - q->rp;
>  }
>
> -static int fifo_empty_elements_number(Exynos4210UartFIFO *q)
> +static int fifo_empty_elements_number(const Exynos4210UartFIFO *q)
>  {
>      return q->size - fifo_elements_number(q);
>  }
> @@ -245,7 +245,7 @@ static void fifo_reset(Exynos4210UartFIFO *q)
>      q->rp = 0;
>  }
>
> -static uint32_t exynos4210_uart_Tx_FIFO_trigger_level(Exynos4210UartState *s)
> +static uint32_t exynos4210_uart_Tx_FIFO_trigger_level(const Exynos4210UartState *s)
>  {
>      uint32_t level = 0;
>      uint32_t reg;
> @@ -488,7 +488,7 @@ static const MemoryRegionOps exynos4210_uart_ops = {
>
>  static int exynos4210_uart_can_receive(void *opaque)
>  {
> -    Exynos4210UartState *s = (Exynos4210UartState *)opaque;
> +    const Exynos4210UartState *s = (Exynos4210UartState *)opaque;
>
>      return fifo_empty_elements_number(&s->rx);
>  }
> diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
> index f19a7062be3a..b057921e0504 100644
> --- a/hw/intc/exynos4210_combiner.c
> +++ b/hw/intc/exynos4210_combiner.c
> @@ -180,7 +180,7 @@ void exynos4210_combiner_get_gpioin(Exynos4210Irq *irqs, DeviceState *dev,
>  static uint64_t
>  exynos4210_combiner_read(void *opaque, hwaddr offset, unsigned size)
>  {
> -    struct Exynos4210CombinerState *s =
> +    const struct Exynos4210CombinerState *s =
>              (struct Exynos4210CombinerState *)opaque;
>      uint32_t req_quad_base_n;    /* Base of registers quad. Multiply it by 4 and
>                                     get a start of corresponding group quad */
> diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
> index 2a55817b7660..432b8425d09d 100644
> --- a/hw/intc/exynos4210_gic.c
> +++ b/hw/intc/exynos4210_gic.c
> @@ -190,7 +190,7 @@ combiner_grp_to_gic_id[64-EXYNOS4210_MAX_EXT_COMBINER_OUT_IRQ][8] = {
>
>  static void exynos4210_irq_handler(void *opaque, int irq, int level)
>  {
> -    Exynos4210Irq *s = (Exynos4210Irq *)opaque;
> +    const Exynos4210Irq *s = (Exynos4210Irq *)opaque;
>
>      /* Bypass */
>      qemu_set_irq(s->board_irqs[irq], level);
> @@ -277,7 +277,7 @@ typedef struct {
>
>  static void exynos4210_gic_set_irq(void *opaque, int irq, int level)
>  {
> -    Exynos4210GicState *s = (Exynos4210GicState *)opaque;
> +    const Exynos4210GicState *s = (Exynos4210GicState *)opaque;
>      qemu_set_irq(qdev_get_gpio_in(s->gic, irq), level);
>  }
>
> @@ -401,7 +401,7 @@ static const VMStateDescription vmstate_exynos4210_irq_gate = {
>  /* Process a change in IRQ input. */
>  static void exynos4210_irq_gate_handler(void *opaque, int irq, int level)
>  {
> -    Exynos4210IRQGateState *s = (Exynos4210IRQGateState *)opaque;
> +    const Exynos4210IRQGateState *s = (Exynos4210IRQGateState *)opaque;
>      uint32_t i;
>
>      assert(irq < s->n_in);
> @@ -420,7 +420,7 @@ static void exynos4210_irq_gate_handler(void *opaque, int irq, int level)
>
>  static void exynos4210_irq_gate_reset(DeviceState *d)
>  {
> -    Exynos4210IRQGateState *s = EXYNOS4210_IRQ_GATE(d);
> +    const Exynos4210IRQGateState *s = EXYNOS4210_IRQ_GATE(d);
>
>      memset(s->level, 0, s->n_in * sizeof(*s->level));
>  }
> diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
> index e30dbc7d3d83..cbdfa0614600 100644
> --- a/hw/misc/exynos4210_pmu.c
> +++ b/hw/misc/exynos4210_pmu.c
> @@ -400,7 +400,7 @@ typedef struct Exynos4210PmuState {
>  static uint64_t exynos4210_pmu_read(void *opaque, hwaddr offset,
>                                      unsigned size)
>  {
> -    Exynos4210PmuState *s = (Exynos4210PmuState *)opaque;
> +    const Exynos4210PmuState *s = (Exynos4210PmuState *)opaque;
>      unsigned i;
>      const Exynos4210PmuReg *reg_p = exynos4210_pmu_regs;
>
>
