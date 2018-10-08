Received: from eggs.gnu.org ([2001:4830:134:3::10]:46603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9Kdt-0004Ch-Hw
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9Kdq-0001bt-2w
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:47:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9Kdp-0001Zs-8a
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:47:25 -0400
Received: by mail-pg1-x541.google.com with SMTP id c10-v6so7088178pgq.4
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 18:47:24 -0700 (PDT)
References: <20181006214508.5331-1-cota@braap.org>
	<20181006214508.5331-2-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7f7ef8fd-a6dd-88d9-6219-1aabdadd8582@linaro.org>
Date: Sun, 7 Oct 2018 18:47:20 -0700
MIME-Version: 1.0
In-Reply-To: <20181006214508.5331-2-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/6] (XXX) cputlb: separate MMU allocation +
 run-time sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/6/18 2:45 PM, Emilio G. Cota wrote:
> -#define CPU_COMMON_TLB \
> +typedef struct CPUTLBDesc {
> +    size_t size;
> +    size_t mask; /* (.size - 1) << CPU_TLB_ENTRY_BITS for TLB fast path */
> +} CPUTLBDesc;

I think you don't need both size and mask.  Size is (or ought to be) used
infrequently enough that I think it can be computed on demand.  But on a
related note, if you remember the out-of-line tlb changes, it'll be easier for
x86 if you index an array of scalars.


> -    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> +    int index = (addr >> TARGET_PAGE_BITS) & (env->tlb_desc[mmu_idx].size - 1);

I just posted a patch to functionalize this.  But I imagine

static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
                                  target_ulong addr)
{
    uintptr_t ofs = (addr >> TARGET_PAGE_BITS) & env->tlb_mask[mmu_idx];
    return ofs >> CPU_TLB_BITS;
}

static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
                                     target_ulong addr)
{
    uintptr_t ofs = (addr >> TARGET_PAGE_BITS) & env->tlb_mask[mmu_idx];
    return (void *)&env->tlb_table[mmu_idx][0] + ofs;
}

In the few places where we use both of these functions, the compiler ought to
be able to pull out the common sub-expression.


> @@ -139,7 +149,10 @@ static void tlb_flush_nocheck(CPUState *cpu)
>       * that do not hold the lock are performed by the same owner thread.
>       */
>      qemu_spin_lock(&env->tlb_lock);
> -    memset(env->tlb_table, -1, sizeof(env->tlb_table));
> +    for (i = 0; i < NB_MMU_MODES; i++) {
> +        memset(env->tlb_table[i], -1,
> +               env->tlb_desc[i].size * sizeof(CPUTLBEntry));

Here we can use something like

static inline uintptr_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
{
    return env->tlb_mask[mmu_idx] + (1 << CPU_TLB_BITS);
}

memset(env->tlb_table[i], -1, sizeof_tlb(env, i));

> -        for (i = 0; i < CPU_TLB_SIZE; i++) {
> +        for (i = 0; i < env->tlb_desc[mmu_idx].size; i++) {

This seems to be one of the few places where you need the number of entries
rather than the size.  Perhaps

   for (i = sizeof_tlb(env, mmu_idx) >> CPU_TLB_BITS; i-- > 0; ) {

Or if you can think of a name for the function of the same effect...


r~
