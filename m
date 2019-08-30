Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D9EC3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 15:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2EC23407
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 15:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbj0Fbbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2EC23407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3igN-0001d0-9A
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 11:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i3idL-0000vn-Kb
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 11:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i3idH-0001wk-FU
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 11:16:13 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i3idH-0001md-4p
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 11:16:11 -0400
Received: by mail-pf1-x443.google.com with SMTP id a67so1566350pfa.6
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 08:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W/5KIcDspcCw4aMY+Mi0R66tPJCSR/ireqasuabxNoI=;
 b=cbj0FbbsM32b5T6tIUvTc0FS5j8I3k507dV1dzfoEER3fJuiIX75EtPcqoyOnGoMTe
 A3dEV+juzYy3hkiDOqAma/Mh8RRldXz6yQSRr2JUTg5oUIhyAYs2oaTnzKoFP1y12OEc
 o+qR7bWNnrqbGgUsVde/YE7ilHftc0p26lBmDHsw6YkifJuaAduuaRYc/+KJKoKx71oU
 a3BITDNScELBKSYQmd6si9ms4uEN62RGgQi4J94unHmFVSjyQ4oqHfREaBUuDtgRnWbV
 aozbubc7bkhGyHeImMKXgW4tMh9y3FuMF6HuzGMG5psQHCDoaWty+hm0MllJ4ZrOydCt
 k46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W/5KIcDspcCw4aMY+Mi0R66tPJCSR/ireqasuabxNoI=;
 b=dMvX2evJTkCgTIMD4Sa3RlYdjh4PP9PeXWpiOfBnFrA8hHHUVSd8wINsxrSM3D/RiN
 zF3AWkeJ9zHPYDXzuXhhQx3W8bf42GuJtrcn7j3nsPMPYMqu4MZjyMkW69uLqNGW11oN
 pwukR5VfhNZaFs0uJn+Y1Aj2YZ+fyXgOBLHksk2V5QvZX+suM/17AIpMABTJAY92Di92
 Oiw4B0bVUV3jSM5A9W/G50bk+HWIFK8iam6SqFeGMTUp1h35RvgZl1Z82f65uCvVRpry
 uyZbGhvnwWzI2rReQ3qlJ5kVQOmt2UBMv71UEiatH2U5f7pm/EGLuRCABKFRy+Q5mxYB
 TdBA==
X-Gm-Message-State: APjAAAUgEHYcIE5h+nZTBAhnu2TbR4C+vH17MR5s9mZBEhx7kCkHfQK/
 sBY1mn2VrPwyzmbb0oPHMKTing==
X-Google-Smtp-Source: APXvYqwrXm79mehfopV5eJ7n+n5IubZJTM+VtAbDL1JQKstPlUH+f1nJUJ8i5oDiNbC1ZGUUTm0i4Q==
X-Received: by 2002:a65:620a:: with SMTP id d10mr13262621pgv.8.1567178168289; 
 Fri, 30 Aug 2019 08:16:08 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b126sm17137025pfa.177.2019.08.30.08.16.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Aug 2019 08:16:07 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190830100959.26615-1-david@redhat.com>
 <20190830100959.26615-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <bf422242-735c-afec-0bd7-97d088468a70@linaro.org>
Date: Fri, 30 Aug 2019 08:16:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830100959.26615-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2 1/2] tcg: Make probe_write() return a
 pointer to the host page
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/19 3:09 AM, David Hildenbrand wrote:
> ... similar to tlb_vaddr_to_host(); however, allow access to the host
> page except when TLB_NOTDIRTY or TLB_MMIO is set.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  accel/tcg/cputlb.c      | 21 ++++++++++++++++-----
>  accel/tcg/user-exec.c   |  6 ++++--
>  include/exec/exec-all.h |  4 ++--
>  3 files changed, 22 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

