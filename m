Received: from eggs.gnu.org ([2001:4830:134:3::10]:54962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSmy-00050p-Dp
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSmx-0006En-9t
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:36:12 -0400
Date: Fri, 22 Jun 2018 16:36:04 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20180622203604.GE12424@codeaurora.org>
References: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
	<1523997485-1905-4-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA_g1Bb=-cj+QToHDypZPiqw_U5YioRWfDSs0Ano3PqDTQ@mail.gmail.com>
	<20180622135045.GD12424@codeaurora.org>
	<CAFEAcA_EEXRQQjXDsei0Y6mQB6EVTtJB5=EFHFsT7kbZk5iv6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_EEXRQQjXDsei0Y6mQB6EVTtJB5=EFHFsT7kbZk5iv6Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 03/21] target/arm: Reorganize PMCCNTR
 accesses
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

On Jun 22 15:08, Peter Maydell wrote:
> On 22 June 2018 at 14:50, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> > On Apr 20 11:17, Peter Maydell wrote:
> >> On 17 April 2018 at 21:37, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> >> > pmccntr_read and pmccntr_write contained duplicate code that was already
> >> > being handled by pmccntr_sync. Consolidate the duplicated code into two
> >> > functions: pmccntr_op_start and pmccntr_op_finish. Add a companion to
> >> > c15_ccnt in CPUARMState so that we can simultaneously save both the
> >> > architectural register value and the last underlying cycle count - this
> >> > ensure time isn't lost and will also allow us to access the 'old'
> >> > architectural register value in order to detect overflows in later
> >> > patches.
> >> >
> >> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> 
> >> > -        /* If the counter is enabled, this stores the last time the counter
> >> > -         * was reset. Otherwise it stores the counter value
> >> > +        /* Stores the architectural value of the counter *the last time it was
> >> > +         * updated* by pmccntr_op_start. Accesses should always be surrounded
> >> > +         * by pmccntr_op_start/pmccntr_op_finish to guarantee the latest
> >> > +         * architecturally-corect value is being read/set.
> >> >           */
> >> >          uint64_t c15_ccnt;
> >> > +        /* Stores the delta between the architectural value and the underlying
> >> > +         * cycle count during normal operation. It is used to update c15_ccnt
> >> > +         * to be the correct architectural value before accesses. During
> >> > +         * accesses, c15_ccnt_delta contains the underlying count being used
> >> > +         * for the access, after which it reverts to the delta value in
> >> > +         * pmccntr_op_finish.
> >> > +         */
> >> > +        uint64_t c15_ccnt_delta;
> >>
> >> So the key question here is: how does this work for VM migration?
> >
> > To be honest, I'm not sure I fully understand the things I need to be
> > looking out for with VM migration.
> >
> > My guess, though, is that this current implementation is not sufficient.
> > Perhaps there needs to be logic to ensure that c15_ccnt is the current
> > architectural value before migration and also to setup c15_ccnt_delta to
> > be the delta between that architectural value and the underlying cycle
> > count upon inbound migration. Does that sound like an approach which
> > would fit well within the rest of the migration framework?
> 
> You need to deal with two different situations:
>  (1) migration from an older QEMU which doesn't have this patchset
>  (2) migration from a QEMU with this patchset to one with this patchset
> 
> Either:
>  (a) all the architectural state can be expressed in our existing
> state fields in whatever the previous format was -- in this case
> you just need to ensure that cpu_pre_save() and cpu_post_load()
> put the state there and unpack it again
>  (b) we were missing some architectural state and really do need
> to transfer more over the wire than we were before -- in this case
> you need to add a new subsection to the vmstate which has the fields
> that contain that new state, and give the subsection a suitable 'needed'
> function to indicate when the subsection should be transferred plus
> pre_load and post_load functions that allow us to cope correctly with
> the case of the older QEMU that doesn't send the subsection.

Okay, thanks! I didn't manage to get to this before v5, but look into it
more for v6.

-Aaron

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
