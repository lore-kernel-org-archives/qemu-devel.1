Received: from eggs.gnu.org ([2001:4830:134:3::10]:53286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fOls8-0004t8-W7
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fOls4-0002gk-1E
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:21:44 -0400
Received: from smtp44.i.mail.ru ([94.100.177.104]:43218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fOls3-0002eW-LV
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:21:39 -0400
References: <20180529220338.10879-1-jusual@mail.ru>
	<20180529220338.10879-3-jusual@mail.ru>
	<20180531094201.GH26429@stefanha-x1.localdomain>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <b695da95-3c7f-8b83-bb6a-bbdc727f4567@mail.ru>
Date: Fri, 1 Jun 2018 18:21:28 +0300
MIME-Version: 1.0
In-Reply-To: <20180531094201.GH26429@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 2/3] hw/char/nrf51_uart: Implement nRF51 SoC
 UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>

On 31.05.2018 12:42, Stefan Hajnoczi wrote:
 > On Wed, May 30, 2018 at 01:03:37AM +0300, Julia Suvorova wrote:
 >> The following features are not yet implemented:
 >>      Control with SUSPEND/START*/STOP*
 >
 > This is probably worth implementing for completeness.  Just rx_enabled
 > and tx_enabled boolean states will be sufficient.  SUSPEND flushes tx
 > and stops rx, it doesn't require any extra state.
 >
 >>      CTS/NCTS flow control
 >
 > CTS flow control is probably not necessary since we don't have bitwise
 > I/O and guest applications probably don't care either.
 >
 >>      Mapping registers to pins
 >
 > This is probably not necessary since the micro:bit only uses the UART in
 > one pin configuration (back to the USB interface chip).
 >
 > Please make sure that every register is explicitly handle in the code
 > and falls into these categories:
 >
 > 1. Implemented.
 > 2. Unimplemented - can be observed via a trace event.  This will make
 >     debugging easier in the future when an application doesn't work
 >     with the UART.
 > 3. Stubbed out - explicitly marked as ignored in the code.
 >
 > This way we can be confident about the completeness of this device
 > model.

I've definitely missed handling some registers, so marking it seems a
good idea.

 >> diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
 >> new file mode 100644
 >> index 0000000000..2da97aa0c4
 >> --- /dev/null
 >> +++ b/hw/char/nrf51_uart.c
 >> @@ -0,0 +1,232 @@
 >> +/*
 >> + * nRF51 SoC UART emulation
 >
 > Please add a reference to the hardware specfication here:
 >
 >    See nRF51 Series Reference Manual, "29 Universal Asynchronous
 >    Receiver/Transmitter" for hardware specifications:
 >    http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
 >

Sure, I'll add it.

 >> +static gboolean uart_transmit(GIOChannel *chan, GIOCondition cond, void *opaque)
 >> +{
 >> +    Nrf51UART *s = NRF51_UART(opaque);
 >> +    int r;
 >> +
 >> +    s->watch_tag = 0;
 >> +
 >> +    r = qemu_chr_fe_write(&s->chr, (uint8_t *) &s->reg[A_TXD], 1);
 >
 > This does not work on big-endian hosts:
 >
 >    s->reg[A_TXD] = 'A';
 >
 > little-endian memory layout: 41 00 00 00
 > big-endian memory layout:    00 00 00 41
 > (uint8_t *) &s->reg[A_TXD] --^
 >
 > Instead please use a uint8_t local:
 >
 >    uint8_t ch = s->reg[A_TXD];
 >
 >    ...
 >
 >    r = qemu_chr_fe_write(&s->chr, &ch, 1);
 >

A real bug! I'll fix this.

 >> +    if (r <= 0) {
 >> +        s->watch_tag = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
 >> +                                             uart_transmit, s);
 >> +        if (!s->watch_tag) {
 >> +            goto buffer_drained;
 >
 > Please add a comment here:
 >
 >    /* The hardware has no transmit error reporting, so silently drop the byte */
 >

The QEMU code is inconsistent with comments. Some files are full of
comments, some have only code. Is there any policy how to comment
the files?

 >> +static void uart_receive(void *opaque, const uint8_t *buf, int size)
 >> +{
 >> +
 >> +   Nrf51UART *s = NRF51_UART(opaque);
 >> +
 >> +   if (s->rx_fifo_len >= UART_FIFO_LENGTH) {
 >
 > Indentation is off.  Please use 4 spaces.

Sorry, have no idea how it happened.

 >> +        return;
 >> +    }
 >> +
 >> +    s->rx_fifo[(s->rx_fifo_pos + s->rx_fifo_len) % UART_FIFO_LENGTH] = *buf;
 >> +    s->rx_fifo_len++;
 >> +
 >> +    s->reg[A_RXDRDY] = 1;
 >> +    nrf51_uart_update_irq(s);
 >> +}
 >> +
 >> +static int uart_can_receive(void *opaque)
 >> +{
 >> +    Nrf51UART *s = NRF51_UART(opaque);
 >> +
 >> +    return (s->rx_fifo_len < sizeof(s->rx_fifo));
 >
 > This is very subtle: this function returns the number of bytes that can
 > be read.  This expression looks like a boolean return value but actually
 > relies on the implicit int cast (false -> 0 bytes, true -> 1 byte).
 >
 > Please write it so it doesn't look like a boolean return value:
 >
 >    if (s->rx_fifo_len >= sizeof(s->rx_fifo)) {
 >        return 0;
 >    }
 >
 >    return 1 /* byte */;
 >
 > Alternatively, you could handle more than 1 byte:
 >
 >    return sizeof(s->rx_fifo) - s->rx_fifo_len;
 >
 > but now uart_receive() needs to handle up to sizeof(s->rx_fifo) bytes of
 > data in a single call.

I will rewrite uart_receive function to accept many bytes at once.

 >> +}
 >> +
 >> +static void nrf51_uart_realize(DeviceState *dev, Error **errp)
 >> +{
 >> +    Nrf51UART *s = NRF51_UART(dev);
 >> +
 >> +    qemu_chr_fe_set_handlers(&s->chr, uart_can_receive, uart_receive,
 >> +                             NULL, NULL, s, NULL, true);
 >> +}
 >> +
 >> +static void nrf51_uart_init(Object *obj)
 >> +{
 >> +    Nrf51UART *s = NRF51_UART(obj);
 >> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 >> +
 >> +    memory_region_init_io(&s->mmio, obj, &uart_ops, s,
 >> +                          "nrf51_soc.uart", 0x1000);
 >
 > s/0x1000/UART_SIZE/

Should I just add a new define or move the existing one from nrf51_soc.c to
some header (or any other way to pass the UART_SIZE)?

Best regards, Julia Suvorova.
