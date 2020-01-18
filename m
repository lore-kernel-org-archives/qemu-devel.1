Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07AAC32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 20:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B666824683
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 20:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyyvBJkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B666824683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isv1p-0001jt-Rp
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 15:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1isv0h-0000uh-6z
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:48:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1isv0g-00049g-3Z
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:47:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36735
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1isv0g-00049R-0I
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579380477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U8zlOwIowKO3g7XEruyJfeRIR2kdecd97HGr8CVMbuQ=;
 b=EyyvBJktwdNTBpEGJ/iWpM9gEYqKpbUsKyotV864RkupkEZI4AJhN08iJZnoSdx3TyWSKv
 UNH5cbf/BWpj3MhuCySICGRlcoC0omUJdp69GIsA0gpS3JM8j7/5zsi3DEvcPdR24q2nJq
 VQlO0826o+8MUAKs6kp7vXDTcL7Zkjw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-U-_LkY8TMWKrqs2m3g2vbw-1; Sat, 18 Jan 2020 15:47:54 -0500
Received: by mail-wr1-f69.google.com with SMTP id h30so12086025wrh.5
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 12:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r6LwXheus+QX0k9fenlCjIxWyHROscpq82W28UBfmKg=;
 b=VztL7rebFhoG3sRHKu13HXBadfP53K93c3SDe1Ls/N97OWjAKBOD/iqhY9R4W3A4jd
 RlZFE7ypgURnPAmM5t1UpaxdtixHJcE0qPYnoM88qSIABM8mqfQryGgKaC2O8vp5/vsK
 3oEFGxdP++LZJVjH8TIEpzVlNaPc1tq+DqTnbY+HSMQoUuJFDG35hrLYepg/mU6/U3X/
 Fu15sDXzOzusWh2lsoOyIp1HE0IAzlpGVWQS3ixb6JvaArGOr4Xq94iRPHRTdjLcofG+
 NH76bwzOCtMpeT6eeOObg9lmJTij4di/QVOuxpOE7x9DNFgQ3sETzleKzP2erwWWbQx4
 AUsw==
X-Gm-Message-State: APjAAAXJt37vSyCuGOD/CeqS78IJNH+9miYVRRWwWIcuH5K/1PVnq5KB
 GPWP5CpPII83TItQeeM1AgzVJ6A3ajrdbZtjeyZmiMLry0mT9TghU7VcHrXc+5g5TVJG9ibsixl
 88k8z7Du7/hKX8uA=
X-Received: by 2002:a5d:538e:: with SMTP id d14mr10313753wrv.358.1579380472680; 
 Sat, 18 Jan 2020 12:47:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxmt1tWidYMlcD4f7v9nOUeQBwSO4mjT1KjA0g5WTekVnPA2LUzGfUdNvZuHYYN6S0OUVIrZQ==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr10313741wrv.358.1579380472378; 
 Sat, 18 Jan 2020 12:47:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9?
 ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
 by smtp.gmail.com with ESMTPSA id v62sm2239320wmg.3.2020.01.18.12.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 12:47:51 -0800 (PST)
Subject: Re: [RFC PATCH] qapi: Incorrect attempt to fix building with
 MC146818RTC=n
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20191231184916.10235-1-philmd@redhat.com>
 <875zhfzc9l.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a06fd97c-b149-2f24-1180-4e4efa8ff79d@redhat.com>
Date: Sat, 18 Jan 2020 21:47:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <875zhfzc9l.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: U-_LkY8TMWKrqs2m3g2vbw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/01/20 15:01, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> When configured with --without-default-devices and setting
>> MC146818RTC=3Dn, the build fails:
>>
>>     LINK    x86_64-softmmu/qemu-system-x86_64
>>   /usr/bin/ld: qapi/qapi-commands-misc-target.o: in function `qmp_marsha=
l_rtc_reset_reinjection':
>>   qapi/qapi-commands-misc-target.c:46: undefined reference to `qmp_rtc_r=
eset_reinjection'
>>   /usr/bin/ld: qapi/qapi-commands-misc-target.c:46: undefined reference =
to `qmp_rtc_reset_reinjection'
>>   collect2: error: ld returned 1 exit status
>>   make[1]: *** [Makefile:206: qemu-system-x86_64] Error 1
>>   make: *** [Makefile:483: x86_64-softmmu/all] Error 2
>>
>> This patch tries to fix this, but this is incorrect because QAPI
>> scripts only provide TARGET definitions, so with MC146818RTC=3Dy we
>> get:
>>
>>   hw/rtc/mc146818rtc.c:113:6: error: no previous prototype for =E2=80=98=
qmp_rtc_reset_reinjection=E2=80=99 [-Werror=3Dmissing-prototypes]
>>     113 | void qmp_rtc_reset_reinjection(Error **errp)
>>         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>>   cc1: all warnings being treated as errors
>>   make[1]: *** [rules.mak:69: hw/rtc/mc146818rtc.o] Error 1
>>
>> Any idea? :)
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  qapi/misc-target.json | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>> index a00fd821eb..8e49c113d1 100644
>> --- a/qapi/misc-target.json
>> +++ b/qapi/misc-target.json
>> @@ -41,7 +41,7 @@
>>  #
>>  ##
>>  { 'command': 'rtc-reset-reinjection',
>> -  'if': 'defined(TARGET_I386)' }
>> +  'if': 'defined(TARGET_I386) && defined(CONFIG_MC146818RTC)' }
>> =20
>> =20
>>  ##
>=20
> The generated qapi-commands-misc-target.h duly has
>=20
>     #if defined(TARGET_I386) && defined(CONFIG_MC146818RTC)
>     void qmp_rtc_reset_reinjection(Error **errp);
>     void qmp_marshal_rtc_reset_reinjection(QDict *args, QObject **ret, Er=
ror **errp);
>     #endif /* defined(TARGET_I386) && defined(CONFIG_MC146818RTC) */
>=20
> mc146818rtc.c includes it.  But since it doesn't include
> config-devices.h, CONFIG_MC146818RTC remains undefined, and the
> prototype gets suppressed.
>=20
> Crude fix: make mc146818rtc.c #include "config-devices.h".

Can we modify the code generator to leave out the #if from the header,
and only include it in the .c file?  An extra prototype is harmless.

Paolo


