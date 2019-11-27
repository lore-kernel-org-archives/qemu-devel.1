Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60698C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B73B20674
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiK4fhi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B73B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZyum-00029j-DA
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 10:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZytP-0001Bd-Jf
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZytO-0003Gy-8Y
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:06:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54741
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZytO-0003Ge-4W
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574867169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=geO61cjETkJ1SplBUleWYMEXG9vnZWtFw9pLg/U+7kE=;
 b=LiK4fhi2um172mhZLfG/qOiAXxzaMcU+j3ZosNzeyWWZGvJjBmEZ/tsXLq0vbAyHGxMffe
 GXgDlyCNl4JzcJHPjKC8hzpZC18DISDm4JtjA2yiWI6saBdM10llk+nbwMQ/esy3mzSO9v
 IejtG6tKcoytPRTs/jrjfmhJKy1cNGg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-ukNgBkJUNmekHvQGmlUbcA-1; Wed, 27 Nov 2019 10:06:07 -0500
Received: by mail-wr1-f70.google.com with SMTP id h7so12345888wrb.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 07:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iOzJWa4kJ6lBhYW5giyWdvM80GcAAOVPmo2vbUHp6uI=;
 b=ZuxoFDqdIztkTIcqHvV2pkLEcSg2cXRLTB+z9L1eSrUMuLPycyM1Tk4vB+H1E7BU8X
 UNvBQlUOGyY3Ox86n7+hIv+j2UWbvhe3prWSF4CWnq2fL3uBZ+0d4dKbr53gvtpZIn8e
 KvG7UofPCG1BVW71sJZkYjxtvsSh8UkDuTKuN2tvnWtmeDmHNXS1ePeJH32tuBDI34j7
 8M0CmHmPvJyVfxYiw2/CulWdV0g0niP6xC/TsSDYMIDvRZ+uivJsek3Sc2dgZiyAR+Uj
 zIQBsmc+BH+otKao9CnOqmM5pXb8vJ+AfQsHdt2vUrOyoDNWZfuESsNdCRcmTqtqs9OF
 T4eQ==
X-Gm-Message-State: APjAAAXGsXLRDXp6NbjkmDgfDLo5A0TOy7JCag3t0GCs173XnqX8Je8l
 NC+pY5EA7TCi6SeoKkKNJ6txH7dGHWDjskZPhUPTFat8LcxFMmYyIXGBuWjQVpWIc6Y2ncB10Ru
 oC0fKG89Q+a2rpa4=
X-Received: by 2002:a1c:998f:: with SMTP id b137mr4975418wme.104.1574867166672; 
 Wed, 27 Nov 2019 07:06:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzvKGBPe24m2rfE+61hAyOyYQwbRTK82oTagJWFBHPrtJ34Fj3I7Ltfz8tWWj55CUjfrTVqg==
X-Received: by 2002:a1c:998f:: with SMTP id b137mr4975387wme.104.1574867166417; 
 Wed, 27 Nov 2019 07:06:06 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id r6sm6446210wrv.40.2019.11.27.07.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2019 07:06:05 -0800 (PST)
Subject: Re: [PATCH-for-5.0? v2 2/2] Revert "Acceptance test: cancel test if
 m68k kernel packages goes missing"
To: Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20191126223810.20180-1-philmd@redhat.com>
 <20191126223810.20180-3-philmd@redhat.com>
 <CAKJDGDY21sjoQ9rvDWvRnwMobgg37ARM3Nj6Ajo6XQaLv4GFtA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f3477ffa-c73c-ebb9-cd33-69f614d9ffb3@redhat.com>
Date: Wed, 27 Nov 2019 16:06:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKJDGDY21sjoQ9rvDWvRnwMobgg37ARM3Nj6Ajo6XQaLv4GFtA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: ukNgBkJUNmekHvQGmlUbcA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 3:53 PM, Willian Rampazzo wrote:
> On Tue, Nov 26, 2019 at 7:38 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> Now than we use the stable snapshot archive, we can remove this check.
>>
>> This reverts commit d2499aca4bac613d837e2720e7bbe3378bc91245.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   tests/acceptance/boot_linux_console.py | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/b=
oot_linux_console.py
>> index 752f776f68..ab4c8a5e5a 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -483,10 +483,7 @@ class BootLinuxConsole(Test):
>>                      '/20191021T083923Z/pool-m68k/main'
>>                      '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k=
.udeb')
>>           deb_hash =3D '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
>> -        try:
>> -            deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_has=
h)
>> -        except OSError as exp:
>> -            self.cancel(exp)
>> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>>           kernel_path =3D self.extract_from_deb(deb_path,
>>                                               '/boot/vmlinux-5.3.0-1-m68=
k')
>>
>=20
> Tested-by: Willian Rampazzo <wrampazz@redhat.com>

Thanks for testing!

> Although I prefer to be on the safe side and keep the verification,
> the code works as expected.

If we want to catch that kind of errors, we should do it consistently in=20
all the tests.

I understand the recent 'avocado assets' command from release 73=20
properly fixes our problem, isn't it Cleber?

See https://avocado-framework.readthedocs.io/en/73.0/releases/73_0.html:

   INSTRUMENTED tests using the avocado.core.test.Test.fetch_asset()
   can take advantage of plugins that will attempt to download (and
   cache) assets before the test execution. This should make the
   overall test execution more reliable, and give better test
   execution times as the download time will be excluded. Users can
   also manually execute the avocado assets command to manually
   fetch assets from tests.

I'm anxious about testing this new feature :)

Regards,

Phil.


