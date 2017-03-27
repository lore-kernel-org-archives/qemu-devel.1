Received: from eggs.gnu.org ([2001:4830:134:3::10]:59102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csUbr-0000Gf-Ai
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csUbo-0005Fa-54
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:22:59 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1csUbn-0005F8-Ui
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:22:56 -0400
Received: by mail-wr0-x234.google.com with SMTP id w11so42850219wrc.3
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 06:22:55 -0700 (PDT)
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
	<1e67644b-4b30-887e-d329-1848e94c9484@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1e67644b-4b30-887e-d329-1848e94c9484@twiddle.net>
Date: Mon, 27 Mar 2017 14:22:51 +0100
Message-ID: <874lye6ehg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] GSoC 2017 Proposal: TCG performance enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Pranith Kumar <bobby.prani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>, qemu-devel <qemu-devel@nongnu.org>


Richard Henderson <rth@twiddle.net> writes:

> On 03/26/2017 02:52 AM, Pranith Kumar wrote:
>> Hello,
>>
<snip>
>
>> Please let me know if you have any comments or suggestions. Also please let me
>> know if there are other enhancements that are easily implementable to increase
>> TCG performance as part of this project or otherwise.
>
> I think it would be interesting to place TranslationBlock structures
> into the same memory block as code_gen_buffer, immediately before the
> code that implements the TB.
>
> Consider what happens within every TB:
>
> (1) We have one or more references to the TB address, via exit_tb.
>
> For aarch64, this will normally require 2-4 insns.
>
> # alpha-softmmu
> 0x7f75152114:  d0ffb320      adrp x0, #-0x99a000 (addr 0x7f747b8000)
> 0x7f75152118:  91004c00      add x0, x0, #0x13 (19)
> 0x7f7515211c:  17ffffc3      b #-0xf4 (addr 0x7f75152028)
>
> # alpha-linux-user
> 0x00569500:  d2800260      mov x0, #0x13
> 0x00569504:  f2b59820      movk x0, #0xacc1, lsl #16
> 0x00569508:  f2c00fe0      movk x0, #0x7f, lsl #32
> 0x0056950c:  17ffffdf      b #-0x84 (addr 0x569488)
>
> We would reduce this to one insn, always, if the TB were close by,
> since the ADR instruction has a range of 1MB.

Having a TB address statically addressable from the generated code would
also be very handy for doing things like rough block execution counts
(or even precise if you want to go through the atomic penalty for it).

It would be nice for future work to be able to track where our hot-paths
are through generated code.

>
>
> (2) We have zero to two references to a linked TB, via goto_tb.
>
> Your stated goal above for eliminating the code_gen_buffer maximum of
> 128MB can be done in two ways.
>
> (2A) Raise the maximum to 2GB.  For this we would align an instruction
> pair, adrp+add, to compute the address; the following insn would
> branch.  The update code would write a new destination by modifing the
> adrp+add with a single 64-bit store.
>
> (2B) Eliminate the maximum altogether by referencing the destination
> directly in the TB.  This is the !USE_DIRECT_JUMP path.  It is
> normally not used on 64-bit targets because computing the full 64-bit
> address of the TB is harder, or just as hard, as computing the full
> 64-bit address of the destination.
>
> However, if the TB is nearby, aarch64 can load the address from
> TB.jmp_target_addr in one insn, with LDR (literal).  This pc-relative
> load also has a 1MB range.
>
> This has the side benefit that it is much quicker to re-link TBs, both
> in the computation of the code for the destination as well as
> re-flushing the icache.
>
>
> In addition, I strongly suspect the 1,342,177 entries (153MB) that we
> currently allocate for tcg_ctx.tb_ctx.tbs, given a 512MB
> code_gen_buffer, is excessive.
>
> If we co-allocate the TB and the code, then we get exactly the right
> number of TBs allocated with no further effort.
>
> There will be some additional memory wastage, since we'll want to keep
> the code and the data in different cache lines and that means padding,
> but I don't think that'll be significant.  Indeed, given the above
> over-allocation will probably still be a net savings.
>
>
> r~


--
Alex Bennée
