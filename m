Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE1CC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 10:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0001820873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 10:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIZypCm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0001820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48737 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM8kT-0007P5-8R
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 06:15:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1hM8jk-00075e-4p
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1hM8jj-0005vx-Bh
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:14:44 -0400
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:52029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1hM8jj-0005uf-4U
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:14:43 -0400
Received: by mail-it1-x141.google.com with SMTP id s3so2347565itk.1
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=qBeiteXdYtsE85pywkveO0AVnFwBNBYSM7PGTuFc8qA=;
	b=LIZypCm9cHX+n1RmWf2b1EzKw4ixpAUCdTtpa2/LgNsCMNgAOHYVmxemXdfYAHqHBE
	bHXNxOplMsFl1y115jcphK+XIKeAe4ie3OBXt5Rfp70+KWhPTEj5t18K+C9BbiqtacnT
	vu7HrUcBmN3EAtaDAgyojQFJogvjQ+dGuse5UH+5cGnTG/3o7Mqt8zIH6vwyj/R8TCnc
	9F+2OfKWRRwIa42Vz81yap/mC0SsnR412+nlRNkDBCcPjjSI0CDaCK+w0v1XqPaubgLL
	OXhAQIKTL1EY5ZLjNA4iqunppJKbJOY/T963vJQsbcua2J5WsKMY2cgSiFKSolNsyc1i
	22qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=qBeiteXdYtsE85pywkveO0AVnFwBNBYSM7PGTuFc8qA=;
	b=e9MEGgJT7N30jFxzgu/SQGH7MScAXFt7O4U8JPci8oTuD993jGCcIhbSPfeVIK2qJi
	x8xXkP78seQXpkl8BK8c/Jj6qIeMv5CbLfid1ZY40pifRGMjky7rWBQC9ewnOliXR8ho
	j0UwkfuOPCPpvUod8iu+bRf1jWrFznLiUZEYY4qyAPkX9nJ0ktb1VZfd+ACY4Xbt/2cT
	Uj3Vn59zbNAjuGN4wSYg3e6OfD9PkLMfPMeFXrXCmQsuMdBO3CfR7FlMBoRi30ymFuTk
	+SrwCqr/PlZ9kJQN3VCnXvlkWWK0QAo+OP+z9JYoXmrdmKwPjw4r7yvxiRmD2tVC+kbG
	kR0Q==
X-Gm-Message-State: APjAAAUcXnvT8tEaImInFnPa2xq3il0NE2HhY9Ol/rdCIwMqEODOCpJb
	p5kf+z7Cyu9wa+1pNIVoZ6qYl8VEoA/eJs3JU6o=
X-Google-Smtp-Source: APXvYqzzrhVR1qCNtkYqDxuxRsKQz/H82xUFNPNQ5VnCsf63Xts5h03hKjKcV2+1wWhUNddZm7J8gPlaBqQHnSD+EYQ=
X-Received: by 2002:a24:798c:: with SMTP id z134mr1606006itc.5.1556792078889; 
	Thu, 02 May 2019 03:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190502092728.32727-1-alex.bennee@linaro.org>
In-Reply-To: <20190502092728.32727-1-alex.bennee@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 2 May 2019 12:14:27 +0200
Message-ID:
 <CABoDooPLQAGi+gtYX+jPaZk9=OgGOLwpJdwfJML-aKMiHu3Azw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::141
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix GPROF build failure
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502101427.cRyBORldv2JQyjjmiYUK0ztcs64aRFBLVVU0eA1-IqA@z>

Hello,

On Thu, May 2, 2019 at 11:31 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> When linux-user/exit was introduced we failed to move the gprof
> include at the same time. The CI didn't notice because it only builds
> system emulation. Fix it for those that still find gprof useful.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  linux-user/exit.c    | 3 +++
>  linux-user/syscall.c | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/linux-user/exit.c b/linux-user/exit.c
> index 14e94e28fa..bdda720553 100644
> --- a/linux-user/exit.c
> +++ b/linux-user/exit.c
> @@ -18,6 +18,9 @@
>   */
>  #include "qemu/osdep.h"
>  #include "qemu.h"
> +#ifdef TARGET_GPROF
> +#include <sys/gmon.h>
> +#endif
>
>  #ifdef CONFIG_GCOV
>  extern void __gcov_dump(void);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 96cd4bf86d..f2d9883aef 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -59,9 +59,6 @@
>  #ifdef CONFIG_TIMERFD
>  #include <sys/timerfd.h>
>  #endif
> -#ifdef TARGET_GPROF
> -#include <sys/gmon.h>
> -#endif
>  #ifdef CONFIG_EVENTFD
>  #include <sys/eventfd.h>
>  #endif
> --
> 2.20.1
>
>

