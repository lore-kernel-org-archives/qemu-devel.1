Received: from eggs.gnu.org ([2001:4830:134:3::10]:53200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1g8Bib-0004YC-Ar
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 18:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1g8Bia-0006Zl-JL
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 18:03:37 -0400
Received: from mail-yw1-xc2f.google.com ([2607:f8b0:4864:20::c2f]:33689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1g8Bia-0006T1-A4
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 18:03:36 -0400
Received: by mail-yw1-xc2f.google.com with SMTP id m127-v6so4459265ywb.0
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 15:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181004010505.26184-1-jcmvbkbc@gmail.com>
	<CAMo8BfJ==eV4g7L3nSuYa=o2RNw98nUg_0VJeBD6V8Q54m0wkg@mail.gmail.com>
	<39db072a-4ed9-834e-a77f-bb06df42a9f1@linaro.org>
In-Reply-To: <39db072a-4ed9-834e-a77f-bb06df42a9f1@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 4 Oct 2018 15:03:04 -0700
Message-ID: <CAMo8BfKJCYqFT31aL6ESD-N2zHKR2jv30RYxDPGYSbSpKQacvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] target/xtensa: rework zero overhead loops
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

Hi Richard,

thank you for taking a look.

On Thu, Oct 4, 2018 at 2:13 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
> Think first about how, if PC >= LEND or LEND - PC > PAGE_SIZE, that all of the
> loop stuff is irrelevant because we won't hit LEND within this TB.
>
> Think second about how to represent the common case -- how LOOP sets LBEG and
> LEND together.  That is, LEND - LBEG <= 256.  So, usually, we can also have an
> exact representation of LBEG and have a direct link rather than an indirect
> link.

I tried similar thing as a followup to my original patch, recording entire LBEG
in the cs_base -- surprisingly to me it made no measurable difference on my
tests.

>  But I presume that one can play games with special registers to create
> ranges that LOOP won't.  So we need some setting that will indicate that.
>
> Consider CS_BASE fields:
>
>   [12: 0]  EDIF = LEND - PC, if PC < LEND && LEND - PC < 2*PAGE_SIZE, or 0.

That has the same issue as my original patch: two TBs with PC > LEND
in both may be linked together, and then LEND may change, so that
PC1 > LEND and PC2 < LEND.
But I guess always storing low 13 bits of LEND - PC should work?
I'll play with it...

-- 
Thanks.
-- Max
