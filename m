Received: from eggs.gnu.org ([2001:4830:134:3::10]:35682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dUxIC-0006yq-GJ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dUxIA-0001Pl-VY
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:41:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_DyoTE+idUtiWOB4ptA-TMcmU2WRYWjo2Lwt7+RD8xEQ@mail.gmail.com>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<1499771839-32518-3-git-send-email-peter.maydell@linaro.org>
	<CAKmqyKPn+JEVWmpzypZt=8kH80aNa+aNAZLhPSWvHy+h5gyd=Q@mail.gmail.com>
	<CAFEAcA_DyoTE+idUtiWOB4ptA-TMcmU2WRYWjo2Lwt7+RD8xEQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Jul 2017 17:40:00 +0200
Message-ID: <CAKmqyKOW1s7zbLFD2E+X+5--Gk0sBmK_mdbEaPDVD-C4JUxrKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/7] hw/char/cmsdk-apb-uart.c: Implement
 CMSDK APB UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On Tue, Jul 11, 2017 at 5:33 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 11 July 2017 at 16:12, Alistair Francis <alistair23@gmail.com> wrote:
>> On Tue, Jul 11, 2017 at 1:17 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> Implement a model of the simple "APB UART" provided in
>>> the Cortex-M System Design Kit (CMSDK).
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
>>> +} CMSDKAPBUART;
>>
>> This should be CamelCase.
>
> Yes, but CamelCase where all the words are all-uppercase
> (as with CMSDK, APB and UART) is indistinguishable from
> all-uppercase. (Compare the way we say "PCIIORegion" rather
> than "PciIoRegion".)

Good point, I feel like it just looks strange being all caps though.

>
>>> +/* This is a model of the "APB UART" which is part of the Cortex-M
>>> + * System Design Kit (CMSDK) and documented in the Cortex-M System
>>> + * Design Kit Technical Reference Manual (ARM DDI0479C):
>>> + * https://developer.arm.com/products/system-design/system-design-kits/cortex-m-system-design-kit
>>
>> I can't find the spec from this site. Is it possible to link directly
>> to the guides? I have found a few dead links from some of these
>> marketing focused site.
>
> It's the link with the big blue button "Cortex-M System Design Kit
> TRM". I didn't want to link directly to the TRM, because that is
> (currently) an infocenter.arm.com URL which may eventually go
> away as content migrates to developer.arm.com. (The DDI document
> reference number is unique and sufficient to find the document
> in future even in the face of broken links.)
>
>>> +static void uart_update_parameters(CMSDKAPBUART *s)
>>> +{
>>> +    QEMUSerialSetParams ssp;
>>> +
>>> +    /* This UART is always 8N1 but the baud rate is programmable.
>>> +     * The minimum permitted bauddiv setting is 16, so we just ignore
>>> +     * settings below that (usually this means the device has just
>>> +     * been reset and not yet programmed).
>>> +     */
>>> +    if (s->bauddiv < 16 || s->bauddiv > s->pclk_frq) {
>>> +        return;
>>> +    }
>>
>> This seems like it should deserve a guest error print.
>
> As the comment says, that would cause us to print a spurious
> warning every time the device was reset.

I just see this being hard to debug. What about if not printing if
baud rate is 0 but guest error otherwise?

Or can this not be called from reset?

>
>>> +static int uart_can_receive(void *opaque)
>>> +{
>>> +    CMSDKAPBUART *s = CMSDK_APB_UART(opaque);
>>> +
>>> +    /* We can take a char if RX is enabled and the buffer is empty */
>>> +    if (s->ctrl & R_CTRL_RX_EN_MASK && !(s->state & R_STATE_RXFULL_MASK)) {
>>> +        return 1;
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +static void uart_receive(void *opaque, const uint8_t *buf, int size)
>>> +{
>>> +    CMSDKAPBUART *s = CMSDK_APB_UART(opaque);
>>> +
>>> +    trace_cmsdk_apb_uart_receive(*buf);
>>> +
>>> +    if (!(s->ctrl & R_CTRL_RX_EN_MASK)) {
>>> +        /* Just drop the character on the floor */
>>> +        return;
>>
>> Doesn't this also deserve a guest error print.
>
> It's a can't-happen case because uart_can_receive() won't
> return 1 if the EN bit is clear. Checking again here is
> perhaps unnecessary paranoia, but it's not a guest error.

Ah good point. Maybe that is worth stating?

Thanks,
Alistair

>
>>> +    }
>>> +
>>> +    if (s->state & R_STATE_RXFULL_MASK) {
>>> +        s->state |= R_STATE_RXOVERRUN_MASK;
>>> +    }
>>> +
>>> +    s->rxbuf = *buf;
>>> +    s->state |= R_STATE_RXFULL_MASK;
>>> +    if (s->ctrl & R_CTRL_RX_INTEN_MASK) {
>>> +        s->intstatus |= R_INTSTATUS_RX_MASK;
>>> +    }
>>> +    cmsdk_apb_uart_update(s);
>>> +}
>>> +
>>> +static uint64_t uart_read(void *opaque, hwaddr offset, unsigned size)
>>> +{
>>> +    CMSDKAPBUART *s = CMSDK_APB_UART(opaque);
>>> +    uint64_t r;
>>> +
>>> +    switch (offset) {
>>> +    case A_DATA:
>>> +        r = s->rxbuf;
>>> +        s->state &= ~R_STATE_RXFULL_MASK;
>>> +        cmsdk_apb_uart_update(s);
>>> +        break;
>>> +    case A_STATE:
>>> +        r = s->state;
>>> +        break;
>>> +    case A_CTRL:
>>> +        r = s->ctrl;
>>> +        break;
>>> +    case A_INTSTATUS:
>>> +        r = s->intstatus;
>>> +        break;
>>> +    case A_BAUDDIV:
>>> +        r = s->bauddiv;
>>> +        break;
>>
>> You used pasrt of the register API but not the second part. This seems
>> like a greaet device to use the register API on.
>
> I really don't like the register API. The field definition
> convenience macros are fine, but I prefer to define devices
> with read and write functions with switches, I think it's
> clearer, and it's easier to see where you want to put a breakpoint
> to be able to step through register reads and writes, and so on.
>
>>> +    case A_PID4 ... A_CID3:
>>> +        r = uart_id[offset / 4 - A_PID4];
>>
>> I think this is the one you already found in the cover letter.
>
> Yep. (Same in both timer and uart.)
>
>>> +    switch (offset) {
>>> +    case A_DATA:
>>> +    {
>>> +        s->txbuf = value;
>>> +        if (s->state & R_STATE_TXFULL_MASK) {
>>> +            /* Buffer already full -- note the overrun and let the
>>> +             * existing pending transmit callback handle the new char.
>>> +             */
>>> +            s->state |= R_STATE_TXOVERRUN_MASK;
>>> +            cmsdk_apb_uart_update(s);
>>> +        } else {
>>> +            s->state |= R_STATE_TXFULL_MASK;
>>> +            uart_transmit(NULL, G_IO_OUT, s);
>>> +        }
>>> +        break;
>>> +    }
>>
>> Why is this case inside braces?
>
> I probably had a local variable in there at one point which
> I ended up not needing. I'll delete the braces.
>
> thanks
> -- PMM
