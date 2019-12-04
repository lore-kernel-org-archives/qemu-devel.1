Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E319C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8152077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ME8n+R4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8152077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTua-0000iG-O6
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1icTJB-0006uL-Ma
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:59:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1icTJ2-00040w-T1
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:58:58 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:45762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1icTIr-0002iI-Cu; Wed, 04 Dec 2019 06:58:45 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id A95F296EF0;
 Wed,  4 Dec 2019 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575460722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ljSCwCD3O4e7pPsXT+MroUcr3135nqWethx1Gpbjuk=;
 b=ME8n+R4fLmX9fusvWwUBqlaHbU3t6uMxB4GWpYle5KmMmGxA3gWLNDe80yNw25b5GePgrm
 SCWxuwA6suJbg5CMUpzBDG3TxTtVuj/V2iRpMKlXHdY24V0TTlItUW/90NOJ993Zw5Pdfg
 hAYBtQuwtisRqbayMzldysn7j8WXl18=
Subject: Re: [PATCH v6 3/9] qdev: add clock input&output support to devices.
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-4-damien.hedde@greensocs.com>
 <CAFEAcA9M4qR89wykURrUxqxeWoNqYHxuJSwC5Mum6GfmWSG=nA@mail.gmail.com>
 <8ac54ca8-4acf-5145-9ead-6791a5181617@greensocs.com>
 <d6937a23-d6d5-fe22-bc42-0bec543decf6@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <e9c078e5-be16-ca95-7cfa-44cbcc63a3be@greensocs.com>
Date: Wed, 4 Dec 2019 12:58:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <d6937a23-d6d5-fe22-bc42-0bec543decf6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575460722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ljSCwCD3O4e7pPsXT+MroUcr3135nqWethx1Gpbjuk=;
 b=kMohnrxOSGi/bc2DJWVZPeVkXKu0dPgbRlmc2HIz42+9hLjxiPb2sKVuLevJQVVyDeTbSq
 XMrUZxavi+77oRokysQqiSD/egPitKW2O9/Uw2+/S7y56jV88TacJQ+EIuWZ4tK+BnCv/I
 xyDANj8WMWukbFxLN16t7LSjXI7LeTY=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575460722; a=rsa-sha256; cv=none;
 b=4jjL4V+OVqzIQM1lGRM833Vyrn2OZM1Expn5PvC3c1PT+VafVskD/PbWfHgNspsHeBi/+j
 2iOHgwS4U60Mp/2o1SSot5u+I182q5r76STPd2V202inWZx4Rn3ZQC7BtWCnmD4m2oq/oF
 yvU4RLtGEwvBv3F4PQW+ZPhDozP78wE=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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



On 12/4/19 10:53 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/4/19 10:05 AM, Damien Hedde wrote:
>> On 12/2/19 3:34 PM, Peter Maydell wrote:
>>> On Wed, 4 Sep 2019 at 13:56, Damien Hedde
>>> <damien.hedde@greensocs.com> wrote:
>>>>
> [...]
>>>> +/**
>>>> + * qdev_pass_clock:
>>>> + * @dev: the device to forward the clock to
>>>> + * @name: the name of the clock to be added (can't be NULL)
>>>> + * @container: the device which already has the clock
>>>> + * @cont_name: the name of the clock in the container device
>>>> + *
>>>> + * Add a clock @name to @dev which forward to the clock @cont_name
>>>> in @container
>>>> + */
>>>
>>> 'container' seems odd terminology here, because I would expect
>>> the usual use of this function to be when a 'container' object
>>> like an SoC wants to forward a clock to one of its components;
>>> in that case the 'container' SoC would be @dev, wouldn't it?
>>
>> Yes. I agree it is confusing.
>> This function just allow a a device 'A' to exhibit a clock from anothe=
r
>> device 'B' (typically a composing sub-device, inside a soc like you
>> said). The device A is not supposed to interact with the clock itself.
>> The original sub-device is the true
>> owner/controller of the clock and is the only one which should use the
>> clock API: setting a callback on it (input clock); or updating the clo=
ck
>> frequency (output clock).
>> Basically, it just add the clock into the device clock namespace witho=
ut
>> interfering with it.
>>
>>> We should get this to be the same way round as qdev_pass_gpios(),
>>> which takes "DeviceState *dev, DeviceState *container", and
>>> passes the gpios that exist on 'dev' over to 'container' so that
>>> 'container' now has gpios which it did not before.
>>
>> Ok, I'll invert the arguments.
>>
>>>
>>> Also, your use of 'forward to' is inconsistent: in the 'dev'
>>> documentation you say we're forwarding the clock to 'dev',
>>> but in the body of the documentation you say we're forwarding
>>> the clock to the clock in 'container'.
>>
>> I'll try to clarify this and make the documentation more consistent wi=
th
>> the comments here.
>>
>>>
>>> I think the way to resolve this is to stick to the terminology
>>> in the function name itself:
>>> =C2=A0 @dev: the device which has the clock
>>> =C2=A0 @name: the name of the clock on @dev
>>> =C2=A0 @container: the name of the device which the clock should
>>> =C2=A0=C2=A0 be passed to
>>> =C2=A0 @cont_name: the name to use for the clock on @container
>>
>> I think container is confusing because depending on how we reason (clo=
ck
>> in a device; device in another device), we end up thinking the opposit=
e.
>>
>> Maybe we can use "exhibit" instead of "container" in the 2nd pair of
>> parameters, or prefix use "origin" or "owner" as a prefix for the firs=
t
>> pair of parameters.
>=20
> @sink vs @source?
>=20
>>> Q: if you pass a clock to another device with this function,
>>> does it still exist to be used directly on the original
>>> device? For qdev_pass_gpios it does not (I think), but
>>> this is more accident of implementation than anything else.
>>
>> It depends what we mean by "used by".
>> Original device can:
>> + set the callback in case it is an input
>> + update the frequency in case it is an output
>=20
> Hmm here you use @input vs @output...

Not really. What I meant here is that the device which originally
creates the clock is the only device which can interact with the clock.
And it will never gives this right to another device even if
qdev_pass_clock() is used.

There are 2 interactions, depending on the clock direction (input or
output). If it is an input clock, it can register a callback on
frequency changes; and if it is an output clock, it can updates the
frequency of the clock.

>=20
>> But since an input clock can only be connected once,
>> I think the logic here is that any connection should now go through th=
e
>> new device. But this is not checked and using one or the other is
>> exactly the same.
>>
>> Maybe I misunderstood the meaning of qdev_pass_gpios().
> [...]
>=20

