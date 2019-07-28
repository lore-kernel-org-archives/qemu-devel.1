Return-Path: <SRS0=P1lm=VZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC7AC433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 14:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B95F2064C
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 14:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvF8+pHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B95F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrjSS-0003bn-B1
	for qemu-devel@archiver.kernel.org; Sun, 28 Jul 2019 09:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36608)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hrjS2-0003DJ-Uy
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 09:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hrjS1-0001tx-5v
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 09:43:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hrjS0-0001sG-VK
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 09:43:01 -0400
Received: by mail-wr1-x441.google.com with SMTP id n4so59065082wrs.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2019 06:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DR5LEv+RFFYZJheqEjVxYEkzSvqTzSfygz3t4iT8QdM=;
 b=gvF8+pHLCBxk/CETaM6QwSsoCDbWxu8HGedeRjtthyBwgs+brl3XI7RXD1UQ99GS6Q
 H/heVXsQXKCT7aagbjS8s3WUkdsnr/A0pF/hBKnlzxnGPwX/O+AuPAMuRG+ZHHRiH9vf
 a8DNid20mVo0JueWCOSHh1jj0QbtppgCam85JgGNuMz2LMn45LiVefYouVfpaazxS+cw
 ASyq6eb4WMhE3fLPbw3hdmrNP6Yjho927a4hsU2pZohBamRjMmWNkGSaTVQydC4YlWCH
 52uA9cQO3ADU4xMivGkxPqJlk6/5PX0LzKjLMI4XwbMJIPS3gf8+ZvR2aWAdU0pYgXgg
 m3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DR5LEv+RFFYZJheqEjVxYEkzSvqTzSfygz3t4iT8QdM=;
 b=LHTNOpZwf+jJvw1BL1J6PPmwc4UNLqk0AcfLH+4qZOwi5K09O+WQGyqkQRcQDgWWAw
 hqh7o9ijfTrC9WKk7I9CaoX/oPMEcUBDX+tq8kxkQ1490GLat3UUrDxnT0I+3Q4r73wm
 WZOwn2iQtjj29WbXYI5Q08vSf5lW+ehKWnJRHQ2fzt+02cQocAo3AZWsTzhQJessVGaI
 uwOv0kUVDY9cO1QcLKANWcRbtN8JCh9ISn7Ri2/K0QWPuD9gnI0eNS+HGFJ7jaY+sKKc
 c5uQjCsP6ddGh7bPjGYZEPSC1ZkumhSeclQO0W8HB2Duq+LjcSYc3B/Srtb7zjdjrJYq
 aHeQ==
X-Gm-Message-State: APjAAAVldCrwR5jvbmtsAcDglulo5qHpE0/9p6EFIKDghEJ9TT5kCxB0
 ARgbivfyj9faamMIP/buMBE=
X-Google-Smtp-Source: APXvYqwDX2yepK1HlcPhZc8tgADXrwy/Qa5Q4kbXyfO1aD0Afx8ly95xvI6HesurwhnowTguL4Wpdg==
X-Received: by 2002:a5d:6287:: with SMTP id k7mr63170654wru.108.1564321379698; 
 Sun, 28 Jul 2019 06:42:59 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::54?
 (2a01-036c-0113-12e0-0001-0000-0000-0054.pool6.digikabel.hu.
 [2a01:36c:113:12e0:1::54])
 by smtp.gmail.com with ESMTPSA id v18sm61184119wrs.80.2019.07.28.06.42.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 28 Jul 2019 06:42:59 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
References: <cover.1563224628.git.DirtY.iCE.hu@gmail.com>
 <8245dab2e59b99b55f3f7773fd39dc920ae48951.1563224628.git.DirtY.iCE.hu@gmail.com>
 <878ssyqyyu.fsf@dusky.pond.sub.org>
 <b8009305-9e17-97e5-a57d-f78dd111f55b@gmail.com>
 <87lfwqywsa.fsf@dusky.pond.sub.org>
Message-ID: <59720be5-241e-be50-2b0f-be611cff7dbc@gmail.com>
Date: Sun, 28 Jul 2019 15:42:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87lfwqywsa.fsf@dusky.pond.sub.org>
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-07-22 16:21, Markus Armbruster wrote:
> "Zoltán Kővágó" <dirty.ice.hu@gmail.com> writes:
> 
>> On 2019-07-16 08:23, Markus Armbruster wrote:
>>> "Kővágó, Zoltán" <dirty.ice.hu@gmail.com> writes:
>>>
>>>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>>>> ---
>>>>    ui/vnc.h        |  2 ++
>>>>    monitor/misc.c  | 12 +++++++++++-
>>>>    ui/vnc.c        | 15 ++++++++++++++-
>>>>    hmp-commands.hx | 13 ++++++++-----
>>>>    qemu-options.hx |  6 ++++++
>>>>    5 files changed, 41 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/ui/vnc.h b/ui/vnc.h
>>>> index 2f84db3142..6f54653455 100644
>>>> --- a/ui/vnc.h
>>>> +++ b/ui/vnc.h
>>>> @@ -183,6 +183,8 @@ struct VncDisplay
>>>>    #ifdef CONFIG_VNC_SASL
>>>>        VncDisplaySASL sasl;
>>>>    #endif
>>>> +
>>>> +    AudioState *audio_state;
>>>>    };
>>>>      typedef struct VncTight {
>>>> diff --git a/monitor/misc.c b/monitor/misc.c
>>>> index e393333a0e..f97810d370 100644
>>>> --- a/monitor/misc.c
>>>> +++ b/monitor/misc.c
>>>> @@ -1148,7 +1148,17 @@ static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
>>>>        int bits = qdict_get_try_int(qdict, "bits", -1);
>>>>        int has_channels = qdict_haskey(qdict, "nchannels");
>>>>        int nchannels = qdict_get_try_int(qdict, "nchannels", -1);
>>>> +    const char *audiodev = qdict_get_try_str(qdict, "audiodev");
>>>>        CaptureState *s;
>>>> +    AudioState *as = NULL;
>>>> +
>>>> +    if (audiodev) {
>>>> +        as = audio_state_by_name(audiodev);
>>>> +        if (!as) {
>>>> +            monitor_printf(mon, "Invalid audiodev specified\n");
>>>> +            return;
>>>> +        }
>>>> +    }
>>>
>>> Note for later: if "audiodev" is specified, it must name an existing
>>> AudioState.
>>>
>>>>          s = g_malloc0 (sizeof (*s));
>>>>    @@ -1156,7 +1166,7 @@ static void hmp_wavcapture(Monitor *mon,
>>>> const QDict *qdict)
>>>>        bits = has_bits ? bits : 16;
>>>>        nchannels = has_channels ? nchannels : 2;
>>>>    -    if (wav_start_capture(NULL, s, path, freq, bits, nchannels))
>>>> {
>>>> +    if (wav_start_capture(as, s, path, freq, bits, nchannels)) {
>>>>            monitor_printf(mon, "Failed to add wave capture\n");
>>>>            g_free (s);
>>>>            return;
>>>
>>> Note for later: this is the only other failure mode.
>>>
>>>> diff --git a/ui/vnc.c b/ui/vnc.c
>>>> index 140f364dda..24f9be5b5d 100644
>>>> --- a/ui/vnc.c
>>>> +++ b/ui/vnc.c
>>>> @@ -1222,7 +1222,7 @@ static void audio_add(VncState *vs)
>>>>        ops.destroy = audio_capture_destroy;
>>>>        ops.capture = audio_capture;
>>>>    -    vs->audio_cap = AUD_add_capture(NULL, &vs->as, &ops, vs);
>>>> +    vs->audio_cap = AUD_add_capture(vs->vd->audio_state, &vs->as, &ops, vs);
>>>>        if (!vs->audio_cap) {
>>>>            error_report("Failed to add audio capture");
>>>>        }
>>>> @@ -3369,6 +3369,9 @@ static QemuOptsList qemu_vnc_opts = {
>>>>            },{
>>>>                .name = "non-adaptive",
>>>>                .type = QEMU_OPT_BOOL,
>>>> +        },{
>>>> +            .name = "audiodev",
>>>> +            .type = QEMU_OPT_STRING,
>>>>            },
>>>>            { /* end of list */ }
>>>>        },
>>>> @@ -3806,6 +3809,7 @@ void vnc_display_open(const char *id, Error **errp)
>>>>        const char *saslauthz;
>>>>        int lock_key_sync = 1;
>>>>        int key_delay_ms;
>>>> +    const char *audiodev;
>>>>          if (!vd) {
>>>>            error_setg(errp, "VNC display not active");
>>>> @@ -3991,6 +3995,15 @@ void vnc_display_open(const char *id, Error **errp)
>>>>        }
>>>>        vd->ledstate = 0;
>>>>    +    audiodev = qemu_opt_get(opts, "audiodev");
>>>> +    if (audiodev) {
>>>> +        vd->audio_state = audio_state_by_name(audiodev);
>>>> +        if (!vd->audio_state) {
>>>> +            error_setg(errp, "Audiodev '%s' not found", audiodev);
>>>> +            goto fail;
>>>> +        }
>>>> +    }
>>>
>>> Note for later: if "audiodev" is specified, it must name an existing
>>> AudioState.
>>>
>>> I like this error message better than the one in hmp_wavcapture().  Use
>>> it there, too?
>>>
>>> Move it into audio_state_by_name() by giving it an Error **errp
>>> parameter?  Matter of taste, up to you.
>>>
>>>> +
>>>>        device_id = qemu_opt_get(opts, "display");
>>>>        if (device_id) {
>>>>            int head = qemu_opt_get_number(opts, "head", 0);
>>>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>>>> index bfa5681dd2..fa7f009268 100644
>>>> --- a/hmp-commands.hx
>>>> +++ b/hmp-commands.hx
>>>> @@ -819,16 +819,19 @@ ETEXI
>>>>          {
>>>>            .name       = "wavcapture",
>>>> -        .args_type  = "path:F,freq:i?,bits:i?,nchannels:i?",
>>>> -        .params     = "path [frequency [bits [channels]]]",
>>>> +        .args_type  = "path:F,freq:i?,bits:i?,nchannels:i?,audiodev:s?",
>>>> +        .params     = "path [frequency [bits [channels [audiodev]]]]",
>>>>            .help       = "capture audio to a wave file (default frequency=44100 bits=16 channels=2)",
>>>>            .cmd        = hmp_wavcapture,
>>>>        },
>>>>    STEXI
>>>> -@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{channels}]]]
>>>> +@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{channels} [@var{audiodev}]]]]
>>>>    @findex wavcapture
>>>> -Capture audio into @var{filename}. Using sample rate @var{frequency}
>>>> -bits per sample @var{bits} and number of channels @var{channels}.
>>>> +Capture audio into @var{filename} from @var{audiodev}, using sample rate
>>>> +@var{frequency} bits per sample @var{bits} and number of channels
>>>> +@var{channels}. When not using an -audiodev argument on command line,
>>>> +@var{audiodev} must be omitted, otherwise is must specify a valid
>>>> +audiodev.
>>>
>>> I can see the code for "must specify a valid audiodev" in
>>> hmp_wavcapture().  Where is "must be omitted" checked?
>>
>> It's not checked right now, but if the user specifies audiodev, it
>> must be a valid audiodev id.  So if the user can guess the id (which
>> is not too hard ATM, it's simply the driver's name), it will work even
>> in this case.
>>
>>> Preexisting: the list "sample rate @var{frequency} bits per sample
>>> @var{bits} and number of channels @var{channels}" lacks a comma after
>>> @var{frequency}, please fix that.  I'd put one after @var{bits} as well,
>>> but that's a matter of taste[*]
>>>
>>> The sentence is of the form "if not COND then A else B".  The
>>> less-negated form "if COND then B else A" is commonly easier to read.
>>>
>>> Documentation says "from @var{audiodev}".  But when "not using an
>>> -audiodev argument on command line, +@var{audiodev} must be omitted".
>>> Where does it sample from then?  I figure from some default audio
>>> device.  Where is that default audio device explained?  I skimmed the
>>> -audiodev documentation in qemu-options.hx, but couldn't see it there.
>>
>> Currently there are two ways to specify audio options, the legacy ones
>> using the QEMU_AUDIO_* environment variables, and the new one using
>> -audiodev arguments.  The two formats cannot be mixed, and eventually
>> we should remove the legacy ones (IIRC my previous patch series
>> already deprecated them), then we can get rid of this madness.  Maybe
>> something like "When using the legacy environment variable based audio
>> config, @var{audiodev} must be omitted." would be better?
> 
> What about effectively de-documenting the deprecated method?  I.e. write
> as if it was already gone.  This should result in more readable
> documentation.

Makes sense.  User will less likely use deprecated methods that way and 
it simplifies the documentation.

> Double-checking: will audiodev become mandatory once the deprecated
> method is gone?

Yes.

> 
>>>
>>> Suggest to say "an -audiodev command line option" instead of "an
>>> -audiodev argument on command line".
>>>
>>> Double-checking:
>>>
>>> * -audiodev is the only way to create an audio backend.
>>>
>>> * If the user creates no audio backend, QEMU supplies a default audio
>>>     backend.
>>>
>>> Correct?
>>
>> Not exactly a default audio backend, as it can be customized through
>> environment variables, and as I previously said this is
>> deprecated. When we remove the legacy config, there will be no default
>> backend (like with -netdev and -device).
> 
> Thanks, I see more clearly now.
> 
>>> Other kinds of backends can also be created at run-time with the
>>> monitor.  I'm not asking you provide that for audio.  I'm just wondering
>>> whether it could conceivably be useful.
>>
>> Yes, since we can create new soundcard devices run-time, creating
>> backends would make sense too.
>>
>>>
>>> If yes, you might want to avoid the narrow "if using -audiodev", and
>>> instead say "if the default audio device is in use".
>>>
>>>>      Defaults:
>>>>    @itemize @minus
>>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>>> index 9621e934c0..a308e5f5aa 100644
>>>> --- a/qemu-options.hx
>>>> +++ b/qemu-options.hx
>>>> @@ -1978,6 +1978,12 @@ can help the device and guest to keep up and not lose events in case
>>>>    events are arriving in bulk.  Possible causes for the latter are flaky
>>>>    network connections, or scripts for automated testing.
>>>>    +@item audiodev=@var{audiodev}
>>>> +
>>>> +Use the specified @var{audiodev} when the VNC client requests audio
>>>> +transmission. When not using an -audiodev argument, this option must
>>>> +be omitted, otherwise is must be present and specify a valid audiodev.
>>>> +
>>>>    @end table
>>>>    ETEXI
>>>
>>> Same as for wavcapture, basically.
>>>
>>>
>>> [*] https://en.wikipedia.org/wiki/Serial_comma
>>>


