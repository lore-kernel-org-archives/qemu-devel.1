Received: from eggs.gnu.org ([2001:4830:134:3::10]:57819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddMuh-0004Uf-Aa
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 16:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddMug-0002Qw-HX
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 16:40:11 -0400
Date: Thu, 3 Aug 2017 22:40:01 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170803204001.GX4859@toto>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-3-git-send-email-peter.maydell@linaro.org>
	<3f6ee028-b7f9-fbe0-1aea-eb1e6faab5a3@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f6ee028-b7f9-fbe0-1aea-eb1e6faab5a3@twiddle.net>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 02/15] target/arm: Don't trap
 WFI/WFE for M profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Thu, Aug 03, 2017 at 01:28:28PM -0700, Richard Henderson wrote:
> On 08/02/2017 09:43 AM, Peter Maydell wrote:
> > M profile cores can never trap on WFI or WFE instructions. Check for
> > M profile in check_wfx_trap() to ensure this.
> > 
> > The existing code will do the right thing for v7M cores because
> > the hcr_el2 and scr_el3 registers will be all-zeroes and so we
> > won't attempt to trap, but when we start setting ARM_FEATURE_V8
> > for v8M cores the v8A handling of SCTLR.nTWE and .nTWI will not
> > give the right results.
> > 
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  target/arm/op_helper.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> While looking at this, I think there's an error in helper_wfi.  The early exit
> for cpu_has_work should happen after the exception check.

I don't have the spec at hand but IIRC the trap should only happen
if the processor would have entered the low-power state (i.e if
there's no work).

A comment in the code would probably be good...

Cheers,
Edgar 
