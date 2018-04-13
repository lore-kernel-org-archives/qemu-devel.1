Received: from eggs.gnu.org ([2001:4830:134:3::10]:47634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f73Ej-000777-Qg
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f73Ei-0000LW-KF
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:15:49 -0400
Date: Fri, 13 Apr 2018 14:15:36 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20180413181536.GN24561@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-12-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA8pBXYQjbqOdSt5g1kwHbiax6iuirLOZZ0LBNxH9Ne5WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8pBXYQjbqOdSt5g1kwHbiax6iuirLOZZ0LBNxH9Ne5WA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 11/22] target/arm: Fix bitmask for
 PMCCFILTR writes
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

On Apr 12 17:41, Peter Maydell wrote:
> On 16 March 2018 at 20:31, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> > It was shifted to the left one bit too few.
> >
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > ---
> >  target/arm/helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 50eaed7..0102357 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -1123,7 +1123,7 @@ static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >                              uint64_t value)
> >  {
> >      uint64_t saved_cycles = pmccntr_op_start(env);
> > -    env->cp15.pmccfiltr_el0 = value & 0x7E000000;
> > +    env->cp15.pmccfiltr_el0 = value & 0xfc000000;
> >      pmccntr_op_finish(env, saved_cycles);
> >  }
> >
> 
> I wonder why we got that one wrong.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Strictly speaking, bit 26 (M) should be visible only in
> the AArch64 view of the register, not the AArch32 one,
> but that's a separate issue.

Right. I addressed this when I added AArch32 access for PMCCFILTR:
	[PATCH v3 13/22] target/arm: Allow AArch32 access for PMCCFILTR
	https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg04910.html

-Aaron

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
