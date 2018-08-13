Received: from eggs.gnu.org ([2001:4830:134:3::10]:57139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fp8pm-0001Km-RZ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fp8pj-0000r2-IV
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:08:18 -0400
Received: from smtp29.i.mail.ru ([94.100.177.89]:52938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fp8pj-0000qD-4u
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:08:15 -0400
References: <20180808210750.3915-1-jusual@mail.ru>
	<20180808210750.3915-2-jusual@mail.ru>
	<CAJSP0QUZERaC=YVe_eWJjtVdMt24Ngi7H5yU6a9anf59n+Zwfw@mail.gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <5a087618-751c-c562-6d41-630a9ced03f4@mail.ru>
Date: Mon, 13 Aug 2018 12:08:06 +0300
MIME-Version: 1.0
In-Reply-To: <CAJSP0QUZERaC=YVe_eWJjtVdMt24Ngi7H5yU6a9anf59n+Zwfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hw/char: Implement nRF51 SoC UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>

On 10.08.2018 09:02, Stefan Hajnoczi wrote:
> On Wed, Aug 8, 2018 at 10:07 PM, Julia Suvorova <jusual@mail.ru> wrote:
>> +static uint64_t uart_read(void *opaque, hwaddr addr, unsigned int size)
>> +{
>> +    NRF51UARTState *s = NRF51_UART(opaque);
>> +    uint64_t r;
>> +
>> +    if (!s->enabled) {
>> +        return 0;
>> +    }
>> +
>> +    switch (addr) {
>> +    case A_UART_RXD:
>> +        r = s->rx_fifo[s->rx_fifo_pos];
>> +        if (s->rx_started && s->rx_fifo_len) {
>> +            qemu_chr_fe_accept_input(&s->chr);
> 
> Should this be called after popping a byte from the rx fifo?  That way
> .can_receive() will return true again.

Could you explain more, please?

>> +static void nrf51_uart_realize(DeviceState *dev, Error **errp)
>> +{
>> +    NRF51UARTState *s = NRF51_UART(dev);
>> +
>> +    qemu_chr_fe_set_handlers(&s->chr, uart_can_receive, uart_receive,
>> +                             uart_event, NULL, s, NULL, true);
>> +}
> 
> unrealize() should set the handlers to NULL.  That way the device can
> be removed without leaving callbacks registered.

I don't know the reason, but almost all char devices do not implement
this function. Maybe, because when you quit qemu, qemu_chr_cleanup() is called.

Best regards, Julia Suvorova.
