Received: from eggs.gnu.org ([2001:4830:134:3::10]:33912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWMSo-0005g7-ME
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWMSn-0008BF-Qz
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:50:58 -0400
Date: Fri, 22 Jun 2018 09:50:45 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20180622135045.GD12424@codeaurora.org>
References: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
	<1523997485-1905-4-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA_g1Bb=-cj+QToHDypZPiqw_U5YioRWfDSs0Ano3PqDTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_g1Bb=-cj+QToHDypZPiqw_U5YioRWfDSs0Ano3PqDTQ@mail.gmail.com>
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

On Apr 20 11:17, Peter Maydell wrote:
> On 17 April 2018 at 21:37, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> > pmccntr_read and pmccntr_write contained duplicate code that was already
> > being handled by pmccntr_sync. Consolidate the duplicated code into two
> > functions: pmccntr_op_start and pmccntr_op_finish. Add a companion to
> > c15_ccnt in CPUARMState so that we can simultaneously save both the
> > architectural register value and the last underlying cycle count - this
> > ensure time isn't lost and will also allow us to access the 'old'
> > architectural register value in order to detect overflows in later
> > patches.
> >
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > ---
> >  target/arm/cpu.h    |  28 ++++++++++-----
> >  target/arm/helper.c | 100 ++++++++++++++++++++++++++++------------------------
> >  2 files changed, 73 insertions(+), 55 deletions(-)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 19a0c03..04041db 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -454,10 +454,20 @@ typedef struct CPUARMState {
> >          uint64_t oslsr_el1; /* OS Lock Status */
> >          uint64_t mdcr_el2;
> >          uint64_t mdcr_el3;
> > -        /* If the counter is enabled, this stores the last time the counter
> > -         * was reset. Otherwise it stores the counter value
> > +        /* Stores the architectural value of the counter *the last time it was
> > +         * updated* by pmccntr_op_start. Accesses should always be surrounded
> > +         * by pmccntr_op_start/pmccntr_op_finish to guarantee the latest
> > +         * architecturally-corect value is being read/set.
> >           */
> >          uint64_t c15_ccnt;
> > +        /* Stores the delta between the architectural value and the underlying
> > +         * cycle count during normal operation. It is used to update c15_ccnt
> > +         * to be the correct architectural value before accesses. During
> > +         * accesses, c15_ccnt_delta contains the underlying count being used
> > +         * for the access, after which it reverts to the delta value in
> > +         * pmccntr_op_finish.
> > +         */
> > +        uint64_t c15_ccnt_delta;
> 
> So the key question here is: how does this work for VM migration?

To be honest, I'm not sure I fully understand the things I need to be
looking out for with VM migration.

My guess, though, is that this current implementation is not sufficient.
Perhaps there needs to be logic to ensure that c15_ccnt is the current
architectural value before migration and also to setup c15_ccnt_delta to
be the delta between that architectural value and the underlying cycle
count upon inbound migration. Does that sound like an approach which
would fit well within the rest of the migration framework?

-Aaron

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
