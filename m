Received: from eggs.gnu.org ([2001:4830:134:3::10]:36453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drnxG-0007gT-NN
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drnxF-0005Uz-T4
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:22:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1505232834-20890-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ca218563-0789-f11d-fa7b-895998a1a84d@amsat.org>
Date: Tue, 12 Sep 2017 13:22:19 -0300
MIME-Version: 1.0
In-Reply-To: <1505232834-20890-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] mps2-an511: Fix wiring of UART overflow
 interrupt lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, patches@linaro.org, qemu-arm@nongnu.org

(CC'ed qemu-arm)

Hi Peter,

On 09/12/2017 01:13 PM, Peter Maydell wrote:
> Fix an error that meant we were wiring every UART's overflow
> interrupts into the same inputs 0 and 1 of the OR gate,
> rather than giving each its own input.

oops tricky to catch

> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/mps2.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
> index abb0ab6..769cff8 100644
> --- a/hw/arm/mps2.c
> +++ b/hw/arm/mps2.c

         /* The overflow IRQs for all UARTs are ORed together.
          * Tx and Rx IRQs for each UART are ORed together.
          */

can you update this comment?

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> @@ -287,8 +287,8 @@ static void mps2_common_init(MachineState *machine)
>               cmsdk_apb_uart_create(uartbase[i],
>                                     qdev_get_gpio_in(txrx_orgate_dev, 0),
>                                     qdev_get_gpio_in(txrx_orgate_dev, 1),
> -                                  qdev_get_gpio_in(orgate_dev, 0),
> -                                  qdev_get_gpio_in(orgate_dev, 1),
> +                                  qdev_get_gpio_in(orgate_dev, i * 2),
> +                                  qdev_get_gpio_in(orgate_dev, i * 2 + 1),
>                                     NULL,
>                                     uartchr, SYSCLK_FRQ);
>           }
> 
