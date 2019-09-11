Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD71C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 22:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935D82054F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 22:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0p/+bW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935D82054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Ajs-0008VQ-OC
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 18:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8AiW-0007xj-Id
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 18:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8AiV-0002F1-3S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 18:04:00 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b]:45551)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8AiU-0002Ed-VU
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 18:03:59 -0400
Received: by mail-qt1-x82b.google.com with SMTP id r15so27240788qtn.12
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=B11fCxFSF+GDBYGDuQmnKLsVf1WAgMZ5jqiZbj7z3WM=;
 b=i0p/+bW/jVBlFnmlPQ2p10TEvsE7yJTEI/lbMkInFLn3wi+Y8JUVwmB5R1yP2vheCV
 olKjlOgZjTX4rDWrbg1auzU5aAFRQ3Kl6soYVaIDrYcI9oQC+hHXJ504s1az9WaxhDuD
 x8Jr8Z8Trjg9jXWPURjBNxdg/lwxKO9Kh4fN3j+5tcBBdVO5yoLG+WXJBmWYgSy2Xhma
 p6ipbhsanwZmqin7ksv19o1gVU+0WskWlWMWJQXW0W2L/lVReAMkqUeVMmVQH3fBRDF3
 rCfKwGsigipCIG6bcEZilTFX+0M1F2HRj5MFNQKcr0T6yyb/8IUJdC8z8C7VM6UYddRx
 OAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B11fCxFSF+GDBYGDuQmnKLsVf1WAgMZ5jqiZbj7z3WM=;
 b=gvSxDVeaREdiuyMx8J+PqIFch8ccIXoLjrkxZQjjD++s6C3QZZWYGRTAMo1NVgv9Vv
 upFFGebkVjsUEtC+1uJJpEnuJIirNxm6mEDbxtCPx8/YYd3dqgsp9pnHvxh39XtKQrWr
 2CcOEhYOGZwBms6Jet6x6lIOViMI+zNT05KrU1JNO1tHnwBBL/uoRcSusgEPgS+5S2rn
 7lZtzBRQpqhQOFNvfhxBLF+z3Ncy6iKpn2XbPZBQzKqPZSc7kIUKCn6ZZrGba29FtNzb
 Pgyh7+fiRigO/HDYnyLM38wlzIE0+C9LuOUg4m+X3QNI/jldlvRPFrVMBCTShmClRM5F
 L/cQ==
X-Gm-Message-State: APjAAAWDixTjQB84jb0+C1kppNuR5A5C2UZl7Q6FuVnSghoAn2NgnwgS
 AuyX3d65MK+DVycjZ8vmLst9tg==
X-Google-Smtp-Source: APXvYqzMImJb7ck4NSCC0Wx1pZboe4F3/K3VOtQTV8MLhMXznCE/XEGfqpohpXg9AbghB2GO9D/68A==
X-Received: by 2002:aed:22cc:: with SMTP id q12mr38967214qtc.232.1568239438093; 
 Wed, 11 Sep 2019 15:03:58 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id y58sm6094246qta.1.2019.09.11.15.03.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 15:03:57 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-17-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9d620f0d-fa1d-9f28-3e0e-235109e7d81d@linaro.org>
Date: Wed, 11 Sep 2019 18:03:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-17-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82b
Subject: Re: [Qemu-devel] [PATCH v2 16/28] s390x/tcg: Fault-safe memmove
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
> +static void access_memmove_idx(CPUS390XState *env, vaddr dest, vaddr src,
> +                               int size, int dest_idx, int src_idx,
> +                               uintptr_t ra)
> +{
> +    S390Access srca = access_prepare_idx(env, src, size, MMU_DATA_LOAD, src_idx,
> +                                         ra);
> +    S390Access desta = access_prepare_idx(env, dest, size, MMU_DATA_STORE,
> +                                          dest_idx, ra);

I was just thinking that it might be worth passing in these Access structures.
 It seems that usually we wind up computing them in several locations.

Hoisting it up it would make MVC look like

    midx = cpu_mmu_index(env);
    srca = access_prepare_idx(env, src, size, LOAD, midx, ra);
    dsta = access_prepare_idx(env, dst, size, STORE, midx, ra);

    if (dst == src + 1) {
        uint8_t x = access_get_byte(env, &srca, 0, ra);
        access_memset(env, &dsta, x, size, ra);
    } else if (!is_destructive_overlap(env, dst, src, size)) {
        access_memmove(env, &dsta, &srca, size, ra);
    } else {
        // byte by byte loop, but still need srca, dsta.
    }

which seems even More Correct, since the current access_memset path does not
check for read watchpoints or faults on all of [src, src+size-1].


r~

