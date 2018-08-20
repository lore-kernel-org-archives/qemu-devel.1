Received: from eggs.gnu.org ([2001:4830:134:3::10]:44421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mkschreder.uk@googlemail.com>) id 1frox7-0000KL-95
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mkschreder.uk@googlemail.com>) id 1frovW-0000mA-Iw
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:29:19 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:39716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mkschreder.uk@googlemail.com>)
	id 1frovU-0000ex-H7
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:29:17 -0400
Received: by mail-vk0-x244.google.com with SMTP id e139-v6so6976687vkf.6
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 11:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGmj6qti3t3dBp6OT1H_UrkUi5OvXrb1nhEyozonz6uZm2P95A@mail.gmail.com>
	<CAFEAcA8wZ7ga0kJ3WQ-A=fYNeJrxxCV+b2n7_Ni4Hg7jBS+L0w@mail.gmail.com>
	<CAGmj6qtJuootGneBjcz8aCRsBXBU+GN2nhERc+76un_CiBcDZQ@mail.gmail.com>
	<CAFEAcA8wp=_MzzrT0G70n1eHbbt8FXf2upZB0cyBmhK3Pv+Y9w@mail.gmail.com>
In-Reply-To: <CAFEAcA8wp=_MzzrT0G70n1eHbbt8FXf2upZB0cyBmhK3Pv+Y9w@mail.gmail.com>
From: Martin Schroeder <mkschreder.uk@googlemail.com>
Date: Mon, 20 Aug 2018 20:29:02 +0200
Message-ID: <CAGmj6qsWJq3cXheRpftnK2c9yCFCGDwN=Y9Y=m=QLBq+dTokAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Simulating a composite machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org

Sent it off as reply instead of reply all.. my bad.

I was also surprised that it was mid into an instruction. The code
works fine on STM32 but if FPU is not enabled on the STM32 then I
believe the code will fault in much the same way. I have had this
problem before and it was also hard faulting inside libc snprintf. It
has definitely something to do with FPU and snprintf faults when fpu
is not enabled on F4. When FPU is enabled everything works. Why I
don't know.

It seems the HardFault is preceded by two UsageFaults:
Taking exception 17 [v7M NOCP UsageFault]
...taking pending nonsecure exception 3
Taking exception 17 [v7M NOCP UsageFault]
qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

Ok so FPU support is not there. What would it take for me to add it? I
would very much like to add it if I get some guidance as to what needs
to be done and where I can find information on how to do it. I see
there is some code in fpu/softfloat.c but I guess it is not enough?
On Mon, Aug 20, 2018 at 8:12 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On 20 August 2018 at 19:03, Martin Schroeder
> <mkschreder.uk@googlemail.com> wrote:
> > Peter, perhaps a slightly off-topic question,
>
> Could you keep traffic on the mailing lists, please? That
> way everybody can read the answer and reply if they have a view.
>
> (I append the rest because I'd typed it all out before I noticed
> that this was a private email.)
>
> > but how do I enable FPU
> > support for armv7m M4 emulation? Is it supported? FPU instructions
> > currently make the armv7m core go into hard fault on master.
>
> It's not supported, because FPU support requires changes to
> the M profile exception handling (stacking FPU regs on exception
> entry, handling the lazy-stacking feature, etc). This is on my
> todo list, so there is a reasonable chance it'll get done either
> for QEMU 3.1 or more likely for 3.2, if nobody else gets to it first.
>
> > If I disable FPU in firmware build and use -mfloat-abi=soft then I get
> > a hard fault even sooner with following warning: "warning: TCG
> > temporary leaks before 0805875a"
>
> The warning is harmless -- I think the only remaining
> encodings that can cause it to be produced are all ones
> where the instruction in question generates an exception
> (it's caused because we generate a bit of code before
> realising the insn is going to fault, and then the TCG
> temp is not cleaned up by the per-insn translation code.
> The temp is cleaned up at the end of the TB, so it's not
> a permanent leak -- the warning is there because per-insn
> leaks let the guest run us out of temps by having a TB with
> a lot of the same insn in it.)
>
> > (gdb) disas 0x0805875a
> > Dump of assembler code for function snprintf:
> >    0x08058750 <+0>:     push    {r2, r3}
> >    0x08058754 <+4>:     push    {r4, r5, r6, lr}
> >    0x08058758 <+8>:     ldr     r3, [pc, #136]  ; 0x80587e8 <snprintf+152>
> >    0x0805875c <+12>:    subs    r4, r1, #0
> >    0x08058760 <+16>:    ldr     r5, [r3]
> >    0x08058764 <+20>:    movlt   r3, #139        ; 0x8b
> >    0x08058768 <+24>:    sub     sp, sp, #112    ; 0x70
> >    0x0805876c <+28>:    strlt   r3, [r5]
> >    0x08058770 <+32>:    mvnlt   r0, #0
> >    0x08058774 <+36>:    blt     0x80587d8 <snprintf+136>
> >    0x08058778 <+40>:    add     r12, sp, #132   ; 0x84
> >    0x0805877c <+44>:    mov     r3, #520        ; 0x208
> >    0x08058780 <+48>:    subne   lr, r4, #1
> >    0x08058784 <+52>:    moveq   lr, r4
> >    0x08058788 <+56>:    ldr     r2, [sp, #128]  ; 0x80
>
> Not clear from that why you're getting a hard fault, but it
> seems a bit suspicious that the quoted PC is midway through an
> insn -- suggests that maybe the code being executed is not
> what your disassembly says it is?
>
> You might find that the -d debug logs are helpful in indicating
> what's happened.
>
> thanks
> -- PMM
