Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EBBC3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 15:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3374C22CE9
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 15:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfNnKVNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3374C22CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3ikf-0002nk-CI
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 11:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i3ihb-0002Cr-G4
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 11:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i3ihY-0005FK-7p
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 11:20:38 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i3ihW-0005An-BR
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 11:20:36 -0400
Received: by mail-pl1-x642.google.com with SMTP id gn20so3519601plb.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w29b21BZvW6QHFcyFYkoQK/4zWzZUtFJ4JQFViTO00g=;
 b=LfNnKVNuXabTG1/r919wi0SOEYQlKTVTLHsT6CiO7jGsvXRgUJTO+IzYFCQ1K36ne+
 RTAB3jUky2NpMRxK8xLUSOdyMMcczVoXr17/89AoQNglUwXrw+5RDVZAQVv9/uct52NN
 Yv53UaPFk+dnUoFz9iRD1wXjaF/rp3YYOnp91JeFfto5D8jBGXVWPtKhm4i/mBtzj2mp
 iT+gDzJCDL3Omj2ojmL7QCR6QPnF8g7jUfBW9qBOegbB1cEbjKctoPBd6KpZjkDPfEzr
 kbzB18HZnomDNL1eXKRgnjD3zOqr45ZMs4187BDTUGR4O0U0kAwAfr2faXPWc9fm9Qxi
 jOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w29b21BZvW6QHFcyFYkoQK/4zWzZUtFJ4JQFViTO00g=;
 b=cVfQVEbFQYkfa1EwXNr77KTIFN/+4O9mv6Uh3JWAFqOSWtQ/yYUDuLU5q1OET2jKgo
 s8zxMSVoNsVwHDqlb8WpB38yHwNnklkagadKJG23lQhEMs5jzI1ugI6N75r9mn3my1Yt
 sze2nMtB3tvLXPjnNP6te2OxY7fAUtSVfNQnxJj3IYHDqaa6T0FhRnyHK3beBySt88IJ
 LG4nhPoCgEkF/Z0yfFnYgu1Kar49FIro+eXLeFYNUSmQNi0ab+fyCZXA5tKn162jxDv4
 yyJdJbBglxCzSr8r6BUS5jHP5jzlRkGeL25N+69AbO76syMO8vD4ka/8+uXatuU40s+I
 FHKA==
X-Gm-Message-State: APjAAAXU27OmGfrttra+9gL4RC/9Qr3W4tYbWP9uZC/6u4sBgKAk4CGW
 e5NuMysNuf9mw5GTneZNgv2sUQ==
X-Google-Smtp-Source: APXvYqxnpTiZU8lmSrn4wZtUo11S2deNq5n/3iGT/7PTz5U/DF9+UVi159rCTVZk7gal3SWhwMkajg==
X-Received: by 2002:a17:902:b58d:: with SMTP id
 a13mr2102404pls.116.1567178430494; 
 Fri, 30 Aug 2019 08:20:30 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 97sm4903999pjz.12.2019.08.30.08.20.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Aug 2019 08:20:29 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190830100959.26615-1-david@redhat.com>
 <20190830100959.26615-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d77f487e-b913-3a53-1602-6011466bd2fe@linaro.org>
Date: Fri, 30 Aug 2019 08:20:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830100959.26615-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tcg: Factor out probe_write() logic
 into probe_access()
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/19 3:09 AM, David Hildenbrand wrote:
> Let's also allow to probe other access types.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  accel/tcg/cputlb.c      | 43 ++++++++++++++++++++++++++++++-----------
>  accel/tcg/user-exec.c   | 26 +++++++++++++++++++------
>  include/exec/exec-all.h |  9 +++++++--
>  3 files changed, 59 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


