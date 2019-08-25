Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF76C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 23:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E792080C
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 23:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cez9CQKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E792080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i222A-0004yG-4q
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 19:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i221U-0004X4-6G
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 19:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i221T-0003xk-1O
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 19:34:12 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:34951)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i221S-0003wz-S3
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 19:34:10 -0400
Received: by mail-qt1-x843.google.com with SMTP id u34so16344268qte.2
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+O6IBfmZuZ3cWAMdrT8zT818FPBJyiBkiRiYPDXhew0=;
 b=cez9CQKQgzLhNLkTUW8Q5SXwxs7bo+t5pdkRX8sMK2Drra4O/ZapB3/DfUZZO1cXCn
 0iyfeB9DkOgsqO2Vx5rAAojOA2YRH4O8YfASut1UrqU3ZfALZicll7zpOLT0Q4WEvmIH
 M26LQf76jbw9WYWlx+yBQFY1EXfUBsEYXkHXnOPpKOy974dc097JcT66FA0YDQzNxkWM
 UMakatnWQr0U1oj0Of9JtnTX0JUbpWCKyuu+gZvWakiovqOwJgoQaUHF6m5G4z3da/vj
 GyCYp8ASAH+YB1Wekvs+8oG7M6L6Zd0hwe5GcnMEKV5ycXLPd0AHXRJH3iGforFdy47m
 Y6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+O6IBfmZuZ3cWAMdrT8zT818FPBJyiBkiRiYPDXhew0=;
 b=iK8fB57ckPqaD0YKAOT726bvHYBCaUN/Kut/nTqVLzjRKj/vgmPXXeoNlSGY9NjOde
 zzYJnpLNd9nykrZmf0Tb9NJGqUhXVINMszEKmHKU3zuirmMaHY6J1kxZ8aRX83Gkc4DH
 gHhrHGPBSA50XWluIsfKb0TiJ4NFFi1CMd2QlRe3trPloT36o9z9ORHE61XWkQSeu/Am
 JBbTvXNkiipboC3UArzg0J11MFwYI8p/H1/4BojxcxEtdrQkoeqSKwPUXzVZ449AKYnP
 MOkVzfdf3MBw3/HdaXHtuVjJpzWO93pD7HO3GfhKmHmo+fdah5OpFmxBhLx2KVfZsgr+
 hiFA==
X-Gm-Message-State: APjAAAW2b/KLiGL3TAXcw1hArORiU2vDjPLT/Y7cQxPF0z0UAEc2G/5C
 gea33nHfPN4wBdMiTV/zDJw=
X-Google-Smtp-Source: APXvYqwgNgJTNZS6ik34zzbAE5xPgDtc9JnjauYFx+7f5PFxZMBgBxpC6xG4kiMrSJlzcOoUxbJMCw==
X-Received: by 2002:aed:22b3:: with SMTP id p48mr13018152qtc.136.1566776050019; 
 Sun, 25 Aug 2019 16:34:10 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::d3?
 (2a01-036c-0113-61b1-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:61b1:1::d3])
 by smtp.gmail.com with ESMTPSA id 20sm5256715qkg.59.2019.08.25.16.34.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 16:34:09 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20190821084113.1840-1-kraxel@redhat.com>
 <20190821084113.1840-8-kraxel@redhat.com>
 <01aadba9669734bfde832a01bb62f7746a57f905.camel@redhat.com>
 <cc1b515e-de9b-8bb0-d1e1-94f038420853@gmail.com>
 <813e5200e860b3615e5e827bb3a761b503ef1702.camel@redhat.com>
Message-ID: <7d6c27a5-a09b-17b7-74c3-400fcfb10e4a@gmail.com>
Date: Mon, 26 Aug 2019 01:34:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <813e5200e860b3615e5e827bb3a761b503ef1702.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: Re: [Qemu-devel] [PULL 07/15] audio: audiodev= parameters no longer
 optional when -audiodev present
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
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Walle <michael@walle.cc>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-08-26 00:15, Maxim Levitsky wrote:
> On Sun, 2019-08-25 at 20:05 +0200, Zoltán Kővágó wrote:
>> On 2019-08-25 11:44, Maxim Levitsky wrote:
>>> On Wed, 2019-08-21 at 10:41 +0200, Gerd Hoffmann wrote:
>>>> From: Kővágó, Zoltán <dirty.ice.hu@gmail.com>
>>>>
>>>> This means you should probably stop using -soundhw (as it doesn't allow
>>>> you to specify any options) and add the device manually with -device.
>>>> The exception is pcspk, it's currently not possible to manually add it.
>>>> To use it with audiodev, use something like this:
>>>>
>>>>     -audiodev id=foo,... -global isa-pcspk.audiodev=foo -soundhw pcspk
>>>
>>> Hi!
>>
>> Hi,
>>
>>> There is one corner case this breaks.
>>> In qemu 4.1.0, there is no way to specify audiodev for a sound device, specifying it
>>> fails with error.
>>> So some of my machines have audiodev (which is miles better that using old env variables)
>>> but also have sound devices without audiodev reference since this wasn't supported.
>>>
>>>
>>> In what will be qemu 4.2, you must specify it, thus this kind of breaks backward compatibility.
>>> Maybe we can have audiodev reference optional for a version or two?
>>>
>>> This is just a minor itch, as otherwise the sound improvements are really good. The days
>>> of installing that old realtek driver are finally gone :-)
>>
>> Hmm, this is what happens when you split a patch series.  We could
>> either revert this patch, or alternatively turn the error messages into
>> warnings about using deprecated behavior.
> Warning would be great in this case!
>>
>>> Another thing I noted, that there is no way for pulseaudio audiodev to specify the 'client name',
>>> it always shows up in pavucontrl as the socket path to the server. 
>>> Thus if I added two PA audiodevs, I can't really distinguish between them.
>>> The in|out.name= seems to specify the pulseaudio source/sink to connect to, which is not the same.
>>
>> We currently supply the constant "qemu" as a name to pa_stream_new.
>> While it's still not ideal, shouldn't this end up as a client name in
>> pulseaudio instead of a socket path?
> 
> Actually it seems that pulseaudio has two names supplied for each stream
> Maybe stream name and application name?
> 
> This is how chromium playback looks versus qemu in pavucontrol and in gnome volume control.
> 
> https://imgur.com/a/I8HZhgx
> 
> I do notice that 'qemu' now, in pavucontrol though.

I see.  We currently pass the server socket to pa_context_new instead of
the client name.  I'll prepare a patch soon, thanks for the report!

Regards,
Zoltan

