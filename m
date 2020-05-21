Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D85BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6082072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAiniqUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6082072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnYi-0006yR-Ga
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnXO-0005Ox-Bt
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:55:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38820
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnXL-0002vp-Gm
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590076510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvmqkTREPnIQgumN6Baa7AbQ9wZxRHSfBjzoTW7p+x4=;
 b=MAiniqUVCtTS0Al2Nd6o9bCE0YddJ8RJpQBTtFoh7lUkAMiYJRO8Lc2yQGSXiAdLyXfoXc
 UmD0vCDe9IQIFoIG47Kni9s65YPACudAqUGLZjqmGIViSJqQmHvFpHUk6RIRw9aDOXhNAl
 4a1aGUuD54w5Jg5HlvwNr2S7Zqw0OK4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-Cv7-vvD-OTqp2Yym-orGNg-1; Thu, 21 May 2020 11:55:05 -0400
X-MC-Unique: Cv7-vvD-OTqp2Yym-orGNg-1
Received: by mail-wm1-f72.google.com with SMTP id y20so806000wmi.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kvmqkTREPnIQgumN6Baa7AbQ9wZxRHSfBjzoTW7p+x4=;
 b=pbUWPP2G4hkhYDVbTX71CY3Biky4VilY0Z7x2nl55kFj4YClhktZ6YbyhhaIUDBMZm
 UoXc9ktieralvgmGvcc/O73aTKw270BDDCZeSqa9+GhoDoS/riahKNORJi5rl++PPRy8
 Vg+l4k8HkRZHbRRYSwearyajL6XKrZMlYyHzINN5MX+BF365WMmpF5qWC97ldu+mlCsf
 V6hOJTwiSmuRxb68AVw3aFoPijqW+JBju2jZrI+SH1HC0DKTVuJalY1nm15UHqqoYE40
 scLI1zgeFZrYwRKLNsOvNnUYA1EgQ5NxiKG4tXa5FTJbAYIYiym5Z2O9r8ZYET2u3Mvc
 UHyg==
X-Gm-Message-State: AOAM5304rGTei+UouTqhfKArCynxnSPs4cP/msX/PtvVg909zXZjHpsd
 Hhc40fqFV/JBVKo631903Z+/DPb6HXizuyh0Z1T8QL836J8/PF35iAKshO8z7t97wR3P+HbvI70
 gOC21ekMBu8u5dR8=
X-Received: by 2002:a05:600c:1403:: with SMTP id
 g3mr10035419wmi.51.1590076504582; 
 Thu, 21 May 2020 08:55:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzslmZ2AtJyMi4n+cHQ5y1VCo/CNiTHxCs1tL31fXoBKiyXhqwOuDV8U7dh6OSYCyak9Yv6Iw==
X-Received: by 2002:a05:600c:1403:: with SMTP id
 g3mr10035397wmi.51.1590076504377; 
 Thu, 21 May 2020 08:55:04 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id s67sm7072415wmf.3.2020.05.21.08.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 08:55:03 -0700 (PDT)
Subject: Re: [PATCH] x86/cpu: Enable AVX512_VP2INTERSECT cpu feature
To: Cathy Zhang <cathy.zhang@intel.com>, rth@twiddle.net, ehabkost@redhat.com
References: <1586760758-13638-1-git-send-email-cathy.zhang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9eb3a0ba-d695-1fb3-74ea-d69e45941506@redhat.com>
Date: Thu, 21 May 2020 17:55:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1586760758-13638-1-git-send-email-cathy.zhang@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/04/20 08:52, Cathy Zhang wrote:
> AVX512_VP2INTERSECT compute vector pair intersection to a pair
> of mask registers, which is introduced with intel Tiger Lake,
> defining as CPUID.(EAX=7,ECX=0):EDX[bit 08].
> 
> Refer to the following release spec:
> https://software.intel.com/sites/default/files/managed/c5/15/\
> architecture-instruction-set-extensions-programming-reference.pdf
> 
> Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
> ---
>  target/i386/cpu.c | 2 +-
>  target/i386/cpu.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 92fafa2..c8c95c3 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1078,7 +1078,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .feat_names = {
>              NULL, NULL, "avx512-4vnniw", "avx512-4fmaps",
>              NULL, NULL, NULL, NULL,
> -            NULL, NULL, "md-clear", NULL,
> +            "avx512-vp2intersect", NULL, "md-clear", NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL /* pconfig */, NULL,
>              NULL, NULL, NULL, NULL,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 576f309..5c34795 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -770,6 +770,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_EDX_AVX512_4VNNIW     (1U << 2)
>  /* AVX512 Multiply Accumulation Single Precision */
>  #define CPUID_7_0_EDX_AVX512_4FMAPS     (1U << 3)
> +/* AVX512 Vector Pair Intersection to a Pair of Mask Registers */
> +#define CPUID_7_0_EDX_AVX512_VP2INTERSECT (1U << 8)
>  /* Speculation Control */
>  #define CPUID_7_0_EDX_SPEC_CTRL         (1U << 26)
>  /* Single Thread Indirect Branch Predictors */
> 

Queued, thanks.

Paolo


