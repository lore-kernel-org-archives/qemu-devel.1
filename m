Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E4BC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E51720675
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EU7N/AEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E51720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icV22-0000Tm-7X
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icV1L-0008RY-Nv
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icV1K-0002H0-D6
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:48:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icV1K-0002GK-5w
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:48:46 -0500
Received: by mail-wr1-x441.google.com with SMTP id a15so8662532wrf.9
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 05:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mkzKBCMjmgJ8XymMNCVuM2hyVfke0dSXJaSagEsc/c0=;
 b=EU7N/AEUkjrlyyFZ2anRl+Wpi7bUbioT1WuXsvmFwlOaWi6AI37CmwT4+VY6tYsn8B
 AjSHmGwZOZ0qzu0u3IXtuW96h/uVkJCvEv7swm17vs6xPCd8qqHikiTOnwRbTl4ADtv/
 GIimAoInlj1Pp9goVgk+ykqM8CGPtnlpDsfh+Swz8oYYB+yrwxMsA5Ij2GjwUuEu/qjW
 Lk7MMEZ6voxviYRKZ7iHZBsAvP2pJ7KxwEyCsHnbEFr0qTSHjg0APk8NkeJn7vXsKrXa
 HeWEL3UoAC8QsVQ8pzQFAJg6s3+lwftlgbPR2c0B9CFJWGc9yMkl41+arzBcwMNv0kcW
 QlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mkzKBCMjmgJ8XymMNCVuM2hyVfke0dSXJaSagEsc/c0=;
 b=VrciQ2/n8vdsfKpKJlBVP3X/amTFLBiplG5i2IiHMlYGs7yaQg0Kd+kzIw+kA0kR2y
 kUamgY6CXdemsECSHjgZhv2qIKT/88TocZyk9tikS/bLVo84pNUcFm5AiEb+5vIeUVbc
 /r8bmPSVqzjCWejZCaVsPjai6WxG2vCQSbx7JwgJgOFu1q0e3c/Y4dAHyd3PGS6EZAyI
 IrdesnVqHXvLRWLTA0w9CoW4XXqgVwN/Zz3RY4OyOAJPhGGvb8sWYlt0M5glkTxMTdlD
 ghzFQTDoGIGO6L9EdXht0lCFLQWKEDhbEWMZJxNmyrM0TLyidI8ghNJPY8n6BFgS88Yt
 RRDA==
X-Gm-Message-State: APjAAAU+HGESNcUh34KKG5AycPgE/3ABkDfK1jfFZ2TbiKujHPmBNnuK
 ikwNN0QRgHHcv/27QvO/jhgnPCdKFXA=
X-Google-Smtp-Source: APXvYqwWLpb/l4M0d6e+02QAoEnk/WqceSnh1uQBeXwJPcVfnl1yjSRi2QMYPaJ1+cDm9hxYPGMN3w==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr4172324wrn.83.1575467323799; 
 Wed, 04 Dec 2019 05:48:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v14sm8278349wrm.28.2019.12.04.05.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 05:48:42 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1404E1FF87;
 Wed,  4 Dec 2019 13:48:42 +0000 (GMT)
References: <87lfrtbtj6.fsf@linaro.org>
 <20191204083133.6198-1-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3] travis.yml: Run tcg tests with tci
In-reply-to: <20191204083133.6198-1-thuth@redhat.com>
Date: Wed, 04 Dec 2019 13:48:42 +0000
Message-ID: <87muc88amd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> So far we only have compile coverage for tci. But since commit
> 2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
> for INDEX_op_ld16u_i64") has been included now, we can also run the
> "tcg" and "qtest" tests with tci, so let's enable them in Travis now.
> Since we don't gain much additional test coverage by compiling all
> targets, and TCI is broken e.g. with the Sparc targets, we also limit
> the target list to a reasonable subset now (which should still get us
> test coverage by tests/boot-serial-test for example).

Queued to testing/next, thanks.
>
> Tested-by: Stefan Weil <sw@weilnetz.de>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v3:
>  - Add --disable-kvm option since we're only interested in TCG here
>
>  .travis.yml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 445b0646c1..d73e2fb744 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -215,10 +215,11 @@ matrix:
>          - TEST_CMD=3D""
>=20=20
>=20=20
> -    # We manually include builds which we disable "make check" for
> +    # Check the TCG interpreter (TCI)
>      - env:
> -        - CONFIG=3D"--enable-debug --enable-tcg-interpreter"
> -        - TEST_CMD=3D""
> +        - CONFIG=3D"--enable-debug --enable-tcg-interpreter --disable-kv=
m --disable-containers
> +            --target-list=3Dalpha-softmmu,arm-softmmu,hppa-softmmu,m68k-=
softmmu,microblaze-softmmu,moxie-softmmu,ppc-softmmu,s390x-softmmu,x86_64-s=
oftmmu"
> +        - TEST_CMD=3D"make check-qtest check-tcg V=3D1"
>=20=20
>=20=20
>      # We don't need to exercise every backend with every front-end


--=20
Alex Benn=C3=A9e

