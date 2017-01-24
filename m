Received: from eggs.gnu.org ([2001:4830:134:3::10]:34903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cW265-0002Ih-4v
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cW262-0003XE-1Q
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:29:21 -0500
Received: from bran.ispras.ru ([83.149.199.196]:50896 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cW261-0003Ws-Lm
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:29:17 -0500
Date: Tue, 24 Jan 2017 17:29:15 +0300 (MSK)
From: Kirill Batuzov <batuzovk@ispras.ru>
In-Reply-To: <0b0b1136-ada6-f30e-a6b9-90263d55e7da@twiddle.net>
Message-ID: <alpine.DEB.2.11.1701241637370.2026@bulbul.intra.ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-2-git-send-email-batuzovk@ispras.ru>
	<4d351b53-8724-b245-0077-942de1bebd66@twiddle.net>
	<alpine.DEB.2.11.1701191515580.1724@bulbul.intra.ispras.ru>
	<7178d6dd-4252-ad60-e1f0-51acffcd393c@twiddle.net>
	<d3ca01a3-b8ed-93fd-235a-bd9b3adad838@ispras.ru>
	<7f9b740e-20d5-2a6e-eaba-ffef5851e754@twiddle.net>
	<alpine.DEB.2.11.1701231246360.2026@bulbul.intra.ispras.ru>
	<0b0b1136-ada6-f30e-a6b9-90263d55e7da@twiddle.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 01/18] tcg: add support for 128bit vector
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 23 Jan 2017, Richard Henderson wrote:

> On 01/23/2017 02:30 AM, Kirill Batuzov wrote:
> > Because 4 adds on 4 i32 registers work good only when the size of
> > vector elements matches the size of scalar variables we use for
> > representation of a vector. add_i16x8 will not be that great if we use
> > 4 i32 variables: each will need to be split into two values, processed
> > independently and merged back afterwards.
> 
> Certainly.  But that's pretty much exactly how they are processed now.  Usually
> via a helper function that accepts an i64 input as a pair of i32 arguments.
> 
> > Scalar variables lack primitives to work with them as vectors of shorter
> > values. This is one of the reasons I added v64 type instead of using i64
> > for 64-bit vector operations. And this is the reason I'm so opposed to
> > using them to represent vector types if vector registers are not
> > supported by host. Handling vector operations with element size that
> > does not match representation will be complicated, may require special
> > handling for different operations and will produce a lot of if-s in code.
> 
> A lot of if's?  I've no idea what you're talking about.
> 
> A v64 type makes sense because generally we're going to allocate them to a
> different register set than i64.  That said, i64 is perfectly adequate for
> implementing add_i8x8:
> 
>   t0  = in1 & 0x7f7f7f7f7f7f7f7f
>   t1  = in0 + t0;
>   t2  = in1 & 0x8080808080808080
>   out = t1 ^ t2
> 
> This is less expensive than addition by pieces if there are at least 4 pieces.
> 
> > The method I'm proposing can handle any operation regardless of
> > representation. This includes handling situation where host supports
> > vector registers but does not support required operation (for example 
> > SSE/AVX does not support multiplication of vectors of 8-bit values).
> 
> Not for nothing but it's trivial to expand with punpcklbw, punpckhbw, pmullw,
> pand, packuswb.  That said, if an expansion gets too complicated, it's still
> better to move it into a helper than expand 16 * (load, op, store).
>

I'm a bit lost in the discussion so let me try to summarise. As far as I
understand there is only one major point on which we disagree: is it
worth representing vector variables as a sequences of scalar ones?

Pros:
1. We will not get phantom variables of unsupported type like we do in
my current implementation.

2. If we manage to efficiently emulate large enough number of vector
operations using scalar types we'll get some performance benefits. In
this case scalar variables can be allocated on registers and stay there
across several consecutive guest instructions.

I personally doubt that first "if": logical operations will be fine,
addition and subtraction can be implemented, may be shifts, but
everything else will end up as helpers (and they are expensive
from performance perspective).

Cons:
1. Additional cases for each possible representation in
tcg_global_mem_new_internal and tcg_temp_new_internal. I do not see how I
can use existing i64 as a pair of i32 recursively. TCG supports only one
level of indirection: there is a "type" of variable, and a "base_type"
it is used to represent. i64 code does not check "base_type" explicitly,
so if I pass two consecutive i32 variables to these functions they will
work, but this sounds like some dirty hack to me.

2. Additional cases for each possible representation in
tcg_gen_<vector_op> wrappers. We need to generate adequate expansion
code for each representation. That is if do not default to memory
location every time (in which case why bother with different
representation to begin with).

3. TCG variables exhaustion: to (potentially) represent AVX-512
registers with 32 bit variables we'll need 512 of them (32 of 512 bit
registers). TCG_MAX_TEMP is 512. Sure, it can be increased.

Making something a global variable is only beneficial when we can carry
a value of it in a register from one operation to another (so we'll get
ld+op1+op2+st instead of l1+op1+st+ld+op2+st). I'm not sure that subset
of operations we can effectively emulate is large enough for this to
happen often, but my experience with vector operations is limited so it
might be.

Let's do the following: in v2 I'll add representation of v128 as a pair
of v64 and update tcg_gen_<vector_op> wrappers. We'll see how this works
out and decide if it is good to follow with representation of v128 as a
sequence of scalar types.

-- 
Kirill
