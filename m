Received: from eggs.gnu.org ([2001:4830:134:3::10]:51358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.gacek@gmail.com>) id 1cEwqh-0005sn-N3
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 06:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.gacek@gmail.com>) id 1cEwqd-0001jY-K3
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 06:26:51 -0500
MIME-Version: 1.0
In-Reply-To: <CAHgzvFjyvHOSYdGyi8_ug+tO1rE_0TZXVQwc9g=NnZJxQ2Dtdg@mail.gmail.com>
References: <CAHgzvFi2wjPtJzU9hXzdaZsbYr085VCbjfsiUeVc5XnUR8arHw@mail.gmail.com>
	<293c3354-b11b-a31f-39dc-b7264ad0bb24@redhat.com>
	<20161208104252.GH9606@toto>
	<CAHgzvFjyvHOSYdGyi8_ug+tO1rE_0TZXVQwc9g=NnZJxQ2Dtdg@mail.gmail.com>
From: Andrew Gacek <andrew.gacek@gmail.com>
Date: Thu, 8 Dec 2016 05:25:26 -0600
Message-ID: <CAHgzvFi2ft+Oqo7MvmJQWa_Wv5AYKxZveaLi2FZ3OiY8BZrA=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] cadence_uart: Check if
 receiver timeout counter is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm@nongnu.org

Laurent, thanks for CC'ing Xilinx Zynq maintainers. I read that part
of the submission guidelines, then completely forgot to do it.

Edgar, thanks for the comments. I wasn't sure if I needed to call that
function or not. Also, one other discrepancy with the technical
reference manual is that writing to R_RTOR should mask off all but the
lower 8 bits. I'm not sure how important that actually is (since the
timer isn't really implemented in qemu), but I thought I'd mention it.
For my use case, the current patch fixes the issue we were having.

-Andrew

On Thu, Dec 8, 2016 at 5:21 AM, Andrew Gacek <andrew.gacek@gmail.com> wrote:
> When register Rcvr_timeout_reg0 (R_RTOR in cadence_uart.c) is set to
> 0, the receiver timeout counter should be disabled. See page 1801 of
> "Zynq-7000 AP SoC Technical Reference Manual". This commit adds a
> such a check before setting the receive timeout interrupt.
>
> Signed-off-by: Andrew Gacek <andrew.gacek@gmail.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  hw/char/cadence_uart.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index 0215d65..378630d 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -138,9 +138,11 @@ static void fifo_trigger_update(void *opaque)
>  {
>      CadenceUARTState *s = opaque;
>
> -    s->r[R_CISR] |= UART_INTR_TIMEOUT;
> +    if (s->r[R_RTOR]) {
> +        s->r[R_CISR] |= UART_INTR_TIMEOUT;
>
> -    uart_update_status(s);
> +        uart_update_status(s);
> +    }
>  }
>
>  static void uart_rx_reset(CadenceUARTState *s)
> --
> 2.7.4
>
> On Thu, Dec 8, 2016 at 4:42 AM, Edgar E. Iglesias
> <edgar.iglesias@gmail.com> wrote:
>> On Thu, Dec 08, 2016 at 08:50:40AM +0100, Laurent Vivier wrote:
>>> I CC: Xilinx Zynq Maintainers.
>>>
>>> Laurent
>>
>> Thanks
>>
>>>
>>> On 07/12/2016 22:12, Andrew Gacek wrote:
>>> > When register Rcvr_timeout_reg0 (R_RTOR in cadence_uart.c) is set to
>>> > 0, the receiver timeout counter should be disabled. See page 1801 of
>>> > "Zynq-7000 AP SoC Technical Reference Manual". This commit adds a
>>> > such a check before setting the receive timeout interrupt.
>>
>> We could also try to disable the timer when rtor is zero but I think
>> that exposes a bunch of corner cases that would complicate the model a bit.
>> So IMO, this patch is good.
>>
>>
>>> > Signed-off-by: Andrew Gacek <andrew.gacek@gmail.com>
>>> > ---
>>> >  hw/char/cadence_uart.c | 4 +++-
>>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>>> >
>>> > diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
>>> > index 0215d65..54194b1 100644
>>> > --- a/hw/char/cadence_uart.c
>>> > +++ b/hw/char/cadence_uart.c
>>> > @@ -138,7 +138,9 @@ static void fifo_trigger_update(void *opaque)
>>> >  {
>>> >      CadenceUARTState *s = opaque;
>>> >
>>> > -    s->r[R_CISR] |= UART_INTR_TIMEOUT;
>>> > +    if (s->r[R_RTOR]) {
>>> > +        s->r[R_CISR] |= UART_INTR_TIMEOUT;
>>> > +    }
>>> >
>>> >      uart_update_status(s);
>>
>> Since you are not modifying the IRQ state when the timeout is disabled, you can avoid calling uart_update_status too (because it will only end up recomputing the same state).
>>
>> With that fix:
>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>>
>> Best regards,
>> Edgar
