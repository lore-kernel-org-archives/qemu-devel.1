Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150EAC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 16:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A742063A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 16:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLV1U+M0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A742063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWjzK-0005Zx-Vv
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 11:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWjyd-0005Ax-FJ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWjyc-0004e3-IS
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:34:11 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWjyc-0004dn-CO
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:34:10 -0500
Received: by mail-ot1-x341.google.com with SMTP id n23so15018996otr.13
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 08:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2B9tWy0GLdIW3J+/caXyhVxyGmwaeAldNAVANDfG224=;
 b=NLV1U+M0IukqXPCOTq40m8cgUh+FmymMBL3zSb7/2hs7Sykxvaet0U0S+fnZDUSnuJ
 zVu5FAKLlEdlxF0yPTSlDiWC1UTr9J8sLBv5oik6Ooq3LaYRbAW9A+wqzbrQZtF5kgmr
 45NvTtu76Ujxl8SdtEAfDzhbieBXRRw9F9K8Tf6943gQc0x/IeTXvw8G9DYmK95vLQzJ
 WrC19ROy5z5HwgIE1glB4tQgfNW+07eG/mZgTdJyF5DVo8oqCxgIRvhTzq8tbxlSZoPH
 OuYa84usAAj5nmQH6xax2xZL/1OvMHq2nS79aMHwon2ou9/beREziT6Z9OpD/D0w/3kW
 z/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2B9tWy0GLdIW3J+/caXyhVxyGmwaeAldNAVANDfG224=;
 b=tkxKnexHXMQCr9aur7F1T3+l+fM8L56w0qEm/V9wUq54pZiOe/ucSPnAbeibURBWFZ
 4j6muhwAjE/xwSbIIrIXNyTyIBpJXDnY54RWkD/ehSdcdJ5/hG9pZckucO0ucrgrHx+/
 eis7PK0gg98j7FcDhea36Ojk3MF0zmZLfssFhCSZnEYRamySpR60Tgj2nZaFpWfkWxcg
 +fnBqlm2/WgAxwSEhRkZ6bCumylvPdvZuiDk3YNJCe14YWIUrNdSRW6LJL2HpH81pLa7
 WrwIBhpS8ulsSfgdOQwUX2N8/06agM3ZzQMZr/bn1dDdiog8v/FniRjteWBU/bNU181V
 wmuQ==
X-Gm-Message-State: APjAAAUGaG8FtejmPVdwjPZl1OWwWsTuflS0ZBFOctPBWowYOZGT0Hre
 S+yg5H60N0NtQgFBKRDBq4CxCapS1B1uCST+9rgS1w==
X-Google-Smtp-Source: APXvYqz+vjPO+7FQYTxujAGIT7CNqNhKxEOAznWTEdtYg0iVJKbhJUs1rcrvwoBRgDRGlUhy4xEuhBsXvV+oTcj0MPw=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr138241otg.232.1574094849730; 
 Mon, 18 Nov 2019 08:34:09 -0800 (PST)
MIME-Version: 1.0
References: <1573830705-14579-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <20191115154925.GD2859@toto>
In-Reply-To: <20191115154925.GD2859@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 16:33:58 +0000
Message-ID: <CAFEAcA94hOoT=a9A9JwzNO-9xuEZO84RShFxkMC1i0PO0dp4cQ@mail.gmail.com>
Subject: Re: [PATCH v6] ssi: xilinx_spips: Skip spi bus update for a few
 register writes
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 at 15:49, Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
>
> On Fri, Nov 15, 2019 at 08:41:45PM +0530, Sai Pavan Boddu wrote:
> > A few configuration register writes need not update the spi bus state, so just
> > return after the register write.
> >
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> > Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>
>
>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Applied to target-arm.next for 4.2, thanks.

-- PMM

