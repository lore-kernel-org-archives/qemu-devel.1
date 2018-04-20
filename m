Received: from eggs.gnu.org ([2001:4830:134:3::10]:36503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9ThZ-0000TX-2j
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9ThY-00031E-9q
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:55:37 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:35647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9ThY-00030w-51
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:55:36 -0400
Received: by mail-oi0-x229.google.com with SMTP id c15-v6so7651322oic.2
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 03:55:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
References: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 11:55:14 +0100
Message-ID: <CAFEAcA847b02nswyaUipGNnJUYRyMt5GyA3mgX_NbaUtqQWyBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 00/21] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 17 April 2018 at 21:37, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> The ARM PMU implementation currently contains a basic cycle counter, but it is
> often useful to gather counts of other events and filter them based on
> execution mode. These patches flesh out the implementations of various PMU
> registers including PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to
> represent arbitrary counter types, implement mode filtering, send interrupts on
> counter overflow, and add instruction, cycle, and software increment events.
>
> Notable changes since v3:
>
> * Detect counter overflow and send interrupts accordingly (adds a 'shadow' copy
>   of both PMCCNTR and general-purpose counters, possibly/probably Doing It
>   Wrong)
> * Update counter filtering code to more closely resemble the ARM documentation
>   in form and functionality
> * Don't mix EL change hooks and KVM
> * Don't call gen_io_start/end if not actually using icount
> * Reorganized a few of the patches to more logically group changes
> * Clarify and otherwise improve a few comments
> * There are also a number of less significant changes scattered around

In the interests of cutting down the size of this patchset for
future rounds, I'm going to apply these patches to target-arm.next:

> 1  target/arm: Check PMCNTEN for whether PMCCNTR is enabled
> 2  target/arm: Treat PMCCNTR as alias of PMCCNTR_EL0
> 4  target/arm: Mask PMU register writes based on PMCR_EL0.N
> 5  target/arm: Fetch GICv3 state directly from CPUARMState
> 6  target/arm: Support multiple EL change hooks
> 7  target/arm: Add pre-EL change hooks
> 8  target/arm: Allow EL change hooks to do IO
> 9  target/arm: Fix bitmask for PMCCFILTR writes
> 12 target/arm: Make PMOVSCLR and PMUSERENR 64 bits wide

thanks
-- PMM
