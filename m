Received: from eggs.gnu.org ([2001:4830:134:3::10]:55166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gGaqr-00050T-5Z
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 22:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gGaqo-0006Py-0x
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 22:30:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gGaqn-0006PP-CM
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 22:30:49 -0400
Received: by mail-wm1-x342.google.com with SMTP id h2-v6so1053786wmb.0
	for <qemu-devel@nongnu.org>; Sat, 27 Oct 2018 19:30:48 -0700 (PDT)
References: <20181023070253.6407-1-richard.henderson@linaro.org>
	<20181023070253.6407-6-richard.henderson@linaro.org>
	<20181027001652.GA12509@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <581bbe04-c0b5-fb55-ce96-f2378dd38968@linaro.org>
Date: Sun, 28 Oct 2018 02:30:44 +0000
MIME-Version: 1.0
In-Reply-To: <20181027001652.GA12509@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/10] cputlb: Split large page tracking
 per mmu_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 10/27/18 1:16 AM, Emilio G. Cota wrote:
> On Tue, Oct 23, 2018 at 08:02:47 +0100, Richard Henderson wrote:
>> +static void tlb_flush_page_locked(CPUArchState *env, int midx,
>> +                                  target_ulong addr)
>> +{
>> +    target_ulong lp_addr = env->tlb_d[midx].large_page_addr;
>> +    target_ulong lp_mask = env->tlb_d[midx].large_page_mask;
>> +
>> +    /* Check if we need to flush due to large pages.  */
>> +    if ((addr & lp_mask) == lp_addr) {
>> +        tlb_debug("forcing full flush midx %d ("
>> +                  TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
>> +                  midx, lp_addr, lp_mask);
>> +        tlb_flush_one_mmuidx_locked(env, midx);
>> +    } else {
>> +        int pidx = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
>> +        tlb_flush_entry_locked(&env->tlb_table[midx][pidx], addr);
>> +        tlb_flush_vtlb_page_locked(env, midx, addr);
> 
> Just noticed that we should use tlb_entry here, e.g.:
> 
>      } else {
> -        int pidx = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -        tlb_flush_entry_locked(&env->tlb_table[midx][pidx], addr);
> +        CPUTLBEntry *entry = tlb_entry(env, midx, addr);
> +
> +        tlb_flush_entry_locked(entry, addr);
>          tlb_flush_vtlb_page_locked(env, midx, addr);
>      }

Fixed, thanks.

r~
