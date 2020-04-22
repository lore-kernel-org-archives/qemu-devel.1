Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5F3C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9C320767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWx0vVsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9C320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRKeB-0007hJ-Sk
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 15:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRKdU-0007Bd-Uw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRKdU-00006g-3i
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:02:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRKdT-00005Z-M8
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:02:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id k13so3806776wrw.7
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=r6du1/x6/YYB+L8A3QU/UNwpdXLw5JICnDSf4HkhW+U=;
 b=yWx0vVsjLR+H5gn568sNMaJy9mf4kq6Qi8HSStli1Fxo9tvDG4G5+AbVqvkiCenADz
 K7j/Ct4TkzZiwLXgTfGVF5lTJMg6PaLLZkKJA8+nD5mysUXostzVN3mHDZBod0+mH7oi
 MqD9nFqobBj7SwdqWxkPpZ7SLSeZdAO4ujcg0uu/NrYzknwF2EGpJdrPttotolQ5sehO
 tXKgVhLufR9nI4g3UmtVTIvDBdNabr40kcKlTzJZgQ4oMh58guUo6fohbJLYHDpM7SyW
 DF3t+u2ce72BaZuGU+11OiX/XtpGAixbZniXEYf1e2MQBaf0Y+pndtoGXzZ8NuyOvsBZ
 XjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=r6du1/x6/YYB+L8A3QU/UNwpdXLw5JICnDSf4HkhW+U=;
 b=ZJshQSQ93V8D9RZ6nxNL+sARxEHzmEjqgNXAsx0mOvJY632U/hq006RMG0DAL+/1/Y
 XpJT/dtnthUph7BVMXup8S7stIYFLnHwYPeyxkoSzl4/EoOTj7OPNU3YZ0repp9axhqj
 gIyn5eH0dS5VJRiAqZNG1oQ9Iuy5or6OIS46vnjNjebDcz4iEf5XveoZt//u2KllNRSl
 Mh8Q+h+sW5W5sRDAKccOPalQ9zgcB8ovReHjACrwErF/MX6AA8JFXB10M5ushtcoXhss
 0svE+W5NUW2Gu9FdrdAeuspoqgm60XpvUQhvd+qcuynlz9dieeOfTcQz5Y9PlEH0uWTD
 ybxQ==
X-Gm-Message-State: AGi0PuZO9CGx1EB3ummxDP8hu1w0fnzVxM9gXD8bPpwAnXCIHl7nCCo5
 y3rhLtGEG+ZktKe1O1zL3v79QA==
X-Google-Smtp-Source: APiQypKXUZlhn15MJ2hUmvwRhPUa4zBisFfmEt5XOIviLxx8pTkDKACJEP6HUuHuUGviSNR5EV0aTQ==
X-Received: by 2002:a5d:610e:: with SMTP id v14mr509563wrt.159.1587582133861; 
 Wed, 22 Apr 2020 12:02:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y18sm241878wmc.45.2020.04.22.12.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 12:02:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 91A081FF7E;
 Wed, 22 Apr 2020 20:02:11 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-20-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 19/36] tcg/tci: Add special tci_movi_{i32,i64} opcodes
In-reply-to: <20200422011722.13287-20-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 20:02:11 +0100
Message-ID: <87wo67baz0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The normal movi opcodes are going away.  We need something
> for TCI to use internally.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/tcg/tcg-opc.h    | 8 ++++++++
>  tcg/tci.c                | 4 ++--
>  tcg/tci/tcg-target.inc.c | 4 ++--
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
> index 9288a04946..7dee9b38f7 100644
> --- a/include/tcg/tcg-opc.h
> +++ b/include/tcg/tcg-opc.h
> @@ -268,6 +268,14 @@ DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
>  #include "tcg-target.opc.h"
>  #endif
>=20=20
> +#ifdef TCG_TARGET_INTERPRETER
> +/* These opcodes are only for use between the tci generator and interpre=
ter. */
> +DEF(tci_movi_i32, 1, 0, 1, TCG_OPF_NOT_PRESENT)
> +#if TCG_TARGET_REG_BITS =3D=3D 64
> +DEF(tci_movi_i64, 1, 0, 1, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
> +#endif
> +#endif
> +
>  #undef TLADDR_ARGS
>  #undef DATA64_ARGS
>  #undef IMPL
> diff --git a/tcg/tci.c b/tcg/tci.c
> index 46fe9ce63f..a6c1aaf5af 100644
> --- a/tcg/tci.c
> +++ b/tcg/tci.c
> @@ -576,7 +576,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t=
 *tb_ptr)
>              t1 =3D tci_read_r32(regs, &tb_ptr);
>              tci_write_reg32(regs, t0, t1);
>              break;
> -        case INDEX_op_movi_i32:
> +        case INDEX_op_tci_movi_i32:
>              t0 =3D *tb_ptr++;
>              t1 =3D tci_read_i32(&tb_ptr);
>              tci_write_reg32(regs, t0, t1);
> @@ -847,7 +847,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t=
 *tb_ptr)
>              t1 =3D tci_read_r64(regs, &tb_ptr);
>              tci_write_reg64(regs, t0, t1);
>              break;
> -        case INDEX_op_movi_i64:
> +        case INDEX_op_tci_movi_i64:
>              t0 =3D *tb_ptr++;
>              t1 =3D tci_read_i64(&tb_ptr);
>              tci_write_reg64(regs, t0, t1);
> diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
> index 992d50cb1e..1f1639df0d 100644
> --- a/tcg/tci/tcg-target.inc.c
> +++ b/tcg/tci/tcg-target.inc.c
> @@ -530,13 +530,13 @@ static void tcg_out_movi(TCGContext *s, TCGType typ=
e,
>      uint8_t *old_code_ptr =3D s->code_ptr;
>      uint32_t arg32 =3D arg;
>      if (type =3D=3D TCG_TYPE_I32 || arg =3D=3D arg32) {
> -        tcg_out_op_t(s, INDEX_op_movi_i32);
> +        tcg_out_op_t(s, INDEX_op_tci_movi_i32);
>          tcg_out_r(s, t0);
>          tcg_out32(s, arg32);
>      } else {
>          tcg_debug_assert(type =3D=3D TCG_TYPE_I64);
>  #if TCG_TARGET_REG_BITS =3D=3D 64
> -        tcg_out_op_t(s, INDEX_op_movi_i64);
> +        tcg_out_op_t(s, INDEX_op_tci_movi_i64);
>          tcg_out_r(s, t0);
>          tcg_out64(s, arg);
>  #else


--=20
Alex Benn=C3=A9e

