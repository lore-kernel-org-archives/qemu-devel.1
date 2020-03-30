Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34319C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 11:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0181320733
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 11:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qfFXm0Gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0181320733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIsfq-00013s-2c
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 07:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jIseb-0008Vt-Pl
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 07:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jIsea-0007vB-LJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 07:32:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jIsea-0007tS-7g
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 07:32:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id 31so21153513wrs.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 04:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zCAd2WN6Yp83qUe/B/Pw5GfYoWZ5hgecHKf7fVSrGh0=;
 b=qfFXm0Gck0VoxLFpGZTkfNfNW8EzLIM945URDPi0NXhVW58/Q3golvafNVHUm3YWVY
 hpH5iiUUaPvbOsVA8y/zGtcZHweD2pPmbfYJ2tvtikX94jY7Uj8qrER5R17fHPCAkLag
 Y6FbkaGusF/TXxaPVrBxL3pgMDxKwpNTzS2sLR+lotnbuPK3Majx4nkry8RHxU9MVd+W
 FltD5/lq9dnhean3OKUEEK06X/SogtGt1Z+wx4/ISYkCgY7zRY9sFywBYi9jbnU2MuB0
 kU9+mFb7lO82cRRwJXPlm3T/mEIgB1RagiBbFj4Ic6BCMSxXg46xeKkJpQDuM9y8gwgk
 GUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zCAd2WN6Yp83qUe/B/Pw5GfYoWZ5hgecHKf7fVSrGh0=;
 b=XY3raoHk57Qtc4aSCRT4LB75FBro0WqrA3AA/47/OFJAytF6wjIpkarQrUBplL8Yu6
 AxG9igvCl2xZa/UFU25VKxv+arHUFUkO89STxnqwYZtuFUvQAoQUQsVJ0QrZcT+qf0bj
 kzXKcl20NMxIz9cmWZhLmAQxDvEXwPKLOV+YZ7eQQn5kz1a9BYFJe2Ejt/RcjS5nXOU0
 aQdEO9g62Wjvw3G/Sa4zrmHu3RuDallFbLJcSlJithC7h/wyi2Mkcmfr9sWJZFJ/Pk9v
 +GrCnYf0K5rdVrJ/Pzpa6CjlXdXYFqLB5R7cf+CgJ8h772tU1RnqPiAWz66YNuaEwNrT
 Uq5A==
X-Gm-Message-State: ANhLgQ0IN8q81I9QnBFGK6TLRKh0eZcNti2Fe6WmR3isDGCgFEwpVD8N
 tOkQQt6j/o3AVyvXFfj+mC/z0Q==
X-Google-Smtp-Source: ADFU+vu7dihG9pkfwxyHlwrM4WyHSvQkeGeteP7RquipcOLAY3OoWmR8fLUBn6zRGjdbs4+LZo/vng==
X-Received: by 2002:adf:8182:: with SMTP id 2mr13762573wra.37.1585567946714;
 Mon, 30 Mar 2020 04:32:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k3sm22600975wrw.61.2020.03.30.04.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 04:32:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B29F81FF7E;
 Mon, 30 Mar 2020 12:32:24 +0100 (BST)
References: <20200327232042.10008-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] softfloat: Fix BAD_SHIFT from normalizeFloatx80Subnormal
In-reply-to: <20200327232042.10008-1-richard.henderson@linaro.org>
Date: Mon, 30 Mar 2020 12:32:24 +0100
Message-ID: <87h7y6gjsn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> All other calls to normalize*Subnormal detect zero input before
> the call -- this is the only outlier.  This case can happen with
> +0.0 + +0.0 =3D +0.0 or -0.0 + -0.0 =3D -0.0, so return a zero of
> the correct sign.
>
> Reported-by: Coverity (CID 1421991)
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Queued to for-5.0/random-fixes, thanks.

> ---
>  fpu/softfloat.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 301ce3b537..ae6ba71854 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -5856,6 +5856,9 @@ static floatx80 addFloatx80Sigs(floatx80 a, floatx8=
0 b, flag zSign,
>          zSig1 =3D 0;
>          zSig0 =3D aSig + bSig;
>          if ( aExp =3D=3D 0 ) {
> +            if (zSig0 =3D=3D 0) {
> +                return packFloatx80(zSign, 0, 0);
> +            }
>              normalizeFloatx80Subnormal( zSig0, &zExp, &zSig0 );
>              goto roundAndPack;
>          }


--=20
Alex Benn=C3=A9e

