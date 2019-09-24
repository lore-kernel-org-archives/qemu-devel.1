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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41196C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 00:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069C6207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 00:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1F3lQfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069C6207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCYwz-0006Go-2g
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 20:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iCYvm-0005nf-VB
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iCYvl-0005V7-9j
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:43:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iCYvl-0005Uk-1Q
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:43:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id i18so15831737wru.11
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 17:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wURrAhaxCbiqzjAikjDaa7fw+MWZZ6YslWE1/obZGD0=;
 b=k1F3lQfzKNt4MLkTYOPSyqLdPHy4pCSNIE0gVLvu10hAack9tnrreiYWv7OCZhoo8T
 NdUGkW+t09dz25iNMD1a3z721B7TAcUL4akNL74mGsK2xbCZS+IRB7Qj8MpUkkLlAA1T
 PafWdtDX3RO4loNz3KoDf4gSTRbdYhrqN/2OV1XLENcy3y5UJqS1p1DUyX4qIxxXy7Qc
 EvFKubagAUSzCd88ieXE1e3n5r6nJ4WnfKGLHQZbUXnbI1hientd2n3X7RuQGFQ+shgH
 MtHkARunqp3TIq3ZNNTJ31IVilfSBOx9BadKjhcZIMCj194ovPbf+yOe/qx092TURLeF
 JaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wURrAhaxCbiqzjAikjDaa7fw+MWZZ6YslWE1/obZGD0=;
 b=KfSyF0TMLCxNkv/BUraiveO6iIcVP+5v6okEphPOQ0b14cM9HjLrIzkM1ZHQL2emP/
 xPVmCrDuspDQMZQJBmBT3GxfbRd2LEU7Mcm+8J/D7S9Ql524Zhlnc3QHhAGbPsFyhgkQ
 9PohJDH2WnDl+Wxv927BRkL91bOxLrmxmXBM27k7RLGnmlotLLEOgNHtM0LTyUwGN4SB
 qUmlWywD13DweT0iGkdvRkBEK3kJBfsjC7WXzv08H8qOYn2RUmUHsgGIe1bn58fl3kAf
 JoawO2vfH1vTHUgI+FHXFtLHQDewzY0qMHxkESuz6TVpwSd7rB7ExE/OaqQOUtDAXL9Q
 a2XA==
X-Gm-Message-State: APjAAAVqH04ezBLcQNLX5hlvjj7T6sSOM/gi6Wg5048VoeWT2AYNl/CN
 wKtHWHy9/XQK6Yb7+ssQJjo=
X-Google-Smtp-Source: APXvYqzFt8zEiXvGP/oCC5oRdy+tzLaeuVqdzm8FAv9OnVH4DjXgalw2iwLCy8ItC90dkbvmlX8fFw==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr53596wro.38.1569285827649;
 Mon, 23 Sep 2019 17:43:47 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::d3?
 (2a01-036c-0113-40af-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:40af:1::d3])
 by smtp.gmail.com with ESMTPSA id f8sm40229wmb.37.2019.09.23.17.43.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Sep 2019 17:43:47 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
Subject: Re: [PATCH v4 21/24] paaudio: channel-map option
To: Markus Armbruster <armbru@redhat.com>
References: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
 <8f650662fd6cc50baaede260581aeb560eed44fb.1568927990.git.DirtY.iCE.hu@gmail.com>
 <87o8zbma1m.fsf@dusky.pond.sub.org>
Message-ID: <55ea6ac9-9651-e322-fd84-22b4bedb3a93@gmail.com>
Date: Tue, 24 Sep 2019 02:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87o8zbma1m.fsf@dusky.pond.sub.org>
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

On 2019-09-23 15:12, Markus Armbruster wrote:
> "Kővágó, Zoltán" <dirty.ice.hu@gmail.com> writes:
> 
>> Add an option to change the channel map used by pulseaudio.  If not
>> specified, falls back to an OSS compatible channel map.
>>
>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>> ---
>>   audio/paaudio.c | 18 ++++++++++++++----
>>   qapi/audio.json |  7 +++++--
>>   qemu-options.hx |  9 +++++++++
>>   3 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/audio/paaudio.c b/audio/paaudio.c
>> index d195b1caa8..20402b0718 100644
>> --- a/audio/paaudio.c
>> +++ b/audio/paaudio.c
>> @@ -338,17 +338,27 @@ static pa_stream *qpa_simple_new (
>>           pa_stream_direction_t dir,
>>           const char *dev,
>>           const pa_sample_spec *ss,
>> -        const pa_channel_map *map,
>> +        const char *map,
>>           const pa_buffer_attr *attr,
>>           int *rerror)
>>   {
>>       int r;
>>       pa_stream *stream;
>>       pa_stream_flags_t flags;
>> +    pa_channel_map pa_map;
>>   
>>       pa_threaded_mainloop_lock(c->mainloop);
>>   
>> -    stream = pa_stream_new(c->context, name, ss, map);
>> +    if (map && !pa_channel_map_parse(&pa_map, map)) {
>> +        dolog("Invalid channel map specified: '%s'\n", map);
>> +        map = NULL;
>> +    }
>> +    if (!map) {
>> +        pa_channel_map_init_extend(&pa_map, ss->channels,
>> +                                   PA_CHANNEL_MAP_OSS);
>> +    }
>> +
>> +    stream = pa_stream_new(c->context, name, ss, &pa_map);
>>       if (!stream) {
>>           goto fail;
>>       }
>> @@ -421,7 +431,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
>>           PA_STREAM_PLAYBACK,
>>           ppdo->has_name ? ppdo->name : NULL,
>>           &ss,
>> -        NULL,                   /* channel map */
>> +        ppdo->has_channel_map ? ppdo->channel_map : NULL,
>>           &ba,                    /* buffering attributes */
>>           &error
>>           );
>> @@ -470,7 +480,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>>           PA_STREAM_RECORD,
>>           ppdo->has_name ? ppdo->name : NULL,
>>           &ss,
>> -        NULL,                   /* channel map */
>> +        ppdo->has_channel_map ? ppdo->channel_map : NULL,
>>           &ba,                    /* buffering attributes */
>>           &error
>>           );
>> diff --git a/qapi/audio.json b/qapi/audio.json
>> index 0535eff794..07003808cb 100644
>> --- a/qapi/audio.json
>> +++ b/qapi/audio.json
>> @@ -214,13 +214,16 @@
>>   # @latency: latency you want PulseAudio to achieve in microseconds
>>   #           (default 15000)
>>   #
>> +# @channel-map: channel map to use (default: OSS compatible map, since: 4.2)
>> +#
>>   # Since: 4.0
>>   ##
>>   { 'struct': 'AudiodevPaPerDirectionOptions',
>>     'base': 'AudiodevPerDirectionOptions',
>>     'data': {
>> -    '*name': 'str',
>> -    '*latency': 'uint32' } }
>> +    '*name':        'str',
>> +    '*latency':     'uint32',
>> +    '*channel-map': 'str' } }
>>   
>>   ##
>>   # @AudiodevPaOptions:
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 395427422a..f3bc342f98 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -471,6 +471,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
>>       "-audiodev pa,id=id[,prop[=value][,...]]\n"
>>       "                server= PulseAudio server address\n"
>>       "                in|out.name= source/sink device name\n"
>> +    "                in|out.channel-map= channel map to use\n"
>>   #endif
>>   #ifdef CONFIG_AUDIO_SDL
>>       "-audiodev sdl,id=id[,prop[=value][,...]]\n"
>> @@ -636,6 +637,14 @@ Sets the PulseAudio @var{server} to connect to.
>>   @item in|out.name=@var{sink}
>>   Use the specified source/sink for recording/playback.
>>   
>> +@item in|out.channel-map=@var{map}
>> +Use the specified channel map.  The default is an OSS compatible
>> +channel map.  Do not forget to escape commas inside the map:
> 
> Awkward.
> 
>> +
>> +@example
>> +-audiodev pa,id=example,sink.channel-map=front-left,,front-right
>> +@end example
> 
> Makes me realize new AudiodevPaPerDirectionOptions member @channel-map
> is a list encoded in a string.  QAPI heavily frowns upon encoding stuff
> in strings.  Any reason why you can't (or don't want to) make it
> ['str']?

Hmm, I don't think it's used too frequently on structs parsed by qapi 
opts visitor. What would be the command line format in that case? 
Something like this?

-audiodev 
pa,id=example,sink.channel-map=front-left,sink.channel-map=front-right

I think it's simply a string because while conceptually it's a string, 
we don't try to interpret it, we just pass the string to 
pa_channel_map_parse.  Of course we could take a list and instead either 
rebuild the string or reimplement half of pa_channel_map_parse by 
manually calling pa_channel_position_from_string.
Oh now that I looked again at the pulseaudio docs, channel-map doesn't 
have to be a list, it can be also a "well-known mapping name".

> 
>> +
>>   @end table
>>   
>>   @item -audiodev sdl,id=@var{id}[,@var{prop}[=@var{value}][,...]]


