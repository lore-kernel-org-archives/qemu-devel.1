Received: from eggs.gnu.org ([2001:4830:134:3::10]:37208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fp9SE-0003Ri-Bm
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fp9SD-0006vz-Fu
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:48:02 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fp9SD-0006vn-9S
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:48:01 -0400
Received: by mail-wm0-x243.google.com with SMTP id l2-v6so7172892wme.1
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 02:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180808210750.3915-1-jusual@mail.ru>
	<20180808210750.3915-2-jusual@mail.ru>
	<CAJSP0QUZERaC=YVe_eWJjtVdMt24Ngi7H5yU6a9anf59n+Zwfw@mail.gmail.com>
	<5a087618-751c-c562-6d41-630a9ced03f4@mail.ru>
In-Reply-To: <5a087618-751c-c562-6d41-630a9ced03f4@mail.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 13 Aug 2018 10:47:48 +0100
Message-ID: <CAJSP0QWxBtpeTt=4wBjemdTjQy_12DS+1PHZUvP2S48LcxWv7g@mail.gmail.com>
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

On Mon, Aug 13, 2018 at 10:08 AM Julia Suvorova <jusual@mail.ru> wrote:
> On 10.08.2018 09:02, Stefan Hajnoczi wrote:
> > On Wed, Aug 8, 2018 at 10:07 PM, Julia Suvorova <jusual@mail.ru> wrote:
> >> +static uint64_t uart_read(void *opaque, hwaddr addr, unsigned int size)
> >> +{
> >> +    NRF51UARTState *s = NRF51_UART(opaque);
> >> +    uint64_t r;
> >> +
> >> +    if (!s->enabled) {
> >> +        return 0;
> >> +    }
> >> +
> >> +    switch (addr) {
> >> +    case A_UART_RXD:
> >> +        r = s->rx_fifo[s->rx_fifo_pos];
> >> +        if (s->rx_started && s->rx_fifo_len) {
> >> +            qemu_chr_fe_accept_input(&s->chr);
> >
> > Should this be called after popping a byte from the rx fifo?  That way
> > .can_receive() will return true again.
>
> Could you explain more, please?

This calls into the chardev's ->chr_accept_input() function.  That
function may do anything it wants.

At this point we haven't popped a byte from our rx fifo yet, so if
->chr_accept_input() calls back into the chardev frontend (us!) it
sees that we cannot receive.  That's strange since we just told the
backend we want to accept input!

I haven't checked if there is any code path where this can happen, but
it's safer to first update internal state before letting the outside
world know that we can accept more input.

> >> +static void nrf51_uart_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    NRF51UARTState *s = NRF51_UART(dev);
> >> +
> >> +    qemu_chr_fe_set_handlers(&s->chr, uart_can_receive, uart_receive,
> >> +                             uart_event, NULL, s, NULL, true);
> >> +}
> >
> > unrealize() should set the handlers to NULL.  That way the device can
> > be removed without leaving callbacks registered.
>
> I don't know the reason, but almost all char devices do not implement
> this function. Maybe, because when you quit qemu, qemu_chr_cleanup() is called.

It's an assumption that on-board devices cannot be hot unplugged and
that the machine type stays alive until QEMU terminates.

Making this assumption saves 1 call to qemu_chr_fe_set_handlers().
The cost is that we cannot safely stop the system-on-chip because its
devices don't clean up properly.

Since cleanup is so trivial here I think it's worthwhile.

Stefan
