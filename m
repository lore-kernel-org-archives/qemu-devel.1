Received: from eggs.gnu.org ([2001:4830:134:3::10]:47055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnp4-0001LT-Mf
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnoz-0002z4-NJ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:36:02 -0500
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1812100112050.45639@zero.eik.bme.hu>
	<20181210025943.GE4261@umbus.fritz.box>
	<alpine.BSF.2.21.9999.1812102035360.24343@zero.eik.bme.hu>
	<20181211012027.GA4261@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <7bcfc7ae-7777-e1e5-d1a4-36c2d958b845@ilande.co.uk>
Date: Tue, 11 Dec 2018 19:35:42 +0000
MIME-Version: 1.0
In-Reply-To: <20181211012027.GA4261@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
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
To: David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org

On 11/12/2018 01:20, David Gibson wrote:

> On Mon, Dec 10, 2018 at 09:54:51PM +0100, BALATON Zoltan wrote:
>> On Mon, 10 Dec 2018, David Gibson wrote:
>>> On Mon, Dec 10, 2018 at 01:33:53AM +0100, BALATON Zoltan wrote:
>>>> On Fri, 7 Dec 2018, Mark Cave-Ayland wrote:
>>>>> This patchset is an attempt at trying to improve the VMX (Altivec) instruction
>>>>> performance by making use of the new TCG vector operations where possible.
>>>>
>>>> This is very welcome, thanks for doing this.
>>>>
>>>>> In order to use TCG vector operations, the registers must be accessible from cpu_env
>>>>> whilst currently they are accessed via arrays of static TCG globals. Patches 1-3
>>>>> are therefore mechanical patches which introduce access helpers for FPR, AVR and VSR
>>>>> registers using the supplied TCGv_i64 parameter.
>>>>
>>>> Have you tried some benchmarks or tests to measure the impact of these
>>>> changes? I've tried the (very unscientific) benchmarks I've written about
>>>> before here:
>>>>
>>>> http://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00261.html
>>>>
>>>> (which seem to use AltiVec/VMX instructions but not sure which) on mac99
>>>> with MorphOS and I could not see any performance increase. I haven't run
>>>> enough tests but results with or without this series on master were mostly
>>>> the same within a few percents, and sometimes even seen lower performance
>>>> with these patches than without. I haven't tried to find out why (no time
>>>> for that now) so can't really draw any conclusions from this. I'm also not
>>>> sure if I've actually tested what you've changed or these use instructions
>>>> that your patches don't optimise yet, or the changes I've seen were just
>>>> normal changes between runs; but I wonder if the increased number of
>>>> temporaries could result in lower performance in some cases?
>>>
>>> What was your host machine.  IIUC this change will only improve
>>> performance if the host tcg backend is able to implement TCG vector
>>> ops in terms of vector ops on the host.
>>
>> Tried it on i5 650 which has: sse sse2 ssse3 sse4_1 sse4_2. I assume x86_64
>> should be supported but not sure what are the CPU requirements.
>>
>>> In addition, this series only converts a subset of the integer and
>>> logical vector instructions.  If your testcase is mostly floating
>>> point (vectored or otherwise), it will still be softfloat and so not
>>> see any speedup.
>>
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
> 
> The patches here don't convert all VMX instructions to use vector TCG
> ops - they only convert a few, and those few are about using the
> vector unit for integer (and logical) operations.  VMX instructions
> involving floating point calculations are unaffected and will still
> use soft-float.

Right. As I mentioned in an earlier email, this is hopefully laying the groundwork
for future evolution of the TCG vector operations and making use of the existing
functions first.

Certainly I'd be interested at looking at the hardfloat patches after this, since FP
performance is something that can offer enormous benefit to MacOS emulation.

>> I've tried to do some profiling again to find out what's used but I can't
>> get good results with the tools I have (oprofile stopped working since I've
>> updated my machine and Linux perf provides results that are hard to
>> interpret for me, haven't tried if gprof would work now it didn't before)
>> but I've seen some vector related helpers in the profile so at least some
>> vector ops are used. The "helper_vperm" came up top at about 11th (not sure
>> where is it called from), other vector helpers were lower.
>>
>> I don't remember details now but previously when testing hardfloat I've
>> written this: "I've looked at vperm which came out top in one of the
>> profiles I've taken and on little endian hosts it has the loop backwards and
>> also accesses vector elements from end to front which I wonder may be enough
>> for the compiler to not be able to optimise it? But I haven't checked
>> assembly. The altivec dependent mplayer video decoding test did not change
>> much with hardfloat, it took 98% compared to master so likely altivec is
>> dominating here." (Although this was with the PPC specific vector helpers
>> before VMX patch so not sure if this is still relevant.)
>>
>> The top 10 in profile were still related to low level memory access and MMU
>> management stuff as I've found before:
>>
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03609.html
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03704.html
>>
>> I think implementing i2c for mac99 may help this and some other
>> optimisations may also be possible but I don't know enough about these to
>> try that.
>>
>> It also looks like with --enable-debug something is always flusing tlb and
>> blowing away tb caches so these will be top in profile and likely dominate
>> runtime so can't really use profile to measure impact of VMX patch. Without
>> --enable-debug I can't get call graphs so can't get useful profile. I think
>> I've looked at this before as well but can't remember now which check
>> enabled by --enable-debug is responsible for constant tb cache flush and if
>> that could be avoided. I just don't use --enable-debug since unless need to
>> debug somthing.
>>
>> Maybe the PPC softmmu should be reviewed and optimised by someone who knows
>> it...
> 
> I'm not sure there is anyone who knows it at this point.  I probably
> know it as well as anybody, and the ppc32 code scares me.  It's a
> crufty mess and it would be nice to clean up, but that requires
> someone with enough time and interest.

As a newcomer to this code, it's not particularly easy to read. It strikes me that
one of the main improvements would be to switch over to using generated helper
templates rather than to make use of nested macros as in use currently.

Looking at your profiles above, the primary hotspot appears to be
helper_lookup_tb_ptr(). However as someone quite new to the TCG parts of QEMU, I
couldn't tell you whether or not this is to be expected.

Perhaps a question for Richard: what could we consider to be a "normal" backend when
looking at profiles in terms of recommended features to implement, and to get an idea
of what a typical profile should look like?

It would be interesting to compare with a similar workload profile on e.g. ARM to see
if there is anything obvious that stands out for PPC.


ATB,

Mark.
