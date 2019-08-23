Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114CFC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D061220578
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DjR//lLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D061220578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BCM-0006ZB-2I
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1AxF-0006C1-V8
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1AxC-0008VE-Hq
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:54:16 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1AxC-0008Ux-Bb
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:54:14 -0400
Received: by mail-oi1-x241.google.com with SMTP id h21so7200360oie.7
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 07:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S9BWm8rALYi1vE1HhrquHz4J4gBYtALXVa0h9Tsi0uk=;
 b=DjR//lLJwOiOMeHMk8xSdZJbZFEM7Bxaw1/Hvsmc3dDyw1d6SMGRzfmgD/FZTFGP8J
 RU3GkRsWCS8naajUENGqwyJ5aoFoBBnRgQaY5ci0xl6hbzSpKQsK026E63EPun3XC05l
 bF9JyW17rYHGCoa5RVB4YnFShdp4fNFHAP8sYKys7dnggxGCB45BRIgfO3XkpRnuib1L
 n3EqJTYZV6wm+OmDqjj/AG+WHCx7yHsCwFvKcIV1ko4lM4+kGhEtQWhMBZbZZ1V/sAP4
 H4ebatXU1lwrtZYVYIhG6ddJy4QnNrNKjNfsK1jfp69WdYog+iUM2Qwe4198RQwM2npG
 vtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S9BWm8rALYi1vE1HhrquHz4J4gBYtALXVa0h9Tsi0uk=;
 b=s7qjrZjotcZMGBJpwfnZzTMaIaI2qenixXagUekVi42CuO0sA19SD3ey2ezsAKOtmB
 R39wcqdT15sXhAL6Q61i0YdHtJfhl7ZU6HvjHIBEESJ/9OLgWi1xk7Pshd9NfUK+h1q0
 HIrHNDwBF1Q/dCQqdLZbZ2A6Gf7njxvmbqofe7eUGs77YqxaxK5BTll3lBwUermdlvmh
 r7I+dHZ6dcZt92eSRA8/bAx0JXZUSYtsqTlVkYimOISJcqhYu3rvsv8RMNcHNhhe65zz
 cJ/HnSFGFF13lHD2gl1POlzl0p4G5HM+1jHuLdPK18u+PPFzQT4xZVEdvaXr4ehLsXgO
 xQhA==
X-Gm-Message-State: APjAAAW+H5QrhC0EXv/7j/83GVPujDONoEa1Dqj6UJM1ChHMHQVmeeUN
 1BVrqsAAdJHlhP6R6qCIa6H2g6iM35m+zkvgAZGu24K9
X-Google-Smtp-Source: APXvYqy1GiDc6NFJMzbD1y9OZdYbV+XNCLPalwNwNZch8q4KGiXkG+j51blMjFXeDgbw03l6aw18r2TXbLZrWDFMHxE=
X-Received: by 2002:aca:4a57:: with SMTP id x84mr3488992oia.170.1566572053734; 
 Fri, 23 Aug 2019 07:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-21-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 15:54:03 +0100
Message-ID: <CAFEAcA85Ojy2u_G6frO_KL-kmTVCfpcOxsW5CCuKr=eKPcm+KQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2 20/68] target/arm: Convert load/store
 (register, immediate, literal)
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 797 ++++++++++++++++++-----------------------
>  target/arm/a32.decode  | 120 +++++++
>  target/arm/t32.decode  | 141 ++++++++
>  3 files changed, 615 insertions(+), 443 deletions(-)

This one is brutal to review. I got through review of all the
decode file patterns but got bogged down when I started looking
at the .c file changes... I might come back to it alter.

thanks
-- PMM

