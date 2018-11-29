Received: from eggs.gnu.org ([2001:4830:134:3::10]:50122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSRcG-0005Rt-0D
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSRcB-000347-Ou
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:04:47 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSRcB-00033d-7k
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:04:43 -0500
Received: by mail-pf1-x443.google.com with SMTP id g62so1474910pfd.12
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 11:04:42 -0800 (PST)
References: <f4349b9ee95cbd9d5b16e9033fdf0d7c9e99aebf.camel@kernel.crashing.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a9dd602b-9eb1-f57a-ef21-31f08fc18729@linaro.org>
Date: Thu, 29 Nov 2018 11:04:38 -0800
MIME-Version: 1.0
In-Reply-To: <f4349b9ee95cbd9d5b16e9033fdf0d7c9e99aebf.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 11/28/18 3:15 PM, Benjamin Herrenschmidt wrote:
> +static inline uint64_t update_entry(CPUState *cs, target_ulong addr,
> +                                    uint64_t orig_entry, uint32_t bits)
> +{
> +    uint64_t new_entry = orig_entry | bits;
> +
> +    /* Write the updated bottom 32-bits */
> +    if (qemu_tcg_mttcg_enabled()) {
> +        uint32_t old_le = cpu_to_le32(orig_entry);
> +        uint32_t new_le = cpu_to_le32(new_entry);
> +        MemTxResult result;
> +        uint32_t old_ret;
> +
> +        old_ret = address_space_cmpxchgl_notdirty(cs->as, addr,
> +                                                  old_le, new_le,
> +                                                  MEMTXATTRS_UNSPECIFIED,
> +                                                  &result);
> +        if (result == MEMTX_OK) {
> +            if (old_ret != old_le) {
> +                new_entry = 0;
> +            }
> +            return new_entry;
> +        }
> +
> +        /* Do we need to support this case where PTEs aren't in RAM ?
> +         *
> +         * For now fallback to non-atomic case
> +         */
> +    }
> +
> +    x86_stl_phys_notdirty(cs, addr, new_entry);
> +
> +    return new_entry;
> +}

While I know the existing code just updates the low 32-bits, I'd rather update
the whole entry, and make use of the old value returned from the cmpxchg.

E.g.

static bool update_entry(CPUState *cs, target_ulong addr,
                         uint64_t *entry, uint32_t bits)
{
    uint64_t old_entry = *entry;
    uint64_t new_entry = old_entry | bits;

    if (qemu_tcg_mttcg_enabled()) {
        uint64_t cmp_le = cpu_to_le64(old_entry);
        uint64_t new_le = cpu_to_le64(new_entry);
        uint64_t old_le;
        MemTxResult result;

        old_le = address_space_cmpxchgl_notdirty(cs->as, addr,
                                                 cmp_le, new_le,
                                                 MEMTXATTRS_UNSPECIFIED,
                                                 &result);
        if (result == MEMTX_OK) {
            if (old_le == cmp_le) {
                return true;
            } else {
                *entry = le_to_cpu64(old_le);
                return false;
            }
        }
    }
    x86_stq_phys_notdirty(cs, addr, new_entry);
    return true;
}

....

    pdpe_addr = (pml4e & PG_ADDRESS_MASK) +
                (((gphys >> 30) & 0x1ff) << 3);
    pdpe = x86_ldq_phys(cs, pdpe_addr);
    do {
        if (!(pdpe & PG_PRESENT_MASK)) {
            goto do_fault;
        }
        if (pdpe & rsvd_mask) {
            goto do_fault_rsvd;
        }
        if (pdpe & PG_ACCESSED_MASK) {
            break;
        }
    } while (!update_entry(cs, pdpe_addr, &pdpe, PG_ACCESSED_MASK));
    ptep &= pdpe ^ PG_NX_MASK;

....

Although I think it would be really great if we could figure out something that
allows us to promote this whole load/cmpxchg loop into a primitive that avoids
multiple translations of the address.

No, I don't know what that primitive would look like.  :-)


r~
