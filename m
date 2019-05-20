Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EF3C04E87
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C4C20815
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7T0iQ4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C4C20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34693 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShHQ-0000b0-GD
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 08:20:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hShEi-0007XY-J8
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hShEg-0006v3-0r
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:17:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hShEf-0006uS-Qx
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:17:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id d9so1385107wrx.0
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 05:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=crwrfIIAZoYXbIGFBOxXoQXOSGE/adVR/qetCaQlpLU=;
	b=A7T0iQ4R0kG8sGmFlxTXnSzxwtheHuFXtufmvMEm2OH0VCXqtzL2K5EWR9uXlyWZCA
	Kd43T8uhX/rCBhnKi6raHf0y790avJlhmYwWWBqG9LwrZ4y2DnayQLQiX8sNH5fau1jd
	9i4LrgZNXgFLT5CWaivGGZ5kkwEJT4QP42tJg2nwbSW/BvUwDOi2748qUtJK3BRoYBCC
	xRe0oyclTVJS4vNElpDtVXJxTsC+T+FFDFFysmBOB/TrSiDEceIikaEegsxEbWn9RIvV
	gBqledvdvi7ZxfbTMs0T27uejr2kFF5nC3K5TqxGpJy8Mowjr4BKDvNKHO+xLTtk3V0U
	fAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=crwrfIIAZoYXbIGFBOxXoQXOSGE/adVR/qetCaQlpLU=;
	b=TxD5SXWXbbVrlEbDGdia/xM2pUBuegyQ5+vZjZAl51r2akn8TXA4FGv4E2y95cH83q
	Qn1VgW/7tWr72Chr7rZCEJ7hd5Mfq2RaCqfBlSbRdIiO5ptrrz97aDqJbhOVwffTwKie
	AnLw8Kr8r1mzilXyXQoBT5n14fKX3+dnjDbCcOt89u3qGV29V0QlQI7RWhEYDhwO2vRr
	D894sYBte8zWaR7ubEDTvkrUOBqAqralCM/OSd2JQ3TatJLxFcLtbe7+Q4mklzq/5VT+
	MdHwjq1kl2/yu5gOc1QKDtqLoV2eZyhlEtZN3TDYlnGseBLlwS2bWdjEa9DNxUvsJTMi
	q+JA==
X-Gm-Message-State: APjAAAW7QU074gaU+jfTRxb2Bkez5tf20r+DGT0/8Gsz6wx+NXJx9saG
	OSfnWemCMS40y8sObR0DBrgY7A==
X-Google-Smtp-Source: APXvYqxVjm67XIC6A3Y11AeasTlGLc/sNkidvIGDVqW/2w8ZHvbQ8eq+WZ7PNaa9tacMg0Et44U7BA==
X-Received: by 2002:adf:dcc8:: with SMTP id x8mr26614972wrm.3.1558354664542;
	Mon, 20 May 2019 05:17:44 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	i125sm15815459wmi.2.2019.05.20.05.17.43
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 05:17:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 975721FF87;
	Mon, 20 May 2019 13:17:43 +0100 (BST)
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-9-jan.bobek@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190517224450.15566-9-jan.bobek@gmail.com>
Date: Mon, 20 May 2019 13:17:43 +0100
Message-ID: <87y331gw0o.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RISU v2 08/11] configure: add i386/x86_64
 architectures
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

> Now that i386 and x86_64 architectures are supported by RISU, we want
> to detect them and build RISU for them automatically.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  configure | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/configure b/configure
> index 65e1819..ca2d7db 100755
> --- a/configure
> +++ b/configure
> @@ -48,12 +48,14 @@ EOF
>  }
>
>  guess_arch() {
> -    if check_define __m68k__ ; then
> -        ARCH=3D"m68k"
> +    if check_define __aarch64__ ; then
> +        ARCH=3D"aarch64"
>      elif check_define __arm__ ; then
>          ARCH=3D"arm"
> -    elif check_define __aarch64__ ; then
> -        ARCH=3D"aarch64"
> +    elif check_define __i386__ || check_define __x86_64__ ; then
> +        ARCH=3D"i386"
> +    elif check_define __m68k__ ; then
> +        ARCH=3D"m68k"
>      elif check_define __powerpc64__ ; then
>          ARCH=3D"ppc64"
>      else


--
Alex Benn=C3=A9e

