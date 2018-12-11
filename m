Received: from eggs.gnu.org ([2001:4830:134:3::10]:38932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gWYKl-0001ub-RO
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 22:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gWYKg-0007wF-N5
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 22:03:43 -0500
Date: Tue, 11 Dec 2018 04:03:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20181211012027.GA4261@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.9999.1812110330580.98824@zero.eik.bme.hu>
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1812100112050.45639@zero.eik.bme.hu>
	<20181210025943.GE4261@umbus.fritz.box>
	<alpine.BSF.2.21.9999.1812102035360.24343@zero.eik.bme.hu>
	<20181211012027.GA4261@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 0/6] target/ppc: convert VMX
 instructions to use TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org

On Tue, 11 Dec 2018, David Gibson wrote:
> On Mon, Dec 10, 2018 at 09:54:51PM +0100, BALATON Zoltan wrote:
>> Yes, I don't really know what these tests use but I think "lame" test is
>> mostly floating point but tried with "lame_vmx" which should at least use
>> some vector ops and "mplayer -benchmark" test is more vmx dependent based on
>> my previous profiling and testing with hardfloat but I'm not sure. (When
>> testing these with hardfloat I've found that lame was benefiting from
>> hardfloat but mplayer wasn't and more VMX related functions showed up with
>> mplayer so I assumed it's more VMX bound.)
>
> I should clarify here.  When I say "floating point" above, I'm not
> meaning things using the regular FPU instead of the vector unit.  I'm
> saying *anything* involving floating point calculations whether
> they're done in the FPU or the vector unit.

OK that clarifies it. I admit I was only testing these but didn't have 
time to look what changed exactly.

> The patches here don't convert all VMX instructions to use vector TCG
> ops - they only convert a few, and those few are about using the
> vector unit for integer (and logical) operations.  VMX instructions
> involving floating point calculations are unaffected and will still
> use soft-float.

What I've said above about lame test being more FPU and mplayer more VMX 
intensive probably still holds as I've retried now on a Haswell i5 and got 
1-2% difference with lame_vmx and ~6% with mplayer. That's very little 
improvement but if only some VMX instructions should be faster then this 
may make sense.

These tests are not the best, maybe there are better ways to measure this 
but I don't know of any,

>> Maybe the PPC softmmu should be reviewed and optimised by someone who knows
>> it...
>
> I'm not sure there is anyone who knows it at this point.  I probably
> know it as well as anybody, and the ppc32 code scares me.  It's a
> crufty mess and it would be nice to clean up, but that requires
> someone with enough time and interest.

At least this seems to be a big bottleneck in PPC emulation and one that's 
not being worked on (others like hardfloat and VMX while not finished and 
still lot to do but already there are some results but no one is looking 
at softmmu). I was just trying to direct some attention to that softmmu 
may also need some optimisation and hope someone would notice this. I have 
some interest but not much time these days and if it scares you what 
should I say. I don't even understand most of it so it would take a lot of
time to even get how it works and what would need to be done. So I hope 
someone with more time or knowledge shows up and maybe at least provides 
some hints on what may need to be done.

Regards,
BALATON Zoltan
