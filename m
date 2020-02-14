Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF59DC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DDB222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CiPf2Q+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DDB222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2hcm-0002hZ-S0
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2hbt-0002G6-Aa
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2hbr-0004jv-Uf
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:30:49 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2hbr-0004iG-Nb
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:30:47 -0500
Received: by mail-pl1-x641.google.com with SMTP id g6so4139655plp.6
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 12:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=U3vErsPz/gWhxJLENS7YwYcij3i60608UBHlEaWAIc4=;
 b=CiPf2Q+G9V04lqX9bzoNZkMvYxhDwuWC6G6Nxk5RZrropDbBB7YnYEAcBJMnzvIKvG
 DiBehz5c63dXNTcaCZziTowbRqUd9ndNIC9hqxyGupGXnK5BA02HcRCYnNNhOWV2nPoQ
 K4Y7HyyucjDmPU8YB8OBkKfsqpC+0aS6Dy239m3L6aFwc2GhfJiB8u/G5SjunCUUkSQJ
 PafIlbRjkqBYY2fA7tJODd1P0pDgBnxl6e+AMhVROhyneKQXQP4DZRQHNIl4nVJBk4Qi
 3XfKb53QtuysBTWA1Ug7KaLTL6e34bLLdFN/oszUoF70bnNdjJHEv51F+XfENQNauAG2
 X4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U3vErsPz/gWhxJLENS7YwYcij3i60608UBHlEaWAIc4=;
 b=aS7iLZHMlFrvLrM1IdI2jQ07sd7BklEh06JJM7UVsVWjdsfB0o05n55vuiYwX3COUY
 UhoH/eEzHDOcy/7H5d2K6YnenKPuEtvZm7elXIAmNFX4l6h8Dn5YhxGeVt+dmWStxql0
 bRCJg5C8oracrgoFY8J5YKv50K8Y/jKzgvXqwFxb2Rw7sqibO5FvPzZZkn0gHrtzIwtM
 NyMRKs4ihpBt7v3Iiaedc5jfYME/QIxMdeNy1CvJ8ZiMCEZTDN/XDjTOWn38lbsWtHuC
 TRKuUAuXBiwce+1lt8//9HU361KHdfhoO29Bs1rQog/xAN4oabgPE0jbuCq61vq7d+zb
 D2zQ==
X-Gm-Message-State: APjAAAXw/XbYbMJE8TRTQGEKrLCH+eGMWYuhD9XF1zj7YxIkzkjDS3tT
 XZG3E712lr1Yd3y83a1RohOa4Q==
X-Google-Smtp-Source: APXvYqyfkv1mR+11k+6wM+1VxENMtww63nNPzc23JAqaeLuStZ+SIvY0EcRSM4zNVz74tSY5n0jOBg==
X-Received: by 2002:a17:90a:fe02:: with SMTP id
 ck2mr5654121pjb.10.1581712246209; 
 Fri, 14 Feb 2020 12:30:46 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 188sm8176887pgf.24.2020.02.14.12.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 12:30:45 -0800 (PST)
Subject: Re: [PATCH v2 18/21] target/arm: Test correct register in aa32_pan
 and aa32_ats1e1 checks
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200214175116.9164-1-peter.maydell@linaro.org>
 <20200214175116.9164-19-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e9df303c-ba1c-1a86-3d57-1e7cc8860de3@linaro.org>
Date: Fri, 14 Feb 2020 12:30:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214175116.9164-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 9:51 AM, Peter Maydell wrote:
> The isar_feature_aa32_pan and isar_feature_aa32_ats1e1 functions
> are supposed to be testing fields in ID_MMFR3; but a cut-and-paste
> error meant we were looking at MVFR0 instead.
> 
> Fix the functions to look at the right register; this requires
> us to move at least id_mmfr3 to the ARMISARegisters struct; we
> choose to move all the ID_MMFRn registers for consistency.
> 
> Fixes: 3d6ad6bb466f
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      |  14 +++---
>  hw/intc/armv7m_nvic.c |   8 ++--
>  target/arm/cpu.c      | 104 +++++++++++++++++++++---------------------
>  target/arm/cpu64.c    |  28 ++++++------
>  target/arm/helper.c   |  12 ++---
>  target/arm/kvm32.c    |  17 +++++++
>  target/arm/kvm64.c    |  10 ++++
>  7 files changed, 110 insertions(+), 83 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

