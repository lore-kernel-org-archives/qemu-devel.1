Received: from eggs.gnu.org ([2001:4830:134:3::10]:45745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dVYd2-0002TK-22
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dVYd1-0005Av-0a
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:33:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8s+WJH+3Xt41WC7JMYG5Lqwj_d4Kg-zW7cXgwiw-5muw@mail.gmail.com>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<1499771839-32518-3-git-send-email-peter.maydell@linaro.org>
	<CAKmqyKPn+JEVWmpzypZt=8kH80aNa+aNAZLhPSWvHy+h5gyd=Q@mail.gmail.com>
	<CAFEAcA_DyoTE+idUtiWOB4ptA-TMcmU2WRYWjo2Lwt7+RD8xEQ@mail.gmail.com>
	<CAKmqyKOW1s7zbLFD2E+X+5--Gk0sBmK_mdbEaPDVD-C4JUxrKA@mail.gmail.com>
	<CAFEAcA8s+WJH+3Xt41WC7JMYG5Lqwj_d4Kg-zW7cXgwiw-5muw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Jul 2017 09:32:02 +0200
Message-ID: <CAKmqyKM7rR6n55Y+Fysomhjq26cQhJLj62oFYMDGdetmkwZVew@mail.gmail.com>
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

On Tue, Jul 11, 2017 at 6:45 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 11 July 2017 at 16:40, Alistair Francis <alistair23@gmail.com> wrote:
>> On Tue, Jul 11, 2017 at 5:33 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 11 July 2017 at 16:12, Alistair Francis <alistair23@gmail.com> wrote:
>>>> On Tue, Jul 11, 2017 at 1:17 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>> Implement a model of the simple "APB UART" provided in
>>>>> the Cortex-M System Design Kit (CMSDK).
>>>>>
>>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>
>>>>> +} CMSDKAPBUART;
>>>>
>>>> This should be CamelCase.
>>>
>>> Yes, but CamelCase where all the words are all-uppercase
>>> (as with CMSDK, APB and UART) is indistinguishable from
>>> all-uppercase. (Compare the way we say "PCIIORegion" rather
>>> than "PciIoRegion".)
>>
>> Good point, I feel like it just looks strange being all caps though.
>
> Me too, but I didn't have any better naming ideas.
>
>>>>> +static void uart_update_parameters(CMSDKAPBUART *s)
>>>>> +{
>>>>> +    QEMUSerialSetParams ssp;
>>>>> +
>>>>> +    /* This UART is always 8N1 but the baud rate is programmable.
>>>>> +     * The minimum permitted bauddiv setting is 16, so we just ignore
>>>>> +     * settings below that (usually this means the device has just
>>>>> +     * been reset and not yet programmed).
>>>>> +     */
>>>>> +    if (s->bauddiv < 16 || s->bauddiv > s->pclk_frq) {
>>>>> +        return;
>>>>> +    }
>>>>
>>>> This seems like it should deserve a guest error print.
>>>
>>> As the comment says, that would cause us to print a spurious
>>> warning every time the device was reset.
>>
>> I just see this being hard to debug. What about if not printing if
>> baud rate is 0 but guest error otherwise?
>>
>> Or can this not be called from reset?
>
> The thing is that the guest error really here is "enabled TX
> but didn't program the baud rate". So if you want to flag it
> up you'd want to do it in uart_write() at the point where
> CTRL.TX_EN is written to 1, not in this function. I decided I
> didn't really care enough to check and report that (we often
> don't bother to track every possible guest mistake). It won't
> make any difference to QEMU anyway except in the vanishingly
> rare case that the user connects QEMU up to a real serial port.
> I very nearly didn't bother to implement the set-params logic
> at all (we don't have it on the pl011 and nobody's ever complained).
>
> I can add the qemu_log on "TX_EN written as 1 and baud_div out
> of range" if you think it's helpful though.

I think it makes sense to add. It's one line of code and can possibly
be very helpful for debugging.

>
>>>>> +static int uart_can_receive(void *opaque)
>>>>> +{
>>>>> +    CMSDKAPBUART *s = CMSDK_APB_UART(opaque);
>>>>> +
>>>>> +    /* We can take a char if RX is enabled and the buffer is empty */
>>>>> +    if (s->ctrl & R_CTRL_RX_EN_MASK && !(s->state & R_STATE_RXFULL_MASK)) {
>>>>> +        return 1;
>>>>> +    }
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static void uart_receive(void *opaque, const uint8_t *buf, int size)
>>>>> +{
>>>>> +    CMSDKAPBUART *s = CMSDK_APB_UART(opaque);
>>>>> +
>>>>> +    trace_cmsdk_apb_uart_receive(*buf);
>>>>> +
>>>>> +    if (!(s->ctrl & R_CTRL_RX_EN_MASK)) {
>>>>> +        /* Just drop the character on the floor */
>>>>> +        return;
>>>>
>>>> Doesn't this also deserve a guest error print.
>>>
>>> It's a can't-happen case because uart_can_receive() won't
>>> return 1 if the EN bit is clear. Checking again here is
>>> perhaps unnecessary paranoia, but it's not a guest error.
>>
>> Ah good point. Maybe that is worth stating?
>
> Mmm, something like:
>     /* In fact uart_can_receive() ensures that we can't be
>      * called unless RX is enabled and the buffer is empty,
>      * but we include this logic as documentation of what the
>      * hardware does if a character arrives in these circumstances.
>      */
>
> (Or we could delete this and the RXFULL check below it
> entirely.)

I like the comment, it makes sure it is really clear.

Thanks,
Alistair

>
> thanks
> -- PMM
