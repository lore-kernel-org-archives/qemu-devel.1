Received: from eggs.gnu.org ([2001:4830:134:3::10]:43255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1e4XbV-0004po-Nv
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 15:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1e4XbU-0004B6-Hu
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 15:32:41 -0400
Date: Tue, 17 Oct 2017 15:32:31 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20171017193230.GB22177@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
	<1506737310-21880-7-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA8H-Zv0HRiMTSYFqkR0Wx7npB_N_ze9h0oovVa1tMHDRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8H-Zv0HRiMTSYFqkR0Wx7npB_N_ze9h0oovVa1tMHDRQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Oct 17 15:57, Peter Maydell wrote:
> On 30 September 2017 at 03:08, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> > The pmu_counter_filtered and pmu_sync functions are generic (as opposed
> > to PMCCNTR-specific) to allow for the implementation of other events.
> >
> > RFC: I know that many of the locations of the calls to pmu_sync are
> > problematic when icount is enabled because can_do_io will not be set.
> > The documentation says that for deterministic execution, IO must only be
> > performed by the last instruction of a thread block.
> 
> Yes. You need to arrange that gen_io_start() and gen_io_end()
> are called around the generation of code for operations that might
> do IO or care about the state of the clock, and that we end the TB
> after gen_io_end().
> 
> > Because
> > cpu_handle_interrupt() and cpu_handle_exception() are actually made
> > outside of a thread block, is it safe to set can_do_io=1 for them to
> > allow this to succeed? Is there a better mechanism for handling this?
> 
> From my reading of the code, can_do_io should already be 1
> when these functions are called. It's only set to 0 just
> before we call tcg_qemu_tb_exec() and then set back to 1
> immediately after (see cpu_tb_exec()).
> 
> In general, the approach you have here looks like it's going to
> be pretty invasive and also hard to keep working right. I think
> we can come up with something a bit better.

Yes, I am hoping so.

> Specifically, the filtering criteria effectively only change
> when we change exception level, right? (since you can only
> change security state as part of an exception level change).
> We already have a mechanism for getting a callback when the EL
> changes -- arm_register_el_change_hook(). (We would need to
> upgrade it to support more than one hook function.)
> 
> You still need to get the io-count handling right, but there
> are many fewer places that need to change (just the codegen
> for calls to exception-return helpers, I think) and they already
> end the TB, so you don't have the complexity of trying to end the
> TB in places you didn't before, you just need the gen_io_start/end.

Using hooks/callbacks is clearly a better solution. I shied away from
using *el_change_hook in this patchset because A) it seemed to be marked
explicitly for GICv3 emulation, B) the one-hook limitation you
mentioned, and C) it doesn't currently provide you with which EL you're
coming from.

If everyone is amenable to changing how the hook is structured, I don't
think any of those reasons stand. My initial thought is that the best
way to fix C) is to add a pre_el_change_hook to be called at the top of
the exception_return and cpsr_write_eret helpers in
target/arm/op_helper.c to drive the first call to pmu_sync() (or
whatever I rename the first half of that pair to based on your
suggestions on that patch).

If I don't receive any additional feedback before then, I'll do my best
to adapt the existing hooks to allow for a cleaner approach to filtering
for v3.

-Aaron

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
