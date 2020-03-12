Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6891FC4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E4A20674
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKpX0AmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E4A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCPer-0000a4-D2
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 11:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCPdm-0007b8-CJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCPdg-0004fZ-QX
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:20:50 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCPdf-0004dQ-8H
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:20:48 -0400
Received: by mail-ot1-x342.google.com with SMTP id 111so6598424oth.13
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4ZLGhiOilpINsS5jE5BvE2/xx+HNELOoeEuRjTXACAo=;
 b=gKpX0AmV46SKn1TU88cy0LRAVRLazRg4OasF7bSnVzgo6C8iexp0kqITY9ypGOC822
 jLj6xsVcpS43uNefsfQFmuBiCpyHCqmCGuGkwaCblgfMuYS0XNuSEGv5sHkv1tAbMG7x
 YdNBQulp3u4u2H4PxsHuLA4X6D0sNMHHq9AHAy5f5FXb6+ZItCXDv8h7migHuFgXC7r9
 tyGukwYarIUVxg57cz0aome+UYt2Rqw+aFW8OIayN+dTbP2Pv8Pe0MsLiFS7OpOAAvPi
 KBCymGrVFKAH8QbBfnQRo1w/xQaWbV4KGHfGGHASwjAtxuw4VwHe2KaFTZSBKxvE4hn4
 FCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4ZLGhiOilpINsS5jE5BvE2/xx+HNELOoeEuRjTXACAo=;
 b=QNHyLeJ9KbZOZoeydiAMw+gtXuhqVMHM2n0hbuow5j1/e0uu2RJoSPNzGcBdbL0DRF
 j8ssHr5HjZbmm5d/wNX5OHj7o0W7d0Xa2YuTLY6xzC2+bz/maxj3Y6I4ekWKplL8hS7A
 6Zzw6PKw5q8omcgbcmNB6GEmBwl8LQiuqkf0CwQUF2Y+fxCmQnTUFMghyslhzA8fxD1l
 iY88ikjWlUom8GhUsxGXk2CSkN3lKN8BiUhzk1fuuSYxpPOUw8LbzlLZTjHBc/LpxR7O
 kGwkEQuVmFaSEspLozHq9GLykzaM1fYitLmgPMwSGw6w4IRBNFlgJjsmysasFEu+K0Ax
 B9lQ==
X-Gm-Message-State: ANhLgQ2CmSdMnxbjcXvsmv84/A/+ds35wFW+tZxCPk+Al9Y0ktZaclE0
 PTUm1uGHdzl+lFccDhoRUFFTYEDOW6lcfk2s1gPqDXkzu9o=
X-Google-Smtp-Source: ADFU+vtsyyzl3qqKjfK/m90NITjYnBCla7pn1ZBV4zItpcXU3QTjKw9IjaZnFkZ4HNL3zm23Z+Dtj9YbUq2Vwvd9Wj4=
X-Received: by 2002:a4a:dc05:: with SMTP id p5mr4445547oov.63.1584026445611;
 Thu, 12 Mar 2020 08:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200311162722.1846432-1-groug@kaod.org>
In-Reply-To: <20200311162722.1846432-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 15:20:33 +0000
Message-ID: <CAFEAcA-4muCaCOLxMm0majMtS-goUa637u8sayqPozUgWF+qDw@mail.gmail.com>
Subject: Re: [PULL 0/1] 9p patches 2020-03-10
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 16:27, Greg Kurz <groug@kaod.org> wrote:
>
> The following changes since commit 7f368aed672117980f7f09933e1eb3e1139caae6:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20200309' into staging (2020-03-09 19:49:53 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/9p-next-2020-03-10
>
> for you to fetch changes up to 659f1953281bcfa5ac217e42877d7d3c32eeea38:
>
>   9p/proxy: Fix export_flags (2020-03-10 16:12:49 +0100)
>
> ----------------------------------------------------------------
> Fix the proxy fsdev so that it honours "readonly" and "writeout".
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

