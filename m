Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600A1C76188
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 15:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C04C2085A
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 15:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMenmVVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C04C2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpDP7-0001Ql-2j
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 11:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42591)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hpDOt-0000zu-Ez
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 11:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hpDOr-0007V0-Lu
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 11:05:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hpDOr-0007UO-FA
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 11:05:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id n4so36846449wrs.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2019 08:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=o8B7B8RdO2Vqe9yCn8MY/dcfQitQRsm+Oz9t3pMllrc=;
 b=AMenmVVx8F9SEw6hOSbSnSt2F3AAOKzYjs51my0c2UckZtwjmmBSlCKKsm/bOTWJpT
 SRje4qXe/q+hf7gRd1jqAcpe81lQnub50Zxs+UnzO5JXsvioviyh7v80rESHUnIP1zcn
 MIjpTbFKwBri3lL8LfXfsa+rXZ1Oc8pLKUCbX925zvNICQ5qzeZF5OZUTq2XctSvBjuO
 PCBg0jLwi8ELNRy9wEh4165/onjXXBWMjiS4I2UN8P+111hF2tfqZ3VyNk8emQwo+UMc
 UFB5xQHG0SNDP3DD6Wuf6s+7p+6V/bi4uGpXuIn5q3Pp5RqulUgKPZGRfHHkVfVAUrvq
 +Qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o8B7B8RdO2Vqe9yCn8MY/dcfQitQRsm+Oz9t3pMllrc=;
 b=YBgPANXmFPPlNkuUWmmzCvswXSjFiGd7j5pdH9TPIRUZyOizby0ny8mK/oS6AezfLw
 gFceMr1k7/AgbIP96aKxDcHSw9aIa23nl/pB5Lo/9yoUj1Cl7XAu0r5tI7ujX25SeQto
 tduLKTWIqhHja5ty6jwHeD9i8EXpEdC/IszmKLC7rdeYcH+u/KTmSGOcC2SF1yunOoT4
 zKMNKXQl1n06ej76sKISfTsX1xubrsTPk+vYHBRrOIKp1IkdsKK++C8bjdU/QsS9P+Tc
 Tsh8XEXNHW5LsRv471kP0GI1EHJQt7oObbQZIoLMCn4DF2uJG2tOsny66PecHmAfoww7
 kmBQ==
X-Gm-Message-State: APjAAAUjUJbXyUhTChHHWgvjqY1ssC7LLxJJmqDZIHR2CMlbRJhtsRDD
 IMmPsEEIDAqpYXjmjTtIAQY=
X-Google-Smtp-Source: APXvYqxB6JDeRoN7aWy4u5M3DHwL/YMdt0oc434Og5jSR2YnVByI9nA+78vYM6MEE+al9NYjAPP1yw==
X-Received: by 2002:a5d:668e:: with SMTP id l14mr13355348wru.156.1563721520039; 
 Sun, 21 Jul 2019 08:05:20 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::d3?
 (2a01-036c-0113-08e2-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:8e2:1::d3])
 by smtp.gmail.com with ESMTPSA id n14sm65281475wra.75.2019.07.21.08.05.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 Jul 2019 08:05:19 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
References: <cover.1563224628.git.DirtY.iCE.hu@gmail.com>
 <8245dab2e59b99b55f3f7773fd39dc920ae48951.1563224628.git.DirtY.iCE.hu@gmail.com>
 <878ssyqyyu.fsf@dusky.pond.sub.org>
Message-ID: <b8009305-9e17-97e5-a57d-f78dd111f55b@gmail.com>
Date: Sun, 21 Jul 2019 17:05:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <878ssyqyyu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 03/14] audio: add audiodev property to
 vnc and wav_capture
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

On 2019-07-16 08:23, Markus Armbruster wrote:
> "Kővágó, Zoltán" <dirty.ice.hu@gmail.com> writes:
> 
>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>> ---
>>   ui/vnc.h        |  2 ++
>>   monitor/misc.c  | 12 +++++++++++-
>>   ui/vnc.c        | 15 ++++++++++++++-
>>   hmp-commands.hx | 13 ++++++++-----
>>   qemu-options.hx |  6 ++++++
>>   5 files changed, 41 insertions(+), 7 deletions(-)
>>
>> diff --git a/ui/vnc.h b/ui/vnc.h
>> index 2f84db3142..6f54653455 100644
>> --- a/ui/vnc.h
>> +++ b/ui/vnc.h
>> @@ -183,6 +183,8 @@ struct VncDisplay
>>   #ifdef CONFIG_VNC_SASL
>>       VncDisplaySASL sasl;
>>   #endif
>> +
>> +    AudioState *audio_state;
>>   };
>>   
>>   typedef struct VncTight {
>> diff --git a/monitor/misc.c b/monitor/misc.c
>> index e393333a0e..f97810d370 100644
>> --- a/monitor/misc.c
>> +++ b/monitor/misc.c
>> @@ -1148,7 +1148,17 @@ static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
>>       int bits = qdict_get_try_int(qdict, "bits", -1);
>>       int has_channels = qdict_haskey(qdict, "nchannels");
>>       int nchannels = qdict_get_try_int(qdict, "nchannels", -1);
>> +    const char *audiodev = qdict_get_try_str(qdict, "audiodev");
>>       CaptureState *s;
>> +    AudioState *as = NULL;
>> +
>> +    if (audiodev) {
>> +        as = audio_state_by_name(audiodev);
>> +        if (!as) {
>> +            monitor_printf(mon, "Invalid audiodev specified\n");
>> +            return;
>> +        }
>> +    }
> 
> Note for later: if "audiodev" is specified, it must name an existing
> AudioState.
> 
>>   
>>       s = g_malloc0 (sizeof (*s));
>>   
>> @@ -1156,7 +1166,7 @@ static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
>>       bits = has_bits ? bits : 16;
>>       nchannels = has_channels ? nchannels : 2;
>>   
>> -    if (wav_start_capture(NULL, s, path, freq, bits, nchannels)) {
>> +    if (wav_start_capture(as, s, path, freq, bits, nchannels)) {
>>           monitor_printf(mon, "Failed to add wave capture\n");
>>           g_free (s);
>>           return;
> 
> Note for later: this is the only other failure mode.
> 
>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index 140f364dda..24f9be5b5d 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -1222,7 +1222,7 @@ static void audio_add(VncState *vs)
>>       ops.destroy = audio_capture_destroy;
>>       ops.capture = audio_capture;
>>   
>> -    vs->audio_cap = AUD_add_capture(NULL, &vs->as, &ops, vs);
>> +    vs->audio_cap = AUD_add_capture(vs->vd->audio_state, &vs->as, &ops, vs);
>>       if (!vs->audio_cap) {
>>           error_report("Failed to add audio capture");
>>       }
>> @@ -3369,6 +3369,9 @@ static QemuOptsList qemu_vnc_opts = {
>>           },{
>>               .name = "non-adaptive",
>>               .type = QEMU_OPT_BOOL,
>> +        },{
>> +            .name = "audiodev",
>> +            .type = QEMU_OPT_STRING,
>>           },
>>           { /* end of list */ }
>>       },
>> @@ -3806,6 +3809,7 @@ void vnc_display_open(const char *id, Error **errp)
>>       const char *saslauthz;
>>       int lock_key_sync = 1;
>>       int key_delay_ms;
>> +    const char *audiodev;
>>   
>>       if (!vd) {
>>           error_setg(errp, "VNC display not active");
>> @@ -3991,6 +3995,15 @@ void vnc_display_open(const char *id, Error **errp)
>>       }
>>       vd->ledstate = 0;
>>   
>> +    audiodev = qemu_opt_get(opts, "audiodev");
>> +    if (audiodev) {
>> +        vd->audio_state = audio_state_by_name(audiodev);
>> +        if (!vd->audio_state) {
>> +            error_setg(errp, "Audiodev '%s' not found", audiodev);
>> +            goto fail;
>> +        }
>> +    }
> 
> Note for later: if "audiodev" is specified, it must name an existing
> AudioState.
> 
> I like this error message better than the one in hmp_wavcapture().  Use
> it there, too?
> 
> Move it into audio_state_by_name() by giving it an Error **errp
> parameter?  Matter of taste, up to you.
> 
>> +
>>       device_id = qemu_opt_get(opts, "display");
>>       if (device_id) {
>>           int head = qemu_opt_get_number(opts, "head", 0);
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index bfa5681dd2..fa7f009268 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -819,16 +819,19 @@ ETEXI
>>   
>>       {
>>           .name       = "wavcapture",
>> -        .args_type  = "path:F,freq:i?,bits:i?,nchannels:i?",
>> -        .params     = "path [frequency [bits [channels]]]",
>> +        .args_type  = "path:F,freq:i?,bits:i?,nchannels:i?,audiodev:s?",
>> +        .params     = "path [frequency [bits [channels [audiodev]]]]",
>>           .help       = "capture audio to a wave file (default frequency=44100 bits=16 channels=2)",
>>           .cmd        = hmp_wavcapture,
>>       },
>>   STEXI
>> -@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{channels}]]]
>> +@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{channels} [@var{audiodev}]]]]
>>   @findex wavcapture
>> -Capture audio into @var{filename}. Using sample rate @var{frequency}
>> -bits per sample @var{bits} and number of channels @var{channels}.
>> +Capture audio into @var{filename} from @var{audiodev}, using sample rate
>> +@var{frequency} bits per sample @var{bits} and number of channels
>> +@var{channels}. When not using an -audiodev argument on command line,
>> +@var{audiodev} must be omitted, otherwise is must specify a valid
>> +audiodev.
> 
> I can see the code for "must specify a valid audiodev" in
> hmp_wavcapture().  Where is "must be omitted" checked?

It's not checked right now, but if the user specifies audiodev, it must 
be a valid audiodev id.  So if the user can guess the id (which is not 
too hard ATM, it's simply the driver's name), it will work even in this 
case.

> Preexisting: the list "sample rate @var{frequency} bits per sample
> @var{bits} and number of channels @var{channels}" lacks a comma after
> @var{frequency}, please fix that.  I'd put one after @var{bits} as well,
> but that's a matter of taste[*]
> 
> The sentence is of the form "if not COND then A else B".  The
> less-negated form "if COND then B else A" is commonly easier to read.
> 
> Documentation says "from @var{audiodev}".  But when "not using an
> -audiodev argument on command line, +@var{audiodev} must be omitted".
> Where does it sample from then?  I figure from some default audio
> device.  Where is that default audio device explained?  I skimmed the
> -audiodev documentation in qemu-options.hx, but couldn't see it there.

Currently there are two ways to specify audio options, the legacy ones 
using the QEMU_AUDIO_* environment variables, and the new one using 
-audiodev arguments.  The two formats cannot be mixed, and eventually we 
should remove the legacy ones (IIRC my previous patch series already 
deprecated them), then we can get rid of this madness.  Maybe something 
like "When using the legacy environment variable based audio config, 
@var{audiodev} must be omitted." would be better?

> 
> Suggest to say "an -audiodev command line option" instead of "an
> -audiodev argument on command line".
> 
> Double-checking:
> 
> * -audiodev is the only way to create an audio backend.
> 
> * If the user creates no audio backend, QEMU supplies a default audio
>    backend.
> 
> Correct?

Not exactly a default audio backend, as it can be customized through 
environment variables, and as I previously said this is deprecated. 
When we remove the legacy config, there will be no default backend (like 
with -netdev and -device).

> Other kinds of backends can also be created at run-time with the
> monitor.  I'm not asking you provide that for audio.  I'm just wondering
> whether it could conceivably be useful.

Yes, since we can create new soundcard devices run-time, creating 
backends would make sense too.

> 
> If yes, you might want to avoid the narrow "if using -audiodev", and
> instead say "if the default audio device is in use".
> 
>>   
>>   Defaults:
>>   @itemize @minus
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 9621e934c0..a308e5f5aa 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1978,6 +1978,12 @@ can help the device and guest to keep up and not lose events in case
>>   events are arriving in bulk.  Possible causes for the latter are flaky
>>   network connections, or scripts for automated testing.
>>   
>> +@item audiodev=@var{audiodev}
>> +
>> +Use the specified @var{audiodev} when the VNC client requests audio
>> +transmission. When not using an -audiodev argument, this option must
>> +be omitted, otherwise is must be present and specify a valid audiodev.
>> +
>>   @end table
>>   ETEXI
> 
> Same as for wavcapture, basically.
> 
> 
> [*] https://en.wikipedia.org/wiki/Serial_comma
> 


