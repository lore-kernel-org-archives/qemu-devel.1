Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AAFC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 02:57:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3DB206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 02:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ETbNO1iP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3DB206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR5ZR-0002f1-4K
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 22:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR5Ya-0001o4-S7
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 22:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR5YR-0007fm-N5
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 22:56:12 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:42033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR5YR-0007WM-1z
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 22:56:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id v2so333520plp.9
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 19:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=czzqj7vu5BMsF7L+JiAZg+a4gqFb+cpUNZ+P9HRtzjU=;
 b=ETbNO1iPLwlbb7wgP1fsDn9PJID6/CR3RHfZvjPFCgP2bC9T1rF0Se2MksIZcCJt1/
 OKN81CxC5cjKWVECMYIrmJ4Nb40VzWP0Ctui7PHHKWdiJAgEscCOloKrBdvidZQuncq1
 D5F3xSVbufg9lGJLSBJc7I1jcZy7T1RUQwETltR3uXMpuRr1oCTXqkozU8s3PHUKYJ0e
 d1XdLZBsLsr1TQJbrxG9ArbDdcO40dGtCiAaNYBvu3nAYIae+RTBUdIP1PT0tWKkp2ru
 nsGXUQd8Swxe4MQKRQcqAIIZSbnMtdn3zRYU1Lez3m98uPkEFXIvz87X+YE6xcDYSRbK
 nptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=czzqj7vu5BMsF7L+JiAZg+a4gqFb+cpUNZ+P9HRtzjU=;
 b=RQh/7YgaM94J8AzZRpPBM0P4XeGxX3QvsWMFszGnVb3qEeOdotSy15lajn1OH/cjjh
 telcg7aH/xm0sm/XediserLHTZK+0obsMbP1QrTNvaSUeS8j50i6nOQeDugTmVr8QMTb
 TKVMa2i3hjqCDcfyIcQtM/T/h0KfgVi+bfapGjt/HfP58zD3AusfDxniBiVRzRPblC3Z
 cnjpHrhPT9wF2nOa2LCxM75knRYpno49OaLkPrT9C/Ke0R4HCDz3ub7jVfvBe4t3+rFe
 4cgGodakk2Rj509+1aoTrowIQsUZcCm501FxqTKy6GnPL9Y6lcnDK5WXZXvl1FSTGwwI
 JbMQ==
X-Gm-Message-State: AGi0PuYG38sz+qiYODjKahLQAyoCeupqsLTo+CzeBLj21pROWUmywLoh
 5ZvWJ8phR6S/IvimtxWcspTBwg==
X-Google-Smtp-Source: APiQypKSsd0UZtbBRG3cz+TDswVUeRG863ggNmIlzOMcQdEpBaI52Ju9GsP00thabn8h8H4ajNOPJQ==
X-Received: by 2002:a17:902:7c97:: with SMTP id
 y23mr216555pll.231.1587524160911; 
 Tue, 21 Apr 2020 19:56:00 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id l22sm3533250pjq.15.2020.04.21.19.55.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 19:56:00 -0700 (PDT)
Subject: Re: [PATCH for-5.1 00/31] target/arm: SVE2, part 1
To: LIU Zhiwei <liuzwnan@163.com>, qemu-devel@nongnu.org
References: <20200326230838.31112-1-richard.henderson@linaro.org>
 <eb7eea48-ecb8-f64d-83cd-66463a61d5a6@163.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <13d106bc-19ef-2be4-eb44-dc49fb5f1271@linaro.org>
Date: Tue, 21 Apr 2020 19:55:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <eb7eea48-ecb8-f64d-83cd-66463a61d5a6@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::62c
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
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/21/20 7:51 PM, LIU Zhiwei wrote:
> I find BF16 is included in the ISA.  Will you extend  the softfpu in this patch
> set?

I will do that eventually, but probably not part of the first full SVE2 patch set.

There are several optional extensions to SVE2, of which BF16 is one.  But BF16
also requires changes to the normal FPU as well, and Arm requires SVE and FPU
be in sync.


r~

