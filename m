Received: from eggs.gnu.org ([2001:4830:134:3::10]:51518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1dk56w-0002xK-3w
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1dk56u-0006l5-O5
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:04:34 -0400
Date: Tue, 22 Aug 2017 12:04:23 +0300 (MSK)
From: Kirill Batuzov <batuzovk@ispras.ru>
In-Reply-To: <64af762a-5d2b-5e33-fc8e-18244b0c6586@linaro.org>
Message-ID: <alpine.DEB.2.20.1708221128110.2770@bulbul.intra.ispras.ru>
References: <20170817180404.29334-1-alex.bennee@linaro.org>
	<alpine.DEB.2.20.1708181355080.2770@bulbul.intra.ispras.ru>
	<64af762a-5d2b-5e33-fc8e-18244b0c6586@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [RFC PATCH 0/9] TCG Vector types and example
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, cota@braap.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, rth@twiddle.net

On Fri, 18 Aug 2017, Richard Henderson wrote:

> On 08/18/2017 04:33 AM, Kirill Batuzov wrote:
> > From my own experimentations some times ago,
> > 
> > (1) translating vector instructions to vector instructions in TCG is faster than
> > 
> > (2) translating vector instructions to series of scalar instructions in TCG,
> > which is faster than*
> > 
> > (3) translating vector instructions to single helper calls, which is faster
> > than*
> > 
> > (4) translating vector instructions to helper calls for each vector element.
> > 
> > (*) (2) and (3) may change their respective places in case of some
> > complicated instructions.
> 
> This was my gut feeling as well.  With the caveat that for the ARM SVE case of
> 2048-bit registers we cannot afford to expand inline due to generated code size.
> 
> > ARM (at least ARM32, I have not checked aarch64 in this regard) uses the
> > last, the slowest scheme. As far as I understand, you are want to change
> > it to the third approach. This approach is used in SSE emulation, may be
> > you can use similar structure of helpers?
> > 
> > I still hope to finish my own series about implementation of the first
> > approach. I apologize for the long delay since last update and hope to
> > send next version somewhere next week. I do not think our series
> > contradict each other: you are trying to optimize existing general
> > purpose case while I'm trying to optimize case where both host and guest
> > support vector instructions. Since I'm experimenting on ARM32, we'll not
> > have much merge conflicts either.
> 
> I posted my own, different, take on vectorization yesterday as well.
> 
>   http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg03272.html
> 
> The primary difference between my version and your version is that I do not
> allow target/cpu/translate*.c to create vector types.  All of the host vector
> expansion is done within tcg/*.c.

I took a look at your approach. The only problem with it is that in
current implementation it does not allow to keep vector variables on
register between consecutive guest instructions. But this can be
changed. To do it we need to make copy propagation work with memory
locations as well, and dead code elimination to be able to remove excess
stores to memory. While in general case these can be troublesome if we
limit analysis to addresses that are [env + Const] it becomes relatively
easy. I've done similar thing in my series to track interference between
memory operations and vector global variables. In case of your series
this affects only performance so it does not need to be added in the
initial series and can be added later as a separate patch. I can care of
this once initial series are pulled to master.

Overall I like your approach the most out of three:
 - it handles different representations of guest vectors with host
   vectors seamlessly (unlike my approach where I still do not know how
   to make it right),
 - it provides better performance than Alex's (and the same as mine once
   we add a bit of alias analysis),
 - it moves in the direction of representing guest vectors not as
   globals, but as a pair (offset, size) in a special address space
   (this approach was successfully used in Valgrind and it handles
   intersecting registers much better than what we have now; we are
   moving in this direction anyway).

-- 
Kirill
