Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB6FC388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 11:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6D0207C4
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 11:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQonbJqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6D0207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWeT2-0004U4-59
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 07:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWePt-00039F-Ho
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 07:42:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWePr-0001dK-Pz
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 07:42:29 -0400
Received: by mail-wm1-x344.google.com with SMTP id 13so8831309wmf.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 04:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/ELOI9/0rT3BCPXECcXaKoJsxijcO55NQTCuRCm8HcQ=;
 b=XQonbJqTUlof6NkkG9kw2yRL/AdptY2GV7ZVXpZ0IP5bRBgwNEIGjctquomaPFY9HO
 AGk9GZtmGpom+l/LlkgUOX+AQ31dR7qavnemqsepPSbmhwXp9ze3idMfviOM13F9UmBg
 H9/LQehrcK6xVk4FzddZbRCKXR1oLUnNNT/q6q06Wd5DfCXLa7X1RykflDoxlXrELtnL
 UVycCsVGrw1Sbwne6R23dlXHLmtdoy2LHeOXAniQ2VWnD/a+f53gXeCkmDwyoT84fa4U
 rlJb2HFnnJ0WNUvbN9iwf6IFt6KGglsa8Pmm1j2Kjcn8p0ktbg5BtHUZG4psCq+kIFoX
 i9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/ELOI9/0rT3BCPXECcXaKoJsxijcO55NQTCuRCm8HcQ=;
 b=nBwtiFgx1MGi5zuIuIerrGMuc880uoT6QXw7Q36IPmyPs7Q4vX+5EJoi1inl0Cl/K3
 oSeqF5wV7f5lnRws6EgftRYGLzdOMbIX1HjkppSea3GvjWBeKx64GdT4VmFxsoqqYqaZ
 3HOxKCBXDfqIIyo0SabychmeTrVq0xscz5GirvszjhZz8s3NY+dfO2+jAbR0NuJC87ni
 K+lReqO58LK6IWkUEReric0jVUoCEDFYN9v2hdFayh+WWcTHj8VDnbiC1Jl5yNC8bebT
 7ds8z0KGDuHFBDltUgPwyvi1Z5zRSn7OGI3ZfV6yYEOSK+3Yh84ApEGJwTBP9S9nGvfl
 30qQ==
X-Gm-Message-State: AOAM530WcqWQso8VykiX4jdCD+GXG/9rLxAI7PadQeRPKAaEfkQO+R2P
 /gHCga47HPyKbop7LRP5QNw=
X-Google-Smtp-Source: ABdhPJwlX7NuiH25g8bYgDC1e5oG7LjDDyYK9GCQaKa4MpregDGBM9zhueU1H8qdYPeEER4MTHLoYg==
X-Received: by 2002:a05:600c:2211:: with SMTP id
 z17mr11705512wml.92.1603626146229; 
 Sun, 25 Oct 2020 04:42:26 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id z18sm15526466wrs.82.2020.10.25.04.42.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2020 04:42:25 -0700 (PDT)
Subject: Re: [PATCH v3] hw/display/tcx: Allow 64-bit accesses to framebuffer
 stippler and blitter
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20201024205100.3623006-1-f4bug@amsat.org>
 <8744a7c0-4fb8-65ce-cecf-0013468eeb10@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <117a8dd2-9234-e90d-33c3-39e3dc4c1e9e@amsat.org>
Date: Sun, 25 Oct 2020 12:42:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <8744a7c0-4fb8-65ce-cecf-0013468eeb10@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Michael Lorenz <macallan@NetBSD.org>, Andreas Gustafsson <gson@gson.org>,
 1892540@bugs.launchpad.net, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/20 11:55 AM, Mark Cave-Ayland wrote:
> On 24/10/2020 21:51, Philippe Mathieu-Daudé wrote:
> 
>> The S24/TCX datasheet is listed as "Unable to locate" on [1].
>>
>> However the NetBSD revision 1.32 of the driver introduced
>> 64-bit accesses to the stippler and blitter [2]. It is safe
>> to assume these memory regions are 64-bit accessible.
>> QEMU implementation is 32-bit, so fill the 'impl' fields.
>>
>> Michael Lorenz (author of the NetBSD code [2]) provided us with more
>> information in [3]:
>>
>>> IIRC the real hardware *requires* 64bit accesses for stipple and
>>> blitter operations to work. For stipples you write a 64bit word into
>>> STIP space, the address defines where in the framebuffer you want to
>>> draw, the data contain a 32bit bitmask, foreground colour and a ROP.
>>> BLIT space works similarly, the 64bit word contains an offset were to
>>> read pixels from, and how many you want to copy.
>>>
>>> One more thing since there seems to be some confusion - 64bit accesses
>>> on the framebuffer are fine as well. TCX/S24 is *not* an SBus device,
>>> even though its node says it is.
>>> S24 is a card that plugs into a special slot on the SS5 mainboard,
>>> which is shared with an SBus slot and looks a lot like a horizontal
>>> UPA slot. Both S24 and TCX are accessed through the Micro/TurboSPARC's
>>> AFX bus which is 64bit wide and intended for graphics.
>>> Early FFB docs even mentioned connecting to both AFX and UPA,
>>> no idea if that was ever realized in hardware though.
>>
>> [1] 
>> http://web.archive.org/web/20111209011516/http://wikis.sun.com/display/FOSSdocs/Home 
>>
>> [2] 
>> http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/sbus/tcx.c.diff?r1=1.31&r2=1.32 
>>
>> [3] https://www.mail-archive.com/qemu-devel@nongnu.org/msg734928.html
>>
>> Reported-by: Andreas Gustafsson <gson@gson.org>
>> Buglink: https://bugs.launchpad.net/bugs/1892540
>> Fixes: 55d7bfe2293 ("tcx: Implement hardware acceleration")
>> Tested-by: Michael S. Tsirkin <mst@redhat.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Tested-by: Andreas Gustafsson <gson@gson.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Since v2:
>> - added Michael's memories
>> - added R-b/T-b tags
>>
>> Since v1:
>> - added missing uncommitted staged changes... (tcx_blit_ops)
>> ---
>>   hw/display/tcx.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
>> index c9d5e45cd1f..878ecc8c506 100644
>> --- a/hw/display/tcx.c
>> +++ b/hw/display/tcx.c
>> @@ -549,20 +549,28 @@ static const MemoryRegionOps tcx_stip_ops = {
>>       .read = tcx_stip_readl,
>>       .write = tcx_stip_writel,
>>       .endianness = DEVICE_NATIVE_ENDIAN,
>> -    .valid = {
>> +    .impl = {
>>           .min_access_size = 4,
>>           .max_access_size = 4,
>>       },
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 8,
>> +    },
>>   };
>>   static const MemoryRegionOps tcx_rstip_ops = {
>>       .read = tcx_stip_readl,
>>       .write = tcx_rstip_writel,
>>       .endianness = DEVICE_NATIVE_ENDIAN,
>> -    .valid = {
>> +    .impl = {
>>           .min_access_size = 4,
>>           .max_access_size = 4,
>>       },
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 8,
>> +    },
>>   };
>>   static uint64_t tcx_blit_readl(void *opaque, hwaddr addr,
>> @@ -651,10 +659,14 @@ static const MemoryRegionOps tcx_rblit_ops = {
>>       .read = tcx_blit_readl,
>>       .write = tcx_rblit_writel,
>>       .endianness = DEVICE_NATIVE_ENDIAN,
>> -    .valid = {
>> +    .impl = {
>>           .min_access_size = 4,
>>           .max_access_size = 4,
>>       },
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 8,
>> +    },
>>   };
>>   static void tcx_invalidate_cursor_position(TCXState *s)
> 
> I'd already queued v2 of this patch (see my earlier email) with the 
> intent to send a PR today, however I'll replace it with this v3 instead.

Thanks! Since there is no code change with v2, I assumed it wouldn't be
a problem to replace it, without having to re-run your tests.

> 
> 
> ATB,
> 
> Mark.
> 

