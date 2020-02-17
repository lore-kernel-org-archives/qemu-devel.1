Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBCEC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CBEF20801
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvhrYleH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBEF20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lpt-0003bH-GS
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lpH-00035Y-Ek
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lpG-0000VD-FS
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:13:03 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lpG-0000UJ-9i
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:13:02 -0500
Received: by mail-pg1-x542.google.com with SMTP id z12so9720844pgl.4
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lOpoGlMHmRcDqN4ZWXKlb9Ek24G1P4/qCOiUBXU8rBU=;
 b=IvhrYleHAhZTtfzYRg/I1W4WxBi+fuUvaHVQok+hR9e9il0+g707TPdpxrP4mSzmS8
 095u1aSjvEYa23K4cVh7LZMElCMnVQJjJbPEQoGzdmMss0v7HTRZdqA1/awGXWjI23U3
 3jbm6PYxYdNzykHT1VcQdo0owiSeSxgJW9qmowvS5oOAXRphRsxPh4ZeYd/uWTcOq1N7
 X2penu9l0UbpHdlDLPKW49ZLXb8FFaBV29rQkGEvvrqYSFNvpw7hFMLh0L4YB5OhUGOS
 zgJVGdqnFIOF+6eP9OKltnjtLJVaAH5hp0sp5TpEtw7udaEeH0hFssuT68cUAfTx/sPl
 wYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lOpoGlMHmRcDqN4ZWXKlb9Ek24G1P4/qCOiUBXU8rBU=;
 b=qGt3aSsOgnS9I0nNkgc9WxZ3I5hgPPhsnVqw5Jff3V4XKhyITtNtQluBBkTwwqWgFp
 e2fBVwZklkTk6fUqi1bm0hCyg6kX7FC2eeSEjhfgd8TxcAvmATK9+m0vV78UNl7fdno/
 J4S/98K77ax+C1JcL/WMJEjLcXRfJ306R/ByzWgEajPcA2JBuI+XsWAeswdZPBP7az3p
 nFn4S0Ag756fgHVHiPRbJB845N824Ta0bwPRjmBhK/UDu1jNGodhHl6aP/znXdJ+gznI
 P9LbX9TVfD5jskxG4ViRvehwFnzfTrnCI99z6RtUfBJ6fQU8mq0L3WQAquk0Ot9MJWgY
 0B9w==
X-Gm-Message-State: APjAAAXbcR+S9wixLBaeN6qTymX1BuAMbXaM0SN309ymlriA+xKBUjv7
 7BgVAwLKtHNsnQOHRN7HRYUmuQ==
X-Google-Smtp-Source: APXvYqzxFvMeKYO+Kftt9b7E4LGTkZp1xC1nbFwgigrVTuJcqqj+YubfuRsZ1BCC095D9YEXZJrb6w==
X-Received: by 2002:a63:5657:: with SMTP id g23mr18519633pgm.452.1581966781066; 
 Mon, 17 Feb 2020 11:13:01 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 y10sm1218992pfq.110.2020.02.17.11.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:13:00 -0800 (PST)
Subject: Re: [PATCH v5 25/79] arm/nseries: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-26-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <942e0586-8c53-f0b3-0b7e-08c56ccf0149@linaro.org>
Date: Mon, 17 Feb 2020 11:12:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-26-imammedo@redhat.com>
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



