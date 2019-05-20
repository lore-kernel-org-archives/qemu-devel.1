Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2D5C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 11:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C6A20645
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 11:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KXsBqdwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C6A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33932 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSgmm-00060E-Fn
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 07:48:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hSglj-0005ZD-IF
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hSgli-0003qp-Lf
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:47:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hSgli-0003q0-DW
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:47:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id r7so14194324wrr.13
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=Yi8jWrpPCuGQ81I0k+L4GtZncJLeYUrGbSY7YIG9Fhg=;
	b=KXsBqdwch/PpjNV/KJ9znNSUzrdNum7H64EODUaphF5ciflpTliMXSxZdpOuV4le0j
	SY97i3CVpflBdy1PXgNqPlEyt8/6QT4q0GDRPjugUqsqrMTeNKWFXWOtZYrcLFPDVtDP
	MtWDjHtkIYnqJmkDHeWRKcI+X5G5DMhuQEoih+uO4+JNc0MKPBmV1v2ZJ+0CdHs7G2Wo
	ogW78ddZBZSgGYxkxx8pyrZLU+HpsHltK2lJcQX6rT3XF137XjFSzTSUKR2yrLoo4/Ke
	I6BxnYFJmJ40g2hyDs0AjN/LhNusWYwYXqTxNAdo63ey+ZWWHfAjR+QSLmJc8ZDarDLT
	/0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=Yi8jWrpPCuGQ81I0k+L4GtZncJLeYUrGbSY7YIG9Fhg=;
	b=cXR+4FPAhmKcB3OEDd4GTREZKdFzyT5A+APOV/90e1bl2qIcCuAN9ZwJ6nMLxZo9Tp
	DRIU5FFvrHeNGE2b4c/6a3XLkLUyRg9K6e0/itDa/sfFZFAmqMYPteQ27PstxEX+ZPL8
	Vp6fOlqFxXQ08m9ikv6qYqtmb4PcDooJJEQq3VjbR43OXvzQcpYIvp0sz0+pxH2HfKYx
	j+Yjs9smD0shuE0dTstDI6WeqlzD0ZFsRHRIZb+dCpDaUFkQOBmORrxlYi8O2wsQ0lPL
	Ky/C0Yz+cKMjabUFPpi3wQ4HcSHFEuh9xcCcCel8fz0lTaLY4rhx5GB/5oyVLdXtQXm/
	5Ulw==
X-Gm-Message-State: APjAAAW01hxUtUknlPmthYcrMQNP/Lu1sJg5sjXxL79t/25WJ7mTStSi
	4BjxSMK/7Hp6bvsjlqQ418vOvQ==
X-Google-Smtp-Source: APXvYqyHjgQaDefXR7IwnBMRXDjTxrbQb6abRWebn+vtYKhTY9EtpgqBAOzdUA64qThCtDSurq2Qsg==
X-Received: by 2002:adf:e691:: with SMTP id r17mr26809690wrm.50.1558352868631; 
	Mon, 20 May 2019 04:47:48 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	i25sm19578201wmb.46.2019.05.20.04.47.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 04:47:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 3B3491FF87;
	Mon, 20 May 2019 12:47:47 +0100 (BST)
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-2-jan.bobek@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190517224450.15566-2-jan.bobek@gmail.com>
Date: Mon, 20 May 2019 12:47:47 +0100
Message-ID: <874l5pibz0.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [RISU v2 01/11] Makefile: undefine the arch name
 symbol
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Bobek <jan.bobek@gmail.com> writes:

> At least GCC defines the symbol "i386" to 1 to signal the target
> platform. We need to use "i386" as an undefined symbol in order to
> correctly include risu_reginfo_i386.h from risu.h. Add an -U option to
> the build command to make sure the symbol remains undefined.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 4aad448..b362dbe 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -17,7 +17,7 @@ VPATH=3D$(SRCDIR)
>
>  CFLAGS ?=3D -g
>
> -ALL_CFLAGS =3D -Wall -D_GNU_SOURCE -DARCH=3D$(ARCH) $(BUILD_INC) $(CFLAG=
S) $(EXTRA_CFLAGS)
> +ALL_CFLAGS =3D -Wall -D_GNU_SOURCE -DARCH=3D$(ARCH) -U$(ARCH) $(BUILD_IN=
C) $(CFLAGS) $(EXTRA_CFLAGS)
>
>  PROG=3Drisu
>  SRCS=3Drisu.c comms.c reginfo.c risu_$(ARCH).c risu_reginfo_$(ARCH).c


--
Alex Benn=C3=A9e

