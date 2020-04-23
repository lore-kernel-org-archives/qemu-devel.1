Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25052C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BDF2076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie5BKlxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BDF2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRbb1-0005SL-2R
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 09:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jRbaN-0004uI-Oj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jRbaJ-0002ce-MA
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:08:11 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jRbaJ-0002ZT-9U; Thu, 23 Apr 2020 09:08:07 -0400
Received: by mail-il1-x144.google.com with SMTP id t12so5423640ile.9;
 Thu, 23 Apr 2020 06:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=izWOxLMJjKKCnsghAObjTqVGDsbWvFY0EQ2g9sbVDxk=;
 b=Ie5BKlxXQRs99oIr9v3g7SL6OBw+Q958VLMxta5lVxEfLG+paNjp6tQzOUHWKGgsxP
 0VPUFvuJkVjmUqx5EkGUunFJ+dxYvHSWbtjWiWaCm0Gfe0y1pdPcVVfEGP1tqd6PnC2K
 WjhlrALAtE0/5s3EUajW6LsQRXT1zr1xFOkVy6Ay5LkCfRBR3KbjqWQ6DeCbJNyBWXfZ
 vXYe94Xqx4walh09lFeXAC6gkHubfMa4G0WSlJFVjHKR+IgXI7vCssUJO2TdAvNrEE9/
 QebOivfzVOdKO9y7AAlVJ1b0VbeTFPYObjIvbe2j68dYTYqKlTDpOxBGKOu5CicSECNA
 3p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=izWOxLMJjKKCnsghAObjTqVGDsbWvFY0EQ2g9sbVDxk=;
 b=BoWPh0TncelMzTfhAEsqh7uH7aMwavqYdpe6U8+O8lyiGTS2wWksEt/daPu8oZPJ22
 rtns9cKNouDjEWCB+runv7k04QSkUFq5AbS414oPcZOnJjhBeF6dj4YhyTdVxgf8qSVS
 pPB7B3O2TGfG2mTymDyRxXyIiBaLpz1KFs80mpd9L/D0BDR7TyYpQcLupE3LhFJHVM9t
 oKrqtsxjKp0lT/u8tkwQnxvFtaHJlWRCXsLK83pCidjfKoH8K3M0tUwW0276NejDyqXk
 V8Njn0P6dxLoOp/aYOnG8yrL9hMJ1Ou5Gn8AtR4APDcA+hYDwqWBsNBK1yYQJN5P3goz
 HTUA==
X-Gm-Message-State: AGi0PuaMfOARYow0Ad5/5QwD+tgohtcGTzyjapVvO14ACWZ9MN6ZDrB8
 3DlBnNMUnHnGHTdAtwxnAw/a52VkTyzNMczWbKo=
X-Google-Smtp-Source: APiQypIEBzKBqxaWI7oNC7ghadXJ21n8+TOwHzXc3zD0+lHgJkLPIdNnZFPMPERAT2UWkzYUrDNb03gwJPSQUDgUyKY=
X-Received: by 2002:a92:690e:: with SMTP id e14mr3336683ilc.22.1587647285396; 
 Thu, 23 Apr 2020 06:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200423124305.14718-1-f4bug@amsat.org>
In-Reply-To: <20200423124305.14718-1-f4bug@amsat.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 23 Apr 2020 15:08:06 +0200
Message-ID: <CABoDooOz7MZ6DWajfQU1s3mK8Cf_U06pjHcoPW9Tat5+gKGdGw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Use correct variable for setting 'max' cpu's
 MIDR_EL1
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=laurent.desnogues@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 2:44 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> MIDR_EL1 is a 32-bit register.

In fact MIDR_EL1 a 64-bit system register with the top 32-bit being RES0.

So the right fix might be to change midr field size, just to be future proo=
f :-)

But if we stick to a 32-bit midr then:

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> This fixes when compiling with -Werror=3Dconversion:
>
>   target/arm/cpu64.c: In function =E2=80=98aarch64_max_initfn=E2=80=99:
>   target/arm/cpu64.c:628:21: error: conversion from =E2=80=98uint64_t=E2=
=80=99 {aka =E2=80=98long unsigned int=E2=80=99} to =E2=80=98uint32_t=E2=80=
=99 {aka =E2=80=98unsigned int=E2=80=99} may change value [-Werror=3Dconver=
sion]
>     628 |         cpu->midr =3D t;
>         |                     ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/arm/cpu64.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 95d0c8c101..4eb0a9030e 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -620,12 +620,12 @@ static void aarch64_max_initfn(Object *obj)
>           * code needs to distinguish this QEMU CPU from other software
>           * implementations, though this shouldn't be needed.
>           */
> -        t =3D FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0);
> -        t =3D FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf);
> -        t =3D FIELD_DP64(t, MIDR_EL1, PARTNUM, 'Q');
> -        t =3D FIELD_DP64(t, MIDR_EL1, VARIANT, 0);
> -        t =3D FIELD_DP64(t, MIDR_EL1, REVISION, 0);
> -        cpu->midr =3D t;
> +        u =3D FIELD_DP32(0, MIDR_EL1, IMPLEMENTER, 0);
> +        u =3D FIELD_DP32(u, MIDR_EL1, ARCHITECTURE, 0xf);
> +        u =3D FIELD_DP32(u, MIDR_EL1, PARTNUM, 'Q');
> +        u =3D FIELD_DP32(u, MIDR_EL1, VARIANT, 0);
> +        u =3D FIELD_DP32(u, MIDR_EL1, REVISION, 0);
> +        cpu->midr =3D u;
>
>          t =3D cpu->isar.id_aa64isar0;
>          t =3D FIELD_DP64(t, ID_AA64ISAR0, AES, 2); /* AES + PMULL */
> --
> 2.21.1
>
>

