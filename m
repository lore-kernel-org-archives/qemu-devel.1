Received: from eggs.gnu.org ([2001:4830:134:3::10]:54772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOK5y-0000UF-84
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOK5t-00069k-A6
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:42:10 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOK5s-00068n-Tf
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:42:05 -0400
Received: by mail-wr0-x242.google.com with SMTP id f16-v6so17000856wrm.3
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 02:42:04 -0700 (PDT)
Date: Thu, 31 May 2018 10:42:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180531094201.GH26429@stefanha-x1.localdomain>
References: <20180529220338.10879-1-jusual@mail.ru>
	<20180529220338.10879-3-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jHkwA2TBA/ec6v+"
Content-Disposition: inline
In-Reply-To: <20180529220338.10879-3-jusual@mail.ru>
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
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>


--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 01:03:37AM +0300, Julia Suvorova wrote:
> The following features are not yet implemented:
>     Control with SUSPEND/START*/STOP*

This is probably worth implementing for completeness.  Just rx_enabled
and tx_enabled boolean states will be sufficient.  SUSPEND flushes tx
and stops rx, it doesn't require any extra state.

>     CTS/NCTS flow control

CTS flow control is probably not necessary since we don't have bitwise
I/O and guest applications probably don't care either.

>     Mapping registers to pins

This is probably not necessary since the micro:bit only uses the UART in
one pin configuration (back to the USB interface chip).

Please make sure that every register is explicitly handle in the code
and falls into these categories:

1. Implemented.
2. Unimplemented - can be observed via a trace event.  This will make
   debugging easier in the future when an application doesn't work
   with the UART.
3. Stubbed out - explicitly marked as ignored in the code.

This way we can be confident about the completeness of this device
model.

> diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
> new file mode 100644
> index 0000000000..2da97aa0c4
> --- /dev/null
> +++ b/hw/char/nrf51_uart.c
> @@ -0,0 +1,232 @@
> +/*
> + * nRF51 SoC UART emulation

Please add a reference to the hardware specfication here:

  See nRF51 Series Reference Manual, "29 Universal Asynchronous
  Receiver/Transmitter" for hardware specifications:
  http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf

> +static gboolean uart_transmit(GIOChannel *chan, GIOCondition cond, void *opaque)
> +{
> +    Nrf51UART *s = NRF51_UART(opaque);
> +    int r;
> +
> +    s->watch_tag = 0;
> +
> +    r = qemu_chr_fe_write(&s->chr, (uint8_t *) &s->reg[A_TXD], 1);

This does not work on big-endian hosts:

  s->reg[A_TXD] = 'A';

little-endian memory layout: 41 00 00 00
big-endian memory layout:    00 00 00 41
(uint8_t *) &s->reg[A_TXD] --^

Instead please use a uint8_t local:

  uint8_t ch = s->reg[A_TXD];

  ...

  r = qemu_chr_fe_write(&s->chr, &ch, 1);

> +    if (r <= 0) {
> +        s->watch_tag = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> +                                             uart_transmit, s);
> +        if (!s->watch_tag) {
> +            goto buffer_drained;

Please add a comment here:

  /* The hardware has no transmit error reporting, so silently drop the byte */

> +static void uart_receive(void *opaque, const uint8_t *buf, int size)
> +{
> +
> +   Nrf51UART *s = NRF51_UART(opaque);
> +
> +   if (s->rx_fifo_len >= UART_FIFO_LENGTH) {

Indentation is off.  Please use 4 spaces.

> +        return;
> +    }
> +
> +    s->rx_fifo[(s->rx_fifo_pos + s->rx_fifo_len) % UART_FIFO_LENGTH] = *buf;
> +    s->rx_fifo_len++;
> +
> +    s->reg[A_RXDRDY] = 1;
> +    nrf51_uart_update_irq(s);
> +}
> +
> +static int uart_can_receive(void *opaque)
> +{
> +    Nrf51UART *s = NRF51_UART(opaque);
> +
> +    return (s->rx_fifo_len < sizeof(s->rx_fifo));

This is very subtle: this function returns the number of bytes that can
be read.  This expression looks like a boolean return value but actually
relies on the implicit int cast (false -> 0 bytes, true -> 1 byte).

Please write it so it doesn't look like a boolean return value:

  if (s->rx_fifo_len >= sizeof(s->rx_fifo)) {
      return 0;
  }

  return 1 /* byte */;

Alternatively, you could handle more than 1 byte:

  return sizeof(s->rx_fifo) - s->rx_fifo_len;

but now uart_receive() needs to handle up to sizeof(s->rx_fifo) bytes of
data in a single call.

> +}
> +
> +static void nrf51_uart_realize(DeviceState *dev, Error **errp)
> +{
> +    Nrf51UART *s = NRF51_UART(dev);
> +
> +    qemu_chr_fe_set_handlers(&s->chr, uart_can_receive, uart_receive,
> +                             NULL, NULL, s, NULL, true);
> +}
> +
> +static void nrf51_uart_init(Object *obj)
> +{
> +    Nrf51UART *s = NRF51_UART(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &uart_ops, s,
> +                          "nrf51_soc.uart", 0x1000);

s/0x1000/UART_SIZE/

> +typedef struct Nrf51UART {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    CharBackend chr;
> +    qemu_irq irq;
> +    guint watch_tag;
> +
> +    uint8_t rx_fifo[UART_FIFO_LENGTH];
> +    unsigned int rx_fifo_pos;
> +    unsigned int rx_fifo_len;
> +
> +    uint32_t reg[0x1000];

Where does 0x1000 come from?  I think the actual 0x1000-byte range would
be uint32_t reg[UART_SIZE / sizeof(reg[0])].

--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD8NpAAoJEJykq7OBq3PII4YH/iJRxxCJDj7OLvzGaTgQk/s7
wyKKmR2b8PAoqRYjGLnyRyMNoY8r5g+FrjAlEXL4dcBkp0nwfmOXBhbq6AkUTvcU
rzpTuCIeIcs77Qc+gOCxJoBauwr5rjE/0gGV8Yu6hX8PKk2FxlraO//368rZQhh2
XqPwKwX8MhmmDtQFyzfRvcsy/MSJcX4WHIu1HoJ0viajpAbNkVLNoKOsXfCVs8V/
UunK4OTiE6RdYmnocJ6/KL6AzVks00a95dpj0EMCIXrZhir7j2dytAl6Q2bTstJS
8l81eZsI2myEAoBGaIUIKUNzaVyrxDiY+AnPbyomt0QS1DxtN5fKCOmED3nqXD8=
=pFik
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--
