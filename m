Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42F6C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD5B2078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YI4AU6p7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD5B2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7xJ-00075F-MW
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kD7vZ-0005Fb-Ln
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:10:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45843
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kD7vX-0004ny-Gr
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598973026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/nPcvBp1sTrFhUeBQJsXuAek+7Hcxh1gFmbtI9gpHIs=;
 b=YI4AU6p7YjEQfIJgEY9Yeg8AJC2akri8wE0uIO5hgHcBIUTf9kavtzh0Eko3i89gcrVJcx
 F7iRiXahS8vfcnHSgQ1+sWvbkVwA/lapN0kZHM204+OVwhNsV/eAakvOMK7XwwmCIU0nBW
 3Vu0XP2BIvfcihg/egn0s/IDMeoxEu0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-rlRU7nVwNdCwDaE8cPNtcA-1; Tue, 01 Sep 2020 11:10:23 -0400
X-MC-Unique: rlRU7nVwNdCwDaE8cPNtcA-1
Received: by mail-wr1-f72.google.com with SMTP id g3so708555wrx.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/nPcvBp1sTrFhUeBQJsXuAek+7Hcxh1gFmbtI9gpHIs=;
 b=gz9yahVjNKbifdTp6SJw18nSE8n7MIzZ/Ou4AJnD1Zt+sGLgJS+bWtVg0Kz/VRvOlF
 6N/h6e2JuLu9ELbnlKb+DFvkfwblW6zumba+Q02lfEm9PDOQWFe3jdMnYAlG29DjzM9C
 yTexCWJrmKDuJdKZi9+cw8GMMl9In5vuuB99/4DjEUHrt0rV4h1RWRgLKYFLcA2xBZj6
 MnICQsaHW+3w6uM1S2BBhQNWGFTsebfT/tl0/Gm+iEgJ113Koz00s8QcwGUjY9o/AAcW
 GdnpPA8eaEFSzSfDAjZseyjqoW92yif2cWTzAVJ6nN9eKSaqjGQZntzDIZCeyJQHim99
 /UJQ==
X-Gm-Message-State: AOAM533Ly2HPYzvhdjdbhlBeotPcqkuL9y8Rh4rwiuXbvxIEQhrfs6Jg
 ZNZCl9nuTbfzcv8YIu81X/dfsPPotkWr3aD8RC/O1s09pg9hsZ8L6fHQziuCpxEmIpdUEdJXaaI
 nbvKZu/Hg0qEjTJo=
X-Received: by 2002:a1c:c913:: with SMTP id f19mr2157667wmb.173.1598973021987; 
 Tue, 01 Sep 2020 08:10:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHvN0nOjTKmNCry4+yDCksvrZ69DXtsuD3ZYykxGT9EzPPpshSVBUJT3kP9tiVeY+E47kYgg==
X-Received: by 2002:a1c:c913:: with SMTP id f19mr2157647wmb.173.1598973021729; 
 Tue, 01 Sep 2020 08:10:21 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id c145sm2099263wmd.7.2020.09.01.08.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 08:10:21 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] gitlab: expand test coverage for crypto builds
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200901133050.381844-1-berrange@redhat.com>
 <20200901133050.381844-3-berrange@redhat.com>
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
Message-ID: <577ced18-4a9a-3532-e797-0fe0708340bc@redhat.com>
Date: Tue, 1 Sep 2020 17:10:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901133050.381844-3-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:16:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 3:30 PM, Daniel P. Berrangé wrote:
> Most jobs test the latest nettle library. This adds explicit coverage
> for latest gcrypt using Fedora, and old gcrypt and nettle using
> CentOS-7. The latter does a minimal tools-only build, as we only need to
> validate that the crypto code builds and unit tests pass. Finally a job
> disabling both nettle and gcrypt is provided to validate that gnutls
> still works.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.yml                          | 69 +++++++++++++++++++++++++
>  tests/docker/dockerfiles/centos7.docker |  2 +
>  tests/docker/dockerfiles/centos8.docker |  1 +
>  3 files changed, 72 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index b7967b9a13..a74b16ff04 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -130,6 +130,7 @@ build-system-fedora:
>    <<: *native_build_job_definition
>    variables:
>      IMAGE: fedora
> +    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle
>      TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips-softmmu
>        xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
>      MAKE_CHECK_ARGS: check-build
> @@ -160,6 +161,7 @@ build-system-centos:
>    <<: *native_build_job_definition
>    variables:
>      IMAGE: centos8
> +    CONFIGURE_ARGS: --disable-nettle --enable-gcrypt
>      TARGETS: ppc64-softmmu lm32-softmmu or1k-softmmu s390x-softmmu
>        x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
>      MAKE_CHECK_ARGS: check-build
> @@ -196,6 +198,7 @@ build-disabled:
>        --disable-guest-agent --disable-curses --disable-libxml2 --disable-tpm
>        --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
>        --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
> +      --disable-nettle --disable-gcrypt --disable-gnutls
>      TARGETS: i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user
>      MAKE_CHECK_ARGS: check-qtest SPEED=slow
>  
> @@ -271,3 +274,69 @@ build-tci:
>        done
>      - QTEST_QEMU_BINARY="./qemu-system-x86_64" ./tests/qtest/pxe-test
>      - QTEST_QEMU_BINARY="./qemu-system-s390x" ./tests/qtest/pxe-test -m slow
> +
> +# Most jobs test latest gcrypt or nettle builds
> +#
> +# These jobs test old gcrypt and nettle from RHEL7
> +# which had some API differences.
> +build-crypto-old-nettle:
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: centos7
> +    TARGETS: x86_64-softmmu x86_64-linux-user
> +    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle
> +    MAKE_CHECK_ARGS: check-build
> +  artifacts:
> +    paths:
> +      - build
> +
> +check-crypto-old-nettle:
> +  <<: *native_test_job_definition
> +  needs:
> +    - job: build-crypto-old-nettle
> +      artifacts: true
> +  variables:
> +    IMAGE: centos7
> +    MAKE_CHECK_ARGS: check
> +
> +

I'd copy the same comment for each library... In case
we add more jobs in the middle.

> +build-crypto-old-gcrypt:
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: centos7
> +    TARGETS: x86_64-softmmu x86_64-linux-user
> +    CONFIGURE_ARGS: --disable-nettle --enable-gcrypt
> +    MAKE_CHECK_ARGS: check-build
> +  artifacts:
> +    paths:
> +      - build
> +
> +check-crypto-old-gcrypt:
> +  <<: *native_test_job_definition
> +  needs:
> +    - job: build-crypto-old-gcrypt
> +      artifacts: true
> +  variables:
> +    IMAGE: centos7
> +    MAKE_CHECK_ARGS: check
> +
> +
> +build-crypto-only-gnutls:

Aren't these 'old' jobs too (centos 7, not 8)?

> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: centos7
> +    TARGETS: x86_64-softmmu x86_64-linux-user
> +    CONFIGURE_ARGS: --disable-nettle --disable-gcrypt --enable-gnutls
> +    MAKE_CHECK_ARGS: check-build
> +  artifacts:
> +    paths:
> +      - build
> +
> +check-crypto-only-gnutls:
> +  <<: *native_test_job_definition
> +  needs:
> +    - job: build-crypto-only-gnutls
> +      artifacts: true
> +  variables:
> +    IMAGE: centos7
> +    MAKE_CHECK_ARGS: check
> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
> index e197acdc3c..46277773bf 100644
> --- a/tests/docker/dockerfiles/centos7.docker
> +++ b/tests/docker/dockerfiles/centos7.docker
> @@ -15,9 +15,11 @@ ENV PACKAGES \
>      gettext \
>      git \
>      glib2-devel \
> +    gnutls-devel \
>      libaio-devel \
>      libepoxy-devel \
>      libfdt-devel \
> +    libgcrypt-devel \
>      librdmacm-devel \
>      libzstd-devel \
>      lzo-devel \

We should try to keep the same set of packages installed (if possible)
in the older distrib supported and in the more recent one. Not sure
what the best way to do that though.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
> index 9852c5b9ee..f435616d6a 100644
> --- a/tests/docker/dockerfiles/centos8.docker
> +++ b/tests/docker/dockerfiles/centos8.docker
> @@ -13,6 +13,7 @@ ENV PACKAGES \
>      glib2-devel \
>      libaio-devel \
>      libepoxy-devel \
> +    libgcrypt-devel \
>      lzo-devel \
>      make \
>      mesa-libEGL-devel \
> 


