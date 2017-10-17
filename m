Received: from eggs.gnu.org ([2001:4830:134:3::10]:43709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4TJL-00022d-LB
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4TJG-0008M2-3n
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:57:39 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:46654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e4TJF-0008LO-PL
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:57:34 -0400
Received: by mail-wr0-x230.google.com with SMTP id l1so2009834wrc.3
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 07:57:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506737310-21880-7-git-send-email-alindsay@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
	<1506737310-21880-7-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2017 15:57:11 +0100
Message-ID: <CAFEAcA8H-Zv0HRiMTSYFqkR0Wx7npB_N_ze9h0oovVa1tMHDRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/13] target/arm: Filter cycle counter
 based on PMCCFILTR_EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 30 September 2017 at 03:08, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> The pmu_counter_filtered and pmu_sync functions are generic (as opposed
> to PMCCNTR-specific) to allow for the implementation of other events.
>
> RFC: I know that many of the locations of the calls to pmu_sync are
> problematic when icount is enabled because can_do_io will not be set.
> The documentation says that for deterministic execution, IO must only be
> performed by the last instruction of a thread block.

Yes. You need to arrange that gen_io_start() and gen_io_end()
are called around the generation of code for operations that might
do IO or care about the state of the clock, and that we end the TB
after gen_io_end().

> Because
> cpu_handle_interrupt() and cpu_handle_exception() are actually made
> outside of a thread block, is it safe to set can_do_io=1 for them to
> allow this to succeed? Is there a better mechanism for handling this?

>From my reading of the code, can_do_io should already be 1
when these functions are called. It's only set to 0 just
before we call tcg_qemu_tb_exec() and then set back to 1
immediately after (see cpu_tb_exec()).

In general, the approach you have here looks like it's going to
be pretty invasive and also hard to keep working right. I think
we can come up with something a bit better.

Specifically, the filtering criteria effectively only change
when we change exception level, right? (since you can only
change security state as part of an exception level change).
We already have a mechanism for getting a callback when the EL
changes -- arm_register_el_change_hook(). (We would need to
upgrade it to support more than one hook function.)

You still need to get the io-count handling right, but there
are many fewer places that need to change (just the codegen
for calls to exception-return helpers, I think) and they already
end the TB, so you don't have the complexity of trying to end the
TB in places you didn't before, you just need the gen_io_start/end.

thanks
-- PMM
