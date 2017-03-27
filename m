Received: from eggs.gnu.org ([2001:4830:134:3::10]:48018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1csSLI-0004C5-Lf
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1csSLF-0002So-Ju
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:57:44 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1csSLF-0002Si-Ad
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:57:41 -0400
Received: by mail-pg0-x241.google.com with SMTP id 79so11934275pgf.0
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 03:57:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1e67644b-4b30-887e-d329-1848e94c9484@twiddle.net>
Date: Mon, 27 Mar 2017 20:57:32 +1000
MIME-Version: 1.0
In-Reply-To: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] GSoC 2017 Proposal: TCG performance enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

On 03/26/2017 02:52 AM, Pranith Kumar wrote:
> Hello,
>
> With MTTCG code now merged in mainline, I tried to see if we are able to run
> x86 SMP guests on ARM64 hosts. For this I tried running a windows XP guest on
> a dragonboard 410c which has 1GB RAM. Since x86 has a strong memory model
> whereas ARM64 is a weak memory model, I added a patch to generate fence
> instructions for every guest memory access. After some minor fixes, I was
> successfully able to boot a 4 core guest all the way to the desktop (albeit
> with a 1GB backing swap). However the performance is severely
> limited and the guest is barely usable. Based on my observations, I think
> there are some easily implementable additions we can make to improve the
> performance of TCG in general and on ARM64 in particular. I propose to do the
> following as part of Google Summer of Code 2017.
>
>
> * Implement jump-to-register instruction on ARM64 to overcome the 128MB
>   translation cache size limit.
>
>   The translation cache size for an ARM64 host is currently limited to 128
>   MB. This limitation is imposed by utilizing a branch instruction which
>   encodes the jump offset and is limited by the number of bits it can use for
>   the range of the offset. The performance impact by this limitation is severe
>   and can be observed when you try to run large programs like a browser in the
>   guest. The cache is flushed several times before the browser starts and the
>   performance is not satisfactory. This limitation can be overcome by
>   generating a branch-to-register instruction and utilizing that when the
>   destination address is outside the range of what can be encoded in current
>   branch instruction.

128MB is really quite large.  I doubt doubling the cache size will really help 
that much.  That said, it's really quite trivial to make this change, if you'd 
like to experiment.

FWIW, I rarely see TB flushes for alpha -- not one during an entire gcc 
bootstrap.  Now, this is usually with 4GB ram, which by default implies 512MB 
translation cache.  But it does mean that, given an ideal guest, TB flushes 
should not dominate anything at all.

If you're seeing multiple flushes during the startup of a browser, your guest 
must be flushing for other reasons than the code_gen_buffer being full.


> * Implement an LRU translation block code cache.
>
>   In the current TCG design, when the translation cache fills up, we flush all
>   the translated blocks (TBs) to free up space. We can improve this situation
>   by not flushing the TBs that were recently used i.e., by implementing an LRU
>   policy for freeing the blocks. This should avoid the re-translation overhead
>   for frequently used blocks and improve performance.

The major problem you'll encounter is how to manage allocation in this case.

The current mechanism means that it is trivial to not know how much code is 
going to be generated for a given set of TCG opcodes.  When we reach the 
high-water mark, we've run out of room.  We then flush everything and start 
over at the beginning of the buffer.

If you manage the cache with an allocator, you'll need to know in advance how 
much code is going to be generated.  This is going to require that you either 
(1) severely over-estimate the space required (qemu_ld generates lots more code 
than just add), (2) severely increase the time required, by generating code 
twice, or (3) somewhat increase the time required, by generating 
position-independent code into an external buffer and copying it into place 
after determining the size.


> * Avoid consistency overhead for strong memory model guests by generating
>   load-acquire and store-release instructions.

This is probably required for good performance of the user-only code path, but 
considering the number of other insns required for the system tlb lookup, I'm 
surprised that the memory barrier matters.

> Please let me know if you have any comments or suggestions. Also please let me
> know if there are other enhancements that are easily implementable to increase
> TCG performance as part of this project or otherwise.

I think it would be interesting to place TranslationBlock structures into the 
same memory block as code_gen_buffer, immediately before the code that 
implements the TB.

Consider what happens within every TB:

(1) We have one or more references to the TB address, via exit_tb.

For aarch64, this will normally require 2-4 insns.

# alpha-softmmu
0x7f75152114:  d0ffb320      adrp x0, #-0x99a000 (addr 0x7f747b8000)
0x7f75152118:  91004c00      add x0, x0, #0x13 (19)
0x7f7515211c:  17ffffc3      b #-0xf4 (addr 0x7f75152028)

# alpha-linux-user
0x00569500:  d2800260      mov x0, #0x13
0x00569504:  f2b59820      movk x0, #0xacc1, lsl #16
0x00569508:  f2c00fe0      movk x0, #0x7f, lsl #32
0x0056950c:  17ffffdf      b #-0x84 (addr 0x569488)

We would reduce this to one insn, always, if the TB were close by, since the 
ADR instruction has a range of 1MB.


(2) We have zero to two references to a linked TB, via goto_tb.

Your stated goal above for eliminating the code_gen_buffer maximum of 128MB can 
be done in two ways.

(2A) Raise the maximum to 2GB.  For this we would align an instruction pair, 
adrp+add, to compute the address; the following insn would branch.  The update 
code would write a new destination by modifing the adrp+add with a single 
64-bit store.

(2B) Eliminate the maximum altogether by referencing the destination directly 
in the TB.  This is the !USE_DIRECT_JUMP path.  It is normally not used on 
64-bit targets because computing the full 64-bit address of the TB is harder, 
or just as hard, as computing the full 64-bit address of the destination.

However, if the TB is nearby, aarch64 can load the address from 
TB.jmp_target_addr in one insn, with LDR (literal).  This pc-relative load also 
has a 1MB range.

This has the side benefit that it is much quicker to re-link TBs, both in the 
computation of the code for the destination as well as re-flushing the icache.


In addition, I strongly suspect the 1,342,177 entries (153MB) that we currently 
allocate for tcg_ctx.tb_ctx.tbs, given a 512MB code_gen_buffer, is excessive.

If we co-allocate the TB and the code, then we get exactly the right number of 
TBs allocated with no further effort.

There will be some additional memory wastage, since we'll want to keep the code 
and the data in different cache lines and that means padding, but I don't think 
that'll be significant.  Indeed, given the above over-allocation will probably 
still be a net savings.


r~
