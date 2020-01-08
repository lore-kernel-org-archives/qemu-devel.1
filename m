Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BA6C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 19:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D2420705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 19:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HtoXFmk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D2420705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipHRd-00045l-6m
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 14:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipHQx-0003Vw-1J
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipHQv-0007WB-SF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:56:02 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipHQv-0007Uh-Eg
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 14:56:01 -0500
Received: by mail-wr1-x444.google.com with SMTP id c9so4721488wrw.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 11:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aN6VwhHZHlQAb6ucbbRptY8h66Rz3uJc1wktGsvl0/4=;
 b=HtoXFmk5S/ZJ96OcXN3Hxw+RF+n+i9OD+OHhaMLzT/3J0utzNprsiMkspm73Dd8MpG
 Od6kEUCksoSiyAxf10HIqEfpiIAoCaC1ypc7xaf2T5Yfmy6IxVyJoMDpcPEfmlLZtIU4
 imxpiHbzwmgEUXl8dYYWw22eeOt75Ij8VoaFUZHQ0BAl9IP0htT+LmL7CK54V6tusrvQ
 V6qF2JwUxCc34BYoy+AzeNBR7giHY23m8ZUbf1yFdXeGSTsNsXpGRRJozWFueCIOtbzg
 3BpH29DfQ2SYjJOC0CGQXMe+6ynTY0R56qtIkbj2mp6mqCMXslVeswKCzpj/CcpAXq1K
 L66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aN6VwhHZHlQAb6ucbbRptY8h66Rz3uJc1wktGsvl0/4=;
 b=WC7ekT4KvjaDV/IFpirQ0j6/6eYY8UU1+QJRdXlVsCIF6OV6BmiThiQtezWL3URi1j
 +3ncEe8Kb6CRteO0b5K8cicD8WRRWyNoNHuajv/vC4P1SsICwqguhUus5NjsiUEZGazp
 kge9MOqUoNQEwGM1PzXofvk5H0QTfzBRbpF2Zz5IxbNmDDjjrlPM2hBoL8IqWtRDhJeG
 wZdXpIG9mwAev1et2byD0yqhMYLB+TKs3Z7Wd3k0Z2u+oiu80wkQ6FQhvuke3zYQ487/
 QqmldMtH5EW8MFhSfA86xbzQYqsdPCb2h+7J3H37nD+zCjYv1/sE5xs2YH+8nxOVTgv/
 uAbg==
X-Gm-Message-State: APjAAAUkJiWAznr/sDyhfF8p85hTvMHYq7qNEBIPtMoj1LBYbng7qYQf
 7G/3KWL6S0IB+gYvdq24SN5ueQ==
X-Google-Smtp-Source: APXvYqyG8P+TqEzeVwY0twJnez7EC1w4zNRAOydRdmkcBlfdF3ppjjrqAjm6Jw//CLS3X1+4PMzFXg==
X-Received: by 2002:adf:9144:: with SMTP id j62mr6280580wrj.168.1578513360081; 
 Wed, 08 Jan 2020 11:56:00 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x7sm5049962wrq.41.2020.01.08.11.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 11:55:58 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3F3281FF87;
 Wed,  8 Jan 2020 19:55:58 +0000 (GMT)
References: <20200108150252.6216-1-alex.bennee@linaro.org>
 <20200108150252.6216-7-alex.bennee@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH  v3 6/6] tests/tcg: add user version of dumb-as-bricks
 semiconsole test
In-reply-to: <20200108150252.6216-7-alex.bennee@linaro.org>
Date: Wed, 08 Jan 2020 19:55:58 +0000
Message-ID: <87a76xk9ip.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 qemu-arm@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> There are linux-user users of semihosting so we'd better check things
> work for them as well.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v3
>   - include aarch64 version
> v4
>   - use common semicall.h, test thumb & arm
> ---
>  tests/tcg/arm/semiconsole.c       | 27 +++++++++++++++++++++++++++
>  tests/tcg/aarch64/Makefile.target |  7 +++++++
>  tests/tcg/arm/Makefile.target     | 19 +++++++++++++++++++
>  3 files changed, 53 insertions(+)
>  create mode 100644 tests/tcg/arm/semiconsole.c
>
> diff --git a/tests/tcg/arm/semiconsole.c b/tests/tcg/arm/semiconsole.c
> new file mode 100644
> index 00000000000..6ef0bd24500
> --- /dev/null
> +++ b/tests/tcg/arm/semiconsole.c
> @@ -0,0 +1,27 @@
> +/*
> + * linux-user semihosting console
> + *
> + * Copyright (c) 2019
> + * Written by Alex Benn=C3=A9e <alex.bennee@linaro.org>
> + *
> + * SPDX-License-Identifier: GPL-3.0-or-later
> + */
> +
> +#include <stdio.h>
> +#include <stdint.h>
> +#include "semicall.h"
> +
> +int main(void)
> +{
> +    char c;
> +
> +    printf("Semihosting Console Test\n");
> +    printf("hit X to exit:");
> +
> +    do {
> +        c =3D __semi_call(SYS_READC, 0);
> +        printf("got '%c'\n", c);
> +    } while (c !=3D 'X');
> +
> +    return 0;
> +}
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index 96d2321045a..4281c766419 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -32,4 +32,11 @@ run-plugin-semihosting-with-%:
>  		 $(call strip-plugin,$<) 2> $<.err, \
>  		"$< on $(TARGET_NAME) with $*")
>=20=20
> +AARCH64_TESTS +=3D semiconsole
> +run-semiconsole: semiconsole
> +	$(call skip-test, $<, "MANUAL ONLY")
> +
> +run-semiconsole-with-%:

this should be run-plugin-semiconsole-with-%

<snip>
> +run-semiconsole-with-%:
<snip>
> +run-semiconsole-arm-with-%:

ditto for these


--=20
Alex Benn=C3=A9e

