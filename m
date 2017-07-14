Received: from eggs.gnu.org ([2001:4830:134:3::10]:49270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dW3Bz-0004Zz-Vg
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dW3Bw-000307-L5
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:11:47 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dW3Bw-0002zv-DV
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:11:44 -0400
Received: by mail-wr0-x229.google.com with SMTP id 77so69641351wrb.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 09:11:44 -0700 (PDT)
References: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
	<1500029487-14822-3-git-send-email-peter.maydell@linaro.org>
	<87mv87uj9r.fsf@linaro.org>
	<CAFEAcA_NJpj_vigDCr8dy_OH5J4T50caAGFHZPC5a+nhdTH2Uw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_NJpj_vigDCr8dy_OH5J4T50caAGFHZPC5a+nhdTH2Uw@mail.gmail.com>
Date: Fri, 14 Jul 2017 17:11:41 +0100
Message-ID: <87k23buhfm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 2/9]
 hw/char/cmsdk-apb-uart.c: Implement CMSDK APB UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Philippe =?utf-8?Q?Mathie?= =?utf-8?Q?u-Daud=C3=A9?= <f4bug@amsat.org>, "patches@linaro.org" <patches@linaro.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 14 July 2017 at 16:32, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> Implement a model of the simple "APB UART" provided in
>>> the Cortex-M System Design Kit (CMSDK).
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> This fails to compile, I think since
>> 81517ba37a6cec59f92396b4722861868eb0a500 change the API for
>> qemu_chr_fe_set_handlers.
>
>>> +static void cmsdk_apb_uart_update(CMSDKAPBUART *s)
>>> +{
>>> +    /* update outbound irqs, including handling the way the rxo and txo
>>> +     * interrupt status bits are just logical AND of the overrun bit in
>>> +     * STATE and the overrun interrupt enable bit in CTRL.
>>> +     */
>>> +    uint32_t omask = (R_INTSTATUS_RXO_MASK | R_INTSTATUS_TXO_MASK);
>>> +    s->intstatus &= ~omask;
>>> +    s->intstatus |= (s->state & (s->ctrl >> 2) & omask);
>>> +
>>> +    qemu_set_irq(s->txint, !!(s->intstatus & R_INTSTATUS_TX_MASK));
>>> +    qemu_set_irq(s->rxint, !!(s->intstatus & R_INTSTATUS_RX_MASK));
>>> +    qemu_set_irq(s->txovrint, !!(s->intstatus & R_INTSTATUS_TXO_MASK));
>>> +    qemu_set_irq(s->rxovrint, !!(s->intstatus & R_INTSTATUS_RXO_MASK));
>>> +    qemu_set_irq(s->uartint, !!(s->intstatus));
>>
>> If we updated qemu_set_irq to take a bool instead of int would the !!
>> hack no longer be needed?
>
> I am fairly sure we have a few places that utilize the ability
> to send an integer down the qemu_irq channel.
>
>>> +    case A_STATE:
>>> +        /* Bits 0 and 1 are read only; bits 2 and 3 are W1C */
>>> +        s->state &= ~(value & 0xc);
>>
>> I guess:
>>           s->state &= ~(value & (R_STATE_TXOVERRUN_MASK | R_STATE_RXOVERRUN_MASK));
>>
>> maybe a little too verbose.
>
> Well, it probably ought to use the bit mask names, yes.
>
>>> +static void cmsdk_apb_uart_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    CMSDKAPBUART *s = CMSDK_APB_UART(dev);
>>> +
>>> +    if (s->pclk_frq == 0) {
>>> +        error_setg(errp, "CMSDK APB UART: pclk-frq property must be set");
>>> +        return;
>>> +    }
>>> +
>>> +    /* This UART has no flow control, so we do not need to register
>>> +     * an event handler to deal with CHR_EVENT_BREAK.
>>> +     */
>>> +    qemu_chr_fe_set_handlers(&s->chr, uart_can_receive, uart_receive,
>>> +                             NULL, s, NULL, true);
>>
>> I think this is now:
>>
>>     qemu_chr_fe_set_handlers(&s->chr, uart_can_receive, uart_receive,
>>                              NULL, NULL, s, NULL, true);
>
> Yes. It looks like we don't have to support backend swaps
> (only hw/char/serial.c and virtio-console have support for that),
> so just the extra NULL argument will do fine.
>
> I propose to just fix both these nits in target-arm rather
> than resend.

Sure.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

>
> thanks
> -- PMM


--
Alex Bennée
