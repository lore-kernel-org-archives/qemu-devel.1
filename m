Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA056C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A399223888
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FU79h1PI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A399223888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqsT-0001Yq-Um
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpqrf-000175-NW
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:18:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51336
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpqrb-00078S-0V
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593425889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6etd2juU9QFi4memaLqULtuNZtkqePm65OnJFZhxcGE=;
 b=FU79h1PI0lXsktyCp7kdrVuK+eAQkG7ung0v1joty8ZkrMy6heZtsjWzLgZJJ0IOqRhw3k
 GjFybUbO+cqe46uPuJvXFf17Fc0Ak50kUbc4YUuvyhG16yPgStuKMaAJAmuiZiDBJcKp7i
 Ru7mS1GaIYu5D1wfLvneRwiMAYjCJMs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-d16DSU5tMrKzRQMQrH6Tag-1; Mon, 29 Jun 2020 06:18:06 -0400
X-MC-Unique: d16DSU5tMrKzRQMQrH6Tag-1
Received: by mail-wr1-f69.google.com with SMTP id b8so2307518wro.19
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 03:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=6etd2juU9QFi4memaLqULtuNZtkqePm65OnJFZhxcGE=;
 b=YEdrsr2/lKfPjFUJZdS5nCM+b5nfMC68ZAn3cfKK7+puERSO6i0yDjCdlA5FmamD9W
 IAEW3RxuaEGCm4IjyXP0V+xiAOFJtHftRvWgT6C7R9qz1C5AmE07RP1cX3Fac7Xj3GVu
 2OBzAoJWwCWJbzNqKHhpQjhgZL37D1U1cBCQ61Irqpkp1HjFwVkfx1xzb+Y5gHQOrUNB
 o7rEFNaA/i/emoRGEmBPzIptEECFZJbOBCeELuftidENtuE7/A4VPlZYlHghagS7ZZaP
 miHft8kd8i2vj8NCZyBNkcoeLVfvKGng+hiy7f1o6/tny2Rp8fXp8hpZxqc3/NQBsOpa
 hTiQ==
X-Gm-Message-State: AOAM531YVtRxRpKKFRKoKuw4OavYwUR3CK/T7y0y/UKC5D80/QOFC6+I
 BMN70V8iaEnkDChMkuZJnwfXVlBUrkfIrMLyl1/MM3H5ewmI2Bb0scliWjKDJWTSyWJ1zcbfjwB
 9j0EpHJVn5GcOpDc=
X-Received: by 2002:a1c:bdc3:: with SMTP id n186mr871044wmf.84.1593425885401; 
 Mon, 29 Jun 2020 03:18:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpD4gnyvpA+hzfSgZXzG2tpgTQ81kKbfWilgpVhoJpx88E0rC1f2hLfpjlNQy6j+NSGojfCw==
X-Received: by 2002:a1c:bdc3:: with SMTP id n186mr871019wmf.84.1593425885161; 
 Mon, 29 Jun 2020 03:18:05 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id j16sm8931336wrt.7.2020.06.29.03.18.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 03:18:04 -0700 (PDT)
Subject: Re: [PATCH v3 25/30] tests/docker: add a linux-user testing focused
 image
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200626181357.26211-1-alex.bennee@linaro.org>
 <20200626181357.26211-26-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <523f882a-2b1f-2d7c-d13e-b5d6b4f07aa2@redhat.com>
Date: Mon, 29 Jun 2020 12:18:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200626181357.26211-26-alex.bennee@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 8:13 PM, Alex Bennée wrote:
> We happily use all the cross images for both cross-building QEMU as
> well as building the linux-user tests. However calling docker from
> within docker seems not to work. As we can build in Debian anyway why
> not include an image that has all the compilers available for
> non-docker invocation.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  .gitlab-ci.d/containers.yml                   |  7 +++
>  tests/docker/Makefile.include                 |  1 +
>  .../dockerfiles/debian-all-test-cross.docker  | 53 +++++++++++++++++++
>  3 files changed, 61 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-all-test-cross.docker
> 
> diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
> index ba9c24e98f1..20b2fb1de5d 100644
> --- a/.gitlab-ci.d/containers.yml
> +++ b/.gitlab-ci.d/containers.yml
> @@ -66,6 +66,13 @@ amd64-debian-cross-container:
>    variables:
>      NAME: debian-amd64-cross
>  
> +amd64-debian-user-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-all-test-cross
> +
>  amd64-debian-container:
>    <<: *container_job_definition
>    stage: containers-layer2
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 8139e8467d4..079ceb6ff33 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -133,6 +133,7 @@ docker-image-travis: NOUSER=1
>  
>  # Specialist build images, sometimes very limited tools
>  docker-image-debian-tricore-cross: docker-image-debian9
> +docker-image-debian-all-test-cross: docker-image-debian10
>  docker-image-debian-arm64-test-cross: docker-image-debian11
>  
>  # These images may be good enough for building tests but not for test builds
> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
> new file mode 100644
> index 00000000000..dedcea58b46
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> @@ -0,0 +1,53 @@
> +#
> +# Docker all cross-compiler target (tests only)
> +#
> +# While the normal cross builds take care to setup proper multiarch
> +# build environments which can cross build QEMU this just installs the
> +# basic compilers for as many targets as possible. We shall use this
> +# to build and run linux-user tests on GitLab
> +#
> +FROM qemu/debian10
> +
> +# What we need to build QEMU itself
> +RUN apt update && \
> +    DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt build-dep -yy qemu
> +
> +# Add the foreign architecture we want and install dependencies
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +        apt install -y --no-install-recommends \
> +        gcc-aarch64-linux-gnu \
> +        libc6-dev-arm64-cross \
> +        gcc-alpha-linux-gnu \
> +        libc6.1-dev-alpha-cross \
> +        gcc-arm-linux-gnueabihf \
> +        libc6-dev-armhf-cross \
> +        gcc-hppa-linux-gnu \
> +        libc6-dev-hppa-cross \
> +        gcc-m68k-linux-gnu \
> +        libc6-dev-m68k-cross \
> +        gcc-mips-linux-gnu \
> +        libc6-dev-mips-cross \
> +        gcc-mips64-linux-gnuabi64 \
> +        libc6-dev-mips64-cross \
> +        gcc-mips64el-linux-gnuabi64 \
> +        libc6-dev-mips64el-cross \
> +        gcc-mipsel-linux-gnu \
> +        libc6-dev-mipsel-cross \
> +        gcc-powerpc-linux-gnu \
> +        libc6-dev-powerpc-cross \
> +        gcc-powerpc64-linux-gnu \
> +        libc6-dev-ppc64-cross \
> +        gcc-powerpc64le-linux-gnu \
> +        libc6-dev-ppc64el-cross \
> +        gcc-riscv64-linux-gnu \
> +        libc6-dev-riscv64-cross \
> +        gcc-s390x-linux-gnu \
> +        libc6-dev-s390x-cross \
> +        gcc-sh4-linux-gnu \
> +        libc6-dev-sh4-cross \
> +        gcc-sparc64-linux-gnu \
> +        libc6-dev-sparc64-cross
> +
> +ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
> +ENV DEF_TARGET_LIST aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
> 


