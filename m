Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A95C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458312089F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8LzhCH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458312089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCRZD-0006zn-22
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCRO4-0006Ms-QA
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCRO3-0004Lh-LI
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:40:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54873)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCRO3-0004L2-D7
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:40:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id p7so10767271wmp.4
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=e6goZyVTcrpeUHzSgLPbCvH4DkIrEtmKDcNTMHNNMTg=;
 b=D8LzhCH+km4GkcKhpeg7ovUSbD8sxKt5NDGg830ui4dvyIVzkuLnGKtd7usqbPKY4q
 hh+/0XuLQEX76yBO/5lbzVuWEqIvw0LgELtm7iaGPe4RN/cURrSWkjHAKWatmMqfvj+I
 +dOPEQzBcHa3iTvZjAnqdQWab97eiz9HqZSt1bOQ5BkeMWKsO8trY6v2iUJsejAI+unE
 mKS3AHkFd6rdd8vAyIr9sj0jUBC/SV1sK5xhzSNRJ+JjWalVw10BdggTQeGDAzU0Ai3D
 Fr8nW17Xij2DvXEj6z9p3FR4XNfJAMQ2ukjaBmVV0PV2hDjp3j4DulqVfEvxKpFleNoT
 k4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=e6goZyVTcrpeUHzSgLPbCvH4DkIrEtmKDcNTMHNNMTg=;
 b=bk4Vfoqy8OZY5GIWoTndhj9q9zq40gLhYNLYFgo+iO2GctuPGrsT/heOajaaQLfKsS
 Ay1++3T45smFUjHPlstzHzHRN+RwxU04eXL8+yb3wC7GQWBmPw+cxP4nR8Z/vlXPAsB3
 OMFYspeEKZ/EeCILIapf6veXny41TDQQF6DXFNSwlAT4QSCD1+dcnNQaErjWTe4F2+Wr
 NZRQab76xiI3sFCWSFlcbDC+mT3RWcrInWAcRfySLzwDnHUkTGeh+zjmb+JHFUYj6cpJ
 3+Lc4bJWEc4ATA5zVp+tt0bfrl+n174DBfvhMASAAZ9hKNlECkPMRqK7eHMy3v8OMsjH
 p9yg==
X-Gm-Message-State: APjAAAXL/MwlkHVJvj3ETud5UzXZCMDeod/rsAhj6y5UL6s29tLzMy7N
 j6XrSF4omjL4JnCjFZWFGlL+5kH1+Uaqjg==
X-Google-Smtp-Source: APXvYqyuKa3LKWWWBZ7dqD53Tw7KmOwvlo7D+1E2/IpZyTxBflioS/XVQqMD1mP7wQDpnQifofbnpQ==
X-Received: by 2002:a05:600c:2290:: with SMTP id
 16mr372233wmf.161.1569256830125; 
 Mon, 23 Sep 2019 09:40:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z13sm8650525wrq.51.2019.09.23.09.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 09:40:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EEA6E1FF87;
 Mon, 23 Sep 2019 17:40:28 +0100 (BST)
References: <20190921043256.4575-1-richard.henderson@linaro.org>
 <20190921043256.4575-8-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 7/7] target/alpha: Tidy helper_fp_exc_raise_s
In-reply-to: <20190921043256.4575-8-richard.henderson@linaro.org>
Date: Mon, 23 Sep 2019 17:40:28 +0100
Message-ID: <87lfufarur.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

> Remove a redundant masking of ignore.  Once that's gone it is
> obvious that the system-mode inner test is redundant with the
> outer test.  Move the fpcr_exc_enable masking up and tidy.
>
> No functional change.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/alpha/fpu_helper.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
> index 62a066d902..df8b58963b 100644
> --- a/target/alpha/fpu_helper.c
> +++ b/target/alpha/fpu_helper.c
> @@ -90,25 +90,18 @@ void helper_fp_exc_raise_s(CPUAlphaState *env, uint32=
_t ignore, uint32_t regno)
>      uint32_t exc =3D env->error_code & ~ignore;
>      if (exc) {
>          env->fpcr |=3D exc;
> -        exc &=3D ~ignore;
> -#ifdef CONFIG_USER_ONLY
> -        /*
> -         * In user mode, the kernel's software handler only
> -         * delivers a signal if the exception is enabled.
> -         */
> -        if (!(exc & env->fpcr_exc_enable)) {
> -            return;
> -        }
> -#else
> +        exc &=3D env->fpcr_exc_enable;
>          /*
>           * In system mode, the software handler gets invoked
>           * for any non-ignored exception.
> +         * In user mode, the kernel's software handler only
> +         * delivers a signal if the exception is enabled.
>           */
> +#ifdef CONFIG_USER_ONLY
>          if (!exc) {
>              return;
>          }
>  #endif
> -        exc &=3D env->fpcr_exc_enable;
>          fp_exc_raise1(env, GETPC(), exc, regno, EXC_M_SWC);
>      }
>  }


--
Alex Benn=C3=A9e

