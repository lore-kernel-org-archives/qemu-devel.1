Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93EAC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FCF21775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPu2v11s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FCF21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izh0q-0000Ha-SV
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izgow-0003Hy-13
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izgou-00018l-6k
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:03:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55263
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izgot-000152-W2
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580994227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmt39iqxDB9+2RJPIis2e2uW25dDpeUMKXynOKRZMCg=;
 b=bPu2v11sZDyDr4ZjN9rFnHJxbPtN3elwsAYYuez4dcyY/o2a7IdVnqr1pFcv4F6qO0PmGZ
 mh/Nv8X9jSXECMI67u1UIklRjehpcIKfd2m/DWifPh8Ghr4N6kaMU+yTu1sNBYKCfjahC3
 ouH1WnWrSyIcZgTylIxb0lGO10cLz3I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-7OHGquYHPUeLlGGXftw3VA-1; Thu, 06 Feb 2020 08:03:30 -0500
Received: by mail-wr1-f72.google.com with SMTP id s13so3331832wru.7
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 05:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nmt39iqxDB9+2RJPIis2e2uW25dDpeUMKXynOKRZMCg=;
 b=PHDAtKZNk3lfiRZER5cFRpnrv62v8eA4lI1goMT89c+vmqusyFEN6p0ZzIvO17j3Mk
 VIK4HOahZkFHGUaIlU1qaM7fPhv/ri9IVSY+mqkh/FdV7CJ4vD6bDlOdpB3W/Iw8blYH
 EY27FvUZPnigMvBngXMauJhInbFNK1kv35jlEM0NbIPzODXqKKgjgHTWt79ZBTW0w4qN
 znd2RtZTs3EkTxcVY1qu6wC/H0fVxMBFNSrIymkK4CtiFv2IEwNpAvnkpoQRGnIdjV/a
 Kzyr2xmtbUZjmNQ9mlSwIXB4Pf1zxQu+SN0gHgtYTDNnngVttmoVeJmscoqdSwSkMF2U
 atLA==
X-Gm-Message-State: APjAAAUEPt/M55lKVWxyLZvFkrdHzhPaVazEHSSwhjmi7WWMMNS7dSVS
 0bmx92zO6TY7X7EX8bzYBhrxVfJe2CMmMTmS174wz7AotUkzSvdZsyLtWTvpucqUfG9dUUafw7c
 91Yu5+5xV8lWVJJg=
X-Received: by 2002:a05:6000:1112:: with SMTP id
 z18mr3656715wrw.140.1580994209060; 
 Thu, 06 Feb 2020 05:03:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7+WhUPyLxgTIsD4NBkHYy4hm2K0UQcBn4/cHDvWFW1eA+CRfHDFFdk/wqRni4bhaJvCYNAw==
X-Received: by 2002:a05:6000:1112:: with SMTP id
 z18mr3656694wrw.140.1580994208774; 
 Thu, 06 Feb 2020 05:03:28 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g7sm4142070wrq.21.2020.02.06.05.03.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 05:03:28 -0800 (PST)
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <80f87c73-ed38-cba6-f551-20c7f5a46264@redhat.com>
Date: Thu, 6 Feb 2020 14:03:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203032328.12051-2-crosa@redhat.com>
Content-Language: en-US
X-MC-Unique: 7OHGquYHPUeLlGGXftw3VA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 4:23 AM, Cleber Rosa wrote:
> This is a crude and straightforward mapping of Peter's
> "remake-merge-builds" and "pull-buildtest" scripts.
> 
> Some characteristics were removed for simplicity sake (but eventually
> will), including:
>   * number of simultaneous make jobs
>   * make's synchronous output, not needed because of previous point
>   * out-of-tree builds
> 
> This covers the "x86-64 Linux with a variety of different build
> configs"[1].  I've personally tested all of them, and only had
> issues with the "notcg" job[2], but it seems to be a test specific
> issue with the nested KVM I was using.
> 
> [1] - https://wiki.qemu.org/Requirements/GatingCI#Current_Tests
> [2] - https://paste.centos.org/view/1dd43a1c
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   .gitlab-ci.yml | 116 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 116 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index d2c7d2198e..eb4077e2ab 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -2,6 +2,8 @@ include:
>     - local: '/.gitlab-ci-edk2.yml'
>   
>   build-system1:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME != "staging"'
>    before_script: &before_scr_apt
>    - apt-get update -qq
>    - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev genisoimage
> @@ -17,6 +19,8 @@ build-system1:
>    - make -j2 check
>   
>   build-system2:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME != "staging"'
>    before_script:
>     *before_scr_apt
>    script:
> @@ -31,6 +35,8 @@ build-system2:
>    - make -j2 check
>   
>   build-disabled:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME != "staging"'
>    before_script:
>     *before_scr_apt
>    script:
> @@ -47,6 +53,8 @@ build-disabled:
>    - make -j2 check-qtest SPEED=slow
>   
>   build-tcg-disabled:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME != "staging"'
>    before_script:
>     *before_scr_apt
>    script:
> @@ -67,6 +75,8 @@ build-tcg-disabled:
>               248 250 254 255 256
>   
>   build-user:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME != "staging"'
>    before_script:
>     *before_scr_apt
>    script:
> @@ -78,6 +88,8 @@ build-user:
>    - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
>   
>   build-clang:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME != "staging"'
>    before_script:
>     *before_scr_apt
>    script:
> @@ -92,6 +104,8 @@ build-clang:
>    - make -j2 check
>   
>   build-tci:
> + rules:
> + - if: '$CI_COMMIT_REF_NAME != "staging"'
>    before_script:
>     *before_scr_apt
>    script:
> @@ -111,3 +125,105 @@ build-tci:
>    - QTEST_QEMU_BINARY="x86_64-softmmu/qemu-system-x86_64" ./tests/qtest/pxe-test
>    - QTEST_QEMU_BINARY="s390x-softmmu/qemu-system-s390x"
>      ./tests/qtest/pxe-test -m slow
> +
> +ubuntu-18.04.3-x86_64-notools:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME == "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n22
> + - ./configure --target-list=arm-softmmu --disable-tools --disable-libssh
> + # There is no make / make check in the "pull-buildtest" script for this.
> + # Question: should it at least be built? Or dropped?
> + - make
> +
> +ubuntu-18.04.3-x86_64-all-linux-static:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME == "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n25
> + - ./configure --enable-debug --static --disable-system --disable-glusterfs --disable-libssh
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n36
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n45
> + - make check V=1
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n48
> + - make check-tcg V=1
> +
> +ubuntu-18.04.3-x86_64-all:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME == "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n26
> + - ./configure --disable-libssh
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n28
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n37
> + - make check V=1
> +
> +ubuntu-18.04.3-x86_64-alldbg:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME == "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n27
> + - ./configure --disable-libssh
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n27
> + - make clean
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n29
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n37
> + - make check V=1
> +
> +ubuntu-18.04.3-x86_64-clang:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME == "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n31
> + - ./configure --disable-libssh --cc=clang --cxx=clang++ --enable-gtk --extra-cflags='-fsanitize=undefined -fno-sanitize=shift-base -Werror'
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n33
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n39
> + - make check V=1
> +
> +ubuntu-18.04.3-x86_64-tci:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME == "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n33
> + - ./configure --disable-libssh --enable-debug --enable-tcg-interpreter
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n34
> + - make
> +
> +ubuntu-18.04.3-x86_64-notcg:
> + tags:
> + - ubuntu_18.04.3
> + - x86_64
> + rules:
> + - if: '$CI_COMMIT_REF_NAME == "staging"'
> + script:
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remake-merge-builds#n35
> + - ./configure --disable-libssh --enable-debug --disable-tcg
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n35
> + - make
> + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-buildtest#n39
> + # Question: check is disabled on the original script, because the machine
> + # is said to be running VirtualBox.  Should this be dropped or should the
> + # machine be tweaked or substituted?
> + - make check V=1

On another thread Thomas said he doesn't want to be responsible of other 
tests:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg670132.html

We could move the set of tests converted from Peter personal testsuite 
into a separate YAML, so the interested (you Cleber, and Peter) can have 
a F: entry in MAINTAINERS for it:

include:
   - local: '/.gitlab-ci-pm215.yml'


