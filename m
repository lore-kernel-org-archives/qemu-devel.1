Received: from eggs.gnu.org ([209.51.188.92]:40122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shahab.vahedi@gmail.com>) id 1hI7RZ-0001kd-4K
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 04:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shahab.vahedi@gmail.com>) id 1hI7RX-0004Hj-Tr
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 04:03:21 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:44090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shahab.vahedi@gmail.com>)
	id 1hI7RX-0004Gz-K0
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 04:03:19 -0400
Received: by mail-ed1-x541.google.com with SMTP id i13so7373519edf.11
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 01:03:19 -0700 (PDT)
Date: Sun, 21 Apr 2019 10:03:14 +0200
From: Shahab Vahedi <shahab.vahedi@gmail.com>
Message-ID: <20190421080314.GA1817@gmail.com>
References: <20190419114502.20388-1-shahab.vahedi@gmail.com>
	<CAFEAcA_2aNt10Ti8HCTbCvHrgFYt7Uw2z=pNWBWyWMsbR6kjoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_2aNt10Ti8HCTbCvHrgFYt7Uw2z=pNWBWyWMsbR6kjoQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] cputlb: Fix io_readx() to respect the
 access_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "open list:Overall" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

Hi Peter,

On Sat, Apr 20, 2019 at 07:57:31PM +0100, Peter Maydell wrote:
> On Fri, 19 Apr 2019 at 12:46, Shahab Vahedi <shahab.vahedi@gmail.com> wrote:
> >
> > This change adapts io_readx() to its input access_type. Currently
> > io_readx() treats any memory access as a read, although it has an
> > input argument "MMUAccessType access_type". This results in:
> >
> > 1) Calling the tlb_fill() only with MMU_DATA_LOAD
> > 2) Considering only entry->addr_read as the tlb_addr
> >
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1825359
> >
> > Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
> > ---
> > Changelog:
> > - Extra space before closing parenthesis is removed
> >
> >  accel/tcg/cputlb.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Hi; this patch mostly looks good; thanks for submitting it.
> 
Please let me remind you that there is a newer [PATCH v3].

> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index 88cc8389e9..4a305ac942 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -878,10 +878,13 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
> >          CPUTLBEntry *entry;
> >          target_ulong tlb_addr;
> >
> > -        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
> > +        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
> >
> >          entry = tlb_entry(env, mmu_idx, addr);
> > -        tlb_addr = entry->addr_read;
> > +        tlb_addr =
> > +            (access_type == MMU_DATA_LOAD)  ? entry->addr_read  :
> > +            (access_type == MMU_DATA_STORE) ? entry->addr_write :
> > +            entry->addr_code;
> 
> Here you don't need to handle MMU_DATA_STORE, because
> we're in io_readx -- stores will go to io_writex, not here.
> 
This concern was already raised by Alex (Bennée) and in [PATCH v3] I
addressed it the way he suggested: an _assert_ in the beginning to
verify that "access_type" is only for fetching and reading.
I must say, Philippe (Mathieu-Daudé) has his doubts about using an
_assert_ like this.

>
> Style-wise it's probably better just to use an
>   if (...) {
>       tlb_addr = ...;
>   } else {
>       tlb_addr = ...;
>   }
> 
> rather than a multi-line ?: expression.
> 
Sure Peter, I will do that, but please let me remind you that in
[PATCH v3] the conditional part is a two-liner (i.s.o the three-
liner here).

> >          if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
> >              /* RAM access */
> >              uintptr_t haddr = addr + entry->addend;
> > --
> > 2.21.0
> >
> 
> thanks
> -- PMM

I have a question though: Richard (Henderson) has already _reviewed_
[PATCH v3]. Is it OK if I change the code further and submit yet a
newer version?

Cheers,
Shahab
