Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CF2C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5D720714
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCFdtOyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5D720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ARt-000201-Ec
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 09:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1ARF-0001Rn-Fm
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 09:53:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1ARD-0003YN-Ex
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 09:53:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33844
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1ARD-0003XT-As
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 09:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581346406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izPLpU0paHfq3Rvo0HFYzR4b9+dI6xK1SWPc1LbekCs=;
 b=UCFdtOyyI5lgu6WnsSj1Ss4ShG8GSnxmjywytee3JBUIaRMM85cgYmZK5wsM4Z+5wpL5DZ
 TPjOdqCKu1qvmILsHjSQwdYYQ1O2wryXq5RLNHj/VbRr+lCXde25z1v14VC+yuwD6X+XxX
 XnLRDHPeWBbgpPOCx0ddkBeEEpsM5UA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-opEH36iVPKC92OwP2TKLtQ-1; Mon, 10 Feb 2020 09:53:10 -0500
Received: by mail-wm1-f70.google.com with SMTP id p2so3114366wma.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 06:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=izPLpU0paHfq3Rvo0HFYzR4b9+dI6xK1SWPc1LbekCs=;
 b=A9BxyxazlBYi/5gu5DCmQ3CTjsArgF8/OxsfdRY7hpm6nGE4f2icztCFwXSSZuWSb5
 Zrvhfg7P0rCoFlRvSTskMXqk9MQUz+rmoUas/u3JAYyxQwlXWu8dBbkLVfNa+zbRd9AE
 PsW+xg+EEnSK+FrkSBh87J3SlyzaV1LirOFh9MzXyEKORCRlBH71nQ/hrJNJ67gQrte/
 PyHDSU/pjwjjHyaDwkMDGjDzWC5JNo9tCvEnXcW7n01ShjjmdQqO/huotPCmzNuej5RC
 DO6K9XJgUSVKJg6TW0RffkPbQJibj4Izz9jElPW9inGqk0ynvNcKHWhbHyCHU/i75UaF
 ydyA==
X-Gm-Message-State: APjAAAWHSG6zw2eqD6TKA3WagRlJ+Iej45K1HmmH35m12zl5yWPrwDk9
 1eBve5CnZOkDT30BwZIj7/Ia4QpRcWnisLCIhito9Ory375DBT2yC6fTywcIwboqkHLjrwuZ+IV
 8OdI7ZZQ3eS8yGE8=
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr15572764wma.31.1581346387411; 
 Mon, 10 Feb 2020 06:53:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyuebncPXc22ofSKEopdsgy6Y2UEhvLoK6/ydfH+4Ge2yoO/ezO4gOY/Qq96ODrZkB/B03gTg==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr15572743wma.31.1581346387170; 
 Mon, 10 Feb 2020 06:53:07 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id w13sm846188wru.38.2020.02.10.06.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 06:53:06 -0800 (PST)
Subject: Re: [PATCH v4 0/8] Acceptance tests: boot Linux with KVM test
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200205203250.30526-1-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <305480ea-feeb-683a-c611-0643f4460e6c@redhat.com>
Date: Mon, 10 Feb 2020 15:53:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205203250.30526-1-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: opEH36iVPKC92OwP2TKLtQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: drjones@redhat.com, thuth@redhat.com, alex.bennee@linaro.org,
 ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Wainer,

On 2/5/20 9:32 PM, Wainer dos Santos Moschetta wrote:
> This adds boot Linux tests for x86_64, aarch64, ppc64, and s390x
> targets which, unlike others, enable the KVM acceleration. Likewise
> it was added test cases for tcg.
> 
> It is introduced an infraestructure on avocado_qemu framework
> so that:
> a) simply tagging the test with `accel:kvm` (or `accel:tcg`) will
> automatically set the corresponding '-accel' on the launched
> QEMU;
> b) test is canceled if the accelerator is not enabled on the QEMU
> binary or not available in the host. In special, it checks if SMT
> is disabled on POWER8.
> 
> The acceptance builder on Travis was changed too in order to make
> the test run.
> 
> Changes v3 -> v4:
> - Broke changes per-arch to ease the reviews. Resulting on
>    patches 02, 03, 05, 06.
> - The test for aarch64 now passes '-cpu max' and
>    -M 'virt,gic-version=max'. (patch 03) [drjones]
> - Added a fix to accel.kvm_available() so that it detects
>    correctly the availability of kvm on ppc64le. (patch 05)
> - The test for ppc64le now checks if SMT is enabled on
>    POWER8 then skip.
> 
> v3: [PATCH v3 0/4] Acceptance tests: boot Linux with KVM test
> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg672635.html
> v2: [PATCH v2 0/3] Acceptance tests: boot Linux with KVM test
> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg666238.html
> v1: [PATCH 0/3] Acceptance tests: boot Linux with KVM test
> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg627498.html
> 
> Tree:
> - Git: https://github.com/wainersm/qemu
> - Branch: acceptance_kvm_test-v4
> 
> CI:
> - Travis (FAIL): https://travis-ci.org/wainersm/qemu/builds/646154220
>    Failed jobs are not related with this series changes.
> 
> Wainer dos Santos Moschetta (8):
>    tests/acceptance: avocado_qemu: Introduce the 'accel' test parameter
>    tests/acceptance: boot_linux_console: Add boot Linux/x86 with KVM
>    tests/acceptance: boot_linux_console: Add boot Linux/aarch64 with KVM
>    python/qemu: accel: Fix kvm_available() on ppc64le
>    test/acceptance: boot_linux_console: Add boot Linux/ppc64le with KVM
>    tests/acceptance: boot_linux_console: Add boot Linux/s390x with KVM
>    tests/acceptance: avocado_qemu: Refactor the handler of 'machine'
>      parameter
>    travis.yml: Enable acceptance KVM tests
> 
>   .travis.yml                               |   7 +-
>   docs/devel/testing.rst                    |  16 ++++
>   python/qemu/accel.py                      |   3 +-
>   tests/acceptance/avocado_qemu/__init__.py |  27 +++++-
>   tests/acceptance/boot_linux_console.py    | 108 +++++++++++++++++-----
>   5 files changed, 136 insertions(+), 25 deletions(-)

As I'm not sure this is the correct to do, I'll defer this review to Cleber.
We can also have a look at it during the next Avocado call.


