Received: from eggs.gnu.org ([2001:4830:134:3::10]:46996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4TUo-00080k-W8
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4TUi-00063z-W8
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:09:30 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:43685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e4TUi-00063E-QK
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:09:24 -0400
Received: by mail-wr0-x231.google.com with SMTP id p46so2047837wrb.0
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 08:09:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2017 16:09:02 +0100
Message-ID: <CAFEAcA_f=7XjUs7BNQksidnBKofc8SxYtfjMtmfYMuPeo8NXug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 00/13] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 30 September 2017 at 03:08, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> The ARM PMU implementation currently contains a basic cycle counter, but it is
> often useful to gather counts of other events and filter them based on
> execution mode. These patches flesh out the implementations of various PMU
> registers including PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to
> represent arbitrary counter types, implement mode filtering, and add
> instruction, cycle, and software increment events.
>
> I am particularly interested in feedback on the following two patches because I
> think I'm likely Doing It Wrong:
>  [1] target/arm: Filter cycle counter based on PMCCFILTR_EL0
>  [2] target/arm: PMU: Add instruction and cycle events
>
> In order to implement mode filtering in an event-driven way, [1] adds a pair of
> calls to pmu_sync() surrounding every update to a register/variable which may
> affect whether any counter is currently filtered. These pmu_sync() calls
> ultimately call cpu_get_icount_raw() for enabled instruction and cycle counters
> when using icount. Unfortunately, cpu->can_do_io may otherwise be zero for
> these calls so the current implementation in [2] temporarily sets can_do_io to
> 1. I haven't see any ill side effects from this in my testing, but it doesn't
> seem like the right way to handle this.

I've now reviewed the early stuff and provided what I hope is
a useful direction for the mode-filtering, so I'm not going to
look at the patches at the tail end on this version of the series.


> I would like to eventually add sending interrupts on counter overflow.
> Suggestions for the best direction to handle this are most welcome.

Check out how the helper.c timer interrupts are wired up
(the CPU object exposes outbound irq lines, which then get
wired up by the board to the GIC.)

thanks
-- PMM
