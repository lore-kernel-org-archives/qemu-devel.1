Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0E1C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 20:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091DD214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 20:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNZAqSOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091DD214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS4mn-000194-4U
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 16:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS4lz-0000Qp-2C
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS4ly-00046J-Cr
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:18:06 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jS4lx-00045v-Ou
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:18:06 -0400
Received: by mail-pg1-x543.google.com with SMTP id d17so5163672pgo.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4nLYMVwdqWzcDZNSakvBh3gvehkY4Zpi0kf/RMQHkpw=;
 b=FNZAqSORpbFoOI1/TnwLtoRRmzLsJlw7TjyDrk8bP34nUrHeUN4QEu5L3CMgPUqbnv
 rJfaG406mMY/cqLlvXCoMME9DHw5WDMZHdNATSzTySmNPua+YhlcA63gslgJrGe7cGF7
 gnSEI3VwGoWCTp5W4PximV4XlZujQJ1v++3ZoX8ytPc7lzbRXcplLoTQ7alLSIrSqP2+
 5ht45GHRZHa94wYJ+kWmySco61QyWAaw6xqWlphzu5MBns9xSI0a6aKnDiMaWYqGFMmX
 w5UI21kAiDKQIUnFd3QGJRsigiIKPfXnRgfyjgmt5JQSgbbvAfQtDkm4NaFCViKd2ouC
 8OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4nLYMVwdqWzcDZNSakvBh3gvehkY4Zpi0kf/RMQHkpw=;
 b=uHvXxfhQNhbTGYXt+l3OKa6+9n8VGRWn8mYzypGlrxJLuuL52e9ToH5MWrufCg50yM
 NHNsTamjyhAIjC1G8OrAAdeedf4cjCyJ6tUzOd8IyqNt04H412wZCWA/RuHH/MxiT1Di
 xHQcAxNLvuafxc6kPuSbzOaaXYTM21BZ7LFwrrQ5Qf687takCuzTVneEOwGUyTtxNIxC
 kFjOV1vwyQ9lu8Ly+bHcep+xEz1KLS3oa3BMkPDoAB/oB2ULPEZx051TIgiJyAPxsni3
 SZ7nqYVEvN6yMRl6jBV8aWaeyYBRqULHNrwn/b6NnvSs7LTKc3xSzMILc20JMaZlfv87
 A+gA==
X-Gm-Message-State: AGi0PuZKb5uXTkSy8psdDxuDJ8Bawg9qFmoIdZqEOhtiynv2CNDmow5I
 jh78eAN/nJFFFAev2r8/cskALA==
X-Google-Smtp-Source: APiQypJtnVtBsQ89xWVu75dn0b4/Mrv5UPq9d1UcB4s7UOJXw/fR4oAbxhHDAAoEe9zVJYqhrcsGnQ==
X-Received: by 2002:a63:f849:: with SMTP id v9mr6360244pgj.395.1587759484004; 
 Fri, 24 Apr 2020 13:18:04 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id a2sm5336380pja.44.2020.04.24.13.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2020 13:18:03 -0700 (PDT)
Subject: Re: [PATCH RFC] target/arm: Implement SVE2 gather load insns
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200422152343.12493-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de85dea9-439b-8de1-8f96-af38851f0d6b@linaro.org>
Date: Fri, 24 Apr 2020 13:18:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422152343.12493-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 8:23 AM, Stephen Long wrote:
> Add decoding logic for SVE2 64-bit/32-bit gather non-temporal load
> insns.
> 
> 64-bit
> * LDNT1SB
> * LDNT1B (vector plus scalar)
> * LDNT1SH
> * LDNT1H (vector plus scalar)
> * LDNT1SW
> * LDNT1W (vector plus scalar)
> * LDNT1D (vector plus scalar)
> 
> 32-bit
> * LDNT1SB
> * LDNT1B (vector plus scalar)
> * LDNT1SH
> * LDNT1H (vector plus scalar)
> * LDNT1W (vector plus scalar)
> 
> Signed-off-by: Stephen Long <steplong@quicinc.com>
> 
> I'm not sure I'm initializing xs correctly. This also goes for the
> scatter store insns in the previous patch.

You did.  xs=0 is 32-bit unsigned offset, xs=1 is 32-bit signed offset
(directly from the SVE encoding); I repurpose xs=2 as 64-bit offset.  There's a
comment in there next to the load/store helper array to that effect.

> ---
>  target/arm/sve.decode      | 11 +++++++++++
>  target/arm/translate-sve.c |  8 ++++++++
>  2 files changed, 19 insertions(+)

Applied to my SVE2 branch.  Thanks!


r~

