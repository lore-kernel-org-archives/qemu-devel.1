Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DD7C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25449206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRwLMoYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25449206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSIQ-0005LV-8D
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSHj-0004pL-Kf
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSHi-0001UE-Aj
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:07:39 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSHi-0001Sx-4J
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:07:38 -0500
Received: by mail-oi1-x241.google.com with SMTP id k4so22294040oik.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RwbD3gvEWa+hMsrQyvQGMC4eF/bJwAhYBiV4S+/BsuU=;
 b=dRwLMoYDSnk5Oeg9kRsxLS2gM/YVtXjFN6QB0B05zD1YXKOE4qNTDUyfAHtcdZV2yR
 VveNXcphgf47S4eVkTzQs4KatrWOS2OSBxZdjtWNMI1vsNKNvJRJpu4jjYspbwbt/NI6
 PlwJkk7caNtvwdikWmt6GZCfRPhu8g0hgo25kS8kPVtG7NMqPykdG3HgYbGCM6iYfDGm
 YzPfJoJsAEKHnuBaVEdaODf8WQUU08Mc0Gu2hq8VIVUC+JWx+1iQrlUoB8HYd5wvcNfW
 xj3+SDi0qbmxLU40eu1+MFi8489q5CQPPYopijbKzkyfy88obbrUNi2NEVgYPDQGx+FT
 CvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RwbD3gvEWa+hMsrQyvQGMC4eF/bJwAhYBiV4S+/BsuU=;
 b=B+/yAsAliN44yNXHSiPdE/bWHLOJBFcVld5bRYj81GsxBHPyiKOn/6JZeghgzjRPJg
 +fmaSi7EJCgldBwViezEgwj0R1GUzEp6zvtp7yWS3DanIZOfsC5j7dN7yA9yOh6kHl8M
 F9t4X5plawfeQKn67cOYdBL057kimZv0PFTsGj36HIFam4GspBn/RsqjzsWjBaZ9863F
 TZ5owDFyxdIF7rbdwsPsyzKJtgfYg1XylhzDrNb3jfmxXTNIGri/LIgjde1ntFSG3nuX
 nKYNV6yxoszSllnHJl9wU2dgHcC6fK7XMNpONxAQ4zxsNQG8Z8sGzNcAebNF1bZ0bLbh
 cUHA==
X-Gm-Message-State: APjAAAWrD+FepeTzRG/4TLGR9KmBJn3g+Ko3k8gmOPXafz2oIF1OBZpi
 PbcpqQ54EetlG5ZLmu4nS0OJ/GZ9XJcAdR6EMGZDGBDgZ+A=
X-Google-Smtp-Source: APXvYqzcnA6xnHJUTN7zD+Y/Um0YD0i/IU/jrWhLIuXdM7J0XdG9QPyyy5qyxwzYaiRKbmLnylDZMjtb/dmZt8sCUxs=
X-Received: by 2002:aca:3182:: with SMTP id x124mr3579334oix.170.1579270056529; 
 Fri, 17 Jan 2020 06:07:36 -0800 (PST)
MIME-Version: 1.0
References: <20200110161626.31943-1-alex.bennee@linaro.org>
 <20200110161626.31943-3-alex.bennee@linaro.org>
In-Reply-To: <20200110161626.31943-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 14:07:25 +0000
Message-ID: <CAFEAcA9H8oNBX4QcKjSB3jFqDq==6tr392yEzJwF2Dxnw9EFcw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] tests/tcg: add a vtimer test for aarch64
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

On Fri, 10 Jan 2020 at 16:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Bug: https://bugs.launchpad.net/bugs/1859021
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/aarch64/system/vtimer.c         | 80 +++++++++++++++++++++++
>  tests/tcg/aarch64/Makefile.softmmu-target |  4 ++
>  2 files changed, 84 insertions(+)
>  create mode 100644 tests/tcg/aarch64/system/vtimer.c
>
> diff --git a/tests/tcg/aarch64/system/vtimer.c b/tests/tcg/aarch64/system=
/vtimer.c
> new file mode 100644
> index 00000000000..2f6299b5d2c
> --- /dev/null
> +++ b/tests/tcg/aarch64/system/vtimer.c
> @@ -0,0 +1,80 @@
> +/*
> + * Simple Virtual Timer Tests
> + *
> + * Note: kvm-unit-tests has a much more comprehensive exercising of
> + * the timer sub-system. However this test case can tweak _EL2 values
> + * to trigger bugs which can't be done with that.
> + *
> + * Copyright (c) 2020 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <inttypes.h>
> +#include <minilib.h>
> +
> +/* grabbed from Linux */
> +#define __stringify_1(x...) #x
> +#define __stringify(x...)   __stringify_1(x)

Code 'grabbed from Linux' is unlikely to be GPL-2-or-later...

QEMU already has a stringify() macro in compiler.h.

thanks
-- PMM

