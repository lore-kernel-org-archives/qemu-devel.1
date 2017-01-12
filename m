Received: from eggs.gnu.org ([2001:4830:134:3::10]:36377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cRn8D-0001oB-QR
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cRn8C-0002W1-V0
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:42:01 -0500
Date: Thu, 12 Jan 2017 22:41:52 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170112214152.GB9606@toto>
References: <1484073849-32666-1-git-send-email-peter.maydell@linaro.org>
	<1484073849-32666-3-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484073849-32666-3-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] target/arm: Handle VIRQ and VFIQ in
 arm_cpu_do_interrupt_aarch32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Tue, Jan 10, 2017 at 06:44:08PM +0000, Peter Maydell wrote:
> To run a VM in 32-bit EL1 our AArch32 interrupt handling code
> needs to be able to cope with VIRQ and VFIQ exceptions.
> These behave like IRQ and FIQ except that we don't need to try
> to route them to Monitor mode.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

We could possibly avoid some duplication with EXCP_IRQ and _FIQ
but either way works:

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/arm/helper.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8dcabbf..dc90986 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6403,6 +6403,20 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
>          }
>          offset = 4;
>          break;
> +    case EXCP_VIRQ:
> +        new_mode = ARM_CPU_MODE_IRQ;
> +        addr = 0x18;
> +        /* Disable IRQ and imprecise data aborts.  */
> +        mask = CPSR_A | CPSR_I;
> +        offset = 4;
> +        break;
> +    case EXCP_VFIQ:
> +        new_mode = ARM_CPU_MODE_FIQ;
> +        addr = 0x1c;
> +        /* Disable FIQ, IRQ and imprecise data aborts.  */
> +        mask = CPSR_A | CPSR_I | CPSR_F;
> +        offset = 4;
> +        break;
>      case EXCP_SMC:
>          new_mode = ARM_CPU_MODE_MON;
>          addr = 0x08;
> -- 
> 2.7.4
> 
