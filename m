Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DD8C43215
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2641F2176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kS7Fyp7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2641F2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaMmw-0002wm-Jq
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 11:37:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iaMgl-0008Bg-UQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iaMgf-00008Q-3I
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:30:39 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iaMgb-0008LE-5v
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:30:36 -0500
Received: by mail-ot1-x341.google.com with SMTP id c19so22624001otr.11
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yPEt+Nju5WcU4veBFi/Ga5jHOqhqtAro/oydEshYtiM=;
 b=kS7Fyp7iDOJxsphVx4uPCCZ6SQKHN5WxJzKywXc/bIvgucEkylxrWNNXWs4T9y9m4B
 zSGf1glua5q3mJok38ms+3X8pVgFctG7Ua1PRFmAlLcXyi2W2tjNqyRHHFNC7UCJLp0Y
 xaKtGeqhBZqncS9Lqbqu9hzZgNv+DwNxWe5bBceDx0HX3Gm6/9Aw1EsA9T8ucTTDl8pW
 WjBReBK8541aPpxPWZQVMZSLb/tV6VbMq165AUhueZY3ao4raQAFPXX18tc+cScjHKk0
 e3B4cYNa8MyuzXB6QtSZrNT1w/9xBSQ/o+mRHevLgT5p+4cNFGg5yPEbulCiSGZzsxco
 KvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yPEt+Nju5WcU4veBFi/Ga5jHOqhqtAro/oydEshYtiM=;
 b=PYDw1Txw7T51nGP+32FWFzw60h9oHyzIjh1qVld+WyK3YXGUbpe+AxKS8ySXTG+avq
 58oD1ApGxRoVgylHuFV8yGpkGlFRSz9iz+htFGYzHo696UZJCkWIH5Oj4h2XUD+6WZYf
 CPfg0MvNFKTbF7zPf5sFRV4Q6oFMUNa9aTX0Dfbp8qRRg9n6d3h0nTtNpjyI0oAYadXh
 DIgzoun1XG83uLt9Qys/Zmsz+X7h/9Rogthbi9hnkVKDOFaZgpUPidR+aSTsHZAnYlYh
 S9khOxtZ2yXm21OESTVAd7LpYkfKlFWcWYZNCWyLFiqtioYsAed1C5Y6sHLP/2uu/NNR
 PF/A==
X-Gm-Message-State: APjAAAXpSE+4jGbOyvFe7JwEnbz2tcW4UAvrq+WGgGxaOzOy+oCV9Mql
 nUdIYrOP6UY9OXfp5yVd+38JG9MccmdqQk7pmeOEKQ==
X-Google-Smtp-Source: APXvYqyRP/Ze+GcllGSIuZVG5DxUMyLWFDdLzbBxNq/abvBFlXXlvtGbw42Wz9EjTh6F/FqwCx+Db3z6E0tDKndd3Uc=
X-Received: by 2002:a9d:6353:: with SMTP id y19mr8132604otk.135.1574958616053; 
 Thu, 28 Nov 2019 08:30:16 -0800 (PST)
MIME-Version: 1.0
References: <20191128161718.24361-1-maz@kernel.org>
In-Reply-To: <20191128161718.24361-1-maz@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Nov 2019 16:30:05 +0000
Message-ID: <CAFEAcA8GvqnwfGiKHi7OgcUqUu1JL9UKTe6J77-VHMnzRpKX_A@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/arm: More HCR_EL2.TIDx fixes
To: Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 at 16:17, Marc Zyngier <maz@kernel.org> wrote:
>
> I started looking the rest of the missing TIDx handling,
> and this resulted in the following patches.
>
> There is still one thing I'm a bit puzzled by though:
>
> HCR_EL2.TID0 mandates trapping of the AArch32 JIDR
> register, but I couldn't find a trace of it in the QEMU
> code, and trying to read it seems to generate an exception.
>
> It isn't like anyone is going to miss it, but I wonder if
> it should be implemented... It could also be that I'm missing
> the obvious and that my testing is broken! ;-)

Hmm, I was under the impression that we correctly implemented
'trivial Jazelle', but we obviously missed some of it
(we do have the handling of BXJ insns).
We should, yes, ideally, have RAZ/WI implementations
of JIDR, JMCR and JOSCR.

We also I think don't get right the fiddly detail about
attempting an exception return with SPSR.J set, but that's
not worth messing about with IMHO.

thanks
-- PMM

