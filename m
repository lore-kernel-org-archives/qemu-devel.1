Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EAFC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CAD8206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEQnx1fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAD8206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZxT-0001yP-MA
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1Zwg-00018j-Eg
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1Zwf-0007WM-I7
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:07:38 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1Zwf-0007VW-DV
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:07:37 -0500
Received: by mail-ot1-x344.google.com with SMTP id 66so11020754otd.9
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o6xl5QrjZf7PJIyJc+0wVh21NPuHG2hoAdk1fUt7wjM=;
 b=dEQnx1fzZ7RHdDznYPj5+B88hDph4HO7v07z+8qlp7/23DJFl6J8zGR+thwEd1msZu
 hX7USy8W7JwvRdX1Lyu7zGe2jQN7ebhRELKQxXlIKL1RtzYhM4qLSVznWw75sNQRp5Hl
 AEE0mqoNl8qPQaj0SVRIX5MuoicWINZJD1Cyul+aqpmgEe7/EjQ0FSJnIf4B97dikBYQ
 /I/KPFaTnFeEJJzadvlBA++KoKi+/CjsWXaXW/tpNfX1wuQPD78yysaOOPOjJ/KCgs8d
 GiC/EjoUO+r40LJnjgzq63dc2tw4q4JP1MIyMwGeOOetiaVPrY+sAbAod6caTStwDe3x
 J+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o6xl5QrjZf7PJIyJc+0wVh21NPuHG2hoAdk1fUt7wjM=;
 b=sRbINJHOa5B3/EUkoXTv1dobyg0HUxDadF/gmknYfSaNNOIkJkuHCfE3OEPzOF5sWr
 SXS0PzL/3Ak3ZZQqJjbO/e7gdA9DKPWx8QB/PPYORyvFLFYI4znGQLkdOm1JgIYlme1d
 gY1qgEXrQKnI4HRPkiwC0ik8yzk4wc8yVzKOszrmLBaT3qYC5yNFS+ml61yJEaG+Js+k
 1TjTB5pexvlfeTMemRr2k578Qi5na2obfilRjLcf3fwYjDTaZ+vX1C+80bvQ0gVzM8Pq
 81GMn6IGmvhptc4ZAUH97/aR73BqLsAOjhS3TJnuYShIeiQLNF47785CVKBFYQQ2zzPQ
 PIXQ==
X-Gm-Message-State: APjAAAWvjF0oBn1PAbOxJ/JntCBDOp/mBXxmCs/UOEnwp3Z9ltbtBMp0
 EtWieLtqSFAZEjBTLRTd7hSFiBeFHQDJxSoTAw37KUjC
X-Google-Smtp-Source: APXvYqzIjVgLTjkP7MX1rsRQS164lNLMBIJ4uPSeqr5Khz0whVSXypc0rgaiwgwLD+NOMk6LsV+/qGyBKkUw000n6po=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr6295921ota.232.1581444456619; 
 Tue, 11 Feb 2020 10:07:36 -0800 (PST)
MIME-Version: 1.0
References: <20200208125816.14954-1-richard.henderson@linaro.org>
 <20200208125816.14954-7-richard.henderson@linaro.org>
In-Reply-To: <20200208125816.14954-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 18:07:25 +0000
Message-ID: <CAFEAcA81ADjmtAZF5C30XixTzD+aBpXV6V+oWBvoSktr68sa4w@mail.gmail.com>
Subject: Re: [PATCH v4 06/20] target/arm: Mask CPSR_J when Jazelle is not
 enabled
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

On Sat, 8 Feb 2020 at 12:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The J bit signals Jazelle mode, and so of course is RES0
> when the feature is not enabled.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v4: Split out from aarch32_cpsr_valid_mask creation in previous patch.
> ---
>  target/arm/internals.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

