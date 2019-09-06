Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9548DC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625432082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcyoOS9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625432082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Fhf-0003t7-JP
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 10:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i6Fgd-0003RH-EA
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i6Fgb-000382-Rt
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:58:07 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:44334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i6Fgb-000357-HC
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:58:05 -0400
Received: by mail-io1-xd42.google.com with SMTP id j4so13322651iog.11
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/Uqdc4bdLj3y17IvEA6hXY3WegviI+ZNTgJNIsnG32M=;
 b=DcyoOS9dN7CPJCfFwE9QKc4nToIAn7WTk/b/nigF2L6eOWmXnI3zdAN9HRfo+q4gGO
 dPw6aGwXXnhiuWRWIbXJRFcQBsbq6lVXGQG79uJyvAFQ0YJdtOqrasirJCgvv6YwZV+c
 TP7Kok+iZCnFHK+wXEXXVkPEJqP4xRemttSnqph/iAUe4/DL8r12eL+M+LuEZvxsHEfE
 sdCyNCjO91T7T4pD9KHIdzy/399m9nUJGCcRkecWU8o2OedOP6dWlD+0QOwoBctAPE+G
 go0YRGMtLtmXaQMnw3lWgSSfty90wJqx1Fwzfhh8nE6b3vpCTXtqFSLj7XDPHuNiECh6
 0W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Uqdc4bdLj3y17IvEA6hXY3WegviI+ZNTgJNIsnG32M=;
 b=JGgtXUCJkgqQQeNc6kk4jbkoN5W7GXg67udXQ7/XoR4ya6VJ2JbfgfUXsI8TxwKVPo
 BX0Vhcg/D4yFIZyCxsEexTNE5PX56GYymq88zW7MheIOvKJWxRauiIZ0U3feN8q+7XMg
 iJQqomnP1GL5/G/SWv0aPrhZSz+1sEPssVhfJ9xAK2BVBgWUn/r1oFKH6kSXyT/BLlj8
 Da+RjIsDXTiLp3B+kVNcYoJcgHiT1gILxDGdBlQelLv5ev/IaiW8y/OHCBtE2D9Uvf/j
 yXgL//DcEvNCVm/fnBt8lI8aGXwvvRJsrycEece25sC/Nf12BMwq2clBlF/zDvwEFZhh
 5iEw==
X-Gm-Message-State: APjAAAWub3jjNlv/0if5As7OC+z9zvhmt03HC4W19PHk3lxwMZ8kkq5P
 Cvi8zR/rxnLPZ7lKrbJIqxptFJKRwHWR/Q==
X-Google-Smtp-Source: APXvYqz7UK+OfPAbF0juxRNcgfda8P/57ZoV+hs+3svQKcCpzSuSZSh8fVcl1492800dc9QBP1eL8w==
X-Received: by 2002:a02:93e5:: with SMTP id z92mr10891747jah.8.1567781883894; 
 Fri, 06 Sep 2019 07:58:03 -0700 (PDT)
Received: from ?IPv6:2607:fea8:a260:81:78cf:74ad:c2b2:73ef?
 ([2607:fea8:a260:81:78cf:74ad:c2b2:73ef])
 by smtp.gmail.com with ESMTPSA id t15sm5019699ioc.68.2019.09.06.07.58.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Sep 2019 07:58:03 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
 <20190903160858.5296-23-richard.henderson@linaro.org>
 <CAFEAcA9g-nyCPafbjmdL6Ka03rEhH3LyZL2aBPqH7UdR36TihA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <61271010-51d0-c711-82da-7a7210db05b5@linaro.org>
Date: Fri, 6 Sep 2019 10:58:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9g-nyCPafbjmdL6Ka03rEhH3LyZL2aBPqH7UdR36TihA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [PATCH 22/36] cputlb: Fold TLB_RECHECK into
 TLB_INVALID_MASK
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 7:02 AM, Peter Maydell wrote:
> On Tue, 3 Sep 2019 at 17:09, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> We had two different mechanisms to force a recheck of the tlb.
>>
>> Before TLB_RECHECK was introduced, we had a PAGE_WRITE_INV bit
>> that would immediate set TLB_INVALID_MASK, which automatically
>> means that a second check of the tlb entry fails.
>>
>> We can use the same mechanism to handle small pages.
>> Conserve TLB_* bits by removing TLB_RECHECK.
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
>> @@ -1265,27 +1269,6 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>>          if ((addr & (size - 1)) != 0) {
>>              goto do_unaligned_access;
>>          }
>> -
>> -        if (tlb_addr & TLB_RECHECK) {
>> -            /*
>> -             * This is a TLB_RECHECK access, where the MMU protection
>> -             * covers a smaller range than a target page, and we must
>> -             * repeat the MMU check here. This tlb_fill() call might
>> -             * longjump out if this access should cause a guest exception.
>> -             */
>> -            tlb_fill(env_cpu(env), addr, size,
>> -                     access_type, mmu_idx, retaddr);
>> -            index = tlb_index(env, mmu_idx, addr);
>> -            entry = tlb_entry(env, mmu_idx, addr);
>> -
>> -            tlb_addr = code_read ? entry->addr_code : entry->addr_read;
>> -            tlb_addr &= ~TLB_RECHECK;
>> -            if (!(tlb_addr & ~TARGET_PAGE_MASK)) {
>> -                /* RAM access */
>> -                goto do_aligned_access;
>> -            }
>> -        }
>> -
>>          return io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
>>                          mmu_idx, addr, retaddr, access_type, op);
>>      }
> 
> In the old version of this code, we do the "tlb fill if TLB_RECHECK
> is set", and then we say "now we've done the refill have we actually
> got RAM", and we avoid calling io_readx() if that is the case.


I don't think that's the case, since,

        if (!victim_tlb_hit(env, mmu_idx, index, tlb_off,
                            addr & TARGET_PAGE_MASK)) {
            tlb_fill(env_cpu(env), addr, size,
                     access_type, mmu_idx, retaddr);
            index = tlb_index(env, mmu_idx, addr);
            entry = tlb_entry(env, mmu_idx, addr);
        }
        tlb_addr = code_read ? entry->addr_code : entry->addr_read;
        tlb_addr &= ~TLB_INVALID_MASK;
    }

the last line here clears INVALID.  The only bits that could remain should be
WATCHPOINT and MMIO.  (NOTDIRTY can only be set for entry->addr_write, not for
addr_read/addr_code.)

And for that matter, once we've processed the watchpoint we remove
TLB_WATCHPOINT as well, so that we only enter io_readx() if MMIO is set.

> This is necessary because io_readx() will misbehave if you try to
> call it on RAM (notably if what we have is notdirty-mem then we
> need to do the read-from-actual-host-ram because the IO ops backing
> notdirty-mem are intended for writes only).
> 
> With this patch applied, we seem to have lost the handling for
> if the tlb_fill in a TLB_RECHECK case gives us back some real RAM.
> (Similarly for store_helper().)

Again, I disagree.  I think there must be some other explanation.

> More generally, I don't really understand why this merging
> is correct -- "TLB needs a recheck" is not the same thing as
> "TLB is invalid" and I don't think we can merge the two
> bits.

"TLB is invalid" means that we cannot use an existing tlb entry, therefore we
must go back to tlb_fill.  "TLB needs a recheck" means we must go back to
tlb_fill -- exactly the same.

The only odd bit about "TLB is invalid" is that it applies to the *next*
lookup.  If we have just returned from tlb_fill, then the tlb entry *must* be
valid.  If it were not valid, then tlb_fill would not return at all.

So, on the paths that use tlb_fill, we clear TLB_INVALID_MASK, indicating that
the lookup has just been done.

Which, honestly, ought to have happened with TLB_RECHECK because it was not
uncommon to perform two tlb_fill in a row -- the first because of a true tlb
miss and the second because the entry supplied by the fill has TLB_RECHECK set.


r~

