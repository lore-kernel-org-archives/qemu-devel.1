Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4ABC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8329F2064B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYG/SqRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8329F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFEGV-0002Z0-Eb
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFEFv-00023y-Mv
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:20:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFEFt-0001oE-Sg
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:20:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id c18so15187741wrm.9
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 03:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vnpyYhZaeRqlBBMcs6XOlMjuNEcGFrdZOAleCSugNY0=;
 b=nYG/SqRHcFIe8xbyHIzv3Dll7BnEVCkx7jlw4Drd43g0nKFvXjRpLz/aIqGUMQ4Zhs
 0Y/8u8MWvBF34m7px3bqQvLufAt7alzaaL1JHF+t6WsvDraciVy0ox6mqBbtlhcan5VW
 syowHjOETs4JWHdBxkS1u/pEbYLJZ7ydWKm4jqjf6sVmAN8Fxcj5vHqSyvoy2xnVS5a3
 ovvsx2lNouiaLy2Or0GbPajLetQI3Y4lKFTakHabe7ZJklVrDDqBiIZCajDTSkDyZr/r
 KjR66Md9Up1L6qglAbem94PuP8Vvgf9ukkhGIdehw+b3tGqwTFuGpcg2hgsT8wZLHZWx
 HTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vnpyYhZaeRqlBBMcs6XOlMjuNEcGFrdZOAleCSugNY0=;
 b=ieBc2gI05kQr7ou08CLcVYVEa/IRRO4WNJNz42FaGSJSAw9XH5Boqxy0VfdArx+J4R
 b52zQr2kqwxgWfKbJNqupySCbfPgXhO05wfiDmhV7C1w51qxiNviO/YBFAP2n0OSC/bk
 YGD2VVVlh5BRUgaBG+mAcaYiCfVTOJhxDxgE1PxeWACgHe+EXeJjqV0N+CjqMcy4I7K+
 osaiPLd8vmoMcrJYRZlQqPdki+DlD3DMZOXqCDsT3AQ3Edh8RfdskZkiA30aEugc21z5
 luCZS4xVld/F7WtMAZaGS3VqU39icwLDfh3mvSWtTpkN2486CJQ2F9KVYUOtv9EtK1xT
 MqkA==
X-Gm-Message-State: AOAM530fuKI1XedJmH9pE92cH86a2u2c4eoD0YAH2dAcFAw0A1Gjx32w
 BiKAcQWXtMSvM6sseQxZ9pQ=
X-Google-Smtp-Source: ABdhPJxxGqkAemMfHjv3dKgZsbk9W64CxrHQPZWtiYaVnUAwRlyUIMplHj0tRUTxEEWt4Y3m986aIA==
X-Received: by 2002:adf:dcd1:: with SMTP id x17mr22274660wrm.150.1599474007985; 
 Mon, 07 Sep 2020 03:20:07 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id w15sm27839165wro.46.2020.09.07.03.20.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 03:20:06 -0700 (PDT)
Subject: Re: [PULL 3/5] softmmu/cpus: Only set parallel_cpus for SMP
To: Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200903214101.1746878-1-richard.henderson@linaro.org>
 <20200903214101.1746878-4-richard.henderson@linaro.org>
 <1f573d2d-b3bb-21ab-bbcd-b759fc14ad2b@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3dfae924-34c9-e36a-77bf-f3abcdeaf268@amsat.org>
Date: Mon, 7 Sep 2020 12:20:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1f573d2d-b3bb-21ab-bbcd-b759fc14ad2b@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-2.69,
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 12:05 PM, Claudio Fontana wrote:
> Hi Richard,
> 
> currently rebasing on top of this one,
> just a question, why is the patch not directly using "current_machine"?

For user mode?

> 
> Is using MACHINE(qdev_get_machine()) preferrable here?
> 
> Thanks,
> 
> Claudio
> 
> On 9/3/20 11:40 PM, Richard Henderson wrote:
>> Do not set parallel_cpus if there is only one cpu instantiated.
>> This will allow tcg to use serial code to implement atomics.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  softmmu/cpus.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
>> index a802e899ab..e3b98065c9 100644
>> --- a/softmmu/cpus.c
>> +++ b/softmmu/cpus.c
>> @@ -1895,6 +1895,16 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>>      if (!tcg_region_inited) {
>>          tcg_region_inited = 1;
>>          tcg_region_init();
>> +        /*
>> +         * If MTTCG, and we will create multiple cpus,
>> +         * then we will have cpus running in parallel.
>> +         */
>> +        if (qemu_tcg_mttcg_enabled()) {
>> +            MachineState *ms = MACHINE(qdev_get_machine());
> 
> MachineState *ms = current_machine;
> ?
> 
> 
>> +            if (ms->smp.max_cpus > 1) {
>> +                parallel_cpus = true;
>> +            }
>> +        }
>>      }
>>  
>>      if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
>> @@ -1904,7 +1914,6 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>>  
>>          if (qemu_tcg_mttcg_enabled()) {
>>              /* create a thread per vCPU with TCG (MTTCG) */
>> -            parallel_cpus = true;
>>              snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
>>                   cpu->cpu_index);
>>  
>>
> 
> 

