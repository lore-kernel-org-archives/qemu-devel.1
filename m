Received: from eggs.gnu.org ([2001:4830:134:3::10]:51026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ramysameh26@gmail.com>) id 1dpIvs-0003JR-Lp
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ramysameh26@gmail.com>) id 1dpIvn-0008Fl-A2
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:50:44 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:35740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ramysameh26@gmail.com>)
	id 1dpIvn-0008F7-0e
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:50:39 -0400
Received: by mail-oi0-x236.google.com with SMTP id n18so29947733oig.2
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 11:50:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9kEEyUj7=7Wd-jNbVOWwfgkj0a201q+L4e5CDR22JUgw@mail.gmail.com>
References: <CAF6HrYxj5BoTQpQjz95Z1_N_p615jpEE12xh_afuuqE4fcTyLg@mail.gmail.com>
	<CAFEAcA9YNO7kgC8yzZ_RUKck=+98pUET0ogVZ7TvC1kxV+_fFA@mail.gmail.com>
	<CAF6HrYwT7WP_i7cVhvEyRvqSK7J+bLnKU4b+WrMQfVkLaNDrvQ@mail.gmail.com>
	<CAFEAcA9kEEyUj7=7Wd-jNbVOWwfgkj0a201q+L4e5CDR22JUgw@mail.gmail.com>
From: Ramy Sameh <ramysameh26@gmail.com>
Date: Tue, 5 Sep 2017 20:50:37 +0200
Message-ID: <CAF6HrYw9B1ns0ZVtU_gxqJZxOe0dG03UQiAV7FHxBB-wQh6kNQ@mail.gmail.com>
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

Thank you very much Peter.

I will check the documentation for VersatilePB and ARM926EJ-S for more
understanding of interrupts handling.



On Tue, Sep 5, 2017 at 8:06 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 5 September 2017 at 18:56, Ramy Sameh <ramysameh26@gmail.com> wrote:
> > Are there any documentation or source of information, that can describe
> how
> > interrupts are implemented, and how to use them (where is the vector
> table
> > to put the ISR ... etc) ?
>
> The source code is it.
>
> Note that the pl011 is only a UART. It is used in a variety
> of different boards, which have different interrupt controllers,
> and with different CPUs. Things like ISR vector tables are
> generally part of the CPU or interrupt controller emulation.
>
> The pl011's part of this is simply to raise and lower its outbound IRQ line
> when the conditions are right -- this happens by calling qemu_set_irq()
> in pl011_update(). This corresponds to the hardware's UARTINTR line.
> In QEMU that IRQ line is connected up to an emulated interrupt controller
> which in turn is connected to an emulated CPU, just as in hardware
> the pl011 UARTINTR line is connected to a hardware interrupt controller
> and thus to a CPU.
>
> For information on how guest code should use a UART, how it should
> set up interrupts and so on, you should consult the documentation
> on how the hardware behaves.
>
> > In addition, any source of info that describes the code workflow when
> > reading or writing to the uart would be very helpful.
> > (because I put printfs in the functions to understand the workflow, but
> the
> > order of these printfs made me very confused).
> >
> > Regarding the registers, I have checked pl011_read and pl011_write, and
> > found them, thanks for that.
> > But I couldn't find the register "UARTICR" (Interrupt clear register)
> > I think this might be related to my lack of understanding of how
> interrupts
> > are implemented in emulated pl011.
>
> UARTICR is a write-only register, so it is handled only in
> pl011_write():
>
>     case 17: /* UARTICR */
>         s->int_level &= ~value;
>         pl011_update(s);
>         break;
>
> (It's write-1-to-clear, hence the &= ~.)
>
> > Regarding the ID registers, whose values are hard-wired in the board, and
> > there was no need to implement modifiable states for them.
> > Do you mean Peripheral identification registers, UARTPeriphID0-3 and
> > PrimeCell identification registers, UARTPCellID0-3 ?
>
> Yes. (See the pl011_id_arm[] array which has the values.)
>
> thanks
> -- PMM
>



-- 
Best Regards,
Ramy Sameh
Embedded Software Engineer
+2-010-172-777-14
