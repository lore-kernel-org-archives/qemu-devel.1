Received: from eggs.gnu.org ([2001:4830:134:3::10]:37095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f48o6-00017e-DO
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f48o5-0000W9-Ha
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:36:18 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:40447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f48o5-0000Vj-C4
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:36:17 -0400
Received: by mail-ot0-x235.google.com with SMTP id j8-v6so20622682ota.7
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 10:36:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cfb5230b-ec8e-ccb7-788d-0b389a93e128@redhat.com>
References: <CAFEAcA9PbAr+0U1dJ22fr3+B0-KO3Oy73-mk755rJQtmY_rSKA@mail.gmail.com>
	<cfb5230b-ec8e-ccb7-788d-0b389a93e128@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Apr 2018 18:35:56 +0100
Message-ID: <CAFEAcA-vUuGWqPfDEz9Qu+q3PGqctSw-YxRnH3jWJGH+QVLHsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] TCG icount interaction with timer deadlines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>

On 5 April 2018 at 18:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 05/04/2018 18:01, Peter Maydell wrote:
>>  * however, if the guest reprograms the clock during the tcg_cpu_exec()
>>    run, we don't do anything to cause us to stop earlier
>
> Anything that does this from the vCPU thread should be between
> gen_icount_start and gen_icount_end.  (In fact, it's the entire reason
> why cpu_io_recompile exists).

Yes, and this does cause us to do a cpu_io_recompile, which
rebuilds the TB and does a longjmp. However:
 (1) that only takes us out to cpu_exec(), which will then
 just go ahead and execute the next TB, whereas the
 recalculation of deadlines happens at the next level out
 in tcg_cpu_exec()
 (2) the io_recompile happens *before* the guest writes to
 the timer register that reprograms the deadline, so even
 if we recomputed deadlines after this longjmp they wouldn't
 be correct

thanks
-- PMM
