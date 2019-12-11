Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5270DC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE282465B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9eYsaxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE282465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3bq-0003OA-Vt
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 10:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1if3ao-0002LW-0V
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1if3am-0003hs-Qk
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:07:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48510
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1if3am-0003gi-Mo
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576076872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VAZysT5uZKd9J8uq61bCtrwvuGt9+aQ3AaN0zOdkWv4=;
 b=b9eYsaxyeb0dbrnWB1oebm+jmg4YP+J00EyOwxq551UQIVH90tklzPHVIZJzada/QJ7IFD
 Pv3FiupWg5IRW98AyQfhYp11dTxKyw9d9QUnjMk6YMFYydMIcIYk3+L/NQZUGpLdji33uK
 c/9t6On4cFQMBF8oV60WakJdrAHMlgg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-nFNoLw-eNMOFVsgFG6lkaA-1; Wed, 11 Dec 2019 10:07:51 -0500
Received: by mail-wm1-f70.google.com with SMTP id 7so1818143wmf.9
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 07:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1jbqvpXVWx1C2QN4aadpKQ7nY8XPhlOfaXsNjlzbnkg=;
 b=s4WZa6VpMi2bHAjlnvlCBCak5dkM1n8tW678E3hhlfJ/rVTIMs5N0vfJLq6d5ROSFn
 Ilia87DXRjGCIloYOWZqkqXthNZJHBHH1zUOkffHeHyXhXeeRmMPd2YdilZovyAHLHkX
 HTMm7Q3yFEmVu2Uy0zERfz6R6eZ2S3ARwH1BPGavUcLEq7bAhB4xmTxVUpUIEwDLFtwM
 yhinjr8LqKp+srNwrehH0xiprte+5YK0DU5Tpntzk7FvL0RBX9T0R4H8KtZ3t1aeXipM
 Y/FHaS2xjpvRT4L4hUOZSDZV2m5mskEgD2IqmFeDhRGXvhtGm9cnbEPmr64AGDdhq68K
 J1Vg==
X-Gm-Message-State: APjAAAVxUdXBAZyURemZPj8HbeUVM6a6dARG5B+iBHMEaRGighRS1E3k
 cxibPcZgzMu8c3fPAVwEfKF0re2yuZpfG4CHBRcZUCtGwHPW/g1DZOrcv7jP9R1tE6SMeXetfHP
 KpJeVFmFrC7yd5po=
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr287550wrv.9.1576076870264;
 Wed, 11 Dec 2019 07:07:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqx31rQwYjuKku43LLWcP1izoE6AcqMDCHaWdKbeAubjCnrp5CY+Vp9P4ZFgUhy5Nd7nEFGrGQ==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr287524wrv.9.1576076869937;
 Wed, 11 Dec 2019 07:07:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id t8sm2490820wrp.69.2019.12.11.07.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 07:07:49 -0800 (PST)
Subject: Re: [PATCH] ci: build out-of-tree
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1576074600-54759-1-git-send-email-pbonzini@redhat.com>
 <be96796e-958f-e51e-6832-b6376e2f9c72@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <650aa4be-b7be-0150-f6d9-590b9ce1f550@redhat.com>
Date: Wed, 11 Dec 2019 16:07:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <be96796e-958f-e51e-6832-b6376e2f9c72@redhat.com>
Content-Language: en-US
X-MC-Unique: nFNoLw-eNMOFVsgFG6lkaA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/19 15:50, Thomas Huth wrote:
> On 11/12/2019 15.30, Paolo Bonzini wrote:
>> Most developers are using out-of-tree builds and it was discussed in the=
 past
>> to only allow those.  To prepare for the transition, use out-of-tree bui=
lds
>> in all continuous integration jobs.
>>
>> Based on a patch by Marc-Andr=C3=A9 Lureau.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
> [...]
>> diff --git a/.travis.yml b/.travis.yml
>> index 445b064..d259b51 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -74,8 +74,8 @@ notifications:
>> =20
>>  env:
>>    global:
>> -    - SRC_DIR=3D"."
>> -    - BUILD_DIR=3D"."
>> +    - SRC_DIR=3D".."
>> +    - BUILD_DIR=3D"build"
>>      - BASE_CONFIG=3D"--disable-docs --disable-tools"
>>      - TEST_CMD=3D"make check V=3D1"
>>      # This is broadly a list of "mainline" softmmu targets which have s=
upport across the major distros
>> @@ -192,7 +192,9 @@ matrix:
>>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-clang-sanitize"
>>        compiler: clang
>>        before_script:
>> +        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>>          - ./configure ${CONFIG} --extra-cflags=3D"-fsanitize=3Dundefine=
d -Werror" || { cat config.log && exit 1; }
>=20
> Don't you want to remove the old line?
>=20
>> +        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags=3D"-fsanitize=
=3Dundefined -Werror" --extra-ldflags=3D"-fsanitize=3Dundefined" || { cat c=
onfig.log && exit 1; }
>> =20
>> =20
>>      - env:
>> @@ -323,6 +325,7 @@ matrix:
>>          - CONFIG=3D"--cc=3Dgcc-9 --cxx=3Dg++-9 --disable-pie --disable-=
linux-user"
>>          - TEST_CMD=3D""
>>        before_script:
>> +        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>>          - ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -Wno-error=3D=
stringop-truncation -fsanitize=3Dthread -fuse-ld=3Dgold" || { cat config.lo=
g && exit 1; }
>=20
> That should also use "../configure" (or $SRC_DIR/configure), shouldn't it=
?
>=20
>  Thomas
>=20

Yes, I've sent v2.  This was supposed to be --dry-run, sorry for the noise.

Paolo


