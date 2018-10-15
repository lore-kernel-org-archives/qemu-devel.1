Received: from eggs.gnu.org ([2001:4830:134:3::10]:58108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gC9j8-0007zo-Uw
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gC9j8-00071V-3Z
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:44:34 -0400
Date: Mon, 15 Oct 2018 16:44:24 -0400
From: Aaron Lindsay <aclindsa@gmail.com>
Message-ID: <20181015204424.GK3671@okra.localdomain>
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-5-aclindsa@gmail.com>
	<0e30ca6d-57f1-e67a-b9c3-dc5e4b703260@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e30ca6d-57f1-e67a-b9c3-dc5e4b703260@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 04/14] target/arm: Swap PMU values
 before/after migrations
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

On Oct 15 12:45, Richard Henderson wrote:
> On 10/10/18 1:37 PM, Aaron Lindsay wrote:
> > +static void cpu_post_save(void *opaque)
> > +{
> > +    ARMCPU *cpu = opaque;
> > +    pmccntr_sync(&cpu->env);
> > +}
> 
> I'm confused about the need for this.
> Can you explain the sequence of events that requires it?

It sounds like you're more okay with this now based on your comments on
my later patch, but for others...

The PMU implementation is event-driven - the counters and other
associated PMU/sysreg state are only updated when needed to ensure the
architectural state observed by the system is correct (i.e. on system
register reads). Otherwise, the counters are stored as differences from
the underlying counts rather than the raw counter values themselves.
Upon migration, we want to convert the counters and other state to their
architectural versions, but then want to swap it all back to the
differential versions again when we're done saving/loading.

-Aaron
