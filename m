Received: from eggs.gnu.org ([2001:4830:134:3::10]:53700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gSVCy-0002qC-Fh
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 17:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gSVCu-0001EN-0s
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 17:54:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:39102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benh@kernel.crashing.org>)
	id 1gSVCs-0001DX-SA
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 17:54:51 -0500
Message-ID: <408ef3b1c0bab7d26cffeb366a5ee87bb8448fa4.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Nov 2018 09:54:34 +1100
In-Reply-To: <a9dd602b-9eb1-f57a-ef21-31f08fc18729@linaro.org>
References: <f4349b9ee95cbd9d5b16e9033fdf0d7c9e99aebf.camel@kernel.crashing.org>
	<a9dd602b-9eb1-f57a-ef21-31f08fc18729@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC/PATCH] i386: Atomically update PTEs with mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On Thu, 2018-11-29 at 11:04 -0800, Richard Henderson wrote:
> On 11/28/18 3:15 PM, Benjamin Herrenschmidt wrote:
> > +static inline uint64_t update_entry(CPUState *cs, target_ulong addr,
> > +                                    uint64_t orig_entry, uint32_t bits)
> > +{
> > +    uint64_t new_entry = orig_entry | bits;
> > +
> > +    /* Write the updated bottom 32-bits */
> > +    if (qemu_tcg_mttcg_enabled()) {
> > +        uint32_t old_le = cpu_to_le32(orig_entry);
> > +        uint32_t new_le = cpu_to_le32(new_entry);
> > +        MemTxResult result;
> > +        uint32_t old_ret;
> > +
> > +        old_ret = address_space_cmpxchgl_notdirty(cs->as, addr,
> > +                                                  old_le, new_le,
> > +                                                  MEMTXATTRS_UNSPECIFIED,
> > +                                                  &result);
> > +        if (result == MEMTX_OK) {
> > +            if (old_ret != old_le) {
> > +                new_entry = 0;
> > +            }
> > +            return new_entry;
> > +        }
> > +
> > +        /* Do we need to support this case where PTEs aren't in RAM ?
> > +         *
> > +         * For now fallback to non-atomic case
> > +         */
> > +    }
> > +
> > +    x86_stl_phys_notdirty(cs, addr, new_entry);
> > +
> > +    return new_entry;
> > +}
> 
> While I know the existing code just updates the low 32-bits, I'd rather update
> the whole entry, and make use of the old value returned from the cmpxchg.

Not all PTEs on x86 ae 64-bits, the old 32-bit format still exists, so
we'd have to create two helpers. Not a big deal mind you. I'm already
creating a second address_space_cmpxchgq_notdirty for use by powerpc

> static bool update_entry(CPUState *cs, target_ulong addr,
>                          uint64_t *entry, uint32_t bits)
> {
>     uint64_t old_entry = *entry;
>     uint64_t new_entry = old_entry | bits;
> 
>     if (qemu_tcg_mttcg_enabled()) {
>         uint64_t cmp_le = cpu_to_le64(old_entry);
>         uint64_t new_le = cpu_to_le64(new_entry);
>         uint64_t old_le;
>         MemTxResult result;
> 
>         old_le = address_space_cmpxchgl_notdirty(cs->as, addr,
>                                                  cmp_le, new_le,
>                                                  MEMTXATTRS_UNSPECIFIED,
>                                                  &result);
>         if (result == MEMTX_OK) {
>             if (old_le == cmp_le) {
>                 return true;
>             } else {
>                 *entry = le_to_cpu64(old_le);
>                 return false;
>             }
>         }
>     }
>     x86_stq_phys_notdirty(cs, addr, new_entry);
>     return true;
> }


> ....
> 
>     pdpe_addr = (pml4e & PG_ADDRESS_MASK) +
>                 (((gphys >> 30) & 0x1ff) << 3);
>     pdpe = x86_ldq_phys(cs, pdpe_addr);
>     do {
>         if (!(pdpe & PG_PRESENT_MASK)) {
>             goto do_fault;
>         }
>         if (pdpe & rsvd_mask) {
>             goto do_fault_rsvd;
>         }
>         if (pdpe & PG_ACCESSED_MASK) {
>             break;
>         }
>     } while (!update_entry(cs, pdpe_addr, &pdpe, PG_ACCESSED_MASK));
>     ptep &= pdpe ^ PG_NX_MASK;
> 
> ....

Hrm.. I see. So not re-do the full walk. Not sure it's really worth it
though, how often do we expect to hit the failing case ?

> 
> Although I think it would be really great if we could figure out something that
> allows us to promote this whole load/cmpxchg loop into a primitive that avoids
> multiple translations of the address.
> 
> No, I don't know what that primitive would look like.  :-)

You mean translating once for the load and for the udpate ? Do you
expect that translation to have such a significant cost considering
that all it needs should be in L1 at that point ?

There are subtle differences in what happens between the load and the
update, and we hope for the update to be fairly rare (even though it's
done by HW it's costly even on actual chips).

So best way I could think of would be to use a macro, so we can open-
code the statements that test/manipulate the value.

Not sure I'll get to it today though, I'm off early this afternoon for
the week-end.

Cheers,
Ben.
> 
> r~
