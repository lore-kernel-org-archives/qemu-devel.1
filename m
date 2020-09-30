Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC717C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6392064B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7FPpDwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6392064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZTq-0008Nd-5V
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNZEY-0005Zq-KM
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:21:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNZEW-0006X1-FU
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:21:14 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601461271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HKpq2oK2WNEzy5cJcVWHYsGnoJrgoZmDSZIZJeod+bc=;
 b=Y7FPpDwLZzXAq65L84EzdgT8gmKOCbR2yXXWFaMEHS2N7RDPS8W65Q3PFNH1x/MrTGKKLS
 wXC6JX7rFIaumUDb54J10nuDPDu6jVUuzTQgPFlyQIoI3zeNg3aZM/B/snoc1V65ANohYk
 j4Pjy0r1MhKIonXI9Maj9XqvPTfyp8w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-594hmiJ5N7KSYQUZ0WN9sQ-1; Wed, 30 Sep 2020 06:21:02 -0400
X-MC-Unique: 594hmiJ5N7KSYQUZ0WN9sQ-1
Received: by mail-wm1-f70.google.com with SMTP id c204so300342wmd.5
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 03:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=HKpq2oK2WNEzy5cJcVWHYsGnoJrgoZmDSZIZJeod+bc=;
 b=AtWjch1tQieVF5B80P/NReC26jnQV9aoNuP/QaZlQ4Dxvo1l4vIdHaTcjBTw9pl7cO
 J3Bvy3jaPjxqsQ/uDxAenoJCcEt6t+8YGSxgzqzyZJkNg5ECzvRkdyWmGCWR/KNevR6m
 BB1Au1KuC6lpvkxZr1+J8uGye3ehQcBNIcQOzGByduhGf/tLN4tkQxIQ67wSdDNO/ZKj
 enipTjkyXPWi1+VPqPTBUXcc7Hc+DxRjDkUvV7Z82Ckfyl/V1oXUl0iMXB+f1HgN4XTp
 /FHJImdTyQoM7Dr8APHsK1vzcf+IwlVNUO5e95Uc1r/ehInXLFwCcVV9Tzbq97g1Vagu
 NQyA==
X-Gm-Message-State: AOAM530zeWtEuAwHaOcPFPipp3HxBcaSswLNHwbHRQlVg2tKiY8eqms+
 993CzF7b7Jz5J0vmDr3e0097sUSHkrd0xOGa4sAgbl/N8g+pWQayFqE9kATfZiBjL+ygeo3jEEr
 2Lwf4HqYSd8j9zTQ=
X-Received: by 2002:a1c:7907:: with SMTP id l7mr2167365wme.89.1601461261040;
 Wed, 30 Sep 2020 03:21:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUkYNeBmg4ryAVKpcvFhKstjspsqkUFb63VCsE3fOeoa3MF067WBDzveobq9yJkTb55TuZUw==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr2167326wme.89.1601461260625;
 Wed, 30 Sep 2020 03:21:00 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id i33sm2255084wri.79.2020.09.30.03.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:21:00 -0700 (PDT)
Subject: Re: [PATCH v4 00/12] Support disabling TCG on ARM (part 2)
To: Igor Mammedov <imammedo@redhat.com>
References: <20200929224355.1224017-1-philmd@redhat.com>
 <20200930095841.3df7f8ee@redhat.com>
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
Message-ID: <1dd2c094-284c-0e32-bae3-0c227e5399ab@redhat.com>
Date: Wed, 30 Sep 2020 12:20:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930095841.3df7f8ee@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 9:58 AM, Igor Mammedov wrote:
> On Wed, 30 Sep 2020 00:43:43 +0200
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> Cover from Samuel Ortiz from (part 1) [1]:
>>
>>   This patchset allows for building and running ARM targets with TCG
>>   disabled. [...]
>>
>>   The rationale behind this work comes from the NEMU project where we're
>>   trying to only support x86 and ARM 64-bit architectures, without
>>   including the TCG code base. We can only do so if we can build and run
>>   ARM binaries with TCG disabled.
> 
> I don't recall exact reason but TCG variant is used by bios-tables-test
> to test arm/virt so it will probably break that
> (it has something to do with how KVM uses CPU/GIC, which was making
> ACPI tables not stable (i.e. depend on host), so comparison with master
> tables was failing)

Not a problem, we can restrict bios-tables-test to TCG.

I don't expect the KVM-only build being able to run many
of our current tests, as most of them expect TCG.

I'll have a look at restricting the TCG-dependent tests
after this series get accepted.

> 
>>
>> v4 almost 2 years later... [2]:
>> - Rebased on Meson
>> - Addressed Richard review comments
>> - Addressed Claudio review comments
>>
>> v3 almost 18 months later [3]:
>> - Rebased
>> - Addressed Thomas review comments
>> - Added Travis-CI job to keep building --disable-tcg on ARM
>>
>> v2 [4]:
>> - Addressed review comments from Richard and Thomas from v1 [1]
>>
>> Regards,
>>
>> Phil.
>>
>> [1]: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02451.html
>> [2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg689168.html
>> [3]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg641796.html
>> [4]: https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg05003.html
>>
>> Green CI:
>> - https://cirrus-ci.com/build/4572961761918976
>> - https://gitlab.com/philmd/qemu/-/pipelines/196047779
>> - https://travis-ci.org/github/philmd/qemu/builds/731370972
>>
>> Based-on: <20200929125609.1088330-1-philmd@redhat.com>
>> "hw/arm: Restrict APEI tables generation to the 'virt' machine"
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg745792.html
>>
>> Philippe Mathieu-Daudé (10):
>>   accel/tcg: Add stub for cpu_loop_exit()
>>   meson: Allow optional target/${ARCH}/Kconfig
>>   target/arm: Select SEMIHOSTING if TCG is available
>>   target/arm: Restrict ARMv4 cpus to TCG accel
>>   target/arm: Restrict ARMv5 cpus to TCG accel
>>   target/arm: Restrict ARMv6 cpus to TCG accel
>>   target/arm: Restrict ARMv7 R-profile cpus to TCG accel
>>   target/arm: Restrict ARMv7 M-profile cpus to TCG accel
>>   target/arm: Reorder meson.build rules
>>   .travis.yml: Add a KVM-only Aarch64 job
>>
>> Samuel Ortiz (1):
>>   target/arm: Do not build TCG objects when TCG is off
>>
>> Thomas Huth (1):
>>   target/arm: Make m_helper.c optional via CONFIG_ARM_V7M
>>
>>  default-configs/arm-softmmu.mak |  3 --
>>  meson.build                     |  8 +++-
>>  target/arm/cpu.h                | 12 ------
>>  accel/stubs/tcg-stub.c          |  5 +++
>>  target/arm/cpu_tcg.c            |  4 +-
>>  target/arm/helper.c             |  7 ----
>>  target/arm/m_helper-stub.c      | 73 +++++++++++++++++++++++++++++++++
>>  .travis.yml                     | 35 ++++++++++++++++
>>  hw/arm/Kconfig                  | 32 +++++++++++++++
>>  target/arm/Kconfig              |  4 ++
>>  target/arm/meson.build          | 40 +++++++++++-------
>>  11 files changed, 184 insertions(+), 39 deletions(-)
>>  create mode 100644 target/arm/m_helper-stub.c
>>  create mode 100644 target/arm/Kconfig
>>
> 


