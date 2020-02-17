Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F17C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E574A20578
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w0Avn/47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E574A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lhD-0005ck-PO
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lfq-0004it-VI
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lfq-0002sS-0O
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:03:18 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lfp-0002s8-RT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:03:17 -0500
Received: by mail-pg1-x542.google.com with SMTP id g3so9558154pgs.11
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lOpoGlMHmRcDqN4ZWXKlb9Ek24G1P4/qCOiUBXU8rBU=;
 b=w0Avn/47MAW+CzCV70xQpVHIlv9ArKR7lqnIwZ+hwPOKiVDZDS+QDkGcgF1t+GwN/0
 glZjvdN3MmcAMDFCPebIytKD+36Ef/lbsGrgQO9Pg5aqI1ZrgAdqtFxEth6AWcGK8EW8
 7pf3hyNH6ZDtKEYj3P1KC2t2RLLm59Q082tE4ppWr8S9V8hY5XLOSr2fHA0SFcN2XfmD
 XUNhdpBmWEvRORqHj0deeP1Vi8jP4f/2c53sDaffbMb08oJoTgy5/UnYcEJoqoDfuR0o
 xW3S955mVPtWHRUQvkXKYfMcMkW9+61W7jV0pJrv4lzTo+oyHb/9i6HWDH48hagjhp92
 EUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lOpoGlMHmRcDqN4ZWXKlb9Ek24G1P4/qCOiUBXU8rBU=;
 b=Qfyxp82t7GrYT9QHq1QEl4QnOzkN4hYG/aaWCv8W3DF3t7GuscxZ27fLX8zu521QO+
 6Jfx6g/eigJltqxROXytYQb9rCnK3TIG2S/AUQHeSjMdOZjoXl3eqwLq0a3eloqSlh1n
 +9DRRtCO3lLsaHoT+1vlfjCk2u+Rr5J1SUnTxJUTGEQDOzf+VkarFZlNxGP8WFFZznyM
 gXnan54buseIHzxHrHGwHFClPYOhJOrvgwAVWKZqQYVDFOL8cTnlZVVsvQeTEO2KozC2
 qXib5XcZHVhc451cRRGBsYCQkJMfUjWzihbDjzscCKdkSIn8526gyFBJx5/GNyYNtuPg
 6kkg==
X-Gm-Message-State: APjAAAWmJTByDswOxLjfCznM1kIlc9IEjWwnH3Xq8X1RCozZzfnbX+Ct
 TMyROsLLpLOGkK1jmUjcTLlr6A==
X-Google-Smtp-Source: APXvYqzPTyGAywbvuQ86N7ndP/mIvUkCZ30o3DnZdalwh8Tsg952gpMst38lRHJOvnDeMXBf1V48iQ==
X-Received: by 2002:a62:33c6:: with SMTP id
 z189mr17890154pfz.246.1581966196971; 
 Mon, 17 Feb 2020 11:03:16 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 d15sm1774737pgn.6.2020.02.17.11.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:03:16 -0800 (PST)
Subject: Re: [PATCH v5 23/79] arm/mps2: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-24-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07f2a0f9-092a-d450-b269-71d93b1f2091@linaro.org>
Date: Mon, 17 Feb 2020 11:03:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-24-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

On 2/17/20 9:33 AM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> PS:
>  while at it add check for user supplied RAM size and error
>  out if it mismatches board expected value.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


