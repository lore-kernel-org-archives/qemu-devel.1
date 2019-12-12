Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD621C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73B120663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdPqTMFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73B120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifNbC-0001rD-SR
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ifNaX-0001NU-BI
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ifNaW-0007z4-9C
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:29:01 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ifNaW-0007xg-0f
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:29:00 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so2156725wmj.5
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=/aXlN+9fPn7bQz93CVI4vccAvQwML74Sri8b8UI+fmU=;
 b=gdPqTMFAvyMiOrFtbIP1y33Lcb78lnJ6P0y05Qs8tln+eoS9kDQrmlbxGojPEtGcmm
 1RFx/VDDqCNoZQXeId06weXZrSKzPGZ2zk36d3s5lLtc6KpMU4LETtRzj+66THf1Kv3E
 51kHzSm7sgEwbBMcrnm3Bo9u0IbCiLvhUcFrvFoVnbun2/fAoV1gtTxp29BmZFfp/SlZ
 kisDuWy/OoKrC6f1ntagOHoqiVCnNhDdOdkG3PT6Xs1ahjVTf+FIcxGfpe0GGJHR5UiI
 ADqnTFzmVNjIJSATTqwLu7zTMVu07a7A1syQKGegnx9d/Stxwb1LSJODphPJo6J/fUBL
 4FcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/aXlN+9fPn7bQz93CVI4vccAvQwML74Sri8b8UI+fmU=;
 b=VAXM0rtpHBV/mP6CZPo6/EMJUpjbqU++kDL45iI8mPKo6IVTPla8mdY/2YnZ6YIqyB
 MRO3seIOTQPXoOJ1Z6AHxMKkbI32qO4taUOTZt7xWMmuH3vdBQcHSiHNakMpcfGGlybw
 RP7chDQ708s+rX0FCCH4Ka9NrwoNBDNqvQYxgeLbyXU0C0hzkJAKlOaZKSq3lyLFaevu
 XfHHLeKENhj5qZph8LQ8QOzcGw4tR9GH6qHr2XLP52zBQrShO/YvgmUwV2GFyQ7LWmKA
 4JbBAAdFWHrEMHLZ13B+o5eWRMmmaRVBPb2DKniEPTkai+XA9VwwHieu+UMxyWQXvirX
 E1GA==
X-Gm-Message-State: APjAAAXCgzWZ8StUj7s6zwd7HW7772UuNTHlhpu8yi4CuZWvR6POdKad
 YaMUF3pzEqwGc1aA7dPHZf2igR/FPWU=
X-Google-Smtp-Source: APXvYqz0wXiINP1vDiZa0DEjf7/a5gB0bEYE/jPb4V17gc2IFbRPdlqpkvNt8llINdReMJGIlMEDBg==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr6311698wmi.152.1576153738265; 
 Thu, 12 Dec 2019 04:28:58 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n3sm6123039wmc.27.2019.12.12.04.28.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 04:28:57 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 634D01FF87
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 12:28:56 +0000 (GMT)
References: <20191212040039.26546-1-richard.henderson@linaro.org>
 <20191212040039.26546-12-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 11/28] accel/tcg: Include tcg.h in tcg-runtime.c
In-reply-to: <20191212040039.26546-12-richard.henderson@linaro.org>
Date: Thu, 12 Dec 2019 12:28:56 +0000
Message-ID: <87eex9bud3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Code movement in an upcoming patch will show that this file
> was implicitly depending on tcg.h being included indirectly.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/tcg-runtime.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> index 8a1e408e31..4ab2cf7f75 100644
> --- a/accel/tcg/tcg-runtime.c
> +++ b/accel/tcg/tcg-runtime.c
> @@ -30,6 +30,7 @@
>  #include "exec/tb-lookup.h"
>  #include "disas/disas.h"
>  #include "exec/log.h"
> +#include "tcg.h"
>=20=20
>  /* 32-bit helpers */


--=20
Alex Benn=C3=A9e

