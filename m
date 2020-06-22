Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CCBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908C62074D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuQM/CRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908C62074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOXY-0005Jn-FJ
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnOWe-0004Dj-6L
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:38:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35797
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnOWc-00039l-0C
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592840300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8TfGH39r2J5+h23GnUQzBf9Rp7hclrOqUkeOqVfhTqI=;
 b=EuQM/CRvu3g96oVBsiAurghxAcbz8qKtdrbibFO0dZI0qoAWQNwPgTBI4CIa1PynwGRxvv
 lqCGaYCevbVYA5+ffH68k4zfUSND/AYuiB5DDTmGPs5W+FLNpZW7EoOUuw23+GNTG4aTNt
 M/+/htv+qINqO3RCsH4VRFaW9uBQYo4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-HFfvCleBN1a9NXc-ljxtRw-1; Mon, 22 Jun 2020 11:38:19 -0400
X-MC-Unique: HFfvCleBN1a9NXc-ljxtRw-1
Received: by mail-wr1-f70.google.com with SMTP id g14so4246436wrp.8
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 08:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=8TfGH39r2J5+h23GnUQzBf9Rp7hclrOqUkeOqVfhTqI=;
 b=ZdPSrTBixcV4l5b4aMV2VsigrqJ9VU7h1ZaPzjt9O8Cbcrat2YC0sBFSLSq5usJt9a
 sAvw/8hwvSds9W8vJi/pYJEUAjZJwoBIvSGVy25Z/9WKs5K5rJewBYQv0M67n+KJNIBg
 ct/8k8IZICpy6gcCkk97FXX1ssH6BSrLP8Cte+rtHHbEB8Pj8uCfuNQYhoBnx75HWdCn
 XGz93+Bt2iUEr7Mu+OsHpAyqHegTQnAZshdisntUhITmdDeBpAVdH5MJWHBkVcMD3vAk
 5dKlg5boBQv2CWR98zMWwp/CsaU0Yyqjq8KZiexIm2UBsyBlKjR9bEFElsdDChqCvYUk
 Y5Jw==
X-Gm-Message-State: AOAM5331fppuq+g2AqI3L72xr9U5LclCKAqyZtkIhWbiYtyOx2x2WSUs
 3Rys7SM/lO8wHNKy0JIFJxUP65TRtnAdJtdEHimjMuOfzvKvcfk1s/VgVuPpkXKLj8I9YM1y9vJ
 k01yKGWDJTdKaEBk=
X-Received: by 2002:a5d:554d:: with SMTP id g13mr18506225wrw.98.1592840298142; 
 Mon, 22 Jun 2020 08:38:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNV2sBE6I4BSB3/Pbsgp9AD4QaEEvYW24QLVHKUhc551KGSO1GK5A/YnsweljUiFf940dPWA==
X-Received: by 2002:a5d:554d:: with SMTP id g13mr18506200wrw.98.1592840297884; 
 Mon, 22 Jun 2020 08:38:17 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id i15sm18242322wre.93.2020.06.22.08.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 08:38:17 -0700 (PDT)
Subject: Re: [PATCH RFC 2/3] gitlab: build all container images during CI
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-3-berrange@redhat.com>
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
Message-ID: <e6c27611-2873-2567-e3c8-f10b78831bc9@redhat.com>
Date: Mon, 22 Jun 2020 17:38:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200622153318.751107-3-berrange@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
 Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 5:33 PM, Daniel P. Berrangé wrote:
> We have a number of container images in tests/docker/dockerfiles
> that are intended to provide well defined environments for doing
> test builds. We want our CI system to use these containers too.
> 
> This introduces builds of all of them as the first stage in the
> CI, so that the built containers are available for later build
> jobs. The containers are setup to use the GitLab container
> registry as the cache, so we only pay the penalty of the full
> build when the dockerfiles change. The main qemu-project/qemu
> repo is used as a second cache, so that users forking QEMU will
> see a fast turnaround time on their CI jobs.

OMG you did it! Lovely... 😍

Looking at https://gitlab.com/berrange/qemu/-/pipelines/158854797
why gitlab isn't caching the docker images? the cache isn't
populated on all the runners yet? Or we have to use the same
runner again to hit its cache?

> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/containers.yml | 248 ++++++++++++++++++++++++++++++++++++
>  .gitlab-ci.yml              |   3 +
>  2 files changed, 251 insertions(+)
>  create mode 100644 .gitlab-ci.d/containers.yml
> 
> diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
> new file mode 100644
> index 0000000000..ea1edbb196
> --- /dev/null
> +++ b/.gitlab-ci.d/containers.yml
> @@ -0,0 +1,248 @@
> +
> +
> +.container_job_template: &container_job_definition
> +  image: docker:stable
> +  stage: containers
> +  services:
> +    - docker:dind
> +  before_script:
> +    - export TAG="$CI_REGISTRY_IMAGE/ci-$NAME:latest"
> +    - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/ci-$NAME:latest"
> +    - docker info
> +    - docker login registry.gitlab.com -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
> +  script:
> +    - docker pull "$TAG" || docker pull "$COMMON_TAG" || true
> +    - sed -i -e "s,FROM qemu:,FROM $CI_REGISTRY_IMAGE/ci-," tests/docker/dockerfiles/$NAME.docker
> +    - docker build --cache-from "$TAG" --cache-from "$COMMON_TAG" --tag "$TAG" -f "tests/docker/dockerfiles/$NAME.docker" tests/docker/dockerfiles
> +    - docker push "$TAG"
> +  after_script:
> +    - docker logout
> +
> +amd64-centos7-container:
> +  <<: *container_job_definition
> +  variables:
> +    NAME: centos7
[...]


