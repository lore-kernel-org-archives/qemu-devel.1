Received: from eggs.gnu.org ([2001:4830:134:3::10]:35639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQYef-0005Te-KI
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQYee-0006dU-7G
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:39:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180606093101.30518-1-luc.michel@greensocs.com>
	<20180606093101.30518-3-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3a8833a6-6d8b-0288-b32f-63eeb0af1520@amsat.org>
Date: Wed, 6 Jun 2018 10:39:00 -0300
MIME-Version: 1.0
In-Reply-To: <20180606093101.30518-3-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/6] intc/arm_gic: Remove some
 dead code and put some functions static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luc.michel@greensocs.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, mark.burton@greensocs.com, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>

On 06/06/2018 06:30 AM, luc.michel@greensocs.com wrote:
> From: Luc MICHEL <luc.michel@greensocs.com>
> 
> Some functions are now only used in arm_gic.c, put them static. Some of
> them where only used by the NVIC implementation and are not used
> anymore, so remove them.
> 
> Signed-off-by: Luc MICHEL <luc.michel@greensocs.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/intc/arm_gic.c      | 23 ++---------------------
>  hw/intc/gic_internal.h |  4 ----
>  2 files changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 141f3e7a48..679b19fb94 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -71,7 +71,7 @@ static inline bool gic_has_groups(GICState *s)
>  
>  /* TODO: Many places that call this routine could be optimized.  */
>  /* Update interrupt status after enabled or pending bits have been changed.  */
> -void gic_update(GICState *s)
> +static void gic_update(GICState *s)
>  {
>      int best_irq;
>      int best_prio;
> @@ -137,19 +137,6 @@ void gic_update(GICState *s)
>      }
>  }
>  
> -void gic_set_pending_private(GICState *s, int cpu, int irq)
> -{
> -    int cm = 1 << cpu;
> -
> -    if (gic_test_pending(s, irq, cm)) {
> -        return;
> -    }
> -
> -    DPRINTF("Set %d pending cpu %d\n", irq, cpu);
> -    GIC_DIST_SET_PENDING(irq, cm);
> -    gic_update(s);
> -}
> -
>  static void gic_set_irq_11mpcore(GICState *s, int irq, int level,
>                                   int cm, int target)
>  {
> @@ -565,7 +552,7 @@ static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>      GIC_DIST_CLEAR_ACTIVE(irq, cm);
>  }
>  
> -void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
> +static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>  {
>      int cm = 1 << cpu;
>      int group;
> @@ -1418,12 +1405,6 @@ static const MemoryRegionOps gic_cpu_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> -/* This function is used by nvic model */
> -void gic_init_irqs_and_distributor(GICState *s)
> -{
> -    gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops);
> -}
> -
>  static void arm_gic_realize(DeviceState *dev, Error **errp)
>  {
>      /* Device instance realize function for the GIC sysbus device */
> diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
> index 6f8d242904..a2075a94db 100644
> --- a/hw/intc/gic_internal.h
> +++ b/hw/intc/gic_internal.h
> @@ -75,11 +75,7 @@
>  /* The special cases for the revision property: */
>  #define REV_11MPCORE 0
>  
> -void gic_set_pending_private(GICState *s, int cpu, int irq);
>  uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs);
> -void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs);
> -void gic_update(GICState *s);
> -void gic_init_irqs_and_distributor(GICState *s);
>  void gic_dist_set_priority(GICState *s, int cpu, int irq, uint8_t val,
>                             MemTxAttrs attrs);
>  
> 
