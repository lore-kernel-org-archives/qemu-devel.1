Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3408FC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D0E20848
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if0B8eOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D0E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTQ32-0000cx-A2
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 09:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTQ1d-00009o-Sq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:44:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:32918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTQ1c-0002ut-5e
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:44:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id z22so1634226wmi.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lku0K9dFVN76/FCimSI2p56+m6UmkyCzwYlJ5Pgs8fk=;
 b=if0B8eOuldokLeMkXD9cHQMjofhOvfrtYheVApgMucnS3lQJplN6PHlm/YQBWFFiLx
 nN6mrVxKQaIjW1f7M9zjJS92YUeIi1rdyhI5tkgbkJ46Y1uJFOfthUykz9nPn59edmbW
 dqw0riB2z1vi0x/gA1Amk2ugqocxT0F6YCe+45tVt2r/36HdTJRsjlZVQ0fEJHZZcL+/
 bpBt1MrSSWuUUcu9qvTjI1HodHDMmrhIGZJDBCB0sOeYQ9MpZBQX1FT/VkfjD6y7AJi7
 sd6O2NyOp9C9sqxI98EpvowBSTbv5DXttMIOzQCTeBjmWWqQ0yoFlzN8cVk3rdn4Ju/3
 Q8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lku0K9dFVN76/FCimSI2p56+m6UmkyCzwYlJ5Pgs8fk=;
 b=APKyogJn7D7kKt6FY10KfFwdjBCqarYlXyippRP20XsnQkDiCBhxjVbpRzhCPd8ci4
 0yVt15sqC5d2GRn0nA6niBQP9qGxDjWGb1Auby89/P6DjXMEYZ1nMVxMK50bs5lwhPQe
 PcQLi6cuhQWBcNi0qjA8L3HlIg0n4ZuRxOvg8c4A9LQu9XJSsC1FrbSK/Cs7uBLHVbPG
 dZ2O6swvlMK5BLyfJlJqzrh6dDfXK63YQ45QJ0Ei+9Yg7r48O5E1ymDY1Wgfj84t8LG+
 BKmyi6qi2soHIAN6VRNHMHQCPS+f4HoLukUWcY4GmI7xQq19dfpPY4kF63c4ypElp1pE
 mwSw==
X-Gm-Message-State: AOAM53312dvQd5bD/OPfTjWcNnhyPz7m/RVict/EcTcwkBi5UgIvfWr8
 VA6aWiMmsS51HVjSk/yDg2k=
X-Google-Smtp-Source: ABdhPJyLnPaFkuuB8ks53HFL5Sc0s3OC2sfP9s3vZUbHkkrGSJsMKtU8ttVdxcwwWJfZxxQgBxvMwQ==
X-Received: by 2002:a1c:2601:: with SMTP id m1mr3718835wmm.12.1602855841526;
 Fri, 16 Oct 2020 06:44:01 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id f5sm2814883wmh.16.2020.10.16.06.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 06:44:00 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Move MIPS GIC timer files to Boston
 board section
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201013101659.3557154-1-f4bug@amsat.org>
 <20201013101659.3557154-5-f4bug@amsat.org>
 <39fdf233-f4a2-5b13-c02f-e404a789d99c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3dcb65f2-cd9e-79e6-4b33-f7c068296c05@amsat.org>
Date: Fri, 16 Oct 2020 15:43:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <39fdf233-f4a2-5b13-c02f-e404a789d99c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 3:39 PM, Thomas Huth wrote:
> On 13/10/2020 12.16, Philippe Mathieu-Daudé wrote:
>> The MIPS GIC timer is only used by the Boston board.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   MAINTAINERS | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 702f73823fc..62db288bfc4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -233,11 +233,9 @@ F: docs/system/cpu-models-mips.rst.inc
>>   F: hw/intc/mips_gic.c
>>   F: hw/mips/
>>   F: hw/misc/mips_*
>> -F: hw/timer/mips_gictimer.c
>>   F: include/hw/intc/mips_gic.h
>>   F: include/hw/mips/
>>   F: include/hw/misc/mips_*
>> -F: include/hw/timer/mips_gictimer.h
>>   F: tests/tcg/mips/
>>   K: ^Subject:.*(?i)mips
>>   
>> @@ -1167,7 +1165,9 @@ S: Odd Fixes
>>   F: hw/core/loader-fit.c
>>   F: hw/mips/boston.c
>>   F: hw/pci-host/xilinx-pcie.c
>> +F: hw/timer/mips_gictimer.c
>>   F: include/hw/pci-host/xilinx-pcie.h
>> +F: include/hw/timer/mips_gictimer.h
> 
> If I grep for mips_gictimer_init, it seems like this function is used from
> mips_gic_realize in hw/intc/mips_gic.c ... and mips_gic.c / TYPE_MIPS_GIC is
> also used from the malta board ... so are you really sure this is right? Or
> what did I miss?

We have another Frankenstein :(

