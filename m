Received: from eggs.gnu.org ([2001:4830:134:3::10]:58842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ramysameh26@gmail.com>) id 1dpI5X-0001iD-Ki
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ramysameh26@gmail.com>) id 1dpI5S-0001vu-A1
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:56:39 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:34302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ramysameh26@gmail.com>)
	id 1dpI5S-0001uz-3n
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:56:34 -0400
Received: by mail-oi0-x233.google.com with SMTP id h70so29228359oic.1
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 10:56:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9YNO7kgC8yzZ_RUKck=+98pUET0ogVZ7TvC1kxV+_fFA@mail.gmail.com>
References: <CAF6HrYxj5BoTQpQjz95Z1_N_p615jpEE12xh_afuuqE4fcTyLg@mail.gmail.com>
	<CAFEAcA9YNO7kgC8yzZ_RUKck=+98pUET0ogVZ7TvC1kxV+_fFA@mail.gmail.com>
From: Ramy Sameh <ramysameh26@gmail.com>
Date: Tue, 5 Sep 2017 19:56:31 +0200
Message-ID: <CAF6HrYwT7WP_i7cVhvEyRvqSK7J+bLnKU4b+WrMQfVkLaNDrvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Questions regarding emulated UART in VersatilePB
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ahmed Aly <ahmedaly50@gmail.com>

Thanks Peter for your help.

Are there any documentation or source of information, that can describe how
interrupts are implemented, and how to use them (where is the vector table
to put the ISR ... etc) ?
In addition, any source of info that describes the code workflow when
reading or writing to the uart would be very helpful.
(because I put printfs in the functions to understand the workflow, but the
order of these printfs made me very confused).

Regarding the registers, I have checked pl011_read and pl011_write, and
found them, thanks for that.
But I couldn't find the register "UARTICR" (*Interrupt clear register*)
I think this might be related to my lack of understanding of how interrupts
are implemented in emulated pl011.

Regarding the ID registers, whose values are hard-wired in the board, and
there was no need to implement modifiable states for them.
Do you mean *Peripheral identification registers, UARTPeriphID0-3* and
*PrimeCell
identification registers, UARTPCellID0-3* ?

Thanks in advance for your help.


On Mon, Sep 4, 2017 at 10:50 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 4 September 2017 at 01:27, Ramy Sameh <ramysameh26@gmail.com> wrote:
> > *My 2 questions are:*
> >
> > *First:*
> > Are interrupts activated in the emulated pl011 ?
> > I mean, if I enabled the interrupt bits for UARTTXINTR, will this trigger
> > an interrupt when the FIFO reaches a certain level?
>
> Yes, we implement interrupts.
>
> > *Second:*
> > Another problem is that I can't find some of the UART registers (which
> are
> > in the data sheet PrimeCell UART (PL011)), in QEMU's emulated UART pl011.
> >
> > *These are the registers which I can't find their matches in the
> structure
> > PL011State:*
> >
> > 1.) Interrupt FIFO level select register, UARTIFLS
> > 2.) Raw interrupt status register, UARTRIS
> > 3.) Masked interrupt status register, UARTMIS
> > 4.) Interrupt clear register, UARTICR
> > 5.) Peripheral identification registers, UARTPeriphID0-3
> > 6.) PrimeCell identification registers, UARTPCellID0-3
>
> All these registers are implemented. You can find the code that
> implements them in the pl011_read() and pl011_write() functions.
>
> > *This is the structure where I get pl011 emulated registers:*
> > typedef struct PL011State
>
> This structure defines (among other things) fields which
> hold the underlying state of the device (in hardware terms,
> usually information which is in a flipflop or otherwise
> stored). This is not the same as a guest-visible register,
> although there is very often overlap. For instance, the
> ID registers are constant and read-only, so they do not
> have any modifiable state that we need to put in the struct
> (in hardware, they'll be implemented by just tying off
> lines to 0 or 1, not with flops). Sometimes a register
> value as seen by the guest is just a logical combination
> of state used by other registers, eg UARTMIS is just the
> logical OR of UARTRIS and UARTIMSC, so it doesn't need
> any extra state in the struct.
>
> Some of the state fields have names that don't correspond
> to the register names for historical reasons (eg UARTIFLS
> is in s->ifl); you should always start with the read and
> write functions to look at how the register behaviour
> is implemented, which will show you which state fields
> if any are involved.
>
> thanks
> -- PMM
>



-- 
Best Regards,
Ramy Sameh
Embedded Software Engineer
+2-010-172-777-14
