Received: from eggs.gnu.org ([2001:4830:134:3::10]:43233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOhV6-0000S2-6f
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOhV5-0004cs-90
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:41:40 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:38040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOhV5-0004c9-1t
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:41:39 -0400
Received: by mail-wr0-x243.google.com with SMTP id 94-v6so35847632wrf.5
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 03:41:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALHRZuqSYfTjXJKD=y4Ew9CUvUyhM-biG8Q7Bhs+0r0kYo_sQA@mail.gmail.com>
References: <20180529220338.10879-1-jusual@mail.ru>
	<20180529220338.10879-3-jusual@mail.ru>
	<CALHRZuqSYfTjXJKD=y4Ew9CUvUyhM-biG8Q7Bhs+0r0kYo_sQA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 1 Jun 2018 11:41:37 +0100
Message-ID: <CAJSP0QU3h_k28ZouCaJ7eAmLXKOEwEUDYBn2enqaD29U96EuWw@mail.gmail.com>
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
To: sundeep subbaraya <sundeep.lkml@gmail.com>
Cc: Julia Suvorova <jusual@mail.ru>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Joel Stanley <joel@jms.id.au>

On Thu, May 31, 2018 at 2:58 PM, sundeep subbaraya
<sundeep.lkml@gmail.com> wrote:
> On Wed, May 30, 2018 at 3:33 AM, Julia Suvorova via Qemu-devel
> <qemu-devel@nongnu.org> wrote:
>> +static uint64_t uart_read(void *opaque, hwaddr addr, unsigned int size)
>> +{
>> +    Nrf51UART *s = NRF51_UART(opaque);
>> +    uint64_t r;
>> +
>> +    switch (addr) {
>> +    case A_RXD:
>> +        r = s->rx_fifo[s->rx_fifo_pos];
>> +        if (s->rx_fifo_len > 0) {
>> +            s->rx_fifo_pos = (s->rx_fifo_pos + 1) % UART_FIFO_LENGTH;
>> +            s->rx_fifo_len--;
>> +            qemu_chr_fe_accept_input(&s->chr);
>> +        }
>> +        break;
>> +
>> +    case A_INTENSET:
>> +    case A_INTENCLR:
>> +    case A_INTEN:
>> +        r = s->reg[A_INTEN];
>> +        break;
>> +    default:
>> +        r = s->reg[addr];
>
> You can use R_* macros for registers and access regs[ ] with addr/4 as index.
> It is better than using big regs[ ] array out of which most of
> locations go unused.

Good point.  The bug is more severe than an inefficiency.
s->reg[addr] allows out-of-bounds accesses.  This is a security bug.

The memory region is 0x1000 *bytes* long, but the array has 0x1000
32-bit *elements*.  A read from address 0xfffc results in a memory
load from s->reg + 0xfffc * sizeof(s->reg[0]).  That's beyond the end
of the array!

s->reg[A_*] should be changed to s->reg[R_*].  s->reg[addr] needs to
be s->reg[addr / sizeof(s->reg[0])].

It may be worth adding a warning to scripts/checkpatch.pl for
array[A_*] so this bug is reported automatically in the future.

Stefan
