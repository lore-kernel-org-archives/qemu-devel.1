Received: from eggs.gnu.org ([2001:4830:134:3::10]:43637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7U44-0001Ng-UE
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7U40-0006FZ-PD
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:26:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7U40-0006Dr-GL
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:26:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id b19-v6so3879891wme.3
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 16:26:48 -0700 (PDT)
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
	<20181002142443.30976-9-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3814fb09-5be7-834a-72a8-80f2f6dc005d@redhat.com>
Date: Wed, 3 Oct 2018 01:26:45 +0200
MIME-Version: 1.0
In-Reply-To: <20181002142443.30976-9-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 8/9] hw/char/cadence_uart: add clock
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair@alistair23.me, mark.burton@greensocs.com, saipava@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com, konrad@adacore.com, luc.michel@greensocs.com

Hi Damien,

On 10/2/18 4:24 PM, Damien Hedde wrote:
> Add bus interface and uart reference clock inputs.
> 
> Note: it is hard to find out from the doc what is the behavior when only one
> of the clock is disabled.
> 
> The implemented behaviour is that register access needs both clock being active.
> 
> The bus interface control the mmios visibility

This sentence sounds odd.

> 
> The reference clock controls the baudrate generation. If it disabled,
> any input characters and events are ignored. Also register accesses are
> conditioned to the clock being enabled (but is it really the case in
> reality ?) and a guest error is triggerred if that is not the case.
> 
> If theses clocks remains unconnected, the uart behaves as before
> (default to 50MHz ref clock).
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  include/hw/char/cadence_uart.h |  3 ++
>  hw/char/cadence_uart.c         | 92 ++++++++++++++++++++++++++++++++--
>  hw/char/trace-events           |  3 ++
>  3 files changed, 93 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uart.h
> index 118e3f10de..fd1d4725f4 100644
> --- a/include/hw/char/cadence_uart.h
> +++ b/include/hw/char/cadence_uart.h
> @@ -21,6 +21,7 @@
>  #include "hw/sysbus.h"
>  #include "chardev/char-fe.h"
>  #include "qemu/timer.h"
> +#include "hw/clock-port.h"
>  
>  #define CADENCE_UART_RX_FIFO_SIZE           16
>  #define CADENCE_UART_TX_FIFO_SIZE           16
> @@ -47,6 +48,8 @@ typedef struct {
>      CharBackend chr;
>      qemu_irq irq;
>      QEMUTimer *fifo_trigger_handle;
> +    ClockIn *refclk;
> +    ClockIn *busclk;
>  } CadenceUARTState;
>  
>  static inline DeviceState *cadence_uart_create(hwaddr addr,
> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index fbdbd463bb..feb5cee4d7 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -28,6 +28,7 @@
>  #include "qemu/timer.h"
>  #include "qemu/log.h"
>  #include "hw/char/cadence_uart.h"
> +#include "trace.h"
>  
>  #ifdef CADENCE_UART_ERR_DEBUG
>  #define DB_PRINT(...) do { \
> @@ -94,7 +95,7 @@
>  #define LOCAL_LOOPBACK         (0x2 << UART_MR_CHMODE_SH)
>  #define REMOTE_LOOPBACK        (0x3 << UART_MR_CHMODE_SH)
>  
> -#define UART_INPUT_CLK         50000000
> +#define UART_DEFAULT_REF_CLK (50 * 1000 * 1000)
>  
>  #define R_CR       (0x00/4)
>  #define R_MR       (0x04/4)
> @@ -165,15 +166,30 @@ static void uart_send_breaks(CadenceUARTState *s)
>                        &break_enabled);
>  }
>  
> +static unsigned int uart_input_clk(CadenceUARTState *s)
> +{
> +    return clock_get_frequency(s->refclk);
> +}
> +
>  static void uart_parameters_setup(CadenceUARTState *s)
>  {
>      QEMUSerialSetParams ssp;
>      unsigned int baud_rate, packet_size;
>  
>      baud_rate = (s->r[R_MR] & UART_MR_CLKS) ?
> -            UART_INPUT_CLK / 8 : UART_INPUT_CLK;
> +            uart_input_clk(s) / 8 : uart_input_clk(s);
> +    baud_rate /= (s->r[R_BRGR] * (s->r[R_BDIV] + 1));

Safe because s->r[R_BRGR] >= 1, OK.

> +    trace_cadence_uart_baudrate(baud_rate);
> +
> +    ssp.speed = baud_rate;
> +    if (ssp.speed == 0) {
> +        /*
> +         * Avoid division-by-zero below.
> +         * TODO: find something better
> +         */
> +        ssp.speed = 1;
> +    }
>  
> -    ssp.speed = baud_rate / (s->r[R_BRGR] * (s->r[R_BDIV] + 1));
>      packet_size = 1;
>  
>      switch (s->r[R_MR] & UART_MR_PAR) {
> @@ -337,6 +353,11 @@ static void uart_receive(void *opaque, const uint8_t *buf, int size)
>      CadenceUARTState *s = opaque;
>      uint32_t ch_mode = s->r[R_MR] & UART_MR_CHMODE;
>  
> +    /* ignore characters when unclocked */
> +    if (!clock_is_enabled(s->refclk)) {
> +        return;
> +    }
> +
>      if (ch_mode == NORMAL_MODE || ch_mode == ECHO_MODE) {
>          uart_write_rx_fifo(opaque, buf, size);
>      }
> @@ -350,6 +371,11 @@ static void uart_event(void *opaque, int event)
>      CadenceUARTState *s = opaque;
>      uint8_t buf = '\0';
>  
> +    /* ignore events when unclocked */
> +    if (!clock_is_enabled(s->refclk)) {
> +        return;
> +    }
> +
>      if (event == CHR_EVENT_BREAK) {
>          uart_write_rx_fifo(opaque, &buf, 1);
>      }
> @@ -382,6 +408,14 @@ static void uart_write(void *opaque, hwaddr offset,
>  {
>      CadenceUARTState *s = opaque;
>  
> +    /* ignore accesses when bus or ref clock is disabled */
> +    if (!(clock_is_enabled(s->busclk) && clock_is_enabled(s->refclk))) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "cadence_uart: Trying to write register 0x%x"
> +                " while clock is disabled\n", (unsigned) offset);
> +        return;
> +    }
> +
>      DB_PRINT(" offset:%x data:%08x\n", (unsigned)offset, (unsigned)value);
>      offset >>= 2;
>      if (offset >= CADENCE_UART_R_MAX) {
> @@ -440,6 +474,14 @@ static uint64_t uart_read(void *opaque, hwaddr offset,
>      CadenceUARTState *s = opaque;
>      uint32_t c = 0;
>  
> +    /* ignore accesses when bus or ref clock is disabled */
> +    if (!(clock_is_enabled(s->busclk) && clock_is_enabled(s->refclk))) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "cadence_uart: Trying to read register 0x%x"
> +                " while clock is disabled\n", (unsigned) offset);
> +        return 0;
> +    }
> +
>      offset >>= 2;
>      if (offset >= CADENCE_UART_R_MAX) {
>          c = 0;
> @@ -488,6 +530,14 @@ static void cadence_uart_realize(DeviceState *dev, Error **errp)
>                               uart_event, NULL, s, NULL, true);
>  }
>  
> +static void cadence_uart_refclk_update(void *opaque)
> +{
> +    CadenceUARTState *s = opaque;
> +
> +    /* recompute uart's speed on clock change */
> +    uart_parameters_setup(s);
> +}
> +
>  static void cadence_uart_init(Object *obj)
>  {
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> @@ -497,9 +547,26 @@ static void cadence_uart_init(Object *obj)
>      sysbus_init_mmio(sbd, &s->iomem);
>      sysbus_init_irq(sbd, &s->irq);
>  
> +    s->refclk = qdev_init_clock_in(DEVICE(obj), "refclk",
> +            cadence_uart_refclk_update, s);
> +    /* initialize the frequency in case the clock remains unconnected */
> +    clock_init_frequency(s->refclk, UART_DEFAULT_REF_CLK);
> +    s->busclk = qdev_init_clock_in(DEVICE(obj), "busclk", NULL, NULL);
> +    /* initialize the frequency to non-zero in case it remains unconnected */
> +    clock_init_frequency(s->busclk, 100 * 1000 * 1000);

#define INPUT_BUS_CLK_FREQUENCY (100 * 1000 * 1000)

> +
>      s->char_tx_time = (NANOSECONDS_PER_SECOND / 9600) * 10;
>  }
>  
> +static int cadence_uart_pre_load(void *opaque)
> +{
> +    CadenceUARTState *s = opaque;
> +
> +    clock_init_frequency(s->refclk, UART_DEFAULT_REF_CLK);
> +    clock_init_frequency(s->busclk, 100 * 1000 * 1000);

INPUT_BUS_CLK_FREQUENCY

> +    return 0;
> +}
> +
>  static int cadence_uart_post_load(void *opaque, int version_id)
>  {
>      CadenceUARTState *s = opaque;
> @@ -516,10 +583,22 @@ static int cadence_uart_post_load(void *opaque, int version_id)
>      return 0;
>  }
>  
> +static const VMStateDescription vmstate_cadence_uart_clocks = {
> +    .name = "cadence_uart_clocks",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_CLOCKIN(refclk, CadenceUARTState),
> +        VMSTATE_CLOCKIN(busclk, CadenceUARTState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_cadence_uart = {
>      .name = "cadence_uart",
>      .version_id = 2,
>      .minimum_version_id = 2,
> +    .pre_load = cadence_uart_pre_load,
>      .post_load = cadence_uart_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(r, CadenceUARTState, CADENCE_UART_R_MAX),
> @@ -532,7 +611,10 @@ static const VMStateDescription vmstate_cadence_uart = {
>          VMSTATE_UINT32(rx_wpos, CadenceUARTState),
>          VMSTATE_TIMER_PTR(fifo_trigger_handle, CadenceUARTState),
>          VMSTATE_END_OF_LIST()
> -    }
> +    },
> +    .subsections = (const VMStateDescription * []) {
> +        &vmstate_cadence_uart_clocks,
> +    },
>  };
>  
>  static Property cadence_uart_properties[] = {
> @@ -548,7 +630,7 @@ static void cadence_uart_class_init(ObjectClass *klass, void *data)
>      dc->vmsd = &vmstate_cadence_uart;
>      dc->reset = cadence_uart_reset;
>      dc->props = cadence_uart_properties;
> -  }
> +}
>  
>  static const TypeInfo cadence_uart_info = {
>      .name          = TYPE_CADENCE_UART,
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index b64213d4dd..2ea25d1ea1 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -73,3 +73,6 @@ cmsdk_apb_uart_receive(uint8_t c) "CMSDK APB UART: got character 0x%x from backe
>  cmsdk_apb_uart_tx_pending(void) "CMSDK APB UART: character send to backend pending"
>  cmsdk_apb_uart_tx(uint8_t c) "CMSDK APB UART: character 0x%x sent to backend"
>  cmsdk_apb_uart_set_params(int speed) "CMSDK APB UART: params set to %d 8N1"
> +
> +# hw/char/cadence_uart.c
> +cadence_uart_baudrate(unsigned baudrate) "baudrate %u"
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Except migration:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
