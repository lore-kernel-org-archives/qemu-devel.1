Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6029C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A176F206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3QaVdzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A176F206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgwOH-00045O-MS
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 16:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgwNX-0003TQ-9Q
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:22:19 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgwNV-000581-CB
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:22:19 -0400
Received: by mail-pj1-x1043.google.com with SMTP id q24so1718925pjd.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LDqVsxMO/Ew4Oyl1upGA18KILvEu0ZLIV+JkPJ/5hhw=;
 b=m3QaVdzysHdvc4oEJf8DMpzWX7ePqlpI+0vswD9NsLnJJY3ZqdKNDfgVfY6RbLM/Fo
 q2zWX+/VDM5V7Y1ZWCxf1nblinss6C8diGAIncxwy7jIbETOWTiG4JGpIl4MTQcNipkL
 Zi9PtziS6nAjXBssC7eP0dAaOj5VcN9dzVxKaB1gXtvVvnTqYzhwNXm5tlYdZiLGkkxV
 2tSYBldDzw+96n13kgK7qmdIfKw90yKUZhRZyuAuNHx0U222XBQVybqVwWrxva/40I3F
 +MgybQ5fNrV31RTctGOQ9QO6xq1c9ByqUAuh9LH0lCoL+NGV7H5ddlr7rTlJiu9Hv7xj
 sZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LDqVsxMO/Ew4Oyl1upGA18KILvEu0ZLIV+JkPJ/5hhw=;
 b=P1zz5uHmJugLvd05XQxRfs0DYpO9OuYcN0r1TmXeuesHZbVeAPafzRTRPgYjnIVdlO
 KmETTHrriXZPK8Kh4jkIOLx4GR4bjnUl+aH+RA4MVLh2ijsPaVH5hY/Y7FqqlTX7bDN8
 oVIT86+j9oEsGvEM0nlQDK76wLSvAf0sDkAHTWuiCC5edVH8rJ0J7Pe73ftlvdfpGfqC
 YF8JWCcyM6Z1JX2cyGeKkG9+HE8ISIRBVcY3+oKmC7kx3NcqrFmctLGi3MjqlcpC2Gzs
 a9O0s6CpVREVGdqchCmjSBsM3mW2FqQLEVOq0W+hDfgI9EKIi056Beyo+DI6hO5HNTNI
 cCDQ==
X-Gm-Message-State: AOAM532dkV5Oduruk6mL7XcfInBirbhaLq87SUPq76fXLDhgiCl/sTRi
 lI9Siz0Od9wT6eahuseX2x57sA==
X-Google-Smtp-Source: ABdhPJy/tXiqyDeoDslbMzfEVNgSPlbuH9ue/5e2XNcv9zKpO++DZ4BL4h6Xal5BR+X8qghDdlvibg==
X-Received: by 2002:a17:90a:cc18:: with SMTP id
 b24mr7906506pju.89.1591302135623; 
 Thu, 04 Jun 2020 13:22:15 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p14sm6561790pjf.32.2020.06.04.13.22.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 13:22:14 -0700 (PDT)
Subject: Re: [PATCH v8 25/62] target/riscv: vector single-width averaging add
 and subtract
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-26-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b988b684-b502-1044-0e6e-19ac8f962f7e@linaro.org>
Date: Thu, 4 Jun 2020 13:22:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521094413.10425-26-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, alistair.francis@wdc.com,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 2:43 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/helper.h                   |  17 ++++
>  target/riscv/insn32.decode              |   5 ++
>  target/riscv/insn_trans/trans_rvv.inc.c |   7 ++
>  target/riscv/vector_helper.c            | 100 ++++++++++++++++++++++++
>  4 files changed, 129 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

