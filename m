Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB36C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065E5214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/6+bEkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065E5214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhcO-0005ej-5s
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izhbj-00055g-WD
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izhbi-0003oO-5O
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:54:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40946
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izhbi-0003il-0p
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580997253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Ils8Q3A712jvhUERwtYxbXMu+zq5hlfSK+/aN1Q9EQ=;
 b=H/6+bEkUCQNTgrR9YxBQjp2UYqNo7uNZ3+qKTFLPDPupjb+EEQCku3KtKxMOvrrpG+PyQS
 BJ/RczBgHy/z/LjTg66JBoNU8XirwMd4ZPg3JUpGfETfD6A8rdKb2ikx9haDcUvmK/3wf4
 GT+f1WSbvd87lLDz67SFLd8IwqRirHQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-enwWjVHxMWeV3VUzpgGA8g-1; Thu, 06 Feb 2020 08:54:09 -0500
Received: by mail-wr1-f70.google.com with SMTP id x15so3398702wrl.15
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 05:54:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=elXhSB+PPyr+ljin56JYXBPHu5EsgVz+jMoC6htZ81Q=;
 b=NZGLZwVvS5dmOzoeuV21UM5wTYDfwlRXjZTVauAitJEhz/Om0xUyIkArt/kR8s4qZF
 oouYD+buj4kW2/XubhlLYwTCuhROS0UWxZd4TheQVkq3aBdYRkOHt0NJoTePfrfNxzYK
 wccKdeVQ3MNbU7q9X5+qq5M4XmDftUC1ZWyUpbyNNusgvij96aJSpWQddEB5NijmEl+E
 EdRnnYHqSbp7Jd6mY5M3kqGfoKO2lFmJdk9AyvqzTd9m9AmjOVqFUw8WBbdlMb1l4M2J
 5S72D2gs/z1YPVLKCSxzVPAdzwSA/ei36PgpJEu7JfVI2QaE3lN8UWwRzgMmVynGXmo1
 GTOQ==
X-Gm-Message-State: APjAAAUh8vZ5lNybwFI4kqS376dWMtOYG/1Vae+utTyDCPXbl3vFhKqW
 Sp3BI4xyPAb5RDpcp+0WTLhcxZzIKrFkCOhp9wW82YB9gC/vmUimV7NJNLXedTwNNhVoiTPL5/O
 uBLvhTGl/+fuY9fE=
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr4756767wmi.35.1580997248088;
 Thu, 06 Feb 2020 05:54:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqxds9DoiUdqCsudrdY1ugeKmQdCeDMg/qjdTafk+2V0x/S//kIruKQ3QDcxeNDRwsd0iG81Lg==
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr4756740wmi.35.1580997247792;
 Thu, 06 Feb 2020 05:54:07 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i3sm1084209wrc.6.2020.02.06.05.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 05:54:07 -0800 (PST)
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <80f87c73-ed38-cba6-f551-20c7f5a46264@redhat.com>
 <c75939bf-828f-bff9-d42f-b11d141aae64@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ff1caa49-1698-e2c3-0205-213922ef2c1d@redhat.com>
Date: Thu, 6 Feb 2020 14:54:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c75939bf-828f-bff9-d42f-b11d141aae64@redhat.com>
Content-Language: en-US
X-MC-Unique: enwWjVHxMWeV3VUzpgGA8g-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 2:52 PM, Wainer dos Santos Moschetta wrote:
> On 2/6/20 11:03 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 2/3/20 4:23 AM, Cleber Rosa wrote:
>>> This is a crude and straightforward mapping of Peter's
>>> "remake-merge-builds" and "pull-buildtest" scripts.
>>>
>>> Some characteristics were removed for simplicity sake (but eventually
>>> will), including:
>>> =C2=A0 * number of simultaneous make jobs
>>> =C2=A0 * make's synchronous output, not needed because of previous poin=
t
>>> =C2=A0 * out-of-tree builds
>>>
>>> This covers the "x86-64 Linux with a variety of different build
>>> configs"[1].=C2=A0 I've personally tested all of them, and only had
>>> issues with the "notcg" job[2], but it seems to be a test specific
>>> issue with the nested KVM I was using.
>>>
>>> [1] - https://wiki.qemu.org/Requirements/GatingCI#Current_Tests
>>> [2] - https://paste.centos.org/view/1dd43a1c
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>> =C2=A0 .gitlab-ci.yml | 116 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>>> =C2=A0 1 file changed, 116 insertions(+)
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index d2c7d2198e..eb4077e2ab 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -2,6 +2,8 @@ include:
>>> =C2=A0=C2=A0=C2=A0 - local: '/.gitlab-ci-edk2.yml'
>>> =C2=A0 =C2=A0 build-system1:
>>> + rules:
>>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>>> =C2=A0=C2=A0 before_script: &before_scr_apt
>>> =C2=A0=C2=A0 - apt-get update -qq
>>> =C2=A0=C2=A0 - apt-get install -y -qq flex bison libglib2.0-dev libpixm=
an-1-dev=20
>>> genisoimage
>>> @@ -17,6 +19,8 @@ build-system1:
>>> =C2=A0=C2=A0 - make -j2 check
>>> =C2=A0 =C2=A0 build-system2:
>>> + rules:
>>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>>> =C2=A0=C2=A0 before_script:
>>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>>> =C2=A0=C2=A0 script:
>>> @@ -31,6 +35,8 @@ build-system2:
>>> =C2=A0=C2=A0 - make -j2 check
>>> =C2=A0 =C2=A0 build-disabled:
>>> + rules:
>>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>>> =C2=A0=C2=A0 before_script:
>>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>>> =C2=A0=C2=A0 script:
>>> @@ -47,6 +53,8 @@ build-disabled:
>>> =C2=A0=C2=A0 - make -j2 check-qtest SPEED=3Dslow
>>> =C2=A0 =C2=A0 build-tcg-disabled:
>>> + rules:
>>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>>> =C2=A0=C2=A0 before_script:
>>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>>> =C2=A0=C2=A0 script:
>>> @@ -67,6 +75,8 @@ build-tcg-disabled:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 248 250 254 255 256
>>> =C2=A0 =C2=A0 build-user:
>>> + rules:
>>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>>> =C2=A0=C2=A0 before_script:
>>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>>> =C2=A0=C2=A0 script:
>>> @@ -78,6 +88,8 @@ build-user:
>>> =C2=A0=C2=A0 - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-=
linux-user
>>> =C2=A0 =C2=A0 build-clang:
>>> + rules:
>>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>>> =C2=A0=C2=A0 before_script:
>>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>>> =C2=A0=C2=A0 script:
>>> @@ -92,6 +104,8 @@ build-clang:
>>> =C2=A0=C2=A0 - make -j2 check
>>> =C2=A0 =C2=A0 build-tci:
>>> + rules:
>>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>>> =C2=A0=C2=A0 before_script:
>>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>>> =C2=A0=C2=A0 script:
>>> @@ -111,3 +125,105 @@ build-tci:
>>> =C2=A0=C2=A0 - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64"=
=20
>>> ./tests/qtest/pxe-test
>>> =C2=A0=C2=A0 - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x"
>>> =C2=A0=C2=A0=C2=A0=C2=A0 ./tests/qtest/pxe-test -m slow
>>> +
>>> +ubuntu-18.04.3-x86_64-notools:
>>> + tags:
>>> + - ubuntu_18.04.3
>>> + - x86_64
>>> + rules:
>>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>>> + script:
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remak=
e-merge-builds#n22=20
>>>
>>> + - ./configure --target-list=3Darm-softmmu --disable-tools=20
>>> --disable-libssh
>>> + # There is no make / make check in the "pull-buildtest" script for=20
>>> this.
>>> + # Question: should it at least be built? Or dropped?
>>> + - make
>>> +
>>> +ubuntu-18.04.3-x86_64-all-linux-static:
>>> + tags:
>>> + - ubuntu_18.04.3
>>> + - x86_64
>>> + rules:
>>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>>> + script:
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remak=
e-merge-builds#n25=20
>>>
>>> + - ./configure --enable-debug --static --disable-system=20
>>> --disable-glusterfs --disable-libssh
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n36=20
>>>
>>> + - make
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n45=20
>>>
>>> + - make check V=3D1
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n48=20
>>>
>>> + - make check-tcg V=3D1
>>> +
>>> +ubuntu-18.04.3-x86_64-all:
>>> + tags:
>>> + - ubuntu_18.04.3
>>> + - x86_64
>>> + rules:
>>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>>> + script:
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remak=
e-merge-builds#n26=20
>>>
>>> + - ./configure --disable-libssh
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n28=20
>>>
>>> + - make
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n37=20
>>>
>>> + - make check V=3D1
>>> +
>>> +ubuntu-18.04.3-x86_64-alldbg:
>>> + tags:
>>> + - ubuntu_18.04.3
>>> + - x86_64
>>> + rules:
>>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>>> + script:
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remak=
e-merge-builds#n27=20
>>>
>>> + - ./configure --disable-libssh
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n27=20
>>>
>>> + - make clean
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n29=20
>>>
>>> + - make
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n37=20
>>>
>>> + - make check V=3D1
>>> +
>>> +ubuntu-18.04.3-x86_64-clang:
>>> + tags:
>>> + - ubuntu_18.04.3
>>> + - x86_64
>>> + rules:
>>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>>> + script:
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remak=
e-merge-builds#n31=20
>>>
>>> + - ./configure --disable-libssh --cc=3Dclang --cxx=3Dclang++=20
>>> --enable-gtk --extra-cflags=3D'-fsanitize=3Dundefined=20
>>> -fno-sanitize=3Dshift-base -Werror'
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n33=20
>>>
>>> + - make
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n39=20
>>>
>>> + - make check V=3D1
>>> +
>>> +ubuntu-18.04.3-x86_64-tci:
>>> + tags:
>>> + - ubuntu_18.04.3
>>> + - x86_64
>>> + rules:
>>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>>> + script:
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remak=
e-merge-builds#n33=20
>>>
>>> + - ./configure --disable-libssh --enable-debug --enable-tcg-interprete=
r
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n34=20
>>>
>>> + - make
>>> +
>>> +ubuntu-18.04.3-x86_64-notcg:
>>> + tags:
>>> + - ubuntu_18.04.3
>>> + - x86_64
>>> + rules:
>>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>>> + script:
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remak=
e-merge-builds#n35=20
>>>
>>> + - ./configure --disable-libssh --enable-debug --disable-tcg
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n35=20
>>>
>>> + - make
>>> + #=20
>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n39=20
>>>
>>> + # Question: check is disabled on the original script, because the=20
>>> machine
>>> + # is said to be running VirtualBox.=C2=A0 Should this be dropped or=
=20
>>> should the
>>> + # machine be tweaked or substituted?
>>> + - make check V=3D1
>>
>> On another thread Thomas said he doesn't want to be responsible of=20
>> other tests:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg670132.html
>>
>> We could move the set of tests converted from Peter personal testsuite=
=20
>> into a separate YAML, so the interested (you Cleber, and Peter) can=20
>> have a F: entry in MAINTAINERS for it:
>=20
>=20
> I like that idea.
>=20
>=20
>>
>>
>> include:
>> =C2=A0 - local: '/.gitlab-ci-pm215.yml'
>=20
>=20
> If so, I suggest moving the file to the .gitlab-ci.d directory instead.=
=20
> Likewise the .gitlab-ci-edk2.yml file. This way the sources root=20
> directory does not get infested of GitLab files.

Yes, +1. I'm pretty sure Thomas will like that too.


