Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD39C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1526121848
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/H939dQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1526121848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2LFZ-0002Ii-7i
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 16:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i2LEU-0001Id-24
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 16:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i2LET-0004WU-08
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 16:04:53 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:37818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i2LES-0004WB-QP
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 16:04:52 -0400
Received: by mail-qt1-x843.google.com with SMTP id y26so19205000qto.4
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 13:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d3BIuTEPbYOdMrpbP7UNRH36z//xHl4HV2kirQMHKjo=;
 b=o/H939dQdh9CGVcTG5x1bhH10FklX4DDr5an/PLAWzg7oIjG+yOUlevWi9BmlLEdqR
 DJhr6Wwd6Smp/xwI+vaikSh0LU2XnUNutwh5e2tq1tiECXfGp8/eO9tIi51EkWzEiwl+
 e7VCZgAikcYnEkzEWhbwXXJJFlNuCBvrYec52gaVfYND0o4RBzM63xDk/Ky5EyWlL/F9
 FtooO/eeDbxO1TrnQLVlWGN/9yT1+YeGIYeVwwA5xr3pbgRBy0HEkw+f9GT5tUGVTSyQ
 DCY2moSkteU/xX1AIUPuUJtUJUPFHm8N07IqZrLK0Q1IhpRcyp26AJMpD2v0rbJsBMqg
 W/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d3BIuTEPbYOdMrpbP7UNRH36z//xHl4HV2kirQMHKjo=;
 b=kdocccKQerh8dzI+Kw8xmVi/Z+nFSuxj4vjzxSv9giKP0VHRQlMPpYpzwJDSCcu6+G
 aVCFs36Yhe+09s4af38FWXdI9ROQEoSz7OqLPlrTErWUAsMhAcSocB2mOYJfoQeqtC4m
 ckQ5+CQL853+rZ8ZiBIHdCeDt3vsrlxOEuzHgs4quhgml0Y0mxh65MD+g1PdvFA1d2a4
 vSVdUq4HFRTc3Ieob8rmiFJjRnTYWpkucumxXKn5OffcsJek/Wr6CYKkmx4tfT+WBvoE
 iChCpJkL0az1VBt7IgYo3SWseUlNm3uTTANvnW9hlEXU/ANS+REXGtqMHKuKDQJX3kEe
 Wmdw==
X-Gm-Message-State: APjAAAUHBDPghqG8/7oCqJPFi/3Wq47vIGfo5Xl+S0ESVv6Gid/c8Iuk
 7G9t3TKEil67Pa+XfNqPcOs=
X-Google-Smtp-Source: APXvYqztrwH20SjWSDYjK77GyinbH18A76LD0521CSzr8+heNZtsoLCHXbpephKlqZmZBlC77HdkFw==
X-Received: by 2002:aed:3327:: with SMTP id u36mr18759705qtd.94.1566849892182; 
 Mon, 26 Aug 2019 13:04:52 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc::5?
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.googlemail.com with ESMTPSA id b18sm5565503qkc.112.2019.08.26.13.04.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2019 13:04:51 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
 <76a0c0fda2f78cfb5f2234aa7e28073aa3e8bd95.1566755452.git.DirtY.iCE.hu@gmail.com>
 <1e59409e-1754-543f-28e1-03db2b01d634@redhat.com>
Message-ID: <90eee26d-ff1f-8ada-08ba-32ca1f27ae8e@gmail.com>
Date: Mon, 26 Aug 2019 22:04:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1e59409e-1754-543f-28e1-03db2b01d634@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: Re: [Qemu-devel] [PATCH 16/25] audio: add mixeng option
 (documentation)
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-08-26 15:35, Eric Blake wrote:
> On 8/25/19 1:46 PM, Kővágó, Zoltán wrote:
>> This will allow us to disable mixeng when we use a decent backend.
>>
>> Disabling mixeng have a few advantages:
>> * we no longer convert the audio output from one format to another, when
>>   the underlying audio system would just convert it to a third format.
>>   We no longer convert, only the underlying system, when needed.
>> * the underlying system probably has better resampling and sample format
>>   converting methods anyway...
>> * we may support formats that the mixeng currently does not support (S24
>>   or float samples, more than two channels)
>> * when using an audio server (like pulseaudio) different sound card
>>   outputs will show up as separate streams, even if we use only one
>>   backend
>>
>> Disadvantages:
>> * audio capturing no longer works (wavcapture, and vnc audio extension)
>> * some backends only support a single playback stream or very picky
>>   about the audio format.  In this case we can't disable mixeng.
>>
>> However mixeng is not removed, only made optional, so this shouldn't be
>> a big concern.
>>
>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>> ---
>>  qapi/audio.json | 5 +++++
>>  qemu-options.hx | 6 ++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/qapi/audio.json b/qapi/audio.json
>> index 9fefdf5186..dc7f9cb1e2 100644
>> --- a/qapi/audio.json
>> +++ b/qapi/audio.json
>> @@ -11,6 +11,10 @@
>>  # General audio backend options that are used for both playback and
>>  # recording.
>>  #
>> +# @mixeng: use QEMU's mixing engine to mix all streams inside QEMU. When set to
>> +#          off, fixed-settings must be also off. Not every backend compatible
>> +#          with the off setting (default on, since 4.2)
>> +#
> 
> 'mixeng' looks like an accidental typo, when 3 words later is 'mixing'.
> Would 'mix-eng' or 'mix-engine' be more obvious?

I used the spelling used in audio/mixeng.c, if we treat it as a name
then it should be simply 'mixeng'.  However I agree that it might not be
too meaningful for users, so 'mixing-engine' would make more sense, even
though it's a bit longer.

> 
> 
>>  ##
>>  { 'struct': 'AudiodevPerDirectionOptions',
>>    'data': {
>> +    '*mixeng':         'bool',
>>      '*fixed-settings': 'bool',
> 
> And the very next member is an example that QAPI doesn't have to use
> abbreviations.
> 

Regards,
Zoltan

