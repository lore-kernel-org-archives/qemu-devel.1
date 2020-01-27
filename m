Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84598C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475062071E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LILOvA1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475062071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw030-0001ft-G8
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 03:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iw01e-00019z-Gr
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iw01c-0000d1-Ka
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:45:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36373
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iw01c-0000ch-Bf
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580114739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zAWqCNhYubOz0exjEaffL2GTGwSKLThT+P6d0uNUb4=;
 b=LILOvA1/ZtmDDIf0nx5jKC4fBzy+1z/1ZRUV6wei6Gjq/8khY/VFLrYW0HmPyroLZy9GIr
 kI7256lkhG1siW5wqvozFE+v0DIT5YjB5jQDtmnN3EtABUt0pOmgTVYSHsTgmP1HEX1VCY
 2GvuyyvHFw91YPurCwu0NQZeOFckWDc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-SsGs5-abOuGbblNy4XGX4A-1; Mon, 27 Jan 2020 03:45:25 -0500
Received: by mail-wr1-f72.google.com with SMTP id j4so5750039wrs.13
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 00:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NIpkfIQgyGmIcZh+4Iwm/qkivhx+WLalZRK5USjRiwU=;
 b=Wq+YW2YIZdXbW48Pa+6FWfoJ3CpwU2+qo2VeIVVacQGMl253ch+TntE9Uh1ahKLCnh
 YXKRjOd+XMn4wdl8vOcmrcj4D/JuiYl5h4YlNfj6occxK9a80XL2ly5PGR4w9kKWAn27
 S+LS+d18ZeYzyWDYWgFKyYy5i0uAnAFYloK4I5h/l44VblpRU6n5BBp7wpNysd+4MMuk
 WRIcllVAvOdMXBSuQ+yXizcQPjLMsw8Nb9EIRjih6cbaehTMWCSDEkiCuYmVy0FGIAZC
 3AyYE/mcMKYdGq5Vkyq7SQfwaui4ICdDcLamdXk4IF+WBTM5igOYwjItIbrRj/KXqBB4
 fLCg==
X-Gm-Message-State: APjAAAWVf04e6VQ9GEze4Hjq1khVcrUcTmc0HjFxQxwu6YHQmjH9HweX
 voVJEewq8CSrPrbq8ItjjKhKKPnRmm2AgzvZZWKo5rWOpFzZLdqiEtxWtj4f/ID6j/9FFAD19qb
 U/MPLmofy8J/RJOA=
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr13427022wmg.16.1580114724699; 
 Mon, 27 Jan 2020 00:45:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwnjNk8H0gcH6MKVhZvjisGi5ssdKZrOZd9/Fpkq2O8TQhiLcytr7dolc2qb2xalCFwHMJyg==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr13426998wmg.16.1580114724431; 
 Mon, 27 Jan 2020 00:45:24 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id b137sm18970186wme.26.2020.01.27.00.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 00:45:23 -0800 (PST)
Subject: Re: [PATCH 2/8] tests/vm: increased max timeout for vm boot.
To: Robert Foley <robert.foley@linaro.org>
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-3-robert.foley@linaro.org>
 <075d1da4-f59a-489e-4c64-63e76265d5c4@redhat.com>
 <CAEyhzFsqvjooH0SbmedKGAX51AUgGMvOfVdB3gcF7aziKUddOQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a9f5adc1-d8ae-d0fa-1789-84c015e893e9@redhat.com>
Date: Mon, 27 Jan 2020 09:45:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAEyhzFsqvjooH0SbmedKGAX51AUgGMvOfVdB3gcF7aziKUddOQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: SsGs5-abOuGbblNy4XGX4A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 8:00 PM, Robert Foley wrote:
> Hi Phil,
>=20
>> I once suggested "When using TCG, wait longer for a VM to start"
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg550610.html
>>
> Thanks for the pointer.  This increase in timeout under TCG seems just
> right for the case we saw.  I will incorporate this into the patch.

Well I'm not sure this is the better way, at the time I posted the=20
series (see cover) there was no upstream interest in vmtests with TCG on=20
aarch64, so I did not insist.

I'm glad you are improving this area now.

> On Fri, 24 Jan 2020 at 12:12, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> Hi Robert,
>>
>> On 1/24/20 5:53 PM, Robert Foley wrote:
>>> Add change to increase timeout waiting for VM to boot.
>>> Needed for some emulation cases where it can take longer
>>> than 5 minutes to boot.
>>>
>>> Signed-off-by: Robert Foley <robert.foley@linaro.org>
>>> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
>>> ---
>>>    tests/vm/basevm.py | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
>>> index 991115e44b..86908f58ec 100755
>>> --- a/tests/vm/basevm.py
>>> +++ b/tests/vm/basevm.py
>>> @@ -310,7 +310,7 @@ class BaseVM(object):
>>>        def print_step(self, text):
>>>            sys.stderr.write("### %s ...\n" % text)
>>>
>>> -    def wait_ssh(self, seconds=3D300):
>>> +    def wait_ssh(self, seconds=3D600):
>>>            starttime =3D datetime.datetime.now()
>>>            endtime =3D starttime + datetime.timedelta(seconds=3Dseconds=
)
>>>            guest_up =3D False
>>>
>>
>> I once suggested "When using TCG, wait longer for a VM to start"
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg550610.html
>>
>> Cleber took some notes about 'kicking a expiring timer' but I can't find
>> it. This might be related:
>> https://trello.com/c/MYdgH4mz/90-delayed-failures
>>
>> Regards,
>>
>> Phil.
>>
>=20


