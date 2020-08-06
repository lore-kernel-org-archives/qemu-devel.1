Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3814DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F0020855
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyxtZzsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F0020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mXi-0007PX-63
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3mEw-0006H0-38
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 16:11:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3mEu-0004Bh-Hi
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 16:11:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id z18so41605893wrm.12
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yGznpTt9hNOsMnxk5jyKH9aLtAcYOTWPD2BmiJHoX8g=;
 b=UyxtZzsb4an5A/RvDO0Y35juCnxDQQxR1eUEA1F4wNHbTaRMGvJdIU2mISnUWhZL6J
 pq8aIqCUQhmr80lHupJwOtWyoWjcftt2pYbL2/llqdG+D6an2HUVc1c8g0THTIOokisq
 6OPxM0wWNuGH54OyperJfjAmThijop9A5xWRijCMhwvudmVCHKlo0zwopaCmxwrsnoDd
 vsuDqVOk4RpeyuDfHOfKCgFzkLApXa9MUgORQVCKkT++ZyjhgCFOnasaNfaoQHT9pCdg
 OCuhzjgPQmxG6Uv/uWNulfhxS2Y1Kr2A6G87XIoRetJgpwBiLCuefTYtdwD3ttCUYL6b
 p8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yGznpTt9hNOsMnxk5jyKH9aLtAcYOTWPD2BmiJHoX8g=;
 b=qYJjZEaePlA4zPE3Uh7izFxgWaILDJ+qYfv0bNHFrgHpdGgkK8zDYs39uU5NVAsWm3
 5oKFCcE0GXJvBN1H4/kR7KcFNZqTMwuHZXbBcPc0vGpA1/YjQ0XbM/2MCc+gDRkw+QBs
 hK8t6IHva5lNMj7nRXVf5Fes0GJySs0mWAUPLi/HCEnAYe+kig5Nujb4pk/KowmkzO9S
 aCToxJphpeUKi/bQthBgZ3N9ZB4P61IYSJW5v/7gSEGm8urFgjg7/X3rIs8GUeGWbnqP
 jwKuEU3ApZxTZzfLxI68HD/ALY4FGaNm6WxsqEfXoWjBvkhxY3SWxTv2KJl7dsrKRDKP
 0Jug==
X-Gm-Message-State: AOAM531auxEVEc8CgPke+3Ax8uUNW4VUZ4uHMxjim1c9SRTl2jnknsEk
 bBwGbRG63QzTM1WQFtvQC2g=
X-Google-Smtp-Source: ABdhPJxzQt5ablqWdzfoAhNNxZ+7S/K4ahux7pA/Fl/qH+ifxxJUF2+LcXMqh+iUsaAInSQOpsRRNA==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr8792100wrn.389.1596744706587; 
 Thu, 06 Aug 2020 13:11:46 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id o125sm8586969wma.27.2020.08.06.13.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 13:11:44 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] target/mips: Report unimplemented cache()
 operations
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20200806122612.17167-1-f4bug@amsat.org>
 <e55da0ff-e88c-f2f4-0430-32255f7e58fe@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ec0ff553-a5e7-6c93-5ab3-093721b044a6@amsat.org>
Date: Thu, 6 Aug 2020 22:11:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e55da0ff-e88c-f2f4-0430-32255f7e58fe@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Huacai Chen <chenhc@lemote.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 8:01 PM, Jiaxun Yang wrote:
> 在 2020/8/6 下午8:26, Philippe Mathieu-Daudé 写道:
>> We only implement the Index[Store/Load]Tag from the 'cache' opcode.
>> Instead of ignoring the other cache operations, report them as
>> unimplemented.
> 
> Hmm, I don't think we have anything to do with Invalidate/Writeback etc.
> opcodes
> in QEMU. Why do we log this?

I'm noticed this code is run on Linux 3.3.8 (4KEc):

    8880:       3082000f        andi    v0,a0,0xf
    8884:       10800008        beqz    a0,88a8
    8888:       00a21021        addu    v0,a1,v0
    888c:       08002227        j       889c
    8890:       00001821        move    v1,zero
    8894:       bcf90000        cache   0x19,0(a3)
    8898:       24630010        addiu   v1,v1,16
    889c:       0062302b        sltu    a2,v1,v0
    88a0:       14c0fffc        bnez    a2,8894
    88a4:       00833821        addu    a3,a0,v1
    88a8:       03e00008        jr      ra
    88ac:       00000000        nop

Why silently ignore the opcode is not implemented instead of logging it?

> 
> Thanks.
> 
> - Jiaxun
> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   target/mips/op_helper.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
>> index 9552b280e0..7f87e57c8e 100644
>> --- a/target/mips/op_helper.c
>> +++ b/target/mips/op_helper.c
>> @@ -1583,6 +1583,8 @@ void helper_cache(CPUMIPSState *env,
>> target_ulong addr, uint32_t op)
>>           /* Index Load Tag */
>>           memory_region_dispatch_read(env->itc_tag, index,
>> &env->CP0_TagLo,
>>                                       MO_64, MEMTXATTRS_UNSPECIFIED);
>> +    } else {
>> +        qemu_log_mask(LOG_UNIMP, "cache %u\n", op);
>>       }
>>   #endif
>>   }
> 

