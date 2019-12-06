Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35B4C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F2E2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMTgyLwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F2E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIFe-0005Eb-Cr
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1idHg1-0005m7-Tt
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1idHg0-0004JN-QC
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:46:01 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1idHg0-0004Gw-CV
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:46:00 -0500
Received: by mail-pg1-x543.google.com with SMTP id l24so3655718pgk.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 09:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+fTMpWPBwCKpCqV8qO6kMVlUDHWzwdoLpiyq66XcwJY=;
 b=SMTgyLwGgqmK5Lm16vV4iVIS9Sk0krw+MFRSBO+zlMkAZCYLbXBHOe0lsacOUxbmBk
 7DL9LjtmKxIb45jq3ai8hgSRFVbVx+5Q3bjlE8OPAZi6OKi3rTRs7Or6Bhyi2UvF4Ax2
 PHYHioQltXcdwXXBLwPAnoo/xVywvZJXuRXsPRl3uYPCh5ITFgb9HIoy+cgG2E20XXMw
 enyLxaGx4Ls+relyVAArpS4sjQkwRmKKkPFofzkNy0nf5GRWItC+6qAW/oSjHNBvz5Pj
 LK3TRoGRf4mh5C/EMtOlEDR3bwWur2jO0VHX2U6H3DFc+BA4fCb2UzcKCgOCUwzcRqEl
 PZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+fTMpWPBwCKpCqV8qO6kMVlUDHWzwdoLpiyq66XcwJY=;
 b=UJGjeVvpIIgL2g7MNn6RAPxtJp3de0PnisaLnEHficPNSebvV2WmMBuCbXLGBZ7gOK
 jWu1zRqONrj+G00iLwlTj/tEd0OgSo7HDlo7isORf7GrBPlCppA9vyyHRKm+bxWC27Xs
 FgVLIGEppx7oW9EqEvsmbk+VDf/jXi3LgJviJ6+GC09ImUiAOwSMfoHYJuUN7Y/Mf/sX
 xRVnDxZgAEHdCXOZL7r5L0gOre4jctO53pth0Xqi1mMpGI+5drYIDlTbuh0TsujOhVa3
 FMJyPskkRlFn4PMWfIGCmV3OPmVSNlMyWiYSQTObyPj965t6UU+6/2PN4uZM2e181Ttv
 aG0g==
X-Gm-Message-State: APjAAAWmiDIJVyPXH6aGqjGTqoCz/SkJcwVb/+LFNRpbjs61TGPc5507
 3kDuIg709UrzpPApMWoTZhgpIQ==
X-Google-Smtp-Source: APXvYqxWsL2vak7Zwd+GIlARGws6peo2c7aLHPenXpKWPsIGxl1JgY13+9ySoDyOIQu2NEE8PeIlbg==
X-Received: by 2002:a63:4f54:: with SMTP id p20mr4807336pgl.246.1575654358388; 
 Fri, 06 Dec 2019 09:45:58 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 136sm15746431pgg.74.2019.12.06.09.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 09:45:57 -0800 (PST)
Subject: Re: [PATCH v2 3/5] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
To: Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <maz@kernel.org>
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-4-maz@kernel.org>
 <CAFEAcA_YGBXY4X5KYE_xny1bYtP1fKefT+VubmNYbe8TxdwBOw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a13fdd7-9ee8-4b1b-5740-9b6d9488fe9b@linaro.org>
Date: Fri, 6 Dec 2019 09:45:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_YGBXY4X5KYE_xny1bYtP1fKefT+VubmNYbe8TxdwBOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 6:08 AM, Peter Maydell wrote:
>>  DEF_HELPER_FLAGS_3(autdb, TCG_CALL_NO_WG, i64, env, i64, i64)
>>  DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
>>  DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
>> +
>> +DEF_HELPER_3(check_hcr_el2_trap, void, env, i32, i32)
> 
> This has to be in helper.h, not helper-a64.h, otherwise
> the arm-softmmu target won't build. helper-a64.h is for
> helper functions which only exist in the aarch64 binary.

Oh, while we're at it,

  DEF_HELPER_FLAGS_3(..., TCG_CALL_NO_WG, ...)

The helper does not modify tcg globals (on successful return).
It does read globals (via the exception path), and of course it has side
effects (the exception).


r~

