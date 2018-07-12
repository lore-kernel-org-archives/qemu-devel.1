Received: from eggs.gnu.org ([2001:4830:134:3::10]:46591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdb7X-0007Tb-UK
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdb7X-0002IF-2D
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:54:56 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdb7W-0002I3-S8
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:54:54 -0400
Received: by mail-oi0-x241.google.com with SMTP id i12-v6so55563970oik.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 05:54:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-11-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-11-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 13:54:33 +0100
Message-ID: <CAFEAcA_YxdvZGuBTKoMk+Wd4KP0LXfk1i+FvX-=3i=+aautRiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 10/20] intc/arm_gic: Implement
 virtualization extensions in gic_(activate_irq|drop_prio)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

On 29 June 2018 at 14:29, Luc Michel <luc.michel@greensocs.com> wrote:
> Implement virtualization extensions in gic_activate_irq() and
> gic_drop_prio() and in gic_get_prio_from_apr_bits() called by
> gic_drop_prio().
>
> When the current CPU is a vCPU:
>   - Use GIC_VIRT_MIN_BPR and GIC_VIRT_NR_APRS instead of their non-virt
>   counterparts,
>   - the vCPU APR is stored in the virtual interface, in h_apr.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  hw/intc/arm_gic.c | 45 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index d55a88bb33..d61c2dd557 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -276,16 +276,23 @@ static void gic_activate_irq(GICState *s, int cpu, int irq)
>       * and update the running priority.
>       */
>      int prio = gic_get_group_priority(s, cpu, irq);
> -    int preemption_level = prio >> (GIC_MIN_BPR + 1);
> +    int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
> +    int preemption_level = prio >> (min_bpr + 1);
>      int regno = preemption_level / 32;
>      int bitno = preemption_level % 32;
> +    uint32_t *papr = NULL;
>
> -    if (gic_has_groups(s) && gic_test_group(s, irq, cpu)) {
> -        s->nsapr[regno][cpu] |= (1 << bitno);
> +    if (gic_is_vcpu(cpu)) {
> +        assert(regno == 0);
> +        papr = &s->h_apr[gic_get_vcpu_real_id(cpu)];
> +    } else if (gic_has_groups(s) && gic_test_group(s, irq, cpu)) {
> +        papr = &s->nsapr[regno][cpu];
>      } else {
> -        s->apr[regno][cpu] |= (1 << bitno);
> +        papr = &s->apr[regno][cpu];
>      }
>
> +    *papr |= (1 << bitno);
> +
>      s->running_priority[cpu] = prio;
>      gic_set_active(s, irq, cpu);
>  }
> @@ -296,12 +303,22 @@ static int gic_get_prio_from_apr_bits(GICState *s, int cpu)
>       * on the set bits in the Active Priority Registers.
>       */
>      int i;
> -    for (i = 0; i < GIC_NR_APRS; i++) {
> -        uint32_t apr = s->apr[i][cpu] | s->nsapr[i][cpu];
> +    int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
> +    int nr_aprs = gic_is_vcpu(cpu) ? GIC_VIRT_NR_APRS : GIC_NR_APRS;
> +
> +    for (i = 0; i < nr_aprs; i++) {
> +        uint32_t apr;
> +
> +        if (gic_is_vcpu(cpu)) {
> +            apr = s->h_apr[gic_get_vcpu_real_id(cpu)];
> +        } else {
> +            apr = s->apr[i][cpu] | s->nsapr[i][cpu];
> +        }
> +
>          if (!apr) {
>              continue;
>          }
> -        return (i * 32 + ctz32(apr)) << (GIC_MIN_BPR + 1);
> +        return (i * 32 + ctz32(apr)) << (min_bpr + 1);

Since GIC_VIRT_NR_APRS is always 1, I think that rather than
merging the vcpu code into the loop here it would be clearer
to just special case it at the top of the function:

   if (gic_is_vcpu(cpu)) {
       uint32_t apr = s->h_apr[gic_get_vcpu_real_id(cpu)];
       if (apr) {
           return ctz32(apr) << (GIC_VIRT_MIN_BPR + 1);
       } else {
           return 0x100;
       }
   }


>      }
>      return 0x100;
>  }
> @@ -325,9 +342,19 @@ static void gic_drop_prio(GICState *s, int cpu, int group)
>       * might not do so, and interrupts that should not preempt might do so.
>       */
>      int i;
> +    int nr_aprs = gic_is_vcpu(cpu) ? GIC_VIRT_NR_APRS : GIC_NR_APRS;
> +
> +    for (i = 0; i < nr_aprs; i++) {
> +        uint32_t *papr = NULL;
> +
> +        if (gic_is_vcpu(cpu)) {
> +            papr = &s->h_apr[gic_get_vcpu_real_id(cpu)];
> +        } else if (group) {
> +            papr = &s->nsapr[i][cpu];
> +        } else {
> +            papr = &s->apr[i][cpu];
> +        }
>
> -    for (i = 0; i < GIC_NR_APRS; i++) {
> -        uint32_t *papr = group ? &s->nsapr[i][cpu] : &s->apr[i][cpu];
>          if (!*papr) {
>              continue;
>          }

Similarly here.

thanks
-- PMM
