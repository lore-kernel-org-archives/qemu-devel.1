Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242A1C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 22:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D996D2133F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 22:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hsZNiGPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D996D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1ebf-0000RC-0W
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 18:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1ea8-0007wg-01
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 18:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1ea7-0005g9-4D
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 18:32:23 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1ea6-0005f1-T2
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 18:32:23 -0400
Received: by mail-pf1-x441.google.com with SMTP id y9so8721914pfl.4
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2019 15:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=c1aUb8xUsccimiPHe7aU685Fp5o97wDpus55YYwsOkA=;
 b=hsZNiGPmVYlWQXjw2Alwn8z7NJajBYgK2icb/fkx2aP+ThK15QOwiBIBkvRan4aUrd
 HUMt7VRUpkWqIDjj10wlfybtQkSy2mBvKKEDUuMhe+mpWF5SBwO72E28CzwwOhdFfPIE
 TMxatsMnDSIK5xQQdWwatUPtoxoCZ5CzlqaHGUq+N1iTIsehFUVC0Wyy5LE+9H4dQM3o
 6hJKFtQfm0NLefA1CFczmQWWC3i/L6MTU1WPZAIv5atWIt+8WCTzxJ6yCYHx5HequcY4
 HKkKZgSOhENnuGWY8wgibX3OkKt0xq/mgYuHOalIKcWMPh5SluLhBzhIheCBha62CebP
 tJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c1aUb8xUsccimiPHe7aU685Fp5o97wDpus55YYwsOkA=;
 b=mhTBfL+EsTmGpyCdKvaUYQc/DKdallOTrgiUYXTuyfe3nWN0gkcnebn7T3dwZE5ppA
 OLvYkG+hH1qzTP9TOjkGdz0P+789BE3bdtKuS05ePrYH+rX4GONbO8u6mQqnHHbCQkcR
 If3w8JQiw3RBJ4ys5VkU7AsxsieYIvvz8pKg1Qis840YcKx3radYz0KLh0UAofoI1GKs
 zCGcqQpMq9C2z3fqiW492R1ck/FY6eeeQHo9MrFp03w99ZaLSF9i1JwIsmLvUljPD2qb
 eiJiIQXNk8BHoCWSENXW2jPZmAQMOxSUHI/+3BrBK7rXejImsWPUJLGlLemTDrY0Z6Qt
 HSTA==
X-Gm-Message-State: APjAAAUTHVuVUF+Q4ZQE9AoNOYLWXqM5RFguedA6RaowvlnWeU3VpJxA
 1/n0ppAHcfbYCO0006eDaA7/iw==
X-Google-Smtp-Source: APXvYqynkT1s8I4QXZy0J21ivoc/4iw9g9aWDYY9x3d+691/Mubyifzf3HjzvknqEyhI4Kuy3212nQ==
X-Received: by 2002:aa7:8753:: with SMTP id g19mr12650428pfo.249.1566685941576; 
 Sat, 24 Aug 2019 15:32:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m37sm15882246pjb.0.2019.08.24.15.32.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 24 Aug 2019 15:32:20 -0700 (PDT)
To: Tony Nguyen <tony.nguyen@bt.com>, qemu-devel@nongnu.org
References: <cover.1566588033.git.tony.nguyen@bt.com>
 <faffd619a65fdab2dfcce3c75f3cffd4178875d7.1566588034.git.tony.nguyen@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <05216e1c-e531-7efe-f4d6-56b12a136860@linaro.org>
Date: Sat, 24 Aug 2019 15:32:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <faffd619a65fdab2dfcce3c75f3cffd4178875d7.1566588034.git.tony.nguyen@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 9/9] memory: Delete memory_region_big_endian
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 12:42 PM, Tony Nguyen wrote:
> memory_region_big_endian is no longer useful now we are consistently
> using MemOp for endianness.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  memory.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


