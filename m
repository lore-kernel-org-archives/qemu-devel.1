Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EA0C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B0C206CB
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvfIy4Mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B0C206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiMLp-0000gV-70
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 12:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMJV-0006DG-LS
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMJT-0005Bv-Pa
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:43:45 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiMJR-0005A4-Ux
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:43:42 -0500
Received: by mail-wr1-x441.google.com with SMTP id c14so10197600wrn.7
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 09:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=yB9IQuYz07MCV0Az7FbUVXmejdcr3lwjZDauA26qX7k=;
 b=uvfIy4MuooKgk+NkSq1oTflkpwHryYZ32z0dXCkn/Ont4+5Z89McWnPoJw+43NJD/R
 5eC18/XJ+dFpbQsPWZUjlLP0UnwkOJ/i/hCg7vJUD1/V3yLv+W+7Wp4+V4wceHmPIw/j
 McR6Ybim80cWK2KzgXLLZ7si1XaeoKob8xPrfeC1GlIPNrn9rcOym05fxSbTqIkUbzDT
 B6BJfZtvf34Av9MiwqlIlRDf/joA9xkRJQm+XvtixAtgrbejb+p6yxNV+AwDfZXRHsmK
 hpaDY+BjbIBtzwaNzYA0iQYrMumJGEh1fTSTvaY39FFDNtcZ88thg5XwQoxK5fAqY1lJ
 CkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yB9IQuYz07MCV0Az7FbUVXmejdcr3lwjZDauA26qX7k=;
 b=rSG0nw9MinKHtuMJz9iRk3VDZZLRaA9CXjv0r8J5VDSQDQje5jHVveWiw0rS6o28lc
 5B18sZd+8IVrB/UA6kr7yKn13K81MVQrG70sNhneFsZ2xUCe/POKLOnuUFG4C73RO2bg
 t1IhYeMyB7qqmyfW5oNsgTUapSA17hBa6sKcEmL9D4v9oVKhw8Iby32QcnqyL1xgsCRI
 KmmshshOlCXvw1PmRPUThvWh2K3ptkY4pwHbuJiOgRGMLPc5MH2h7s5XqHcT4PsJLrdo
 gfmKAfNqS1KyKx6Iyh/6ZcwpNaKXuWbeYtWd+GLS/erD197bcrn1EZxzEItEz18HmPnV
 ZIug==
X-Gm-Message-State: APjAAAWLc+5+SWQZb1M/7P9EMDtTRwTn0CkGft11vzSwiDa6j6q0gG1q
 lSQgfAjHxnD6Jp1sEwAmI2wLwnCs3b4=
X-Google-Smtp-Source: APXvYqxAqxGSxu02ULMkM47WduCG+2AYD2FtB7B0uTwkOxt0suYEsw0z7aPhTkzZHTULP9YlME6mFQ==
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr16906626wrw.126.1576863819316; 
 Fri, 20 Dec 2019 09:43:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y20sm9892994wmi.25.2019.12.20.09.43.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 09:43:38 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 904601FF87
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 17:43:37 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-13-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/28] linux-user: Include tcg.h in syscall.c
In-reply-to: <20191216221158.29572-13-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 17:43:37 +0000
Message-ID: <87fthedh9y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
>  linux-user/syscall.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 171c0caef3..34825f15bf 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -115,6 +115,7 @@
>  #include "user/syscall-trace.h"
>  #include "qapi/error.h"
>  #include "fd-trans.h"
> +#include "tcg.h"
>=20=20
>  #ifndef CLONE_IO
>  #define CLONE_IO                0x80000000      /* Clone io context */


--=20
Alex Benn=C3=A9e

