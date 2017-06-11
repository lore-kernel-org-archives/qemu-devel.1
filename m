Received: from eggs.gnu.org ([2001:4830:134:3::10]:37288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJv6G-0004Ig-DB
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 01:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJv6F-0001Ss-El
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 01:07:44 -0400
Date: Sun, 11 Jun 2017 01:07:30 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170611050730.GA12317@flamenco>
References: <20170609170100.3599-1-alex.bennee@linaro.org>
	<20170609170100.3599-4-alex.bennee@linaro.org>
	<fc351edb-7c08-c341-d8ee-85f6768e4931@twiddle.net>
	<87vao4b4z5.fsf@linaro.org>
	<9776b437-90b4-f2c2-4a0c-c1c6585379bf@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9776b437-90b4-f2c2-4a0c-c1c6585379bf@twiddle.net>
Subject: Re: [Qemu-devel] [RFC DEBUG PATCH 3/3] translate-a64: fix
 lookup_tb_ptr hang (DEBUG!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, pbonzini@redhat.com, edgar.iglesias@xilinx.com, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

On Sat, Jun 10, 2017 at 09:59:19 -0700, Richard Henderson wrote:
> On 06/10/2017 01:51 AM, Alex Bennée wrote:
> >I would agree with Emilio that we revert but I can't quite shake the
> >feeling we are missing an underlying problem. Would just skipping the
> >htable lookup (but keeping the tb_jmp_cache) be an OK fix for now?
> 
> I agree.  It seems like there's some real problem that this is uncovering.
> 
> Dropping the htable lookup is certainly ok by me.  If that's enough to
> un-stick your regression testing for aarch64 guest.

Unfortunately not checking the htable isn't enough to fix it for me.

I spent a few hours on Friday trying (and failing) to understand
what's going on. Regarding interrupts, I see *more* TB_EXIT_INTERRUPT
exits than without the patch, so my current best guess is that this is
a livelock kind of thing.

I'll keep digging, but regardless I think we should revert
e75449a346 ("target/aarch64: optimize indirect branches") ASAP, and
then reenable the feature ("revert the revert") once we get to the
bottom of this.

		E.
