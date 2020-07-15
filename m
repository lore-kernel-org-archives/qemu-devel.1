Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95032C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB002067D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="YgTwSwtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB002067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvfDs-0000KL-JX
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 07:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jvfD7-0008IQ-3m
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 07:04:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jvfD5-0000wI-9r
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 07:04:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so5339249wmf.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mnN8xAg/OXiHe8qVYZfeys4lAqDvbkAFPuQ5NXnd6Ik=;
 b=YgTwSwtdlfhUctJWNC4wCfCQVQ/BiyVo/9nKiUnjk2HoIrtxCi/+im3mhd/C8ywxWE
 Nbs1xIOKykKRV5N+zffL/pUE8W2kpMj27AUGIF3CCeZf7BiKXaylTRO+XuMkhpf76rHd
 a9uiNzKjsSPrE6AOGb0rb8GV4IgXTc7VilhLOkxx7c2zOwjX1as29mBbd63CZdQrTwTE
 s/8I18jR/ER9T0Xn2GhiVarka6rtZ5EO2esPFjvrImpWKC3fhGmhqyISMfWGFIOMUq/C
 n7wR+prqEY/5hBHZicoVQaeFaQYyUfZncyiQSjCE8KsMqwzKlwYNgDJa8zFWt/8zW8Y0
 CVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mnN8xAg/OXiHe8qVYZfeys4lAqDvbkAFPuQ5NXnd6Ik=;
 b=QCVxjV2dzoVXiNKY2mZsaQu6k1Mli2xcPV6USluvGEYK9XIrIvao5NkPDwplQtY9tF
 dnOTDs8yyUqWZqJM6jNQLPYy+/SiDiSXquKPkQNR7yvwfkqPIQlhk7WY4g2q0TH8KnUl
 y+ItPCSwCPkqdpbI9lTdi20N57Dj0MIr+zthqNTZdihWKabWNqISQrHS1EnHGoVm/31t
 y7c286eO9MSzaVtqJTr5hBRUKENIz88wyfHQoqiDcyV2rGgBAHAfJ4d4DphXh3rIrDl7
 0VUjz/JNkHfYs27Dl3JdilBnRr42gjL35HU0VhU0kelqNmqlQ+RE64oxjfbCOOuz5Orx
 /e0Q==
X-Gm-Message-State: AOAM53155UmA4RyXi+RASFqQ5zgt4J+UbsXcxbeyy8rbdb+4S7+Oiaw+
 8M481IZjQNtRTC540xZF3gyoBw==
X-Google-Smtp-Source: ABdhPJy/+pVtQgcbGNc9voTDDnIisHvwy3KroRR1ucJ30EGR/9w0NLhHVUlDjwq2JnwiBmpyM/HdbA==
X-Received: by 2002:a7b:c0c9:: with SMTP id s9mr7705553wmh.166.1594811061356; 
 Wed, 15 Jul 2020 04:04:21 -0700 (PDT)
Received: from localhost.localdomain ([37.58.245.230])
 by smtp.gmail.com with ESMTPSA id g3sm3417868wrb.59.2020.07.15.04.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2020 04:04:19 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] semihosting: defer connect_chardevs a little more
 to use serialx
From: Fred Konrad <konrad@adacore.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <1592215252-26742-1-git-send-email-frederic.konrad@adacore.com>
 <87tuzbyseo.fsf@linaro.org>
 <d8e0a351-7136-4630-f65d-2d7b9603eb8d@adacore.com>
Message-ID: <0e1a1c94-7b90-177a-4283-5247ef675497@adacore.com>
Date: Wed, 15 Jul 2020 13:04:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d8e0a351-7136-4630-f65d-2d7b9603eb8d@adacore.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=konrad@adacore.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 6/26/20 à 12:06 PM, Fred Konrad a écrit :
> 
> 
> Le 6/16/20 à 4:52 PM, Alex Bennée a écrit :
>>
>> konrad@adacore.com writes:
>>
>>> From: KONRAD Frederic <frederic.konrad@adacore.com>
>>>
>>> With that we can just use chardev=serial0.
>>
>> I don't quite follow what this means.
>>
>> ./aarch64-softmmu/qemu-system-aarch64 -cpu max -monitor none -chardev=serial0 
>> -M virt -display none -semihosting -kernel ./tests/tcg/aarch64-softmmu/memory
>> qemu-system-aarch64: -chardev=serial0: invalid option
>>
>> ./aarch64-softmmu/qemu-system-aarch64 -cpu max -monitor none -chardev 
>> id=serial0 -M virt -display none -semihosting -kernel 
>> ./tests/tcg/aarch64-softmmu/memory
>> qemu-system-aarch64: -chardev id=serial0: chardev: "serial0" missing backend
>>
>> The run:
>>
>> ./aarch64-softmmu/qemu-system-aarch64 -cpu max -serial mon:stdio -M virt 
>> -display none -semihosting -kernel ./tests/tcg/aarch64-softmmu/memory
>>
>> works fine without this patch.
> 
> Hi Alex, and sorry for the delay,
> 
> I meant `-semihosting-config chardev=serial0`.  I suspect your last command-line
> will print any string sent to semihosting to stderr by default.

Does that make sense?  BTW the second patch fixes a bug, it might be interesting
to have it in 5.1.

Cheers,
Fred

> 
>>
>>>
>>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>>> ---
>>>   softmmu/vl.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>>> index f669c06..9b8b48a 100644
>>> --- a/softmmu/vl.c
>>> +++ b/softmmu/vl.c
>>> @@ -4123,8 +4123,6 @@ void qemu_init(int argc, char **argv, char **envp)
>>>       qemu_opts_foreach(qemu_find_opts("chardev"),
>>>                         chardev_init_func, NULL, &error_fatal);
>>> -    /* now chardevs have been created we may have semihosting to connect */
>>> -    qemu_semihosting_connect_chardevs();
>>>   #ifdef CONFIG_VIRTFS
>>>       qemu_opts_foreach(qemu_find_opts("fsdev"),
>>> @@ -4271,6 +4269,9 @@ void qemu_init(int argc, char **argv, char **envp)
>>>       if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
>>>           exit(1);
>>> +    /* now chardevs have been created we may have semihosting to connect */
>>> +    qemu_semihosting_connect_chardevs();
>>> +
>>>       /* If no default VGA is requested, the default is "none".  */
>>>       if (default_vga) {
>>>           vga_model = get_default_vga_model(machine_class);
>>
>>

