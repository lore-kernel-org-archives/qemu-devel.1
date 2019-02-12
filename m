Received: from eggs.gnu.org ([209.51.188.92]:38888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtck5-0001Xq-6H
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtck4-0004NK-Cx
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:25:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtck4-0004Hv-7O
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:25:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so4093449wmj.0
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 10:25:08 -0800 (PST)
References: <20190212181917.8322-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fdf9bc20-2694-107e-4e27-d5db7616a367@redhat.com>
Date: Tue, 12 Feb 2019 19:25:05 +0100
MIME-Version: 1.0
In-Reply-To: <20190212181917.8322-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/intc/armv7m_nvic: Allow byte accesses
 to SHPR1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Julia Suvorova <jusual@mail.ru>, patches@linaro.org

Hi Peter,

On 2/12/19 7:19 PM, Peter Maydell wrote:
> The code for handling the NVIC SHPR1 register intends to permit
> byte and halfword accesses (as the architecture requires). However
> the 'case' line for it only lists the base address of the
> register, so attempts to access bytes other than the first one
> end up in the "bad write" default logic. This bug was added
> accidentally when we split out the SHPR1 logic from SHPR2 and
> SHPR3 to support v6M.
> 
> Fixes: 7c9140afd594 ("nvic: Handle ARMv6-M SCS reserved registers")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The Zephyr RTOS happens to access SHPR1 byte at a time,
> which is how I spotted this.
> ---
>  hw/intc/armv7m_nvic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 790a3d95849..2fd40f9dc4c 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1956,7 +1956,7 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
>          }
>          nvic_irq_update(s);
>          return MEMTX_OK;
> -    case 0xd18: /* System Handler Priority (SHPR1) */
> +    case 0xd18 ... 0xd1b: /* System Handler Priority (SHPR1) */

Can you fix the nvic_sysreg_read() case too?

With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>          if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
>              return MEMTX_OK;
>          }
> 
