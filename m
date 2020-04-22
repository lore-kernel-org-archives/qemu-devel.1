Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0901BC38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 03:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC68206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 03:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DW8/eRZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC68206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR5yC-0000hB-Sf
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 23:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR5xL-0008Iz-VD
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 23:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR5xK-0007bc-Jx
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 23:21:47 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR5xK-0007YK-1H
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 23:21:46 -0400
Received: by mail-pf1-x443.google.com with SMTP id b8so353562pfp.8
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 20:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LSac1QTTZ7wQ13jD7Q3AfAMsMClaAbzuB0bS+btyUWU=;
 b=DW8/eRZEZ4nt32RLrKX7qPNcMCRqyCj6btPdFGUqVNSz+/XdjPd/B/EWKP4gdBzgli
 kZajsfCFmLWh65jCxbC90zzlUqJ6apW7Vj61XhjS7YnXfoQ1h/LfAKwvQZgAfHhoI2bA
 sGkZnQRp8EhtPsyU26j65pum+nx7rCl1vEZKsyjK4Uv4yfU3BumNLnRasNZ0lmuNlwhN
 kj0iyK+XrQxjmtfia5LEzD271wSg1SrQdOl6BIYJOb96YsAqjANE9yOowEDiZr2bPm0f
 iQ7SELmN+Crq1817qC7R5grm+Tw+geEIOzai0mUFd95EJpktBx/Tn3jb8AIL7rx0z24y
 BBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LSac1QTTZ7wQ13jD7Q3AfAMsMClaAbzuB0bS+btyUWU=;
 b=hEVmiE6CGC5Oh0ZRmtUW+LJ1W3JnRD1mf5/XbTKsuwL7ryoEX+B55KoiE1kYpfNrmP
 0poIu6JzNWYyZRzTK7W95zxQDdVF9gUxrY8bVTon+TZZ2+wYEk6LTa3TIviG2KMLmwQN
 2o9Rf8zxrW68DjdLszzP54C6eHubGcU3yDFxeuGkFaxhLEmKcY2iFVyMFDQsyiPBcWF2
 xwHsXmBvrFRVnlFYn3BhBCw7hxItVWRUgRbXke6v110khR2zXnmyrk7wTmWmbw1qreY+
 H9XK/dujY53DnO+ZBSTiKcw77SseGYZDZNef4pEyLbna7pUat7rJicM+DWjnU1pVjI+F
 2Sww==
X-Gm-Message-State: AGi0Pua1VrraKUrMjXCRFjKTVe1pV6WkaJMUhCv1kkdz/uBWCfrSRCxs
 u6z21rYgdQwFUuZiemS1I5pKuQ==
X-Google-Smtp-Source: APiQypJNW3KkfK/pVMT/d8WYPPf7MiUtBzhvktMtOoOqjFAU3Vqk4DuPaqnhttFJZtsrSzCU3IBqpg==
X-Received: by 2002:a62:2506:: with SMTP id l6mr23854953pfl.184.1587525704080; 
 Tue, 21 Apr 2020 20:21:44 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 1sm3828470pjc.32.2020.04.21.20.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 20:21:43 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Implement SVE2 FMMLA
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200420151044.12186-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d6e4b681-751f-cc36-0453-38db6635c227@linaro.org>
Date: Tue, 21 Apr 2020 20:21:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420151044.12186-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::443
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

On 4/20/20 8:10 AM, Stephen Long wrote:
> +#define DO_FP_MATRIX_MUL(NAME, TYPE, H)                                     \
> +void HELPER(NAME)(void *vd, void *va, void *vn, void *vm,                   \
> +                     void *status, uint32_t desc)                           \
> +{                                                                           \
> +    intptr_t s, i, j;                                                       \
> +    intptr_t opr_sz = simd_oprsz(desc) / (sizeof(TYPE) >> 2);               \
> +                                                                            \
> +    for (s = 0; s < opr_sz; ++s) {                                          \
> +        TYPE *n = vn + s * (sizeof(TYPE) >> 2);                             \
> +        TYPE *m = vm + s * (sizeof(TYPE) >> 2);                             \
> +        TYPE *a = va + s * (sizeof(TYPE) >> 2);                             \
> +        TYPE *d = vd + s * (sizeof(TYPE) >> 2);                             \
> +                                                                            \
> +        for (i = 0; i < 1; ++i) {                                           \
> +            for (j = 0; j < 1; ++j) {                                       \
> +                TYPE addend = a[H(2*i + j)];                                \
> +                                                                            \
> +                TYPE nn0 = n[H(2*i)];                                       \
> +                TYPE mm0 = m[H(2*j)];                                       \
> +                TYPE prod0 = TYPE##_mul(nn0, mm0, status);                  \
> +                                                                            \
> +                TYPE nn1 = n[H4(2*i + 1)];                                  \
> +                TYPE mm1 = m[H4(2*j + 1)];                                  \
> +                TYPE prod1 = TYPE##_mul(nn1, mm1, status);                  \
> +                                                                            \
> +                TYPE sum = TYPE##_add(prod0, prod1, status);                \
> +                d[H(2*i + j)] = TYPE##_add(sum, addend, status);            \
> +            }                                                               \
> +        }                                                                   \

This has a read-after-write problem, when D overlaps any of the inputs.  You
need to read all of the inputs before writing anything.

It might be easiest to just unroll these two inner loops:

    TYPE n00 = n[0], n01 = n[1], n10 = n[2], n11 = n[3];
    TYPE m00 = m[0], m01 = m[1], m10 = m[2], m11 = m[3];
    TYPE p0, p1;

    // i = 0, j = 0
    p0 = mul(n00, m00, status);
    p1 = mul(n01, m01, status);
    a[0] = add(a[0], add(p0, p1, status), status);

    // i = 0, j = 1
    p0 = mul(n00, m10, status);
    p1 = mul(n01, m11, status);
    a[1] = add(a[1], add(p0, p1, status), status);
    ...



r~

