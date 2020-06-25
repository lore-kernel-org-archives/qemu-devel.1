Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0AEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB09D20702
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sy5cisYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB09D20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOgC-0003rH-87
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joOfW-0003Pk-HO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:59:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49256
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joOfT-0000aK-Pn
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593079178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xe9Ym1ca4+eATGvCL3tFcNKuap5fUrBQhtfdgIJcImk=;
 b=Sy5cisYmEP+d4QQZRxrrxRJj5n1Y0MlcqpoSf4Ymn0LYQBymCG5uPajrf+uIvnTTBaX73a
 OKVok+ojKG0j2DTxh/DNx9/V0TTa+qluIiASSw3nlQiFmRDufS4CfrNVVyHP7MZlbp2AUr
 +fWEb+Eb7Oav6a2hDcdZlwlg70wgl6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-b30kJZxdOCS-Xfh4vcU42w-1; Thu, 25 Jun 2020 05:59:36 -0400
X-MC-Unique: b30kJZxdOCS-Xfh4vcU42w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C03EE1800D4A;
 Thu, 25 Jun 2020 09:59:35 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 578415C578;
 Thu, 25 Jun 2020 09:59:31 +0000 (UTC)
Subject: Re: [PATCH RFC 3/3] gitlab: convert jobs to use custom built
 containers
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-4-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6a9df5e9-1f8c-eb1f-06c4-19c337e8cc5f@redhat.com>
Date: Thu, 25 Jun 2020 11:59:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200622153318.751107-4-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Laszlo Ersek <lersek@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/06/2020 17.33, Daniel P. Berrangé wrote:
> Now that we're building standard container images from
> dockerfiles in tests/docker/dockerfiles, we can convert
> the build jobs to use them. The key benefit of this is
> that a contributor can now more easily replicate the CI
> environment on their local machine. The container images
> are cached too, so we are not spending time waiting for
> the apt-get/dnf package installs to complete.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.yml | 187 +++++++++++++++++++++----------------------------
>   1 file changed, 81 insertions(+), 106 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 72d688875f..3297a402f7 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -9,133 +9,108 @@ include:
>     - local: '/.gitlab-ci.d/opensbi.yml'
>     - local: '/.gitlab-ci.d/containers.yml'
>   
> -.update_apt_template: &before_script_apt
> - before_script:
> -  - apt-get update -qq
> -  - apt-get install -y -qq git gcc libglib2.0-dev libpixman-1-dev make
> -        genisoimage
> -  - JOBS=$(expr $(nproc) + 1)
> -
> -.update_dnf_template: &before_script_dnf
> - before_script:
> -  - dnf update -y
> -  - dnf install -y bzip2 diffutils gcc git genisoimage findutils glib2-devel
> -        make python3 perl-podlators perl-Test-Harness pixman-devel zlib-devel
> -  - JOBS=$(expr $(nproc) + 1)
> +.native_build_job_template: &native_build_job_definition
> +  stage: build
> +  image: $CI_REGISTRY_IMAGE/ci-$IMAGE:latest
> +  before_script:
> +    - JOBS=$(expr $(nproc) + 1)
> +  script:
> +    - mkdir build
> +    - cd build
> +    - if test -n "$TARGETS";
> +      then
> +        ../configure --enable-werror $CONFIGURE_ARGS --target-list="$TARGETS" ;
> +      else
> +        ../configure --enable-werror $CONFIGURE_ARGS ;
> +      fi
> +    - make -j"$JOBS"
> +    - make -j"$JOBS" $MAKE_CHECK_ARGS
>   
>   build-system1:
> - stage: build
> - image: ubuntu:19.10
> - <<: *before_script_apt
> - script:
> - - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
> -      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev libvdeplug-dev
> - - mkdir build
> - - cd build
> - - ../configure --enable-werror --target-list="aarch64-softmmu alpha-softmmu
> -      cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazeel-softmmu
> -      mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc-softmmu"
> - - make -j"$JOBS"
> - - make -j"$JOBS" check
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: ubuntu2004
> +    TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu lm32-softmmu
> +      moxie-softmmu microblazeel-softmmu mips64el-softmmu m68k-softmmu ppc-softmmu
> +      riscv64-softmmu sparc-softmmu
> +    MAKE_CHECK_ARGS: check
>   
>   build-system2:
> - stage: build
> - image: fedora:latest
> - <<: *before_script_dnf
> - script:
> - - yum install -y SDL2-devel libgcrypt-devel brlapi-devel libaio-devel
> -       libfdt-devel lzo-devel librdmacm-devel libibverbs-devel libibumad-devel
> -       libzstd-devel
> - - mkdir build
> - - cd build
> - - ../configure --enable-werror --target-list="tricore-softmmu unicore32-softmmu
> -      microblaze-softmmu mips-softmmu riscv32-softmmu s390x-softmmu sh4-softmmu
> -      sparc64-softmmu x86_64-softmmu xtensa-softmmu nios2-softmmu or1k-softmmu"
> - - make -j"$JOBS"
> - - make -j"$JOBS" check
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: fedora
> +    TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips-softmmu
> +      riscv32-softmmu s390x-softmmu sh4-softmmu sparc64-softmmu x86_64-softmmu
> +      xtensa-softmmu nios2-softmmu or1k-softmmu
> +    MAKE_CHECK_ARGS: check
>   
>   build-disabled:
> - stage: build
> - image: fedora:latest
> - <<: *before_script_dnf
> - script:
> - - mkdir build
> - - cd build
> - - ../configure --enable-werror --disable-rdma --disable-slirp --disable-curl
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: fedora
> +    CONFIGURE_ARGS: --disable-rdma --disable-slirp --disable-curl
>         --disable-capstone --disable-live-block-migration --disable-glusterfs
>         --disable-replication --disable-coroutine-pool --disable-smartcard
>         --disable-guest-agent --disable-curses --disable-libxml2 --disable-tpm
>         --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
>         --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
> -      --target-list="i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user"
> - - make -j"$JOBS"
> - - make -j"$JOBS" check-qtest SPEED=slow
> +    TARGETS: i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user
> +    MAKE_CHECK_ARGS: check-qtest SPEED=slow
>   
>   build-tcg-disabled:
> - stage: build
> - image: centos:8
> - <<: *before_script_dnf
> - script:
> - - dnf install -y clang gtk3-devel libusbx-devel libgcrypt-devel
> - - mkdir build
> - - cd build
> - - ../configure --cc=clang --enable-werror --disable-tcg --audio-drv-list=""
> - - make -j"$JOBS"
> - - make check-unit
> - - make check-qapi-schema
> - - cd tests/qemu-iotests/
> - - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: centos8
> +  script:
> +    - mkdir build
> +    - cd build
> +    - ../configure --disable-tcg --audio-drv-list=""
> +    - make -j"$JOBS"
> +    - make check-unit
> +    - make check-qapi-schema
> +    - cd tests/qemu-iotests/
> +    - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
>               052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
>               170 171 183 184 192 194 197 208 215 221 222 226 227 236 253 277
> - - ./check -qcow2 028 051 056 057 058 065 067 068 082 085 091 095 096 102 122
> +    - ./check -qcow2 028 051 056 057 058 065 067 068 082 085 091 095 096 102 122
>               124 132 139 142 144 145 151 152 155 157 165 194 196 197 200 202
>               208 209 215 216 218 222 227 234 246 247 248 250 254 255 257 258
>               260 261 262 263 264 270 272 273 277 279
>   
>   build-user:
> - stage: build
> - <<: *before_script_apt
> - script:
> - - mkdir build
> - - cd build
> - - ../configure --enable-werror --disable-system --disable-guest-agent
> -               --disable-capstone --disable-slirp --disable-fdt
> - - make -j"$JOBS"
> - - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: ubuntu2004
> +    CONFIGURE_ARGS: --disable-system --disable-guest-agent
> +      --disable-capstone --disable-slirp --disable-fdt
> +    MAKE_CHECK_ARGS:  run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
>   
>   build-clang:
> - stage: build
> - image: fedora:latest
> - <<: *before_script_dnf
> - script:
> - - yum install -y clang SDL2-devel libattr-devel libcap-ng-devel xfsprogs-devel
> -       libiscsi-devel libnfs-devel libseccomp-devel gnutls-devel librbd-devel
> - - mkdir build
> - - cd build
> - - ../configure --cc=clang --cxx=clang++ --enable-werror
> -      --target-list="alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu
> -                     ppc-softmmu s390x-softmmu x86_64-softmmu arm-linux-user"
> - - make -j"$JOBS"
> - - make -j"$JOBS" check
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: fedora
> +    CONFIGURE_ARGS: --cc=clang --cxx=clang++
> +    TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu
> +      ppc-softmmu s390x-softmmu x86_64-softmmu arm-linux-user
> +    MAKE_CHECK_ARGS: check
>   
>   build-tci:
> - stage: build
> - image: centos:8
> - <<: *before_script_dnf
> - script:
> - - TARGETS="aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x86_64"
> - - mkdir build
> - - cd build
> - - ../configure --enable-tcg-interpreter
> -      --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)"
> - - make -j"$JOBS"
> - - make run-tcg-tests-x86_64-softmmu
> - - make tests/qtest/boot-serial-test tests/qtest/cdrom-test tests/qtest/pxe-test
> - - for tg in $TARGETS ; do
> -     export QTEST_QEMU_BINARY="${tg}-softmmu/qemu-system-${tg}" ;
> -     ./tests/qtest/boot-serial-test || exit 1 ;
> -     ./tests/qtest/cdrom-test || exit 1 ;
> -   done
> - - QTEST_QEMU_BINARY="x86_64-softmmu/qemu-system-x86_64" ./tests/qtest/pxe-test
> - - QTEST_QEMU_BINARY="s390x-softmmu/qemu-system-s390x"
> -   ./tests/qtest/pxe-test -m slow
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: fedora
> +  script:
> +    - TARGETS="aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x86_64"
> +    - mkdir build
> +    - cd build
> +    - ../configure --enable-tcg-interpreter
> +        --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)"
> +    - make -j"$JOBS"
> +    - make run-tcg-tests-x86_64-softmmu
> +    - make tests/qtest/boot-serial-test tests/qtest/cdrom-test tests/qtest/pxe-test
> +    - for tg in $TARGETS ; do
> +        export QTEST_QEMU_BINARY="${tg}-softmmu/qemu-system-${tg}" ;
> +        ./tests/qtest/boot-serial-test || exit 1 ;
> +        ./tests/qtest/cdrom-test || exit 1 ;
> +      done
> +    - QTEST_QEMU_BINARY="x86_64-softmmu/qemu-system-x86_64" ./tests/qtest/pxe-test
> +    - QTEST_QEMU_BINARY="s390x-softmmu/qemu-system-s390x" ./tests/qtest/pxe-test -m slow
> 

Looks pretty cool, thanks for doing this!

Acked-by: Thomas Huth <thuth@redhat.com>


