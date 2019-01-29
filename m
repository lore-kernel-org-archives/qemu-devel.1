Received: from eggs.gnu.org ([209.51.188.92]:46582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goQ9H-0007jk-T6
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:57:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goQ9G-0005y1-Vm
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:57:43 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goQ9G-0005vg-Lx
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:57:42 -0500
Received: by mail-oi1-x243.google.com with SMTP id i6so15632892oia.6
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 01:57:41 -0800 (PST)
MIME-Version: 1.0
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-7-richard.henderson@linaro.org>
	<CAFEAcA_cvfL2Sja4WawDAR++Ak85yKo7J=Xy4hzO_ChiFt7mZw@mail.gmail.com>
	<b4e20937-dbf0-1e26-8426-dcea14874833@linaro.org>
In-Reply-To: <b4e20937-dbf0-1e26-8426-dcea14874833@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 09:57:29 +0000
Message-ID: <CAFEAcA9WGH8O1CQfe_HAQT3w3P7p_aRW=hE0b1TN-UNF011cWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/11] target/arm: Reset btype for direct
 branches and syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 28 Jan 2019 at 21:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/22/19 6:12 AM, Peter Maydell wrote:
> > On Thu, 10 Jan 2019 at 12:17, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> This is all of the non-exception cases of DISAS_NORETURN.
> >
> > What about the gen_helper_exit_atomic() exit cases ?
>
> In that case we are going to re-execute the same insn with a different
> translation, so we do not want to change btype.
>
> (Although I'm not sure how the guest could tell.  Given where we check for
> btype mismatch, we would recognize the BTI exception before getting into the
> ldst_ex path that generates the ATOMIC exception.  So any DataAbort exception
> that the atomic insn itself might generate must also have BTYPE == 0.)

Yeah, I was mostly asking because they're the other
DISAS_NORETURN cases and they're neither changed in the
patch nor mentioned as special cases in the commit message.

> > The advantage of picking the other choice (SPSR_ELx.BTYPE ==
> > PSTATE.BTYPE) is that it means that the behaviour is identical
> > for all exceptions (async or sync of any type) and we don't
> > do the work of clearing the BTYPE field (which will happen
> > potentially in "normal" guest code if we're not in a guarded page,
> > I think).
>
> Well, BTYPE is in the TB flags, so we know it's already zero in that case, so
> there's no extra work.

It's not zero if we just did a BR Xn to get to this SVC insn, is it?

thanks
-- PMM
