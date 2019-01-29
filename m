Received: from eggs.gnu.org ([209.51.188.92]:41466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goU2Y-0006M9-En
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goU2W-0001Ju-P0
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:07:02 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goU2W-0001Jc-Jt
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:07:00 -0500
Received: by mail-oi1-x242.google.com with SMTP id m6so16165197oig.11
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 06:07:00 -0800 (PST)
MIME-Version: 1.0
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-7-richard.henderson@linaro.org>
	<CAFEAcA_cvfL2Sja4WawDAR++Ak85yKo7J=Xy4hzO_ChiFt7mZw@mail.gmail.com>
	<b4e20937-dbf0-1e26-8426-dcea14874833@linaro.org>
	<CAFEAcA9WGH8O1CQfe_HAQT3w3P7p_aRW=hE0b1TN-UNF011cWw@mail.gmail.com>
	<9717bb4f-e253-fe4e-ca72-7e59f162e844@linaro.org>
In-Reply-To: <9717bb4f-e253-fe4e-ca72-7e59f162e844@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 14:06:48 +0000
Message-ID: <CAFEAcA9CxUXK8LThj4ixzqJE2amwTVS5JmSVefd0qw_PQDsK7g@mail.gmail.com>
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

On Tue, 29 Jan 2019 at 14:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/29/19 1:57 AM, Peter Maydell wrote:
> >>> The advantage of picking the other choice (SPSR_ELx.BTYPE ==
> >>> PSTATE.BTYPE) is that it means that the behaviour is identical
> >>> for all exceptions (async or sync of any type) and we don't
> >>> do the work of clearing the BTYPE field (which will happen
> >>> potentially in "normal" guest code if we're not in a guarded page,
> >>> I think).
> >>
> >> Well, BTYPE is in the TB flags, so we know it's already zero in that case, so
> >> there's no extra work.
> >
> > It's not zero if we just did a BR Xn to get to this SVC insn, is it?
>
> I guess I misunderstood what you meant by "extra" work.
> It's not "extra" if btype is known to not be zero...

The architecture doesn't require it to be cleared in that
situation, unless I've misunderstood it. So unless the kernel
is explicitly clearing the BTYPE in the SPSR (which I don't
think it is obliged to do either) then clearing it is
work we don't need to do.

thanks
-- PMM
