Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A7BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD892072E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUOJxLNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD892072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joNip-0002A3-Bq
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 04:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joNi9-0001kA-Mn
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 04:58:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56308
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joNi3-0000Tq-Cx
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 04:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593075493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N8Yw1Q9L2daiiK8lTD3FN2B1e4/TPgWOw15SFLRIkLo=;
 b=BUOJxLNEdYh/7XxXwm0jh6uEp5ZrnpSdkwadhPXrHWmIL94bysM4EWIcoS0f46TjNFSVW4
 MLwRXP44y/eXp13U9IkW5hg6fxDJlGfCk5JMTT9aLm4yOetkZnNigHLHUeQTePaXMxaIgp
 fnT6CSY62iBrpJPbMwb+VMzgAmIUo6s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-gUDqLKWOOuuPLQD86h325Q-1; Thu, 25 Jun 2020 04:58:12 -0400
X-MC-Unique: gUDqLKWOOuuPLQD86h325Q-1
Received: by mail-wm1-f72.google.com with SMTP id h25so6733751wmb.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 01:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=N8Yw1Q9L2daiiK8lTD3FN2B1e4/TPgWOw15SFLRIkLo=;
 b=EqhDWmHUCmqX8G5h1WFpwndWZk+9eVMIQQtC4orxVq+JOkQf7lWOT0nEGoEc14EakA
 OEWPD9Cc982NXM4sz3zXclZ2nO4Lr1IqQPBeyABCptmVDp4x7XGrv5YYXgAAOrFfiaU+
 Ox9k8K9FEw9Mvt85xeHnMlKlWcoGkFuJLE9+zFVVV2xd/wdoAhiJH4+1gDL/C6dgqyZq
 F6lg2JqlbvXJ3T1bSJz4iB8AH9/2LQFWVzvixoF0XtoM+90lq3993gOFDN0nyW4K/FI0
 y0C/UjM7/2pmm8IKZlO6Zrm7fHAiMPf01y2x4wFMr7PTmld11TQJqkHSd8Lax5Hi2HKh
 kMYw==
X-Gm-Message-State: AOAM531nwhsnU4AMN3rDVXNG0FnbQPJT215U6A2LjvpEMF8ORT7+DOBE
 7t0wktNa0DDRCUoJ9BrTeQd1uDl8edJjk6Fws9vRvIyMT5otDXz9fpdG1YdCnM+uHaRzJ2w7WOl
 VSVpZogzrb1FsbA0=
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr2226716wmf.0.1593075491076; 
 Thu, 25 Jun 2020 01:58:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUannUV7AMd49VQy5z881m5dFpBYn0lEleD7FBqet+Tis33ImMWUBZcuUGj5oPnWNQPTkhfQ==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr2226684wmf.0.1593075490788; 
 Thu, 25 Jun 2020 01:58:10 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v20sm31315651wrb.51.2020.06.25.01.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 01:58:10 -0700 (PDT)
Subject: Re: [PATCH RFC 1/3] gitlab: introduce explicit "container" and
 "build" stages
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-2-berrange@redhat.com>
 <bd889cd5-7088-84f8-85f6-85c6b7d6e049@redhat.com>
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
Message-ID: <14cc2376-0715-a74c-41d1-7dd33890a208@redhat.com>
Date: Thu, 25 Jun 2020 10:58:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <bd889cd5-7088-84f8-85f6-85c6b7d6e049@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 10:54 AM, Thomas Huth wrote:
> On 22/06/2020 17.33, Daniel P. Berrangé wrote:
>> If no stage is listed, jobs get put in an implicit "test" stage.
>> Some jobs which create container images to be used by later stages
>> are currently listed as in a "build" stages.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   .gitlab-ci.d/edk2.yml    |  3 ++-
>>   .gitlab-ci.d/opensbi.yml |  3 ++-
>>   .gitlab-ci.yml           | 11 +++++++++++
>>   3 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/.gitlab-ci.d/edk2.yml b/.gitlab-ci.d/edk2.yml
>> index 088ba4b43a..d4e7dfcba6 100644
>> --- a/.gitlab-ci.d/edk2.yml
>> +++ b/.gitlab-ci.d/edk2.yml
>> @@ -1,5 +1,5 @@
>>   docker-edk2:
>> - stage: build
>> + stage: containers
>>    rules: # Only run this job when the Dockerfile is modified
>>    - changes:
>>      - .gitlab-ci-edk2.yml
> 
> Uh, oh, I guess I should have changed that line to .gitlab-ci.d/edk2.yml
> when I renamed that file .... will send a patch...

Well, your patch has been reviewed...

> 
>> @@ -24,6 +24,7 @@ docker-edk2:
>>    - docker push $IMAGE_TAG
>>     build-edk2:
>> + stage: build
>>    rules: # Only run this job when ...
>>    - changes: # ... roms/edk2/ is modified (submodule updated)
>>      - roms/edk2/*
>> diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
>> index dd051c0124..ec1c1f4cab 100644
>> --- a/.gitlab-ci.d/opensbi.yml
>> +++ b/.gitlab-ci.d/opensbi.yml
>> @@ -1,5 +1,5 @@
>>   docker-opensbi:
>> - stage: build
>> + stage: containers
>>    rules: # Only run this job when the Dockerfile is modified
>>    - changes:
>>      - .gitlab-ci-opensbi.yml
> 
> dito

Oops...

> 
>> @@ -24,6 +24,7 @@ docker-opensbi:
>>    - docker push $IMAGE_TAG
>>     build-opensbi:
>> + stage: build
>>    rules: # Only run this job when ...
>>    - changes: # ... roms/opensbi/ is modified (submodule updated)
>>      - roms/opensbi/*
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 349c77aa58..9fdc752ea6 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -1,3 +1,7 @@
>> +stages:
>> +  - containers
>> +  - build
>> +
>>   include:
>>     - local: '/.gitlab-ci.d/edk2.yml'
>>     - local: '/.gitlab-ci.d/opensbi.yml'
>> @@ -17,6 +21,7 @@ include:
>>     - JOBS=$(expr $(nproc) + 1)
>>     build-system1:
>> + stage: build
>>    image: ubuntu:19.10
>>    <<: *before_script_apt
>>    script:
>> @@ -31,6 +36,7 @@ build-system1:
>>    - make -j"$JOBS" check
>>     build-system2:
>> + stage: build
>>    image: fedora:latest
>>    <<: *before_script_dnf
>>    script:
>> @@ -46,6 +52,7 @@ build-system2:
>>    - make -j"$JOBS" check
>>     build-disabled:
>> + stage: build
>>    image: fedora:latest
>>    <<: *before_script_dnf
>>    script:
>> @@ -62,6 +69,7 @@ build-disabled:
>>    - make -j"$JOBS" check-qtest SPEED=slow
>>     build-tcg-disabled:
>> + stage: build
>>    image: centos:8
>>    <<: *before_script_dnf
>>    script:
>> @@ -82,6 +90,7 @@ build-tcg-disabled:
>>               260 261 262 263 264 270 272 273 277 279
>>     build-user:
>> + stage: build
>>    <<: *before_script_apt
>>    script:
>>    - mkdir build
>> @@ -92,6 +101,7 @@ build-user:
>>    - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
>>     build-clang:
>> + stage: build
>>    image: fedora:latest
>>    <<: *before_script_dnf
>>    script:
>> @@ -106,6 +116,7 @@ build-clang:
>>    - make -j"$JOBS" check
>>     build-tci:
>> + stage: build
>>    image: centos:8
>>    <<: *before_script_dnf
>>    script:
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


