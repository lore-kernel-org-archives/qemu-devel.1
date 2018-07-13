Received: from eggs.gnu.org ([2001:4830:134:3::10]:34166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdxJ9-0002G1-A7
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdxJ4-0002bS-DJ
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:36:23 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:36639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fdxJ4-0002Zw-6z
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:36:18 -0400
Received: by mail-oi0-x22e.google.com with SMTP id r16-v6so61951477oie.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 05:36:18 -0700 (PDT)
References: <20180702160546.31969-1-richard.henderson@linaro.org>
	<20180702160546.31969-5-richard.henderson@linaro.org>
	<CAFEAcA8qtHmWt9Zhnhqcc6J-hgbxucq-gU1V5=uZa727kqKSvg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8a05e6cb-dd76-58c4-8069-956b3e95161d@linaro.org>
Date: Fri, 13 Jul 2018 07:36:12 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8qtHmWt9Zhnhqcc6J-hgbxucq-gU1V5=uZa727kqKSvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 4/6] accel/tcg: Don't treat invalid TLB
 entries as needing recheck
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 07/13/2018 06:05 AM, Peter Maydell wrote:
>> -    if (unlikely(env->tlb_table[mmu_idx][index].addr_code & TLB_RECHECK)) {
>> +    if (unlikely((env->tlb_table[mmu_idx][index].addr_code &
>> +                  (TLB_RECHECK | TLB_INVALID_MASK)) == TLB_RECHECK)) {
>>          /*
>>           * This is a TLB_RECHECK access, where the MMU protection
>>           * covers a smaller range than a target page, and we must
> 
> Looking again at this code, I think that now we have the code to
> ensure that there's only ever one entry in the TLB/victim TLB for
> a given guest address...

Which probably wasn't the case the first time you wrote this, no?
Fixing that single entry condition was just a few weeks ago.


> The sequence
> 
>     if (unlikely(!tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr))) {
>         if (!VICTIM_TLB_HIT(addr_read, addr)) {
>             tlb_fill(ENV_GET_CPU(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
>         }
>     }
> 
> should result in us always either (a) taking a guest exception and
> longjumping out of the tlb_fill(), or (b) ending up with the TLB
> containing an entry valid for an insn fetch, ie addr_code does not
> have TLB_INVALID_MASK set. So we could drop the check on TLB_INVALID_MASK
> here and instead have:
> 
>     assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));

Tuck that assert just after the tlb_fill, if you like.
I think it's unnecessary; we don't do that any of the
other places we use tlb_fill.


r~
