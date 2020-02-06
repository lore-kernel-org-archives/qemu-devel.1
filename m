Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D13DC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B81620838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlyXBIRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B81620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izis4-0007Fz-ET
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1izirG-0006K6-5L
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:14:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1izirD-0007IP-6v
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:14:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35330
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1izirC-0007H1-VR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581002058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=nWKHvIgwPsvlxVgFq6KOSdHHx2NCINMTF5XEKRkrhwo=;
 b=hlyXBIRMexO75jxKLyR3Urobq+agt/fYOZr8lw8Vp639DS8XOVDS1KwIpViyoyc2qn4L66
 sIQhcfV/0/ShgJcjQsFHxpeVIni/c9fc6pfFy2ajWvOzFHyraPXAm8L9gg8eoFaFYLiBTc
 IuupOSCnGI0VnYfT0n8JBKz4r9vrDEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-jA0XNpWBPXW6MWF70fEidA-1; Thu, 06 Feb 2020 10:13:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C49C91137843;
 Thu,  6 Feb 2020 15:13:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F1E887B1C;
 Thu,  6 Feb 2020 15:13:51 +0000 (UTC)
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <80f87c73-ed38-cba6-f551-20c7f5a46264@redhat.com>
 <c75939bf-828f-bff9-d42f-b11d141aae64@redhat.com>
 <ff1caa49-1698-e2c3-0205-213922ef2c1d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c0cd7780-a73a-376d-1410-c48ab50d37fc@redhat.com>
Date: Thu, 6 Feb 2020 16:13:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ff1caa49-1698-e2c3-0205-213922ef2c1d@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: jA0XNpWBPXW6MWF70fEidA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/02/2020 14.54, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/6/20 2:52 PM, Wainer dos Santos Moschetta wrote:
>> On 2/6/20 11:03 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 2/3/20 4:23 AM, Cleber Rosa wrote:
>>>> This is a crude and straightforward mapping of Peter's
>>>> "remake-merge-builds" and "pull-buildtest" scripts.
>>>>
>>>> Some characteristics were removed for simplicity sake (but eventually
>>>> will), including:
>>>> =C2=A0 * number of simultaneous make jobs
>>>> =C2=A0 * make's synchronous output, not needed because of previous poi=
nt
>>>> =C2=A0 * out-of-tree builds
>>>>
>>>> This covers the "x86-64 Linux with a variety of different build
>>>> configs"[1].=C2=A0 I've personally tested all of them, and only had
>>>> issues with the "notcg" job[2], but it seems to be a test specific
>>>> issue with the nested KVM I was using.
>>>>
>>>> [1] - https://wiki.qemu.org/Requirements/GatingCI#Current_Tests
>>>> [2] - https://paste.centos.org/view/1dd43a1c
>>>>
>>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>>> ---
>>>> =C2=A0 .gitlab-ci.yml | 116
>>>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>>> =C2=A0 1 file changed, 116 insertions(+)
>>>>
>>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>>> index d2c7d2198e..eb4077e2ab 100644
>>>> --- a/.gitlab-ci.yml
>>>> +++ b/.gitlab-ci.yml
>>>> @@ -2,6 +2,8 @@ include:
>>>> =C2=A0=C2=A0=C2=A0 - local: '/.gitlab-ci-edk2.yml'
>>>> =C2=A0 =C2=A0 build-system1:
>>>> + rules:
>>>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>>>> =C2=A0=C2=A0 before_script: &before_scr_apt
>>>> =C2=A0=C2=A0 - apt-get update -qq
>>>> =C2=A0=C2=A0 - apt-get install -y -qq flex bison libglib2.0-dev
>>>> libpixman-1-dev genisoimage
>>>> @@ -17,6 +19,8 @@ build-system1:
>>>> =C2=A0=C2=A0 - make -j2 check
>>>> =C2=A0 =C2=A0 build-system2:
>>>> + rules:
>>>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>>>> =C2=A0=C2=A0 before_script:
>>>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>>>> =C2=A0=C2=A0 script:
>>>> @@ -31,6 +35,8 @@ build-system2:
>>>> =C2=A0=C2=A0 - make -j2 check
>>>> =C2=A0 =C2=A0 build-disabled:
>>>> + rules:
>>>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>>>> =C2=A0=C2=A0 before_script:
>>>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>>>> =C2=A0=C2=A0 script:
>>>> @@ -47,6 +53,8 @@ build-disabled:
>>>> =C2=A0=C2=A0 - make -j2 check-qtest SPEED=3Dslow
>>>> =C2=A0 =C2=A0 build-tcg-disabled:
>>>> + rules:
>>>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>>>> =C2=A0=C2=A0 before_script:
>>>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>>>> =C2=A0=C2=A0 script:
>>>> @@ -67,6 +75,8 @@ build-tcg-disabled:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 248 250 254 255 256
>>>> =C2=A0 =C2=A0 build-user:
>>>> + rules:
>>>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>>>> =C2=A0=C2=A0 before_script:
>>>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>>>> =C2=A0=C2=A0 script:
>>>> @@ -78,6 +88,8 @@ build-user:
>>>> =C2=A0=C2=A0 - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64=
-linux-user
>>>> =C2=A0 =C2=A0 build-clang:
>>>> + rules:
>>>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>>>> =C2=A0=C2=A0 before_script:
>>>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>>>> =C2=A0=C2=A0 script:
>>>> @@ -92,6 +104,8 @@ build-clang:
>>>> =C2=A0=C2=A0 - make -j2 check
>>>> =C2=A0 =C2=A0 build-tci:
>>>> + rules:
>>>> + - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
>>>> =C2=A0=C2=A0 before_script:
>>>> =C2=A0=C2=A0=C2=A0 *before_scr_apt
>>>> =C2=A0=C2=A0 script:
>>>> @@ -111,3 +125,105 @@ build-tci:
>>>> =C2=A0=C2=A0 - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64"
>>>> ./tests/qtest/pxe-test
>>>> =C2=A0=C2=A0 - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x"
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ./tests/qtest/pxe-test -m slow
>>>> +
>>>> +ubuntu-18.04.3-x86_64-notools:
>>>> + tags:
>>>> + - ubuntu_18.04.3
>>>> + - x86_64
>>>> + rules:
>>>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>>>> + script:
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rema=
ke-merge-builds#n22
>>>>
>>>> + - ./configure --target-list=3Darm-softmmu --disable-tools
>>>> --disable-libssh
>>>> + # There is no make / make check in the "pull-buildtest" script for
>>>> this.
>>>> + # Question: should it at least be built? Or dropped?
>>>> + - make
>>>> +
>>>> +ubuntu-18.04.3-x86_64-all-linux-static:
>>>> + tags:
>>>> + - ubuntu_18.04.3
>>>> + - x86_64
>>>> + rules:
>>>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>>>> + script:
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rema=
ke-merge-builds#n25
>>>>
>>>> + - ./configure --enable-debug --static --disable-system
>>>> --disable-glusterfs --disable-libssh
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull=
-buildtest#n36
>>>>
>>>> + - make
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull=
-buildtest#n45
>>>>
>>>> + - make check V=3D1
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull=
-buildtest#n48
>>>>
>>>> + - make check-tcg V=3D1
>>>> +
>>>> +ubuntu-18.04.3-x86_64-all:
>>>> + tags:
>>>> + - ubuntu_18.04.3
>>>> + - x86_64
>>>> + rules:
>>>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>>>> + script:
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rema=
ke-merge-builds#n26
>>>>
>>>> + - ./configure --disable-libssh
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull=
-buildtest#n28
>>>>
>>>> + - make
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull=
-buildtest#n37
>>>>
>>>> + - make check V=3D1
>>>> +
>>>> +ubuntu-18.04.3-x86_64-alldbg:
>>>> + tags:
>>>> + - ubuntu_18.04.3
>>>> + - x86_64
>>>> + rules:
>>>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>>>> + script:
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rema=
ke-merge-builds#n27
>>>>
>>>> + - ./configure --disable-libssh
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull=
-buildtest#n27
>>>>
>>>> + - make clean
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull=
-buildtest#n29
>>>>
>>>> + - make
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull=
-buildtest#n37
>>>>
>>>> + - make check V=3D1
>>>> +
>>>> +ubuntu-18.04.3-x86_64-clang:
>>>> + tags:
>>>> + - ubuntu_18.04.3
>>>> + - x86_64
>>>> + rules:
>>>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>>>> + script:
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rema=
ke-merge-builds#n31
>>>>
>>>> + - ./configure --disable-libssh --cc=3Dclang --cxx=3Dclang++
>>>> --enable-gtk --extra-cflags=3D'-fsanitize=3Dundefined
>>>> -fno-sanitize=3Dshift-base -Werror'
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull=
-buildtest#n33
>>>>
>>>> + - make
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull=
-buildtest#n39
>>>>
>>>> + - make check V=3D1
>>>> +
>>>> +ubuntu-18.04.3-x86_64-tci:
>>>> + tags:
>>>> + - ubuntu_18.04.3
>>>> + - x86_64
>>>> + rules:
>>>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>>>> + script:
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rema=
ke-merge-builds#n33
>>>>
>>>> + - ./configure --disable-libssh --enable-debug
>>>> --enable-tcg-interpreter
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull=
-buildtest#n34
>>>>
>>>> + - make
>>>> +
>>>> +ubuntu-18.04.3-x86_64-notcg:
>>>> + tags:
>>>> + - ubuntu_18.04.3
>>>> + - x86_64
>>>> + rules:
>>>> + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
>>>> + script:
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/rema=
ke-merge-builds#n35
>>>>
>>>> + - ./configure --disable-libssh --enable-debug --disable-tcg
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull=
-buildtest#n35
>>>>
>>>> + - make
>>>> + #
>>>> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull=
-buildtest#n39
>>>>
>>>> + # Question: check is disabled on the original script, because the
>>>> machine
>>>> + # is said to be running VirtualBox.=C2=A0 Should this be dropped or
>>>> should the
>>>> + # machine be tweaked or substituted?
>>>> + - make check V=3D1
>>>
>>> On another thread Thomas said he doesn't want to be responsible of
>>> other tests:
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg670132.html
>>>
>>> We could move the set of tests converted from Peter personal
>>> testsuite into a separate YAML, so the interested (you Cleber, and
>>> Peter) can have a F: entry in MAINTAINERS for it:
>>
>>
>> I like that idea.
>>
>>
>>>
>>>
>>> include:
>>> =C2=A0 - local: '/.gitlab-ci-pm215.yml'
>>
>>
>> If so, I suggest moving the file to the .gitlab-ci.d directory
>> instead. Likewise the .gitlab-ci-edk2.yml file. This way the sources
>> root directory does not get infested of GitLab files.
>=20
> Yes, +1. I'm pretty sure Thomas will like that too.

Sure. But I'd be also fine sharing or even completely handing over the
entry in MAINTAINERS for .gitlab-ci.yml to someone else. I'm only listed
there since I was initially the only one who was using the gitlab CI.
Now that there is interest for using gitlab CI as our gating CI, I think
it would be good to have some other people listed here, too...

 Thomas


