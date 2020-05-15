Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED9CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82736206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQV/ERU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82736206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZUOZ-0002kD-KN
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 03:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZUNc-0002IV-T6
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:03:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36042
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZUNc-0004S8-3u
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589526215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z9cP3R2+TZvvM1yq/Uhzg1DcM86POq4w2MyMtO+UfCA=;
 b=NQV/ERU9Gj8XNJAJWTjryBKmE4xbUyC6NoiRjEZa1cEyy7W0R5JNKdJxiGZTrTezwk3//M
 x43154dSulRVNywcMMzomOzvLAsOPqP8ABz2QLTSP7tDUGfCC7mmoJ15wrgk4nXf+Mq/q5
 5xzJ0yNoGXtw12xe4+fB88A/Uzp0a78=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-pzb6KUF-NR2fflgpoWqtRA-1; Fri, 15 May 2020 03:03:33 -0400
X-MC-Unique: pzb6KUF-NR2fflgpoWqtRA-1
Received: by mail-wm1-f72.google.com with SMTP id t82so447632wmf.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 00:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z9cP3R2+TZvvM1yq/Uhzg1DcM86POq4w2MyMtO+UfCA=;
 b=ADQLNysBgAr1yJBM+5bpPWfGj5YR9uO+73+iCvbo9qaY1Sc6FNPTG82p0HsFCpyJpY
 gsvDl5lfagNfXFYkf4OAPaGA5+bFTBcxpEGXx41BeFkCGfGldtLeWa6+WNNjLUTrN8lN
 eQsBInYzHwlJaSIoM9ZPlJViR/WQ8bbeUxbOYUuaummWYWP4T5Frb7E1LAxIsF8TmWpo
 s0FTBEjd6KK1vkZt95BQB0XpRHWf/vWKddcODbcUSCrBeTwIsEopcdX0FnjTlXXgLtRg
 ByWHc1pU3M2+iWK1bfk46BVgc0mzy4Qqii/xXPqatzYBLN+jeU3eQVIZf4zQNa9mkkwf
 qT7Q==
X-Gm-Message-State: AOAM530m0BbsmU1e7IH8HSdYvgjs3c3RUzWJ/ztv5AZXJ7xUixaT7l9K
 6CuKSTGlY+jrubRadPlc4aso2WQKR5OwAGg6OrciGH9ieM8CV6r8y5lq1ETtKWqmjymDjLg6asu
 RU9hFqonUL4R1vWI=
X-Received: by 2002:a05:6000:10c3:: with SMTP id
 b3mr1809475wrx.53.1589526212363; 
 Fri, 15 May 2020 00:03:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/c3didIiz2jiKZbmvcO7KvKV1PyPh0UC3fAzhwIVzyl20dnq6TVuY9rifDb2RsOHxdccTHA==
X-Received: by 2002:a05:6000:10c3:: with SMTP id
 b3mr1809453wrx.53.1589526212125; 
 Fri, 15 May 2020 00:03:32 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 32sm2209433wrg.19.2020.05.15.00.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 00:03:31 -0700 (PDT)
Subject: Re: [PATCH 0/5] target/i386: fxtract, fscale fixes
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <58daea3d-8244-787d-ff2f-3afb260b903c@redhat.com>
Date: Fri, 15 May 2020 09:03:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Cc'ing FPU emulation maintainers too.

On 5/7/20 2:42 AM, Joseph Myers wrote:
> Among the various bugs in the x87 floating-point emulation that show
> up through a combination of glibc testing and code inspection, there
> are several in the implementations of the fxtract and fscale
> instructions.  This series fixes those bugs.
> 
> Bugs in other instructions, and bugs relating to floating-point
> exceptions and flag setting, will be addressed separately.  In
> particular, while some of these patches add code that sets exception
> flags in the softfloat state, it's generally the case that the x87
> emulation ignores exceptions in that state rather than propagating
> them to the status word (and to generating traps where appropriate).
> I intend to address that missing propagation of exceptions in a
> subsequent patch series; until it's addressed, the code setting
> exceptions won't actually do anything useful.  (There is also code in
> the x87 emulation, including that of fscale, that would result in
> spurious exceptions being set from a naive propagation of exceptions
> from the softfloat state, and thus will need updating to avoid
> propagating inappropriate exceptions when such propagation is
> implemented.)
> 
> Joseph Myers (5):
>    target/i386: implement special cases for fxtract
>    target/i386: fix fscale handling of signaling NaN
>    target/i386: fix fscale handling of invalid exponent encodings
>    target/i386: fix fscale handling of infinite exponents
>    target/i386: fix fscale handling of rounding precision
> 
>   target/i386/fpu_helper.c           |  59 +++++++++++++-
>   tests/tcg/i386/test-i386-fscale.c  | 108 ++++++++++++++++++++++++++
>   tests/tcg/i386/test-i386-fxtract.c | 120 +++++++++++++++++++++++++++++
>   3 files changed, 285 insertions(+), 2 deletions(-)
>   create mode 100644 tests/tcg/i386/test-i386-fscale.c
>   create mode 100644 tests/tcg/i386/test-i386-fxtract.c
> 


