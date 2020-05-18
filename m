Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A564DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716FE207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IH/fIqjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716FE207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jabtD-00015u-Qo
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabsV-0000Vd-Rk
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:16:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60861
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabsU-00008t-3F
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589793364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qd1QOf1vGuqRSKOfb4zyT2zsQafyvJNhEuPavwQJFNM=;
 b=IH/fIqjvyx9vM9y2n2zZoO4AyAET6ToJ7Y3qSgji51K3KiuxMhgCxh7iRHf4eyS1R7e7J7
 9DYSY1Mo/hTQ8iCwJqWtZQyAI/RSpkz8UxHKkOaWCAAGVMlIcp9wwqVjgRbCr43uUU2mcm
 jKr8fSF6Fl8KFhxHVdZpEvRVyXFrHYw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-2E-RsIgpN0uaa0aj2v4ahg-1; Mon, 18 May 2020 05:16:02 -0400
X-MC-Unique: 2E-RsIgpN0uaa0aj2v4ahg-1
Received: by mail-wm1-f72.google.com with SMTP id l26so2826270wmh.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 02:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Qd1QOf1vGuqRSKOfb4zyT2zsQafyvJNhEuPavwQJFNM=;
 b=OtzuAMX3q/r6KHLTiCEWHkjY6KWWQvoCxIEl1hVV380Z0v5kz4gNMSjb8pq23tvACC
 7YyNnxLDmhuIgPwShCErRdQ5WxzyixhAjGf9wd0Ugu8dt63UEDiIjnt++sOfLmtlP+Db
 qUBkGRxUVbkftAZJaKon0LyFjqqq6VcbNntIs8yJy2SbjQAczmrIStDvLaSTj1vl7/Be
 BSTzbB2ECRXNiSgsyQUj+s3rZHbeAipuGUF9pUxMsV5rHi9kMzptBTfEFFk/nhyIC45f
 E1+ElTdsQPmdn/zvpFzWZCMGvBki2BtzXYtQdboZbfP1OqgrVKSU2OlVNF9sEzbAq2Yp
 snRg==
X-Gm-Message-State: AOAM532P2xmaLdIohMKDHAX8n0vcOasHjff0vSK3pnVpe7NOlypt8Ds3
 zTcVX2xCKaf/XejBqmmyO8utamUWbruBO8yACg63J3s5KW+23ttxR0+fcnbmDtfS5bu3/z4IYWD
 gdHonHZ/g+tUC2oY=
X-Received: by 2002:a1c:e903:: with SMTP id q3mr17682647wmc.76.1589793361367; 
 Mon, 18 May 2020 02:16:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1iIMCMHR4o29sbjuqp2Ia/nmZXSRTSjhHLrWAER2k/8UFEQRd9lgzODaNJND2wZAG8tcBWA==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr17682546wmc.76.1589793360162; 
 Mon, 18 May 2020 02:16:00 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id c80sm16288168wme.15.2020.05.18.02.15.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 02:15:59 -0700 (PDT)
Subject: Re: [PATCH] travis.yml: Use clang++ in the Clang tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200518083316.25065-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2e571780-e8d6-406f-0475-afa43bcb0815@redhat.com>
Date: Mon, 18 May 2020 11:15:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518083316.25065-1-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 5/18/20 10:33 AM, Thomas Huth wrote:
> Our configure script does not look for clang++ automatically, so we
> should use --cxx=clang++ to make sure that we test our C++ code with
> Clang, too. And while we're at it, also use --host-cc=clang here
> to avoid that we use the normal "cc" as host C compiler.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .travis.yml | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 1ec8a7b465..564be50a3c 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -205,14 +205,15 @@ jobs:
>       # Test with Clang for compile portability (Travis uses clang-5.0)
>       - name: "Clang (user)"
>         env:
> -        - CONFIG="--disable-system"
> +        - CONFIG="--disable-system --host-cc=clang --cxx=clang++"
>           - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
>         compiler: clang
>   
>   
>       - name: "Clang (main-softmmu)"
>         env:
> -        - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS} "
> +        - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS}
> +                  --host-cc=clang --cxx=clang++"
>           - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-sanitize"
>         compiler: clang
>         before_script:
> @@ -222,7 +223,8 @@ jobs:
>   
>       - name: "Clang (other-softmmu)"
>         env:
> -        - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
> +        - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}
> +                  --host-cc=clang --cxx=clang++"
>           - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
>         compiler: clang
>   
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


