Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3809AC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EA52080C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFwVaBuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EA52080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htG0d-00006n-Bd
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60999)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htFyw-00079d-83
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htFyv-00087O-8F
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:39:18 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htFyv-000878-2T
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:39:17 -0400
Received: by mail-pg1-x544.google.com with SMTP id d1so1862973pgp.4
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jb1RohQfgDw/SREiDrJTgxWl7QQbLAGgWDY2vKene1g=;
 b=qFwVaBuulqqxmpkf3E0ohZ3wyJATI5KP9mAvgPehGS3D6GaT1/mRCv5hIYHTrcUzGW
 4fcY+k6SSli3UWGROd4RpihV8thaJpjoPoRhx38EZVBJ02Tz228KirQ6/zhr+Lfvqmdu
 cfnu7WD9F0evyqaBBxS8N3qW7J8h219FVOF901EIVwAJdB0AOhoDN0DDEPbYNyktV9P8
 PLdxRbPiil67sU31P4leBmcVn5wYxKiGSjPMdwLvygoh2tRQlwiLXvxC6ik7rXMUrNrO
 VuJUX4/F/PrToELKsanSvq03kgDgRAUrCwQo3VgeWCXC8sXwqEt1/77EjglAXI8YWpBu
 AKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jb1RohQfgDw/SREiDrJTgxWl7QQbLAGgWDY2vKene1g=;
 b=HAwV4im52jBqVR09fRaf8gO64StkuE0hCLLt3sKnIV1sTlCgyjsv+/+KzuKsl2dxoi
 iO7cGoCjSxDjdOfveTrkbbXPipZKR6eqWxHKMB3agkP3EOotOXIUEPCErn7hKkAzLAG2
 jpBeA8EnsTwlFS8HhUmuLHb2SIHY98ne+3/6oheUjE3VxAr+9AtCu/2B1z/VT0dhbXci
 bH2akVScSEq4lecld2124zYTOAKTNI544lbUfE484QemKjDcxcH1H0qNhZj3pHilL2gz
 mVE2Omu2WFMBTBExGzFofxZDOl0ZpuPbqB5IpujY1v/2aNi39VnLj04crO5kc25yIRQt
 LjPQ==
X-Gm-Message-State: APjAAAV8sylyabdc4cpXGeNyiKy4TolKR+3q9wGAPCK+sNkgor+viRzi
 H21XKnMMfwr13xptC0dAjWnjbw==
X-Google-Smtp-Source: APXvYqymPz+PJfRgC0xVqkgVatPOpscZKmCt+18nyeGbU91KV4Q7MvyQag4Oj+ROkyNWy+So1YIqIg==
X-Received: by 2002:a63:b46:: with SMTP id a6mr111849500pgl.235.1564684755870; 
 Thu, 01 Aug 2019 11:39:15 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q126sm78373347pfq.123.2019.08.01.11.39.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 11:39:15 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-30-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <78cbdf47-ec9e-ed36-4eb4-7f9c5559bb49@linaro.org>
Date: Thu, 1 Aug 2019 11:39:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-30-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v4 29/54] plugin-gen: add plugin_insn_append
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
Cc: bobby.prani@gmail.com, cota@braap.org, aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> By adding it to plugin-gen's header file, we can export is as
> an inline, since tcg.h is included in the header (we need tcg_ctx).
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> [AJB: use g_byte_array]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - use g_byte_array
> ---
>  include/exec/plugin-gen.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


