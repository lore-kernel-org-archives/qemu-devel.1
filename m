Received: from eggs.gnu.org ([2001:4830:134:3::10]:35865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZwDm-0004w6-9c
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZwDl-0004ov-EP
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:38:14 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZwDl-0004oh-5f
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:38:13 -0400
Received: by mail-oi0-x243.google.com with SMTP id 13-v6so3028976ois.1
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 03:38:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629213703.13833-1-richard.henderson@linaro.org>
References: <20180629213703.13833-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 11:37:52 +0100
Message-ID: <CAFEAcA8La4xrHxJpRGnmO1uDj34-igu1A+O6AJNyf=6L3FG8Mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] accel/tcg: Avoid caching overwritten tlb
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>

On 29 June 2018 at 22:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
> When installing a TLB entry, remove any cached version of the
> same page in the VTLB.  If the existing TLB entry matches, do
> not copy into the VTLB, but overwrite it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> This may fix some problems with Q800 that Laurent reported.
>
> On IRC, Peter suggested that regardless of the m68k ptest insn, we
> need to be more careful with installed TLB entries.
>
> I added some temporary logging and concur.  This sort of overwrite
> happens often when writable pages are marked read-only in order to
> track a dirty bit.  After the dirty bit is set, we re-install the
> TLB entry as read-write.
>
> I'm mildly surprised we haven't run into problems before...
>
>
> r~
>
> ---
>  accel/tcg/cputlb.c | 60 +++++++++++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 27 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index cc90a5fe92..250b024c5d 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -235,17 +235,30 @@ void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
>      async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
>  }
>
> -
> -
> -static inline void tlb_flush_entry(CPUTLBEntry *tlb_entry, target_ulong addr)
> +static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry,
> +                                        target_ulong page)
>  {
> -    if (tlb_hit_page(tlb_entry->addr_read, addr) ||
> -        tlb_hit_page(tlb_entry->addr_write, addr) ||
> -        tlb_hit_page(tlb_entry->addr_code, addr)) {
> +    return (tlb_hit_page(tlb_entry->addr_read, page) ||
> +            tlb_hit_page(tlb_entry->addr_write, page) ||
> +            tlb_hit_page(tlb_entry->addr_code, page));

Checkpatch warns that the outer brackets here are not required.


> +    /* If the old entry matches the new page, just overwrite TE.  */
> +    if (!tlb_hit_page_anyprot(te, vaddr_page)) {

I found it slightly confusing that the sense of the "if" in
the comment is backwards from the "if" in the code.
Maybe
   /*
    * Only evict the old entry to the victim tlb if it's for a
    * different page; otherwise just overwrite the stale data.
    */
?

(I was only slightly confused, though, so I don't feel very
strongly here.)

> +        unsigned vidx = env->vtlb_index++ % CPU_VTLB_SIZE;
> +        CPUTLBEntry *tv = &env->tlb_v_table[mmu_idx][vidx];
>
> -    env->iotlb_v[mmu_idx][vidx] = env->iotlb[mmu_idx][index];
> +        /* Evict the old entry into the victim tlb.  */
> +        copy_tlb_helper(tv, te, true);
> +        env->iotlb_v[mmu_idx][vidx] = env->iotlb[mmu_idx][index];
> +    }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
