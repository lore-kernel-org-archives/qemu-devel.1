Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70B2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87054206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="dps9uidQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87054206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolGn-00009x-RF
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jolFz-0007nD-Tv
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:06:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jolFx-0005jp-NZ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:06:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id z13so8919290wrw.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 03:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2OxCbBgFU9PvvF0xecYaaPPPsto/wU1BWDxi2oul6RE=;
 b=dps9uidQx33WhZUjYcoYMHk9CxGHZtzJamSqBVUgqnhEarAhtivjmir0/hs2SEN/gj
 RM9vSMkuFUjwRQfPYUQA5swghQqefacRkPxi6Uikf/rFXr9PwaYRqbL8xhYj9sMddoHo
 MEYtPpBUD7GbAMyKkUk8nLDepAf4tf5nmUerkEMVxCdg64NZPbwKNVTxTdOMPz0+rstE
 hxVjj6exAehFkz9Fe6MgPA7c42xc3SOjsZLVC15/xLM4i3JPicM5DhnwfGbJ9h2jy+3J
 bWieiJyVQX2RcSI0GaLCggdrvP4ox7sg5ug/MKpYUem5uD7GyrI1ghSVFFJMTqblZQga
 4oHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2OxCbBgFU9PvvF0xecYaaPPPsto/wU1BWDxi2oul6RE=;
 b=KFnLR60gNHiKcul4YWcV4tKHXMTQlNwuRhjj4nGc82jetTWl7Dc3y65FMSiCYJcAXp
 91KsiFbKr+GLdBU1gCxBu2+JJDx1WYt9nJpMA5AL65YhK0HDqnH60e/dnxiO+kcA7Qrb
 mCNPS2/88xPqt2CVbsyxKnKstJHougtusw6iGHd9T121/1FDpZubxedchLtMpJYp9xBk
 EKhhTZevY66BlQQ3CtjsPxt+k6HPRZId+CBi9GPxZksUB0l6k8JiK1EfpcGtW9BPHc5K
 BIaGEWxrKz+cM8ZeX+3GbIa9jH2FGF+nREqZNXuTNO5J8eBQokC1h2IPSP+6ddlj/xPW
 wuQA==
X-Gm-Message-State: AOAM531Lu7WkXPsIEivhZf7DpFLuifr6axO8fnU91td/RRTmXBwbgpPG
 UC0WQql54wdWY4UwIo5GNc9FPg==
X-Google-Smtp-Source: ABdhPJxr2Emqx/eNxCSAB/Kkn5jjxJB3eBlNcgp8VGSxk5ubWjNgay/Q0NPiRK/ZtFq6NKE8iMtZ+g==
X-Received: by 2002:a05:6000:12c5:: with SMTP id
 l5mr2769056wrx.219.1593166007416; 
 Fri, 26 Jun 2020 03:06:47 -0700 (PDT)
Received: from localhost.localdomain
 (lfbn-tou-1-1325-88.w90-89.abo.wanadoo.fr. [90.89.138.88])
 by smtp.gmail.com with ESMTPSA id v20sm36970780wrb.51.2020.06.26.03.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 03:06:46 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] semihosting: defer connect_chardevs a little more
 to use serialx
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <1592215252-26742-1-git-send-email-frederic.konrad@adacore.com>
 <87tuzbyseo.fsf@linaro.org>
From: Fred Konrad <konrad@adacore.com>
Message-ID: <d8e0a351-7136-4630-f65d-2d7b9603eb8d@adacore.com>
Date: Fri, 26 Jun 2020 12:06:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87tuzbyseo.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=konrad@adacore.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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



Le 6/16/20 à 4:52 PM, Alex Bennée a écrit :
> 
> konrad@adacore.com writes:
> 
>> From: KONRAD Frederic <frederic.konrad@adacore.com>
>>
>> With that we can just use chardev=serial0.
> 
> I don't quite follow what this means.
> 
> ./aarch64-softmmu/qemu-system-aarch64 -cpu max -monitor none -chardev=serial0 -M virt -display none -semihosting -kernel ./tests/tcg/aarch64-softmmu/memory
> qemu-system-aarch64: -chardev=serial0: invalid option
> 
> ./aarch64-softmmu/qemu-system-aarch64 -cpu max -monitor none -chardev id=serial0 -M virt -display none -semihosting -kernel ./tests/tcg/aarch64-softmmu/memory
> qemu-system-aarch64: -chardev id=serial0: chardev: "serial0" missing backend
> 
> The run:
> 
> ./aarch64-softmmu/qemu-system-aarch64 -cpu max -serial mon:stdio -M virt -display none -semihosting -kernel ./tests/tcg/aarch64-softmmu/memory
> 
> works fine without this patch.

Hi Alex, and sorry for the delay,

I meant `-semihosting-config chardev=serial0`.  I suspect your last command-line
will print any string sent to semihosting to stderr by default.

> 
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>   softmmu/vl.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index f669c06..9b8b48a 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -4123,8 +4123,6 @@ void qemu_init(int argc, char **argv, char **envp)
>>   
>>       qemu_opts_foreach(qemu_find_opts("chardev"),
>>                         chardev_init_func, NULL, &error_fatal);
>> -    /* now chardevs have been created we may have semihosting to connect */
>> -    qemu_semihosting_connect_chardevs();
>>   
>>   #ifdef CONFIG_VIRTFS
>>       qemu_opts_foreach(qemu_find_opts("fsdev"),
>> @@ -4271,6 +4269,9 @@ void qemu_init(int argc, char **argv, char **envp)
>>       if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
>>           exit(1);
>>   
>> +    /* now chardevs have been created we may have semihosting to connect */
>> +    qemu_semihosting_connect_chardevs();
>> +
>>       /* If no default VGA is requested, the default is "none".  */
>>       if (default_vga) {
>>           vga_model = get_default_vga_model(machine_class);
> 
> 

