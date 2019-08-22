Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B969EC3A59E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 02:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F6A22CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 02:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMkPn11H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F6A22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0dHX-0007hc-Hw
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 22:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0dGn-0007B9-Gv
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 22:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0dGm-00050b-6i
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 22:56:13 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0dGl-00050P-Vf
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 22:56:12 -0400
Received: by mail-pf1-x442.google.com with SMTP id v12so2843190pfn.10
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 19:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pqsV1GhFYAgEf6DwOiFvo3EJnjxsVUqJQ/dirtTmVrI=;
 b=AMkPn11HrBJ6ik8/LNaMfh2KOpRw0cz3IUDqZW62D4i9Sf0oZmXimkypyRLxutXF7U
 YOt+Qafdk1GlU3QNc1+maQFv5GALIRWwdmyKgdQKEjbEDIn5ypnQlDDTq1JjEfLhdexM
 Hfep5SqHj0hGJJYJeuwx779bqzbUHCo0FDtKqxgBnr6QJ+QpEgYVgkVylIVKQBEAICU+
 s7gAnYWCaCr3Z61SecpImqIzxqpNTQbAcxzmJQmi25F4He5nmj7DCIAfcmvj1OLMXO0d
 dR5ts8wYkI0HrdDclxBd9hULqtZoDmbfmPJoDAmw0Y84Q7tNv1wbh3uGuVHVYCil9X/M
 AuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pqsV1GhFYAgEf6DwOiFvo3EJnjxsVUqJQ/dirtTmVrI=;
 b=falLn5zk7BHsDjXRODna/oep5J9ocuSrVCVhPWq1i5fvbMu1SLhyt+aK1KZLN9iSV9
 AGgwc2qeLl0e81xLwwfwuRHgRV9XNPCTYWkSp5EhQSv9Fbhwc0c8KzXXMgbKk8zw2equ
 ZK1+ZNtg5YfCLYetw/X0eHVH+8Htj5J31gQTONHLluK8LnMeP8bQG5NejCxkoIW5NXkz
 SRAl6UDNwSoO9JeUmsnm89ft8GZVYWJkN25ITcBdPR+dn8iADeHt3C2y47VMWVU9jgf9
 77ImwfaXqBvnVWt/u98ELH9tsN7WRVgE67JCgMQ7kpvpvQyLwIa01z2FUrgxFTvC4Ef6
 55Aw==
X-Gm-Message-State: APjAAAXJZxkwZRwAdQPMsT5n2jA3cezd/6xM6MmbUidKFtTsWXhs9Se+
 uH0no7nENmojEZkTHhdEMBEgkA==
X-Google-Smtp-Source: APXvYqxdnLelDV5rdYar9Kz2dmw0FgivH8INaA2Vx2DeW+WRNIQLhqrzuKL6QqU0NmC7lQQ6ZQr4rw==
X-Received: by 2002:a17:90a:224e:: with SMTP id
 c72mr3178921pje.9.1566442570163; 
 Wed, 21 Aug 2019 19:56:10 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u7sm20970812pgr.94.2019.08.21.19.56.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Aug 2019 19:56:09 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20190821133932.7428-1-aurelien@aurel32.net>
 <CAFEAcA-YEeYEkLW1AL_dgqoANFnfpqJu=XSAkVBctNOh1i=kcw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b37aa2d9-7352-3cc0-4e58-5ac23f99c8a6@linaro.org>
Date: Wed, 21 Aug 2019 19:56:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-YEeYEkLW1AL_dgqoANFnfpqJu=XSAkVBctNOh1i=kcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH] target/alpha: fix tlb_fill trap_arg2 value
 for instruction fetch
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
Cc: qemu-stable <qemu-stable@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 6:52 AM, Peter Maydell wrote:
> On Wed, 21 Aug 2019 at 14:42, Aurelien Jarno <aurelien@aurel32.net> wrote:
>>
>> Commit e41c94529740cc26 ("target/alpha: Convert to CPUClass::tlb_fill")
>> slightly changed the way the trap_arg2 value is computed in case of TLB
>> fill. The type of the variable used in the ternary operator has been
>> changed from an int to an enum. This causes the -1 value to not be
>> sign-extended to 64-bit in case of an instruction fetch. The trap_arg2
>> ends up with 0xffffffff instead of 0xffffffffffffffff. Fix that by
>> changing the -1 into -1LL.
>>
>> This fixes the execution of user space processes in qemu-system-alpha.
>>
>> Fixes: e41c94529740cc26
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>> ---
>>  target/alpha/helper.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
>> index 93b8e788b1..9e9d880c1a 100644
>> --- a/target/alpha/helper.c
>> +++ b/target/alpha/helper.c
>> @@ -283,7 +283,7 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
>>          cs->exception_index = EXCP_MMFAULT;
>>          env->trap_arg0 = addr;
>>          env->trap_arg1 = fail;
>> -        env->trap_arg2 = (access_type == MMU_INST_FETCH ? -1 : access_type);
>> +        env->trap_arg2 = (access_type == MMU_INST_FETCH ? -1LL : access_type);
>>          cpu_loop_exit_restore(cs, retaddr);
>>      }
> 
> Oops. Thanks for the catch.
> 
> Maybe we should not rely directly on the value of the access_type
> enum to set trap_arg2 at all (ie just go for a switch on access_type and
> set env->trap_arg2 to the right h/w value in the three cases)?

Yes, I'll do that.  I'm somewhat embarrassed that I haven't tested Alpha in a
while, and moreso because we just did a release.


r~

