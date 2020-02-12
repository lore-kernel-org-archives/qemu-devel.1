Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6710C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECD120848
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4oIIKfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECD120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j20dX-00054T-K8
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 17:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j20cy-0004Vn-0C
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j20cw-0005xF-Mg
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:37:03 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j20cw-0005wc-Dn
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:37:02 -0500
Received: by mail-pj1-x1042.google.com with SMTP id e9so1495855pjr.4
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 14:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7RomneQjE1BDZHcQ1b+trUZ64+juggZ5CxifJHgKC34=;
 b=S4oIIKfk5KzJpLxhqC5CdiBkoNrzOHRBsWT3usl8Dm0AFGD7ElOMMy6X/KH36XVpFm
 7rSf7Ds31RzjkX7gpdLHHnVt5d/QFF5a8NaPzJAQaK894tyOStw7EkBHSpo7iKPRhUk2
 pNCM8JPvNsq3orRZvbYF3lvAsB1+18onhwCCr0Uyuzh5BlkgdONlxQvhNzxUd8CDUU+I
 O+/wut/8h8Z1FaFZilPm+/lgAWMnN4Kgz1j15TAbmILoLoFexqIjyz5fN9zryZ2s7b5z
 8OOpPvc8064gjfSBlHURT3FLlmTNoQp/XGPV2ShAR+9mlCihnq5+XR5ld7YTHnhIW2Tx
 Vmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7RomneQjE1BDZHcQ1b+trUZ64+juggZ5CxifJHgKC34=;
 b=YFQGvmVghhh762QxGhkzzzc0cUlgoM9whflLf18ggtBo1Spy1tEEKJBDCHGib9hhAp
 hfAo/Qgfm+ufwlJ2BnqGTWN6XfSUI6w/vm+L8W0P3fCQOTCZhjDmL51KOZ+w9GZg5fCz
 y+ODlOPJzBkjC6qvSHrZ2kvTqjKLuLJkwfZjcRJAq3O/UNLbIISCua28UiLD7u7F0MZs
 HmWe/vNgI7CZeDSrILFhsQpVyv5hKtGEXBvQiwgtcsdEPaUC+MTTTj9PPansIrvTOdSu
 uhlXSR+CxA/8ca1sPwARWqWki+6CQ9Rx10AyiB7Rva/EWHR73XTVBYK/w5vq7wFuFo36
 NWxQ==
X-Gm-Message-State: APjAAAW2nhDK3EHr0GT3yG0U5zPYmiL0xoxedvUvxtLjCiYd0WcOBu9j
 qSwHEBAOaXIenewXWujOhSin3Q==
X-Google-Smtp-Source: APXvYqxVNsRaoYrcKa0Fr0qb62323nPrDlFnl9CT6CVJPoLliyghkkGILQaQxH0GqL/Dhk+9dYwe0A==
X-Received: by 2002:a17:90a:c390:: with SMTP id
 h16mr1465066pjt.131.1581547021013; 
 Wed, 12 Feb 2020 14:37:01 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 t28sm254365pfq.122.2020.02.12.14.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 14:37:00 -0800 (PST)
Subject: Re: [PULL 34/35] target/ppc: Use probe_write for DCBZ
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
 <20200203061123.59150-35-david@gibson.dropbear.id.au>
 <20200212194825.18da5290@bahia.lan>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5b92b6e2-2bb9-2234-7cf3-0487d82fbf7c@linaro.org>
Date: Wed, 12 Feb 2020 14:36:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212194825.18da5290@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 10:48 AM, Greg Kurz wrote:
> On Mon,  3 Feb 2020 17:11:22 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
>> From: Richard Henderson <richard.henderson@linaro.org>
>>
>> Using probe_write instead of tlb_vaddr_to_host means that we
>> process watchpoints and notdirty pages more efficiently.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-Id: <20200129235040.24022-5-richard.henderson@linaro.org>
>> Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  target/ppc/mem_helper.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
>> index 0cb78777e7..98f589552b 100644
>> --- a/target/ppc/mem_helper.c
>> +++ b/target/ppc/mem_helper.c
>> @@ -298,7 +298,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
>>      }
>>  
>>      /* Try fast path translate */
>> -    haddr = tlb_vaddr_to_host(env, addr, MMU_DATA_STORE, mmu_idx);
>> +    haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
> 
> Hi Richard,
> 
> This one is making coverity unhappy.
> 
> 
> ** CID 1419390:  Memory - corruptions  (OVERRUN)
> 
> 
> ______________________________________________________________________________________________________
> *** CID 1419390:  Memory - corruptions  (OVERRUN)
> /target/ppc/mem_helper.c: 301 in dcbz_common()
> 295         /* Check reservation */
> 296         if ((env->reserve_addr & mask) == addr)  {
> 297             env->reserve_addr = (target_ulong)-1ULL;
> 298         }
> 299     
> 300         /* Try fast path translate */
>>>>     CID 1419390:  Memory - corruptions  (OVERRUN)
>>>>     Overrunning callee's array of size 9 by passing argument "mmu_idx" (which evaluates to 9) in call to "probe_write".  
> 301         haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
> 302         if (haddr) {
> 303             memset(haddr, 0, dcbz_size);
> 304         } else {
> 305             /* Slow path */
> 306             for (i = 0; i < dcbz_size; i += 8) {
> 
> 
> Can you have a look ?

That's a bit of a mystery, given

#define NB_MMU_MODES 10

So I wonder what array is supposed to be of size 9...

Ho hum.  False positive.  Expanding everything in the coverity gui shows it's
taking the definition from target/xtensa/cpu-param.h.


r~

