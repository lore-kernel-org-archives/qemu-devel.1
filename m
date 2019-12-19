Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAD7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A12420716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ht6Um4Dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A12420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvcE-0006Mk-Ua
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihvZ2-0001o7-Q4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihvYy-00076g-9t
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32275
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihvYx-0006tS-0n
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576760992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuzS+0RI392neHe9EkEjexF+DgTfoqg6pQIc+0/RiGk=;
 b=Ht6Um4DcfzoWXsPGSX4hFs1vv6E6QTiaxwxbilqHMg3GXAXA9hcDs/lVEkYJCmU/Y30EOO
 KH7j6imdcapUkkjwxdI69Ey14WsarBsZpCbJIN5UqHRhsGWCIS8AlxZwWLCF6o2gMJ6FPM
 hzm5VR/+V3XNDTrbtP6Qd38XYLk98Us=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-zq8ZJQeAMX-O3qNq0BF-SA-1; Thu, 19 Dec 2019 08:09:48 -0500
Received: by mail-ed1-f70.google.com with SMTP id g20so3441073edt.18
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ni05vfEtEsgSJx+IszN8ATEGfrX2nnauYNLHkipway8=;
 b=ZgeFv1fL3trgjAH0K6QFfNxuJmeHcMriGoRG8kxNUk5MP/MAMA550agaW7h+ntwc/6
 fTwE9u7B5pz77wxla0b9vhqdsFj93P/DZ+leZscIHUeT/b5SHcgTD2LsTRj/yK8+tdQ3
 fO8YdueD2gn4s5RozRR8qNIkm6XYSRTadKqCCz49gqtjpvsNniz4wXTVl9MulrTKMzZ4
 mLiVz96Xi7sb+C/7SWmT/vu23b1Hf+NFgPm0UC6mJJBh7Z7ooOAZS12dyR8XjPwN7xlj
 8iPmy2D88oVrqLJ0p/vBG+2CD58gHkv5j1H/9f7cKAHyKcG1hiCwQSSRM7LXKN8c6N8v
 4j1A==
X-Gm-Message-State: APjAAAXmqRJAB1daaGqDa6uwzqsjzsVQ5yZApDPiPqcYTnCQVmTGhb0t
 dYhHM41xSkQ+lPfCu5OTQ2WvZ6U8fEkxxyI7nK6m+LnElKmEGpQf9zl9R7m7KOuMhVxEAhjWXgh
 CxwrW14JynH9vm6A=
X-Received: by 2002:a50:8522:: with SMTP id 31mr9076200edr.237.1576760987694; 
 Thu, 19 Dec 2019 05:09:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/adgrbgJoCgmy56SiGC2LIO/SZZdbSv5QlB93ULWzoIEaQX5tN2zW1BKIP1XXj+7bB7rUng==
X-Received: by 2002:a50:8522:: with SMTP id 31mr9076104edr.237.1576760986995; 
 Thu, 19 Dec 2019 05:09:46 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id e2sm474808eja.37.2019.12.19.05.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2019 05:09:46 -0800 (PST)
Subject: Re: [RFC PATCH 13/14] hw/char/terminal3270: Explicit ignored
 QEMUChrEvent in IOEventHandler
To: Markus Armbruster <armbru@redhat.com>
References: <20191217163808.20068-1-philmd@redhat.com>
 <20191217163808.20068-14-philmd@redhat.com>
 <87sglgx0w1.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <214a1da6-d974-4f98-0113-ea0b1ea9f244@redhat.com>
Date: Thu, 19 Dec 2019 14:09:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87sglgx0w1.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: zq8ZJQeAMX-O3qNq0BF-SA-1
X-Mimecast-Spam-Score: 0
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Paul Burton <pburton@wavecomp.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, KONRAD Frederic <frederic.konrad@adacore.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alberto Garcia <berto@igalia.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, Joel Stanley <joel@jms.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Corey Minyard <minyard@acm.org>,
 Amit Shah <amit@kernel.org>, Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, Michael Walle <michael@walle.cc>,
 Palmer Dabbelt <palmer@dabbelt.com>, Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

On 12/19/19 7:52 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> The Chardev events are listed in the QEMUChrEvent enum. To be
>> able to use this enum in the IOEventHandler typedef, we need to
>> explicit when frontends ignore some events, to silent GCC the
>> following warnings:
>>
>>      CC      s390x-softmmu/hw/char/terminal3270.o
>>    hw/char/terminal3270.c: In function =E2=80=98chr_event=E2=80=99:
>>    hw/char/terminal3270.c:156:5: error: enumeration value =E2=80=98CHR_E=
VENT_BREAK=E2=80=99 not handled in switch [-Werror=3Dswitch]
>>      156 |     switch (event) {
>>          |     ^~~~~~
>>    hw/char/terminal3270.c:156:5: error: enumeration value =E2=80=98CHR_E=
VENT_MUX_IN=E2=80=99 not handled in switch [-Werror=3Dswitch]
>>    hw/char/terminal3270.c:156:5: error: enumeration value =E2=80=98CHR_E=
VENT_MUX_OUT=E2=80=99 not handled in switch [-Werror=3Dswitch]
>>    cc1: all warnings being treated as errors
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: qemu-s390x@nongnu.org
>> ---
>>   hw/char/terminal3270.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
>> index 6859c1bcb2..9e59a2d92b 100644
>> --- a/hw/char/terminal3270.c
>> +++ b/hw/char/terminal3270.c
>> @@ -166,6 +166,9 @@ static void chr_event(void *opaque, int event)
>>           sch->curr_status.scsw.dstat =3D SCSW_DSTAT_DEVICE_END;
>>           css_conditional_io_interrupt(sch);
>>           break;
>> +    default:
>> +        /* Ignore */
>> +        break;
>>       }
>>   }
>=20
> I doubt the /* Ignore */ comment is worth its keep.

OK I don't mind dropping it.

> Splitting PATCH 02-13 feels excessive to me.

I agree, but I have the feeling when a patch touch many subsystems, we=20
don't wait for all the maintainers to Ack it, we are fine with 2 or 3.
In this case, maybe a subsystem neglected a QEMUChrEvent case, so I=20
prefer to have each of them to confirm we can ignore the missing cases.

In v2 I don't replace by a 'default' entry, all the cases are explicit.

Regards,

Phil.


