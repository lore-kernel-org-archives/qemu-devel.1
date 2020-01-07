Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731C6C33C9B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40801222D9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flyWfm8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40801222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopv6-00052R-4Y
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iooRp-0004i0-Hm
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:59:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iooRo-0003kT-9F
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:59:01 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53567)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iooRo-0003js-0y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:59:00 -0500
Received: by mail-wm1-x342.google.com with SMTP id m24so18837525wmc.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 04:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=i175rk+8Kf76ICDOtYMU2bYqO0QEH6Bb0CbJbkc9bB0=;
 b=flyWfm8UG2uzTG/ieRXVNDHie23TgVWxnNns1B8M+Go4dTs32GoIh559B6DepQyBiL
 rxPuazM4yDscM/QCwKo4ZJtvpjk+U3sqqHB/Mqq3qBEdJAP0hbqKAvDLxPis98xuNTZ9
 om8FLW/b2YJ35+J0qpXBfMnjLgMryajZeXSUS2ZIIRBbfQyICjB9T/dBvx3KT7GvKYVk
 G3ooLmc58I3vvgJ64/tmE1bHD7bWzMKmiaQ2VjyEki3ZGljqyRHQei7SId/5OiXEWY1e
 kxqnPLfKy/8eRUMu58AJ9MZtAHAu3Wrp0mZHgZX/+StJn8LNxicJk1bxhA4P3gBARje8
 eBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=i175rk+8Kf76ICDOtYMU2bYqO0QEH6Bb0CbJbkc9bB0=;
 b=RdAMuZ4lQUO2GkU6eXKYs7/fi3afWOC5Y5ViCE3d1HG3b72YUWN1cD5tjnusq20xNw
 Te0FRCYsbgnxEV+7gV56LQq6PFrr0TXSO3k9ork7UG+xsfTYEMiLb3pod8t+QvUDc80t
 gIhLxuqSIJHNIlXbnAC1FNMh60q6sp2EX7NNhUNsvjsqMZ+uDqzSP9Vnx4E/THqZLl13
 fcLKybsbfUOuZQ/ROczOlo0qldqC8O6rRNWN0FKx4VYqdx2DO7biRkHHyJhprsQm5bXl
 hyjL9UB/gefYED354BKHHRuBKrgq/KMnv+T0j1u5cKKEQ8yy37OmEnsHXhiUzhLG3eUI
 eFeg==
X-Gm-Message-State: APjAAAWLtQwmVdaCI+OCmHRov5qXah6rPFLu6QujvPS3U3plP0GxuUNN
 VJdH4n5S3VQsxA4lm6rfbLaPEQ==
X-Google-Smtp-Source: APXvYqwM6D2y9dGpFnMnLlD60QlAF/cqIW6puzQAWx/1LEMDBnzkDeSmY4+6AOgyv2vuc20IAn7TAA==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr41632804wmh.22.1578401938827; 
 Tue, 07 Jan 2020 04:58:58 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p18sm26723207wmg.4.2020.01.07.04.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 04:58:57 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D15751FF87;
 Tue,  7 Jan 2020 12:58:56 +0000 (GMT)
References: <20191218223441.23852-1-richard.henderson@linaro.org>
 <20191218223441.23852-4-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/7] configure: Do not force pie=no for non-x86
In-reply-to: <20191218223441.23852-4-richard.henderson@linaro.org>
Date: Tue, 07 Jan 2020 12:58:56 +0000
Message-ID: <87r20b4e3z.fsf@linaro.org>
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
Cc: berrange@redhat.com, i@maskray.me, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> PIE is supported on many other hosts besides x86.
>
> The default for non-x86 is now the same as x86: pie is used
> if supported, and may be forced via --enable/--disable-pie.
>
> The original commit (40d6444e91c) said:
>
>   "Non-x86 are not changed, as they require TCG changes"
>
> but I think that's wrong -- there's nothing about PIE that
> affects TCG one way or another.
>
> Tested on aarch64 (bionic) and ppc64le (centos 7) hosts.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Also I double checked OpenBSD still worked:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  configure | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/configure b/configure
> index 30e3875c6b..99faf64a74 100755
> --- a/configure
> +++ b/configure
> @@ -2018,16 +2018,6 @@ if ! compile_prog "-Werror" "" ; then
>  	"Thread-Local Storage (TLS). Please upgrade to a version that does."
>  fi
>=20=20
> -if test "$pie" =3D ""; then
> -  case "$cpu-$targetos" in
> -    i386-Linux|x86_64-Linux|x32-Linux|i386-OpenBSD|x86_64-OpenBSD)
> -      ;;
> -    *)
> -      pie=3D"no"
> -      ;;
> -  esac
> -fi
> -
>  if test "$pie" !=3D "no" ; then
>    cat > $TMPC << EOF


--=20
Alex Benn=C3=A9e

