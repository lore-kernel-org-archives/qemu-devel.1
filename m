Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4ABC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 094582078D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqp9CZki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094582078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PFt-0000sH-6f
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8PEz-0008Bl-Ix
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8PEx-00020u-9g
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597847938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kmA3D2z/AeMqn7o3kywkPIKsl6hEPXrNgZQ79+LG3AY=;
 b=bqp9CZkicin1+fPwqrZ9KSS5uJUDqHcz6WUO8Qk7R/hiz0c7I2xqkH0kLw4myX3Qc3ecAk
 l82YCcs+4uzaY/CIEwYnCZCgXLdKaxZ2y8yTVyrFunZJcpBRMO0lsOifkBN3aHvNJh8Umg
 d5NKJtBI7PDspknVnVSPV9QaQ5hOi5Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-RmkiibzLOHyyMxidl1MHzw-1; Wed, 19 Aug 2020 10:38:55 -0400
X-MC-Unique: RmkiibzLOHyyMxidl1MHzw-1
Received: by mail-wr1-f69.google.com with SMTP id 89so9414948wrr.15
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 07:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=kmA3D2z/AeMqn7o3kywkPIKsl6hEPXrNgZQ79+LG3AY=;
 b=sVcQSWPmWfpa/oGbTyhK+iuFcz2VVTKIryCR7R2O1n9EgLOo1dYy/ZXqRXX3WFOmp1
 Luy9UnlUQfaK8YQn957TbfWd+Yvy9kdU2Sai0gIusT+CZ0DETqt9ViWnmX8H8hILCcyx
 PPPAdoUeGO3Rake0SEdd4Riz8vY0ZfiaE9x/6aLUFS5qeVYzYvOL6DkzTwRwUew7/kZO
 BRIfqZgNUgHCK+n7cnVvcmnUMdUi8LmePRScAwNbCbap3+IALFOZNlgQRP1j0LYhhdMZ
 qRue9w8IIovKEPJMcBHIHPmWWLFuUGXpfvfMb1YwVmMy+/+4ME81wFoqH+GDF156HjSS
 4tFw==
X-Gm-Message-State: AOAM533768uf/rV2pSSBzK/2pDkNbpervW2DJUr3fC4i9a14CF9DiASs
 ac+NVJa2fOhBvliyBmRb3AIwnaBeQasAxT0wLRvjQXlEy740TyzpJxwTy0NdA6h6KC1OkI/nqy2
 y5geigtO1qIb4nHo=
X-Received: by 2002:a7b:c185:: with SMTP id y5mr5240085wmi.95.1597847933845;
 Wed, 19 Aug 2020 07:38:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYRwSY88T1/zRpEw25ZrrFx0QalqNmQjj9mbOy83oV80tUDLbzNEDDqrgaa5FwAUUqMKhdbQ==
X-Received: by 2002:a7b:c185:: with SMTP id y5mr5240049wmi.95.1597847933538;
 Wed, 19 Aug 2020 07:38:53 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id e5sm42966010wrc.37.2020.08.19.07.38.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 07:38:52 -0700 (PDT)
Subject: Re: [PATCH] qtest: add fuzz test case
To: Li Qiang <liq3ea@163.com>, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, alxndr@bu.edu
References: <20200819141533.66354-1-liq3ea@163.com>
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
Message-ID: <baabaa94-e4bf-3578-2f78-624704eb29c4@redhat.com>
Date: Wed, 19 Aug 2020 16:38:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819141533.66354-1-liq3ea@163.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 06:57:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, liq3ea@gmail.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/20 4:15 PM, Li Qiang wrote:
> Currently the device fuzzer find a more and more issues.
> For every fuzz case, we need not only the fixes but also
> the coressponding test case. We can analysis the reproducer

Typo "corresponding"

> for every case and find what happened in where and write
> a beautiful test case. However the raw data of reproducer is not
> friendly to analysis. It will take a very long time, even far more
> than the fixes itself. So let's create a new file to hold all of
> the fuzz test cases and just use the raw data to act as the test
> case. This way nobody will be afraid of writing a test case for
> the fuzz reproducer.

Ahaha nice :)

> 
> This patch adds the issue LP#1878263 test case.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/qtest/Makefile.include |  2 ++
>  tests/qtest/fuzz-test.c      | 45 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 tests/qtest/fuzz-test.c
> 
> diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
> index b0204e44f2..ff460179c5 100644
> --- a/tests/qtest/Makefile.include
> +++ b/tests/qtest/Makefile.include
> @@ -7,6 +7,7 @@ check-qtest-generic-y += machine-none-test
>  check-qtest-generic-y += qmp-test
>  check-qtest-generic-y += qmp-cmd-test
>  check-qtest-generic-y += qom-test
> +check-qtest-generic-y += fuzz-test

Maybe name that fuzzed-reproducers-test?

>  check-qtest-generic-$(CONFIG_MODULES) += modules-test
>  check-qtest-generic-y += test-hmp
>  
> @@ -272,6 +273,7 @@ tests/qtest/m25p80-test$(EXESUF): tests/qtest/m25p80-test.o
>  tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o $(libqos-pc-obj-y)
>  tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-pc-obj-y)
>  tests/qtest/fw_cfg-test$(EXESUF): tests/qtest/fw_cfg-test.o $(libqos-pc-obj-y)
> +tests/qtest/fuzz-test$(EXESUF): tests/qtest/fuzz-test.o $(libqos-pc-obj-y)
>  tests/qtest/rtl8139-test$(EXESUF): tests/qtest/rtl8139-test.o $(libqos-pc-obj-y)
>  tests/qtest/pnv-xscom-test$(EXESUF): tests/qtest/pnv-xscom-test.o
>  tests/qtest/wdt_ib700-test$(EXESUF): tests/qtest/wdt_ib700-test.o
> diff --git a/tests/qtest/fuzz-test.c b/tests/qtest/fuzz-test.c
> new file mode 100644
> index 0000000000..695c6dffb9
> --- /dev/null
> +++ b/tests/qtest/fuzz-test.c
> @@ -0,0 +1,45 @@
> +/*
> + * QTest testcase for fuzz case
> + *
> + * Copyright (c) 2020 Li Qiang <liq3ea@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +
> +#include "qemu/osdep.h"
> +
> +#include "libqtest.h"
> +
> +/*
> + * This used to trigger the assert in scsi_dma_complete
> + * https://bugs.launchpad.net/qemu/+bug/1878263
> + */
> +static void test_megasas_zero_iov_cnt(void)

I'd name it test_lp1878263_megasas_zero_iov_cnt()
or lp1878263_megasas_zero_iov_cnt().

> +{
> +    QTestState *s;
> +
> +    s = qtest_init("-nographic -monitor none -serial none "
> +                   "-M q35 -device megasas -device scsi-cd,drive=null0 "
> +                   "-blockdev driver=null-co,read-zeroes=on,node-name=null0");
> +    qtest_outl(s, 0xcf8, 0x80001818);
> +    qtest_outl(s, 0xcfc, 0xc101);
> +    qtest_outl(s, 0xcf8, 0x8000181c);
> +    qtest_outl(s, 0xcf8, 0x80001804);
> +    qtest_outw(s, 0xcfc, 0x7);
> +    qtest_outl(s, 0xcf8, 0x8000186a);
> +    qtest_writeb(s, 0x14, 0xfe);
> +    qtest_writeb(s, 0x0, 0x02);
> +    qtest_outb(s, 0xc1c0, 0x17);
> +    qtest_quit(s);

Actually all the test body could be generated...
Alex, can you have a look at that?

> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("fuzz/megasas_zero_iov_cnt", test_megasas_zero_iov_cnt);
> +
> +    return g_test_run();

The problem is now the test suite will fail because this test is not
fixed.

Good idea btw :)

> +}
> 


