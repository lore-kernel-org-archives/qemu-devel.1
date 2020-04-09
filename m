Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231F6C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 20:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC56620753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 20:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvnOHR99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC56620753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMdtn-0005Wq-3m
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 16:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMdt2-00051Z-Ab
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 16:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMdt1-0001gl-6B
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 16:34:56 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMdt0-0001gO-Vd
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 16:34:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id y24so172088wma.4
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iO1OzD0u//+p/06hMRrCDyC/5gto/5geNL7rNx4T+/U=;
 b=xvnOHR998+iLwaxgRFIxu7ahNmVfsqvwz/ATc8UcVRUxktyQ8ivppTUfFRjalc03fz
 9gw/vXrYrEjoCn8J5waOdkyD+VYa6Ep5z88CbYjAZ3UN3o/nNqRJShs7HKarJKtNuqbA
 aagvUULyPBOqGZ9YdnJZ2Hmh5PY6PVq3a4rBSH6Y2z9DogvGoSGg8lF6EQI3QSOhVaRj
 SvfnQ8bhfrgvIhy3FWyTRn2yfQ6tXE0w8Yh9N+ixbTdukLPpajyK8FSu7gHhAVr1Rsra
 S8vUQNvShkWTJwAkXrKFokw7EAmlIi0jXpMM9U3K3HAUdYu9OQmf5pEq20gbKaEJ9ea9
 pZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iO1OzD0u//+p/06hMRrCDyC/5gto/5geNL7rNx4T+/U=;
 b=iTEKgmdst86dtV2Tv6WnU1Wv1nLcxe70w2jTYM9oobqFpheLkPPM6fy9Iw4b2HMA6e
 MNfAdJe/uqIW1hVTwU1WzENiXqNGsJ440sPWTDR8IKUTI4rSwxgfZXE8mzJ3wBV2k/0Z
 vq8EhChtQQLEakFEgEauPa1CdNz9HjPkzFq1qkUvwmcuWrB3ISgLdPWatwS9XFrXSFwl
 plT1CO9BT+xCuEfRvXSRJgNbf0xY5ok9eR2BxzxPEA4h2zZWEZ1fABElOagsKOt1C/5z
 RBc9Tj9y0POwZKNj339uFLyu/uZfzoaoGQbvoL7Hrc7abs/fSI9SN+L+/niqvv1a5fMa
 xf6A==
X-Gm-Message-State: AGi0PuZPFYGMjdnZUHbkIqxyj6v6r3GJ81V6vW0OPEjzON7dO5cIUbih
 uayAh5C9/ac4vZmaE1kfE8D7XpoNUMA=
X-Google-Smtp-Source: APiQypLk3Ji0TmMWz5PzlszJpVHYYzFqNNQOy/MCnTNjJXjGSfR6Trnclo0xepXoBq9QNX/Pl9eKhA==
X-Received: by 2002:a05:600c:2316:: with SMTP id
 22mr1677725wmo.25.1586464492547; 
 Thu, 09 Apr 2020 13:34:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h4sm20620276wrv.91.2020.04.09.13.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 13:34:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A761E1FF7E;
 Thu,  9 Apr 2020 21:34:50 +0100 (BST)
References: <20200409172509.4078-1-philmd@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0] target/m68k/helper: Fix m68k_fpu_gdb_get_reg()
 use of GByteArray
In-reply-to: <20200409172509.4078-1-philmd@redhat.com>
Date: Thu, 09 Apr 2020 21:34:50 +0100
Message-ID: <87r1ww9z4l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Since a010bdbe719 the gdbstub API takes a GByteArray*.
> Unfortunately we forgot to update the gdb_get_reg*()
> calls.  Do it now.
>

Queued to for-5.0/more-random-fixes, thanks.

> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Based-on: <20200409164954.36902-1-peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/m68k/helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 014657c637..cad4083895 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -109,8 +109,8 @@ static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GB=
yteArray *mem_buf, int n)
>  {
>      if (n < 8) {
>          int len =3D gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
> -        len +=3D gdb_get_reg16(mem_buf + len, 0);
> -        len +=3D gdb_get_reg64(mem_buf + len, env->fregs[n].l.lower);
> +        len +=3D gdb_get_reg16(mem_buf, 0);
> +        len +=3D gdb_get_reg64(mem_buf, env->fregs[n].l.lower);
>          return len;
>      }
>      switch (n) {


--=20
Alex Benn=C3=A9e

