Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A28EC74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 19:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1127A20838
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 19:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vaN9dQw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1127A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlIQc-0007Bc-Qo
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 15:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43287)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hlIPJ-0006fV-HH
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hlIPI-0008MM-EO
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:37:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hlIPI-0008JK-7l
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:37:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id n4so3708910wrs.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=B8POfTexiExHJFx59UEtfjEKKeMN1VtoHbcdymAsc6A=;
 b=vaN9dQw4vY4XiV79Uz7EQcvYHS/ULqYD4BS9wWXwwxo05oFKMPMBF42NaKSm3nCw8f
 36dO06xH5KnDQ72oXAWbI4pGdzxChbvexP9j2oVHWyf/7SyEd5jhvHBxLkIbbDC7Uus6
 5gfSdJcNdjmvY06Qzoti6szGA98UrtL3D3LoKdKJpSTQNwtXRNYnQulw7C85XhHYYp+d
 yTjNApwPrKYWO97Avx5h177MJ4Nlr0XbPrASO3PTN0Z/eFM6oK8tbWWTA3io34OlGBPz
 9pO9FYbY6jhnlAT/FGasnN518Ipghrwm6kCDhq/t75vulEw8L9BjoWiJ3DGdK2ed9yKx
 xSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B8POfTexiExHJFx59UEtfjEKKeMN1VtoHbcdymAsc6A=;
 b=GQ7wZUBH9eMn0bo+UPTG3qovbZ7foT/ZOChQsN3014B/fx61rYUSyyq7s2CgZ6uMBZ
 1XmE5G764wPpduLOvdeojfurisG27yczkQ8k387jqSX/Q5fcRU+zcjCl5U3DYaVMOfBy
 bjCdb4qIxIML2GPE5+EdS7qRWwF7BqW8Htmsr/0TMjNhFHcM+eSgdxEnTF5VMbq6t9E7
 bxpUDxZxjDPw58eKpnxIqdWw8Od4LwnRoJBj7mOmnWOcv6MnRcFGr8Ezoe/6SmstDQh2
 9brbV4O473cavNjDLZfjGRunmHGNmMI7KNVB+3HgflaBTlvsPiqTwSSMmrLnnkG6QRn/
 WvBA==
X-Gm-Message-State: APjAAAV8PO0Sj2+8AM1SZH7Fgv96f8rIpDUdZM6nV8f2aJnd9NUpsXqM
 kCQvb/NLWOA+sDVyBCkZjoI=
X-Google-Smtp-Source: APXvYqwTsGFD39Jvezz9g1llXoog5hOIdDiZ/icdIkoqJ0B5yiphl/OUlIxvXMTOIw0dYp7HODnpMQ==
X-Received: by 2002:adf:f204:: with SMTP id p4mr6441219wro.317.1562787453677; 
 Wed, 10 Jul 2019 12:37:33 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc::5?
 (2a01-036c-0113-6e3f-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6e3f::5])
 by smtp.googlemail.com with ESMTPSA id j189sm3538451wmb.48.2019.07.10.12.37.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 12:37:33 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
 <597ee579c3d14ff6f0892ee9e1905cdb0e0990ad.1562695780.git.DirtY.iCE.hu@gmail.com>
 <87ef2yy1n4.fsf@dusky.pond.sub.org>
Message-ID: <c0ada78b-6d77-936d-f059-3458ca74a156@gmail.com>
Date: Wed, 10 Jul 2019 21:37:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87ef2yy1n4.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 02/11] audio: basic support for multi
 backend audio
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-07-10 06:06, Markus Armbruster wrote:
> "Kővágó, Zoltán" <dirty.ice.hu@gmail.com> writes:
> 
>> Audio functions no longer access glob_audio_state, instead they get an
>> AudioState as a parameter.  This is required in order to support
>> multiple backends.
>>
>> glob_audio_state is also gone, and replaced with a tailq so we can store
>> more than one states.
>>
>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>> ---
> [...]
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index bfa5681dd2..23196da3fe 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -819,16 +819,17 @@ ETEXI
>>  
>>      {
>>          .name       = "wavcapture",
>> -        .args_type  = "path:F,freq:i?,bits:i?,nchannels:i?",
>> -        .params     = "path [frequency [bits [channels]]]",
>> +        .args_type  = "path:F,freq:i?,bits:i?,nchannels:i?,audiodev:s?",
>> +        .params     = "path [frequency [bits [channels [audiodev]]]]",
>>          .help       = "capture audio to a wave file (default frequency=44100 bits=16 channels=2)",
>>          .cmd        = hmp_wavcapture,
>>      },
>>  STEXI
>> -@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{channels}]]]
>> +@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{channels} [@var{audiodev}]]]]
>>  @findex wavcapture
>> -Capture audio into @var{filename}. Using sample rate @var{frequency}
>> -bits per sample @var{bits} and number of channels @var{channels}.
>> +Capture audio into @var{filename} from @var{audiodev}. Using sample rate
>> +@var{frequency} bits per sample @var{bits} and number of channels
>> +@var{channels}.
>>  
>>  Defaults:
>>  @itemize @minus
>    @item Sample rate = 44100 Hz - CD quality
>    @item Bits = 16
>    @item Number of channels = 2 - Stereo
>    @end itemize
>    ETEXI
> 
> Defaults for the other optional arguments are listed here.  Why not for
> @audiodev?

There's no default listed because there's no default when you use the
-audiodev options, since there's no good default.  When you don't use
-audiodev, it'll use the implicitly created audiodev which doesn't have
a name, so it can't be specified.  But I agree that this situation
should be documented somehow.

> 
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 9621e934c0..0111055aa4 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1978,6 +1978,11 @@ can help the device and guest to keep up and not lose events in case
>>  events are arriving in bulk.  Possible causes for the latter are flaky
>>  network connections, or scripts for automated testing.
>>  
>> +@item audiodev=@var{audiodev}
>> +
>> +Use the specified @var{audiodev} when the VNC client requests audio
>> +transmission.
>> +
> 
> What's the default?

It's the same story as wav_capture.

Regards,
Zoltan

