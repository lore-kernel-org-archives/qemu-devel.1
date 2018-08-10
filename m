Received: from eggs.gnu.org ([2001:4830:134:3::10]:45244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fo0VY-0003el-Dg
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fo0VX-00071B-EW
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:02:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fo0VX-00070c-7i
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:02:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id h14-v6so7165938wrw.13
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 23:02:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180808210750.3915-2-jusual@mail.ru>
References: <20180808210750.3915-1-jusual@mail.ru>
	<20180808210750.3915-2-jusual@mail.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 10 Aug 2018 07:02:41 +0100
Message-ID: <CAJSP0QUZERaC=YVe_eWJjtVdMt24Ngi7H5yU6a9anf59n+Zwfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hw/char: Implement nRF51 SoC UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On Wed, Aug 8, 2018 at 10:07 PM, Julia Suvorova <jusual@mail.ru> wrote:
> +static uint64_t uart_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    NRF51UARTState *s = NRF51_UART(opaque);
> +    uint64_t r;
> +
> +    if (!s->enabled) {
> +        return 0;
> +    }
> +
> +    switch (addr) {
> +    case A_UART_RXD:
> +        r = s->rx_fifo[s->rx_fifo_pos];
> +        if (s->rx_started && s->rx_fifo_len) {
> +            qemu_chr_fe_accept_input(&s->chr);

Should this be called after popping a byte from the rx fifo?  That way
.can_receive() will return true again.

> +static void nrf51_uart_realize(DeviceState *dev, Error **errp)
> +{
> +    NRF51UARTState *s = NRF51_UART(dev);
> +
> +    qemu_chr_fe_set_handlers(&s->chr, uart_can_receive, uart_receive,
> +                             uart_event, NULL, s, NULL, true);
> +}

unrealize() should set the handlers to NULL.  That way the device can
be removed without leaving callbacks registered.
