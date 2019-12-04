Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7F4C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 11:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B7B2054F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 11:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDkqwAiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B7B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icSyT-0005qy-JR
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 06:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icRO9-0005Ec-CW
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icRLv-0003eE-OI
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:53:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20489
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icRLv-0003Yn-JI
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575453226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0dwGLHg0baVBbBxWdrAAkf8RroB3yMWuAT5RxiT1E98=;
 b=dDkqwAiEZoEOmSghJwrZnW4Bk/GBYHG2FVLl8UMs2Dyco1lo5LwJRSWqLePObTEmrKxdGd
 1j0kOYUKMrlNpYkySPbO5gQiI8zZ39GnmSip2ySepwsW5HzBElLbNVTqQfj+pR/P655qRv
 cH/SChfUXH0yc0pwCx6vYdm0qvFggoc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-DptTU0ncPY6G_F8fURfOjg-1; Wed, 04 Dec 2019 04:53:45 -0500
Received: by mail-wr1-f70.google.com with SMTP id j13so3056876wrr.20
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 01:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0dwGLHg0baVBbBxWdrAAkf8RroB3yMWuAT5RxiT1E98=;
 b=uJMHwClECChmKnQGA6reGksG+Dtnu86y0m/D0i4ncoWzBxVJOOilYjT33HpxPjeR+I
 WAm8on+sex/4jI3URW2FbhpMut57nFEqX18jxgjKGGUUnjsHF8tX0+OnwjQofyGdcVRu
 7Gu7aSx/6oAbHaPFET9kaP5ShLFOZ40iNR2tO2qRarU9Vc0ACSOmqfiKZ0bi6jdq1622
 ly3Ln3Za9LRJhjxEldUqseXfk01J6TDR6X8R98o2YyjU+X9N6ilrFskw+yCVOWeCH5Qk
 TPwuNteXSoZ0/GK5yjWMiG7AwzLeWptfx6feyBHBv2NDI3IgXRxgknOezcbJypBntulP
 ZY7w==
X-Gm-Message-State: APjAAAWczCAYlmdEfrAjfFUGsHfh0iCrQBF1dE8NMp6tblKv1n0wotEL
 olYBedccTNESut+jRjGwPOQmP93jliNxtrkTTecW/p/oT3M0WRREm8f6ch3G/sAyEGUZ5LMKaZK
 OJi1lkWyOjQ1wzhw=
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr2942142wrm.278.1575453223873; 
 Wed, 04 Dec 2019 01:53:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzKjVeX6p5sK6geDepDnzyjqoq2fWYNHA/bDrKnnUO07emB2SMpMqnixhvjcNd6UuT4xECv4w==
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr2942113wrm.278.1575453223568; 
 Wed, 04 Dec 2019 01:53:43 -0800 (PST)
Received: from [10.201.33.36] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id k19sm6024344wmi.42.2019.12.04.01.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 01:53:43 -0800 (PST)
Subject: Re: [PATCH v6 3/9] qdev: add clock input&output support to devices.
To: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-4-damien.hedde@greensocs.com>
 <CAFEAcA9M4qR89wykURrUxqxeWoNqYHxuJSwC5Mum6GfmWSG=nA@mail.gmail.com>
 <8ac54ca8-4acf-5145-9ead-6791a5181617@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d6937a23-d6d5-fe22-bc42-0bec543decf6@redhat.com>
Date: Wed, 4 Dec 2019 10:53:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8ac54ca8-4acf-5145-9ead-6791a5181617@greensocs.com>
Content-Language: en-US
X-MC-Unique: DptTU0ncPY6G_F8fURfOjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 10:05 AM, Damien Hedde wrote:
> On 12/2/19 3:34 PM, Peter Maydell wrote:
>> On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>>
[...]
>>> +/**
>>> + * qdev_pass_clock:
>>> + * @dev: the device to forward the clock to
>>> + * @name: the name of the clock to be added (can't be NULL)
>>> + * @container: the device which already has the clock
>>> + * @cont_name: the name of the clock in the container device
>>> + *
>>> + * Add a clock @name to @dev which forward to the clock @cont_name in @container
>>> + */
>>
>> 'container' seems odd terminology here, because I would expect
>> the usual use of this function to be when a 'container' object
>> like an SoC wants to forward a clock to one of its components;
>> in that case the 'container' SoC would be @dev, wouldn't it?
> 
> Yes. I agree it is confusing.
> This function just allow a a device 'A' to exhibit a clock from another
> device 'B' (typically a composing sub-device, inside a soc like you
> said). The device A is not supposed to interact with the clock itself.
> The original sub-device is the true
> owner/controller of the clock and is the only one which should use the
> clock API: setting a callback on it (input clock); or updating the clock
> frequency (output clock).
> Basically, it just add the clock into the device clock namespace without
> interfering with it.
> 
>> We should get this to be the same way round as qdev_pass_gpios(),
>> which takes "DeviceState *dev, DeviceState *container", and
>> passes the gpios that exist on 'dev' over to 'container' so that
>> 'container' now has gpios which it did not before.
> 
> Ok, I'll invert the arguments.
> 
>>
>> Also, your use of 'forward to' is inconsistent: in the 'dev'
>> documentation you say we're forwarding the clock to 'dev',
>> but in the body of the documentation you say we're forwarding
>> the clock to the clock in 'container'.
> 
> I'll try to clarify this and make the documentation more consistent with
> the comments here.
> 
>>
>> I think the way to resolve this is to stick to the terminology
>> in the function name itself:
>>   @dev: the device which has the clock
>>   @name: the name of the clock on @dev
>>   @container: the name of the device which the clock should
>>    be passed to
>>   @cont_name: the name to use for the clock on @container
> 
> I think container is confusing because depending on how we reason (clock
> in a device; device in another device), we end up thinking the opposite.
> 
> Maybe we can use "exhibit" instead of "container" in the 2nd pair of
> parameters, or prefix use "origin" or "owner" as a prefix for the first
> pair of parameters.

@sink vs @source?

>> Q: if you pass a clock to another device with this function,
>> does it still exist to be used directly on the original
>> device? For qdev_pass_gpios it does not (I think), but
>> this is more accident of implementation than anything else.
> 
> It depends what we mean by "used by".
> Original device can:
> + set the callback in case it is an input
> + update the frequency in case it is an output

Hmm here you use @input vs @output...

> But since an input clock can only be connected once,
> I think the logic here is that any connection should now go through the
> new device. But this is not checked and using one or the other is
> exactly the same.
> 
> Maybe I misunderstood the meaning of qdev_pass_gpios().
[...]


