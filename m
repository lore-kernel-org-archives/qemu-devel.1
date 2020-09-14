Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D30C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7EF20665
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2X/0BJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7EF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqQD-00038T-FB
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHqCm-0000ld-Mg
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:15:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHqCj-0001h8-Ta
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600096540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9cOs/Ln5TrJ7e7aY3+ovNH46/NufuheH8vhYeGvyw3Y=;
 b=N2X/0BJwVOFGD+9Imwd0xHdHoILbdwFo3/CCBJr+vhFz2iLqRzw5G7Wdh1cGFjF8SuISM8
 RwfgVZBvewbQMEBkTTNeKBJyNSNcnDJjh/ICcCf6zB/PZdHKnnyfZN4KNy1YpUPWzscORU
 6mCIUXVexnUXYVhs6CQP3utJ3iECDPw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-YHJo7BvdOWavpY1cfrNjdw-1; Mon, 14 Sep 2020 11:15:39 -0400
X-MC-Unique: YHJo7BvdOWavpY1cfrNjdw-1
Received: by mail-wm1-f71.google.com with SMTP id d22so116546wmd.6
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 08:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=9cOs/Ln5TrJ7e7aY3+ovNH46/NufuheH8vhYeGvyw3Y=;
 b=MRktfbV/DsUZ8X7sf5T+/o3CBsKNHf4/xOq5VS9E1ctve3yTPn2D4D+u/YvWUvQB65
 aFV3HUVGFLQi95YLM9cT0BcqgERU8wTuagEvMZUu7SUjpORFtXFf+AKvKzo42Se4PQ4d
 eKCbWp3wMrCiRJ+WpfoxTHTT7xasLFnSF468zkUfQjfH+TSwcfMtIYHMZCaKPBPHul1K
 KFPpXqeG5W/dJNz9X/xHhpquY0Y2a2VYL58aSRXLzcA83wPUzCUSpvAoT4K4ufTjASmm
 u6laszXEhigC/kVj07+T8R+Fj3c9MzQ0ZuzfTr1Gs7jGX/h3vL2xkYMOiAioOSorD1li
 T47Q==
X-Gm-Message-State: AOAM533nS6lI9F/CEFWoC1q9wHV//Eups7nuNtMlR5T5TzrIT8LQrXRt
 AjGqURxobV5BVpaqv/8y+Vx/PIB7dV74D9AjRxolHkDzkcpD39SeifOYozba/NDkiPLPv7Zw8sz
 CT5D5onZQ72V3db4=
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr15218153wmi.173.1600096537405; 
 Mon, 14 Sep 2020 08:15:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqUjPvu4gS3dGSUf5HvUA02Y86XHv4lH4cgBwlW/zxQcuPmp9Ddov/QniM3ifeyMQY/2DDEg==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr15218135wmi.173.1600096537142; 
 Mon, 14 Sep 2020 08:15:37 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id y207sm21007686wmc.17.2020.09.14.08.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 08:15:36 -0700 (PDT)
Subject: Re: [PATCH v1 5/6] gitlab: create a build-deprecated target
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200914150716.10501-1-alex.bennee@linaro.org>
 <20200914150716.10501-6-alex.bennee@linaro.org>
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
Message-ID: <0f0b62c6-6c3c-822e-7e74-fab3b84df9bf@redhat.com>
Date: Mon, 14 Sep 2020 17:15:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914150716.10501-6-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 5:07 PM, Alex Bennée wrote:
> These targets might be deprecated but we should keep them building
> before the final axe comes down. Lets keep them all in one place and
> don't hold up the CI if they do fail. They are either poorly tested or
> already flaky anyway,
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .gitlab-ci.yml | 10 ++++++++++
>  .travis.yml    |  3 +--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 72e8604579ee..f027b55aef15 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -254,6 +254,16 @@ build-clang:
>        ppc-softmmu s390x-softmmu arm-linux-user
>      MAKE_CHECK_ARGS: check
>  
> +# These targets are on the way out
> +build-deprecated:
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: debian-all-test-cross
> +    CONFIGURE_ARGS: --disable-docs --disable-tools --disable-system
> +    MAKE_CHECK_ARGS: check-tcg
> +    TARGETS: ppc64abi32-linux-user tilegx-linux-user
> +  allow_failure: true
> +
>  build-oss-fuzz:
>    <<: *native_build_job_definition
>    variables:
> diff --git a/.travis.yml b/.travis.yml
> index 65341634d02a..c75221dca3e7 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -344,10 +344,9 @@ jobs:
>      # Run check-tcg against linux-user (with plugins)
>      # we skip sparc64-linux-user until it has been fixed somewhat
>      # we skip cris-linux-user as it doesn't use the common run loop
> -    # we skip ppc64abi32-linux-user as it seems to have a broken libc
>      - name: "GCC plugins check-tcg (user)"
>        env:
> -        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user,ppc64abi32-linux-user"

Maybe split the patch in 2, first the Travis-CI removal,
mentioning commit c609274b853 ("docs/system/deprecated: mark
ppc64abi32-linux-user for deprecation"), then adding the
build-deprecated to GitLab-CI in a different patch.

Preferably split:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user"
>          - TEST_BUILD_CMD="make build-tcg"
>          - TEST_CMD="make check-tcg"
>          - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
> 


