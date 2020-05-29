Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C575C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120E42074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="zw7q1vpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120E42074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZjw-0007Oi-AB
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jeZj6-0006xG-LO
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:46:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jeZj5-00057K-AI
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:46:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id u13so2115904wml.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 00:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iPS5eCZFJCx/xXMkp96aabirCUbWUF2Amn+L5sqfQVs=;
 b=zw7q1vpuf5AuzJqPVXoDq2gPgx9kU4IHBBu1pbEd/rrx3XDxDIMHBnpwPI9/k6exfn
 JsUWekRRAD2XRQUThsjFoQNJY+xDsQAzmSpBQLRrV0eHM5OG5h8Udgx6Jxg1ANK9sU09
 RWpK6bz1ZM/mAW7WQcbDs65kcFogoyf1EYd/9qlSanHszRUuUVMDsRry16blmk084UO7
 GfI8/9y6/3cmbvtNxSmDPMFbrKobKqSkjc+CkpuLMDD+i/0PeejrvEMt8pBKJ+CH4ces
 OwRqF6ljNdpnUsBSU+8q4FzI/RZE0WFz2FVJI1i4doT8+E7B8bbbV2ngHy1ZQ2536S6r
 MNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iPS5eCZFJCx/xXMkp96aabirCUbWUF2Amn+L5sqfQVs=;
 b=m/L2QNSXLWY7RhBWEybPckqqKO4SQITKOyFswU05ypnIUJtt6pGzNyWVp+oHdoQGsS
 PHMB6CrrgX4WRpevxftsLOQO+awd6TDwr5fOUrqTadp69Ch2dYDpbpzR219a0j5RSNkF
 yP80Lni1GMDvfHSPsVq4x4AiKmC9O/KgEfFSumEwMl57GMdz8x5/92tFvgjEuki0FvPW
 zLZhoGZsGSA+05XtfGS3AvanYWUhwAJlTY6vETpBbUTFeiybR8/aViCYs1lMCwZ82Poj
 NQAhotpfia1yCbedpWu+pH7baoBV1Q5hZD+yHvEZBuiWSL8CpaHqPXtOG0WJIQUCwlsA
 uMig==
X-Gm-Message-State: AOAM533AVXaScsVbOUnj2RGIjOMsf5K7HJuF4aNxuB0cqbfwV0oZaVLJ
 aCITLFFq0wgCXRVvLR5jt9FLoA==
X-Google-Smtp-Source: ABdhPJyzgDMbwacbtZ8oaznwL4wI1r4Euo3/AmfDaRZgATqU+dXJ8UCjO8tpQAyyBWLc0nC1SJ65pw==
X-Received: by 2002:a05:600c:c3:: with SMTP id
 u3mr6928198wmm.108.1590738405236; 
 Fri, 29 May 2020 00:46:45 -0700 (PDT)
Received: from linux.home ([2a01:cb19:867e:2100:7eef:23e0:9210:3e8])
 by smtp.gmail.com with ESMTPSA id z25sm9997514wmf.10.2020.05.29.00.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 00:46:44 -0700 (PDT)
Subject: Re: [RFC] some semihosting interrogation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <141c5b32-31cd-1a1d-b1aa-692b9002dac9@adacore.com>
 <8771e99e-764b-52aa-55c4-a528d0804a34@redhat.com>
From: Fred Konrad <konrad@adacore.com>
Message-ID: <cb021a9c-df71-42af-5862-7c44cb4544db@adacore.com>
Date: Fri, 29 May 2020 09:46:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <8771e99e-764b-52aa-55c4-a528d0804a34@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=konrad@adacore.com; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 5/28/20 à 2:00 PM, Philippe Mathieu-Daudé a écrit :
> Hi Fred,
> 
> On 5/28/20 11:44 AM, Fred Konrad wrote:
>> Hi all,
>>
>> Just wonderring if there is any reason not to be able to defer
>> qemu_semihosting_connect_chardevs a little more to be able to specify
>> chardev=serial0?
>>
>> Like:
>>
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index 6390cf0..9fa1553 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -4333,8 +4333,6 @@ void qemu_init(int argc, char **argv, char **envp)
>>
>>       qemu_opts_foreach(qemu_find_opts("chardev"),
>>                         chardev_init_func, NULL, &error_fatal);
>> -    /* now chardevs have been created we may have semihosting to
>> connect */
>> -    qemu_semihosting_connect_chardevs();
>>
>>   #ifdef CONFIG_VIRTFS
>>       qemu_opts_foreach(qemu_find_opts("fsdev"),
>> @@ -4484,6 +4482,9 @@ void qemu_init(int argc, char **argv, char **envp)
>>       if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
>>           exit(1);
>>
>> +    /* now chardevs have been created we may have semihosting to
>> connect */
>> +    qemu_semihosting_connect_chardevs();
> 
> Cc'ing Markus for this part because he had headaches recently moving
> things around there; but the change looks.
> 
>> +
>>       /* If no default VGA is requested, the default is "none".  */
>>       if (default_vga) {
>>           vga_model = get_default_vga_model(machine_class);
>>
>> Also I found out that the trailing \0 is sent to the chardev
>> (console.c:copy_user_string) is that expected in case of semihosting?
> 
> No, your patch fixes a bug.

Great thanks for your feedback.


