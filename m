Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D99C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180832073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEPYYDwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180832073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEEl-0003Zn-W6
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUE0h-0006Zf-NQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUE0h-0003yh-C0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:34:11 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUE0g-0003y3-NK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:34:10 -0400
Received: by mail-pj1-x1044.google.com with SMTP id hi11so1100013pjb.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=VcbUvPE2ZRGVxOI9OKFnd+iEsBgZpafMiZ3wjH3hb2M=;
 b=bEPYYDwoiVye06OX1TGQatE2OMvpVGSRCJscL7kfn06WEv3cVeJHoq4syk2bn8MLGd
 ioOnCv3ERqh+2BxCJ2GBVk3N1eWvtbHm9nm86aDQVBPNiqchzjKzBIWe03V8Dd7Tepbc
 1Qmc2QuNd6QPM4Qrid4dOFkq5ozrGaNn3Orgt9xTSqF9fiCzabm6Q/z7Wd4NbTVZWQRI
 YPtpgCotmLkpwc+sLJ/+B1JZP4/jWdzLlIUGZxPc8J41MAE4KZrZLecMR0OO07s4vhli
 lSZW0qe6vXVlguLQ2S+TniOnjoN1UXd9Cc+HNMP3ZlI+M4ZhFeJOMDQjLEOjuyNoaebY
 lRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VcbUvPE2ZRGVxOI9OKFnd+iEsBgZpafMiZ3wjH3hb2M=;
 b=orbY+FFHk1fRn0zqoUoCHyigrXTjvyRc7MmCPBXK06SZkx0+DtFdhwu/w+Hf9iX0Et
 YTQkKilp4PIYUd9/GWAONEAeSD7nnBnXaSTR+ezA9430d2hZKzMjbdSvqfBvKhTNGMJf
 5pnZYPhXFmUhUyQ8AkL1RZlrHDehsUJoQNPR2U+IQ9pIIRRVeozLUEmEMrkkBd9riLyW
 8PUInUxZlLoaFUsYbzbCsKC3nLGxntdJylQ/cIl6sarkmNmwq/x8pSMJS2irQtx+wDSW
 +aevAaiWK+FOyBaCKhwdGsNG8erXPh6oSLvWpybE5O9v+G3Etd91SbnGq6VqeoUIgnUs
 1Srg==
X-Gm-Message-State: AGi0PuZXVvev5j2s/fsfqrmtOAwertHfkZ0jz6KNKcRegRW1HNPSne7i
 WMwTyXLIMTGLgfhpwHMUlIZq5SewIhA=
X-Google-Smtp-Source: APiQypLIdyNIAqooeTxG+T0z72SPl9T4oLfjTPp9L12dUqcmRLaL0eggIBWW+E7sCgCZuV62o6G5QA==
X-Received: by 2002:a17:902:a511:: with SMTP id
 s17mr326117plq.33.1588271648833; 
 Thu, 30 Apr 2020 11:34:08 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id c15sm405544pfo.188.2020.04.30.11.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 11:34:07 -0700 (PDT)
Subject: Re: [PATCH 04/36] target/arm: Convert VCMLA (vector) to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <074d5df9-8373-95a8-10a6-138327dd0ae1@linaro.org>
Date: Thu, 30 Apr 2020 11:34:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1044
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
> Convert the VCMLA (vector) insns in the 3same extension group to
> decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 37 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 11 +---------
>  target/arm/neon-shared.decode   | 11 ++++++++++
>  3 files changed, 49 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

