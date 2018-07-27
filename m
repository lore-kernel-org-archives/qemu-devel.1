Received: from eggs.gnu.org ([2001:4830:134:3::10]:38651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj6J7-0005E0-OR
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj6J6-00073l-R7
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:13:37 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1532701430.git.damien.hedde@greensocs.com>
	<81e37f79d335d17d8802f127d59f89e263c50136.1532701430.git.damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <113b1329-fbc8-31f3-1d6a-274c56472d50@amsat.org>
Date: Fri, 27 Jul 2018 14:13:25 -0300
MIME-Version: 1.0
In-Reply-To: <81e37f79d335d17d8802f127d59f89e263c50136.1532701430.git.damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] cadence_uart: add clock/power
 gating support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair@alistair23.me, mark.burton@greensocs.com, saipava@xilinx.com, qemu-arm@nongnu.org, luc.michel@greensocs.com

On 07/27/2018 11:37 AM, Damien Hedde wrote:
> Only discard input characters when unpowered/unclocked.
> As it is a sysbus device, mmio are already disabled when unpowered
> or unclocked.

This is common to all Chardev frontends (also Ethernet/CAN devices, see
NetClientInfo).

Maybe qemu_chr_fe_accept_input() can take a boolean, so when we disable
a device (power/clock), the char-fe code can discard characters for all
frontends?

> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  hw/char/cadence_uart.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index fbdbd463bb..dd51d9a087 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -335,8 +335,14 @@ static void uart_write_tx_fifo(CadenceUARTState *s, const uint8_t *buf,
>  static void uart_receive(void *opaque, const uint8_t *buf, int size)
>  {
>      CadenceUARTState *s = opaque;
> +    DeviceState *dev = DEVICE(s);
>      uint32_t ch_mode = s->r[R_MR] & UART_MR_CHMODE;
>  
> +    /* ignore characters if unpowered or unclocked */
> +    if (!dev->powered || !dev->clocked) {
> +        return;
> +    }
> +
>      if (ch_mode == NORMAL_MODE || ch_mode == ECHO_MODE) {
>          uart_write_rx_fifo(opaque, buf, size);
>      }
> @@ -348,8 +354,14 @@ static void uart_receive(void *opaque, const uint8_t *buf, int size)
>  static void uart_event(void *opaque, int event)
>  {
>      CadenceUARTState *s = opaque;
> +    DeviceState *dev = DEVICE(s);
>      uint8_t buf = '\0';
>  
> +    /* ignore event if we're unpowered or unclocked */
> +    if (!dev->powered || !dev->clocked) {
> +        return;
> +    }
> +
>      if (event == CHR_EVENT_BREAK) {
>          uart_write_rx_fifo(opaque, &buf, 1);
>      }
> @@ -516,10 +528,19 @@ static int cadence_uart_post_load(void *opaque, int version_id)
>      return 0;
>  }
>  
> +static int cadence_uart_pre_load(void *opaque)
> +{
> +    DeviceState *s = opaque;
> +    s->clocked = true;
> +    s->powered = true;
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_cadence_uart = {
>      .name = "cadence_uart",
> -    .version_id = 2,
> +    .version_id = 3,
>      .minimum_version_id = 2,
> +    .pre_load = cadence_uart_pre_load,
>      .post_load = cadence_uart_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(r, CadenceUARTState, CADENCE_UART_R_MAX),
> @@ -531,6 +552,8 @@ static const VMStateDescription vmstate_cadence_uart = {
>          VMSTATE_UINT32(tx_count, CadenceUARTState),
>          VMSTATE_UINT32(rx_wpos, CadenceUARTState),
>          VMSTATE_TIMER_PTR(fifo_trigger_handle, CadenceUARTState),
> +        VMSTATE_BOOL_V(powered, DeviceState, 3),
> +        VMSTATE_BOOL_V(clocked, DeviceState, 3),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> 
