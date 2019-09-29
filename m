Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F46CC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 19:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F2D217F5
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 19:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl6lkqxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F2D217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEeXs-0001qQ-EL
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 15:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iEeX9-0001RQ-CW
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 15:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iEeX7-0007JF-Li
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 15:07:03 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37821)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iEeX7-0007Hi-Eo
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 15:07:01 -0400
Received: by mail-wm1-x343.google.com with SMTP id f22so10334343wmc.2
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2019 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=K+5SyWd5MtcRzqDJ1JI7K3CEI5K3zmegxFs8l90y8ms=;
 b=cl6lkqxuoyicUzCsZ2D0U/ulhyif6o//zzQedRBWGuTWlOzYM4kYzGgiRn+n0uB4h7
 OUsfHfg/LtuDBpF47z8+AZ27hfONowHxOeRTuPjdfZXl0bpxol8CkOQFIZpIX3m0XF1g
 1yw4Xhkyukmwyv5WGSwBmdphBVFzbALwMlOyFW/HQmtHPkpn3e3KwXdC2/liUKV3DS25
 C6fxpq1gFSkGbDcDWRP0vGRy5oHVYZ3rCqsxfyFrXH+Jidtfp7aR71vl6VQd/1hjr0i0
 8B0iyQDkqLhhdZNzFdAIZDJdD0CKNw8Tt+3fJXSLJZw7UVwAJMaxDG3lUdY9JmxWpez1
 AREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K+5SyWd5MtcRzqDJ1JI7K3CEI5K3zmegxFs8l90y8ms=;
 b=sOsT35MPlvahNh30b9JaDipUX2lHBInxA7onbsLNLzAHm+wkCXkqpcyQtug3pgKfln
 VInnja2Zto3Hr4/LKz89CHbJ0liHePinLEkQai4Jf7yoM/UlqtdcOEbP90jj3ubR/aUE
 b9cqQg0ZKiMyy1At4pW9hHM7Mo+B29b/mEk73+MA1W3J+euBaQyUi2jgBDfaTSuRDFyr
 SAq6F2b4hCKH2fux3157tBQJSyZRIZPZq41MoJ4sOKZ4Wpvf25QiM5DPZD/9FJmaYRYc
 Fho9ZbR2UHBOATt0/gy7SpfGV6A/K8xVgWp0yWmCmkIRXHbaYni/ijvyyUnaytYeB2tb
 MTFg==
X-Gm-Message-State: APjAAAX06TYfH3wSzbqO1o+wsNyf0NXl+YkM7nHMmzi8MN8MBAOQg6E9
 T48HPveoYEexw+UAhOfmViA=
X-Google-Smtp-Source: APXvYqxbvkg5QXsLL7J7ycQDrHEKKqytPUw56mNWDQbRzYUzhmu7a7SrGGBorgShaOprqXV4MDOlPQ==
X-Received: by 2002:a1c:1d8d:: with SMTP id d135mr15186831wmd.7.1569784020015; 
 Sun, 29 Sep 2019 12:07:00 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc::5?
 (2a01-036c-0113-e8f4-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:e8f4::5])
 by smtp.googlemail.com with ESMTPSA id w4sm9699842wrv.66.2019.09.29.12.06.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 29 Sep 2019 12:06:59 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
Subject: Re: [PATCH v4 15/24] audio: add mixing-engine option (documentation)
To: Markus Armbruster <armbru@redhat.com>
References: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
 <68c4b4bd438e9cb5c97aed32ee31e3dabd96cbf6.1568927990.git.DirtY.iCE.hu@gmail.com>
 <87sgonma7v.fsf@dusky.pond.sub.org>
 <4d24c95c-0e98-2646-0b1a-6c7b3afe0e90@gmail.com>
 <87wodwyabl.fsf@dusky.pond.sub.org>
Message-ID: <cacb71d0-494f-e05d-dece-637579b0c6d9@gmail.com>
Date: Sun, 29 Sep 2019 21:07:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87wodwyabl.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-09-25 11:49, Markus Armbruster wrote:
> "Zoltán Kővágó" <dirty.ice.hu@gmail.com> writes:
> 
>> On 2019-09-23 15:08, Markus Armbruster wrote:
>>> "Kővágó, Zoltán" <dirty.ice.hu@gmail.com> writes:
>>>
>>>> This will allow us to disable mixeng when we use a decent backend.
>>>>
>>>> Disabling mixeng have a few advantages:
>>>> * we no longer convert the audio output from one format to another, when
>>>>     the underlying audio system would just convert it to a third format.
>>>>     We no longer convert, only the underlying system, when needed.
>>>> * the underlying system probably has better resampling and sample format
>>>>     converting methods anyway...
>>>> * we may support formats that the mixeng currently does not support (S24
>>>>     or float samples, more than two channels)
>>>> * when using an audio server (like pulseaudio) different sound card
>>>>     outputs will show up as separate streams, even if we use only one
>>>>     backend
>>>>
>>>> Disadvantages:
>>>> * audio capturing no longer works (wavcapture, and vnc audio extension)
>>>> * some backends only support a single playback stream or very picky
>>>>     about the audio format.  In this case we can't disable mixeng.
>>>>
>>>> However mixeng is not removed, only made optional, so this shouldn't be
>>>> a big concern.
>>>>
>>>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>>>> ---
>>>>
>>>> Notes:
>>>>       Changes from v1:
>>>>            * renamed mixeng to mixing-engine
>>>>
>>>>    qapi/audio.json | 5 +++++
>>>>    qemu-options.hx | 6 ++++++
>>>>    2 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/qapi/audio.json b/qapi/audio.json
>>>> index 9fefdf5186..0535eff794 100644
>>>> --- a/qapi/audio.json
>>>> +++ b/qapi/audio.json
>>>> @@ -11,6 +11,10 @@
>>>>    # General audio backend options that are used for both playback and
>>>>    # recording.
>>>>    #
>>>> +# @mixing-engine: use QEMU's mixing engine to mix all streams inside QEMU. When
>>>> +#                 set to off, fixed-settings must be also off. Not every backend
>>>> +#                 compatible with the off setting (default on, since 4.2)
>>>> +#
>>>
>>> Last sentence no verb.
>>>
>>> Which backends are compatible?
>>
>> Actually that's a simplification, it depends on a few things.  When
>> mixeng is off, qemu will try to use the same format as the emulated
>> sound card, and if the backend doesn't support that format, it won't
>> work (no audio).  Also attaching multiple sound cards to the same
>> audiodev might not work, if the backend doesn't support multiple
>> playback streams.  If you use pulseaudio, it'll work without problems,
>> if you use alsa, it depends on your device.  If you use a hw: device
>> directly, you'll likely only be able to use one emulated sound card
>> with a few selected audio formats.  If you use dmix: (and plug), alsa
>> will handle the conversion and mixing, so it will work no matter what
>> format the emulated sound card uses.  With OSS the situation is
>> probably similar, it depends on the kernel/hw what works and what not.
>> wav and spice certainly doesn't support multiple streams.  I'm not
>> completely sure about the other backends right now, but I think dsound
>> and coreaudio can handle the necessary sample format conversions and
>> mixing.
>>
>>> What happens when you try the off setting with incompatible backends?
>> See above.
> 
> What happens *exactly*?
> 
> I'm asking because I'm concerned about the user experience.  When a user
> asks for a combination of things QEMU can't provide, such as mixeng off
> with an incompatible backend, QEMU should fail with a suitable error
> message.  Does it?

Error handling is not the best in the audio subsystem, if something 
fails it generally just prints a warning to the console and continues, 
and something will happen...  For example, this is what happens when I 
try to open one hw device twice. I ran qemu with:

-audiodev 
alsa,id=foo,in.dev=hw:1,,0,out.mixing-engine=off,out.dev=hw:1,,0 -device 
piix4-usb-uhci -device usb-audio,audiodev=foo -device AC97,audiodev=foo

When the guest tried to initialize the AC97 card, I got an error:

alsa: Could not initialize DAC
alsa: Failed to open `hw:1,0':
alsa: Reason: Device or resource busy

And it just continued. And the sound worked, but with wrong sample rate 
(AC97 wants 44100 Hz, but USB audio previously opened the alsa device 
with 48000 Hz).  I'll fix this bug in the next revision, 
audio_pcm_hw_add_* shouldn't fall back to other HWs without mixeng.  But 
even with that, the result will be that one emulated sound card will 
work and the other won't.

It's not ideal, but fixing it would require a lot of effort.  Right now, 
if you specify an invalid audiodev for alsa (even with mixeng), it'll 
just print an error to the console and continue without audio.

> Sometimes rejecting non-working configurations is impractical.  Is it
> here?

I think it is.  It depends on the backend, its settings, the frontend 
(emulated sound card), and how the guest uses it.  We currently don't 
know what formats does a backend support, what formats can a frontend 
produce, and even if we would know that, just because a frontend can 
produce a format that the backend doesn't understand doesn't mean that 
it will actually do it.  For example, right now with this patch series 
applied, usb-audio can produce 7.1 audio.  If we want to be strict, it 
means we can only use it with backends that support at least 8 channels, 
even if the user only wants to use stereo audio.

> If yes, we should call out the problematic configurations in
> documentation.

I think we should rather list known working configurations, and leave 
the others as "try at your own risk" because there's too many things 
that can go wrong.  (pulseaudio will work, alsa with dmix too.  Need to 
check coreaudio, dsound and oss.  spice and wavcapture won't work.)

Regards,
Zoltan

