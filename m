Received: from eggs.gnu.org ([2001:4830:134:3::10]:52847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1erLm7-0004SN-Fz
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1erLm6-0008G0-Ki
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:23 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1519898536-19027-1-git-send-email-frederic.konrad@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1625eda8-021b-b7bc-2c41-f87724b95efa@amsat.org>
Date: Thu, 1 Mar 2018 07:49:13 -0300
MIME-Version: 1.0
In-Reply-To: <1519898536-19027-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] grlib_apbuart: always
 enable tx and rx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mark.cave-ayland@ilande.co.uk, jcd@tribudubois.net

Hi Frederic,

On 03/01/2018 07:02 AM, KONRAD Frederic wrote:
> We often use a bootloader for this board. So lets set the uart in a state
> which it can emit characters as if we were using a bootloader.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  hw/char/grlib_apbuart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
> index bac11be..a8020ea 100644
> --- a/hw/char/grlib_apbuart.c
> +++ b/hw/char/grlib_apbuart.c
> @@ -265,8 +265,8 @@ static void grlib_apbuart_reset(DeviceState *d)
>  
>      /* Transmitter FIFO and shift registers are always empty in QEMU */
>      uart->status =  UART_TRANSMIT_FIFO_EMPTY | UART_TRANSMIT_SHIFT_EMPTY;
> -    /* Everything is off */
> -    uart->control = 0;
> +    /* Enable Tx and Rx as the bootloader would do */
> +    uart->control = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE;

I don't think this is the correct approach, as we want to reflect the
real hardware behavior here.

I think the correct QEMU-way is add a tiny asm bootloader in ram in
leon3_generic_hw_init(), which enables the UART.
See write_bootloader() in hw/mips/mips_fulong2e.c for example.

Regards,

Phil.

>      /* Flush receive FIFO */
>      uart->len = 0;
>      uart->current = 0;
> 
