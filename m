Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D124C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 00:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0360922459
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 00:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDXrbQRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0360922459
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXE3i-0005Q3-4u
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 19:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iXE2h-0004yj-5c
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 19:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iXE2g-0007xs-82
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 19:40:23 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iXE2g-0007x6-1x
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 19:40:22 -0500
Received: by mail-wr1-x444.google.com with SMTP id w9so26096954wrr.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 16:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LjLoxN2IJL4Dbu9LWCN595/7N/dZUTENfBxnOW6hIpE=;
 b=iDXrbQRl02PnnNl6GBajS63cA6fk2nFgE0uIY5qG/E3dh8kcKSzj781NPVWlgozOwK
 3LqJJpENCsgkjXWVdQI61DS57eB5DavZEc47FoGReKskteps+v2S3hGWkz28PlUcSTr3
 qyIqUFLoMe9HQ8Qf5OAyAsk8E/HsbupTQdBCjDlgcDs760q0+KI6xJWwywBpSHAbU5E2
 8UNQDu6t5+CV7Viq/VFf5Qd4YHsxJx+uY4kdwJ1NBuQONU1ACrXHtFxNL7jxlEUBwQ8a
 Jrl4cBw1vPdE8QQW4N9g/u1vCQ7vsmDveZ5GYqU6rJUVqjkObnZkdj8o4jF6DOjGRrEK
 8AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LjLoxN2IJL4Dbu9LWCN595/7N/dZUTENfBxnOW6hIpE=;
 b=RLLrap36YYw1E7fELcr7eIHQKhKt1L23TQK72VDKgVSR2qUDmbGsaCV54A2MOxpFeN
 8i4WnZZoRGH0c06W9zyeSE+TehPzG38n0WVLls+h1bggck0c2wpTenhDtFI86Ohij7Aq
 Z6CENzu5sLxPlH9qLOjEhPjXeRFEZJgsFZDd782I7qUyvk60+gbnUZFxwYNqOx/i6HS4
 GS6k5topb2XtHPVWHUDPyzLEPQhG+mI8BRNk7RJkmDK4PbKvrqNukEdmJJ4DZk4t3mG5
 nip6CDavqYNoqBPnrfcjiBf78NyG9dCuy2EzGTg75pYSha7LDNe70f8bP8NrEwvxipO8
 0rtg==
X-Gm-Message-State: APjAAAWzupcBtgKCNk5zCqgHXoXyq+x/qGz/+LpOxvF0LmaqNBn8VqLC
 kciJyuhXflZtU+mXWEv3uYtR6Xa3
X-Google-Smtp-Source: APXvYqyBxNTYrhhuXKV4aZ8wm7I9rBG/k7sljYAXA48ADd+NehsaPhEommGicSWeKCg6bxRQRWfZjg==
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr211229wrn.103.1574210420741;
 Tue, 19 Nov 2019 16:40:20 -0800 (PST)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::1b?
 (2a01-036c-0113-0d0a-0001-0000-0000-001b.pool6.digikabel.hu.
 [2a01:36c:113:d0a:1::1b])
 by smtp.gmail.com with ESMTPSA id 17sm4735936wmg.19.2019.11.19.16.40.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 16:40:20 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
Subject: Re: [PATCH] audio: fix audio recording
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <2fc947cf-7b42-de68-3f11-cbcf1c096be9@t-online.de>
 <a9ed793b-ebe7-b9da-3181-af246e16a59a@redhat.com>
 <780a707e-f80f-e83f-7fe5-31360050fdb0@linaro.org>
Message-ID: <a5cd66a2-45a3-1d42-7eb6-1aa2317866bb@gmail.com>
Date: Wed, 20 Nov 2019 01:40:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <780a707e-f80f-e83f-7fe5-31360050fdb0@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

On 2019-11-19 20:43, Richard Henderson wrote:
> On 11/19/19 9:01 AM, Philippe Mathieu-Daudé wrote:
>> Cc'ing Zoltán.
>>
>> On 11/19/19 7:58 AM, Volker Rümelin wrote:
>>> With current code audio recording with all audio backends
>>> except PulseAudio and DirectSound is broken. The generic audio
>>> recording buffer management forgot to update the current read
>>> position after a read.
>>>
>>> Fixes: ff095e5231 "audio: api for mixeng code free backends"
>>>
>>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>>> ---
>>>    audio/audio.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/audio/audio.c b/audio/audio.c
>>> index 7fc3aa9d16..56fae55047 100644
>>> --- a/audio/audio.c
>>> +++ b/audio/audio.c
>>> @@ -1390,6 +1390,7 @@ void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t
>>> *size)
>>>            size_t read = hw->pcm_ops->read(hw, hw->buf_emul + hw->pos_emul,
>>>                                            read_len);
>>>            hw->pending_emul += read;
>>> +        hw->pos_emul = (hw->pos_emul + read) % hw->size_emul;
>>
>> Anyway since read() can return a negative value, both previous assignments
>> should go after this if/break check...
> 
> This isn't read(2).
> 
>      size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
> 
> Since this isn't ssize_t, no negative return value possible.

Yes, read failures are handled inside the backends.  If the backend 
really can't read anything, it'll return zero, which is harmless here.

Zoltan

