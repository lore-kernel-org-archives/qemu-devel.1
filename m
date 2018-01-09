Received: from eggs.gnu.org ([2001:4830:134:3::10]:40960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYuln-0007Jn-2U
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYull-00060K-UN
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:20:51 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYull-000603-OS
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:20:49 -0500
Received: by mail-oi0-x242.google.com with SMTP id 184so10607705oii.2
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 06:20:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512742372-31517-1-git-send-email-peter.maydell@linaro.org>
References: <1512742372-31517-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 14:20:28 +0000
Message-ID: <CAFEAcA9WWy06hAu6_SCQR5M3GJ-H5zBjgPBiposFeonCp6Ei0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/intc/armv7m: Support byte
 and halfword accesses to CFSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Andy Gross <andy.gross@linaro.org>, "patches@linaro.org" <patches@linaro.org>

Ping for code review?

thanks
-- PMM

On 8 December 2017 at 14:12, Peter Maydell <peter.maydell@linaro.org> wrote:
> The Configurable Fault Status Register for ARMv7M and v8M is
> supposed to be byte and halfword accessible, but we were only
> implementing word accesses. Add support for the other access
> sizes, which are used by the Zephyr RTOS.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reported-by: Andy Gross <andy.gross@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 5d9c883..dc8e2f1 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -896,13 +896,6 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
>              val |= (1 << 8);
>          }
>          return val;
> -    case 0xd28: /* Configurable Fault Status.  */
> -        /* The BFSR bits [15:8] are shared between security states
> -         * and we store them in the NS copy
> -         */
> -        val = cpu->env.v7m.cfsr[attrs.secure];
> -        val |= cpu->env.v7m.cfsr[M_REG_NS] & R_V7M_CFSR_BFSR_MASK;
> -        return val;
>      case 0xd2c: /* Hard Fault Status.  */
>          return cpu->env.v7m.hfsr;
>      case 0xd30: /* Debug Fault Status.  */
> @@ -1280,15 +1273,6 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
>          s->vectors[ARMV7M_EXCP_DEBUG].active = (value & (1 << 8)) != 0;
>          nvic_irq_update(s);
>          break;
> -    case 0xd28: /* Configurable Fault Status.  */
> -        cpu->env.v7m.cfsr[attrs.secure] &= ~value; /* W1C */
> -        if (attrs.secure) {
> -            /* The BFSR bits [15:8] are shared between security states
> -             * and we store them in the NS copy.
> -             */
> -            cpu->env.v7m.cfsr[M_REG_NS] &= ~(value & R_V7M_CFSR_BFSR_MASK);
> -        }
> -        break;
>      case 0xd2c: /* Hard Fault Status.  */
>          cpu->env.v7m.hfsr &= ~value; /* W1C */
>          break;
> @@ -1667,6 +1651,14 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
>              val = deposit32(val, i * 8, 8, get_prio(s, hdlidx, sbank));
>          }
>          break;
> +    case 0xd28 ... 0xd2b: /* Configurable Fault Status (CFSR) */
> +        /* The BFSR bits [15:8] are shared between security states
> +         * and we store them in the NS copy
> +         */
> +        val = s->cpu->env.v7m.cfsr[attrs.secure];
> +        val |= s->cpu->env.v7m.cfsr[M_REG_NS] & R_V7M_CFSR_BFSR_MASK;
> +        val = extract32(val, (offset - 0xd28) * 8, size * 8);
> +        break;
>      case 0xfe0 ... 0xfff: /* ID.  */
>          if (offset & 3) {
>              val = 0;
> @@ -1765,6 +1757,20 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
>          }
>          nvic_irq_update(s);
>          return MEMTX_OK;
> +    case 0xd28 ... 0xd2b: /* Configurable Fault Status (CFSR) */
> +        /* All bits are W1C, so construct 32 bit value with 0s in
> +         * the parts not written by the access size
> +         */
> +        value <<= ((offset - 0xd28) * 8);
> +
> +        s->cpu->env.v7m.cfsr[attrs.secure] &= ~value;
> +        if (attrs.secure) {
> +            /* The BFSR bits [15:8] are shared between security states
> +             * and we store them in the NS copy.
> +             */
> +            s->cpu->env.v7m.cfsr[M_REG_NS] &= ~(value & R_V7M_CFSR_BFSR_MASK);
> +        }
> +        return MEMTX_OK;
>      }
>      if (size == 4) {
>          nvic_writel(s, offset, value, attrs);
> --
> 2.7.4
