Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0026C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CAD322CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ly6cLXqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAD322CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2zll-0001NW-IV
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 11:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2zjH-0007yo-ND
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2zjG-0007NF-Ae
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:19:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2zjG-0007Mj-3g
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:19:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id z11so220241wrt.4
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=cGcXZZOCaa/dul4QdYBlhFe3lUCL2IzRsHBFk/i6Z+k=;
 b=Ly6cLXqFcfKu8VoH4CFJun1KRwam+ZZ3yWVhz+80m92KylgoajC1WB4vlDDrT0dULa
 Jv7zLYrclr1+CClmgJc/JGuBKsrNNtx8Jak/RBErgtT/7FEcl1+rTV/5kFKlSaEIJE9P
 gHZLs4k19eLUSrRMwE7WhrL1B9GsbVoZUl62NSh2Sk9cW4CJDr6v9pb1ALWcpnGqvPD3
 /Om4t24ZoCJ3vF+BbGLXP6REuZoBctrmFMc4P8aE+W909nPtRlyMTLjoitP9yrW3EFrs
 XsJXzgsGCKBOQdJmyhrtIJXC/S2QTTnQqYCiIoqe9+F5utdwbu9/iSCpMIZC2TmTD4ND
 Mfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=cGcXZZOCaa/dul4QdYBlhFe3lUCL2IzRsHBFk/i6Z+k=;
 b=gfg2bwxv6rMlyzkx5YQuHtyOyCxt+zYZY8yGytpC6YtaC0lblkIsnrygtmKcay2Ywc
 pwOoEQxtIwKSusFxzpMAeRq4BhtEzx4DO6geOPOBOoAdkI0bIeDmUKqrQvLnamfxKnhW
 LLrFW20M4wP38hUHdDsWcn1DqW1m97/lk/RColUwFMrrVe6hea8MSf3nFh85mydaNx0b
 mPvEgzfk1Iqicj4wdNyxV5Z+FIlFNQTZxD08RN2PqK+m+1sVsrtBdZZ+QiJMhCQZ7tbi
 KWSN1sb7XU6HwOAmX99M9FPOFs0NozZYQ3L5lhHZG2yK4jnlOhFcBsprdfGcnNW3Hcwg
 gigA==
X-Gm-Message-State: APjAAAUNO3SPE6dHLkwOpZbVcb9ByNXqhAtZuMYh+BzD9Ycu3pZ3PupV
 sRJ1ttjN/nSu/zAPPnPHh5KhGQ==
X-Google-Smtp-Source: APXvYqwgETFhnIalvCxHkl8H15oIqRmZR4ZDsjnZfu0hbhhgvrcxmtYmncMLd7g5F065OxSozvRXUQ==
X-Received: by 2002:adf:facc:: with SMTP id a12mr5359609wrs.205.1567005560941; 
 Wed, 28 Aug 2019 08:19:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c11sm3523455wrt.25.2019.08.28.08.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 08:19:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EB09B1FF87;
 Wed, 28 Aug 2019 16:19:19 +0100 (BST)
References: <20190827140241.20818-1-marcandre.lureau@redhat.com>
 <20190827140241.20818-2-marcandre.lureau@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190827140241.20818-2-marcandre.lureau@redhat.com>
Date: Wed, 28 Aug 2019 16:19:19 +0100
Message-ID: <875zmh5nd4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: fix modules-test with no
 default machine
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
Cc: Laurent Vivier <lvivier@redhat.com>, peter.maydell@linaro.org,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?M?= =?utf-8?Q?arc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Fixes: eb062cfa733 ("tests: add module loading test")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/modules-test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tests/modules-test.c b/tests/modules-test.c
> index a8118e9042..d1a6ace218 100644
> --- a/tests/modules-test.c
> +++ b/tests/modules-test.c
> @@ -1,12 +1,14 @@
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
>
> +const char common_args[] =3D "-nodefaults -machine none";
> +
>  static void test_modules_load(const void *data)
>  {
>      QTestState *qts;
>      const char **args =3D (const char **)data;
>
> -    qts =3D qtest_init(NULL);
> +    qts =3D qtest_init(common_args);
>      qtest_module_load(qts, args[0], args[1]);
>      qtest_quit(qts);
>  }


--
Alex Benn=C3=A9e

