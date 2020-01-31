Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF5AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8505C206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpioF/SP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8505C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZHn-000088-M6
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixYaW-0000jJ-SO
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixYaU-0001O0-ED
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:52:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31646
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixYaU-0001NI-9e
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580485925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZcPdYLnsv/7dMZeN3eNALNEwtOjyVMkI4B7mSTlC0g=;
 b=OpioF/SPCpk/IrFaeiEECRulclIqN3oe0Q+VwnN2qm7a/Da4f0loqHn9GvkM/vi1lplOfY
 l8NA9Ii2GOdgM5TAD4fsoeHe54Plh4z2HBwGk69mvDNFfbxRFa1w5F8Jg3Rjxup7HJX++m
 +L1WOm0pfVn+PheJMs35L1R+vA8ZLzk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-O9w72xd4Osq55WQBEHDm7Q-1; Fri, 31 Jan 2020 10:51:57 -0500
Received: by mail-wm1-f69.google.com with SMTP id o193so2980315wme.8
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ky2LiZptdep06Zi2oZpZNw4UX/QTxEu/nizMBlJPj8Y=;
 b=qfFQNa1qyU7LV0QwndTSAdyZfzoriio3dDRQFX9tlJ4283H5akUvcgDgfs455cCVc+
 Btd2y42i+dZhQ21N4Ek4gQvmIoieeUlL3o/Ni80bdbXBW6G++LAegMIxxIfGDUFDW7CN
 ejBz1loT+UcTqgDitrShvievAzFQ90J6ATaHnfLEm84tdbn3PwdTuSwe25Y8Z7n/6Co0
 6/D57b7qbK9Y8YXL6P3IR73yHrjme3UNdJuqsTlBredwkCfKB6X/r2R/qqkiQ189Of5w
 iL+J47wg/HG54/YMBo0JHfkpphhXwtE/9Uw/3mD0tDA1xJHBXc0beSbQ/DOmxJvPVP9M
 KSww==
X-Gm-Message-State: APjAAAW4Us4OdX2IGxAb4ABEAdQWA++lg0oERZ5F0lEHG8rPqNAo0i5i
 DPZxVrzb9QM++ATXpfGAppEuUIij1uhTF2A2iN6s3iBGIIJlXWGSPZc17v0gqLQpfG7viPgMq3u
 BM/oZfU63CqUsZIw=
X-Received: by 2002:adf:f10a:: with SMTP id r10mr12954773wro.202.1580485915791; 
 Fri, 31 Jan 2020 07:51:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjpT0l7mUhDLOhon1BRsUjwVzj18H+Mik/rNROH08Vz7bRzOZacVxoWukMg7q//X/XMoCVnQ==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr12954742wro.202.1580485915519; 
 Fri, 31 Jan 2020 07:51:55 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id t9sm10649390wmj.28.2020.01.31.07.51.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 07:51:54 -0800 (PST)
Subject: Re: [PATCH v2 11/12] .travis.yml: probe for number of available
 processors
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200130113223.31046-1-alex.bennee@linaro.org>
 <20200130113223.31046-12-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ea3262e1-43b0-8382-a5b9-aff969e7145a@redhat.com>
Date: Fri, 31 Jan 2020 16:51:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200130113223.31046-12-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: O9w72xd4Osq55WQBEHDm7Q-1
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, Ed Vielmetti <ed@packet.com>,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(Cc'ing Ed Vielmetti)

On 1/30/20 12:32 PM, Alex Benn=C3=A9e wrote:
> The arm64 hardware was especially hit by only building on 3 of the 32
> available cores. Introduce a JOBS environment variable which we use
> for all parallel builds. We still run the main checks single threaded
> though so to make it easier to spot hangs.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 1b92f40eab..a600f508b0 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -85,6 +85,8 @@ git:
>   # Common first phase for all steps
>   before_install:
>     - if command -v ccache ; then ccache --zero-stats ; fi
> +  - export JOBS=3D$(($(getconf _NPROCESSORS_ONLN) + 1))

Yeah finally!

Note, on the Cavium ThunderX CN88XX provided by Packet, Ed Vielmetti=20
once suggested to use the --load-average make option due to Amdahl's=20
law, and I noticed a minor speedup using -j96 -l47.5 (-l48 already=20
starts to decrease).

On https://docs.travis-ci.com/user/reference/overview/#linux I read
"LXD compliant OS images for arm64 are run in Packet."

Per=20
https://travis-ci.community/t/what-machine-s-does-travis-use-for-arm64/5579=
/2=20
the CPU seems to be a Ampere eMAG Skylark:
https://en.wikichip.org/wiki/apm/microarchitectures/skylark
Probably the eMAG 8180:
https://en.wikichip.org/wiki/ampere_computing/emag/8180

I don't know what would be the best limit for this CPU.

Back to this patch, it indeed reduced the build time by 2+, so:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +  - echo "=3D=3D=3D Using ${JOBS} simultaneous jobs =3D=3D=3D"
>  =20
>   # Configure step - may be overridden
>   before_script:
> @@ -93,7 +95,7 @@ before_script:
>  =20
>   # Main build & test - rarely overridden - controlled by TEST_CMD
>   script:
> -  - BUILD_RC=3D0 && make -j3 || BUILD_RC=3D$?
> +  - BUILD_RC=3D0 && make -j${JOBS} || BUILD_RC=3D$?
>     - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(e=
xit $BUILD_RC); fi
>   after_script:
>     - if command -v ccache ; then ccache --show-stats ; fi
> @@ -125,7 +127,7 @@ matrix:
>         env:
>           - BASE_CONFIG=3D"--enable-tools"
>           - CONFIG=3D"--disable-user --disable-system"
> -        - TEST_CMD=3D"make check-unit check-softfloat -j3"
> +        - TEST_CMD=3D"make check-unit check-softfloat -j${JOBS}"
>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>  =20
>  =20
> @@ -160,13 +162,13 @@ matrix:
>       - name: "check-unit coroutine=3Ducontext"
>         env:
>           - CONFIG=3D"--with-coroutine=3Ducontext --disable-tcg"
> -        - TEST_CMD=3D"make check-unit -j3 V=3D1"
> +        - TEST_CMD=3D"make check-unit -j${JOBS} V=3D1"
>  =20
>  =20
>       - name: "check-unit coroutine=3Dsigaltstack"
>         env:
>           - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-tcg"
> -        - TEST_CMD=3D"make check-unit -j3 V=3D1"
> +        - TEST_CMD=3D"make check-unit -j${JOBS} V=3D1"
>  =20
>  =20
>       # Check we can build docs and tools (out of tree)
> @@ -366,7 +368,7 @@ matrix:
>       - name: "GCC check-tcg (user)"
>         env:
>           - CONFIG=3D"--disable-system --enable-debug-tcg"
> -        - TEST_CMD=3D"make -j3 check-tcg V=3D1"
> +        - TEST_CMD=3D"make -j${JOBS} check-tcg V=3D1"
>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>  =20
>  =20
> @@ -375,7 +377,7 @@ matrix:
>       - name: "GCC plugins check-tcg (user)"
>         env:
>           - CONFIG=3D"--disable-system --enable-plugins --enable-debug-tc=
g --target-list-exclude=3Dsparc64-linux-user"
> -        - TEST_CMD=3D"make -j3 check-tcg V=3D1"
> +        - TEST_CMD=3D"make -j${JOBS} check-tcg V=3D1"
>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>  =20
>  =20
> @@ -383,7 +385,7 @@ matrix:
>       - name: "GCC check-tcg (some-softmmu)"
>         env:
>           - CONFIG=3D"--enable-debug-tcg --target-list=3Dxtensa-softmmu,a=
rm-softmmu,aarch64-softmmu,alpha-softmmu"
> -        - TEST_CMD=3D"make -j3 check-tcg V=3D1"
> +        - TEST_CMD=3D"make -j${JOBS} check-tcg V=3D1"
>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>  =20
>  =20
> @@ -391,7 +393,7 @@ matrix:
>       - name: "GCC plugins check-tcg (some-softmmu)"
>         env:
>           - CONFIG=3D"--enable-plugins --enable-debug-tcg --target-list=
=3Dxtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
> -        - TEST_CMD=3D"make -j3 check-tcg V=3D1"
> +        - TEST_CMD=3D"make -j${JOBS} check-tcg V=3D1"
>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>  =20
>       - name: "[aarch64] GCC check-tcg"
> @@ -500,7 +502,7 @@ matrix:
>           - BUILD_DIR=3D"release/build/dir" SRC_DIR=3D"../../.."
>           - BASE_CONFIG=3D"--prefix=3D$PWD/dist"
>           - CONFIG=3D"--target-list=3Dx86_64-softmmu,aarch64-softmmu,arme=
b-linux-user,ppc-linux-user"
> -        - TEST_CMD=3D"make install -j3"
> +        - TEST_CMD=3D"make install -j${JOBS}"
>           - QEMU_VERSION=3D"${TRAVIS_TAG:1}"
>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>         script:
>=20


