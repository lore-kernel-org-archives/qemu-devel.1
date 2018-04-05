Received: from eggs.gnu.org ([2001:4830:134:3::10]:39635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f47Km-0006sx-4Y
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f47Kj-0007PT-QX
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:01:56 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:45667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f47Kj-0007OX-Kf
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:01:53 -0400
Received: by mail-ot0-x229.google.com with SMTP id h26-v6so27716538otj.12
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 09:01:53 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Apr 2018 17:01:32 +0100
Message-ID: <CAFEAcA9PbAr+0U1dJ22fr3+B0-KO3Oy73-mk755rJQtmY_rSKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] TCG icount interaction with timer deadlines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>

Does anybody understand how icount TCG is supposed to arrange to
respect timer deadlines?

https://bugs.launchpad.net/qemu/+bug/1754038 has a test case which
shows that we don't get this right.

At the moment what happens is:
 * when we're about to call tcg_cpu_exec(), we call
   prepare_icount_for_run(), which looks at the closest clock deadline
   to figure out how many insns to execute before dropping out, with
   a cap at INT32_MAX nanoseconds
 * however, if the guest reprograms the clock during the tcg_cpu_exec()
   run, we don't do anything to cause us to stop earlier
 * so we blithely continue on til that INT32_MAX cap, and then
   belatedly notice that we should have fired a timer interrupt

In the test case this manifests as the first timer interrupt being
very delayed, because the first tcg_cpu_exec() goes from "start of
program" to INT32_MAX nanoseconds. Later interrupts happen OK, because
the guest isn't reprogramming the timer interrupt, so the deadline
picked at the start of each tcg_cpu_exec run is correct.

What should we be doing to arrange to stop execution of the
tcg_cpu_exec() earlier when the deadline moves closer?

thanks
-- PMM
