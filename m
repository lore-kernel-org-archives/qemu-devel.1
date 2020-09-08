Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294B5C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1858206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/y9lt3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1858206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFc4L-0003fl-OD
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 07:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFc1h-0000ib-NT
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:43:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39282
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFc1g-0001tY-0T
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599565383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivC7vUbxtaJ7G5UmTaqj/zawMr9v9i0KSt9iF0l0sFs=;
 b=A/y9lt3nk5ilqraVBLbc8QODa01vY0dOdyiMCQIbG40zsBFYaefznef1PHYD/KACSDKQwC
 xirxTAyZukCHNHbljLcPUq6wm6/Nso5uSa4IvAZ7YlOohcWSCE9qkBSadD0uEc4buSB6Ku
 cTEOqK28jc/4eUPAcnivlGy/7f7WZ2Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-dwxZYSp-M3-0dANuPMRjug-1; Tue, 08 Sep 2020 07:43:01 -0400
X-MC-Unique: dwxZYSp-M3-0dANuPMRjug-1
Received: by mail-ej1-f72.google.com with SMTP id ml20so6502411ejb.23
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 04:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ivC7vUbxtaJ7G5UmTaqj/zawMr9v9i0KSt9iF0l0sFs=;
 b=qIbnme7ZbiT78d31QhOJMC66yx7lNsqYBq9z2d3FoHMxiztN3O3uAJUwJwCkSF34b4
 8V9vPDSh0+h9r3EXIJqCmdXi2UQFUOeUn94myYg0fwRd6x52i5mGfsjvHad4UhhrDLOr
 655ga/DB6tkabn8vC/GxEuQMMSXTxwIy3X2PRvbG8G/XYeMghufz94SaICwV3dvj0Hsr
 OXO9Z3ruKHpL+BIMZLe913VGedzmdisJn4vqwKd/H1YFEBd5olNSYtCVsTNiO1tCCdQg
 dc7g64keKHAVm9IueDE+jUC0uGPsdm4wd31btB5cBfV3SceZ3ZwLGfP15yCLoyrWQBQy
 EH3Q==
X-Gm-Message-State: AOAM532YDdCCMDlN9L3YrhRb+GS8P7NAPLeD/dCLoKp+MFcCPVww0F9D
 k6kOnMOOKWrG1ihqFdwgVr+UfCWGJUadLiTt8rtd4rzyGdYYWcFzmrdJMBtowcquKcAafuv6aHz
 p3Lc9c/f7xcwGCdc=
X-Received: by 2002:aa7:cb92:: with SMTP id r18mr26697793edt.158.1599565380170; 
 Tue, 08 Sep 2020 04:43:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzn7Hj2Kuph0+GzrrTweZ3UeKW2xdWILtGo6d59h5dYoqit0ejqiFzW0OGDqnSNMDy2l11GrQ==
X-Received: by 2002:aa7:cb92:: with SMTP id r18mr26697775edt.158.1599565379985; 
 Tue, 08 Sep 2020 04:42:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6c4a:4cae:bef0:843f?
 ([2001:b07:6468:f312:6c4a:4cae:bef0:843f])
 by smtp.gmail.com with ESMTPSA id r26sm17923064ejb.102.2020.09.08.04.42.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 04:42:59 -0700 (PDT)
Subject: Re: [RFC PATCH] cpus: Initialize current_cpu with the first vCPU
 created
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200701182100.26930-1-philmd@redhat.com>
 <CAFEAcA8ZKEVySwDAQ+x9xA9bosOs5q20CZLZjBvkXj_d6ZVBuA@mail.gmail.com>
 <20200907203505.hpq5v32gayc5o5yd@mozz.bu.edu>
 <dfac2489-3c4a-aa44-c38b-435db5b0fd2c@redhat.com>
 <CAAdtpL6i52airFP_p7Z5tBU-F3hYtbfv8_2=-QYbjt-NOnP6xQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c4625c0e-dd46-1348-c4db-40b1e6e53154@redhat.com>
Date: Tue, 8 Sep 2020 13:43:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAAdtpL6i52airFP_p7Z5tBU-F3hYtbfv8_2=-QYbjt-NOnP6xQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/20 08:39, Philippe Mathieu-Daudé wrote:
> Le mar. 8 sept. 2020 08:33, Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> a écrit :
> 
>     On 07/09/20 22:35, Alexander Bulekov wrote:
>     >>> RFC because I believe the correct fix is to NOT use current_cpu
>     >>> out of cpus.c, at least use qemu_get_cpu(0) to get the first vCPU.
>     >> Yes, I agree -- I don't think this is the correct fix.
>     >> current_cpu is documented as "only valid inside cpu_exec()",
>     >> ie if you're actually on a vcpu thread you can use it, but if
>     >> you're not on a CPU thread, like the monitor, you need to
>     >> say which vCPU you want to affect. For the monitor, that
>     > Following up on this old thread.. Does qtest count as a pseudo-vCPU?
>     > Since qtest already uses first_cpu for all of its address_space calls,
>     > would it be appropriate to set current_cpu to first_cpu in qtest's
>     > initialization?
> 
> 
> qtest doesn't provide vCPU so first_cpu = NULL, that wouldn't help.

Doesn't qtest use qemu_dummy_start_vcpu?

Paolo


