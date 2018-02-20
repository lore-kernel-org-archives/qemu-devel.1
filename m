Received: from eggs.gnu.org ([2001:4830:134:3::10]:34438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1eoGv1-0004Z0-MX
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 18:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1eoGux-0007Js-FF
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 18:01:51 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34537)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrew@aj.id.au>) id 1eoGux-0007IT-3C
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 18:01:47 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id DD79320B3E
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 18:01:43 -0500 (EST)
Message-Id: <1519167703.477897.1277678272.3A13B01C@webmail.messagingengine.com>
From: Andrew Jeffery <andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <20180220132627.4163-1-hlandau@devever.net>
Date: Wed, 21 Feb 2018 09:31:43 +1030
References: <20180220132627.4163-1-hlandau@devever.net>
Subject: Re: [Qemu-devel] [PATCH] Fix ast2500 protection register emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Tue, 20 Feb 2018, at 23:56, Hugo Landau wrote:
> Some register blocks of the ast2500 are protected by protection key
> registers which require the right magic value to be written to those
> registers to allow those registers to be mutated.
> 
> Register manuals indicate that writing the correct magic value to these
> registers should cause subsequent reads from those values to return 1,
> and writing any other value should cause subsequent reads to return 0.
> 
> Previously, qemu implemented these registers incorrectly: the registers
> were handled as simple memory, meaning that writing some value x to a
> protection key register would result in subsequent reads from that
> register returning the same value x. The protection was implemented by
> ensuring that the current value of that register equaled the magic
> value.
> 
> This modifies qemu to have the correct behaviour: attempts to write to a
> ast2500 protection register results in a transition to 1 or 0 depending
> on whether the written value is the correct magic. The protection logic
> is updated to ensure that the value of the register is nonzero.
> 
> This bug caused deadlocks with u-boot HEAD: when u-boot is done with a
> protectable register block, it attempts to lock it by writing the
> bitwise inverse of the correct magic value, and then spinning forever
> until the register reads as zero. Since qemu implemented writes to these
> registers as ordinary memory writes, writing the inverse of the magic
> value resulted in subsequent reads returning that value, leading to
> u-boot spinning forever.
> 
> Signed-off-by: Hugo Landau <hlandau@devever.net>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  hw/misc/aspeed_scu.c  | 6 +++++-
>  hw/misc/aspeed_sdmc.c | 8 +++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 74537ce975..5e6d5744ee 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -191,7 +191,7 @@ static void aspeed_scu_write(void *opaque, hwaddr 
> offset, uint64_t data,
>      }
>  
>      if (reg > PROT_KEY && reg < CPU2_BASE_SEG1 &&
> -            s->regs[PROT_KEY] != ASPEED_SCU_PROT_KEY) {
> +            !s->regs[PROT_KEY]) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", 
> __func__);
>          return;
>      }
> @@ -199,6 +199,10 @@ static void aspeed_scu_write(void *opaque, hwaddr 
> offset, uint64_t data,
>      trace_aspeed_scu_write(offset, size, data);
>  
>      switch (reg) {
> +    case PROT_KEY:
> +        s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
> +        return;
> +
>      case FREQ_CNTR_EVAL:
>      case VGA_SCRATCH1 ... VGA_SCRATCH8:
>      case RNG_DATA:
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index f0b3053fae..265171ee42 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -110,7 +110,12 @@ static void aspeed_sdmc_write(void *opaque, hwaddr 
> addr, uint64_t data,
>          return;
>      }
>  
> -    if (addr != R_PROT && s->regs[R_PROT] != PROT_KEY_UNLOCK) {
> +    if (addr == R_PROT) {
> +      s->regs[addr] = (data == PROT_KEY_UNLOCK) ? 1 : 0;
> +      return;
> +    }
> +
> +    if (!s->regs[R_PROT]) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked!\n", 
> __func__);
>          return;
>      }
> @@ -123,6 +128,7 @@ static void aspeed_sdmc_write(void *opaque, hwaddr 
> addr, uint64_t data,
>              data &= ~ASPEED_SDMC_READONLY_MASK;
>              break;
>          case AST2500_A0_SILICON_REV:
> +        case AST2500_A1_SILICON_REV:
>              data &= ~ASPEED_SDMC_AST2500_READONLY_MASK;
>              break;
>          default:
> -- 
> 2.15.0
> 
> 
