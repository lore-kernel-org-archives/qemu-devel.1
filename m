Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A75C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8482206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v7D9qe57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8482206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8MWo-000804-W8
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8MVo-0007Ml-Qo
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8MVn-00005y-25
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:39:40 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8MVm-00005C-OX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:39:38 -0400
Received: by mail-wr1-x443.google.com with SMTP id g7so27950988wrx.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Q5j6La+TU4g+hZ0cWtWl8cbLKggrTN+UercTrQhvyjI=;
 b=v7D9qe576cD7UOiSMgT6QYvaI9CfhyAa1werrDVuGhaSAJzNUMBbbiJONq7ck1LYn0
 TrgbWCKwgj25XGekZagpBiR9aNd9lLZg1bTq+FWfft2/lNI3tOcHUEaq8EA1clOfkZRL
 lscBt10xReyvQtAjvKliV72G03SwwXH/zrxlLRWY5fFG2GECNU/4iz+QNelonyqg2lMZ
 e/ZxPbLeLDEoJYXZTKALIlYedRkzyCUxoWG2rJ/zIroVSDosyYq7KmwsNImhKGIR7UvH
 x97spd6x5zzv2CDYQ6jLE2Fo6FDw/IAUYDYgjluXUncNVWr/CCfcGPIziZZQpEyeT0ef
 pXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Q5j6La+TU4g+hZ0cWtWl8cbLKggrTN+UercTrQhvyjI=;
 b=oegR3ALg6jgbSD8Ejqn+ZqMaD4QzbkQXh525Mkx7kpCODFR8dMtIf3lYBm+X5d04m+
 bZ+l48WUSo71GIqygH/BrDsfPWJ1mteTukfXfVUk7mQN52zAKwQm3Qc9UXXlzhxq73S5
 DM+PvsMmHHcYZqkNJHeTAxt6wfZWUXAfW/WEygQxTCWj9k2dOEerSakkF95jGZld/kdS
 zuPPwO0xvgt5WUjtdfLj/TDHx+tBIaLlslndb79qR2OaqzDWg1LQZ/J1n+ZAQknPjIBX
 1ahu2t9RvFHzuQDva+WC052lBHF4ZuFA9cpIoOoiTWoHpii/isd4ogNRmpOCLL8FtG/R
 mNoQ==
X-Gm-Message-State: APjAAAXGnHHptSRlJlmZpj09flsK07PDDE/O2v72fRvCr1gSYDxue37n
 ICe/zINIpyGvlkZXNo8Cc4Iwsg==
X-Google-Smtp-Source: APXvYqyYz0Zgbb1Bsg+/hCmBTfS8yEnliK/ZLqSFcU2yzWtznn9DabkF+hYqHmjJAIwebxDCoHzPuA==
X-Received: by 2002:adf:db8e:: with SMTP id u14mr8390137wri.50.1568284776019; 
 Thu, 12 Sep 2019 03:39:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u10sm5664673wmm.43.2019.09.12.03.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 03:39:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AE6E41FF87;
 Thu, 12 Sep 2019 11:39:34 +0100 (BST)
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-2-peter.maydell@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190910144428.32597-2-peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 11:39:34 +0100
Message-ID: <87sgp1ztll.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 01/13] target/arm/arm-semi:
 Capture errno in softmmu version of set_swi_errno()
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


Peter Maydell <peter.maydell@linaro.org> writes:

> The set_swi_errno() function is called to capture the errno
> from a host system call, so that we can return -1 from the
> semihosting function and later allow the guest to get a more
> specific error code with the SYS_ERRNO function. It comes in
> two versions, one for user-only and one for softmmu. We forgot
> to capture the errno in the softmmu version; fix the error.
>
> (Semihosting calls directed to gdb are unaffected because
> they go through a different code path that captures the
> error return from the gdbstub call in arm_semi_cb() or
> arm_semi_flen_cb().)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> NB that a later commit will put in some cleanup of TaskState
> that will let us reduce the duplication between the two
> implementations of this function.
> ---
>  target/arm/arm-semi.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 90423a35deb..03e60105c05 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -114,8 +114,13 @@ static inline uint32_t set_swi_errno(TaskState *ts, =
uint32_t code)
>      return code;
>  }
>  #else
> +static target_ulong syscall_err;
> +

I appreciate that this is just moving things around but this will be
broken for -smp > 1 if two vCPUs make a syscall at the same time. For
linux-user this information is kept in ts->swi_errno which is
per-thread. Either we need a __thread version or find somewhere in
CPUARMState to store it.

>  static inline uint32_t set_swi_errno(CPUARMState *env, uint32_t code)
>  {
> +    if (code =3D=3D (uint32_t)-1) {
> +        syscall_err =3D errno;
> +    }
>      return code;
>  }
>
> @@ -124,10 +129,6 @@ static inline uint32_t set_swi_errno(CPUARMState *en=
v, uint32_t code)
>
>  static target_ulong arm_semi_syscall_len;
>
> -#if !defined(CONFIG_USER_ONLY)
> -static target_ulong syscall_err;
> -#endif
> -
>  static void arm_semi_cb(CPUState *cs, target_ulong ret, target_ulong err)
>  {
>      ARMCPU *cpu =3D ARM_CPU(cs);


--
Alex Benn=C3=A9e

