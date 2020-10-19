Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C990CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2059122268
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5Ej0eIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2059122268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTnc-0001Bi-05
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUThj-0005ho-EC
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUThh-00019P-Li
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603108312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0tzOrj7TNrpoanQFX/3tZTaKTBJDcENmMYl5OwDg+rM=;
 b=K5Ej0eIqAgVK9MWhFUCoIsAsDCdOs5UHoWCL68ZD5qYQshz8AG24UQrsro0+1/oQwTQ4W/
 zNTa5w/bEENfJEvOmk01CmagMqxH1xePRXAgifntzD5kxTxqBCksmimlzYZR3zIU0kfY00
 /dU7F89uQlnj0WXPRHwyZaHA82y7XxA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-snym5jydMHO7kC_N5RAc_A-1; Mon, 19 Oct 2020 07:51:50 -0400
X-MC-Unique: snym5jydMHO7kC_N5RAc_A-1
Received: by mail-wm1-f69.google.com with SMTP id g71so4479741wmg.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 04:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0tzOrj7TNrpoanQFX/3tZTaKTBJDcENmMYl5OwDg+rM=;
 b=qddNrjTS0pTX9w5rbDYt/t4VYGbwWSAhQ1Z4OSutW3dIfVducvbGOLlSAWSyUsJ+vm
 k45Ny9ZFQYdAg+LovtdLvfRELCrSquTJ7XppWbgx5IqIG6yWSGovXpZr2PH5dAct1Tfn
 ARZC/Eri+4XF5ko629FLkCX6G3vS4lMgO/J7bwcdl/+nLsT14Y39Q1wkmAHLXxWsQ1Mq
 /I75VAsL3jH93k8gXtWC40ExCvdV7sQtvqKM2RILA+88EgYamRUiUHUlml2wBFjmApQD
 TCnfczwAM8qb4FHl9ZEJQqG0SLES9Y1pFcs4Wg2zqJeK7DoPEms+WB9437YIqqWZArq8
 W1Kw==
X-Gm-Message-State: AOAM530MkXfBwU+tFK5t0rPQs0CTjt38NAiJjvEWDPlYZQ5rDyqpj+rH
 g58eX0psHfZo0pBVAM875oQXsPKWQOS2yjlloWD1u2ihQ7Ki7EDPXxTOluBOujaiW3tIokHx2um
 albb3MdK88PaewLI=
X-Received: by 2002:a1c:417:: with SMTP id 23mr17032964wme.1.1603108309057;
 Mon, 19 Oct 2020 04:51:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1i47gFxzcJBtWstKNHRPQbokdbcjJBHEAbGz55LPw2FAOIWu1m795ekZgNkvbgIdg8Yp5GA==
X-Received: by 2002:a1c:417:: with SMTP id 23mr17032947wme.1.1603108308805;
 Mon, 19 Oct 2020 04:51:48 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id k6sm12473468wmk.16.2020.10.19.04.51.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 04:51:48 -0700 (PDT)
Subject: Re: [PATCH] do not use colons in test names
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201019114108.1779369-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <84dbaca3-95d6-295e-69de-3f67aa78e7ed@redhat.com>
Date: Mon, 19 Oct 2020 13:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019114108.1779369-1-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 1:41 PM, Paolo Bonzini wrote:
> Starting with meson 0.56, colons are used to separate the subproject name
> from the test name.  Use dash or slash depending on what looks nicer.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   tests/fp/meson.build    | 4 ++--
>   tests/qtest/meson.build | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/fp/meson.build b/tests/fp/meson.build
> index 24739ad421..514e345bf5 100644
> --- a/tests/fp/meson.build
> +++ b/tests/fp/meson.build
> @@ -603,7 +603,7 @@ fptest_rounding_args = ['-r', 'all']
>   # FIXME: i32_to_extF80 (broken), i64_to_extF80 (broken)
>   #        extF80_roundToInt (broken)
>   foreach k, v : softfloat_conv_tests
> -  test('fp-test:' + k, fptest,
> +  test('fp-test-' + k, fptest,
>          args: fptest_args + fptest_rounding_args + v.split(),
>          suite: ['softfloat', 'softfloat-conv'])
>   endforeach
> @@ -612,7 +612,7 @@ endforeach
>   #        extF80_{mulAdd} (missing)
>   foreach k, v : softfloat_tests
>     extF80_broken = ['lt_quiet', 'rem'].contains(k)
> -  test('fp-test:' + k, fptest,
> +  test('fp-test-' + k, fptest,
>          args: fptest_args + fptest_rounding_args +
>                ['f16_' + k, 'f32_' + k, 'f64_' + k, 'f128_' + k] +
>                (extF80_broken ? [] : ['extF80_' + k]),
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 3987f96086..c2822d9de7 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -250,7 +250,7 @@ foreach dir : target_dirs
>         }
>       endif
>       # FIXME: missing dependency on the emulator binary and qemu-img
> -    test('qtest-@0@: @1@'.format(target_base, test),
> +    test('qtest-@0@/@1@'.format(target_base, test),
>            qtest_executables[test],
>            depends: [test_deps, qtest_emulator],
>            env: qtest_env,
> 


