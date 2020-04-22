Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220F5C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2CA2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Myb7vrRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2CA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRISk-0003wt-11
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRIRt-0002wG-LL
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRIRt-0000nF-00
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:42:09 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jRIRs-0000jB-Ef
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:42:08 -0400
Received: by mail-pf1-x444.google.com with SMTP id x77so1386706pfc.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 09:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4vUvFaUSrdPMIJvLsS9HqHtNdnLVoK8IeRuxUZ/s17E=;
 b=Myb7vrRr3EsGGpi7aPF3R/bfKs57WvUR0XzdFgXxz3x20DpgFZSzH7PSLcDKLkgloZ
 EtCBfWAbT5CULytZ6XSPcoRYuIh1VYSzMi654Sy/GKVjzBySoh22+DxMaDRdlVH+DHUe
 rJMByBVpLTduZ3w/uaf2YN2IHgZ1HTCFQxLslbMHuLLz8D+lGZPitMNo/1Vwf83NxxxC
 CxXL/k+FEkioXparhcqny+CrdS5CfdXDjztoQfsThK7kSEj3RQNigzZfMxl+Zgh9LQ5I
 GDCllOQjNQh2djuqmeZUnoZGWduWB1f0YmjnYJ5bQAQJC5Reg2LMnd1JYvZODHlMIeJ5
 l/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4vUvFaUSrdPMIJvLsS9HqHtNdnLVoK8IeRuxUZ/s17E=;
 b=Ym6pnyQGlWsxv2gvkcLFfqFt/Ms44THsk9+hTVQaqC2eXFs1ZtJdBgZqb56zAlUb5j
 jbq2J4jA6iaZReNNUn9G2JqN7RzjhYNN6qqgbKDJUqRBjLZ/UFFcTk8dQJbTg5tMddyg
 Q0ug0pXnVmywQv/R0GkVfS7q0Y15D+/+n7M/18yVPiWa3ji3cCM1UOnrvCYiZ9Ea7fHN
 WGdXBIyKjRoFGSmD0e7UqwzpSknayeWQsA27VPOpcBv/laGqyXq6sOWhcRj6P6ff0ZcY
 wjhmdFlK4sbdpH/Rt7JpKGR+JIf77LTuXiPlp6u3zwh4fWqby6hpUA5uWp6PvvE1VKkQ
 3SZA==
X-Gm-Message-State: AGi0Puahz3mhV6eB3N8YXe/e5SSxZ0bqPafni89oZBKThEFoAmYw2ILM
 DTLdE3z3RmTFUBtPChgomN9ahA==
X-Google-Smtp-Source: APiQypJ2BA1vRYh9DAonCreyqa48gAR6XG70FVvVZhXGZ0g9+ZNj/7G4L25kVjsDSz6954MO47EU4g==
X-Received: by 2002:a63:1566:: with SMTP id 38mr28432171pgv.355.1587573726686; 
 Wed, 22 Apr 2020 09:42:06 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id z7sm5830149pff.47.2020.04.22.09.42.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 09:42:05 -0700 (PDT)
Subject: Re: [PATCH v2] target/arm: Implement SVE2 FMMLA
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200422141516.7977-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <399f890b-8265-2a82-f9de-ab1d7b95f6cc@linaro.org>
Date: Wed, 22 Apr 2020 09:42:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422141516.7977-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::444
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

On 4/22/20 7:15 AM, Stephen Long wrote:
> Signed-off-by: Stephen Long <steplong@quicinc.com>
> 
> I'm guessing endianness doesn't matter because we are writing to the
> corresponding 32-bit/64-bit in the destination register.
> ---
>  target/arm/cpu.h           | 10 +++++++++
>  target/arm/helper-sve.h    |  3 +++
>  target/arm/sve.decode      |  4 ++++
>  target/arm/sve_helper.c    | 44 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 29 +++++++++++++++++++++++++
>  5 files changed, 90 insertions(+)

Endianness does matter for 32-bit, as we are writing into a host-endian 64-bit
quantity.  I was being over-brief in my earlier reply.


> +        TYPE p0, p1, results[4];                                            \
> +                                                                            \
> +        /* i = 0, j = 0 */                                                  \
> +        p0 = MUL(n00, m00, status);                                         \
> +        p1 = MUL(n01, m01, status);                                         \
> +        results[0] = ADD(a[0], ADD(p0, p1, status), status);                \
> +                                                                            \
> +        /* i = 0, j = 1 */                                                  \
> +        p0 = MUL(n00, m10, status);                                         \
> +        p1 = MUL(n01, m11, status);                                         \
> +        results[1] = ADD(a[1], ADD(p0, p1, status), status);                \
> +                                                                            \
> +        /* i = 1, j = 0 */                                                  \
> +        p0 = MUL(n10, m00, status);                                         \
> +        p1 = MUL(n11, m01, status);                                         \
> +        results[2] = ADD(a[2], ADD(p0, p1, status), status);                \
> +                                                                            \
> +        /* i = 1, j = 1 */                                                  \
> +        p0 = MUL(n10, m10, status);                                         \
> +        p1 = MUL(n11, m11, status);                                         \
> +        results[3] = ADD(a[3], ADD(p0, p1, status), status);                \
> +                                                                            \
> +        memcpy(d, results, sizeof(TYPE) * 4);                               \

There's no need for the result array -- we have already read the inputs, so we
can write back the result straight away.


r~

