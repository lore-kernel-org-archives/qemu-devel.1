Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2C1C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F98621D40
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eR4ie5RH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F98621D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZlXX-0002bh-9O
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:55:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZlV8-0001Zp-Vu
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:52:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZlV0-0001l5-5w
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604368355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQh3j0ya4FkuELdIrOQG6llK5JJkZVpPImMv0NSBfXE=;
 b=eR4ie5RHSBA57RcagzgH8FksJbEP/yHQj0Rp6PEiFZi2AIlw9jykKOWjeNeYEUuVzUIptw
 3l1DrqFdAoV2j6y/jGtn1ur71ecF4iYGAgaX0Yrh9TnjQuM0tuAZI1Ribn4Il4rmof0wLW
 Hrdg6zTzOIwNJIw62xFEDfYN65bHxv0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-mz76xcNmPHm0Vxf--Rc2sw-1; Mon, 02 Nov 2020 20:52:34 -0500
X-MC-Unique: mz76xcNmPHm0Vxf--Rc2sw-1
Received: by mail-wm1-f71.google.com with SMTP id a130so924984wmf.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 17:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yQh3j0ya4FkuELdIrOQG6llK5JJkZVpPImMv0NSBfXE=;
 b=EJg/e3o/KiS8MdxneFMYXnDU2LRMpmClRWixe7RQ/n3s11x3/1gYeU9BuDg1S42h9i
 BjF1zWCtYE7RCgJT+fDJApjUKhSkr9bexME6JwdmV8EFYiLPyITn+HKcqqws1Frc3Jsk
 5m1oB4mavICIyNGhuGS6k7VTJg8rQxxH8gjhbsQrKpAmONL9+0z7CXC6HF5bnQf/KCyD
 CsEZ0EdxqP8xR4OdECZv/7qWYGEcMLp5Gfbzdpuu0Oq5jBe/KVCYUJjOianLEci/IDl0
 S6wjKbZlbRcvUgPX0re8qZDeEV5JYYGdbsw/ujaWZUSzqkrSYwHoMrVZ80V9uTiZ0TkA
 Jp6g==
X-Gm-Message-State: AOAM532FGwmk0ywem8xectMyhWtdDOOGkAUn5t12nXC/og5UymcE3gHc
 4qwd9MLHCmb7qdjJSy7hqOEPuiMOgt73siMIE+KyAsQGhDqmIjVb0pZMxqC6icJQKguvr+t++97
 W/QsuMbduhA3OzM8=
X-Received: by 2002:adf:fa4e:: with SMTP id y14mr22656936wrr.377.1604368352649; 
 Mon, 02 Nov 2020 17:52:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrGeTDpFrOaF+o1pfUvSdHC0Q+Xp3GSlLux41gbGBn4UoosiiT/mbhqFKpi5ZlBzPJxlameg==
X-Received: by 2002:adf:fa4e:: with SMTP id y14mr22656910wrr.377.1604368352245; 
 Mon, 02 Nov 2020 17:52:32 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f17sm1339282wme.22.2020.11.02.17.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 17:52:31 -0800 (PST)
Subject: Re: [PATCH 0/3] tests/qtest: npcm7xx test fixes
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20201103011457.2959989-1-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d41219dd-6cac-f4a4-d559-27ac9b9d9554@redhat.com>
Date: Tue, 3 Nov 2020 02:52:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103011457.2959989-1-hskinnemoen@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:52:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Daniel (patches 1-3) & Marc-André (2).

On 11/3/20 2:14 AM, Havard Skinnemoen via wrote:
> This series contains a fix for the randomness calculation in npcm7xx_rng-test.
> It also makes test failures fatal. The last patch would have dumped the random
> data to stderr if the randomness test fails, except now that failures are
> fatal, it never actually gets a chance to do that.
> 
> It may not make sense to apply all three, but I'd definitely take (1), and I'll
> leave it up to you whether to apply (2), (3) or both.
> 
> Havard Skinnemoen (3):
>   tests/qtest/npcm7xx_rng-test: count runs properly
>   tests/qtest/npcm7xx: Don't call g_test_set_nonfatal_assertions
>   tests/qtest/npcm7xx_rng-test: dump random data on failure
> 
>  tests/qtest/npcm7xx_gpio-test.c           |  1 -
>  tests/qtest/npcm7xx_rng-test.c            | 15 +++++++++++++--
>  tests/qtest/npcm7xx_timer-test.c          |  1 -
>  tests/qtest/npcm7xx_watchdog_timer-test.c |  1 -
>  4 files changed, 13 insertions(+), 5 deletions(-)
> 


