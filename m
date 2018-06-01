Received: from eggs.gnu.org ([2001:4830:134:3::10]:60534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOmSL-0002FE-3R
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOmSJ-0006nU-VF
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:59:09 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:34737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOmSJ-0006nI-PK
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:59:07 -0400
Received: by mail-ot0-x242.google.com with SMTP id i5-v6so29860751otf.1
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 08:59:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b695da95-3c7f-8b83-bb6a-bbdc727f4567@mail.ru>
References: <20180529220338.10879-1-jusual@mail.ru>
	<20180529220338.10879-3-jusual@mail.ru>
	<20180531094201.GH26429@stefanha-x1.localdomain>
	<b695da95-3c7f-8b83-bb6a-bbdc727f4567@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Jun 2018 16:58:46 +0100
Message-ID: <CAFEAcA9uNfZQNoOLPoOvz=j=tWxJZOiWLwpNFn2+ieHLQ43MqA@mail.gmail.com>
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
To: Julia Suvorova <jusual@mail.ru>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 1 June 2018 at 16:21, Julia Suvorova <jusual@mail.ru> wrote:
> On 31.05.2018 12:42, Stefan Hajnoczi wrote:
>> Please add a comment here:
>>
>>    /* The hardware has no transmit error reporting, so silently drop the
>> byte */
>>
>
> The QEMU code is inconsistent with comments. Some files are full of
> comments, some have only code. Is there any policy how to comment
> the files?

The only policy we have written down is that you should use /* */
even for one-line comments.
    /* one line comments like this */

We're inconsistent about how to format multiline comments, but
my preference for the arm parts of the codebase is:
    /* multi line comments look
     * like this
     */

For the actual content of comments:
 * comments generally should describe the 'why' rather than the 'what'
   (but not "why did we change this?", which goes in the commit message)
 * comments are helpful where the code looks wrong or strange
   (as an indication of "this is deliberate and this is why";
   Stefan's suggested comment above is in this category). If
   there's a way to write the code that doesn't look wrong then
   that's obviously preferable :-)
 * you don't need to comment things that are obvious from just
   reading the code
 * I prefer to err on the side of more comments rather than fewer
 * you don't need to replicate lots of info that's in the data sheet,
   but don't assume your readers know all the weird corners of the
   hardware behaviour inside-out, either
 * known missing or broken things can be commented with TODO or
   FIXME comments (but if you have too many of these for easy things
   we may ask you to just fix some of them :-))

Code reviewers will let you know if you've got the balance wrong.

As a special case:
 * any new function with global scope should have a doc-comment
   (starts with "/**") describing its purpose and API

Optionally:
 * for a few recent devices I thought it was useful to document
   in their header what the "QEMU interface" (what the various
   QOM properties, named GPIO outputs, inputs, etc are). You can
   see examples with 'grep "QEMU interface" include/'. If that seems
   helpful, feel free to have a comment like that; if not, skip it.

Overall advice: QEMU is a large code base, and it has both new
and well maintained parts and also very old parts that are
unloved and often use no-longer-recommended style or APIs.
When you're looking around for examples to copy the style of,
it's better to try to find something that's been added or
overhauled recently.

>>> +static int uart_can_receive(void *opaque)
>>> +{
>>> +    Nrf51UART *s = NRF51_UART(opaque);
>>> +
>>> +    return (s->rx_fifo_len < sizeof(s->rx_fifo));
>>
>> This is very subtle: this function returns the number of bytes that can
>> be read.  This expression looks like a boolean return value but actually
>> relies on the implicit int cast (false -> 0 bytes, true -> 1 byte).
>>
>> Please write it so it doesn't look like a boolean return value:
>>
>>    if (s->rx_fifo_len >= sizeof(s->rx_fifo)) {
>>        return 0;
>>    }
>>
>>    return 1 /* byte */;
>>
>> Alternatively, you could handle more than 1 byte:
>>
>>    return sizeof(s->rx_fifo) - s->rx_fifo_len;
>>
>> but now uart_receive() needs to handle up to sizeof(s->rx_fifo) bytes of
>> data in a single call.
>
> I will rewrite uart_receive function to accept many bytes at once.

Stefan, I was wondering about this when I read this patch.
What is the API for the can_receive and receive functions?
There's no documentation of the semantics either with the
IOReadHandler or IOCanReadHandler typedefs in main-loop.h,
or in the doc comment for qemu_chr_fe_set_handlers.

I'm guessing that the answer is "your can_read handler should
return the number of bytes you can accept, and a subsequent call
to the read handler then must accept that many bytes, it can't
change its mind and only accept a smaller number" (with some sort
of guarantee by the caller that it won't let guest execution or
other simulation-changes things between the call to can_receive
and receive) ?

(Similarly we don't document the semantics for the NetClientInfo
can_receive and receive functions.)

>>> +}
>>> +
>>> +static void nrf51_uart_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    Nrf51UART *s = NRF51_UART(dev);
>>> +
>>> +    qemu_chr_fe_set_handlers(&s->chr, uart_can_receive, uart_receive,
>>> +                             NULL, NULL, s, NULL, true);
>>> +}
>>> +
>>> +static void nrf51_uart_init(Object *obj)
>>> +{
>>> +    Nrf51UART *s = NRF51_UART(obj);
>>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>> +
>>> +    memory_region_init_io(&s->mmio, obj, &uart_ops, s,
>>> +                          "nrf51_soc.uart", 0x1000);
>>
>> s/0x1000/UART_SIZE/
>
> Should I just add a new define or move the existing one from nrf51_soc.c to
> some header (or any other way to pass the UART_SIZE)?

Usual thing here is that the uart's own header file defines this sort
of constant, and then the SoC's .c file includes that header file
and uses the constant.

thanks
-- PMM
