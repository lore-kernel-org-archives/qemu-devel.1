Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B9AC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 20:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3EA205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 20:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xqNjicZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3EA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUFRM-00083U-5c
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 16:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUFPT-0007BG-70
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUFP3-000367-QO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:03:50 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUFP3-00030x-Ap
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:03:25 -0400
Received: by mail-pf1-x441.google.com with SMTP id x2so396554pfx.7
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=t6W0xpswfKO91t23QzCn98B2ph5OrwBwXLSGQ0Ysfqg=;
 b=xqNjicZw7kQKcAy55uglOviatHMigMcaRjiRzO3rOj9r0rV7wy6B6CdQ1kH5ddUcNG
 KER1kIpH9iHePq1GsaLCcq1QMANZz636wQdx3E0prxB+bb9Soa2tCXAxMm1ajvbf1KIc
 JWZHPxKGzZ5v1dw94/HHFmDEA4hjGFtN4QTg4Ux6LGocbCR0+JDRYhCUxFQuz8klLCr8
 SMcOPlloRkkGiLY8Wl1ul/ECPE6D/KQ/xLYgKdvPeKqISPqTP6tvoRtQlnlJyafeWUrX
 EkSk6ibOMUPDLtajDRODAxsWpcWaqHRgyznUIRKBYs0J+TyX+zcrQZy2yuyK5NwccrYF
 n3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t6W0xpswfKO91t23QzCn98B2ph5OrwBwXLSGQ0Ysfqg=;
 b=EW9QDQWCFhTyCzWUE7XPgUKi5waV5FthDP36vfSV2SjmsCYSBNV5tJswJd0TuO2j0x
 7U+PHLphxrSEgWry5a9B7/U5+vGXAalL0hOseprfp2np92vo/s0SCHZ6zaZw9fMObTrD
 zBPLTZS2vqqygJqABRUaab2J6VtMElWvcKq5dFiZL/EPzPVav63QrZ/wcE2/DZB0x4SG
 CryVwMwpsXGs5N4NeoYL0vBhZYgtP8SIF6oRzD5gEsQW7G8hsYkCAw0pgjhelc98UFqC
 aVPRoFgzbunHMPEZVCKy8MBK/xFven4w3NdOSuyX1L/WxLaAdHjBdgE6XFVeHCH0pF7J
 UwAA==
X-Gm-Message-State: AGi0PuaHtd5LKkYN9DawhUfS/LjWM1JhqId+SPeT2vjTw1xVD1fUuIzO
 D0urgu4phaB3glXgoOZFOHf7wv7v3i8=
X-Google-Smtp-Source: APiQypKgksjLKXY4xr9TO1mJGUXAxG298xCviDkMKJAE7fcEBGJl098jv2HVkRTrHRANkAGAsieNxA==
X-Received: by 2002:aa7:82c9:: with SMTP id f9mr444634pfn.258.1588277003238;
 Thu, 30 Apr 2020 13:03:23 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id a22sm494864pga.28.2020.04.30.13.03.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 13:03:22 -0700 (PDT)
Subject: Re: [PATCH 20/36] target/arm: Convert Neon 3-reg-same
 VQRDMLAH/VQRDMLSH to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-21-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b20ac6bb-d507-79d1-82dc-b009b20ca13b@linaro.org>
Date: Thu, 30 Apr 2020 13:03:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::441
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 11:09 AM, Peter Maydell wrote:
> Convert the Neon VQRDMLAH and VQRDMLSH insns in the 3-reg-same group
> to decodetree.  These don't use do_3same() because they want to
> operate on VFP double registers, whose offsets are different from the
> neon_reg_offset() calculations do_3same does.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 57 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 36 ++-------------------
>  target/arm/neon-dp.decode       |  3 ++
>  3 files changed, 62 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

