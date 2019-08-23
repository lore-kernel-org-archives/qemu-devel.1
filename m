Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA22C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B36F2173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fccf4bIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B36F2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1DRX-0000P9-4X
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1DOd-0006Gd-Kp
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1DOc-0005QN-Mh
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:30:43 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41116)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1DOc-0005Py-HV
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:30:42 -0400
Received: by mail-ot1-x342.google.com with SMTP id o101so9442769ota.8
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 10:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a/1PZznsLdjjJH0BWG9qHgCgdaqy2MydQV0cqzggrB0=;
 b=Fccf4bINf5GviOwS/vCjzvJMRWWh0G6W6w49sZi/JCLAoRqzqD6my9Mx5Qzc3C/3tu
 SphqCFb3c1v+ZHWgt3ZLngagZhiqF7Oxf7YG2pdLMdJb/znIkckNt3rA3LzLivdULF0K
 r9eicWQ0Tw/yy/jXNM58PzGS9zmYNnTmlbZYsi2Quseq49/+XsQa3XF5q37fmbnLBlyx
 pukANNyFhif7sNwn//t1sDKzppcW9XytYxKku6VaJ8a3y+ISUuAsjPuNd3eypYonv5+/
 GOd1p6Jp5OSHSiuoT6lBtfIQefyAH5hg2BzSkeWuSI2pay0A8N4POFoJYcqmJCAJ3nMM
 GmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a/1PZznsLdjjJH0BWG9qHgCgdaqy2MydQV0cqzggrB0=;
 b=igzj3k8MJSwBph231FXBb21UMSPDo8JEFtyjBVJSl6TcoqO8Ae4TE+JZUlqvIT9sQs
 X4gWVsRGJ++yhngQUty77Vu+6fUr/x8UwkqWr00bnJCvZpl9yWOY8eJXe5ehl5D2/e6p
 KTRLb8eYXXGm+SyXWNBA/HqLbR9t1hFamfrJe2zBnfLcnhtjbf8ZiNmgI27PWaJdokXm
 Em+o3AkgcWJdvegsr2hEkPhiKXTuIiDTnqXFjk2uXfwPA0EPC6dDL2hRKFVeYhET68X9
 z5M9zX1rSvI5UflnjTQ6wYD9e0FNIznLc5bVY6QtqKbFQZYKIsKFxl2dvToe7YAJ/00K
 bMXQ==
X-Gm-Message-State: APjAAAUiA+4pu9mdd1ZYKkhESLJPaBAYKQuZ37cHgZmIUdk2swYGh+fI
 qUZij/M9SDt0gAGOMioPLAdTw4/K4q0x3r4+7ucBZA==
X-Google-Smtp-Source: APXvYqx0uS3lNgdUm3GXKDqEVY7+552GEFPSGvPugdlWdYmVAWCRksgx9r8RskK+6fq9e8RKBjVXJgUgww/6o/7WA3Q=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr2197839otf.97.1566581441777; 
 Fri, 23 Aug 2019 10:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-30-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 18:30:30 +0100
Message-ID: <CAFEAcA_p-FWaToeKiTW-_hBnD3-yzJpi4qm4WqD=6aRQnauD6g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 29/68] target/arm: Diagnose too few
 registers in list for LDM/STM
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This has been a TODO item for quite a while.  The minimum bit
> count for A32 and T16 is 1, and for T32 is 2.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

