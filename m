Received: from eggs.gnu.org ([209.51.188.92]:44705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzOHd-0003kJ-Fk
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzOHb-00082R-AI
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:11:41 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:38626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzOHX-0007zF-AH
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:11:37 -0500
Received: by mail-pg1-x529.google.com with SMTP id m2so9935610pgl.5
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 08:11:31 -0800 (PST)
References: <5F2C0013-1D18-44A9-ADAF-F86EC6FD1174@oberlin.edu>
	<CAFEAcA8VzJRMSThWQ=CgNbB8BY0EAmi77oAJuHQt5iQnkiZmzg@mail.gmail.com>
	<63A30600-CCE3-4412-A3EB-8D535A8B21B3@oberlin.edu>
	<4F8E4327-9F59-4F50-A22D-20A3F939899F@oberlin.edu>
	<9108923c-076b-034c-9d68-af355861ae0c@linaro.org>
	<1FBF59F3-F256-4680-B2AD-199C197814C9@oberlin.edu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <013f91f0-1968-1400-84b2-4d4fe2ece9a6@linaro.org>
Date: Thu, 28 Feb 2019 08:11:26 -0800
MIME-Version: 1.0
In-Reply-To: <1FBF59F3-F256-4680-B2AD-199C197814C9@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] x86 segment limits enforcement with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2/28/19 7:01 AM, Stephen Checkoway wrote:
> I'm very new to this part of the code base. I'm not entirely sure how the
> softmmu translation process works. It looks like each target defines a
> number of MMU_MODES and each memory access TCG instruction (I'm not sure
> what these are called) encodes the MMU mode index. Then, I suppose the code
> generation takes a list of TCG instructions and when generating loads and
> stores, it takes the MMU mode index into account to perform virtual to
> physical translation. I'm not entirely sure where the code that does this
> lives, but is that broadly correct?
Yes.

We call them "tcg opcodes".

The "mmu mode index" indexes into an array of softmmu TLBs, defined in the
CPU_COMMON_TLB macro, in include/exec/cpu-defs.h.  This macro is included
within each CPUArchState (env) structure defined by target/$guest/cpu.h.

The "env pointer" is held in TCG_AREG0 (tcg/$host/tcg-target.h; %rbp for
x86_64), and we generate code to access cached values within that structure.
If we see an address for which we do not have a cached translation, we call
into one of a set of helper functions defined in accel/tcg/cputlb.c.

At the bottom of that set of helper functions, is the function "tlb_fill".
This function is defined somewhere in target/$guest/*.c.  Its job is to take
the virtual address, as presented by the guest instruction, plus the mmu mode
index, plus the operation (read/write/execute), then (1) verify that the
operation is allowed, and raise an exception if not; (2) translate to a
physical address, "page" size, and permissions (r/w/x) for that page.

Importantly, tlb_fill can do completely different things depending on the mmu
mode that is given.  So the existing indexes would continue to interpret flat
virtual addresses to physical addresses for ring3, ring0-smm, and ring0+smm.

>> I would add 6 new MMU_MODES, one for each segment register.  Translation for
>> these modes would proceed in two stages, just like real segmentation+paging.
>> So your access checks happen as a part of normal memory accesses.  (We have an
>> example of two-level translation in target/arm, S1_ptw_translate.)
> 
> So to take an example, movs es:[edi], ds:[esi] would generate a load using
> the DS MMU mode and a store using the ES MMU mode. Currently, a single mode
> appears to be used for all memory accesses and this mode is set in the
> initializer for the disassembly context, i386_tr_init_disas_context.
Correct.

> Are you thinking that this should be modeled as independent sets of TLBs, one per mode?

One per segment you mean?  Yes, exactly.  Since each segment can have
independent segment base + limit + permissions.  All of which would be taken
into account by tlb_fill when populating the TLB.

> It seems easier to have a linear address MMU mode and then for the MMU modes
> corresponding to segment registers, perform an access and limit check,
> adjust the address by the segment base, and then go through the linear
> address MMU mode translation.
Except you need to generate extra calls at runtime to perform this translation,
and you are not able to cache the result of the lookup against a second access
to the same page.

> In particular, code that uses segments spends a lot of time changing the
> values of segment registers. E.g., in the movs example above, the ds segment
> may be overridden but the es segment cannot be, so to use the string move
> instructions within ds, es needs to be saved, modified, and then restored.
You are correct that this would result in two TLB flushes.

But if MOVS executes a non-trivial number of iterations, we still may win.

The work that Emilio Cota has done in this development cycle to make the size
of the softmmu TLBs dynamic will help here.  It may well be that MOVS is used
with small memcpy, and there are a fair few flushes.  But in that case the TLB
will be kept very small, and so the flush will not be expensive.

On the other hand, DS changes are rare (depending on the programming model),
and SS changes only on context switches.  Their TLBs will keep their contents,
even while ES gets flushed.  Work has been saved over adding explicit calls to
a linear address helper function.

> Modifying HF_ADDSEG_MASK to mean not just the base, but also the limit makes
> a lot of sense. I don't know what happens when these hidden flags get
> modified though. If a basic block is translated with ADDSEG not set, then a
> segment register is changed such that ADDSEG becomes set, will the
> previously translated basic block be retranslated in light of this change? I
> hope so, but I'm not sure how/where this happens.
cpu_get_tb_cpu_state returns 3 values (pc, cs_base, flags) to
tb_lookup__cpu_state (in include/exec/tb-lookup.h).

These values are used as the key to a hash table to find a previously compiled
TranslationBlock that we want to execute.  If a bit in flags changes, a TB
without that bit will not match, which may lead to retranslation.

We can, of course, hold *both* translations, with and without bit X set in
flags, in the hash table at the same time, so any one execution may or may not
lead to actual retranslation.

BTW, while the name cs_base is in fact tied to its original (and current) usage
within target/i386/, it can be thought of as a second pointer-sized
target-specific value.  E.g. for target/sparc, to implement delay slots,
cs_base holds next_pc.  For target/hppa, cs_base holds the space register plus
an offset to next_pc.

> Not having to adjust every single memory access in i386/translate.c would be
> fantastic. But I don't see a lot of great options for implementing this that
> doesn't require changing them all. Each memory access needs to know what
> segment register* (and thus which MMU mode) to use. So either every access
> needs to be adjusted to explicitly use the appropriate mode—taking overrides
> into account—or the lea functions need to set the appropriate mode for a
> subsequent access to use. The latter option means that there's an implicit
> dependency in the order of operations.
The vast majority of x86 instructions have exactly one memory access, and it
uses the default segment (ds/ss) or the segment override.  We can set this
default mmu index as soon as we have seen any segment override.

> Returning to the movs example, the order of operations _must_ be
> 1. lea ds:[esi]
> 2. load 4 bytes
> 3. lea es:[edi]
> 4. store 4 bytes

MOVS is one of the rare examples of two memory accesses within one instruction.
 Yes, we would have to special case this, and be careful to get everything right.

> This approach seems pretty brittle and errors are likely going to be difficult to catch.

Because of the rarity of dual memory accesses, I do not think it will be that
brittle.

> Finally, I think there's an issue with this approach when trying to store
> more than 4 or 8 bytes of data in a single operation. On a 32-bit host, MOVQ
> (the MMX instruction) is going to store 64-bits of data. If this store
> happens starting 4 bytes before the end of the segment, I believe this
> should either case #GP(0) or #SS(0), depending on the segment. But if the
> 64-bit store is broken into two 32-bit stores, the first may succeed and the
> second fail, leading to an inconsistent state. Do you have any thoughts on
> how this should be handled?

For those specific examples, the correct solution is to use a 64-bit store,
even with a 32-bit host.  The access will be seen by accel/tcg/cputlb.c as one
64-bit operation, and will raise the appropriate exception before actually
performing the host-level store (which will be done by gcc, probably with two
32-bit insns).

We do have an existing issue with larger stores, for vectors and such.  This
really needs to be handled more generally within accel/tcg/cputlb.c.
Unfortunately, the easiest way for me to do this is to completely drop support
for 32-bit hosts, and there's some resistance to that.  I'm not sure how to
approach this problem in a way that allows 32-bit hosts, so I've done nothing
so far.

We do have a helper function, probe_write, which will check to see if the whole
of a write operation would succeed, and raise an exception if not.  This is
currently only used in specific situations within one or two targets.  It is
not, IMO, a good replacement for incorporating proper support for 16-byte and
32-byte memory operations into accel/tcg/.


r~
