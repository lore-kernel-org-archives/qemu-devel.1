Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9B0C73C41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 13:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F79C20861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 13:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgYJssDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F79C20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkpoN-0002IB-3T
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 09:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38078)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hkplc-0000pu-DK
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 09:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hkpla-0006Ez-8u
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 09:02:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hkplZ-0006De-W1
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 09:02:42 -0400
Received: by mail-wr1-x443.google.com with SMTP id f9so20925839wre.12
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 06:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=B/84RZDLcbcEtXGWyZT4yQlAUVgZV1Ny4zxKfGVZ7yg=;
 b=ZgYJssDc4NZlVSuCWvFlBNLB03lPZRm+fdDEMO1qm2Ucy6BMypj7pRq7QC2KFkSHkq
 gLEDHA5ER0IOrCNNsrrRxDKuByP5tF6GTTNTdbVJR6Lf3WeC34CtWr7Vt5AL4PjX74lh
 MfL72jVHt9cQHAUPIDn5MjPCgAzY9rmdELVUMukURv3pBI1Lfv6SR86uIjMyh0GeDYPR
 H8D4GPB6Izk53sy4zdiAx+dY57p/o1ej92qMyWOd89kXXVRB0hwlKMvp8kGURxSyU4zl
 NKJoc7my7PcUp6KcJTCrA1R8hQTRTuVLiiw5vYCxzlau1XKnoSD5dceWY7DFsEfIAsDM
 jKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=B/84RZDLcbcEtXGWyZT4yQlAUVgZV1Ny4zxKfGVZ7yg=;
 b=YTA8rgBDXmowmxaZ4yryinx81KU+Nevr2Rkzewnl7gdf3EWCDTUnBeXadQEVUy8fR6
 rW4/LY5+UO/DpetNI9tfBj5eMWRgIYSgT25M/Uo5fPctZESJmMcASiRbjIpoKhuMklyq
 HlSkUDxV7OAiG4A3XibNB2dgzGtnOYAokEfPcsRCXxTLbQ/ZPa8nDDdOI98zJO1FZCKp
 eqohoeypzarYOZTJ5DVUYTOWCvaW5Nz80m9/Idsjrl1kVlso0sEd5gzeuTUNbwlVG2p9
 FovVFy/3vCK3VVvNBpj0S1j+geEfPX/otaJF3bRjYfH8qSj3fs/fvLnSTle0mGVlMJv8
 PcXA==
X-Gm-Message-State: APjAAAUVEAc9w2wVXTtISsdcuaRDv272Dwch5sFci3aV0PXzDS6YWEKx
 ZVTVGTRZU+UEbV9FlbY0XcYQ8w==
X-Google-Smtp-Source: APXvYqxmEwqP4f6YxDxUCjSYbicrlszRQ8QpNQ7k83PwvLSxxYPu/JwWWPW6Q9XkqbXKXKDIWEnohw==
X-Received: by 2002:adf:c706:: with SMTP id k6mr25118702wrg.40.1562677360143; 
 Tue, 09 Jul 2019 06:02:40 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y1sm1990414wma.32.2019.07.09.06.02.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 06:02:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AB1B81FF87;
 Tue,  9 Jul 2019 14:02:38 +0100 (BST)
References: <20190709121900.25644-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <20190709121900.25644-1-richard.henderson@linaro.org>
Date: Tue, 09 Jul 2019 14:02:38 +0100
Message-ID: <87sgrfe4y9.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH for-4.1] tcg: Fix constant folding of
 INDEX_op_extract2_i32
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
Cc: christophe.lyon@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On a 64-bit host, discard any replications of the 32-bit
> sign bit when performing the shift and merge.
>
> Fixes: https://bugs.launchpad.net/bugs/1834496
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/optimize.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index d7c71a6085..d2424de4af 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1213,8 +1213,8 @@ void tcg_optimize(TCGContext *s)
>                  if (opc =3D=3D INDEX_op_extract2_i64) {
>                      tmp =3D (v1 >> op->args[3]) | (v2 << (64 - op->args[=
3]));
>                  } else {
> -                    tmp =3D (v1 >> op->args[3]) | (v2 << (32 - op->args[=
3]));
> -                    tmp =3D (int32_t)tmp;
> +                    tmp =3D (int32_t)(((uint32_t)v1 >> op->args[3]) |
> +                                    ((uint32_t)v2 << (32 - op->args[3]))=
);
>                  }
>                  tcg_opt_gen_movi(s, op, op->args[0], tmp);
>                  break;


--
Alex Benn=C3=A9e

