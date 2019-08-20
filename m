Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F81C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA5E22DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxOBVL/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA5E22DA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39297 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i06gq-0003Pb-Nh
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i06fT-0001mG-8j
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i06fR-0003Gj-Tp
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:07:30 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i06fR-0003G4-NW
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:07:29 -0400
Received: by mail-ot1-x344.google.com with SMTP id j7so5521355ota.9
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v12VnDYdjo5ioJ04KkdklVuOuXeScNdl+4v4TtfkkmU=;
 b=gxOBVL/j1EWjQT3xMmwpzMiD/XMYrj0PlFB9dLZvP1qFEZlN/RBdbomkyqSVsCsTM3
 A0ebdbvX50BxjqH1udMGmKNqjgjQ5uaBIwVGkho/JnvLvP1aSZJqunZr08tqQhuFqsnN
 AdYeZx5rLaAW20VRpm7zdBinGHes675l+TamnLbvhdrDS8TiyfEwib9jSN+phsXC/xYg
 oG9kTstyHa0751jvqWIYfymsIZ50R4AsO/t5H8YhfOc5oSkckTQWmXGHZI9uSIXN6ZDN
 YYdaoIN718qwxBRch/omV3SvMVVOaDDcZ9SkPHIj1g5insmL//cMwd5QOColQczglDab
 XPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v12VnDYdjo5ioJ04KkdklVuOuXeScNdl+4v4TtfkkmU=;
 b=gsaMNIk+lQKPLuZFm214kDzy4OTfYhaHFLh3zz2HUGhpciJZwksrfAHwzOR5erraz2
 iVGZ41DSnMIY/t3Yt2jzyzUjQ2eDDlkKF2e0KEfy1RUVziEX9RmIY5An1QL/RqgL3MeE
 kcHbli7HIZv8LsOVFkUla4Azjm//QhW7UXOkk4zF9RSJjdewvN0sukTm/3AuYXhUXmOb
 oKykO+AN9MnzFbs5evqBYjgkbYg4iae1RCiqG6CRtcGiITiPmVwaNKoMXldPMq5TFLQO
 IR8L0rCK7YaIjRg4uAuZCnT+Ej/F8m/mpKT3HOZHn5zGgfJZ4FMM/CDZ2q61hsE/d2lS
 j8Zw==
X-Gm-Message-State: APjAAAV9W+WkxCH0xXFmZiTC3nf7RAVV0HZ4TvmMLqeOa5V6lWAuWIYA
 CakizSuVINg1EUSfu3hAppVsxyGRXtrWo7JWg4wmpg==
X-Google-Smtp-Source: APXvYqzLtPVtKiKrfsW1G7hbsk2Lvr2a6T/G14TQ0oL2ukaMY6Y+YmsswRvfgMrODTSF4svNRJ4UKNuMCwDbtytMx/w=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr18311446otp.232.1566317248726; 
 Tue, 20 Aug 2019 09:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190803210803.5701-1-richard.henderson@linaro.org>
 <20190803210803.5701-5-richard.henderson@linaro.org>
 <CAFEAcA-_gMkE-0kA=xyUyNKxeqX0n6B-9i_7132xfFXQNRqb6w@mail.gmail.com>
 <7c739082-c1d5-ad03-0020-9776cf08694a@linaro.org>
In-Reply-To: <7c739082-c1d5-ad03-0020-9776cf08694a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2019 17:07:17 +0100
Message-ID: <CAFEAcA9mpXFLsbgJBm0wbfdMapa+605KZ8U=8RFQ94LVDbmGsg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v7 4/6] include/elf: Add defines related to
 GNU property notes for AArch64
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Aug 2019 at 16:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/20/19 8:39 AM, Peter Maydell wrote:
> > On Sat, 3 Aug 2019 at 22:08, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> These are all of the defines required to parse
> >> GNU_PROPERTY_AARCH64_FEATURE_1_AND, copied from binutils.
> >> Other missing defines related to other GNU program headers
> >> and notes are elided for now.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >
> > What's the authoritative source for these definitions? I
> > tried looking in glibc, binutils and the kernel without
> > any luck.
>
> Presumably the true "authoritative" source is an ARM document, but I don't have
> that handy.
>
> For binutils, the defines are in include/elf/common.h:
>
> https://sourceware.org/git/?p=binutils-gdb.git;a=blob_plain;f=include/elf/common.h;hb=HEAD

Thanks.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

