Received: from eggs.gnu.org ([2001:4830:134:3::10]:44627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ee9vF-0007b7-IT
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 20:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ee9up-0002nu-4V
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 20:32:17 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:35257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ee9uo-0002lg-Id
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 20:31:50 -0500
Received: by mail-ot0-x236.google.com with SMTP id 53so2233303otj.2
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 17:31:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <318eed49-c986-897a-0e4d-59e0946d11ad@linaro.org>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-7-git-send-email-mjc@sifive.com>
	<f15753f1-7446-26f1-9937-f3b67d15c0a6@linaro.org>
	<CAHNT7Nu-6WvTZyit-xU_bNS6bLKRay3_9e9YtYFmG5tmqr0RXA@mail.gmail.com>
	<318eed49-c986-897a-0e4d-59e0946d11ad@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 23 Jan 2018 17:31:49 -0800
Message-ID: <CAHNT7NtOTXSK9Httz=1+mZ5JRx2UP3q0tHH5hDpF22aJkHR54w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 06/21] RISC-V FPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>, Stefan O'Rear <sorear2@gmail.com>

On Tue, Jan 23, 2018 at 4:01 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 01/23/2018 01:37 PM, Michael Clark wrote:
> >
> >
> > On Wed, Jan 3, 2018 at 12:10 PM, Richard Henderson
> > <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>>
> wrote:
> >
> >     On 01/02/2018 04:44 PM, Michael Clark wrote:
> >     > +/* convert RISC-V rounding mode to IEEE library numbers */
> >     > +unsigned int ieee_rm[] = {
> >
> >     static const.
> >
> >
> > Done.
> >
> >     > +/* obtain rm value to use in computation
> >     > + * as the last step, convert rm codes to what the softfloat
> library expects
> >     > + * Adapted from Spike's decode.h:RM
> >     > + */
> >     > +#define RM ({                                             \
> >     > +if (rm == 7) {                                            \
> >     > +    rm = env->frm;                               \
> >     > +}                                                         \
> >     > +if (rm > 4) {                                             \
> >     > +    helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST); \
> >     > +}                                                         \
> >     > +ieee_rm[rm]; })
> >
> >     Please use inline functions and not these macros.
> >
> >
> > Done.
> >
> > In fact the previous code would, with normal control flow, dereference
> > ieee_rm[rm] with an out of bounds round mode so assuming
> helper_raise_exception
> > does a longjmp, i've inserted g_assert_not_reached() after the
> exception. An
> > analyser could detect that ieee_rm has an out of bounds access assuming
> normal
> > control flow. e.g.
> >
> > static inline void set_fp_round_mode(CPURISCVState *env, uint64_t rm)
> > {
> >     if (rm == 7) {
> >         rm = env->frm;
> >     } else if (rm > 4) {
> >         helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
> >         g_assert_not_reached();
>
> Yes, raise_exception exits via longjmp.  This is a good change.
>
> > Are translations not implicitly indexed by cpu_mmu_index? i.e. do we
> also need
> > to add cpu_mmu_index to cpu_get_tb_cpu_state flags to prevent code
> translated
> > for one value of mmu_index running in code with another value of
> mmu_index (in
> > the case of riscv, we currently return processor mode / privilege level
> in
> > cpu_mmu_index).
>
> No, there is no implicit indexing.  That's why I've mentioned exactly this
> at
> least twice in review so far.
>
> There are two ways to do this correctly.  One is to add all the bits that
> specify processor state (e.g. Alpha stores pal_code bit and supervisor
> bit).
> Another is to actually encode the mmu_idx into the flags (e.g. ARM).


I reviewed Stefan's patches. Stefan has some code that encoded processor
flags in mmu_index however it removed some well-tested code paths and I was
hesitant to make such a large change to get_physical_address at this point
in time. I read Stefan's code and used some fragments from it but was
relatively cautious with regard to changing relatively well tested code
paths. I tried to make the most minimal change for the sake of correctness.

For the meantime we've greatly simplified cpu_mmu_index to just return the
processor mode as well as adding the processor mode to cpu_get_tb_cpu_state
flags. cpu_mmu_index previously returned a permutation of env->priv
(containing processer mode), mstatus.MPP (previous mode) and mstatus.MPRV.
When MPRV is set, M mode loads and stores operate as per the mode in
mstatus.MPP and the previous cpu_mmu_index function returned the mode the
processor should do loads and stores as, not the current mode. This is
problematic as mstatus.MPRV can be altered from user code via register
values so there was a potential to re-enter a pre-existing trace with a
different mmu_index. I believe we have eliminated that issue.

These two changes should fix the issue and we've performed testing with
these patches:

-
https://github.com/michaeljclark/riscv-qemu/commit/82012aef90e5c4500f926523b3b2ff621b0cd512
-
https://github.com/michaeljclark/riscv-qemu/commit/abdb897a4a607d00cfce577ac37ca6119004658f

There is a possibility to further improve this code and potentially avoid
TLB flushes, by encoding more state in cpu_mmu_index
and cpu_get_tb_cpu_state flags. I would say that mstatus.SUM flag is
altered frequently in Linux's copy_to/from_user and is likely to result in
decent performance improvement if we can eliminate the TLB flush when the
SUM bit is changed (it is in concept similar to SMAP on x86). mstatus.MPRV
is used by the monitor for handling misaligned loads and stores which
should be relatively rare (the occasional use of structs with
__attribute__((packed))). Eliminating the tlb_flush on mstatus.SUM changes
likely will have the most positive performance impact

We have increased performance somewhat already (~2.5X faster on dd
if=/dev/zero of=/dev/null bs=1 count=100000). We eliminated a tlb_flush on
privilege level changes as this is included (now solely) in cpu_mmu_index,
and any helper that changes privilege level terminates translation so
mmu_index should now always be consistent. Possibly not quite as fast as
Stefan's original patch but an improvement nevertheless. The changes are
somewhat smaller.

The code is in a state where the mmu_index invariant is now very easy to
reason about. Any helper that changes mstatus or priv level terminates
traces [1] and cpu_mmu_index is included in cpu_get_tb_cpu_state flags.
Stefan may very well propose some incremental changes to eliminate some
more TLB flushes.

[1]
https://github.com/riscv/riscv-qemu/blob/ef7332fc693d386f572169b4011a84cfc5c02ac0/target/riscv/translate.c#L1420

During the process, we also found some bugs in the accessed/dirty bit
handling in get_physical_address. i.e. when the accessed/dirty bits don't
change, we now elide the store. This allows various use cases such as PTE
entries in ROM. We coalesced some of the flag
setting in get_physical_address based on Stefan's patch
(PAGE_READ+PAGE_EXEC) which likely reduces the number of TLB misses, but we
don't set PAGE_WRITE unless the access_type is MMU_DATA_STORE. The previous
code would only set the TLB prot flag for the specific access type. We set
PAGE_READ+PAGE_EXEC based on the PTE flags for load and fetch but we don't
set PAGE_WRITE on loads or fetches because we want a TLB miss for
subsequent stores so we don't miss updating the dirty bit if the first
access on a RW page is a load or fetch. I saw code in i386 that does
essentially the same thing.

We still need to make PTE updates atomic but given we only have multiplexed
SMP, it should not be too much of an issue right now.
