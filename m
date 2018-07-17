Received: from eggs.gnu.org ([2001:4830:134:3::10]:39700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffPZb-0006kP-1V
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffPZZ-0005Ju-KY
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:59:23 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffPZZ-0005IO-As
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:59:21 -0400
Received: by mail-oi0-x244.google.com with SMTP id k81-v6so1805720oib.4
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 05:59:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180710153335.1232-1-jusual@mail.ru>
References: <20180710153335.1232-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 13:58:59 +0100
Message-ID: <CAFEAcA_oZtV3NQnJNPQh74BOk7eyo_A_j4smCbU+xV=QatpJeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] nvic: Change NVIC to support ARMv6-M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 10 July 2018 at 16:33, Julia Suvorova <jusual@mail.ru> wrote:
> The differences from ARMv7-M NVIC are:
>   * ARMv6-M only supports up to 32 external interrupts
>    (configurable feature already). The ICTR is reserved.
>   * Active Bit Register is reserved.
>   * ARMv6-M supports 4 priority levels against 256 in ARMv7-M.
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  hw/intc/armv7m_nvic.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 38aaf3dc8e..8545c87caa 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -420,6 +420,10 @@ static void set_prio(NVICState *s, unsigned irq, bool secure, uint8_t prio)
>      assert(irq > ARMV7M_EXCP_NMI); /* only use for configurable prios */
>      assert(irq < s->num_irq);
>
> +    if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
> +        prio &= 0xc0;

Rather than hard-coding this, I think we should have a
num_prio_bits field in the NVICState struct which defines
how many bits of priority are implemented. This would be
2 for v6M and 8 otherwise, and can be set in
armv7m_nvic_realize. Then the mask is
  MAKE_64BIT_MASK(8 - num_prio_bits, num_prio_bits);
(For v8M the number of priority bits is configurable.)

> +    }
> +
>      if (secure) {
>          assert(exc_is_banked(irq));
>          s->sec_vectors[irq].prio = prio;
> @@ -777,6 +781,9 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
>
>      switch (offset) {
>      case 4: /* Interrupt Control Type.  */
> +        if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> +            goto bad_offset;
> +        }
>          return ((s->num_irq - NVIC_FIRST_IRQ) / 32) - 1;
>      case 0xc: /* CPPWR */
>          if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
> @@ -850,7 +857,10 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
>      case 0xd08: /* Vector Table Offset.  */
>          return cpu->env.v7m.vecbase[attrs.secure];
>      case 0xd0c: /* Application Interrupt/Reset Control (AIRCR) */
> -        val = 0xfa050000 | (s->prigroup[attrs.secure] << 8);
> +        val = 0xfa050000;
> +        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> +            val |= (s->prigroup[attrs.secure] << 8);
> +        }

I think this change is unnecessary, because if we're v6M then
there is no way for the guest to change s->prigroup[] and it will
always be zero, so whether we OR it in or not makes no difference.
(See below about prigroup[]'s reset value.)

>          if (attrs.secure) {
>              /* s->aircr stores PRIS, BFHFNMINS, SYSRESETREQS */
>              val |= cpu->env.v7m.aircr;
> @@ -1274,6 +1284,10 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
>                                "Setting VECTRESET when not in DEBUG mode "
>                                "is UNPREDICTABLE\n");
>              }
> +            if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> +                nvic_irq_update(s);
> +                break;
> +            }
>              s->prigroup[attrs.secure] = extract32(value,
>                                                    R_V7M_AIRCR_PRIGROUP_SHIFT,
>                                                    R_V7M_AIRCR_PRIGROUP_LENGTH);

I would prefer to guard the s->prigroup[] update by wrapping it in
    if (arm_feature(&cpu->env, ARM_FEATURE_V7) {
        s->prigroup[attrs.secure] = ...
    }

rather than having an early exit via break here.

> @@ -1785,6 +1799,11 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
>          break;
>      case 0x300 ... 0x33f: /* NVIC Active */
>          val = 0;
> +
> +        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
> +            break;
> +        }
> +
>          startvec = 8 * (offset - 0x300) + NVIC_FIRST_IRQ; /* vector # */
>
>          for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
> @@ -2160,13 +2179,15 @@ static Property props_nvic[] = {
>
>  static void armv7m_nvic_reset(DeviceState *dev)
>  {
> -    int resetprio;
> +    int resetprio, resetprigroup;
>      NVICState *s = NVIC(dev);
>
>      memset(s->vectors, 0, sizeof(s->vectors));
>      memset(s->sec_vectors, 0, sizeof(s->sec_vectors));
> -    s->prigroup[M_REG_NS] = 0;
> -    s->prigroup[M_REG_S] = 0;
> +
> +    resetprigroup = arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 0 : 5;
> +    s->prigroup[M_REG_NS] = resetprigroup;
> +    s->prigroup[M_REG_S] = resetprigroup;

I don't think we should need this -- prigroup[] can reset to 0 always.
For v8M-baseline this is definitely true -- a v8M baseline CPU has
a prigroup value of 0, meaning that the priority register fields
have bits [7:1] as priority and [0] as subgroup priority, regardless
of how many of the low bits in each field are RAZ/WI. When all
the subgroup priority bits are RAZ/WI then effectively there is
only group priority. For v6M although the Arm ARM doesn't describe
it this way you can implement it like that, and I think it makes
things more consistent with v7M/v8M if we do.

(You can see from the QEMU implementation that there's no behaviour
difference from the choice of prigroup[] value -- the only use of
prigroup[] is in nvic_gprio_mask(), which is used to mask raw
priority values from the registers. Since for v6M the raw priority
values will always have zeroes in the bottom 6 bits, it doesn't
matter whether nvic_gprio_mask() returns 0xc0 (for a prigroup value
of 5) or 0xfe (for a prigroup value of 0).)

>      s->vectors[ARMV7M_EXCP_NMI].enabled = 1;
>      /* MEM, BUS, and USAGE are enabled through
> --
> 2.17.1

thanks
-- PMM
