Received: from eggs.gnu.org ([2001:4830:134:3::10]:40199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cshQV-0000iQ-Nq
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 23:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cshQT-0007kt-TP
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 23:04:07 -0400
Received: from mail-yw0-x232.google.com ([2607:f8b0:4002:c05::232]:33041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cshQT-0007km-ND
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 23:04:05 -0400
Received: by mail-yw0-x232.google.com with SMTP id v76so44956946ywg.0
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 20:04:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1e67644b-4b30-887e-d329-1848e94c9484@twiddle.net>
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
	<1e67644b-4b30-887e-d329-1848e94c9484@twiddle.net>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 27 Mar 2017 23:03:34 -0400
Message-ID: <CAJhHMCBVzqEsEMaNTvUEFx8v-VnbSa7qgQeanVXQTtHRrRW=Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

Hi Richard,

Thanks for the feedback. Please find some comments inline.

On Mon, Mar 27, 2017 at 6:57 AM, Richard Henderson <rth@twiddle.net> wrote:
>
> 128MB is really quite large.  I doubt doubling the cache size will really
> help that much.  That said, it's really quite trivial to make this change,
> if you'd like to experiment.
>
> FWIW, I rarely see TB flushes for alpha -- not one during an entire gcc
> bootstrap.  Now, this is usually with 4GB ram, which by default implies
> 512MB translation cache.  But it does mean that, given an ideal guest, TB
> flushes should not dominate anything at all.
>
> If you're seeing multiple flushes during the startup of a browser, your
> guest must be flushing for other reasons than the code_gen_buffer being
> full.
>

This is indeed the case. From commit a9353fe897ca onwards, we are
flushing the tb cache instead of invalidating a single TB from
breakpoint_invalidate(). Now that MTTCG added proper tb/mmap locking,
we can revert that commit. I will do so once the merge windows opens.

>
>> * Implement an LRU translation block code cache.
>
>
> The major problem you'll encounter is how to manage allocation in this case.
>
> The current mechanism means that it is trivial to not know how much code is
> going to be generated for a given set of TCG opcodes.  When we reach the
> high-water mark, we've run out of room.  We then flush everything and start
> over at the beginning of the buffer.
>
> If you manage the cache with an allocator, you'll need to know in advance
> how much code is going to be generated.  This is going to require that you
> either (1) severely over-estimate the space required (qemu_ld generates lots
> more code than just add), (2) severely increase the time required, by
> generating code twice, or (3) somewhat increase the time required, by
> generating position-independent code into an external buffer and copying it
> into place after determining the size.
>

3 seems to the only feasible options, but I am not sure how easy it is
to generate position-independent code. Do you think it can be done as
a GSoC project?

>
>> * Avoid consistency overhead for strong memory model guests by generating
>>   load-acquire and store-release instructions.
>
>
> This is probably required for good performance of the user-only code path,
> but considering the number of other insns required for the system tlb
> lookup, I'm surprised that the memory barrier matters.
>

I know that having some experimental data will help to accurately show
the benefit here, but my observation from generating store-release
instruction instead of store+fence is that it helps make the system
more usable. I will try to collect this data for a linux x86 guest.

>
> I think it would be interesting to place TranslationBlock structures into
> the same memory block as code_gen_buffer, immediately before the code that
> implements the TB.
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
> We would reduce this to one insn, always, if the TB were close by, since the
> ADR instruction has a range of 1MB.
>
> (2) We have zero to two references to a linked TB, via goto_tb.
>
> Your stated goal above for eliminating the code_gen_buffer maximum of 128MB
> can be done in two ways.
>
> (2A) Raise the maximum to 2GB.  For this we would align an instruction pair,
> adrp+add, to compute the address; the following insn would branch.  The
> update code would write a new destination by modifing the adrp+add with a
> single 64-bit store.
>
> (2B) Eliminate the maximum altogether by referencing the destination
> directly in the TB.  This is the !USE_DIRECT_JUMP path.  It is normally not
> used on 64-bit targets because computing the full 64-bit address of the TB
> is harder, or just as hard, as computing the full 64-bit address of the
> destination.
>
> However, if the TB is nearby, aarch64 can load the address from
> TB.jmp_target_addr in one insn, with LDR (literal).  This pc-relative load
> also has a 1MB range.
>
> This has the side benefit that it is much quicker to re-link TBs, both in
> the computation of the code for the destination as well as re-flushing the
> icache.

This(2B) is the idea I had in mind. If we could have a combination of
both the above. If address range falls outside the 1MB range, we take
the penalty and generate the full 64-bit address.

>
>
> In addition, I strongly suspect the 1,342,177 entries (153MB) that we
> currently allocate for tcg_ctx.tb_ctx.tbs, given a 512MB code_gen_buffer, is
> excessive.
>
> If we co-allocate the TB and the code, then we get exactly the right number
> of TBs allocated with no further effort.
>
> There will be some additional memory wastage, since we'll want to keep the
> code and the data in different cache lines and that means padding, but I
> don't think that'll be significant.  Indeed, given the above over-allocation
> will probably still be a net savings.
>

If you think the project makes sense, I will add it to the GSoC wiki
so that others can also apply for it. Please let me know if you are
interested in mentoring it along with Alex.

Thanks,
-- 
Pranith
