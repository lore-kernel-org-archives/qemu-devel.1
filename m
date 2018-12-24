Received: from eggs.gnu.org ([208.118.235.92]:38302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gbQbs-0008RJ-7B
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 08:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gbQbm-0002Q9-PO
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 08:49:30 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:39169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gbQbg-0002MP-7Y
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 08:49:22 -0500
Received: by mail-oi1-x22f.google.com with SMTP id i6so9960022oia.6
	for <qemu-devel@nongnu.org>; Mon, 24 Dec 2018 05:49:19 -0800 (PST)
MIME-Version: 1.0
References: <1bd5a622.e60b.167dfb192d3.Coremail.13824125580@163.com>
In-Reply-To: <1bd5a622.e60b.167dfb192d3.Coremail.13824125580@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Dec 2018 13:49:07 +0000
Message-ID: <CAFEAcA8TOPHViUG0B0KAnDCpuoygkn51KVXNniQvjdcEf2R9ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] what is the behavier precisely if a tb was
 interrupted by a interrupt or signal?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: tugouxp <13824125580@163.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 24 Dec 2018 at 10:11, tugouxp <13824125580@163.com> wrote:
>  think about the scenario like that, a tb block contain  9 native instructions  execute sequentially
>
>  if a interrupt or a signal happens  before instruction 6 executed,  did the tb  be finished before response to the interrupt  or
>
> the  exited at once to response the interrupt?

We don't check in the middle of a TB for conditions like
interrupts. The only thing that can cause a TB to stop
execution halfway through is if it does something that
provokes a synchronous exception (for instance, if it
does a guest memory access that triggers a guest CPU
page fault, or if it emulates a guest instruction that
is required to trap). Those we emulate by longjumping out
from the generated code to the top level loop.
Asynchronous events like emulated interrupts we only
check at the beginning of the TB: we emit code which
tests a flag and returns early.

thanks
-- PMM
