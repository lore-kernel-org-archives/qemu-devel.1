Received: from eggs.gnu.org ([2001:4830:134:3::10]:56184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWMit-0000OG-NI
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWMis-0001IQ-UQ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:39:51 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWMis-00015J-NH
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:39:50 -0500
Received: by mail-oi1-x241.google.com with SMTP id c206so9141525oib.0
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 06:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20181207155911.12710-1-peter.maydell@linaro.org>
	<c2f3400e-84d9-d380-3259-7e3231ff12f6@adacore.com>
In-Reply-To: <c2f3400e-84d9-d380-3259-7e3231ff12f6@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 14:39:24 +0000
Message-ID: <CAFEAcA_vuA=P2JDmaWZ3XQrcrjnKpewhgxbMA8YWXxo=vU981A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] cpus.c: Fix race condition in
 cpu_stop_current()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Jaap Crezee <jaap@jcz.nl>, "patches@linaro.org" <patches@linaro.org>

On Mon, 10 Dec 2018 at 14:30, KONRAD Frederic
<frederic.konrad@adacore.com> wrote:
>
> Hi Peter,
>
> Thanks for that patch!
>
> I'm seeing the same kind of issue when I run 8 qemu in parallel but it doesn't
> seem to be fixed by this patch. Is it supposed to fix the issue when we are
> doing a reset_request through a MMIO device?
>
> It happens (rarely) with this kind of guest code:
>
> exit:
>    write to the register to reset the device
> loop:
>    branch loop
>
> The code after the reset is executed.. can't we exit the loop directly with
> cpu_loop_exit after cpu_exit?

cpu_loop_exit would abort the execution of the store instruction
that writes to the reset register. I'm not sure that's a great
idea. My thought was more that we should just make sure that insn
is the last one in the TB, so effectively we execute that insn and
then reset the system before executing any further insns. Thinking
it over though I'm not sure that we do do anything that could
avoid having more insns following in the same TB, unless you're
using singlestep or icount...

thanks
-- PMM
