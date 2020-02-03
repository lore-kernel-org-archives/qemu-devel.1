Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B4FC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FCC20661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwTTFD6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FCC20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iya1L-0006bf-5K
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iya0j-00065c-K7
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iya0h-0004vs-8M
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:35:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37306
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iya0g-0004ue-VB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580729721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r1iXVjc07uG0uVlpmdp5IKhpiZQJmrU+IUscOzkOOjQ=;
 b=BwTTFD6M4xejPu0Q5T0IZIAiHHpa0pdQMoREdwyj2RSBowruTdRbXQgLRT/Zc6KeEFYTyv
 QVqbaWGHEqYFD/ct0B1NRlvhrqap+W51ywJDuGJQl9SYPgF1Gk7ilFOftFSY24DhyXQNXP
 Ym9pjihS3HbOXzl9Hkc6+U8fskrjods=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-CPzxHP0wMnGtE3NuRGoSDQ-1; Mon, 03 Feb 2020 06:35:18 -0500
Received: by mail-wr1-f72.google.com with SMTP id t6so4993465wru.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:35:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Lz+8ipTmeS7Pf+B5yUK6EP0lfsK2KuA80CqfiqAmiSk=;
 b=LL2DRjWH57XJRBW5MZLQvYA4wF0HbW68lVE2w7n8q8KOm3fgghHd9XTGtTp25ItIdS
 ph4aLVhTqFLnwrs+XWlphhGI4/P8M4aFIJEe8ziC6FYd/3qo7K/yeq7aAdnEGHhVPo2Z
 xJBvZsJzJOlcK3L0eWWFuVlOn2hDOrG2+LP8qjy2fxqvXRIylz7a/kcybGxJ5JkfYjcc
 lUzYLirOgKcEu0IHxKDmrEyOQZ3wYpzKKE+Tc1++uhyk2VXigsyjUMITNSLEhrbnHUGz
 IIbTiPYak7XWuxVyH0Sqmea+lx+/H4sbp6OKTBEkVhM+d8lgcBC+Std40JQLZDnbG5VG
 a8dA==
X-Gm-Message-State: APjAAAV5VMv7jbHow7ls79OutiN6G9s1xA3IDIBAE/Ttgy4qH2SYJ140
 kkDs47bpgq5zzo0l3zZ6jc/rH/yNWbvr/rihxqeMx42iYhSyEZT6OkORLc0cYGXLz6FIsox0+PI
 ooqs2RJZDL7g8eqQ=
X-Received: by 2002:adf:e40f:: with SMTP id g15mr14608240wrm.223.1580729717183; 
 Mon, 03 Feb 2020 03:35:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBgNbS4TpkzWCglEQncQkOOlQRh6Uhosab0KxbpbWBMFAfAuz2/jxM/G38/qNYj81U4AYaiA==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr14608200wrm.223.1580729716953; 
 Mon, 03 Feb 2020 03:35:16 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id c17sm24307753wrr.87.2020.02.03.03.35.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 03:35:16 -0800 (PST)
Subject: Re: [PATCH v3 17/17] .travis.yml: single thread build-tcg
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20200203090932.19147-1-alex.bennee@linaro.org>
 <20200203090932.19147-18-alex.bennee@linaro.org>
 <e1f501e7-b3c4-5d88-3f10-cd2c1c7a1cd6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <21b86fba-8f28-736e-89d1-f7548e1f92e2@redhat.com>
Date: Mon, 3 Feb 2020 12:35:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e1f501e7-b3c4-5d88-3f10-cd2c1c7a1cd6@redhat.com>
Content-Language: en-US
X-MC-Unique: CPzxHP0wMnGtE3NuRGoSDQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 11:01 AM, Thomas Huth wrote:
> On 03/02/2020 10.09, Alex Benn=C3=A9e wrote:
>> I've theorised that a parallel build-tcg is somehow getting confused
>> when two fedora-30 based cross compilers attempt to build at the same
>> time. From one data-point so far this may fix the problem although the
>> plugins job runs quite close to timeout.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   .travis.yml | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index c1c6df475a8..3b35b7cf04d 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -380,7 +380,7 @@ matrix:
>>       - name: "GCC check-tcg (user)"
>>         env:
>>           - CONFIG=3D"--disable-system --enable-debug-tcg"
>> -        - TEST_BUILD_CMD=3D"make -j${JOBS} build-tcg"
>> +        - TEST_BUILD_CMD=3D"make build-tcg"
>>           - TEST_CMD=3D"make check-tcg"
>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>>  =20
>> @@ -391,7 +391,7 @@ matrix:
>>       - name: "GCC plugins check-tcg (user)"
>>         env:
>>           - CONFIG=3D"--disable-system --enable-plugins --enable-debug-t=
cg --target-list-exclude=3Dsparc64-linux-user,cris-linux-user"
>> -        - TEST_BUILD_CMD=3D"make -j${JOBS} build-tcg"
>> +        - TEST_BUILD_CMD=3D"make build-tcg"
>>           - TEST_CMD=3D"make check-tcg"
>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>=20
> Squash it into patch 14/17 ?

I'd rather not, ideally we will revert this patch once the issue is fixed.


