Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3BDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8075920781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpERWx9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8075920781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPsA-00072v-N5
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1joPqO-0004xC-Rx
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:15:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1joPqM-00009U-K9
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:15:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id h15so5409488wrq.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 04:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YMmvicRRK3kYjGr/ZnkW+6vncF9nze62y7FbaUs6kJQ=;
 b=cpERWx9ffN7blWdqwUtaqU5zzMSfdn3wzDQrjWwOZQoMxJPk523xIT6N7EPqJMoDSA
 6P1qY3vzFSAz7kXTNgnOo2ETHI8TXKI7ZXtY5NuIx6xuXy/o/CULGRNq+Avg05qXlM6s
 ulP8U3yYCIIII7bsU5wmqy6tnmEqXfQI/lGucpL9/D86ufgM1RmBxaE4NcF3u7U3WNDC
 OfY+mAdKmKyMQF0cBtTfTweYV6xjcdX6Ta1Ej5Oh9Lw5hwt1Wo62NjN7Wn7SYCWMA9zv
 kBpHpaXzxZmfkNtnv/KiXPqDACUPWlFQnNHoVRQ3mAT6NKBFaR6K7rGwRQpsuOvNktPM
 DwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YMmvicRRK3kYjGr/ZnkW+6vncF9nze62y7FbaUs6kJQ=;
 b=VrUEECZBLRHHG3/uBRsbKI9qlJqPSntGKp7pMvcwUjyfBrcP7vGUa2l3WhDWAcpa4C
 H+1rT+lEp3aNc8C+eDXf5DP5WncsdQLre6NXi2aQmkJnFyrESnF2GNPBhJLcgHTuFU0C
 +wsF0WkMgiLH/RG6YDKIsQRNbk2P95nF8th/Uik8MP1rFIkM/viGOeI5re7tJD/BcvaF
 u96uTxHAS7zQWseaAFZ9kuGd83+MHhVRiWglhjuv5Zoi+zDyC9JHoaTA4tfNXaQxtxt8
 0kvt/J2+8E9a8d8E0973cXl090NkZ3AF43lqwf53Eweig6BFZAJNqZadDJJC0EAkOOqg
 RpPQ==
X-Gm-Message-State: AOAM5339WNl//xgDQuZQ0xIBtFgiJp1qHNdcWo2ZssHBbAsap5aDQs3J
 dC74EXrN/yT0WOUXhvtrF2iwUyaMadg=
X-Google-Smtp-Source: ABdhPJxW0Dx1OpgCNwU/7hEGjKQEx7quLar3Oqdwf2bphYST4L2tR7GdWjvaDKbL0NR5nqy15t0skQ==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr31351208wrr.259.1593083695833; 
 Thu, 25 Jun 2020 04:14:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k185sm8743969wmk.47.2020.06.25.04.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 04:14:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9F7B91FF7E;
 Thu, 25 Jun 2020 12:14:50 +0100 (BST)
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-3-berrange@redhat.com>
 <20200625100701.GE1009994@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH RFC 2/3] gitlab: build all container images during CI
In-reply-to: <20200625100701.GE1009994@redhat.com>
Date: Thu, 25 Jun 2020 12:14:50 +0100
Message-ID: <871rm375xx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Jun 22, 2020 at 04:33:17PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> We have a number of container images in tests/docker/dockerfiles
>> that are intended to provide well defined environments for doing
>> test builds. We want our CI system to use these containers too.
>>=20
>> This introduces builds of all of them as the first stage in the
>> CI, so that the built containers are available for later build
>> jobs. The containers are setup to use the GitLab container
>> registry as the cache, so we only pay the penalty of the full
>> build when the dockerfiles change. The main qemu-project/qemu
>> repo is used as a second cache, so that users forking QEMU will
>> see a fast turnaround time on their CI jobs.
>>=20
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>  .gitlab-ci.d/containers.yml | 248 ++++++++++++++++++++++++++++++++++++
>>  .gitlab-ci.yml              |   3 +
>>  2 files changed, 251 insertions(+)
>>  create mode 100644 .gitlab-ci.d/containers.yml
>
> Thinking about this at 3am with insomnia, I started considering possible
> ways this could result in CI failures. I came up with
>
>  - Distro repos are unavialable due to transient network/mirror problems
>=20=20
>  - Distro pushes bad packages or changes something that invalidates QEMU
>    assumptions
>
> The first one can hit at any time, but I think that we're reasonably well
> insulated from it due to our usage of caching. Only a small number of CI
> jobs are going to actually trigger a full rebuild of an image, most will
> just hit the cache.
>
> The second one is probably not likely, *provided* we only use stable bran=
ches
> of distros. It looks like we're ok in that regard as we're not using Debi=
an
> Sid, or Fedora rawhide for any images currently.

We use debian11 (which I think is debian-testing) for one of the aarch64
compilers because we need fairlyu bleeding edge gcc's but we won't go
back to sid anytime soon.

>
> If we did want to reduce the risk though, we could mark some of the
> container jobs as non-fatal. We could mark the subset of images that are
> not actually required by later build jobs that we currently have.
>
>> diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
>> new file mode 100644
>> index 0000000000..ea1edbb196
>> --- /dev/null
>> +++ b/.gitlab-ci.d/containers.yml
>> @@ -0,0 +1,248 @@
>> +
>> +
>> +.container_job_template: &container_job_definition
>> +  image: docker:stable
>> +  stage: containers
>> +  services:
>> +    - docker:dind
>> +  before_script:
>> +    - export TAG=3D"$CI_REGISTRY_IMAGE/ci-$NAME:latest"
>> +    - export COMMON_TAG=3D"$CI_REGISTRY/qemu-project/qemu/ci-$NAME:late=
st"
>> +    - docker info
>> +    - docker login registry.gitlab.com -u "$CI_REGISTRY_USER" -p "$CI_R=
EGISTRY_PASSWORD"
>> +  script:
>> +    - docker pull "$TAG" || docker pull "$COMMON_TAG" || true
>> +    - sed -i -e "s,FROM qemu:,FROM $CI_REGISTRY_IMAGE/ci-," tests/docke=
r/dockerfiles/$NAME.docker
>> +    - docker build --cache-from "$TAG" --cache-from "$COMMON_TAG" --tag=
 "$TAG" -f "tests/docker/dockerfiles/$NAME.docker" tests/docker/dockerfiles
>> +    - docker push "$TAG"
>> +  after_script:
>> +    - docker logout
>> +
>> +amd64-centos7-container:
>> +  <<: *container_job_definition
>> +  variables:
>> +    NAME: centos7
>> +
>> +amd64-centos8-container:
>> +  <<: *container_job_definition
>> +  variables:
>> +    NAME: centos8
>> +
>> +amd64-debian10-container:
>> +  <<: *container_job_definition
>> +  variables:
>> +    NAME: debian10
>> +
>> +amd64-debian11-container:
>> +  <<: *container_job_definition
>> +  variables:
>> +    NAME: debian11
>> +
>> +amd64-debian9-container:
>> +  <<: *container_job_definition
>> +  variables:
>> +    NAME: debian9
>> +
>> +amd64-debian9-mxe-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian9-container']
>> +  variables:
>> +    NAME: debian9-mxe
>> +
>> +alpha-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-alpha-cross
>> +
>> +amd64-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-amd64-cross
>> +
>> +amd64-debian-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-amd64
>> +
>> +arm64-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-arm64-cross
>> +
>> +arm64-test-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian11-container']
>> +  variables:
>> +    NAME: debian-arm64-test-cross
>> +
>> +armel-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-armel-cross
>> +
>> +armhf-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-armhf-cross
>> +
>> +hppa-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-hppa-cross
>> +
>> +m68k-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-m68k-cross
>> +
>> +mips64-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-mips64-cross
>> +
>> +mips64el-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-mips64el-cross
>> +
>> +mips-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-mips-cross
>> +
>> +mipsel-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-mipsel-cross
>> +
>> +powerpc-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-powerpc-cross
>> +
>> +ppc64-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-ppc64-cross
>> +
>> +ppc64el-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-ppc64el-cross
>> +
>> +riscv64-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-riscv64-cross
>> +
>> +s390x-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-s390x-cross
>> +
>> +sh4-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-sh4-cross
>> +
>> +sparc64-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian10-container']
>> +  variables:
>> +    NAME: debian-sparc64-cross
>> +
>> +tricore-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer2
>> +  needs: ['amd64-debian9-container']
>> +  variables:
>> +    NAME: debian-tricore-cross
>> +
>> +win32-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer3
>> +  needs: ['amd64-debian9-mxe-container']
>> +  variables:
>> +    NAME: debian-win32-cross
>> +
>> +win64-debian-cross-container:
>> +  <<: *container_job_definition
>> +  stage: containers-layer3
>> +  needs: ['amd64-debian9-mxe-container']
>> +  variables:
>> +    NAME: debian-win64-cross
>> +
>> +xtensa-debian-cross-container:
>> +  <<: *container_job_definition
>> +  variables:
>> +    NAME: debian-xtensa-cross
>> +
>> +cris-fedora-cross-container:
>> +  <<: *container_job_definition
>> +  variables:
>> +    NAME: fedora-cris-cross
>> +
>> +amd64-fedora-container:
>> +  <<: *container_job_definition
>> +  variables:
>> +    NAME: fedora
>> +
>> +i386-fedora-cross-container:
>> +  <<: *container_job_definition
>> +  variables:
>> +    NAME: fedora-i386-cross
>> +
>> +amd64-ubuntu1804-container:
>> +  <<: *container_job_definition
>> +  variables:
>> +    NAME: ubuntu1804
>> +
>> +amd64-ubuntu2004-container:
>> +  <<: *container_job_definition
>> +  variables:
>> +    NAME: ubuntu2004
>> +
>> +amd64-ubuntu-container:
>> +  <<: *container_job_definition
>> +  variables:
>> +    NAME: ubuntu
>> +
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 9fdc752ea6..72d688875f 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -1,10 +1,13 @@
>>  stages:
>>    - containers
>> +  - containers-layer2
>> +  - containers-layer3
>>    - build
>>=20=20
>>  include:
>>    - local: '/.gitlab-ci.d/edk2.yml'
>>    - local: '/.gitlab-ci.d/opensbi.yml'
>> +  - local: '/.gitlab-ci.d/containers.yml'
>>=20=20
>>  .update_apt_template: &before_script_apt
>>   before_script:
>> --=20
>> 2.24.1
>>=20
>
> Regards,
> Daniel


--=20
Alex Benn=C3=A9e

