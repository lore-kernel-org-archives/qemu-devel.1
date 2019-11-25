Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817A7C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D95E20748
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAsj3+Dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D95E20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZFsa-0007nW-4h
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZFr3-0007K7-K8
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZFr2-0000NI-Dv
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:00:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59156
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZFr2-0000N1-9T
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574694043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nbz/uZcKO4VN9UJUlLbQX+tJ3SaV6VwfC3MfISN1+kk=;
 b=IAsj3+DcZmJT6cj7tXrUT7Z5+bPq83k2QR4Qwj7OpdgGilWTDFu/OL8eGlc2Z77S1dV6G7
 Pt0teCRmupnxmderomQymIt1XjG81zMG+FKedWObP7baFTdwOo10gZwG6tNkEIEeGqpraC
 myzi689K+QesBV9/HpJeQNvMeCtcj98=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-DrAD3WkjNIu2PS76syyBfA-1; Mon, 25 Nov 2019 10:00:42 -0500
Received: by mail-wr1-f72.google.com with SMTP id q6so8950160wrv.11
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 07:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tqhgBIRhF35JLE+FMUCZFtbvI+YQmst0rI2qBQHBW68=;
 b=fw6raP7OgKfOrdb8s3Ky/uh+2+LaQeejwGkBS5xDdo/vVDSMAPmkX4582IF2yDzxc3
 9/YG7BVw6nd1u56mdolMEr172coq+rHGGk06ijK455aZ8XjoBVLgfhtVwmZUOmVwpSuO
 tNsimj5HnHy3jcP6+ac9dy6iHJPGiqFPZ42y/pI+9T2oyAf+JryXctqBGFaVkLHhhGph
 LRYj9OZLE7A3Gb6c7Txh6gRP4/9kISFE8nHYvn9+UYig2C6xvON+wXz3oa8iBwK54VuM
 eNFJVthcUR2ybKM58KyIowf7HsRqwdm37GUk2yxYME/wW/wYkCgZzxBXzaEKvo9PfMq6
 n56g==
X-Gm-Message-State: APjAAAVPAhE9dnp5TZ0bABmVZHSqFHNQoGx4MFu2aO3Zr0OmvqgIv3M/
 zz/hXgl9xsnVFPrD7UwVk1g2jcnyYB5/cQUUDa1izVfBdzHIvcXkRXHHsh+HJ5WdJ6NDrEAHJcP
 zE7AePRovTSOY768=
X-Received: by 2002:adf:cd8f:: with SMTP id q15mr31501413wrj.21.1574694040921; 
 Mon, 25 Nov 2019 07:00:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHFSGSf5fUfggibiS05fwg7sCIUlJp8hc8p/V8s/DTQkRDNGJJUDNZ3cpXbnl2W777xx7o7A==
X-Received: by 2002:adf:cd8f:: with SMTP id q15mr31501387wrj.21.1574694040668; 
 Mon, 25 Nov 2019 07:00:40 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id d186sm7123008wmf.7.2019.11.25.07.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 07:00:39 -0800 (PST)
Subject: Re: [PATCH] mos6522: update counters when timer interrupts are off
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191125141414.5015-1-laurent@vivier.eu>
 <a274a621-b9ed-1090-23af-cf4d46a266b3@redhat.com>
 <3c49973f-ef70-27ec-342a-de722a05e257@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <57edef14-04b0-03bc-ff7b-aa64a705e029@redhat.com>
Date: Mon, 25 Nov 2019 16:00:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3c49973f-ef70-27ec-342a-de722a05e257@vivier.eu>
Content-Language: en-US
X-MC-Unique: DrAD3WkjNIu2PS76syyBfA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Andrew Randrianasulu <randrianasulu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/25/19 3:56 PM, Laurent Vivier wrote:
> Le 25/11/2019 =C3=A0 15:37, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>> On 11/25/19 3:14 PM, Laurent Vivier wrote:
>>> Even if the interrupts are off, counters must be updated because
>>> they are running anyway and kernel can try to read them
>>> (it's the case with g3beige kernel).
>>>
>>> Reported-by: Andrew Randrianasulu <randrianasulu@gmail.com>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>> ---
>>>  =C2=A0 hw/misc/mos6522.c | 8 ++++++--
>>>  =C2=A0 1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
>>> index aa3bfe1afd..cecf0be59e 100644
>>> --- a/hw/misc/mos6522.c
>>> +++ b/hw/misc/mos6522.c
>>> @@ -113,6 +113,10 @@ static int64_t get_next_irq_time(MOS6522State *s,
>>> MOS6522Timer *ti,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t d, next_time;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int counter;
>>>   =20
>>
>> Can you add a comment here such "Clock disabled. This is the longest
>> time before expiration" or better?
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>>> +=C2=A0=C2=A0=C2=A0 if (ti->frequency =3D=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return INT64_MAX;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>=20
>=20
> In fact this is here for a deeper problem:
>=20
> frequency is not correctly initialized on reset.
>=20
> ti->frequency are initialized by cuda/pmu/mac_via after the parent reset
> (mos6522) but the parent reset calls set_counter() that uses
> ti->frequency to set the counters. The mos6522 reset initialize the
> ti->frequency from s->frequency but s->frequency is never initialized.

Ah, I see.

"How machines behave after a soft reset" is something I'd like to get=20
tested more thoroughly (with Avocado eventually).

> It was hidden before because the timers were not updated if the
> interrupts are disabled, and now they are always updated.
>=20
> I didn't want to add a such complicated comment in the code and I will
> try to fix the problem later.

Good :)


