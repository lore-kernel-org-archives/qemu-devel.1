Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F06DC2BBD0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC3C2177B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EugSNvo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC3C2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYUp-00047T-Od
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 03:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFYU9-0003FP-H0
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:56:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFYU6-0006t6-SX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:56:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id l9so16157552wme.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ylO4jrjrlAQ2lXutzxooc+bJ5b0Obl8J096TbkcCXnA=;
 b=EugSNvo5NlXFSDjpMjiEGoSWknTA/+Eqd/Lpb62QpYtIseSrDmPOT3Jbv0Fn0HJUrT
 M3VawcH+cKKpqze2Vhe4B1X5XSIy4oB3Lq5qxencfGRo/ygj+EqMqgm4sTE/kinedQOK
 Bnkuy/nAwxKYgrgCXZRYuya/enqXXdEChVKjXRLfQJYSfmmQv98aSNGER97qKvtsWbrd
 Y+81dpxGfVcbdEUORBOiJiGtOxZ6wW8P/cSfZ7HthpdZuJhnBTTX+hghrbr7/TT41jK0
 A3xcN4LeXHf4mY3ZM9iNew2lrv3kRsNpLKiJf7XX62G8U1lgPiBgf79L/dE2D53ZTxhI
 PH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ylO4jrjrlAQ2lXutzxooc+bJ5b0Obl8J096TbkcCXnA=;
 b=HXyOnGnJkCnSWpLrXQ582wu7W5tgSQ23XVvQI5JcWKkI64+pQA+VvpRNsgxJShwaph
 b1T6dHuDD8gI5spXsm9ktvS5Zg/nTsrwrfaLJj/XbDCd/wHoKnIkCjxo2tbEN7MNdJBy
 eVCVSTivoIPDBQZCIr4mf4hodjFBq9ZjPleUsEvE1oRgnFlfhlYMIqiCiVTtoYp7P6Z9
 oUo6M9TDl598T2clFcYnQORrRzPRwuVwCERXefxAyvBq7bZ2+ZPY3ApEqTD9BMMvKqx6
 QgZijHhJRbEgk3wVV0sJYguTvVtWm0sYCwdHmQfEyY1yd2Rt67otJdGTxx+tBczOvwSz
 HPJQ==
X-Gm-Message-State: AOAM533u2JWmJDkBBlmub+rvbUPlaOEcHary5rkvUbvb4yaqfiF71/3I
 KsKB84JalG3ZdfDv9deuIdw=
X-Google-Smtp-Source: ABdhPJzzsMzK+GrnTboopeVNeVcq30l8Ui70SMuE9sNBcHd6gaix/ug8FkfSJR/5BTSgagyLI5c/4A==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr3036013wma.88.1599551769019; 
 Tue, 08 Sep 2020 00:56:09 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a83sm30380677wmh.48.2020.09.08.00.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 00:56:08 -0700 (PDT)
Subject: Re: [PULL 3/5] softmmu/cpus: Only set parallel_cpus for SMP
To: Claudio Fontana <cfontana@suse.de>
References: <20200903214101.1746878-1-richard.henderson@linaro.org>
 <20200903214101.1746878-4-richard.henderson@linaro.org>
 <1f573d2d-b3bb-21ab-bbcd-b759fc14ad2b@suse.de>
 <3dfae924-34c9-e36a-77bf-f3abcdeaf268@amsat.org>
 <7454d121-3ebd-623a-55a3-4ba6e7e870dc@suse.de>
 <e47376bf-8ced-57eb-93d5-a1229d258dd6@amsat.org>
 <75c313df-da09-f3c2-5d34-0bfaad4290a9@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <652516a1-6a63-89eb-8b04-728a95b76d5f@amsat.org>
Date: Tue, 8 Sep 2020 09:56:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <75c313df-da09-f3c2-5d34-0bfaad4290a9@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.825,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Laurent

On 9/8/20 9:09 AM, Claudio Fontana wrote:
> On 9/7/20 6:49 PM, Philippe Mathieu-Daudé wrote:
>> On 9/7/20 6:30 PM, Claudio Fontana wrote:
>>> On 9/7/20 12:20 PM, Philippe Mathieu-Daudé wrote:
>>>> On 9/7/20 12:05 PM, Claudio Fontana wrote:
>>>>> Hi Richard,
>>>>>
>>>>> currently rebasing on top of this one,
>>>>> just a question, why is the patch not directly using "current_machine"?
>>>>
>>>> For user mode?
>>>
>>> In user mode I'd not expect softmmu/cpus.c to be built at all...
>>
>> Which is why :) current_machine is NULL in user-mode.
> 
> Ciao Philippe,
> 
> then why does the patch change softmmu/cpus.c in a way that accounts for user mode?
> 
> The function that the patch changes is never called in user mode.
> 
> The patch could instead use current_machine without any concern of it being NULL, it will always be set in vl.c .

Better send a patch to prove your point :)

I have bad remember about the last time I tried to understand/modify
that part, because IIRC the user-mode creates some fake machine to
satisfy various QEMU generic code assumptions. Sincerely I now prefer
stay away from this; too many unmerged patches there.

> 
> Ciao,
> 
> Claudio
> 
>>
>>>
>>> Ciao,
>>>
>>> Claudio
>>>
>>>>
>>>>>
>>>>> Is using MACHINE(qdev_get_machine()) preferrable here?
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Claudio
>>>>>
>>>>> On 9/3/20 11:40 PM, Richard Henderson wrote:
>>>>>> Do not set parallel_cpus if there is only one cpu instantiated.
>>>>>> This will allow tcg to use serial code to implement atomics.
>>>>>>
>>>>>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>>>> ---
>>>>>>  softmmu/cpus.c | 11 ++++++++++-
>>>>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
>>>>>> index a802e899ab..e3b98065c9 100644
>>>>>> --- a/softmmu/cpus.c
>>>>>> +++ b/softmmu/cpus.c
>>>>>> @@ -1895,6 +1895,16 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>>>>>>      if (!tcg_region_inited) {
>>>>>>          tcg_region_inited = 1;
>>>>>>          tcg_region_init();
>>>>>> +        /*
>>>>>> +         * If MTTCG, and we will create multiple cpus,
>>>>>> +         * then we will have cpus running in parallel.
>>>>>> +         */
>>>>>> +        if (qemu_tcg_mttcg_enabled()) {
>>>>>> +            MachineState *ms = MACHINE(qdev_get_machine());
>>>>>
>>>>> MachineState *ms = current_machine;
>>>>> ?
>>>>>
>>>>>
>>>>>> +            if (ms->smp.max_cpus > 1) {
>>>>>> +                parallel_cpus = true;
>>>>>> +            }
>>>>>> +        }
>>>>>>      }
>>>>>>  
>>>>>>      if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
>>>>>> @@ -1904,7 +1914,6 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>>>>>>  
>>>>>>          if (qemu_tcg_mttcg_enabled()) {
>>>>>>              /* create a thread per vCPU with TCG (MTTCG) */
>>>>>> -            parallel_cpus = true;
>>>>>>              snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
>>>>>>                   cpu->cpu_index);
>>>>>>  
>>>>>>
>>>>>
>>>>>
>>>
>>>
> 
> 

