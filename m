Received: from eggs.gnu.org ([2001:4830:134:3::10]:51225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gC9UG-0003d5-Un
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gC9UF-0002jq-Im
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:29:12 -0400
Date: Mon, 15 Oct 2018 16:29:07 -0400
From: Aaron Lindsay <aclindsa@gmail.com>
Message-ID: <20181015202906.GI3671@okra.localdomain>
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-6-aclindsa@gmail.com>
	<4fff310a-8fc6-91f9-6caf-315c84d983d0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fff310a-8fc6-91f9-6caf-315c84d983d0@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 05/14] target/arm: Reorganize PMCCNTR
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On Oct 15 12:50, Richard Henderson wrote:
> On 10/10/18 1:37 PM, Aaron Lindsay wrote:
> > pmccntr_read and pmccntr_write contained duplicate code that was already
> > being handled by pmccntr_sync. Consolidate the duplicated code into two
> > functions: pmccntr_op_start and pmccntr_op_finish. Add a companion to
> > c15_ccnt in CPUARMState so that we can simultaneously save both the
> > architectural register value and the last underlying cycle count - this
> > ensures time isn't lost and will also allow us to access the 'old'
> > architectural register value in order to detect overflows in later
> > patches.
> > 
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > ---
> >  target/arm/cpu.h     | 26 ++++++++----
> >  target/arm/helper.c  | 96 +++++++++++++++++++++++---------------------
> >  target/arm/machine.c |  8 ++--
> >  3 files changed, 73 insertions(+), 57 deletions(-)
> 
> Ok, looking at this follow-up makes more sense than the previous patch.  Would
> it make sense to squash these two together?

I was attempting to keep the migration plumbing separate from the PMU
implementation details, but I'm not particularly partial to this
staging.

> It also makes sense why you'd need the post_save hook.

Okay. I attempted to describe this in the commit message in a way that
communicated the need for the hook without being overly verbose - but
suggestions in that area are very welcome if you think a different
commit message would help.

-Aaron
