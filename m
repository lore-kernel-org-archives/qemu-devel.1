Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF125C742D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 15:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8352063F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 15:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddFNmuTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8352063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmgJX-0002T9-RK
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 11:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33794)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hmgJN-00024d-Hj
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 11:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hmgJM-0004jN-GW
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 11:21:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hmgJM-0004iF-9r
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 11:21:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id p13so14458812wru.10
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 08:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nHU6Z2UsCXtbi8xWIC6XJ84/Y2ZjeN1jqRrI9ETfoFY=;
 b=ddFNmuTAvYp3n9W+zHBFvx3YygM8wMSBJS4Z8840mvlpKbZcGNmclKzIfnrjlWFdao
 eVUBvfGhP5shkBI1hax3e1thCXXGVJbRNXBFyAYZpHKBcufWKv4CWTunc0tdeoH9jPlP
 iKO/J3VBBWBUZ8s7CZgiij9e2wY/pxDnePtuU1wKZtUNlt1FrP2G8B+7IWoOJ13a57Pq
 RHruZbz0V2kfjoixEpMJk6xdFQMXE7/wkOnqku+Gor0uuSgZ9T4B359xuM1FaBFDA9P7
 AE2jgzFg7qJ7uoKIu4LverFFjnaHatlnr+n7sT9aV+V/BrpklNcf0zwHAWx858GI7AGq
 huQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nHU6Z2UsCXtbi8xWIC6XJ84/Y2ZjeN1jqRrI9ETfoFY=;
 b=ivOVJp629HEKepP/FRHtkkIFK6CZA7cB+esouu5aPvs8KCGYGyzlhTAI3dHVN0/NXe
 nGUaV/2VaoT6Yq5pfEEleutvHsy6fv8HMNjLiyC24wqPTwFFt9EjABMrflXyLruPJxQu
 IeDNg+qZk+q7BW9MiFHA7Vz04R1YpKyLxmdOXs+SzHEZ/aRvg8fiTHkpcCBU9DwEy1WX
 EOnY5E8GQL0JyWBZ++eGNLDsJI24QGvlgJ0kCvEobhmbxQJQzK+wf2aXyI27ZeTyjoVd
 m7SUh6TlP0DtNIg8aQoI/3hXdPye5CAW/BMr3yxg5PWp21olC1BOZhEe2OAaDnUZzj5C
 N2Rg==
X-Gm-Message-State: APjAAAUJX+Y/Kf48f3vQpbadHCUG2AQElSKlcy5lV7yCoUT+xJAkQzhr
 aTDe1ZmipiCByCtsrtNUzb8=
X-Google-Smtp-Source: APXvYqz9Nipwf4v+bZf9pqBi/X0UtnQFCWJ5/WGozZN1UJR6jmuaeKomY+8SuVBVPwZERb+eOPvvog==
X-Received: by 2002:adf:a299:: with SMTP id s25mr16337542wra.74.1563117670601; 
 Sun, 14 Jul 2019 08:21:10 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc::5?
 (2a01-036c-0113-31ca-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:31ca::5])
 by smtp.googlemail.com with ESMTPSA id m24sm9014213wmi.39.2019.07.14.08.21.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Jul 2019 08:21:10 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
 <090ab2fb6a10d601e68012b4152c2dba7a902ca4.1562695780.git.DirtY.iCE.hu@gmail.com>
 <CAJ+F1C+LZp0-0D7gkbfTKHY91FpFyeMKOQRu1NVGwMe-ycEJ1g@mail.gmail.com>
Message-ID: <05fc3584-c89d-1914-fa3d-1dff89e92d55@gmail.com>
Date: Sun, 14 Jul 2019 17:21:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+LZp0-0D7gkbfTKHY91FpFyeMKOQRu1NVGwMe-ycEJ1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 09/11] paaudio: fix playback glitches
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
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-07-10 21:58, Marc-André Lureau wrote:
> On Tue, Jul 9, 2019 at 10:49 PM Kővágó, Zoltán <dirty.ice.hu@gmail.com> wrote:
>>
>> Pulseaudio normally assumes that when the server wants it, the client
>> can generate the audio samples and send it right away.  Unfortunately
>> this is not the case with QEMU -- it's up to the emulated system when
>> does it generate the samples.  Buffering the samples and sending them
>> from a background thread is just a workaround, that doesn't work too
>> well.  Instead enable pa's compatibility support and let pa worry about
>> the details.
>>
>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
> 
> Could you explain how this is related to PA_STREAM_ADJUST_LATENCY ?

According to the pulseaudio documentation[1], you can't use
PA_STREAM_ADJUST_LATENCY and PA_STREAM_EARLY_REQUESTS at the same time.

[1]:
https://www.freedesktop.org/software/pulseaudio/doxygen/def_8h.html#a6966d809483170bc6d2e6c16188850fca98e436f686fc385697e565eb1ecb2609

>> ---
>>  audio/paaudio.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/audio/paaudio.c b/audio/paaudio.c
>> index 9d46f11b0a..d320d2e453 100644
>> --- a/audio/paaudio.c
>> +++ b/audio/paaudio.c
>> @@ -512,10 +512,8 @@ static pa_stream *qpa_simple_new (
>>
>>      flags =
>>          PA_STREAM_INTERPOLATE_TIMING
>> -#ifdef PA_STREAM_ADJUST_LATENCY
>> -        | PA_STREAM_ADJUST_LATENCY
>> -#endif
>> -        | PA_STREAM_AUTO_TIMING_UPDATE;
>> +        | PA_STREAM_AUTO_TIMING_UPDATE
>> +        | PA_STREAM_EARLY_REQUESTS;
>>
>>      if (dev) {
>>          /* don't move the stream if the user specified a sink/source */
>> --
>> 2.22.0
>>
>>
> 
> 
> --
> Marc-André Lureau
> 


