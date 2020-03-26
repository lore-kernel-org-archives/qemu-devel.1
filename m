Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A07C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD0320737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dmc5rnBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD0320737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHW6P-0007NX-KP
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 13:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHW5l-0006wU-8F
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHW5k-0000oq-2Y
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:14:52 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHW5j-0000mF-MY
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:14:52 -0400
Received: by mail-oi1-x243.google.com with SMTP id q204so6128082oia.13
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FcMgUHAZ8FVY/8d/PaJ7lswFs91f+RqDouLnwAfhVSg=;
 b=Dmc5rnBBtHMN4KBeqXUCYZZAHP4KL/AAyi/GbCEJ8vS13lGaiKhFCRQqWUu7a/eCSm
 8Fcp4vF1K0BskN02fRLGbl2CFybBgxJDn0YtUvf3rsxOg3ZdRnfLwPqDYTC26DnbhM7v
 U+ep4NYA5cS/vHEoNcn0YUkjNg7fEUo0FQjsrUdAGvoDuRwQmZOrQn6seZwJBi6Hj1Ko
 KUise4fkaAICaWs2TfKImZ7gu7uLAvzzO8QYb/4ElGCnAejHmBu0j18ZknUBmb2BoT4T
 XssqJbsNuj2lNV4VTsu8BFZiCgyCKABnKWGasBSMya5CsCqzFkKB2w9DgrmfKAydlGa0
 dS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FcMgUHAZ8FVY/8d/PaJ7lswFs91f+RqDouLnwAfhVSg=;
 b=OuW2vN8vmo6KjOqKnpcmasb/6CIvummTy4toWwA/vktGg36E1VA7n1RVVq32mTh3RT
 XzoEY0FzkrSyjrow0AZ6nPYO3+DYPJwK1ZEgahZjooa/CRbshB43P0sY50o95T0+jfUe
 Ph+TeRAk1UDcBe6TrcRh2J38/0mOrciU7xAruOlJq5PoPw+9ffEPus9VNNd6jk5v0Hzm
 7HQPczWyE0iQYHHB4Bep6AOxWnFtHT8woYpdhMjgnDGrSVOejSlbCqQzWWOqLm7eQU6h
 VgYcbobbEId9eoyTVD6ViB+q37OrxeKX7gvYOavTveVjzZea7fXVL+HeoyLm6BBi+FMO
 WFTw==
X-Gm-Message-State: ANhLgQ2Joh9OAVBOPWQl9hlwizy8T1pFOeDMku/hvRK315iEXCPXLfqp
 q/A/g84UofSkQ2E1Jk9x2OCURrhRDtOXA6kcgfO5dQ==
X-Google-Smtp-Source: ADFU+vuKfPMU5U+GWnnNbmUZqUERm/iqggKsZ+41ddGeyN6SMm/vtYWyA1q0ZmKuE5mHSBMZJuaWOCAaXgObmYBCFeE=
X-Received: by 2002:aca:c608:: with SMTP id w8mr911002oif.163.1585242890410;
 Thu, 26 Mar 2020 10:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200326170121.13045-1-alex.bennee@linaro.org>
In-Reply-To: <20200326170121.13045-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 17:14:38 +0000
Message-ID: <CAFEAcA8Lo84gNk2tFCKsgM_O50bXTCs6Z9jH6aCvfDA56TDCmA@mail.gmail.com>
Subject: Re: [PATCH] qemu/atomic.h: add #ifdef guards for stdatomic.h
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Mar 2020 at 17:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Deep inside the FreeBSD netmap headers we end up including stdatomic.h
> which clashes with qemu's atomic functions which are modelled along
> the C11 standard. To avoid a massive rename lets just ifdef around the
> problem.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  include/qemu/atomic.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
> index f9cd24c8994..ff72db51154 100644
> --- a/include/qemu/atomic.h
> +++ b/include/qemu/atomic.h
> @@ -208,11 +208,14 @@
>  /* Provide shorter names for GCC atomic builtins, return old value */
>  #define atomic_fetch_inc(ptr)  __atomic_fetch_add(ptr, 1, __ATOMIC_SEQ_C=
ST)
>  #define atomic_fetch_dec(ptr)  __atomic_fetch_sub(ptr, 1, __ATOMIC_SEQ_C=
ST)
> +
> +#ifndef atomic_fetch_add
>  #define atomic_fetch_add(ptr, n) __atomic_fetch_add(ptr, n, __ATOMIC_SEQ=
_CST)
>  #define atomic_fetch_sub(ptr, n) __atomic_fetch_sub(ptr, n, __ATOMIC_SEQ=
_CST)
>  #define atomic_fetch_and(ptr, n) __atomic_fetch_and(ptr, n, __ATOMIC_SEQ=
_CST)
>  #define atomic_fetch_or(ptr, n)  __atomic_fetch_or(ptr, n, __ATOMIC_SEQ_=
CST)
>  #define atomic_fetch_xor(ptr, n) __atomic_fetch_xor(ptr, n, __ATOMIC_SEQ=
_CST)
> +#endif

This will work around FreeBSD's current implementation in particular,
but I don't think there's anything in the C11 spec that mandates that
atomic_fetch_add() and friends have to be macros and not simply
functions...

thanks
-- PMM

