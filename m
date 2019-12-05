Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3D2C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 10:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6307D2464D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 10:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL3iIFC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6307D2464D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icnxL-0005cO-Ar
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 05:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icnvb-0004ID-Fn
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icnvY-0001Gm-V1
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:00:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icnvY-0001DJ-P8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575540004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YtXlFr7G1Bwr4CnRrYq0HoNwox7A0fyhu78ILH4Nt5w=;
 b=fL3iIFC/k5WOQImXpCjrXnfR2ITfQPeR5nQMwz5p7WaLjq60JWVZOvqqucC5M71b7aSb4V
 +uDHAcT/p3294OekuTHD4U6txQcIC/nsIbA54mVZCOLsj8qAY06HpDzAqNUxdzLUB8rcQb
 hS177RWSJgbnL/A7DqEwDoyL7DSj1Bg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-D7DyDscuNLeP_9j9oYWuLA-1; Thu, 05 Dec 2019 05:00:00 -0500
Received: by mail-wm1-f70.google.com with SMTP id i17so794667wmd.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 02:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MeVrDWx0B3oH3EUzn7xnUjrM9Mx50qFLbEBTMcx+PfM=;
 b=i7N7y+Vyowk44WlZcB2wRiGICpVeX3NeMtIiKSbaJr9I1UPSnMph2AR2P5dj6BaVHB
 szx1TUAmacpYBAmz8ArzMMJKkjrw8UqNp4ouCqkD4zSG3GuRlL36vsN37BeIOtQTXyeX
 hiqA2kTmc2AXK5Wrti2U9hocFlxEjPB1BlGzVsDbii3L9Pd59U5r3mjBBUexw+P/Fyg2
 jt4op5HcCa3F7ZTjxjcw9eXMh2oJ6TflUNLaWnlQRCU1di3RbC8qYcDN+Peywmu5YpZ5
 DDB6w84MT4LsBD+ZX+0HZ1pW4oshIediyggib6FU2YPnInqJ9qKPkim77gMb329CdhdT
 1OFw==
X-Gm-Message-State: APjAAAUi586Nrio6CEpOGZJv89J6WgfJgUt05R5E1ZeMindxGEfa4iGw
 Lv2VaxYP0JKQ83hqw5jppZGFoZixYc26bL4cn+8M/SwXvaRmVtwLzg/E1O+mYuF5rgJ2INYt8vl
 qVZKt0IUwlwlKgkA=
X-Received: by 2002:a05:600c:24ce:: with SMTP id
 14mr4360730wmu.122.1575539999387; 
 Thu, 05 Dec 2019 01:59:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3AJvcv81GYtTYzyf4yn6btBUGDF9Jf4qb/wpCQG70xRO9Lo9L9LU3km1K3zpmc6LMW2UfNg==
X-Received: by 2002:a05:600c:24ce:: with SMTP id
 14mr4360691wmu.122.1575539998934; 
 Thu, 05 Dec 2019 01:59:58 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id f1sm11787323wrp.93.2019.12.05.01.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 01:59:58 -0800 (PST)
Subject: Re: [PATCH v6 0/9] Clock framework API
To: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <CAFEAcA98rt6nRDSrwk8XRbaBT67LZXvF=XEV13dtJBp4fPUscw@mail.gmail.com>
 <be199ad6-1b79-f77d-afad-faeb042151ed@greensocs.com>
 <febdb64d-9d02-66ad-84d2-dc795879e48b@redhat.com>
 <a0cea550-d6c7-0193-b4e6-24ed879be61d@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <279a0fd5-1ea5-b3c7-27bb-b1d22db5e359@redhat.com>
Date: Thu, 5 Dec 2019 10:59:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a0cea550-d6c7-0193-b4e6-24ed879be61d@greensocs.com>
Content-Language: en-US
X-MC-Unique: D7DyDscuNLeP_9j9oYWuLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 12/5/19 10:36 AM, Damien Hedde wrote:
> On 12/4/19 9:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/4/19 5:40 PM, Damien Hedde wrote:
>>> On 12/2/19 5:15 PM, Peter Maydell wrote:
>>>>
>>>> The one topic I think we could do with discussing is whether
>>>> a simple uint64_t giving the frequency of the clock in Hz is
>>>> the right representation. In particular in your patch 9 the
>>>> board has a clock frequency that's not a nice integer number
>>>> of Hz. I think Philippe also mentioned on irc some board where
>>>> the UART clock ends up at a weird frequency. Since the
>>>> representation of the frequency is baked into the migration
>>>> format it's going to be easier to get it right first rather
>>>> than trying to change it later.
>>
>> Important precision for Damien, IIUC we can not migrate float/double typ=
es.
>>
>>>> So what should the representation be? Some random thoughts:
>>>>
>>>> 1) ptimer internally uses a 'period plus fraction' representation:
>>>>  =C2=A0 int64_t period is the integer part of the period in nanosecond=
s,
>>>>  =C2=A0 uint32_t period_frac is the fractional part of the period
>>>> (if you like you can think of this as "96-bit integer
>>>> period measured in units of one-2^32nd of a nanosecond").
>>>> However its only public interfaces for setting the frequency
>>>> are (a) set the frequency in Hz (uint32_t) or (b) set
>>>> the period in nanoseconds (int64_t); the period_frac part
>>>> is used to handle frequencies which don't work out to
>>>> a nice whole number of nanoseconds per cycle.
>>
>> This is very clear, thanks Peter!
>>
>> The period+period_frac split allow us to migrate the 96 bits:
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(period_frac, =
ptimer_state),
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_INT64(period, ptimer=
_state),
>>
>>>> 2) I hear that SystemC uses "value plus a time unit", with
>>>> the smallest unit being a picosecond. (I think SystemC
>>>> also lets you specify the duty cycle, but we definitely
>>>> don't want to get into that!)
>>>
>>> The "value" is internally stored in a 64bits unsigned integer.
>>>
>>>>
>>>> 3) QEMUTimers are basically just nanosecond timers
>>
>> Similarly to SystemC, the QEMUTimers macro use a 'scale' unit, of:
>>
>> #define SCALE_MS 1000000
>> #define SCALE_US 1000
>> #define SCALE_NS 1
>>
>>>>
>>>> 4) The MAME emulator seems to work with periods of
>>>> 96-bit attoseconds (represented internally by a
>>>> 32-bit count of seconds plus a 64-bit count of
>>>> attoseconds). One attosecond is 1e-18 seconds.
>>>>
>>>> Does anybody else have experience with other modelling
>>>> or emulator technology and how it represents clocks ?
>>>
>>> 5) In linux, a clock rate is an "unsigned long" representing Hz.
>>>
>>>>
>>>> I feel we should at least be able to represent clocks
>>>> with the same accuracy that ptimer has.
>>>
>>> Then is a maybe a good idea to store the period and not the frequency i=
n
>>> clocks so that we don't loose anything when we switch from a clock to a
>>> ptimer ?
>>
>> I think storing the period as an integer type is a good idea.
>>
>> However if we store the period in nanoseconds, we get at most 1GHz
>> frequency.
>>
>> The attosecond granularity feels overkill.
>>
>> If we use a 96-bit integer to store picoseconds and use similar SCALE
>> macros we get to 1THz.
>>
>> Regardless the unit chosen, as long it is integer, we can migrate it.
>> If can migrate the period, we don't need to migrate the frequency.
>> We can then use the float type in with the timer API to pass frequencies
>> (which in the modeled hardware are ratios, likely not integers).
>>
>> So we could use set_freq(100e6 / 3), set_freq(40e6 / 5.5) directly.
>>
>>> Regarding the clock, I don't see any strong obstacle to switch
>>> internally to a period based value.
>>> The only things we have to choose is how to represent a disabled clock.
>>> Since putting a "0" period to a ptimer will disable the timer in
>>> ptimer_reload(). We can choose that (and it's a good value because we
>>> can multiply or divide it, it stays the same).
>>>
>>> We could use the same representation as a ptimer. But if we don't keep =
a
>>> C number representation, then computation of frequencies/periods will b=
e
>>> complicated at best and error prone.
>>>
>>>  =C2=A0From that point of view, if we could stick to a 64bits integer (=
or
>>> floating point number) it would be great. Can we use a sub nanosecond
>>> unit that fit our needs ?
>>>
>>> I did some test with a unit of 2^-32 of nanoseconds on 64bits (is that
>>> the unit of the ptimer fractional part ?) and if I'm not mistaken
>>> + we have a frequency range from ~0.2Hz up to 10^18Hz
>>> + the resolution is decreasing with the frequency (but at 100Mhz we hav=
e
>>> a ~2.3mHz resolution, at 1GHz it's ~0.23Hz and at 10GHz ~23Hz
>>> resolution). We hit 1Hz resolution around 2GHz.
>>>
>>> So it sounds to me we have largely enough resolution to model clocks in
>>> the range of frequencies we will have to handle. What do you think ?
>>
>> Back to your series, I wonder why you want to store the frequency in
>> ClockIn. ClockIn shouldn't be aware at what frequency it is clocked.
>> What matters is ClockOut, and each device exposing ClockOuts has a
>> (migrated) state of the output frequencies (rather in fields, or encoded
>> in registers). Once migrated, after the state is loaded back into the
>> device, we call post_load(). Isn't it a good place to call
>> clock_set_frequency(ClockOut[]) which will correctly set each ClockIn
>> frequency.
>>
>> IOW I don't think ClockIn/ClockOut require to migrate a frequency field.
>>
>=20
> I agree it is more logical to store the frequency in clock out. But,
> regarding migration constraints, we have no choice I think because a
> device cannot rely on values that are migrated by another device for
> restoring its state. (when I checked, I add the impression that
> post_load()s are called on a per device migration basis not all at the
> end of migration).

Cc'ing David to clear that out.

> So we could store the frequency in clock out and migrate things there.
> But since we have no way to ensure all clock out states are migrated
> before some device fetch a ClockIn: we'll have to say "don't fetch one
> of your ClockIn frequency during migration and migrate the value
> yourself if you need it", pretty much like gpios.
>=20
> So we will probably migrate all ClockOut and almost all ClockIn.
>=20
> It would nice if we had a way to ensure clocks are migrated before
> devices try to use them. But I don't think this is possible.
>=20
> --
> Damien
>=20


