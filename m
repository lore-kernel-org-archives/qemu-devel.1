Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F307DC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01FE20838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0hmSE4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01FE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07d3-00045O-0w
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j07c6-0002rk-N5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:40:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j07c5-0008GC-MM
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:40:22 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j07c5-0008FY-Fw
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:40:21 -0500
Received: by mail-oi1-x242.google.com with SMTP id a142so2757470oii.7
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 09:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rxbIXb7L2qbGoKJsJb7QQWU+hkl1YfO5De8xADjt6Xg=;
 b=E0hmSE4RpzRX1s0WtDudgdu0z5JuHpyfPEVfqljolFrqwdsT3QMcLupJMI5alTmz4t
 7B1uxdea6KG7hLnKjznA0NP7pcrNbyLEwOFPJgRaPVJtR4LXNPhg8BsdD4qzG25bN9Dy
 orCy391qigrsOMGcY6Pq31rcdkIy/an1ZfVq5QgksLrqMTTQZDTl0F24NCFIEg1UO5mS
 BZFwn+YC3WvVYyG5LmXZcNLEaJHrcJvfvTi2e3iba/PhPrfw8di2baWJ7bX8fqlcuQPr
 UIp21R8tvtgGQOX86633CrhTdDa0vJGa+zCwSqx+jIlYGxh2uQrgw4F53QIMVKRMi+Yl
 XT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rxbIXb7L2qbGoKJsJb7QQWU+hkl1YfO5De8xADjt6Xg=;
 b=NjIAXaxpLcBM22myiY2YtIWVSWO6GHe5FoIJiXflJesLsAq5UaAxaJFkU+oSdhmJZh
 2XdVPuJhCaFjFp8LQb1ieOVE7RPLPGyioGrSlUQCf+iwjuJoVHLaylKl85UuZHtWcA7z
 AsViCzLdJbwdyyHedxu1qt9nTqN9b8888lpkNkp4rvdxRMH5Bg8uUfPFPLC+9K9bnHyY
 AKadNn//LT7PDB7rIcAAJGLZYSAXq1hXYA8NKgRN0tbfcYO8ZZ9SIhPuMBO3xCwq4rx9
 4uSNzqCRjK6rpLNZOtgSfrlzslKPXEtXZi3iqwS+yyhlflLu3fCpG6EXHipLqRpi+bbX
 p/rA==
X-Gm-Message-State: APjAAAU7PZHp4xsWYbmEojSSOQJxP4tlmSaTYlH5hQDZOAS3UKgrG5je
 ylWczTXQtU9gPi2RrYmmXIdsBLlUIus77MjuTcfc0Q==
X-Google-Smtp-Source: APXvYqyRjlcgzR5hm48GPwjcGzMHh+psEAqHBAgLMWrrLvXvjJaIEq75oyGnMSWJy17Rnu0GlLJFkgzADUYgf/Te8Rg=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2751083oic.48.1581097220783; 
 Fri, 07 Feb 2020 09:40:20 -0800 (PST)
MIME-Version: 1.0
References: <20200203144716.32204-1-richard.henderson@linaro.org>
 <20200203144716.32204-10-richard.henderson@linaro.org>
In-Reply-To: <20200203144716.32204-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 17:40:09 +0000
Message-ID: <CAFEAcA9qhMX2xM_nX9Np4g0s=nAW6zH5Hz_HdzwBJMuiWQqxCg@mail.gmail.com>
Subject: Re: [PATCH v3 09/20] target/arm: Tidy msr_mask
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 14:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The CPSR_USER mask for IS_USER already avoids all of the RES0
> bits as per aarch32_cpsr_valid_mask.  Fix up the formatting.

CPSR_USER includes CPSR_Q and CPSR_GE, which might be RES0
depending on feature bit settings.

Diff made a bit of a mess of this patch -- I think it would
be easier to understand if the reformatting to add {} was
separate from the code change.

thanks
-- PMM

