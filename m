Received: from eggs.gnu.org ([2001:4830:134:3::10]:46052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1e1ecT-0007pk-Ju
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 16:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1e1ecS-0007LE-JS
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 16:25:45 -0400
Date: Mon, 9 Oct 2017 16:25:32 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20171009202532.GB3676@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
	<20171009144641.GA3676@codeaurora.org>
	<CAFEAcA9xYJVy2mSo=CmmHDTfELLaEpzbDx=SubsmJQQY9fwxeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9xYJVy2mSo=CmmHDTfELLaEpzbDx=SubsmJQQY9fwxeg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/13] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Oct 09 19:27, Peter Maydell wrote:
> On 9 October 2017 at 15:46, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> > Unfortunately I'm not sure who to add other than the current recipients,
> > but I'm eager for feedback and would love to work this into something
> > that will allow for using the full ARM PMU.
> 
> Hi -- I do have this on my review queue, but unfortunately it's
> sitting behind some other fairly chunky hard-to-review patchsets.

No problem - I'll wait my turn.

> As a first quick "is this going in the right direction" review based
> pretty much only on the cover letter:
> 
> What extra events do you want to try to support in the emulated PMU?
> Part of the reason we only support the cycle counter is because
>  (1) a lot of the events in a real PMU would be hard to support
>  (2) it's not clear to me that exposing events to the guest would be
>      very useful to it anyway -- performance profiling of guest code
>      running under emulation is fraught with difficulty
> 
> Giving more of an idea of what your use case is would help in
> evaluating these patches.

My goal isn't to expose events concerned with microarchitectural
performance, but rather those that can help characterize architectural
behavior (initially instructions and maybe branches, but perhaps
anything in ARM ARM D5.10.4: "Common architectural event numbers"). We
use a number of platforms at different points along the accuracy/speed
trade-off continuum, and it is convenient to use self-hosted tools that
we can expect to work on all of them.

For instance, implementing the instruction counter allows us to stop
processes after executing prescribed numbers of instructions and resume
them on other platforms for further study (using CRIU). It can also be
useful to get a `perf` profile based on instruction count to get a rough
idea of where an application is spending its time.

> Some of what you're doing looks like it's fixing bugs in our current
> implementation, which is definitely fine in principle.

Yes, I believe patches 1-5 are fairly straightforward fixes, with the
later patches getting into the more invasive changes.

> I haven't looked at the icount related stuff (and I can never remember
> how it works either) but fiddling with can_do_io does sound like it's not
> the right approach...

Agreed. Perhaps part of the same offense as the pmu_sync() calls
scattered around - I was unable to find a better way to drive the mode
filtering, and am more than glad to pursue a different approach if
pointed in the right direction.

-Aaron

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
