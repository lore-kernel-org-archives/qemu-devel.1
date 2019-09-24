Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2530C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 00:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F70B20820
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 00:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6s1MO+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F70B20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCYbT-0001mg-N2
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 20:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iCYaV-0001ID-3z
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iCYaT-0003iT-Oq
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:21:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iCYaT-0003hn-Gs
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:21:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id i18so15801881wru.11
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sJdgx4ciKOmuKUEE9HKzQAogTH2GvjXcD8DcJEoYEDs=;
 b=n6s1MO+vX/3Co30GoTEA1id800RHFkXVnV6xTqS1DjJMr3idfFo8ghOr5nuv06GsKP
 6TIg2Urn8DefUS66y1As1vLLJ9qarS1uxW3QM0XTAvbCmd5A3XA75YAZ2tiOiEe0ZghF
 0icHhakmvSlnxPBYixy3nJtgnjdGjhcULJobSP8V6Zmy3O2HMMT9wmdPDtw9hsUxPTbn
 0DOb3672fswQxipcgEko8Wp6SvYabjauLXVFloh27QtfM4nMRz8GBFBW/YMrNsOrQR2z
 /fWhofsm9MRV8bMbuCtpVA8YyXzDt6uTSIs4CYI0STSQqo+/Omyu7Fnc73yZkoQlatbw
 zUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sJdgx4ciKOmuKUEE9HKzQAogTH2GvjXcD8DcJEoYEDs=;
 b=OQ36VJa7Z0hmILWa/0IqrCbcTlBRCAzSzld+5L/nnCFgFeb8LtrrP8hwTvDa43+nMl
 IFvkIRL4lnvdhhmMoDETWBmuowPfbg/0C2BY9BDk2pYZSxynx5B84hqNFaepgZYI8afL
 Syye9U6ooUZ9LgjzJrGTFCLqSQs5426qNxful4kSiU+KiqerYerM8AMUUSVFHbKtogTj
 ia4SrPYJsFqAGHzVep/SK6b2LXl7T0r73LYe3466TKK1QVnAEvhAKhNYS3HOIUC0e0l/
 EbzqSiQS/J9MdCiv8RW+0AAfvvSMuHvtc00ZAyhfxrwMto+1kkAhoAHcF4OslQKnWL+1
 W8/Q==
X-Gm-Message-State: APjAAAWyalRNdscqAcjUrdCkwxH+pQ45HUb/MtSUuHQBaGbbWOcfyrTV
 RDoxJYu4ndI79rV7R6Tsf+q9QWBJ
X-Google-Smtp-Source: APXvYqyIb1T2S9fR7NSYcTvf0lucKSbzARbZ1bht8LYyfJANqAde4tAdwexmfvs3x1zt/S8/OL6u2A==
X-Received: by 2002:adf:bb8e:: with SMTP id q14mr13444wrg.74.1569284507747;
 Mon, 23 Sep 2019 17:21:47 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::d3?
 (2a01-036c-0113-40af-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:40af:1::d3])
 by smtp.gmail.com with ESMTPSA id o22sm46530wra.96.2019.09.23.17.21.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Sep 2019 17:21:47 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
Subject: Re: [PATCH v4 15/24] audio: add mixing-engine option (documentation)
To: Markus Armbruster <armbru@redhat.com>
References: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
 <68c4b4bd438e9cb5c97aed32ee31e3dabd96cbf6.1568927990.git.DirtY.iCE.hu@gmail.com>
 <87sgonma7v.fsf@dusky.pond.sub.org>
Message-ID: <4d24c95c-0e98-2646-0b1a-6c7b3afe0e90@gmail.com>
Date: Tue, 24 Sep 2019 02:21:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87sgonma7v.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-09-23 15:08, Markus Armbruster wrote:
> "Kővágó, Zoltán" <dirty.ice.hu@gmail.com> writes:
> 
>> This will allow us to disable mixeng when we use a decent backend.
>>
>> Disabling mixeng have a few advantages:
>> * we no longer convert the audio output from one format to another, when
>>    the underlying audio system would just convert it to a third format.
>>    We no longer convert, only the underlying system, when needed.
>> * the underlying system probably has better resampling and sample format
>>    converting methods anyway...
>> * we may support formats that the mixeng currently does not support (S24
>>    or float samples, more than two channels)
>> * when using an audio server (like pulseaudio) different sound card
>>    outputs will show up as separate streams, even if we use only one
>>    backend
>>
>> Disadvantages:
>> * audio capturing no longer works (wavcapture, and vnc audio extension)
>> * some backends only support a single playback stream or very picky
>>    about the audio format.  In this case we can't disable mixeng.
>>
>> However mixeng is not removed, only made optional, so this shouldn't be
>> a big concern.
>>
>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>> ---
>>
>> Notes:
>>      Changes from v1:
>>      
>>      * renamed mixeng to mixing-engine
>>
>>   qapi/audio.json | 5 +++++
>>   qemu-options.hx | 6 ++++++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/qapi/audio.json b/qapi/audio.json
>> index 9fefdf5186..0535eff794 100644
>> --- a/qapi/audio.json
>> +++ b/qapi/audio.json
>> @@ -11,6 +11,10 @@
>>   # General audio backend options that are used for both playback and
>>   # recording.
>>   #
>> +# @mixing-engine: use QEMU's mixing engine to mix all streams inside QEMU. When
>> +#                 set to off, fixed-settings must be also off. Not every backend
>> +#                 compatible with the off setting (default on, since 4.2)
>> +#
> 
> Last sentence no verb.
> 
> Which backends are compatible?

Actually that's a simplification, it depends on a few things.  When 
mixeng is off, qemu will try to use the same format as the emulated 
sound card, and if the backend doesn't support that format, it won't 
work (no audio).  Also attaching multiple sound cards to the same 
audiodev might not work, if the backend doesn't support multiple 
playback streams.  If you use pulseaudio, it'll work without problems, 
if you use alsa, it depends on your device.  If you use a hw: device 
directly, you'll likely only be able to use one emulated sound card with 
a few selected audio formats.  If you use dmix: (and plug), alsa will 
handle the conversion and mixing, so it will work no matter what format 
the emulated sound card uses.  With OSS the situation is probably 
similar, it depends on the kernel/hw what works and what not.  wav and 
spice certainly doesn't support multiple streams.  I'm not completely 
sure about the other backends right now, but I think dsound and 
coreaudio can handle the necessary sample format conversions and mixing.

> What happens when you try the off setting with incompatible backends?
See above.

> 
>>   # @fixed-settings: use fixed settings for host input/output. When off,
>>   #                  frequency, channels and format must not be
>>   #                  specified (default true)
>> @@ -31,6 +35,7 @@
>>   ##
>>   { 'struct': 'AudiodevPerDirectionOptions',
>>     'data': {
>> +    '*mixing-engine':  'bool',
>>       '*fixed-settings': 'bool',
>>       '*frequency':      'uint32',
>>       '*channels':       'uint32',
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index bbfd936d29..395427422a 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -433,6 +433,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
>>       "                specifies the audio backend to use\n"
>>       "                id= identifier of the backend\n"
>>       "                timer-period= timer period in microseconds\n"
>> +    "                in|out.mixing-engine= use mixing engine to mix streams inside QEMU\n"
>>       "                in|out.fixed-settings= use fixed settings for host audio\n"
>>       "                in|out.frequency= frequency to use with fixed settings\n"
>>       "                in|out.channels= number of channels to use with fixed settings\n"
>> @@ -503,6 +504,11 @@ Identifies the audio backend.
>>   Sets the timer @var{period} used by the audio subsystem in microseconds.
>>   Default is 10000 (10 ms).
>>   
>> +@item in|out.mixing-engine=on|off
>> +Use QEMU's mixing engine to mix all streams inside QEMU.  When off,
>> +@var{fixed-settings} must be off too.  Not every backend is fully
>> +compatible with the off setting.  Default is on.
>> +
>>   @item in|out.fixed-settings=on|off
>>   Use fixed settings for host audio.  When off, it will change based on
>>   how the guest opens the sound card.  In this case you must not specify


