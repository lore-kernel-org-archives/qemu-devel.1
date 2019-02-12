Received: from eggs.gnu.org ([209.51.188.92]:55076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtVsP-0007Bf-8p
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:05:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtVsN-00057H-Hn
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:05:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtVsN-00055B-2A
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:05:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id j125so2562209wmj.1
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 03:05:18 -0800 (PST)
References: <20190212105201.13795-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1df0da56-7abd-4688-0fed-6dc2bf10ebb6@redhat.com>
Date: Tue, 12 Feb 2019 12:05:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190212105201.13795-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/armsse: Fix miswiring of expansion
 IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 2/12/19 11:52 AM, Peter Maydell wrote:
> In commit 91c1e9fcbd7548db368 where we added dual-CPU support to
> the ARMSSE, we set up the wiring of the expansion IRQs via nested
> loops: the outer loop on 'i' loops for each CPU, and the inner loop
> on 'j' loops for each interrupt. Fix a typo which meant we were
> wiring every expansion IRQ line to external IRQ 0 on CPU 0 and
> to external IRQ 1 on CPU 1.
> 
> Fixes: 91c1e9fcbd7548db368 ("hw/arm/armsse: Support dual-CPU configuration")
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> It turns out that the ARM-TFM image I was using to test that
> I hadn't broken the mps2-an505 doesn't actually rely on any
> interrupts from the external devices...

How did you notice that, simply reviewing? Via 'info qtree'?

> 
>  hw/arm/armsse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
> index 5d53071a5a0..9a8c49547db 100644
> --- a/hw/arm/armsse.c
> +++ b/hw/arm/armsse.c
> @@ -565,7 +565,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
>          /* Connect EXP_IRQ/EXP_CPUn_IRQ GPIOs to the NVIC's lines 32 and up */
>          s->exp_irqs[i] = g_new(qemu_irq, s->exp_numirq);
>          for (j = 0; j < s->exp_numirq; j++) {
> -            s->exp_irqs[i][j] = qdev_get_gpio_in(cpudev, i + 32);
> +            s->exp_irqs[i][j] = qdev_get_gpio_in(cpudev, j + 32);
>          }
>          if (i == 0) {
>              gpioname = g_strdup("EXP_IRQ");
> 
