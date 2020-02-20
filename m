Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9302C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 18:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9082467A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 18:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVvsDssy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9082467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4r2Q-0005L4-OX
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 13:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4r1n-0004tb-63
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4r1m-0001r4-4P
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:58:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33417
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4r1m-0001qi-1S
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582225105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/ISRqWUQ9crFu8+Rj92wrQO2n/nJhQkjiD6L0oia/0=;
 b=iVvsDssyrR5alhtslHqGf38vjTvBogu68yCGR8yh4Z7NGPtRmx2i/wBRqeZb/MfNvwTRe1
 Qx8JMLbF0rOpnkD/dBEYSiwPS6cbk6V/ic1JwJ+7ncLekDGvS4RRnIicBAOk6kGu6oEdIk
 xWtuG9DG+oqKJs/q0C5Q2n0VsCLxdB4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-FL7XgtwOMF6duOjL25w7jg-1; Thu, 20 Feb 2020 13:57:57 -0500
Received: by mail-ed1-f72.google.com with SMTP id h24so3328896edw.23
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 10:57:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+PtlgtaIhxq7h+o4lI5bSBjKgkyOqgUBIzSUB2rcEfo=;
 b=P3T3JCe8/thcRXOs3rPPvTVJ3/UKD+Slyi9qoG1q7qC0gDPLZq/I94rcRFbE7xZPN1
 fUwVjhDHn9LMTdedxO5I+i+kYT0902+KH/BTkJRNqDjpLIwGj5Yzqi7Q3DjotErEYyH2
 i3YDwZj3FtkMaJr2Oj3bW0mttKNiejhF/Hod4L7ZSa6QAyAVYUkkL/ZLU889mPL7Ob5H
 lZ2TW8S1nS2S297n1HQR2BapQqy+zOmJacFb8rxdZ7f+93ZBB6vPmR8jo22VskeDITQz
 rOUPZxvz32S7uQoOkPV7EOm401Da1AlrhuN+HlfmqA09lLAhQFDSzqH5h/VCxkLxDlAD
 NGYg==
X-Gm-Message-State: APjAAAXEGttymih+l6lBnTXr8XeFp3m/YfVK1U8h1QQ03phT1//Xt0nF
 D5sdDgvqsBdpgK+faUbWW6p9Gn3sSpr6p/BiMoVttfrHtqjtMykZO16kXSrRF7ROkTAQb9HLUkh
 SMGpPFPKSMwq6+c8=
X-Received: by 2002:a5d:534d:: with SMTP id t13mr45856219wrv.77.1582224697544; 
 Thu, 20 Feb 2020 10:51:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwHEpFtElVbSDe5Ae+zfavfLcY5zOx6GVksQwzST1Q9rxU6f3vBb8StdREQ5qjrNVW96g1kA==
X-Received: by 2002:a5d:534d:: with SMTP id t13mr45856194wrv.77.1582224697238; 
 Thu, 20 Feb 2020 10:51:37 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id n3sm268218wmc.27.2020.02.20.10.51.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 10:51:36 -0800 (PST)
Subject: Re: [PATCH v2 2/2] hw: move timer_new from init() into realize() to
 avoid memleaks
To: Peter Maydell <peter.maydell@linaro.org>,
 Pan Nengyuan <pannengyuan@huawei.com>
References: <20200217032127.46508-1-pannengyuan@huawei.com>
 <20200217032127.46508-3-pannengyuan@huawei.com>
 <CAFEAcA_AxCVaAgho3g2q=kCifSdhz9Qi72eoVAM9gRjb3-_Sog@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <747a3358-09af-d4fa-9150-57ad3e349f24@redhat.com>
Date: Thu, 20 Feb 2020 19:51:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_AxCVaAgho3g2q=kCifSdhz9Qi72eoVAM9gRjb3-_Sog@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: FL7XgtwOMF6duOjL25w7jg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, mav2-rk.cave-ayland@ilande.co.uk,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/20/20 6:56 PM, Peter Maydell wrote:
> On Mon, 17 Feb 2020 at 03:22, <pannengyuan@huawei.com> wrote:
>>
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> There are some memleaks when we call 'device_list_properties'. This patc=
h move timer_new from init into realize to fix it.
>> Meanwhile, do the null check in mos6522_reset() to avoid null deref if w=
e move timer_new into realize().
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
>=20
>> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
>> index 19e154b870..980eda7599 100644
>> --- a/hw/misc/mos6522.c
>> +++ b/hw/misc/mos6522.c
>> @@ -465,11 +465,15 @@ static void mos6522_reset(DeviceState *dev)
>>       s->timers[0].frequency =3D s->frequency;
>>       s->timers[0].latch =3D 0xffff;
>>       set_counter(s, &s->timers[0], 0xffff);
>> -    timer_del(s->timers[0].timer);
>> +    if (s->timers[0].timer) {
>> +        timer_del(s->timers[0].timer);
>> +    }
>>
>>       s->timers[1].frequency =3D s->frequency;
>>       s->timers[1].latch =3D 0xffff;
>> -    timer_del(s->timers[1].timer);
>> +    if (s->timers[1].timer) {
>> +        timer_del(s->timers[1].timer);
>> +    }
>>   }
>=20
> What code path calls a device 'reset' method on a device
> that has not yet been realized ? I wasn't expecting that
> to be valid...

This is not valid. What I understood while reviewing this patch is on=20
reset the timer is removed from the timers list. But this patch miss=20
setting timer =3D NULL in case the device is reset multiple times, here=20
can happen a NULL deref.

>=20
> thanks
> -- PMM
>=20


