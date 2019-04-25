Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBE3C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B3F20717
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kh+U6duD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B3F20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58153 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJf5a-0002d7-7T
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:11:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJebb-0001fx-18
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJebZ-0005Xt-J9
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:40:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJebZ-0005XS-CK
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:40:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id t17so30353187wrw.13
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=vNrtGYqXRRycy1nGxhXqfe4y3esdBzo1SOP7hSbtBrw=;
	b=Kh+U6duDDKBofV5P/zyA+2M0mMGfB10eJQeiG+9uH8HQW+q3ahEopjm5v2yVjsB6EH
	4zT7GwZpkbaA/uUV++bQ6jSXn1RgEFArjggMAxuhi1yYt/sejSwbmWL3hkSQIh5Ylfc+
	7Te7pvQX58l3INj2dUD4hw91bimIkb745p284aZNtdxENs4P04ygul7gD3aXYlQoqsIo
	v1N3fiWpvL8BjUP520mKhN7jmR73/XfsTZm3eHiK7ebL6YUBsb24+F/C4QpEKI4RQGUs
	gZMSCRjfSU6GCJJpgHsuG4T3Kg1rnyzK0brx0EhxY8drZPmC6IG1XsVo+Tt4JpvhJZVG
	3kUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=vNrtGYqXRRycy1nGxhXqfe4y3esdBzo1SOP7hSbtBrw=;
	b=JzoFg9bgcw02uWqk/jMyXBK5HAXPLoxhZGdVkOijsnCKlh//1eYOoM0TaNNLNrIEnp
	ixVB4Oum45MKI6OTYt1CMy2S1hIFFNhs/3sGZLkt6xrva2Qy7ftfkxA1+ukBu9iPLgn/
	L0+02V4vJq80iPb4QlvJcMtUOKwzQsXP/RWaG6OjfXfKDv8YaLnogV6/CL2MyhN0tZmt
	7KNe9TAAQnV/dRDkfRTfrMyvoF8fu12AH3QUc+dhgzESZq2kV8b/qywOgsumsKFqby1m
	eQZ2HXof+7fQnXt4tu+R0BkBcPFOFqLNwPEjPOkh0hUTn5dwXC1jAIUUud4gHyufLUKJ
	sFrA==
X-Gm-Message-State: APjAAAVTZkFmTcjPUjWUvWOkr9VCpfMcjthNfrhYWHxFqyVddN55wDrp
	kF3/V0BQZaW9wVcrvkq34PNKjA==
X-Google-Smtp-Source: APXvYqxfxSahnJQLL1/iyFrbX2J5985Z1TdAgNUEkBGBnEdvzUWRkbv4mci6a151B+otHgF0R3iHFg==
X-Received: by 2002:adf:e683:: with SMTP id r3mr26824011wrm.286.1556199600263; 
	Thu, 25 Apr 2019 06:40:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b8sm20967562wrf.21.2019.04.25.06.39.59
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:39:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 4FF031FF87;
	Thu, 25 Apr 2019 14:39:59 +0100 (BST)
References: <20190408182748.1238-1-jan.bobek@gmail.com>
	<20190408182748.1238-3-jan.bobek@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190408182748.1238-3-jan.bobek@gmail.com>
Date: Thu, 25 Apr 2019 14:39:59 +0100
Message-ID: <8736m6w6ds.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RISU PATCH 2/5] risu_i386: move reginfo-related
 code to risu_reginfo_i386.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425133959.hKUszPw7UJoF21PFAShBEOejMaq-Le1YLDgF_CZszE8@z>


Jan Bobek <jan.bobek@gmail.com> writes:

> In order to build risu successfully for i386, we need files
> risu_reginfo_i386.{h,c}; this patch adds the latter by extracting the
> relevant code from risu_i386.c.
>
> This patch is pure code motion; no functional changes were made.
>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  risu_i386.c         | 54 -----------------------------------
>  risu_reginfo_i386.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 54 deletions(-)
>  create mode 100644 risu_reginfo_i386.c
>
> diff --git a/risu_i386.c b/risu_i386.c
> index 6798a78..2d2f325 100644
> --- a/risu_i386.c
> +++ b/risu_i386.c
> @@ -33,43 +33,6 @@ void advance_pc(void *vuc)
>      uc->uc_mcontext.gregs[REG_EIP] +=3D 2;
>  }
>
> -static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
> -{
> -    int i;
> -    for (i =3D 0; i < NGREG; i++) {
> -        switch (i) {
> -        case REG_ESP:
> -        case REG_UESP:
> -        case REG_GS:
> -        case REG_FS:
> -        case REG_ES:
> -        case REG_DS:
> -        case REG_TRAPNO:
> -        case REG_EFL:
> -            /* Don't store these registers as it results in mismatches.
> -             * In particular valgrind has different values for some
> -             * segment registers, and they're boring anyway.
> -             * We really shouldn't be ignoring EFL but valgrind doesn't
> -             * seem to set it right and I don't care to investigate.
> -             */
> -            ri->gregs[i] =3D 0xDEADBEEF;
> -            break;
> -        case REG_EIP:
> -            /* Store the offset from the start of the test image */
> -            ri->gregs[i] =3D uc->uc_mcontext.gregs[i] - image_start_addr=
ess;
> -            break;
> -        default:
> -            ri->gregs[i] =3D uc->uc_mcontext.gregs[i];
> -            break;
> -        }
> -    }
> -    /* x86 insns aren't 32 bit but we're not really testing x86 so
> -     * this is just to distinguish 'do compare' from 'stop'
> -     */
> -    ri->faulting_insn =3D *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
> -}
> -
> -
>  int send_register_info(int sock, void *uc)
>  {
>      struct reginfo ri;
> @@ -100,23 +63,6 @@ int recv_and_compare_register_info(int sock, void *uc)
>      return resp;
>  }
>
> -static char *regname[] =3D {
> -    "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
> -    "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
> -    "CS", "EFL", "UESP", "SS", 0
> -};
> -
> -static void dump_reginfo(struct reginfo *ri)
> -{
> -    int i;
> -    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
> -    for (i =3D 0; i < NGREG; i++) {
> -        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
> -                ri->gregs[i]);
> -    }
> -}
> -
> -
>  /* Print a useful report on the status of the last comparison
>   * done in recv_and_compare_register_info(). This is called on
>   * exit, so need not restrict itself to signal-safe functions.
> diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
> new file mode 100644
> index 0000000..e8d671f
> --- /dev/null
> +++ b/risu_reginfo_i386.c
> @@ -0,0 +1,68 @@
> +/***********************************************************************=
********
> + * Copyright (c) 2010 Linaro Limited
> + * All rights reserved. This program and the accompanying materials
> + * are made available under the terms of the Eclipse Public License v1.0
> + * which accompanies this distribution, and is available at
> + * http://www.eclipse.org/legal/epl-v10.html
> + *
> + * Contributors:
> + *     Peter Maydell (Linaro) - initial implementation
> + ***********************************************************************=
*******/
> +
> +#include <stdio.h>
> +#include <ucontext.h>
> +
> +#include "risu.h"
> +#include "risu_reginfo_i386.h"
> +
> +static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
> +{
> +    int i;
> +    for (i =3D 0; i < NGREG; i++) {
> +        switch (i) {
> +        case REG_ESP:
> +        case REG_UESP:
> +        case REG_GS:
> +        case REG_FS:
> +        case REG_ES:
> +        case REG_DS:
> +        case REG_TRAPNO:
> +        case REG_EFL:
> +            /* Don't store these registers as it results in mismatches.
> +             * In particular valgrind has different values for some
> +             * segment registers, and they're boring anyway.
> +             * We really shouldn't be ignoring EFL but valgrind doesn't
> +             * seem to set it right and I don't care to investigate.
> +             */
> +            ri->gregs[i] =3D 0xDEADBEEF;
> +            break;
> +        case REG_EIP:
> +            /* Store the offset from the start of the test image */
> +            ri->gregs[i] =3D uc->uc_mcontext.gregs[i] - image_start_addr=
ess;
> +            break;
> +        default:
> +            ri->gregs[i] =3D uc->uc_mcontext.gregs[i];
> +            break;
> +        }
> +    }
> +    /* x86 insns aren't 32 bit but we're not really testing x86 so
> +     * this is just to distinguish 'do compare' from 'stop'
> +     */
> +    ri->faulting_insn =3D *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
> +}
> +
> +static char *regname[] =3D {
> +    "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
> +    "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
> +    "CS", "EFL", "UESP", "SS", 0
> +};
> +
> +static void dump_reginfo(struct reginfo *ri)
> +{
> +    int i;
> +    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
> +    for (i =3D 0; i < NGREG; i++) {
> +        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
> +                ri->gregs[i]);
> +    }
> +}


--
Alex Benn=C3=A9e

