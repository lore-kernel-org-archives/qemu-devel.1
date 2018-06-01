Received: from eggs.gnu.org ([2001:4830:134:3::10]:56469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fOm6f-0002J1-I3
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fOm6b-0002IY-KZ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:36:45 -0400
Received: from smtp38.i.mail.ru ([94.100.177.98]:46768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fOm6b-0002Gq-8U
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:36:41 -0400
References: <20180529220338.10879-1-jusual@mail.ru>
	<20180529220338.10879-3-jusual@mail.ru>
	<CALHRZuqSYfTjXJKD=y4Ew9CUvUyhM-biG8Q7Bhs+0r0kYo_sQA@mail.gmail.com>
	<CAJSP0QU3h_k28ZouCaJ7eAmLXKOEwEUDYBn2enqaD29U96EuWw@mail.gmail.com>
	<CAJSP0QV_wOv1bV-yB49T7YJA_kjRJb25NkTbt+y2uwzgk_ayGg@mail.gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <e74133a7-d5d3-f683-cf4b-f1478eaf6cc9@mail.ru>
Date: Fri, 1 Jun 2018 18:36:37 +0300
MIME-Version: 1.0
In-Reply-To: <CAJSP0QV_wOv1bV-yB49T7YJA_kjRJb25NkTbt+y2uwzgk_ayGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Stefan Hajnoczi <stefanha@gmail.com>, sundeep subbaraya <sundeep.lkml@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>, Joel Stanley <joel@jms.id.au>

On 01.06.2018 13:44, Stefan Hajnoczi wrote:
> On Fri, Jun 1, 2018 at 11:41 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Thu, May 31, 2018 at 2:58 PM, sundeep subbaraya
>> <sundeep.lkml@gmail.com> wrote:
>>> On Wed, May 30, 2018 at 3:33 AM, Julia Suvorova via Qemu-devel
>>> <qemu-devel@nongnu.org> wrote:
>>>> +static uint64_t uart_read(void *opaque, hwaddr addr, unsigned int size)
>>>> +{
>>>> +    Nrf51UART *s = NRF51_UART(opaque);
>>>> +    uint64_t r;
>>>> +
>>>> +    switch (addr) {
>>>> +    case A_RXD:
>>>> +        r = s->rx_fifo[s->rx_fifo_pos];
>>>> +        if (s->rx_fifo_len > 0) {
>>>> +            s->rx_fifo_pos = (s->rx_fifo_pos + 1) % UART_FIFO_LENGTH;
>>>> +            s->rx_fifo_len--;
>>>> +            qemu_chr_fe_accept_input(&s->chr);
>>>> +        }
>>>> +        break;
>>>> +
>>>> +    case A_INTENSET:
>>>> +    case A_INTENCLR:
>>>> +    case A_INTEN:
>>>> +        r = s->reg[A_INTEN];
>>>> +        break;
>>>> +    default:
>>>> +        r = s->reg[addr];
>>>
>>> You can use R_* macros for registers and access regs[ ] with addr/4 as index.
>>> It is better than using big regs[ ] array out of which most of
>>> locations go unused.
>>
>> Good point.  The bug is more severe than an inefficiency.
>> s->reg[addr] allows out-of-bounds accesses.  This is a security bug.
>>
>> The memory region is 0x1000 *bytes* long, but the array has 0x1000
>> 32-bit *elements*.  A read from address 0xfffc results in a memory
>> load from s->reg + 0xfffc * sizeof(s->reg[0]).  That's beyond the end
>> of the array!
> 
> Sorry, I was wrong.  The array is large enough after all.  It's just
> an inefficiency, but still worth fixing.  Similar issues could lead to
> out-of-bound accesses.

Even if I change the reg array to work with the R_* macros, it will
still be inefficient, since registers are not sequentially located.
I can define the registers in the Nrf51UART structure separately, but
this will increase the code size. Is there a proper way?

Best regards, Julia Suvorova.
