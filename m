Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3B7C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0D52075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SnOAhm/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0D52075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8NWm-00072z-2u
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8NV4-0005in-CH
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8NV3-0000hM-2o
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:42:58 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8NV2-0000gZ-PA
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:42:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id q14so28044941wrm.9
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0Dvtpt029Oo3sA7IupM8HjQ5ZHeoOhkuh6jMZDpIwas=;
 b=SnOAhm/zk2AjY/lq481U4puVo3WB14Gz9/Qql019IUzvRbaK5ihmtBzfXXEZ696htB
 BzMXCZNBnf6HvNb4FDK4QlwAp3kYPi10+Djsd0xw+1NAuzfLe7qLuPW7frPkt5tQJqLQ
 O97A6mj6DgGgGHiD+t6YePEAZgtI7WBS8/uRPJsvAyd/LFX4m0a6KIM2ELPYX59UyfF4
 zuZxWXpnEX3H5ugOJAtQj/6L5cF4yOzRGsTAyMzWYLhh1GW7WQ79Kv2E1lddCrjBQ5qI
 M9lnFDHhPA7DXeOOVd6Mjh9txF2WlAbaWDdy11pdwyyM3/hKpPgVBU69kW2I7Z0huq5m
 EoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0Dvtpt029Oo3sA7IupM8HjQ5ZHeoOhkuh6jMZDpIwas=;
 b=YrasrnG9Njdr1+0kXI8RUmQ5NJRWTJve5lprw7ZvsbW2QrN4wYIaVwgSI5XYUgsSrA
 NtajvQxPhDj0p7iys8jeq7A6Sj5OJHy1qpXr+ooW15sXZAAY7nVhAwFXsNNX9xyGERcz
 YlC54jmYllLNSwFOn+r16DCLEp+r23+52DvkbsEyneVFgDQ2QYTeMZVuI/GtEX9xYpku
 Wbt9aKvoExlqn6dQxrtvz/OfTF/UR8BOA0fude9EVqNYwq5k0EDCiXOUCqoloRj5JkKi
 QeqIxpqD1296+d5CTo6+uS6ZjDO89LTGrhz58F9LjIbaY5f3yRgv3kf2bDFRxCEbUhfb
 HoAA==
X-Gm-Message-State: APjAAAX8hK7ejoDfXCg6Ws9emYdakpPT8aZC1moa2oTsGfn1SZVPQfGF
 DB535GzD7fuP48iSyxWySBhUdEwcJNw=
X-Google-Smtp-Source: APXvYqxwwVScn260OBRqQLkv6pZlAJPAqPhu7C6qfU/ZmocnvDyUQbAHXmQLjbJsGyMhsnpuV37Yiw==
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr33235604wrs.296.1568288575351; 
 Thu, 12 Sep 2019 04:42:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z21sm5800564wmf.30.2019.09.12.04.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 04:42:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D26A41FF87;
 Thu, 12 Sep 2019 12:42:53 +0100 (BST)
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-5-peter.maydell@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190910144428.32597-5-peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 12:42:53 +0100
Message-ID: <87ftl1zqo2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 04/13] target/arm/arm-semi:
 clean up TaskState* usage in non-user-only code
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

> The semihosting code has to build for both user-only and softmmu;
> for user-only it needs access to the TaskState struct that holds
> per-thread information. For softmmu we don't need it.
>
> Currently the softmmu set_swi_errno() takes a CPUARMState *,
> which it doesn't use, and the 'ts' variable in do_arm_semihosting()
> is set to either be a TaskState* or a CPUARMState* depending on
> whether CONFIG_USER_ONLY is set, so that the callsite always
> passes 'ts'. Since we don't actually need the CPUARMState *,
> we can instead make set_swi_errno() always take a TaskState*,
> by providing a local-to-this-file dummy typedef for the softmmu
> case and setting ts to NULL for softmmu.
>
> This will make it easier to have other functions which pass
> through the TaskState*, because now they can have the same
> prototype regardless of whether they're CONFIG_USER_ONLY or not.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/arm-semi.c | 48 ++++++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 21 deletions(-)
>
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 05491bf5248..ce3ba554bef 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -36,6 +36,13 @@
>  #else
>  #include "exec/gdbstub.h"
>  #include "qemu/cutils.h"
> +
> +/*
> + * Dummy typedef so that we can have functions that take
> + * a TaskState* even if we're building for softmmu; in that
> + * case the argument will always be NULL.
> + */
> +typedef void TaskState;
>  #endif
>
>  #define TARGET_SYS_OPEN        0x01
> @@ -213,27 +220,24 @@ static GuestFD *get_guestfd(int guestfd)
>      return gf;
>  }
>
> -#ifdef CONFIG_USER_ONLY
> -static inline uint32_t set_swi_errno(TaskState *ts, uint32_t code)
> -{
> -    if (code =3D=3D (uint32_t)-1)
> -        ts->swi_errno =3D errno;
> -    return code;
> -}
> -#else
> +#ifndef CONFIG_USER_ONLY
>  static target_ulong syscall_err;
>
> -static inline uint32_t set_swi_errno(CPUARMState *env, uint32_t code)
> -{
> -    if (code =3D=3D (uint32_t)-1) {
> -        syscall_err =3D errno;
> -    }
> -    return code;
> -}
> -
>  #include "exec/softmmu-semi.h"
>  #endif
>
> +static inline uint32_t set_swi_errno(TaskState *ts, uint32_t code)
> +{
> +    if (code =3D=3D (uint32_t)-1) {
> +#ifdef CONFIG_USER_ONLY
> +        ts->swi_errno =3D errno;
> +#else
> +        syscall_err =3D errno;
> +#endif
> +    }
> +    return code;
> +}
> +
>  static target_ulong arm_semi_syscall_len;
>
>  static void arm_semi_cb(CPUState *cs, target_ulong ret, target_ulong err)
> @@ -374,13 +378,15 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>      int nr;
>      uint32_t ret;
>      uint32_t len;
> -#ifdef CONFIG_USER_ONLY
> -    TaskState *ts =3D cs->opaque;
> -#else
> -    CPUARMState *ts =3D env;
> -#endif
> +    TaskState *ts;
>      GuestFD *gf;
>
> +#ifdef CONFIG_USER_ONLY
> +    ts =3D cs->opaque;
> +#else
> +    ts =3D NULL;
> +#endif

Why not pass cs to set_swi_errno and deal with all the differences in
the helper?

> +
>      if (is_a64(env)) {
>          /* Note that the syscall number is in W0, not X0 */
>          nr =3D env->xregs[0] & 0xffffffffU;


--
Alex Benn=C3=A9e

