Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2000C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10AC214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCo94iT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10AC214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgv1-0006ty-Tq
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izgqH-000650-OZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izgqF-0004OG-IA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:05:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25741
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izgqF-0004Ny-DQ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580994310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iMldC8mPWy1dGydypVLig323CqeapqU7HbGIk0bAczU=;
 b=MCo94iT0+UPNgmAaTrQKobp/9/W1+V6Wjf9XBTX2Y/MqMwskxI3eEGbXAHAGq7KOmTfxf9
 q9fSwynHg9/8H7s4Kmr7C65bIZ+WhLElxwoV24fUPoJMDdN0tE9pJwvUnHj3gHT2FJqwOm
 tI6p8Z2zTAyeVfo3J0cGAMceoTIO2Tc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-agrEMWd6OKuzpVsZG51d3Q-1; Thu, 06 Feb 2020 08:05:08 -0500
Received: by mail-wr1-f71.google.com with SMTP id z15so3377628wrw.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 05:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EhewbcTY6OfekalZUPBQX2C+kwuAw058umiICqtlCmE=;
 b=dX9KaeWjQ9iRInw37GH/rJ8Ebo5Ms8b9jgMU7KIHFVmslg96o1uSa/VI3WzzLYluCs
 L3e4DGfb5QFaGyXo6nxdYu1DCVMc/P4ZQihco8UbHq5nbiCEH/khnqPHx+4h9vnT9L6r
 3j1In7Calmq+EXC0KMuYqOy68t+b+Rj7U59Re1nP7hcGCydxn0O1KPuQmCgvh2wOwlVO
 lGdnzkjj4/WrV4/hnuVYOrPrgr7oStYuGr3OY9eUHex/MAO9gxEp8m+yaSGaiA7GvJ/m
 EEYCUdw6JsEB4r2oYgBd0yAttgb+gfZxhi6n/FF04N//bBVi6KHsGiGfXe676D+XD86/
 pHiQ==
X-Gm-Message-State: APjAAAW8zAHKu1N+6jq6GCieWFBBcMJzckGv4W0ntbgQdQJmz0QZPeUW
 9j7TjI+7/5eWhUfJWObX8hIB3M1f/t1aDHxzxmKXsqx7HXCH0GQd9HjTpsIRPYHoHUHz9gkFHGW
 MI1D+tnV13LUXtyM=
X-Received: by 2002:a5d:438c:: with SMTP id i12mr3660984wrq.51.1580994306745; 
 Thu, 06 Feb 2020 05:05:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3ctSjOjAvYJKjHOVOZdKcswWLrdYz3Ju6tAy3gFD5fmG4D6o3TzFyOT+FJBFW66Itux0Thw==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr3660954wrq.51.1580994306387; 
 Thu, 06 Feb 2020 05:05:06 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id e22sm3702794wme.45.2020.02.06.05.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 05:05:05 -0800 (PST)
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <80f87c73-ed38-cba6-f551-20c7f5a46264@redhat.com>
Message-ID: <e7aea58f-8ed0-239f-04d8-934c8c00e51d@redhat.com>
Date: Thu, 6 Feb 2020 14:05:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <80f87c73-ed38-cba6-f551-20c7f5a46264@redhat.com>
Content-Language: en-US
X-MC-Unique: agrEMWd6OKuzpVsZG51d3Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 2:03 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/3/20 4:23 AM, Cleber Rosa wrote:
>> This is a crude and straightforward mapping of Peter's
>> "remake-merge-builds" and "pull-buildtest" scripts.
>>
>> Some characteristics were removed for simplicity sake (but eventually
>> will), including:
>> =C2=A0 * number of simultaneous make jobs
>> =C2=A0 * make's synchronous output, not needed because of previous point
>> =C2=A0 * out-of-tree builds
>>
>> This covers the "x86-64 Linux with a variety of different build
>> configs"[1].=C2=A0 I've personally tested all of them, and only had
>> issues with the "notcg" job[2], but it seems to be a test specific
>> issue with the nested KVM I was using.
>>
>> [1] - https://wiki.qemu.org/Requirements/GatingCI#Current_Tests
>> [2] - https://paste.centos.org/view/1dd43a1c
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>> =C2=A0 .gitlab-ci.yml | 116 ++++++++++++++++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 1 file changed, 116 insertions(+)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index d2c7d2198e..eb4077e2ab 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -2,6 +2,8 @@ include:
>> =C2=A0=C2=A0=C2=A0 - local: '/.gitlab-ci-edk2.yml'
>> =C2=A0 build-system1:
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>> =C2=A0=C2=A0 before_script: &before_scr_apt
>> =C2=A0=C2=A0 - apt-get update -qq
>> =C2=A0=C2=A0 - apt-get install -y -qq flex bison libglib2.0-dev libpixma=
n-1-dev=20
>> genisoimage
>> @@ -17,6 +19,8 @@ build-system1:
>> =C2=A0=C2=A0 - make -j2 check
>> =C2=A0 build-system2:
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>> =C2=A0=C2=A0 before_script:
>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>> =C2=A0=C2=A0 script:
>> @@ -31,6 +35,8 @@ build-system2:
>> =C2=A0=C2=A0 - make -j2 check
>> =C2=A0 build-disabled:
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>> =C2=A0=C2=A0 before_script:
>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>> =C2=A0=C2=A0 script:
>> @@ -47,6 +53,8 @@ build-disabled:
>> =C2=A0=C2=A0 - make -j2 check-qtest SPEED=3Dslow
>> =C2=A0 build-tcg-disabled:
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>> =C2=A0=C2=A0 before_script:
>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>> =C2=A0=C2=A0 script:
>> @@ -67,6 +75,8 @@ build-tcg-disabled:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 248 250 254 255 256
>> =C2=A0 build-user:
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>> =C2=A0=C2=A0 before_script:
>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>> =C2=A0=C2=A0 script:
>> @@ -78,6 +88,8 @@ build-user:
>> =C2=A0=C2=A0 - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-l=
inux-user
>> =C2=A0 build-clang:
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>> =C2=A0=C2=A0 before_script:
>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>> =C2=A0=C2=A0 script:
>> @@ -92,6 +104,8 @@ build-clang:
>> =C2=A0=C2=A0 - make -j2 check
>> =C2=A0 build-tci:
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>> =C2=A0=C2=A0 before_script:
>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>> =C2=A0=C2=A0 script:
>> @@ -111,3 +125,105 @@ build-tci:
>> =C2=A0=C2=A0 - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64"=
=20
>> ./tests/qtest/pxe-test
>> =C2=A0=C2=A0 - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x"
>> =C2=A0=C2=A0=C2=A0=C2=A0 ./tests/qtest/pxe-test -m slow
>> +
>> +ubuntu-18.04.3-x86_64-notools:
>> + tags:
>> + - ubuntu_18.04.3
>> + - x86_64
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>> + script:
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake=
-merge-builds#n22=20
>>
>> + - ./configure --target-list=3Darm-softmmu --disable-tools=20
>> --disable-libssh
>> + # There is no make / make check in the "pull-buildtest" script for=20
>> this.
>> + # Question: should it at least be built? Or dropped?
>> + - make
>> +
>> +ubuntu-18.04.3-x86_64-all-linux-static:
>> + tags:
>> + - ubuntu_18.04.3
>> + - x86_64
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>> + script:
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake=
-merge-builds#n25=20
>>
>> + - ./configure --enable-debug --static --disable-system=20
>> --disable-glusterfs --disable-libssh
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-b=
uildtest#n36=20
>>
>> + - make
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-b=
uildtest#n45=20
>>
>> + - make check V=3D1
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-b=
uildtest#n48=20
>>
>> + - make check-tcg V=3D1
>> +
>> +ubuntu-18.04.3-x86_64-all:
>> + tags:
>> + - ubuntu_18.04.3
>> + - x86_64
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>> + script:
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake=
-merge-builds#n26=20
>>
>> + - ./configure --disable-libssh
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-b=
uildtest#n28=20
>>
>> + - make
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-b=
uildtest#n37=20
>>
>> + - make check V=3D1
>> +
>> +ubuntu-18.04.3-x86_64-alldbg:
>> + tags:
>> + - ubuntu_18.04.3
>> + - x86_64
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>> + script:
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake=
-merge-builds#n27=20
>>
>> + - ./configure --disable-libssh
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-b=
uildtest#n27=20
>>
>> + - make clean
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-b=
uildtest#n29=20
>>
>> + - make
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-b=
uildtest#n37=20
>>
>> + - make check V=3D1
>> +
>> +ubuntu-18.04.3-x86_64-clang:
>> + tags:
>> + - ubuntu_18.04.3
>> + - x86_64
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>> + script:
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake=
-merge-builds#n31=20
>>
>> + - ./configure --disable-libssh --cc=3Dclang --cxx=3Dclang++ --enable-g=
tk=20
>> --extra-cflags=3D'-fsanitize=3Dundefined -fno-sanitize=3Dshift-base -Wer=
ror'
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-b=
uildtest#n33=20
>>
>> + - make
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-b=
uildtest#n39=20
>>
>> + - make check V=3D1
>> +
>> +ubuntu-18.04.3-x86_64-tci:
>> + tags:
>> + - ubuntu_18.04.3
>> + - x86_64
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>> + script:
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake=
-merge-builds#n33=20
>>
>> + - ./configure --disable-libssh --enable-debug --enable-tcg-interpreter
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-b=
uildtest#n34=20
>>
>> + - make
>> +
>> +ubuntu-18.04.3-x86_64-notcg:
>> + tags:
>> + - ubuntu_18.04.3
>> + - x86_64
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>> + script:
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake=
-merge-builds#n35=20
>>
>> + - ./configure --disable-libssh --enable-debug --disable-tcg
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-b=
uildtest#n35=20
>>
>> + - make
>> + #=20
>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-b=
uildtest#n39=20
>>
>> + # Question: check is disabled on the original script, because the=20
>> machine
>> + # is said to be running VirtualBox.=C2=A0 Should this be dropped or=20
>> should the
>> + # machine be tweaked or substituted?
>> + - make check V=3D1
>=20
> On another thread Thomas said he doesn't want to be responsible of other=
=20
> tests:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg670132.html
>=20
> We could move the set of tests converted from Peter personal testsuite=20
> into a separate YAML, so the interested (you Cleber, and Peter) can have=
=20
> a F: entry in MAINTAINERS for it:
>=20
> include:
>  =C2=A0 - local: '/.gitlab-ci-pm215.yml'

I'm not calling this file "pm215" because Peter owns it, but because it=20
would contains all the tests Peter was running manually before we use=20
GitLab as a gating CI.


