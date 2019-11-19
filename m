Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BF6C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F236A223B0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SvuZ6er7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F236A223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX9Qs-0005jK-6m
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 14:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iX9Px-0005Hn-RL
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:44:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iX9Pw-0000Dy-E2
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:44:05 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iX9Pw-0000Db-4s
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:44:04 -0500
Received: by mail-wr1-x442.google.com with SMTP id a15so25341607wrf.9
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 11:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3+b0wPei5K3oKfjfgKXyL/WIT9ImopA+t5x0wS49hjk=;
 b=SvuZ6er729t3207+XuzOli+n/2ykhA9HGCmkqt9Cw8LgvUB0W0iuxIsKU+UtotEoXb
 vKKFJzcIW+gIm4lRIhTfiAxidTKgcftFKllUWjitwhIwwW3hPDqG6mCIsscmvDJBEdn1
 /IDVqlzrrBEBXTf0l55FTlNfuVAYevv/5rO/zaPWAAXAVmcePsK8MJ5DpzytqG81c2vP
 CL2p2GQC5Tftlklckh1aoOMoieoxI43JBZ6Xz5cDY878+Qbc/LhRE3kDHsu8xlj7lRQF
 1hABOynkuK+7qahk8+H0ZNXuKp7955RvvySmgBrqwgCCEcsX+GSGYj9U+BZunYGTfp9/
 lZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3+b0wPei5K3oKfjfgKXyL/WIT9ImopA+t5x0wS49hjk=;
 b=cfWUej/kNJyqs5a5SYAFXIMOAMnz47VLhPGr2TiuCCttBxCya3rEon3BKe1vfKwUex
 5jm1YqAy+jByaFuQt64y/DpcbJrt3W6QKnA+OPQwuCidGsMRWKazOqcUW2rwN+r/u4SQ
 Q/W+W1R2h8MDnS0l1KZfdw6v2YZYiWEhaL01jSVwBmVYCR5imI31T+M9PdJ3Ht7qI2+l
 MqvoXl0UlA+6/3DvGLqVaYxgldVsn3v91EwKNyy665dgKn1bvde/8jZcBXW1XDEQtg/6
 WUqSstrG2zH0/JRuagWdkFmjA49P0zNpvd0SVhu70Oz5w1SlWoUeNbHUVsdTTMdZ0B4e
 tkpg==
X-Gm-Message-State: APjAAAUgnj5oPT9RQpxb9uCpIPL5c8Q9J5Cy0IPjt1W51V1fdwlGz7gM
 lNfscfkLNcizCPnmzBSRUFOLfRsIDiXodg==
X-Google-Smtp-Source: APXvYqwE+X7DXa11gnXfCRgk1jIVw1vvPcI44AmQcWcLnh7Jrcz9jxdHLAEOJAfqmM8SgeQsgq9weQ==
X-Received: by 2002:a5d:62cd:: with SMTP id o13mr30842150wrv.367.1574192642522; 
 Tue, 19 Nov 2019 11:44:02 -0800 (PST)
Received: from [192.168.8.102] (64.red-79-149-204.dynamicip.rima-tde.net.
 [79.149.204.64])
 by smtp.gmail.com with ESMTPSA id c9sm4090127wmb.42.2019.11.19.11.44.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 11:44:01 -0800 (PST)
Subject: Re: [PATCH] audio: fix audio recording
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?=
 <DirtY.iCE.hu@gmail.com>
References: <2fc947cf-7b42-de68-3f11-cbcf1c096be9@t-online.de>
 <a9ed793b-ebe7-b9da-3181-af246e16a59a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <780a707e-f80f-e83f-7fe5-31360050fdb0@linaro.org>
Date: Tue, 19 Nov 2019 20:43:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a9ed793b-ebe7-b9da-3181-af246e16a59a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 9:01 AM, Philippe Mathieu-Daudé wrote:
> Cc'ing Zoltán.
> 
> On 11/19/19 7:58 AM, Volker Rümelin wrote:
>> With current code audio recording with all audio backends
>> except PulseAudio and DirectSound is broken. The generic audio
>> recording buffer management forgot to update the current read
>> position after a read.
>>
>> Fixes: ff095e5231 "audio: api for mixeng code free backends"
>>
>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>> ---
>>   audio/audio.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/audio/audio.c b/audio/audio.c
>> index 7fc3aa9d16..56fae55047 100644
>> --- a/audio/audio.c
>> +++ b/audio/audio.c
>> @@ -1390,6 +1390,7 @@ void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t
>> *size)
>>           size_t read = hw->pcm_ops->read(hw, hw->buf_emul + hw->pos_emul,
>>                                           read_len);
>>           hw->pending_emul += read;
>> +        hw->pos_emul = (hw->pos_emul + read) % hw->size_emul;
> 
> Anyway since read() can return a negative value, both previous assignments
> should go after this if/break check...

This isn't read(2).

    size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);

Since this isn't ssize_t, no negative return value possible.


r~

