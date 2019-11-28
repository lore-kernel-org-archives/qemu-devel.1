Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13585C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE8621781
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDZovIcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE8621781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaHxE-00006M-20
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 06:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iaHjV-0001CL-Uc
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iaHZL-0000EW-Bt
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:02:53 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iaHZK-0008Tq-SY
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:02:43 -0500
Received: by mail-oi1-x241.google.com with SMTP id k196so6606162oib.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 03:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=mmQV2NbOFgWEbPkm9R5T4uSOij8YXlxec9LXMKPkYMk=;
 b=lDZovIcW7f+elfCAHvab6we7kz9hmibizwEccr46oEGdAta9aYg7JvGUBN+LoNG+in
 1uaZPdDbDM18DmnxGlYhRqariaN80KV8mlXdjXvfKnZLwjxfr563AteDuwWg0Vtgp1wl
 N4r006E5J7tOYB+Ul/j++ACKUEFRBBSPqwInvW8RNFoOmKIQJvoCU8ndfWnIKAW/8YEg
 ojcBoQrd4w0Q2qpv/UneiWJDFDZMyM0YsMwd6IF9/bIPOKhqUD9f3Wk/tloDt3YZB+IY
 QivfvymUp3G8Aa0FU24cTojWzxQl9jRCSiHg+/9+BW66W2uOPzqtC58F/zfNTdJU4zuO
 LYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=mmQV2NbOFgWEbPkm9R5T4uSOij8YXlxec9LXMKPkYMk=;
 b=b0JQ/92yIkEpvxPTM9w8x1RQYnotblwx/4riVrr0DxuWIxczBqw+ly/+wisbRKk5md
 ow81rqjsg4OnBNls5QtAAACQdXzgZCCKyqQfnu/jAxqpspOBMs5KRodSHdsQwXwlKhVs
 nlQOeHFHv9tLMmamzFLihrjxWrcn2SquJvbGD2PUjExbzaqDJTf2f7aB6sVhMh7W7Rtg
 t6bBk4J9/1eCvoOkqyf96uMAEljw9f5q03ew/VvAw5SQey67rwo3sjRZDRj4mttaqtIH
 CTxBsvRaG5l4DDVgV3t4zE0LDqpm5Tv9RDC2E+QjtGChWRVaN7cw4JBXH2Co9JbvnoZC
 K1uA==
X-Gm-Message-State: APjAAAWmtPb3JNSI7soPcYM5mVk2uzWI457J24iPyukmrKjdtsuM/aU5
 SdaAMBFx9U92Zw6FLVhom/0WPwn8ANA7WvRNJ30=
X-Google-Smtp-Source: APXvYqy9+0KKRLMhXOYFEXQRyRxGCVG7NooSzXCQAUXrMdYy3M+f3vkcZmIouBo1LFkuJ2URnPfDvGyBIvjqYjiLHCg=
X-Received: by 2002:aca:d985:: with SMTP id q127mr8294622oig.62.1574938960130; 
 Thu, 28 Nov 2019 03:02:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Thu, 28 Nov 2019 03:02:38
 -0800 (PST)
In-Reply-To: <CAL1e-=iqKV0YZfKc4RtFeu2rOZjbYJMk4+hyGK9qXJn01qCbKQ@mail.gmail.com>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-11-mrolnik@gmail.com>
 <CAL1e-=i5S65283Ypg6-qDKkrhcG1r=w5ZqMyxp3CaAcAkPskUw@mail.gmail.com>
 <20191125155728.aaedf5d65b5121be1ad9f52f@kent.ac.uk>
 <CAL1e-=gMzamQs7BGg4cm8y23GqzEw7M=CptEV_UGyhFrOpeyJg@mail.gmail.com>
 <20191128093126.39c8125329aa78c92f7bbc8f@kent.ac.uk>
 <CAL1e-=iqKV0YZfKc4RtFeu2rOZjbYJMk4+hyGK9qXJn01qCbKQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 28 Nov 2019 12:02:38 +0100
Message-ID: <CAL1e-=ijvq4QmDwari1wX4mrZ0ewsOvhNs_5sO_yxCrY5+xZ5A@mail.gmail.com>
Subject: Re: [PATCH v35 10/13] target/avr: Add limited support for USART and
 16 bit timer peripherals
To: Sarah Harris <seh53@kent.ac.uk>
Content-Type: multipart/alternative; boundary="00000000000042f8670598660d55"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "S.Harris" <S.E.Harris@kent.ac.uk>, QEMU Developers <qemu-devel@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000042f8670598660d55
Content-Type: text/plain; charset="UTF-8"

On Thursday, November 28, 2019, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Thursday, November 28, 2019, Sarah Harris <seh53@kent.ac.uk> wrote:
>
>> Hi Aleksandar,
>>
>> > Sarah, thanks for taking your tome to respond!
>> No problem! :)
>>
>> > do we fully support what is said in:
>> > * 22.6.2 Sending Frames with 9 Data Bit
>> > * 22.7.2 Receiving Frames with 9 Data Bits
>> No, QEMU's character device system only supports 8 bit characters.
>> Shorter characters can be padded easily, but longer is a problem.
>> At the moment we just emit a warning and ignore the extra bit in UCSRnB
>> (i.e. behave as if 8 bits was selected).
>>
>> > And the same question for section:
>> > * 22.9 Multi-processor Communication Mode
>> No, this was out of scope for testing use.
>> This case is checked when writing to the UCSRnA register, `if (value &
>> USART_CSRA_MPCM)`, and causes a warning.
>> I don't know if we should crash instead, but at the moment we just log
>> the warning and continue.
>> (USART emulation will be incorrect from when this happens and until MPCM
>> is disabled)
>>
>>
> OK. Thanks. All this sounds reasonable to me. Do you agree that we insert:
>
> /*
>  * Limitation of this emulation:
>  *
>  *   * Sending and receiving frames with 9 data bits sre not supported
>  *   * Multi-processor communication mode is not supported
>  */
>
> or a similar comment, close to the top of the file?
>
>
One more question, Sarah, Michael left the license preambles the same as
originals, however this is not a good license (there are some legal
nuances) for QEMU, do you agree that the license preambles for your
implementations are changed to LGPL 2.1 (with wording "or later (at your
option)") that Michael used elsewhere?

Best regards,

 Aleksandar


> Yours,
> Aleksandar
>
>
> Kind regards,
>> Sarah Harris
>>
>>
>> On Mon, 25 Nov 2019 19:57:48 +0100
>> Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:
>>
>> > On Mon, Nov 25, 2019 at 4:57 PM Sarah Harris <seh53@kent.ac.uk> wrote:
>> > >
>> > > Hi Aleksandar,
>> > >
>> > > > - Is there a place in docs that explain its implementation in
>> general?
>> > > This implementation was based on the datasheet for the ATmega2560
>> ("ATmega640/1280/1281/2560/2561 datasheet" available from Microchip's
>> website).
>> > > (I'm not sure if posting a URL will trigger any spam filters, so I'll
>> leave it for now)
>> > > See section 22.10, "USART - Register Description".
>> > >
>> >
>> > OK.
>> >
>> > > > - Why do cases 4, 5, 6 issue relatively unclear error message
>> > > > ""update_char_mask(): Reserved character size <mode>"? Is there a
>> > > > better wording perhaps? Where is justification in the doc for these
>> > > > cases?
>> > > The hardware can send/receive characters of various lengths,
>> specified by settings in these configuration registers.
>> > > The cases are defined in table 22-7, "UCSZn Bits Settings", which
>> specifies that modes 4, 5, and 6 are reserved and should not be used.
>> > > I'm not sure how better to explain this fault to the user; this is an
>> edge case that I'd expect only an AVR developer testing their own program
>> to see, so describing it in the same way as the datasheet seems a good idea.
>> > >
>> >
>> > OK. I somehow missed table 22-7 while comparing the code and specs - my
>> bad.
>> >
>> > > > - What would be the docs justification for case 7? Why is an error
>> > > > message issued, but still "char_mask" is set, and I guess, further
>> > > > processing will go on? Why the error message says "Nine bit
>> character
>> > > > requested"? Who said that (that *nine* bit characters were
>> requested?
>> > > > :-)
>> > > Case 7 also comes from table 22-7, and specifies that the USART
>> should send/receive 9 bits per character.
>> > > For characters <= 8 bits it's easy to pad them to the 8 bit bytes
>> that the character device subsystem operates on.
>> > > For characters of 9 bits we'd have to throw away one bit, which seems
>> like a bad thing to do.
>> > > I decided it wasn't enough to justify crashing, but the user should
>> be made aware that data is being lost and the output might not be what they
>> would otherwise expect.
>> > >
>> >
>> > Sarah, thanks for taking your tome to respond! Could you just explain
>> > to me do we fully support what is said in:
>> >
>> > * 22.6.2 Sending Frames with 9 Data Bit
>> > * 22.7.2 Receiving Frames with 9 Data Bits
>> >
>> > or perhaps there are some limitations?
>> >
>> > And the same question for section:
>> >
>> > * 22.9 Multi-processor Communication Mode
>> >
>> > Please note that I don't suggest amending or extending your
>> > implementation, I just want to understand it better.
>> >
>> > Best regards,
>> > Aleksandar
>> >
>> >
>> > > Kind regards,
>> > > Sarah Harris
>> > >
>> > >
>> > > On Fri, 22 Nov 2019 16:10:02 +0100
>> > > Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:
>> > >
>> > > > On Tue, Oct 29, 2019 at 10:25 PM Michael Rolnik <mrolnik@gmail.com>
>> wrote:
>> > > > >
>> > > > > From: Sarah Harris <S.E.Harris@kent.ac.uk>
>> > > > >
>> > > > > These were designed to facilitate testing but should provide
>> enough function to be useful in other contexts.
>> > > > > Only a subset of the functions of each peripheral is implemented,
>> mainly due to the lack of a standard way to handle electrical connections
>> (like GPIO pins).
>> > > > >
>> > > > > Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>> > > > > ---
>> > > > >  hw/char/Kconfig                |   3 +
>> > > > >  hw/char/Makefile.objs          |   1 +
>> > > > >  hw/char/avr_usart.c            | 324 ++++++++++++++++++
>> > > > >  hw/misc/Kconfig                |   3 +
>> > > > >  hw/misc/Makefile.objs          |   2 +
>> > > > >  hw/misc/avr_mask.c             | 112 ++++++
>> > > > >  hw/timer/Kconfig               |   3 +
>> > > > >  hw/timer/Makefile.objs         |   2 +
>> > > > >  hw/timer/avr_timer16.c         | 605
>> +++++++++++++++++++++++++++++++++
>> > > > >  include/hw/char/avr_usart.h    |  97 ++++++
>> > > > >  include/hw/misc/avr_mask.h     |  47 +++
>> > > > >  include/hw/timer/avr_timer16.h |  97 ++++++
>> > > > >  12 files changed, 1296 insertions(+)
>> > > > >  create mode 100644 hw/char/avr_usart.c
>> > > > >  create mode 100644 hw/misc/avr_mask.c
>> > > > >  create mode 100644 hw/timer/avr_timer16.c
>> > > > >  create mode 100644 include/hw/char/avr_usart.h
>> > > > >  create mode 100644 include/hw/misc/avr_mask.h
>> > > > >  create mode 100644 include/hw/timer/avr_timer16.h
>> > > > >
>> > > > > diff --git a/hw/char/Kconfig b/hw/char/Kconfig
>> > > > > index 40e7a8b8bb..331b20983f 100644
>> > > > > --- a/hw/char/Kconfig
>> > > > > +++ b/hw/char/Kconfig
>> > > > > @@ -46,3 +46,6 @@ config SCLPCONSOLE
>> > > > >
>> > > > >  config TERMINAL3270
>> > > > >      bool
>> > > > > +
>> > > > > +config AVR_USART
>> > > > > +    bool
>> > > > > diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
>> > > > > index 02d8a66925..f05c1f5667 100644
>> > > > > --- a/hw/char/Makefile.objs
>> > > > > +++ b/hw/char/Makefile.objs
>> > > > > @@ -21,6 +21,7 @@ obj-$(CONFIG_PSERIES) += spapr_vty.o
>> > > > >  obj-$(CONFIG_DIGIC) += digic-uart.o
>> > > > >  obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
>> > > > >  obj-$(CONFIG_RASPI) += bcm2835_aux.o
>> > > > > +common-obj-$(CONFIG_AVR_USART) += avr_usart.o
>> > > > >
>> > > > >  common-obj-$(CONFIG_CMSDK_APB_UART) += cmsdk-apb-uart.o
>> > > > >  common-obj-$(CONFIG_ETRAXFS) += etraxfs_ser.o
>> > > > > diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
>> > > > > new file mode 100644
>> > > > > index 0000000000..9ca3c2a1cd
>> > > > > --- /dev/null
>> > > > > +++ b/hw/char/avr_usart.c
>> > > > > @@ -0,0 +1,324 @@
>> > > > > +/*
>> > > > > + * AVR USART
>> > > > > + *
>> > > > > + * Copyright (c) 2018 University of Kent
>> > > > > + * Author: Sarah Harris
>> > > > > + *
>> > > > > + * Permission is hereby granted, free of charge, to any person
>> obtaining a copy
>> > > > > + * of this software and associated documentation files (the
>> "Software"), to deal
>> > > > > + * in the Software without restriction, including without
>> limitation the rights
>> > > > > + * to use, copy, modify, merge, publish, distribute, sublicense,
>> and/or sell
>> > > > > + * copies of the Software, and to permit persons to whom the
>> Software is
>> > > > > + * furnished to do so, subject to the following conditions:
>> > > > > + *
>> > > > > + * The above copyright notice and this permission notice shall
>> be included in
>> > > > > + * all copies or substantial portions of the Software.
>> > > > > + *
>> > > > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>> KIND, EXPRESS OR
>> > > > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> > > > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
>> EVENT SHALL
>> > > > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
>> DAMAGES OR OTHER
>> > > > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> OTHERWISE, ARISING FROM,
>> > > > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> DEALINGS IN
>> > > > > + * THE SOFTWARE.
>> > > > > + */
>> > > > > +
>> > > > > +#include "qemu/osdep.h"
>> > > > > +#include "hw/char/avr_usart.h"
>> > > > > +#include "qemu/log.h"
>> > > > > +#include "hw/irq.h"
>> > > > > +#include "hw/qdev-properties.h"
>> > > > > +
>> > > > > +static int avr_usart_can_receive(void *opaque)
>> > > > > +{
>> > > > > +    AVRUsartState *usart = opaque;
>> > > > > +
>> > > > > +    if (usart->data_valid || !(usart->csrb & USART_CSRB_RXEN)) {
>> > > > > +        return 0;
>> > > > > +    }
>> > > > > +    return 1;
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_usart_receive(void *opaque, const uint8_t
>> *buffer, int size)
>> > > > > +{
>> > > > > +    AVRUsartState *usart = opaque;
>> > > > > +    assert(size == 1);
>> > > > > +    assert(!usart->data_valid);
>> > > > > +    usart->data = buffer[0];
>> > > > > +    usart->data_valid = true;
>> > > > > +    usart->csra |= USART_CSRA_RXC;
>> > > > > +    if (usart->csrb & USART_CSRB_RXCIE) {
>> > > > > +        qemu_set_irq(usart->rxc_irq, 1);
>> > > > > +    }
>> > > > > +}
>> > > > > +
>> > > > > +static void update_char_mask(AVRUsartState *usart)
>> > > > > +{
>> > > > > +    uint8_t mode = ((usart->csrc & USART_CSRC_CSZ0) ? 1 : 0) |
>> > > > > +        ((usart->csrc & USART_CSRC_CSZ1) ? 2 : 0) |
>> > > > > +        ((usart->csrb & USART_CSRB_CSZ2) ? 4 : 0);
>> > > > > +    switch (mode) {
>> > > > > +    case 0:
>> > > > > +        usart->char_mask = 0b11111;
>> > > > > +        break;
>> > > > > +    case 1:
>> > > > > +        usart->char_mask = 0b111111;
>> > > > > +        break;
>> > > > > +    case 2:
>> > > > > +        usart->char_mask = 0b1111111;
>> > > > > +        break;
>> > > > > +    case 3:
>> > > > > +        usart->char_mask = 0b11111111;
>> > > > > +        break;
>> > > > > +    case 4:
>> > > > > +        /* Fallthrough. */
>> > > > > +    case 5:
>> > > > > +        /* Fallthrough. */
>> > > > > +    case 6:
>> > > > > +        qemu_log_mask(
>> > > > > +            LOG_GUEST_ERROR,
>> > > > > +            "%s: Reserved character size 0x%x\n",
>> > > > > +            __func__,
>> > > > > +            mode);
>> > > > > +        break;
>> > > > > +    case 7:
>> > > > > +        qemu_log_mask(
>> > > > > +            LOG_GUEST_ERROR,
>> > > > > +            "%s: Nine bit character size not supported (forcing
>> eight)\n",
>> > > > > +            __func__);
>> > > > > +        usart->char_mask = 0b11111111;
>> > > > > +        break;
>> > > > > +    default:
>> > > > > +        assert(0);
>> > > > > +    }
>> > > > > +}
>> > > > > +
>> > > >
>> > > > Hello, Michael.
>> > > >
>> > > > Please explain to me some details of update_char_mask():
>> > > >
>> > > > - Is there a place in docs that explain its implementation in
>> general?
>> > > >
>> > > > - Why do cases 4, 5, 6 issue relatively unclear error message
>> > > > ""update_char_mask(): Reserved character size <mode>"? Is there a
>> > > > better wording perhaps? Where is justification in the doc for these
>> > > > cases?
>> > > >
>> > > > - What would be the docs justification for case 7? Why is an error
>> > > > message issued, but still "char_mask" is set, and I guess, further
>> > > > processing will go on? Why the error message says "Nine bit
>> character
>> > > > requested"? Who said that (that *nine* bit characters were
>> requested?
>> > > > :-)
>> > > >
>> > > > Sincerely,
>> > > > Aleksandar
>> > > >
>> > > >
>> > > >
>> > > >
>> > > >
>> > > >
>> > > > > +static void avr_usart_reset(DeviceState *dev)
>> > > > > +{
>> > > > > +    AVRUsartState *usart = AVR_USART(dev);
>> > > > > +    usart->data_valid = false;
>> > > > > +    usart->csra = 0b00100000;
>> > > > > +    usart->csrb = 0b00000000;
>> > > > > +    usart->csrc = 0b00000110;
>> > > > > +    usart->brrl = 0;
>> > > > > +    usart->brrh = 0;
>> > > > > +    update_char_mask(usart);
>> > > > > +    qemu_set_irq(usart->rxc_irq, 0);
>> > > > > +    qemu_set_irq(usart->txc_irq, 0);
>> > > > > +    qemu_set_irq(usart->dre_irq, 0);
>> > > > > +}
>> > > > > +
>> > > > > +static uint64_t avr_usart_read(void *opaque, hwaddr addr,
>> unsigned int size)
>> > > > > +{
>> > > > > +    AVRUsartState *usart = opaque;
>> > > > > +    uint8_t data;
>> > > > > +    assert(size == 1);
>> > > > > +
>> > > > > +    if (!usart->enabled) {
>> > > > > +        return 0;
>> > > > > +    }
>> > > > > +
>> > > > > +    switch (addr) {
>> > > > > +    case USART_DR:
>> > > > > +        if (!(usart->csrb & USART_CSRB_RXEN)) {
>> > > > > +            /* Receiver disabled, ignore. */
>> > > > > +            return 0;
>> > > > > +        }
>> > > > > +        if (usart->data_valid) {
>> > > > > +            data = usart->data & usart->char_mask;
>> > > > > +            usart->data_valid = false;
>> > > > > +        } else {
>> > > > > +            data = 0;
>> > > > > +        }
>> > > > > +        usart->csra &= 0xff ^ USART_CSRA_RXC;
>> > > > > +        qemu_set_irq(usart->rxc_irq, 0);
>> > > > > +        qemu_chr_fe_accept_input(&usart->chr);
>> > > > > +        return data;
>> > > > > +    case USART_CSRA:
>> > > > > +        return usart->csra;
>> > > > > +    case USART_CSRB:
>> > > > > +        return usart->csrb;
>> > > > > +    case USART_CSRC:
>> > > > > +        return usart->csrc;
>> > > > > +    case USART_BRRL:
>> > > > > +        return usart->brrl;
>> > > > > +    case USART_BRRH:
>> > > > > +        return usart->brrh;
>> > > > > +    default:
>> > > > > +        qemu_log_mask(
>> > > > > +            LOG_GUEST_ERROR,
>> > > > > +            "%s: Bad offset 0x%"HWADDR_PRIx"\n",
>> > > > > +            __func__,
>> > > > > +            addr);
>> > > > > +    }
>> > > > > +    return 0;
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_usart_write(void *opaque, hwaddr addr, uint64_t
>> value,
>> > > > > +                                unsigned int size)
>> > > > > +{
>> > > > > +    AVRUsartState *usart = opaque;
>> > > > > +    uint8_t mask;
>> > > > > +    uint8_t data;
>> > > > > +    assert((value & 0xff) == value);
>> > > > > +    assert(size == 1);
>> > > > > +
>> > > > > +    if (!usart->enabled) {
>> > > > > +        return;
>> > > > > +    }
>> > > > > +
>> > > > > +    switch (addr) {
>> > > > > +    case USART_DR:
>> > > > > +        if (!(usart->csrb & USART_CSRB_TXEN)) {
>> > > > > +            /* Transmitter disabled, ignore. */
>> > > > > +            return;
>> > > > > +        }
>> > > > > +        usart->csra |= USART_CSRA_TXC;
>> > > > > +        usart->csra |= USART_CSRA_DRE;
>> > > > > +        if (usart->csrb & USART_CSRB_TXCIE) {
>> > > > > +            qemu_set_irq(usart->txc_irq, 1);
>> > > > > +            usart->csra &= 0xff ^ USART_CSRA_TXC;
>> > > > > +        }
>> > > > > +        if (usart->csrb & USART_CSRB_DREIE) {
>> > > > > +            qemu_set_irq(usart->dre_irq, 1);
>> > > > > +        }
>> > > > > +        data = value;
>> > > > > +        qemu_chr_fe_write_all(&usart->chr, &data, 1);
>> > > > > +        break;
>> > > > > +    case USART_CSRA:
>> > > > > +        mask = 0b01000011;
>> > > > > +        /* Mask read-only bits. */
>> > > > > +        value = (value & mask) | (usart->csra & (0xff ^ mask));
>> > > > > +        usart->csra = value;
>> > > > > +        if (value & USART_CSRA_TXC) {
>> > > > > +            usart->csra ^= USART_CSRA_TXC;
>> > > > > +            qemu_set_irq(usart->txc_irq, 0);
>> > > > > +        }
>> > > > > +        if (value & USART_CSRA_MPCM) {
>> > > > > +            qemu_log_mask(
>> > > > > +                LOG_GUEST_ERROR,
>> > > > > +                "%s: MPCM not supported by USART\n",
>> > > > > +                __func__);
>> > > > > +        }
>> > > > > +        break;
>> > > > > +    case USART_CSRB:
>> > > > > +        mask = 0b11111101;
>> > > > > +        /* Mask read-only bits. */
>> > > > > +        value = (value & mask) | (usart->csrb & (0xff ^ mask));
>> > > > > +        usart->csrb = value;
>> > > > > +        if (!(value & USART_CSRB_RXEN)) {
>> > > > > +            /* Receiver disabled, flush input buffer. */
>> > > > > +            usart->data_valid = false;
>> > > > > +        }
>> > > > > +        qemu_set_irq(usart->rxc_irq,
>> > > > > +            ((value & USART_CSRB_RXCIE) &&
>> > > > > +            (usart->csra & USART_CSRA_RXC)) ? 1 : 0);
>> > > > > +        qemu_set_irq(usart->txc_irq,
>> > > > > +            ((value & USART_CSRB_TXCIE) &&
>> > > > > +            (usart->csra & USART_CSRA_TXC)) ? 1 : 0);
>> > > > > +        qemu_set_irq(usart->dre_irq,
>> > > > > +            ((value & USART_CSRB_DREIE) &&
>> > > > > +            (usart->csra & USART_CSRA_DRE)) ? 1 : 0);
>> > > > > +        update_char_mask(usart);
>> > > > > +        break;
>> > > > > +    case USART_CSRC:
>> > > > > +        usart->csrc = value;
>> > > > > +        if ((value & USART_CSRC_MSEL1) && (value &
>> USART_CSRC_MSEL0)) {
>> > > > > +            qemu_log_mask(
>> > > > > +                LOG_GUEST_ERROR,
>> > > > > +                "%s: SPI mode not supported by USART\n",
>> > > > > +                __func__);
>> > > > > +        }
>> > > > > +        if ((value & USART_CSRC_MSEL1) && !(value &
>> USART_CSRC_MSEL0)) {
>> > > > > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad USART
>> mode\n", __func__);
>> > > > > +        }
>> > > > > +        if (!(value & USART_CSRC_PM1) && (value &
>> USART_CSRC_PM0)) {
>> > > > > +            qemu_log_mask(
>> > > > > +                LOG_GUEST_ERROR,
>> > > > > +                "%s: Bad USART parity mode\n",
>> > > > > +                __func__);
>> > > > > +        }
>> > > > > +        update_char_mask(usart);
>> > > > > +        break;
>> > > > > +    case USART_BRRL:
>> > > > > +        usart->brrl = value;
>> > > > > +        break;
>> > > > > +    case USART_BRRH:
>> > > > > +        usart->brrh = value & 0b00001111;
>> > > > > +        break;
>> > > > > +    default:
>> > > > > +        qemu_log_mask(
>> > > > > +            LOG_GUEST_ERROR,
>> > > > > +            "%s: Bad offset 0x%"HWADDR_PRIx"\n",
>> > > > > +            __func__,
>> > > > > +            addr);
>> > > > > +    }
>> > > > > +}
>> > > > > +
>> > > > > +static const MemoryRegionOps avr_usart_ops = {
>> > > > > +    .read = avr_usart_read,
>> > > > > +    .write = avr_usart_write,
>> > > > > +    .endianness = DEVICE_NATIVE_ENDIAN,
>> > > > > +    .impl = {.min_access_size = 1, .max_access_size = 1}
>> > > > > +};
>> > > > > +
>> > > > > +static Property avr_usart_properties[] = {
>> > > > > +    DEFINE_PROP_CHR("chardev", AVRUsartState, chr),
>> > > > > +    DEFINE_PROP_END_OF_LIST(),
>> > > > > +};
>> > > > > +
>> > > > > +static void avr_usart_pr(void *opaque, int irq, int level)
>> > > > > +{
>> > > > > +    AVRUsartState *s = AVR_USART(opaque);
>> > > > > +
>> > > > > +    s->enabled = !level;
>> > > > > +
>> > > > > +    if (!s->enabled) {
>> > > > > +        avr_usart_reset(DEVICE(s));
>> > > > > +    }
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_usart_init(Object *obj)
>> > > > > +{
>> > > > > +    AVRUsartState *s = AVR_USART(obj);
>> > > > > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rxc_irq);
>> > > > > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->dre_irq);
>> > > > > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->txc_irq);
>> > > > > +    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s,
>> TYPE_AVR_USART, 8);
>> > > > > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>> > > > > +    qdev_init_gpio_in(DEVICE(s), avr_usart_pr, 1);
>> > > > > +    s->enabled = true;
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_usart_realize(DeviceState *dev, Error **errp)
>> > > > > +{
>> > > > > +    AVRUsartState *s = AVR_USART(dev);
>> > > > > +    qemu_chr_fe_set_handlers(&s->chr, avr_usart_can_receive,
>> > > > > +                             avr_usart_receive, NULL, NULL,
>> > > > > +                             s, NULL, true);
>> > > > > +    avr_usart_reset(dev);
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_usart_class_init(ObjectClass *klass, void *data)
>> > > > > +{
>> > > > > +    DeviceClass *dc = DEVICE_CLASS(klass);
>> > > > > +
>> > > > > +    dc->reset = avr_usart_reset;
>> > > > > +    dc->props = avr_usart_properties;
>> > > > > +    dc->realize = avr_usart_realize;
>> > > > > +}
>> > > > > +
>> > > > > +static const TypeInfo avr_usart_info = {
>> > > > > +    .name          = TYPE_AVR_USART,
>> > > > > +    .parent        = TYPE_SYS_BUS_DEVICE,
>> > > > > +    .instance_size = sizeof(AVRUsartState),
>> > > > > +    .instance_init = avr_usart_init,
>> > > > > +    .class_init    = avr_usart_class_init,
>> > > > > +};
>> > > > > +
>> > > > > +static void avr_usart_register_types(void)
>> > > > > +{
>> > > > > +    type_register_static(&avr_usart_info);
>> > > > > +}
>> > > > > +
>> > > > > +type_init(avr_usart_register_types)
>> > > > > diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
>> > > > > index 2164646553..e79841e3a4 100644
>> > > > > --- a/hw/misc/Kconfig
>> > > > > +++ b/hw/misc/Kconfig
>> > > > > @@ -125,4 +125,7 @@ config MAC_VIA
>> > > > >      select MOS6522
>> > > > >      select ADB
>> > > > >
>> > > > > +config AVR_MASK
>> > > > > +    bool
>> > > > > +
>> > > > >  source macio/Kconfig
>> > > > > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> > > > > index ba898a5781..3a8093be6a 100644
>> > > > > --- a/hw/misc/Makefile.objs
>> > > > > +++ b/hw/misc/Makefile.objs
>> > > > > @@ -82,3 +82,5 @@ common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
>> > > > >  obj-$(CONFIG_MAC_VIA) += mac_via.o
>> > > > >
>> > > > >  common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
>> > > > > +
>> > > > > +obj-$(CONFIG_AVR_MASK) += avr_mask.o
>> > > > > diff --git a/hw/misc/avr_mask.c b/hw/misc/avr_mask.c
>> > > > > new file mode 100644
>> > > > > index 0000000000..3af82ed9c1
>> > > > > --- /dev/null
>> > > > > +++ b/hw/misc/avr_mask.c
>> > > > > @@ -0,0 +1,112 @@
>> > > > > +/*
>> > > > > + * AVR Power Reduction
>> > > > > + *
>> > > > > + * Copyright (c) 2019 Michael Rolnik
>> > > > > + *
>> > > > > + * Permission is hereby granted, free of charge, to any person
>> obtaining a copy
>> > > > > + * of this software and associated documentation files (the
>> "Software"), to deal
>> > > > > + * in the Software without restriction, including without
>> limitation the rights
>> > > > > + * to use, copy, modify, merge, publish, distribute, sublicense,
>> and/or sell
>> > > > > + * copies of the Software, and to permit persons to whom the
>> Software is
>> > > > > + * furnished to do so, subject to the following conditions:
>> > > > > + *
>> > > > > + * The above copyright notice and this permission notice shall
>> be included in
>> > > > > + * all copies or substantial portions of the Software.
>> > > > > + *
>> > > > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>> KIND, EXPRESS OR
>> > > > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> > > > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
>> EVENT SHALL
>> > > > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
>> DAMAGES OR OTHER
>> > > > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> OTHERWISE, ARISING FROM,
>> > > > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> DEALINGS IN
>> > > > > + * THE SOFTWARE.
>> > > > > + */
>> > > > > +
>> > > > > +#include "qemu/osdep.h"
>> > > > > +#include "hw/misc/avr_mask.h"
>> > > > > +#include "qemu/log.h"
>> > > > > +#include "hw/qdev-properties.h"
>> > > > > +#include "hw/irq.h"
>> > > > > +
>> > > > > +#define DB_PRINT(fmt, args...) /* Nothing */
>> > > > > +/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n",
>> __func__, ## args)*/
>> > > > > +
>> > > > > +static void avr_mask_reset(DeviceState *dev)
>> > > > > +{
>> > > > > +    AVRMaskState *s = AVR_MASK(dev);
>> > > > > +
>> > > > > +    s->val = 0x00;
>> > > > > +
>> > > > > +    for (int i = 0; i < 8; i++) {
>> > > > > +        qemu_set_irq(s->irq[i], 0);
>> > > > > +    }
>> > > > > +}
>> > > > > +
>> > > > > +static uint64_t avr_mask_read(void *opaque, hwaddr offset,
>> unsigned size)
>> > > > > +{
>> > > > > +    assert(size == 1);
>> > > > > +    assert(offset == 0);
>> > > > > +    AVRMaskState *s = opaque;
>> > > > > +
>> > > > > +    return (uint64_t)s->val;
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_mask_write(void *opaque, hwaddr offset,
>> > > > > +                              uint64_t val64, unsigned size)
>> > > > > +{
>> > > > > +    assert(size == 1);
>> > > > > +    assert(offset == 0);
>> > > > > +    AVRMaskState *s = opaque;
>> > > > > +    uint8_t val8 = val64;
>> > > > > +
>> > > > > +    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
>> > > > > +
>> > > > > +    s->val = val8;
>> > > > > +    for (int i = 0; i < 8; i++) {
>> > > > > +        qemu_set_irq(s->irq[i], (val8 & (1 << i)) != 0);
>> > > > > +    }
>> > > > > +}
>> > > > > +
>> > > > > +static const MemoryRegionOps avr_mask_ops = {
>> > > > > +    .read = avr_mask_read,
>> > > > > +    .write = avr_mask_write,
>> > > > > +    .endianness = DEVICE_NATIVE_ENDIAN,
>> > > > > +    .impl = {.max_access_size = 1}
>> > > > > +};
>> > > > > +
>> > > > > +static void avr_mask_init(Object *dev)
>> > > > > +{
>> > > > > +    AVRMaskState *s = AVR_MASK(dev);
>> > > > > +    SysBusDevice *busdev = SYS_BUS_DEVICE(dev);
>> > > > > +
>> > > > > +    memory_region_init_io(&s->iomem, dev, &avr_mask_ops, s,
>> TYPE_AVR_MASK,
>> > > > > +            0x01);
>> > > > > +    sysbus_init_mmio(busdev, &s->iomem);
>> > > > > +
>> > > > > +    for (int i = 0; i < 8; i++) {
>> > > > > +        sysbus_init_irq(busdev, &s->irq[i]);
>> > > > > +    }
>> > > > > +    s->val = 0x00;
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_mask_class_init(ObjectClass *klass, void *data)
>> > > > > +{
>> > > > > +    DeviceClass *dc = DEVICE_CLASS(klass);
>> > > > > +
>> > > > > +    dc->reset = avr_mask_reset;
>> > > > > +}
>> > > > > +
>> > > > > +static const TypeInfo avr_mask_info = {
>> > > > > +    .name          = TYPE_AVR_MASK,
>> > > > > +    .parent        = TYPE_SYS_BUS_DEVICE,
>> > > > > +    .instance_size = sizeof(AVRMaskState),
>> > > > > +    .class_init    = avr_mask_class_init,
>> > > > > +    .instance_init = avr_mask_init,
>> > > > > +};
>> > > > > +
>> > > > > +static void avr_mask_register_types(void)
>> > > > > +{
>> > > > > +    type_register_static(&avr_mask_info);
>> > > > > +}
>> > > > > +
>> > > > > +type_init(avr_mask_register_types)
>> > > > > diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
>> > > > > index a990f9fe35..4343bc23f3 100644
>> > > > > --- a/hw/timer/Kconfig
>> > > > > +++ b/hw/timer/Kconfig
>> > > > > @@ -34,3 +34,6 @@ config CMSDK_APB_TIMER
>> > > > >  config CMSDK_APB_DUALTIMER
>> > > > >      bool
>> > > > >      select PTIMER
>> > > > > +
>> > > > > +config AVR_TIMER16
>> > > > > +    bool
>> > > > > diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>> > > > > index dece235fd7..af0913ca3b 100644
>> > > > > --- a/hw/timer/Makefile.objs
>> > > > > +++ b/hw/timer/Makefile.objs
>> > > > > @@ -35,3 +35,5 @@ common-obj-$(CONFIG_CMSDK_APB_TIMER) +=
>> cmsdk-apb-timer.o
>> > > > >  common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) +=
>> cmsdk-apb-dualtimer.o
>> > > > >  common-obj-$(CONFIG_MSF2) += mss-timer.o
>> > > > >  common-obj-$(CONFIG_RASPI) += bcm2835_systmr.o
>> > > > > +
>> > > > > +obj-$(CONFIG_AVR_TIMER16) += avr_timer16.o
>> > > > > diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
>> > > > > new file mode 100644
>> > > > > index 0000000000..ac6ef73e77
>> > > > > --- /dev/null
>> > > > > +++ b/hw/timer/avr_timer16.c
>> > > > > @@ -0,0 +1,605 @@
>> > > > > +/*
>> > > > > + * AVR 16 bit timer
>> > > > > + *
>> > > > > + * Copyright (c) 2018 University of Kent
>> > > > > + * Author: Ed Robbins
>> > > > > + *
>> > > > > + * Permission is hereby granted, free of charge, to any person
>> obtaining a copy
>> > > > > + * of this software and associated documentation files (the
>> "Software"), to deal
>> > > > > + * in the Software without restriction, including without
>> limitation the rights
>> > > > > + * to use, copy, modify, merge, publish, distribute, sublicense,
>> and/or sell
>> > > > > + * copies of the Software, and to permit persons to whom the
>> Software is
>> > > > > + * furnished to do so, subject to the following conditions:
>> > > > > + *
>> > > > > + * The above copyright notice and this permission notice shall
>> be included in
>> > > > > + * all copies or substantial portions of the Software.
>> > > > > + *
>> > > > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>> KIND, EXPRESS OR
>> > > > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> > > > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
>> EVENT SHALL
>> > > > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
>> DAMAGES OR OTHER
>> > > > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> OTHERWISE, ARISING FROM,
>> > > > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> DEALINGS IN
>> > > > > + * THE SOFTWARE.
>> > > > > + */
>> > > > > +
>> > > > > +/*
>> > > > > + * Driver for 16 bit timers on 8 bit AVR devices.
>> > > > > + * Note:
>> > > > > + * ATmega640/V-1280/V-1281/V-2560/V-2561/V timers 1, 3, 4 and 5
>> are 16 bit
>> > > > > + */
>> > > > > +
>> > > > > +/*
>> > > > > + * XXX TODO: Power Reduction Register support
>> > > > > + *           prescaler pause support
>> > > > > + *           PWM modes, GPIO, output capture pins, input compare
>> pin
>> > > > > + */
>> > > > > +
>> > > > > +#include "qemu/osdep.h"
>> > > > > +#include "hw/timer/avr_timer16.h"
>> > > > > +#include "qemu/log.h"
>> > > > > +#include "hw/irq.h"
>> > > > > +#include "hw/qdev-properties.h"
>> > > > > +
>> > > > > +/* Register offsets */
>> > > > > +#define T16_CRA     0x0
>> > > > > +#define T16_CRB     0x1
>> > > > > +#define T16_CRC     0x2
>> > > > > +#define T16_CNTL    0x4
>> > > > > +#define T16_CNTH    0x5
>> > > > > +#define T16_ICRL    0x6
>> > > > > +#define T16_ICRH    0x7
>> > > > > +#define T16_OCRAL   0x8
>> > > > > +#define T16_OCRAH   0x9
>> > > > > +#define T16_OCRBL   0xa
>> > > > > +#define T16_OCRBH   0xb
>> > > > > +#define T16_OCRCL   0xc
>> > > > > +#define T16_OCRCH   0xd
>> > > > > +
>> > > > > +/* Field masks */
>> > > > > +#define T16_CRA_WGM01   0x3
>> > > > > +#define T16_CRA_COMC    0xc
>> > > > > +#define T16_CRA_COMB    0x30
>> > > > > +#define T16_CRA_COMA    0xc0
>> > > > > +#define T16_CRA_OC_CONF \
>> > > > > +    (T16_CRA_COMA | T16_CRA_COMB | T16_CRA_COMC)
>> > > > > +
>> > > > > +#define T16_CRB_CS      0x7
>> > > > > +#define T16_CRB_WGM23   0x18
>> > > > > +#define T16_CRB_ICES    0x40
>> > > > > +#define T16_CRB_ICNC    0x80
>> > > > > +
>> > > > > +#define T16_CRC_FOCC    0x20
>> > > > > +#define T16_CRC_FOCB    0x40
>> > > > > +#define T16_CRC_FOCA    0x80
>> > > > > +
>> > > > > +/* Fields masks both TIMSK and TIFR (interrupt mask/flag
>> registers) */
>> > > > > +#define T16_INT_TOV    0x1 /* Timer overflow */
>> > > > > +#define T16_INT_OCA    0x2 /* Output compare A */
>> > > > > +#define T16_INT_OCB    0x4 /* Output compare B */
>> > > > > +#define T16_INT_OCC    0x8 /* Output compare C */
>> > > > > +#define T16_INT_IC     0x20 /* Input capture */
>> > > > > +
>> > > > > +/* Clock source values */
>> > > > > +#define T16_CLKSRC_STOPPED     0
>> > > > > +#define T16_CLKSRC_DIV1        1
>> > > > > +#define T16_CLKSRC_DIV8        2
>> > > > > +#define T16_CLKSRC_DIV64       3
>> > > > > +#define T16_CLKSRC_DIV256      4
>> > > > > +#define T16_CLKSRC_DIV1024     5
>> > > > > +#define T16_CLKSRC_EXT_FALLING 6
>> > > > > +#define T16_CLKSRC_EXT_RISING  7
>> > > > > +
>> > > > > +/* Timer mode values (not including PWM modes) */
>> > > > > +#define T16_MODE_NORMAL     0
>> > > > > +#define T16_MODE_CTC_OCRA   4
>> > > > > +#define T16_MODE_CTC_ICR    12
>> > > > > +
>> > > > > +/* Accessors */
>> > > > > +#define CLKSRC(t16) (t16->crb & T16_CRB_CS)
>> > > > > +#define MODE(t16)   (((t16->crb & T16_CRB_WGM23) >> 1) | \
>> > > > > +                     (t16->cra & T16_CRA_WGM01))
>> > > > > +#define CNT(t16)    VAL16(t16->cntl, t16->cnth)
>> > > > > +#define OCRA(t16)   VAL16(t16->ocral, t16->ocrah)
>> > > > > +#define OCRB(t16)   VAL16(t16->ocrbl, t16->ocrbh)
>> > > > > +#define OCRC(t16)   VAL16(t16->ocrcl, t16->ocrch)
>> > > > > +#define ICR(t16)    VAL16(t16->icrl, t16->icrh)
>> > > > > +
>> > > > > +/* Helper macros */
>> > > > > +#define VAL16(l, h) ((h << 8) | l)
>> > > > > +#define ERROR(fmt, args...) \
>> > > > > +    qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ##
>> args)
>> > > > > +#define DB_PRINT(fmt, args...) /* Nothing */
>> > > > > +/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n",
>> __func__, ## args)*/
>> > > > > +
>> > > > > +static inline int64_t avr_timer16_ns_to_ticks(AVRTimer16State
>> *t16, int64_t t)
>> > > > > +{
>> > > > > +    if (t16->period_ns == 0) {
>> > > > > +        return 0;
>> > > > > +    }
>> > > > > +    return t / t16->period_ns;
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_timer16_update_cnt(AVRTimer16State *t16)
>> > > > > +{
>> > > > > +    uint16_t cnt;
>> > > > > +    cnt = avr_timer16_ns_to_ticks(t16,
>> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
>> > > > > +                                       t16->reset_time_ns);
>> > > > > +    t16->cntl = (uint8_t)(cnt & 0xff);
>> > > > > +    t16->cnth = (uint8_t)((cnt & 0xff00) >> 8);
>> > > > > +}
>> > > > > +
>> > > > > +static inline void avr_timer16_recalc_reset_time(AVRTimer16State
>> *t16)
>> > > > > +{
>> > > > > +    t16->reset_time_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
>> > > > > +                         CNT(t16) * t16->period_ns;
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_timer16_clock_reset(AVRTimer16State *t16)
>> > > > > +{
>> > > > > +    t16->cntl = 0;
>> > > > > +    t16->cnth = 0;
>> > > > > +    t16->reset_time_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_timer16_clksrc_update(AVRTimer16State *t16)
>> > > > > +{
>> > > > > +    uint16_t divider = 0;
>> > > > > +    switch (CLKSRC(t16)) {
>> > > > > +    case T16_CLKSRC_EXT_FALLING:
>> > > > > +    case T16_CLKSRC_EXT_RISING:
>> > > > > +        ERROR("external clock source unsupported");
>> > > > > +        goto end;
>> > > > > +    case T16_CLKSRC_STOPPED:
>> > > > > +        goto end;
>> > > > > +    case T16_CLKSRC_DIV1:
>> > > > > +        divider = 1;
>> > > > > +        break;
>> > > > > +    case T16_CLKSRC_DIV8:
>> > > > > +        divider = 8;
>> > > > > +        break;
>> > > > > +    case T16_CLKSRC_DIV64:
>> > > > > +        divider = 64;
>> > > > > +        break;
>> > > > > +    case T16_CLKSRC_DIV256:
>> > > > > +        divider = 256;
>> > > > > +        break;
>> > > > > +    case T16_CLKSRC_DIV1024:
>> > > > > +        divider = 1024;
>> > > > > +        break;
>> > > > > +    default:
>> > > > > +        goto end;
>> > > > > +    }
>> > > > > +    t16->freq_hz = t16->cpu_freq_hz / divider;
>> > > > > +    t16->period_ns = 1000000000ULL / t16->freq_hz;
>> > > > > +    DB_PRINT("Timer frequency %" PRIu64 " hz, period %" PRIu64 "
>> ns (%f s)",
>> > > > > +             t16->freq_hz, t16->period_ns, 1 /
>> (double)t16->freq_hz);
>> > > > > +end:
>> > > > > +    return;
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_timer16_set_alarm(AVRTimer16State *t16)
>> > > > > +{
>> > > > > +    if (CLKSRC(t16) == T16_CLKSRC_EXT_FALLING ||
>> > > > > +        CLKSRC(t16) == T16_CLKSRC_EXT_RISING ||
>> > > > > +        CLKSRC(t16) == T16_CLKSRC_STOPPED) {
>> > > > > +        /* Timer is disabled or set to external clock source
>> (unsupported) */
>> > > > > +        goto end;
>> > > > > +    }
>> > > > > +
>> > > > > +    uint64_t alarm_offset = 0xffff;
>> > > > > +    enum NextInterrupt next_interrupt = OVERFLOW;
>> > > > > +
>> > > > > +    switch (MODE(t16)) {
>> > > > > +    case T16_MODE_NORMAL:
>> > > > > +        /* Normal mode */
>> > > > > +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) &&
>> > > > > +            (t16->imsk & T16_INT_OCA)) {
>> > > > > +            alarm_offset = OCRA(t16);
>> > > > > +            next_interrupt = COMPA;
>> > > > > +        }
>> > > > > +        break;
>> > > > > +    case T16_MODE_CTC_OCRA:
>> > > > > +        /* CTC mode, top = ocra */
>> > > > > +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16)) {
>> > > > > +            alarm_offset = OCRA(t16);
>> > > > > +            next_interrupt = COMPA;
>> > > > > +        }
>> > > > > +       break;
>> > > > > +    case T16_MODE_CTC_ICR:
>> > > > > +        /* CTC mode, top = icr */
>> > > > > +        if (ICR(t16) < alarm_offset && ICR(t16) > CNT(t16)) {
>> > > > > +            alarm_offset = ICR(t16);
>> > > > > +            next_interrupt = CAPT;
>> > > > > +        }
>> > > > > +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) &&
>> > > > > +            (t16->imsk & T16_INT_OCA)) {
>> > > > > +            alarm_offset = OCRA(t16);
>> > > > > +            next_interrupt = COMPA;
>> > > > > +        }
>> > > > > +        break;
>> > > > > +    default:
>> > > > > +        ERROR("pwm modes are unsupported");
>> > > > > +        goto end;
>> > > > > +    }
>> > > > > +    if (OCRB(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
>> > > > > +        (t16->imsk & T16_INT_OCB)) {
>> > > > > +        alarm_offset = OCRB(t16);
>> > > > > +        next_interrupt = COMPB;
>> > > > > +    }
>> > > > > +    if (OCRC(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
>> > > > > +        (t16->imsk & T16_INT_OCC)) {
>> > > > > +        alarm_offset = OCRB(t16);
>> > > > > +        next_interrupt = COMPC;
>> > > > > +    }
>> > > > > +    alarm_offset -= CNT(t16);
>> > > > > +
>> > > > > +    t16->next_interrupt = next_interrupt;
>> > > > > +    uint64_t alarm_ns =
>> > > > > +        t16->reset_time_ns + ((CNT(t16) + alarm_offset) *
>> t16->period_ns);
>> > > > > +    timer_mod(t16->timer, alarm_ns);
>> > > > > +
>> > > > > +    DB_PRINT("next alarm %" PRIu64 " ns from now",
>> > > > > +        alarm_offset * t16->period_ns);
>> > > > > +
>> > > > > +end:
>> > > > > +    return;
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_timer16_interrupt(void *opaque)
>> > > > > +{
>> > > > > +    AVRTimer16State *t16 = opaque;
>> > > > > +    uint8_t mode = MODE(t16);
>> > > > > +
>> > > > > +    avr_timer16_update_cnt(t16);
>> > > > > +
>> > > > > +    if (CLKSRC(t16) == T16_CLKSRC_EXT_FALLING ||
>> > > > > +        CLKSRC(t16) == T16_CLKSRC_EXT_RISING ||
>> > > > > +        CLKSRC(t16) == T16_CLKSRC_STOPPED) {
>> > > > > +        /* Timer is disabled or set to external clock source
>> (unsupported) */
>> > > > > +        return;
>> > > > > +    }
>> > > > > +
>> > > > > +    DB_PRINT("interrupt, cnt = %d", CNT(t16));
>> > > > > +
>> > > > > +    /* Counter overflow */
>> > > > > +    if (t16->next_interrupt == OVERFLOW) {
>> > > > > +        DB_PRINT("0xffff overflow");
>> > > > > +        avr_timer16_clock_reset(t16);
>> > > > > +        if (t16->imsk & T16_INT_TOV) {
>> > > > > +            t16->ifr |= T16_INT_TOV;
>> > > > > +            qemu_set_irq(t16->ovf_irq, 1);
>> > > > > +        }
>> > > > > +    }
>> > > > > +    /* Check for ocra overflow in CTC mode */
>> > > > > +    if (mode == T16_MODE_CTC_OCRA && t16->next_interrupt ==
>> COMPA) {
>> > > > > +        DB_PRINT("CTC OCRA overflow");
>> > > > > +        avr_timer16_clock_reset(t16);
>> > > > > +    }
>> > > > > +    /* Check for icr overflow in CTC mode */
>> > > > > +    if (mode == T16_MODE_CTC_ICR && t16->next_interrupt == CAPT)
>> {
>> > > > > +        DB_PRINT("CTC ICR overflow");
>> > > > > +        avr_timer16_clock_reset(t16);
>> > > > > +        if (t16->imsk & T16_INT_IC) {
>> > > > > +            t16->ifr |= T16_INT_IC;
>> > > > > +            qemu_set_irq(t16->capt_irq, 1);
>> > > > > +        }
>> > > > > +    }
>> > > > > +    /* Check for output compare interrupts */
>> > > > > +    if (t16->imsk & T16_INT_OCA && t16->next_interrupt == COMPA)
>> {
>> > > > > +        t16->ifr |= T16_INT_OCA;
>> > > > > +        qemu_set_irq(t16->compa_irq, 1);
>> > > > > +    }
>> > > > > +    if (t16->imsk & T16_INT_OCB && t16->next_interrupt == COMPB)
>> {
>> > > > > +        t16->ifr |= T16_INT_OCB;
>> > > > > +        qemu_set_irq(t16->compb_irq, 1);
>> > > > > +    }
>> > > > > +    if (t16->imsk & T16_INT_OCC && t16->next_interrupt == COMPC)
>> {
>> > > > > +        t16->ifr |= T16_INT_OCC;
>> > > > > +        qemu_set_irq(t16->compc_irq, 1);
>> > > > > +    }
>> > > > > +    avr_timer16_set_alarm(t16);
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_timer16_reset(DeviceState *dev)
>> > > > > +{
>> > > > > +    AVRTimer16State *t16 = AVR_TIMER16(dev);
>> > > > > +
>> > > > > +    avr_timer16_clock_reset(t16);
>> > > > > +    avr_timer16_clksrc_update(t16);
>> > > > > +    avr_timer16_set_alarm(t16);
>> > > > > +
>> > > > > +    qemu_set_irq(t16->capt_irq, 0);
>> > > > > +    qemu_set_irq(t16->compa_irq, 0);
>> > > > > +    qemu_set_irq(t16->compb_irq, 0);
>> > > > > +    qemu_set_irq(t16->compc_irq, 0);
>> > > > > +    qemu_set_irq(t16->ovf_irq, 0);
>> > > > > +}
>> > > > > +
>> > > > > +static uint64_t avr_timer16_read(void *opaque, hwaddr offset,
>> unsigned size)
>> > > > > +{
>> > > > > +    assert(size == 1);
>> > > > > +    AVRTimer16State *t16 = opaque;
>> > > > > +    uint8_t retval = 0;
>> > > > > +
>> > > > > +    switch (offset) {
>> > > > > +    case T16_CRA:
>> > > > > +        retval = t16->cra;
>> > > > > +        break;
>> > > > > +    case T16_CRB:
>> > > > > +        retval = t16->crb;
>> > > > > +        break;
>> > > > > +    case T16_CRC:
>> > > > > +        retval = t16->crc;
>> > > > > +        break;
>> > > > > +    case T16_CNTL:
>> > > > > +        avr_timer16_update_cnt(t16);
>> > > > > +        t16->rtmp = t16->cnth;
>> > > > > +        retval = t16->cntl;
>> > > > > +        break;
>> > > > > +    case T16_CNTH:
>> > > > > +        retval = t16->rtmp;
>> > > > > +        break;
>> > > > > +    case T16_ICRL:
>> > > > > +        /*
>> > > > > +         * The timer copies cnt to icr when the input capture
>> pin changes
>> > > > > +         * state or when the analog comparator has a match. We
>> don't
>> > > > > +         * emulate this behaviour. We do support it's use for
>> defining a
>> > > > > +         * TOP value in T16_MODE_CTC_ICR
>> > > > > +         */
>> > > > > +        t16->rtmp = t16->icrh;
>> > > > > +        retval = t16->icrl;
>> > > > > +        break;
>> > > > > +    case T16_ICRH:
>> > > > > +        retval = t16->rtmp;
>> > > > > +        break;
>> > > > > +    case T16_OCRAL:
>> > > > > +        retval = t16->ocral;
>> > > > > +        break;
>> > > > > +    case T16_OCRAH:
>> > > > > +        retval = t16->ocrah;
>> > > > > +        break;
>> > > > > +    case T16_OCRBL:
>> > > > > +        retval = t16->ocrbl;
>> > > > > +        break;
>> > > > > +    case T16_OCRBH:
>> > > > > +        retval = t16->ocrbh;
>> > > > > +        break;
>> > > > > +    case T16_OCRCL:
>> > > > > +        retval = t16->ocrcl;
>> > > > > +        break;
>> > > > > +    case T16_OCRCH:
>> > > > > +        retval = t16->ocrch;
>> > > > > +        break;
>> > > > > +    default:
>> > > > > +        break;
>> > > > > +    }
>> > > > > +    return (uint64_t)retval;
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_timer16_write(void *opaque, hwaddr offset,
>> > > > > +                              uint64_t val64, unsigned size)
>> > > > > +{
>> > > > > +    assert(size == 1);
>> > > > > +    AVRTimer16State *t16 = opaque;
>> > > > > +    uint8_t val8 = (uint8_t)val64;
>> > > > > +    uint8_t prev_clk_src = CLKSRC(t16);
>> > > > > +
>> > > > > +    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
>> > > > > +
>> > > > > +    switch (offset) {
>> > > > > +    case T16_CRA:
>> > > > > +        t16->cra = val8;
>> > > > > +        if (t16->cra & T16_CRA_OC_CONF) {
>> > > > > +            ERROR("output compare pins unsupported");
>> > > > > +        }
>> > > > > +        break;
>> > > > > +    case T16_CRB:
>> > > > > +        t16->crb = val8;
>> > > > > +        if (t16->crb & T16_CRB_ICNC) {
>> > > > > +            ERROR("input capture noise canceller unsupported");
>> > > > > +        }
>> > > > > +        if (t16->crb & T16_CRB_ICES) {
>> > > > > +            ERROR("input capture unsupported");
>> > > > > +        }
>> > > > > +        if (CLKSRC(t16) != prev_clk_src) {
>> > > > > +            avr_timer16_clksrc_update(t16);
>> > > > > +            if (prev_clk_src == T16_CLKSRC_STOPPED) {
>> > > > > +                t16->reset_time_ns =
>> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> > > > > +            }
>> > > > > +        }
>> > > > > +        break;
>> > > > > +    case T16_CRC:
>> > > > > +        t16->crc = val8;
>> > > > > +        ERROR("output compare pins unsupported");
>> > > > > +        break;
>> > > > > +    case T16_CNTL:
>> > > > > +        /*
>> > > > > +         * CNT is the 16-bit counter value, it must be
>> read/written via
>> > > > > +         * a temporary register (rtmp) to make the read/write
>> atomic.
>> > > > > +         */
>> > > > > +        /* ICR also has this behaviour, and shares rtmp */
>> > > > > +        /*
>> > > > > +         * Writing CNT blocks compare matches for one clock
>> cycle.
>> > > > > +         * Writing CNT to TOP or to an OCR value (if in use) will
>> > > > > +         * skip the relevant interrupt
>> > > > > +         */
>> > > > > +        t16->cntl = val8;
>> > > > > +        t16->cnth = t16->rtmp;
>> > > > > +        avr_timer16_recalc_reset_time(t16);
>> > > > > +        break;
>> > > > > +    case T16_CNTH:
>> > > > > +        t16->rtmp = val8;
>> > > > > +        break;
>> > > > > +    case T16_ICRL:
>> > > > > +        /* ICR can only be written in mode T16_MODE_CTC_ICR */
>> > > > > +        if (MODE(t16) == T16_MODE_CTC_ICR) {
>> > > > > +            t16->icrl = val8;
>> > > > > +            t16->icrh = t16->rtmp;
>> > > > > +        }
>> > > > > +        break;
>> > > > > +    case T16_ICRH:
>> > > > > +        if (MODE(t16) == T16_MODE_CTC_ICR) {
>> > > > > +            t16->rtmp = val8;
>> > > > > +        }
>> > > > > +        break;
>> > > > > +    case T16_OCRAL:
>> > > > > +        /*
>> > > > > +         * OCRn cause the relevant output compare flag to be
>> raised, and
>> > > > > +         * trigger an interrupt, when CNT is equal to the value
>> here
>> > > > > +         */
>> > > > > +        t16->ocral = val8;
>> > > > > +        break;
>> > > > > +    case T16_OCRAH:
>> > > > > +        t16->ocrah = val8;
>> > > > > +        break;
>> > > > > +    case T16_OCRBL:
>> > > > > +        t16->ocrbl = val8;
>> > > > > +        break;
>> > > > > +    case T16_OCRBH:
>> > > > > +        t16->ocrbh = val8;
>> > > > > +        break;
>> > > > > +    case T16_OCRCL:
>> > > > > +        t16->ocrcl = val8;
>> > > > > +        break;
>> > > > > +    case T16_OCRCH:
>> > > > > +        t16->ocrch = val8;
>> > > > > +        break;
>> > > > > +    default:
>> > > > > +        break;
>> > > > > +    }
>> > > > > +    avr_timer16_set_alarm(t16);
>> > > > > +}
>> > > > > +
>> > > > > +static uint64_t avr_timer16_imsk_read(void *opaque,
>> > > > > +                                      hwaddr offset,
>> > > > > +                                      unsigned size)
>> > > > > +{
>> > > > > +    assert(size == 1);
>> > > > > +    AVRTimer16State *t16 = opaque;
>> > > > > +    if (offset != 0) {
>> > > > > +        return 0;
>> > > > > +    }
>> > > > > +    return t16->imsk;
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_timer16_imsk_write(void *opaque, hwaddr offset,
>> > > > > +                                   uint64_t val64, unsigned size)
>> > > > > +{
>> > > > > +    assert(size == 1);
>> > > > > +    AVRTimer16State *t16 = opaque;
>> > > > > +    if (offset != 0) {
>> > > > > +        return;
>> > > > > +    }
>> > > > > +    t16->imsk = (uint8_t)val64;
>> > > > > +}
>> > > > > +
>> > > > > +static uint64_t avr_timer16_ifr_read(void *opaque,
>> > > > > +                                     hwaddr offset,
>> > > > > +                                     unsigned size)
>> > > > > +{
>> > > > > +    assert(size == 1);
>> > > > > +    AVRTimer16State *t16 = opaque;
>> > > > > +    if (offset != 0) {
>> > > > > +        return 0;
>> > > > > +    }
>> > > > > +    return t16->ifr;
>> > > > > +}
>> > > > > +
>> > > > > +static void avr_timer16_ifr_write(void *opaque, hwaddr offset,
>> > > > > +                                  uint64_t val64, unsigned size)
>> > > > > +{
>> > > > > +    assert(size == 1);
>> > > > > +    AVRTimer16State *t16 = opaque;
>> > > > > +    if (offset != 0) {
>> > > > > +        return;
>> > > > > +    }
>> > > > > +    t16->ifr = (uint8_t)val64;
>> > > > > +}
>> > > > > +
>> > > > > +static const MemoryRegionOps avr_timer16_ops = {
>> > > > > +    .read = avr_timer16_read,
>> > > > > +    .write = avr_timer16_write,
>> > > > > +    .endianness = DEVICE_NATIVE_ENDIAN,
>> > > > > +    .impl = {.max_access_size = 1}
>> > > > > +};
>> > > > > +
>> > > > > +static const MemoryRegionOps avr_timer16_imsk_ops = {
>> > > > > +    .read = avr_timer16_imsk_read,
>> > > > > +    .write = avr_timer16_imsk_write,
>> > > > > +    .endianness = DEVICE_NATIVE_ENDIAN,
>> > > > > +    .impl = {.max_access_size = 1}
>> > > > > +};
>> > > > > +
>> > > > > +static const MemoryRegionOps avr_timer16_ifr_ops = {
>> > > > > +    .read = avr_timer16_ifr_read,
>> > > > > +    .write = avr_timer16_ifr_write,
>> > > > > +    .endianness = DEVICE_NATIVE_ENDIAN,
>> > >
>
>

--00000000000042f8670598660d55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, November 28, 2019, Aleksandar Markovic &lt;<a href=3D"=
mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><br><br>On Thursday, November 28, 201=
9, Sarah Harris &lt;<a href=3D"mailto:seh53@kent.ac.uk" target=3D"_blank">s=
eh53@kent.ac.uk</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Aleks=
andar,<br>
<br>
&gt; Sarah, thanks for taking your tome to respond!<br>
No problem! :)<br>
<br>
&gt; do we fully support what is said in:<br>
&gt; * 22.6.2 Sending Frames with 9 Data Bit<br>
&gt; * 22.7.2 Receiving Frames with 9 Data Bits<br>
No, QEMU&#39;s character device system only supports 8 bit characters.<br>
Shorter characters can be padded easily, but longer is a problem.<br>
At the moment we just emit a warning and ignore the extra bit in UCSRnB (i.=
e. behave as if 8 bits was selected).<br>
<br>
&gt; And the same question for section:<br>
&gt; * 22.9 Multi-processor Communication Mode<br>
No, this was out of scope for testing use.<br>
This case is checked when writing to the UCSRnA register, `if (value &amp; =
USART_CSRA_MPCM)`, and causes a warning.<br>
I don&#39;t know if we should crash instead, but at the moment we just log =
the warning and continue.<br>
(USART emulation will be incorrect from when this happens and until MPCM is=
 disabled)<br>
<br></blockquote><div><br></div><div>OK. Thanks. All this sounds reasonable=
 to me. Do you agree that we insert:</div><div><br></div><div>/*</div><div>=
=C2=A0* Limitation of this emulation:</div><div>=C2=A0*</div><div>=C2=A0* =
=C2=A0 * Sending and receiving frames with 9 data bits sre not supported</d=
iv><div>=C2=A0* =C2=A0 * Multi-processor communication mode is not supporte=
d</div><div>=C2=A0*/</div><div><br></div><div>or a similar comment, close t=
o the top of the file?</div><div><br></div></blockquote><div><br></div><div=
>One more question, Sarah, Michael left the license preambles the same as o=
riginals, however this is not a good license (there are some legal nuances)=
 for QEMU, do you agree that the license preambles for your implementations=
 are changed to LGPL 2.1 (with wording &quot;or later (at your option)&quot=
;) that Michael used elsewhere?</div><div><br></div><div>Best regards,</div=
><div><br></div><div>=C2=A0Aleksandar</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><div>Yours,</div><div>Aleksandar</div><div><br></div><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
Kind regards,<br>
Sarah Harris<br>
<br>
<br>
On Mon, 25 Nov 2019 19:57:48 +0100<br>
Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" targ=
et=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br>
<br>
&gt; On Mon, Nov 25, 2019 at 4:57 PM Sarah Harris &lt;<a href=3D"mailto:seh=
53@kent.ac.uk" target=3D"_blank">seh53@kent.ac.uk</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Hi Aleksandar,<br>
&gt; &gt;<br>
&gt; &gt; &gt; - Is there a place in docs that explain its implementation i=
n general?<br>
&gt; &gt; This implementation was based on the datasheet for the ATmega2560=
 (&quot;ATmega640/1280/1281/2560/256<wbr>1 datasheet&quot; available from M=
icrochip&#39;s website).<br>
&gt; &gt; (I&#39;m not sure if posting a URL will trigger any spam filters,=
 so I&#39;ll leave it for now)<br>
&gt; &gt; See section 22.10, &quot;USART - Register Description&quot;.<br>
&gt; &gt;<br>
&gt; <br>
&gt; OK.<br>
&gt; <br>
&gt; &gt; &gt; - Why do cases 4, 5, 6 issue relatively unclear error messag=
e<br>
&gt; &gt; &gt; &quot;&quot;update_char_mask(): Reserved character size &lt;=
mode&gt;&quot;? Is there a<br>
&gt; &gt; &gt; better wording perhaps? Where is justification in the doc fo=
r these<br>
&gt; &gt; &gt; cases?<br>
&gt; &gt; The hardware can send/receive characters of various lengths, spec=
ified by settings in these configuration registers.<br>
&gt; &gt; The cases are defined in table 22-7, &quot;UCSZn Bits Settings&qu=
ot;, which specifies that modes 4, 5, and 6 are reserved and should not be =
used.<br>
&gt; &gt; I&#39;m not sure how better to explain this fault to the user; th=
is is an edge case that I&#39;d expect only an AVR developer testing their =
own program to see, so describing it in the same way as the datasheet seems=
 a good idea.<br>
&gt; &gt;<br>
&gt; <br>
&gt; OK. I somehow missed table 22-7 while comparing the code and specs - m=
y bad.<br>
&gt; <br>
&gt; &gt; &gt; - What would be the docs justification for case 7? Why is an=
 error<br>
&gt; &gt; &gt; message issued, but still &quot;char_mask&quot; is set, and =
I guess, further<br>
&gt; &gt; &gt; processing will go on? Why the error message says &quot;Nine=
 bit character<br>
&gt; &gt; &gt; requested&quot;? Who said that (that *nine* bit characters w=
ere requested?<br>
&gt; &gt; &gt; :-)<br>
&gt; &gt; Case 7 also comes from table 22-7, and specifies that the USART s=
hould send/receive 9 bits per character.<br>
&gt; &gt; For characters &lt;=3D 8 bits it&#39;s easy to pad them to the 8 =
bit bytes that the character device subsystem operates on.<br>
&gt; &gt; For characters of 9 bits we&#39;d have to throw away one bit, whi=
ch seems like a bad thing to do.<br>
&gt; &gt; I decided it wasn&#39;t enough to justify crashing, but the user =
should be made aware that data is being lost and the output might not be wh=
at they would otherwise expect.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Sarah, thanks for taking your tome to respond! Could you just explain<=
br>
&gt; to me do we fully support what is said in:<br>
&gt; <br>
&gt; * 22.6.2 Sending Frames with 9 Data Bit<br>
&gt; * 22.7.2 Receiving Frames with 9 Data Bits<br>
&gt; <br>
&gt; or perhaps there are some limitations?<br>
&gt; <br>
&gt; And the same question for section:<br>
&gt; <br>
&gt; * 22.9 Multi-processor Communication Mode<br>
&gt; <br>
&gt; Please note that I don&#39;t suggest amending or extending your<br>
&gt; implementation, I just want to understand it better.<br>
&gt; <br>
&gt; Best regards,<br>
&gt; Aleksandar<br>
&gt; <br>
&gt; <br>
&gt; &gt; Kind regards,<br>
&gt; &gt; Sarah Harris<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Fri, 22 Nov 2019 16:10:02 +0100<br>
&gt; &gt; Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail=
.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; On Tue, Oct 29, 2019 at 10:25 PM Michael Rolnik &lt;<a href=
=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; w=
rote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; From: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@ken=
t.ac.uk" target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; These were designed to facilitate testing but should pr=
ovide enough function to be useful in other contexts.<br>
&gt; &gt; &gt; &gt; Only a subset of the functions of each peripheral is im=
plemented, mainly due to the lack of a standard way to handle electrical co=
nnections (like GPIO pins).<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Sarah Harris &lt;<a href=3D"mailto:S.E.H=
arris@kent.ac.uk" target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;=C2=A0 hw/char/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt; &gt; &gt; &gt;=C2=A0 hw/char/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt; &gt; &gt; &gt;=C2=A0 hw/char/avr_usart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 324 ++++++++++++++++++<br>
&gt; &gt; &gt; &gt;=C2=A0 hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt; &gt; &gt; &gt;=C2=A0 hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A02 +<br>
&gt; &gt; &gt; &gt;=C2=A0 hw/misc/avr_mask.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 112 ++++++<br>
&gt; &gt; &gt; &gt;=C2=A0 hw/timer/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt; &gt; &gt; &gt;=C2=A0 hw/timer/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt; &gt; &gt; &gt;=C2=A0 hw/timer/avr_timer16.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 605 ++++++++++++++++++++++++++++++<wbr>+++<br>
&gt; &gt; &gt; &gt;=C2=A0 include/hw/char/avr_usart.h=C2=A0 =C2=A0 |=C2=A0 =
97 ++++++<br>
&gt; &gt; &gt; &gt;=C2=A0 include/hw/misc/avr_mask.h=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 47 +++<br>
&gt; &gt; &gt; &gt;=C2=A0 include/hw/timer/avr_timer16.h |=C2=A0 97 ++++++<=
br>
&gt; &gt; &gt; &gt;=C2=A0 12 files changed, 1296 insertions(+)<br>
&gt; &gt; &gt; &gt;=C2=A0 create mode 100644 hw/char/avr_usart.c<br>
&gt; &gt; &gt; &gt;=C2=A0 create mode 100644 hw/misc/avr_mask.c<br>
&gt; &gt; &gt; &gt;=C2=A0 create mode 100644 hw/timer/avr_timer16.c<br>
&gt; &gt; &gt; &gt;=C2=A0 create mode 100644 include/hw/char/avr_usart.h<br=
>
&gt; &gt; &gt; &gt;=C2=A0 create mode 100644 include/hw/misc/avr_mask.h<br>
&gt; &gt; &gt; &gt;=C2=A0 create mode 100644 include/hw/timer/avr_timer16.h=
<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/hw/char/Kconfig b/hw/char/Kconfig<br>
&gt; &gt; &gt; &gt; index 40e7a8b8bb..331b20983f 100644<br>
&gt; &gt; &gt; &gt; --- a/hw/char/Kconfig<br>
&gt; &gt; &gt; &gt; +++ b/hw/char/Kconfig<br>
&gt; &gt; &gt; &gt; @@ -46,3 +46,6 @@ config SCLPCONSOLE<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 config TERMINAL3270<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +config AVR_USART<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 bool<br>
&gt; &gt; &gt; &gt; diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.o=
bjs<br>
&gt; &gt; &gt; &gt; index 02d8a66925..f05c1f5667 100644<br>
&gt; &gt; &gt; &gt; --- a/hw/char/Makefile.objs<br>
&gt; &gt; &gt; &gt; +++ b/hw/char/Makefile.objs<br>
&gt; &gt; &gt; &gt; @@ -21,6 +21,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_vty.=
o<br>
&gt; &gt; &gt; &gt;=C2=A0 obj-$(CONFIG_DIGIC) +=3D digic-uart.o<br>
&gt; &gt; &gt; &gt;=C2=A0 obj-$(CONFIG_STM32F2XX_USART) +=3D stm32f2xx_usar=
t.o<br>
&gt; &gt; &gt; &gt;=C2=A0 obj-$(CONFIG_RASPI) +=3D bcm2835_aux.o<br>
&gt; &gt; &gt; &gt; +common-obj-$(CONFIG_AVR_USART<wbr>) +=3D avr_usart.o<b=
r>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 common-obj-$(CONFIG_CMSDK_APB_<wbr>UART) +=3D cms=
dk-apb-uart.o<br>
&gt; &gt; &gt; &gt;=C2=A0 common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_ser.o<b=
r>
&gt; &gt; &gt; &gt; diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c<=
br>
&gt; &gt; &gt; &gt; new file mode 100644<br>
&gt; &gt; &gt; &gt; index 0000000000..9ca3c2a1cd<br>
&gt; &gt; &gt; &gt; --- /dev/null<br>
&gt; &gt; &gt; &gt; +++ b/hw/char/avr_usart.c<br>
&gt; &gt; &gt; &gt; @@ -0,0 +1,324 @@<br>
&gt; &gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; &gt; + * AVR USART<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * Copyright (c) 2018 University of Kent<br>
&gt; &gt; &gt; &gt; + * Author: Sarah Harris<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * Permission is hereby granted, free of charge, to an=
y person obtaining a copy<br>
&gt; &gt; &gt; &gt; + * of this software and associated documentation files=
 (the &quot;Software&quot;), to deal<br>
&gt; &gt; &gt; &gt; + * in the Software without restriction, including with=
out limitation the rights<br>
&gt; &gt; &gt; &gt; + * to use, copy, modify, merge, publish, distribute, s=
ublicense, and/or sell<br>
&gt; &gt; &gt; &gt; + * copies of the Software, and to permit persons to wh=
om the Software is<br>
&gt; &gt; &gt; &gt; + * furnished to do so, subject to the following condit=
ions:<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * The above copyright notice and this permission noti=
ce shall be included in<br>
&gt; &gt; &gt; &gt; + * all copies or substantial portions of the Software.=
<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT=
 WARRANTY OF ANY KIND, EXPRESS OR<br>
&gt; &gt; &gt; &gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIE=
S OF MERCHANTABILITY,<br>
&gt; &gt; &gt; &gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMEN=
T. IN NO EVENT SHALL<br>
&gt; &gt; &gt; &gt; + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY =
CLAIM, DAMAGES OR OTHER<br>
&gt; &gt; &gt; &gt; + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT O=
R OTHERWISE, ARISING FROM,<br>
&gt; &gt; &gt; &gt; + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE US=
E OR OTHER DEALINGS IN<br>
&gt; &gt; &gt; &gt; + * THE SOFTWARE.<br>
&gt; &gt; &gt; &gt; + */<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;hw/char/avr_usart.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;qemu/log.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;hw/irq.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static int avr_usart_can_receive(void *opaque)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRUsartState *usart =3D opaque;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (usart-&gt;data_valid || !(usart-&gt;=
csrb &amp; USART_CSRB_RXEN)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 return 1;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_usart_receive(void *opaque, const uint=
8_t *buffer, int size)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRUsartState *usart =3D opaque;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert(!usart-&gt;data_valid);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 usart-&gt;data =3D buffer[0];<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 usart-&gt;data_valid =3D true;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 usart-&gt;csra |=3D USART_CSRA_RXC;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (usart-&gt;csrb &amp; USART_CSRB_RXCI=
E) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(usart-&gt;rxc=
_irq, 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void update_char_mask(AVRUsartState *usart)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t mode =3D ((usart-&gt;csrc &amp; =
USART_CSRC_CSZ0) ? 1 : 0) |<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((usart-&gt;csrc &amp; USA=
RT_CSRC_CSZ1) ? 2 : 0) |<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((usart-&gt;csrb &amp; USA=
RT_CSRB_CSZ2) ? 4 : 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 switch (mode) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case 0:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;char_mask =3D 0b=
11111;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case 1:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;char_mask =3D 0b=
111111;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case 2:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;char_mask =3D 0b=
1111111;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case 3:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;char_mask =3D 0b=
11111111;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case 4:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fallthrough. */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case 5:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fallthrough. */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case 6:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LOG_GUEST_ER=
ROR,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s: Re=
served character size 0x%x\n&quot;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__,<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case 7:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LOG_GUEST_ER=
ROR,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s: Ni=
ne bit character size not supported (forcing eight)\n&quot;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__);<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;char_mask =3D 0b=
11111111;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hello, Michael.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Please explain to me some details of update_char_mask():<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - Is there a place in docs that explain its implementation i=
n general?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - Why do cases 4, 5, 6 issue relatively unclear error messag=
e<br>
&gt; &gt; &gt; &quot;&quot;update_char_mask(): Reserved character size &lt;=
mode&gt;&quot;? Is there a<br>
&gt; &gt; &gt; better wording perhaps? Where is justification in the doc fo=
r these<br>
&gt; &gt; &gt; cases?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - What would be the docs justification for case 7? Why is an=
 error<br>
&gt; &gt; &gt; message issued, but still &quot;char_mask&quot; is set, and =
I guess, further<br>
&gt; &gt; &gt; processing will go on? Why the error message says &quot;Nine=
 bit character<br>
&gt; &gt; &gt; requested&quot;? Who said that (that *nine* bit characters w=
ere requested?<br>
&gt; &gt; &gt; :-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Sincerely,<br>
&gt; &gt; &gt; Aleksandar<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; +static void avr_usart_reset(DeviceState *dev)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRUsartState *usart =3D AVR_USART(dev);=
<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 usart-&gt;data_valid =3D false;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 usart-&gt;csra =3D 0b00100000;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 usart-&gt;csrb =3D 0b00000000;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 usart-&gt;csrc =3D 0b00000110;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 usart-&gt;brrl =3D 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 usart-&gt;brrh =3D 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 update_char_mask(usart);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qemu_set_irq(usart-&gt;rxc_irq, 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qemu_set_irq(usart-&gt;txc_irq, 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qemu_set_irq(usart-&gt;dre_irq, 0);<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static uint64_t avr_usart_read(void *opaque, hwaddr ad=
dr, unsigned int size)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRUsartState *usart =3D opaque;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t data;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (!usart-&gt;enabled) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 switch (addr) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case USART_DR:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(usart-&gt;csrb &amp;=
 USART_CSRB_RXEN)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Receiver =
disabled, ignore. */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (usart-&gt;data_valid) =
{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D usa=
rt-&gt;data &amp; usart-&gt;char_mask;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;da=
ta_valid =3D false;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D 0;<=
br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;csra &amp;=3D 0x=
ff ^ USART_CSRA_RXC;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(usart-&gt;rxc=
_irq, 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_accept_input(&=
amp;usar<wbr>t-&gt;chr);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return data;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case USART_CSRA:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return usart-&gt;csra;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case USART_CSRB:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return usart-&gt;csrb;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case USART_CSRC:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return usart-&gt;csrc;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case USART_BRRL:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return usart-&gt;brrl;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case USART_BRRH:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return usart-&gt;brrh;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LOG_GUEST_ER=
ROR,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s: Ba=
d offset 0x%&quot;HWADDR_PRIx&quot;\n&quot;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__,<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_usart_write(void *opaque, hwaddr addr,=
 uint64_t value,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int si=
ze)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRUsartState *usart =3D opaque;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t mask;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t data;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert((value &amp; 0xff) =3D=3D value);=
<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (!usart-&gt;enabled) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 switch (addr) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case USART_DR:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(usart-&gt;csrb &amp;=
 USART_CSRB_TXEN)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Transmitt=
er disabled, ignore. */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;csra |=3D USART_=
CSRA_TXC;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;csra |=3D USART_=
CSRA_DRE;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (usart-&gt;csrb &amp; U=
SART_CSRB_TXCIE) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq=
(usart-&gt;txc_irq, 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;cs=
ra &amp;=3D 0xff ^ USART_CSRA_TXC;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (usart-&gt;csrb &amp; U=
SART_CSRB_DREIE) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq=
(usart-&gt;dre_irq, 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D value;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_write_all(&amp=
;usart-&gt;<wbr>chr, &amp;data, 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case USART_CSRA:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D 0b01000011;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Mask read-only bits. */=
<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D (value &amp; mas=
k) | (usart-&gt;csra &amp; (0xff ^ mask));<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;csra =3D value;<=
br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; USART_CSRA=
_TXC) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;cs=
ra ^=3D USART_CSRA_TXC;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq=
(usart-&gt;txc_irq, 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; USART_CSRA=
_MPCM) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mas=
k(<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 LOG_GUEST_ERROR,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;%s: MPCM not supported by USART\n&quot;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case USART_CSRB:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D 0b11111101;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Mask read-only bits. */=
<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D (value &amp; mas=
k) | (usart-&gt;csrb &amp; (0xff ^ mask));<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;csrb =3D value;<=
br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(value &amp; USART_CS=
RB_RXEN)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Receiver =
disabled, flush input buffer. */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;da=
ta_valid =3D false;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(usart-&gt;rxc=
_irq,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((value &amp=
; USART_CSRB_RXCIE) &amp;&amp;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (usart-&gt;c=
sra &amp; USART_CSRA_RXC)) ? 1 : 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(usart-&gt;txc=
_irq,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((value &amp=
; USART_CSRB_TXCIE) &amp;&amp;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (usart-&gt;c=
sra &amp; USART_CSRA_TXC)) ? 1 : 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(usart-&gt;dre=
_irq,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((value &amp=
; USART_CSRB_DREIE) &amp;&amp;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (usart-&gt;c=
sra &amp; USART_CSRA_DRE)) ? 1 : 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 update_char_mask(usart);<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case USART_CSRC:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;csrc =3D value;<=
br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((value &amp; USART_CSR=
C_MSEL1) &amp;&amp; (value &amp; USART_CSRC_MSEL0)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mas=
k(<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 LOG_GUEST_ERROR,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;%s: SPI mode not supported by USART\n&quot;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((value &amp; USART_CSR=
C_MSEL1) &amp;&amp; !(value &amp; USART_CSRC_MSEL0)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mas=
k(LOG_GUEST_ERROR, &quot;%s: Bad USART mode\n&quot;, __func__);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(value &amp; USART_CS=
RC_PM1) &amp;&amp; (value &amp; USART_CSRC_PM0)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mas=
k(<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 LOG_GUEST_ERROR,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;%s: Bad USART parity mode\n&quot;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 update_char_mask(usart);<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case USART_BRRL:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;brrl =3D value;<=
br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case USART_BRRH:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usart-&gt;brrh =3D value &=
amp; 0b00001111;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LOG_GUEST_ER=
ROR,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s: Ba=
d offset 0x%&quot;HWADDR_PRIx&quot;\n&quot;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__,<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static const MemoryRegionOps avr_usart_ops =3D {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .read =3D avr_usart_read,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .write =3D avr_usart_write,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .impl =3D {.min_access_size =3D 1, .max_=
access_size =3D 1}<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static Property avr_usart_properties[] =3D {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 DEFINE_PROP_CHR(&quot;chardev&quot;, AVR=
UsartState, chr),<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_usart_pr(void *opaque, int irq, int le=
vel)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRUsartState *s =3D AVR_USART(opaque);<=
br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 s-&gt;enabled =3D !level;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (!s-&gt;enabled) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 avr_usart_reset(DEVICE(s))=
;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_usart_init(Object *obj)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRUsartState *s =3D AVR_USART(obj);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_DEVICE<wbr>(obj)=
, &amp;s-&gt;rxc_irq);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_DEVICE<wbr>(obj)=
, &amp;s-&gt;dre_irq);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_DEVICE<wbr>(obj)=
, &amp;s-&gt;txc_irq);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;mmio<wb=
r>, obj, &amp;avr_usart_ops, s, TYPE_AVR_USART, 8);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_DEVIC<wbr>E(obj=
), &amp;s-&gt;mmio);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qdev_init_gpio_in(DEVICE(s), avr_usart_p=
r, 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 s-&gt;enabled =3D true;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_usart_realize(DeviceState *dev, Error =
**errp)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRUsartState *s =3D AVR_USART(dev);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qemu_chr_fe_set_handlers(&amp;s-&gt;c<wb=
r>hr, avr_usart_can_receive,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avr_usart_receive, NULL=
, NULL,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s, NULL, true);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 avr_usart_reset(dev);<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_usart_class_init(ObjectCla<wbr>ss *kla=
ss, void *data)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);=
<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 dc-&gt;reset =3D avr_usart_reset;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 dc-&gt;props =3D avr_usart_properties;<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D avr_usart_realize;<br=
>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static const TypeInfo avr_usart_info =3D {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D TYPE_AVR_USART,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D T=
YPE_SYS_BUS_DEVICE,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(AVRUsartState)=
,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .instance_init =3D avr_usart_init,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D avr_usart_c=
lass_init,<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_usart_register_types(void)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 type_register_static(&amp;avr_usar<wbr>t=
_info);<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +type_init(avr_usart_register_<wbr>types)<br>
&gt; &gt; &gt; &gt; diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig<br>
&gt; &gt; &gt; &gt; index 2164646553..e79841e3a4 100644<br>
&gt; &gt; &gt; &gt; --- a/hw/misc/Kconfig<br>
&gt; &gt; &gt; &gt; +++ b/hw/misc/Kconfig<br>
&gt; &gt; &gt; &gt; @@ -125,4 +125,7 @@ config MAC_VIA<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 select MOS6522<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 select ADB<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; +config AVR_MASK<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 bool<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt;=C2=A0 source macio/Kconfig<br>
&gt; &gt; &gt; &gt; diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.o=
bjs<br>
&gt; &gt; &gt; &gt; index ba898a5781..3a8093be6a 100644<br>
&gt; &gt; &gt; &gt; --- a/hw/misc/Makefile.objs<br>
&gt; &gt; &gt; &gt; +++ b/hw/misc/Makefile.objs<br>
&gt; &gt; &gt; &gt; @@ -82,3 +82,5 @@ common-obj-$(CONFIG_NRF51_SOC) +=3D n=
rf51_rng.o<br>
&gt; &gt; &gt; &gt;=C2=A0 obj-$(CONFIG_MAC_VIA) +=3D mac_via.o<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 common-obj-$(CONFIG_GRLIB) +=3D grlib_ahb_apb_pnp=
.o<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +obj-$(CONFIG_AVR_MASK) +=3D avr_mask.o<br>
&gt; &gt; &gt; &gt; diff --git a/hw/misc/avr_mask.c b/hw/misc/avr_mask.c<br=
>
&gt; &gt; &gt; &gt; new file mode 100644<br>
&gt; &gt; &gt; &gt; index 0000000000..3af82ed9c1<br>
&gt; &gt; &gt; &gt; --- /dev/null<br>
&gt; &gt; &gt; &gt; +++ b/hw/misc/avr_mask.c<br>
&gt; &gt; &gt; &gt; @@ -0,0 +1,112 @@<br>
&gt; &gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; &gt; + * AVR Power Reduction<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * Copyright (c) 2019 Michael Rolnik<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * Permission is hereby granted, free of charge, to an=
y person obtaining a copy<br>
&gt; &gt; &gt; &gt; + * of this software and associated documentation files=
 (the &quot;Software&quot;), to deal<br>
&gt; &gt; &gt; &gt; + * in the Software without restriction, including with=
out limitation the rights<br>
&gt; &gt; &gt; &gt; + * to use, copy, modify, merge, publish, distribute, s=
ublicense, and/or sell<br>
&gt; &gt; &gt; &gt; + * copies of the Software, and to permit persons to wh=
om the Software is<br>
&gt; &gt; &gt; &gt; + * furnished to do so, subject to the following condit=
ions:<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * The above copyright notice and this permission noti=
ce shall be included in<br>
&gt; &gt; &gt; &gt; + * all copies or substantial portions of the Software.=
<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT=
 WARRANTY OF ANY KIND, EXPRESS OR<br>
&gt; &gt; &gt; &gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIE=
S OF MERCHANTABILITY,<br>
&gt; &gt; &gt; &gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMEN=
T. IN NO EVENT SHALL<br>
&gt; &gt; &gt; &gt; + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY =
CLAIM, DAMAGES OR OTHER<br>
&gt; &gt; &gt; &gt; + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT O=
R OTHERWISE, ARISING FROM,<br>
&gt; &gt; &gt; &gt; + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE US=
E OR OTHER DEALINGS IN<br>
&gt; &gt; &gt; &gt; + * THE SOFTWARE.<br>
&gt; &gt; &gt; &gt; + */<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;hw/misc/avr_mask.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;qemu/log.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;hw/irq.h&quot;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +#define DB_PRINT(fmt, args...) /* Nothing */<br>
&gt; &gt; &gt; &gt; +/*#define DB_PRINT(fmt, args...) printf(&quot;%s: &quo=
t; fmt &quot;\n&quot;, __func__, ## args)*/<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_mask_reset(DeviceState *dev)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRMaskState *s =3D AVR_MASK(dev);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 s-&gt;val =3D 0x00;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 for (int i =3D 0; i &lt; 8; i++) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq[i],=
 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static uint64_t avr_mask_read(void *opaque, hwaddr off=
set, unsigned size)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert(offset =3D=3D 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRMaskState *s =3D opaque;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 return (uint64_t)s-&gt;val;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_mask_write(void *opaque, hwaddr offset=
,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val64, unsign=
ed size)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert(offset =3D=3D 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRMaskState *s =3D opaque;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t val8 =3D val64;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 DB_PRINT(&quot;write %d to offset %d&quo=
t;, val8, (uint8_t)offset);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 s-&gt;val =3D val8;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 for (int i =3D 0; i &lt; 8; i++) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq[i],=
 (val8 &amp; (1 &lt;&lt; i)) !=3D 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static const MemoryRegionOps avr_mask_ops =3D {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .read =3D avr_mask_read,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .write =3D avr_mask_write,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .impl =3D {.max_access_size =3D 1}<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_mask_init(Object *dev)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRMaskState *s =3D AVR_MASK(dev);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 SysBusDevice *busdev =3D SYS_BUS_DEVICE(=
dev);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iome<wb=
r>m, dev, &amp;avr_mask_ops, s, TYPE_AVR_MASK,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 sysbus_init_mmio(busdev, &amp;s-&gt;iome=
m);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 for (int i =3D 0; i &lt; 8; i++) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_init_irq(busdev, &a=
mp;s-&gt;irq[i]);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 s-&gt;val =3D 0x00;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_mask_class_init(ObjectClas<wbr>s *klas=
s, void *data)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);=
<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 dc-&gt;reset =3D avr_mask_reset;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static const TypeInfo avr_mask_info =3D {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D TYPE_AVR_MASK,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D T=
YPE_SYS_BUS_DEVICE,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(AVRMaskState),=
<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D avr_mask_cl=
ass_init,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .instance_init =3D avr_mask_init,<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_mask_register_types(void)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 type_register_static(&amp;avr_mask<wbr>_=
info);<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +type_init(avr_mask_register_t<wbr>ypes)<br>
&gt; &gt; &gt; &gt; diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig<br>
&gt; &gt; &gt; &gt; index a990f9fe35..4343bc23f3 100644<br>
&gt; &gt; &gt; &gt; --- a/hw/timer/Kconfig<br>
&gt; &gt; &gt; &gt; +++ b/hw/timer/Kconfig<br>
&gt; &gt; &gt; &gt; @@ -34,3 +34,6 @@ config CMSDK_APB_TIMER<br>
&gt; &gt; &gt; &gt;=C2=A0 config CMSDK_APB_DUALTIMER<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 select PTIMER<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +config AVR_TIMER16<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 bool<br>
&gt; &gt; &gt; &gt; diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile=
.objs<br>
&gt; &gt; &gt; &gt; index dece235fd7..af0913ca3b 100644<br>
&gt; &gt; &gt; &gt; --- a/hw/timer/Makefile.objs<br>
&gt; &gt; &gt; &gt; +++ b/hw/timer/Makefile.objs<br>
&gt; &gt; &gt; &gt; @@ -35,3 +35,5 @@ common-obj-$(CONFIG_CMSDK_APB_<wbr>TI=
MER) +=3D cmsdk-apb-timer.o<br>
&gt; &gt; &gt; &gt;=C2=A0 common-obj-$(CONFIG_CMSDK_APB_<wbr>DUALTIMER) +=
=3D cmsdk-apb-dualtimer.o<br>
&gt; &gt; &gt; &gt;=C2=A0 common-obj-$(CONFIG_MSF2) +=3D mss-timer.o<br>
&gt; &gt; &gt; &gt;=C2=A0 common-obj-$(CONFIG_RASPI) +=3D bcm2835_systmr.o<=
br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +obj-$(CONFIG_AVR_TIMER16) +=3D avr_timer16.o<br>
&gt; &gt; &gt; &gt; diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_time=
r16.c<br>
&gt; &gt; &gt; &gt; new file mode 100644<br>
&gt; &gt; &gt; &gt; index 0000000000..ac6ef73e77<br>
&gt; &gt; &gt; &gt; --- /dev/null<br>
&gt; &gt; &gt; &gt; +++ b/hw/timer/avr_timer16.c<br>
&gt; &gt; &gt; &gt; @@ -0,0 +1,605 @@<br>
&gt; &gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; &gt; + * AVR 16 bit timer<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * Copyright (c) 2018 University of Kent<br>
&gt; &gt; &gt; &gt; + * Author: Ed Robbins<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * Permission is hereby granted, free of charge, to an=
y person obtaining a copy<br>
&gt; &gt; &gt; &gt; + * of this software and associated documentation files=
 (the &quot;Software&quot;), to deal<br>
&gt; &gt; &gt; &gt; + * in the Software without restriction, including with=
out limitation the rights<br>
&gt; &gt; &gt; &gt; + * to use, copy, modify, merge, publish, distribute, s=
ublicense, and/or sell<br>
&gt; &gt; &gt; &gt; + * copies of the Software, and to permit persons to wh=
om the Software is<br>
&gt; &gt; &gt; &gt; + * furnished to do so, subject to the following condit=
ions:<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * The above copyright notice and this permission noti=
ce shall be included in<br>
&gt; &gt; &gt; &gt; + * all copies or substantial portions of the Software.=
<br>
&gt; &gt; &gt; &gt; + *<br>
&gt; &gt; &gt; &gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT=
 WARRANTY OF ANY KIND, EXPRESS OR<br>
&gt; &gt; &gt; &gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIE=
S OF MERCHANTABILITY,<br>
&gt; &gt; &gt; &gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMEN=
T. IN NO EVENT SHALL<br>
&gt; &gt; &gt; &gt; + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY =
CLAIM, DAMAGES OR OTHER<br>
&gt; &gt; &gt; &gt; + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT O=
R OTHERWISE, ARISING FROM,<br>
&gt; &gt; &gt; &gt; + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE US=
E OR OTHER DEALINGS IN<br>
&gt; &gt; &gt; &gt; + * THE SOFTWARE.<br>
&gt; &gt; &gt; &gt; + */<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; &gt; + * Driver for 16 bit timers on 8 bit AVR devices.<br>
&gt; &gt; &gt; &gt; + * Note:<br>
&gt; &gt; &gt; &gt; + * ATmega640/V-1280/V-1281/V-2560<wbr>/V-2561/V timers=
 1, 3, 4 and 5 are 16 bit<br>
&gt; &gt; &gt; &gt; + */<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; &gt; + * XXX TODO: Power Reduction Register support<br>
&gt; &gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prescaler p=
ause support<br>
&gt; &gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PWM modes, =
GPIO, output capture pins, input compare pin<br>
&gt; &gt; &gt; &gt; + */<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;hw/timer/avr_timer16.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;qemu/log.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;hw/irq.h&quot;<br>
&gt; &gt; &gt; &gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +/* Register offsets */<br>
&gt; &gt; &gt; &gt; +#define T16_CRA=C2=A0 =C2=A0 =C2=A00x0<br>
&gt; &gt; &gt; &gt; +#define T16_CRB=C2=A0 =C2=A0 =C2=A00x1<br>
&gt; &gt; &gt; &gt; +#define T16_CRC=C2=A0 =C2=A0 =C2=A00x2<br>
&gt; &gt; &gt; &gt; +#define T16_CNTL=C2=A0 =C2=A0 0x4<br>
&gt; &gt; &gt; &gt; +#define T16_CNTH=C2=A0 =C2=A0 0x5<br>
&gt; &gt; &gt; &gt; +#define T16_ICRL=C2=A0 =C2=A0 0x6<br>
&gt; &gt; &gt; &gt; +#define T16_ICRH=C2=A0 =C2=A0 0x7<br>
&gt; &gt; &gt; &gt; +#define T16_OCRAL=C2=A0 =C2=A00x8<br>
&gt; &gt; &gt; &gt; +#define T16_OCRAH=C2=A0 =C2=A00x9<br>
&gt; &gt; &gt; &gt; +#define T16_OCRBL=C2=A0 =C2=A00xa<br>
&gt; &gt; &gt; &gt; +#define T16_OCRBH=C2=A0 =C2=A00xb<br>
&gt; &gt; &gt; &gt; +#define T16_OCRCL=C2=A0 =C2=A00xc<br>
&gt; &gt; &gt; &gt; +#define T16_OCRCH=C2=A0 =C2=A00xd<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +/* Field masks */<br>
&gt; &gt; &gt; &gt; +#define T16_CRA_WGM01=C2=A0 =C2=A00x3<br>
&gt; &gt; &gt; &gt; +#define T16_CRA_COMC=C2=A0 =C2=A0 0xc<br>
&gt; &gt; &gt; &gt; +#define T16_CRA_COMB=C2=A0 =C2=A0 0x30<br>
&gt; &gt; &gt; &gt; +#define T16_CRA_COMA=C2=A0 =C2=A0 0xc0<br>
&gt; &gt; &gt; &gt; +#define T16_CRA_OC_CONF \<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 (T16_CRA_COMA | T16_CRA_COMB | T16_CRA_C=
OMC)<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +#define T16_CRB_CS=C2=A0 =C2=A0 =C2=A0 0x7<br>
&gt; &gt; &gt; &gt; +#define T16_CRB_WGM23=C2=A0 =C2=A00x18<br>
&gt; &gt; &gt; &gt; +#define T16_CRB_ICES=C2=A0 =C2=A0 0x40<br>
&gt; &gt; &gt; &gt; +#define T16_CRB_ICNC=C2=A0 =C2=A0 0x80<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +#define T16_CRC_FOCC=C2=A0 =C2=A0 0x20<br>
&gt; &gt; &gt; &gt; +#define T16_CRC_FOCB=C2=A0 =C2=A0 0x40<br>
&gt; &gt; &gt; &gt; +#define T16_CRC_FOCA=C2=A0 =C2=A0 0x80<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +/* Fields masks both TIMSK and TIFR (interrupt mask/fl=
ag registers) */<br>
&gt; &gt; &gt; &gt; +#define T16_INT_TOV=C2=A0 =C2=A0 0x1 /* Timer overflow=
 */<br>
&gt; &gt; &gt; &gt; +#define T16_INT_OCA=C2=A0 =C2=A0 0x2 /* Output compare=
 A */<br>
&gt; &gt; &gt; &gt; +#define T16_INT_OCB=C2=A0 =C2=A0 0x4 /* Output compare=
 B */<br>
&gt; &gt; &gt; &gt; +#define T16_INT_OCC=C2=A0 =C2=A0 0x8 /* Output compare=
 C */<br>
&gt; &gt; &gt; &gt; +#define T16_INT_IC=C2=A0 =C2=A0 =C2=A00x20 /* Input ca=
pture */<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +/* Clock source values */<br>
&gt; &gt; &gt; &gt; +#define T16_CLKSRC_STOPPED=C2=A0 =C2=A0 =C2=A00<br>
&gt; &gt; &gt; &gt; +#define T16_CLKSRC_DIV1=C2=A0 =C2=A0 =C2=A0 =C2=A0 1<b=
r>
&gt; &gt; &gt; &gt; +#define T16_CLKSRC_DIV8=C2=A0 =C2=A0 =C2=A0 =C2=A0 2<b=
r>
&gt; &gt; &gt; &gt; +#define T16_CLKSRC_DIV64=C2=A0 =C2=A0 =C2=A0 =C2=A03<b=
r>
&gt; &gt; &gt; &gt; +#define T16_CLKSRC_DIV256=C2=A0 =C2=A0 =C2=A0 4<br>
&gt; &gt; &gt; &gt; +#define T16_CLKSRC_DIV1024=C2=A0 =C2=A0 =C2=A05<br>
&gt; &gt; &gt; &gt; +#define T16_CLKSRC_EXT_FALLING 6<br>
&gt; &gt; &gt; &gt; +#define T16_CLKSRC_EXT_RISING=C2=A0 7<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +/* Timer mode values (not including PWM modes) */<br>
&gt; &gt; &gt; &gt; +#define T16_MODE_NORMAL=C2=A0 =C2=A0 =C2=A00<br>
&gt; &gt; &gt; &gt; +#define T16_MODE_CTC_OCRA=C2=A0 =C2=A04<br>
&gt; &gt; &gt; &gt; +#define T16_MODE_CTC_ICR=C2=A0 =C2=A0 12<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +/* Accessors */<br>
&gt; &gt; &gt; &gt; +#define CLKSRC(t16) (t16-&gt;crb &amp; T16_CRB_CS)<br>
&gt; &gt; &gt; &gt; +#define MODE(t16)=C2=A0 =C2=A0(((t16-&gt;crb &amp; T16=
_CRB_WGM23) &gt;&gt; 1) | \<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(t16-&gt;cra &amp; T16_CRA_WGM01))<br>
&gt; &gt; &gt; &gt; +#define CNT(t16)=C2=A0 =C2=A0 VAL16(t16-&gt;cntl, t16-=
&gt;cnth)<br>
&gt; &gt; &gt; &gt; +#define OCRA(t16)=C2=A0 =C2=A0VAL16(t16-&gt;ocral, t16=
-&gt;ocrah)<br>
&gt; &gt; &gt; &gt; +#define OCRB(t16)=C2=A0 =C2=A0VAL16(t16-&gt;ocrbl, t16=
-&gt;ocrbh)<br>
&gt; &gt; &gt; &gt; +#define OCRC(t16)=C2=A0 =C2=A0VAL16(t16-&gt;ocrcl, t16=
-&gt;ocrch)<br>
&gt; &gt; &gt; &gt; +#define ICR(t16)=C2=A0 =C2=A0 VAL16(t16-&gt;icrl, t16-=
&gt;icrh)<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +/* Helper macros */<br>
&gt; &gt; &gt; &gt; +#define VAL16(l, h) ((h &lt;&lt; 8) | l)<br>
&gt; &gt; &gt; &gt; +#define ERROR(fmt, args...) \<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s:=
 &quot; fmt &quot;\n&quot;, __func__, ## args)<br>
&gt; &gt; &gt; &gt; +#define DB_PRINT(fmt, args...) /* Nothing */<br>
&gt; &gt; &gt; &gt; +/*#define DB_PRINT(fmt, args...) printf(&quot;%s: &quo=
t; fmt &quot;\n&quot;, __func__, ## args)*/<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static inline int64_t avr_timer16_ns_to_ticks(AVRTim<w=
br>er16State *t16, int64_t t)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (t16-&gt;period_ns =3D=3D 0) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 return t / t16-&gt;period_ns;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_timer16_update_cnt(AVRTime<wbr>r16Stat=
e *t16)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint16_t cnt;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 cnt =3D avr_timer16_ns_to_ticks(t16, qem=
u_clock_get_ns(QEMU_CLOCK_V<wbr>IRTUAL) -<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0t16-&gt;reset_time_ns);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 t16-&gt;cntl =3D (uint8_t)(cnt &amp; 0xf=
f);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 t16-&gt;cnth =3D (uint8_t)((cnt &amp; 0x=
ff00) &gt;&gt; 8);<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static inline void avr_timer16_recalc_reset_time(<wbr>=
AVRTimer16State *t16)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 t16-&gt;reset_time_ns =3D qemu_clock_get=
_ns(QEMU_CLOCK_V<wbr>IRTUAL) -<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CNT(t16) * t16-&gt;period_ns;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_timer16_clock_reset(AVRTim<wbr>er16Sta=
te *t16)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 t16-&gt;cntl =3D 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 t16-&gt;cnth =3D 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 t16-&gt;reset_time_ns =3D qemu_clock_get=
_ns(QEMU_CLOCK_V<wbr>IRTUAL);<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_timer16_clksrc_update(AVRT<wbr>imer16S=
tate *t16)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint16_t divider =3D 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 switch (CLKSRC(t16)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CLKSRC_EXT_FALLING:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CLKSRC_EXT_RISING:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR(&quot;external clock=
 source unsupported&quot;);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CLKSRC_STOPPED:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CLKSRC_DIV1:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 divider =3D 1;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CLKSRC_DIV8:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 divider =3D 8;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CLKSRC_DIV64:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 divider =3D 64;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CLKSRC_DIV256:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 divider =3D 256;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CLKSRC_DIV1024:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 divider =3D 1024;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 t16-&gt;freq_hz =3D t16-&gt;cpu_freq_hz =
/ divider;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 t16-&gt;period_ns =3D 1000000000ULL / t1=
6-&gt;freq_hz;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 DB_PRINT(&quot;Timer frequency %&quot; P=
RIu64 &quot; hz, period %&quot; PRIu64 &quot; ns (%f s)&quot;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t16-&g=
t;freq_hz, t16-&gt;period_ns, 1 / (double)t16-&gt;freq_hz);<br>
&gt; &gt; &gt; &gt; +end:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_timer16_set_alarm(AVRTimer<wbr>16State=
 *t16)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_FA=
LLING ||<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CLKSRC(t16) =3D=3D T16_CLK=
SRC_EXT_RISING ||<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CLKSRC(t16) =3D=3D T16_CLK=
SRC_STOPPED) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Timer is disabled or se=
t to external clock source (unsupported) */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t alarm_offset =3D 0xffff;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 enum NextInterrupt next_interrupt =3D OV=
ERFLOW;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 switch (MODE(t16)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_MODE_NORMAL:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Normal mode */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (OCRA(t16) &lt; alarm_o=
ffset &amp;&amp; OCRA(t16) &gt; CNT(t16) &amp;&amp;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (t16-&gt;ims=
k &amp; T16_INT_OCA)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 alarm_offset=
 =3D OCRA(t16);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next_interru=
pt =3D COMPA;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_MODE_CTC_OCRA:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* CTC mode, top =3D ocra =
*/<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (OCRA(t16) &lt; alarm_o=
ffset &amp;&amp; OCRA(t16) &gt; CNT(t16)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 alarm_offset=
 =3D OCRA(t16);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next_interru=
pt =3D COMPA;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_MODE_CTC_ICR:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* CTC mode, top =3D icr *=
/<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ICR(t16) &lt; alarm_of=
fset &amp;&amp; ICR(t16) &gt; CNT(t16)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 alarm_offset=
 =3D ICR(t16);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next_interru=
pt =3D CAPT;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (OCRA(t16) &lt; alarm_o=
ffset &amp;&amp; OCRA(t16) &gt; CNT(t16) &amp;&amp;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (t16-&gt;ims=
k &amp; T16_INT_OCA)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 alarm_offset=
 =3D OCRA(t16);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next_interru=
pt =3D COMPA;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR(&quot;pwm modes are =
unsupported&quot;);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (OCRB(t16) &lt; alarm_offset &amp;&am=
p; OCRB(t16) &gt; CNT(t16) &amp;&amp;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (t16-&gt;imsk &amp; T16_IN=
T_OCB)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 alarm_offset =3D OCRB(t16)=
;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 next_interrupt =3D COMPB;<=
br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (OCRC(t16) &lt; alarm_offset &amp;&am=
p; OCRB(t16) &gt; CNT(t16) &amp;&amp;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (t16-&gt;imsk &amp; T16_IN=
T_OCC)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 alarm_offset =3D OCRB(t16)=
;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 next_interrupt =3D COMPC;<=
br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 alarm_offset -=3D CNT(t16);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 t16-&gt;next_interrupt =3D next_interrup=
t;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t alarm_ns =3D<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;reset_time_ns + ((=
CNT(t16) + alarm_offset) * t16-&gt;period_ns);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 timer_mod(t16-&gt;timer, alarm_ns);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 DB_PRINT(&quot;next alarm %&quot; PRIu64=
 &quot; ns from now&quot;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 alarm_offset * t16-&gt;per=
iod_ns);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +end:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_timer16_interrupt(void *opaque)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRTimer16State *t16 =3D opaque;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t mode =3D MODE(t16);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 avr_timer16_update_cnt(t16);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_FA=
LLING ||<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CLKSRC(t16) =3D=3D T16_CLK=
SRC_EXT_RISING ||<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CLKSRC(t16) =3D=3D T16_CLK=
SRC_STOPPED) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Timer is disabled or se=
t to external clock source (unsupported) */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 DB_PRINT(&quot;interrupt, cnt =3D %d&quo=
t;, CNT(t16));<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /* Counter overflow */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (t16-&gt;next_interrupt =3D=3D OVERFL=
OW) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DB_PRINT(&quot;0xffff over=
flow&quot;);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 avr_timer16_clock_reset(t1=
6);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t16-&gt;imsk &amp; T16=
_INT_TOV) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;ifr =
|=3D T16_INT_TOV;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq=
(t16-&gt;ovf_irq, 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /* Check for ocra overflow in CTC mode *=
/<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (mode =3D=3D T16_MODE_CTC_OCRA &amp;&=
amp; t16-&gt;next_interrupt =3D=3D COMPA) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DB_PRINT(&quot;CTC OCRA ov=
erflow&quot;);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 avr_timer16_clock_reset(t1=
6);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /* Check for icr overflow in CTC mode */=
<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (mode =3D=3D T16_MODE_CTC_ICR &amp;&a=
mp; t16-&gt;next_interrupt =3D=3D CAPT) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DB_PRINT(&quot;CTC ICR ove=
rflow&quot;);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 avr_timer16_clock_reset(t1=
6);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t16-&gt;imsk &amp; T16=
_INT_IC) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;ifr =
|=3D T16_INT_IC;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq=
(t16-&gt;capt_irq, 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 /* Check for output compare interrupts *=
/<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (t16-&gt;imsk &amp; T16_INT_OCA &amp;=
&amp; t16-&gt;next_interrupt =3D=3D COMPA) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;ifr |=3D T16_INT_O=
CA;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(t16-&gt;compa=
_irq, 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (t16-&gt;imsk &amp; T16_INT_OCB &amp;=
&amp; t16-&gt;next_interrupt =3D=3D COMPB) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;ifr |=3D T16_INT_O=
CB;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(t16-&gt;compb=
_irq, 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (t16-&gt;imsk &amp; T16_INT_OCC &amp;=
&amp; t16-&gt;next_interrupt =3D=3D COMPC) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;ifr |=3D T16_INT_O=
CC;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(t16-&gt;compc=
_irq, 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 avr_timer16_set_alarm(t16);<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_timer16_reset(DeviceState *dev)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRTimer16State *t16 =3D AVR_TIMER16(dev=
);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 avr_timer16_clock_reset(t16);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 avr_timer16_clksrc_update(t16)<wbr>;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 avr_timer16_set_alarm(t16);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qemu_set_irq(t16-&gt;capt_irq, 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qemu_set_irq(t16-&gt;compa_irq, 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qemu_set_irq(t16-&gt;compb_irq, 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qemu_set_irq(t16-&gt;compc_irq, 0);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qemu_set_irq(t16-&gt;ovf_irq, 0);<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static uint64_t avr_timer16_read(void *opaque, hwaddr =
offset, unsigned size)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRTimer16State *t16 =3D opaque;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t retval =3D 0;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CRA:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D t16-&gt;cra;<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CRB:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D t16-&gt;crb;<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CRC:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D t16-&gt;crc;<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CNTL:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 avr_timer16_update_cnt(t16=
);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;rtmp =3D t16-&gt;c=
nth;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D t16-&gt;cntl;<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CNTH:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D t16-&gt;rtmp;<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_ICRL:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The timer copies c=
nt to icr when the input capture pin changes<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* state or when the =
analog comparator has a match. We don&#39;t<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* emulate this behav=
iour. We do support it&#39;s use for defining a<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TOP value in T16_M=
ODE_CTC_ICR<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;rtmp =3D t16-&gt;i=
crh;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D t16-&gt;icrl;<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_ICRH:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D t16-&gt;rtmp;<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_OCRAL:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D t16-&gt;ocral;<=
br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_OCRAH:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D t16-&gt;ocrah;<=
br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_OCRBL:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D t16-&gt;ocrbl;<=
br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_OCRBH:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D t16-&gt;ocrbh;<=
br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_OCRCL:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D t16-&gt;ocrcl;<=
br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_OCRCH:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D t16-&gt;ocrch;<=
br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 return (uint64_t)retval;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_timer16_write(void *opaque, hwaddr off=
set,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val64, unsign=
ed size)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRTimer16State *t16 =3D opaque;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t val8 =3D (uint8_t)val64;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t prev_clk_src =3D CLKSRC(t16);<br=
>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 DB_PRINT(&quot;write %d to offset %d&quo=
t;, val8, (uint8_t)offset);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CRA:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;cra =3D val8;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t16-&gt;cra &amp; T16_=
CRA_OC_CONF) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR(&quot;=
output compare pins unsupported&quot;);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CRB:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;crb =3D val8;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t16-&gt;crb &amp; T16_=
CRB_ICNC) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR(&quot;=
input capture noise canceller unsupported&quot;);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t16-&gt;crb &amp; T16_=
CRB_ICES) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR(&quot;=
input capture unsupported&quot;);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (CLKSRC(t16) !=3D prev_=
clk_src) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 avr_timer16_=
clksrc_update(t16)<wbr>;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prev_clk=
_src =3D=3D T16_CLKSRC_STOPPED) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 t16-&gt;reset_time_ns =3D qemu_clock_get_ns(QEMU_CLOCK_V<wbr>IRTUAL);<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CRC:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;crc =3D val8;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR(&quot;output compare=
 pins unsupported&quot;);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CNTL:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* CNT is the 16-bit =
counter value, it must be read/written via<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* a temporary regist=
er (rtmp) to make the read/write atomic.<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ICR also has this behav=
iour, and shares rtmp */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Writing CNT blocks=
 compare matches for one clock cycle.<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Writing CNT to TOP=
 or to an OCR value (if in use) will<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* skip the relevant =
interrupt<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;cntl =3D val8;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;cnth =3D t16-&gt;r=
tmp;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 avr_timer16_recalc_reset_t=
ime(<wbr>t16);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_CNTH:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;rtmp =3D val8;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_ICRL:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ICR can only be written=
 in mode T16_MODE_CTC_ICR */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (MODE(t16) =3D=3D T16_M=
ODE_CTC_ICR) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;icrl=
 =3D val8;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;icrh=
 =3D t16-&gt;rtmp;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_ICRH:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (MODE(t16) =3D=3D T16_M=
ODE_CTC_ICR) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;rtmp=
 =3D val8;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_OCRAL:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* OCRn cause the rel=
evant output compare flag to be raised, and<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* trigger an interru=
pt, when CNT is equal to the value here<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;ocral =3D val8;<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_OCRAH:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;ocrah =3D val8;<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_OCRBL:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;ocrbl =3D val8;<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_OCRBH:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;ocrbh =3D val8;<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_OCRCL:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;ocrcl =3D val8;<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 case T16_OCRCH:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t16-&gt;ocrch =3D val8;<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 avr_timer16_set_alarm(t16);<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static uint64_t avr_timer16_imsk_read(void *opaque,<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 hwaddr offset,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 unsigned size)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRTimer16State *t16 =3D opaque;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (offset !=3D 0) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 return t16-&gt;imsk;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_timer16_imsk_write(void *opaque, hwadd=
r offset,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt64_t val64, unsigned size)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRTimer16State *t16 =3D opaque;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (offset !=3D 0) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 t16-&gt;imsk =3D (uint8_t)val64;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static uint64_t avr_timer16_ifr_read(void *opaque,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0hwaddr offset,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0unsigned size)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRTimer16State *t16 =3D opaque;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (offset !=3D 0) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 return t16-&gt;ifr;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static void avr_timer16_ifr_write(void *opaque, hwaddr=
 offset,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t=
 val64, unsigned size)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 AVRTimer16State *t16 =3D opaque;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (offset !=3D 0) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 t16-&gt;ifr =3D (uint8_t)val64;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static const MemoryRegionOps avr_timer16_ops =3D {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .read =3D avr_timer16_read,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .write =3D avr_timer16_write,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .impl =3D {.max_access_size =3D 1}<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static const MemoryRegionOps avr_timer16_imsk_ops =3D =
{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .read =3D avr_timer16_imsk_read,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .write =3D avr_timer16_imsk_write,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .impl =3D {.max_access_size =3D 1}<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +static const MemoryRegionOps avr_timer16_ifr_ops =3D {=
<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .read =3D avr_timer16_ifr_read,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .write =3D avr_timer16_ifr_write,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br=
>
&gt; &gt; </blockquote>
</blockquote>

--00000000000042f8670598660d55--

