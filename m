Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12CDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 00:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7591A206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 00:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7LNRGYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7591A206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfuR0-000058-OL
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 20:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfuPm-0007pk-F3
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:04:22 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfuPk-0000J7-U7
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:04:22 -0400
Received: by mail-pf1-x442.google.com with SMTP id 131so4175785pfv.13
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=j1M9zAXPkWvYRdEpExwmerllx1EZ1fUYeIdq+MamthA=;
 b=R7LNRGYfz8TBcBXqZd5awvoIF46r+vMjBuP6TAqhtagPnUz4LDtsmvJNVXCcABvKaH
 Oyq8ScgtN/UA6xmjdZjdqES4E3R0fterS90KuyGZeijZX0YIHB4Y9vKxpbXik0Ewho8T
 XQ0hCmhEUFnY2g+5JXqE9PG6bMttRt2xDZG0I7DEZL9ajA9u5vgsNk+FUF2/et1nkmaA
 upcVrk1nFAkt8j3T3KE9J25J/K2P6XvXzHBe36KvHxv2ALoqALh9KhqOVP4n3tIifNLz
 EBa5dufcobzW/rDUq8k6hD1bb9zGdOAUgzKC8GHAxnoLiVF065QP911P8ven2xpVo67q
 vqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j1M9zAXPkWvYRdEpExwmerllx1EZ1fUYeIdq+MamthA=;
 b=Eb5v25SkfQVK6BNFxq/HMgr8q7hqyuDsOfbHI6LsIvW+M3OlInPxr0uZxzeeA0gipz
 F8mfQtzsrZqtrFgOMulDebH90W3Vu/emkzvkZBziBuQ8R1K6UtDZYa+utuVL4XCcPIrU
 fpdS8E6O+dCMn3kiLWpvlgsvYW/XclscQkHj9L/+sw2VZUOOCs/e5jg84g/Pa9GyeEvT
 /d1CW/eeBMrGoz5G0wluCVCZXWt4P+NUXq8UT7hkJEyQdao7CpOHD8ZBmsBhiZDqr2br
 LDw47YhwL8dGZxv46eEgxCDr4+ZEaeq47TT8AEu559gjrBM3S3K98qtSZNBO+dkRA6pp
 vwqw==
X-Gm-Message-State: AOAM533WkbrI1BucdL3CEU71UJb+1RaS8XqyJUl03AE1uyNL+TLg4V8j
 5oEcl3HTfP3HlOjqFwAnBeN16Q==
X-Google-Smtp-Source: ABdhPJxv/zHbNONk0k5E8rAvIDQQ0qTNyEAT7T2sBSnhBEHMpCIZ0Y+KlPjG3WKgUx2bM+CNV+qFkQ==
X-Received: by 2002:a63:e60a:: with SMTP id g10mr22166792pgh.210.1591056258962; 
 Mon, 01 Jun 2020 17:04:18 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h7sm492258pgg.17.2020.06.01.17.04.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 17:04:18 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] exec/memory: Remove unused MemoryRegionMmio type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200601141536.15192-1-f4bug@amsat.org>
 <20200601141536.15192-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8cf677b5-75b8-a0ed-7951-44c75d9f102e@linaro.org>
Date: Mon, 1 Jun 2020 17:04:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601141536.15192-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 7:15 AM, Philippe Mathieu-Daudé wrote:
> Since commit 62a0db942dec ('memory: Remove old_mmio accessors')
> this structure is unused. Remove it.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/exec/memory.h | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



