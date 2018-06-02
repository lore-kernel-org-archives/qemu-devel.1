Received: from eggs.gnu.org ([2001:4830:134:3::10]:33619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fP1he-0003OE-QG
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 04:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fP1hd-0002Ic-QV
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 04:15:58 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:42248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fP1hd-0002HK-Ih
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 04:15:57 -0400
Received: by mail-wr0-x244.google.com with SMTP id w10-v6so38331727wrk.9
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 01:15:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9uNfZQNoOLPoOvz=j=tWxJZOiWLwpNFn2+ieHLQ43MqA@mail.gmail.com>
References: <20180529220338.10879-1-jusual@mail.ru>
	<20180529220338.10879-3-jusual@mail.ru>
	<20180531094201.GH26429@stefanha-x1.localdomain>
	<b695da95-3c7f-8b83-bb6a-bbdc727f4567@mail.ru>
	<CAFEAcA9uNfZQNoOLPoOvz=j=tWxJZOiWLwpNFn2+ieHLQ43MqA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 2 Jun 2018 09:15:56 +0100
Message-ID: <CAJSP0QV5tpoF2pW_xGweeeFjfi+cWaK7LgWvOnFHX+BP2xpsEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Julia Suvorova <jusual@mail.ru>, qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On Fri, Jun 1, 2018 at 4:58 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 1 June 2018 at 16:21, Julia Suvorova <jusual@mail.ru> wrote:
>> On 31.05.2018 12:42, Stefan Hajnoczi wrote:
>>>> +static int uart_can_receive(void *opaque)
>>>> +{
>>>> +    Nrf51UART *s = NRF51_UART(opaque);
>>>> +
>>>> +    return (s->rx_fifo_len < sizeof(s->rx_fifo));
>>>
>>> This is very subtle: this function returns the number of bytes that can
>>> be read.  This expression looks like a boolean return value but actually
>>> relies on the implicit int cast (false -> 0 bytes, true -> 1 byte).
>>>
>>> Please write it so it doesn't look like a boolean return value:
>>>
>>>    if (s->rx_fifo_len >= sizeof(s->rx_fifo)) {
>>>        return 0;
>>>    }
>>>
>>>    return 1 /* byte */;
>>>
>>> Alternatively, you could handle more than 1 byte:
>>>
>>>    return sizeof(s->rx_fifo) - s->rx_fifo_len;
>>>
>>> but now uart_receive() needs to handle up to sizeof(s->rx_fifo) bytes of
>>> data in a single call.
>>
>> I will rewrite uart_receive function to accept many bytes at once.
>
> Stefan, I was wondering about this when I read this patch.
> What is the API for the can_receive and receive functions?
> There's no documentation of the semantics either with the
> IOReadHandler or IOCanReadHandler typedefs in main-loop.h,
> or in the doc comment for qemu_chr_fe_set_handlers.
>
> I'm guessing that the answer is "your can_read handler should
> return the number of bytes you can accept, and a subsequent call
> to the read handler then must accept that many bytes, it can't
> change its mind and only accept a smaller number" (with some sort
> of guarantee by the caller that it won't let guest execution or
> other simulation-changes things between the call to can_receive
> and receive) ?
>
> (Similarly we don't document the semantics for the NetClientInfo
> can_receive and receive functions.)

I'll send documentation patches.

Stefan
