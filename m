Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47967C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A5121479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/nSaijh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A5121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7mEC-0007Mf-PD
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 15:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7m4q-00055m-Si
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7m4p-0004rG-I1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:45:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43058)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7m4p-0004qi-BU
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:45:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id q17so17202694wrx.10
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=L3sZdVGe93Oonobk9LL1HKyzZUDu1a8yg31vgo6Uk6Y=;
 b=B/nSaijhrP9B1QRhTYNY44TiN5BpeXnlEQOnG/7IhSac0i68oDlOQV6lqiRxr2MH/V
 C4Qm+rCLI9KCq1jTZZJOpR4SOYpNqIkELaOynxo+X+ehTlqozU1i9/QzLD0pl3HBwVS2
 VnOq2Ke/d0Go1DDwxYpOe98p+GeZmrwHlwY0mfSPP9Jv0+S8U2j7BHa2S2S1Gu713i4I
 Dp4ycI4KasSB2c4Ay0tM40RiM/Cj4yU+41pOiMCi1sa/PAeAwnlpTlGNUTU8Uw+uZ0Sc
 QTaQ0ZWPBtzVHaQmDWytxAbzf8WdmzMxLz/YPHVfLodHEZ4WC0U8XthEYCQIx1QZ0mom
 B0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=L3sZdVGe93Oonobk9LL1HKyzZUDu1a8yg31vgo6Uk6Y=;
 b=cmJyMuNKeTgPf57kYuVRvmT6yQr+ot8VSASlatv8ehkrX/ynIquIIrKxiXR6uumcxd
 PYppOiiBuFk6Fha4sdMBslHhZo5UXlmRsBWgkUpt40MjBBH3DJn/m/YPGlaMUI2yT0eK
 haqh9zc6DoSd7lSYxj1+2cCVNML1axP/9jTKNXZ5GVDJGMeuokmWsfXeM4aNUFiW2abm
 8uliYAqFnDW7/DO/J4h3tjlwXLbOvNcxVA2L5u3np7AhyRA/4Tbk0D38P7ph0NrCHRIn
 Jw6sDRYNPvo7fpHok9i+mEKPiZwX9L+fAFUWiY5f1djBU2Liy8BO1JS3J0iTBa8ERbLW
 3YeA==
X-Gm-Message-State: APjAAAWiVhKXsr8lU+r58yZ9nlrx4hDRT+ZPMPS6ui3aTd9KLu1c1RfM
 epOVnzlSq7vT35nRGlTG6QUSjg==
X-Google-Smtp-Source: APXvYqybEwomVc8pG6BfUE2aHjwNOVwDovA6VkVR09/n2GvyiCK/fd+pNEsxsjFDWjFVV61FcLfSOA==
X-Received: by 2002:a5d:4382:: with SMTP id i2mr28688299wrq.297.1568144721620; 
 Tue, 10 Sep 2019 12:45:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q14sm39334451wrc.77.2019.09.10.12.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 12:45:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 615F41FF87;
 Tue, 10 Sep 2019 20:45:20 +0100 (BST)
References: <20190910193408.28917-1-alex.bennee@linaro.org>
 <20190910193408.28917-2-alex.bennee@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
In-reply-to: <20190910193408.28917-2-alex.bennee@linaro.org>
Date: Tue, 10 Sep 2019 20:45:20 +0100
Message-ID: <87blvs0wbz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1 1/4] target/ppc: fix signal delivery for
 ppc64abi32
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> We were incorrectly setting NIP resulting in a segfault. This fixes
> linux-test for this ABI.

Oops, that was at the bottom of my tree for fixing ppc64abi32 which
showed up broken when testing/next enabled the TCG tests for it.

>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  linux-user/ppc/signal.c             | 4 +++-
>  tests/tcg/configure.sh              | 1 +
>  tests/tcg/multiarch/Makefile.target | 5 -----
>  3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
> index 619a56950df..5b82af6cb62 100644
> --- a/linux-user/ppc/signal.c
> +++ b/linux-user/ppc/signal.c
> @@ -501,7 +501,9 @@ void setup_rt_frame(int sig, struct target_sigaction =
*ka,
>      int i, err =3D 0;
>  #if defined(TARGET_PPC64)
>      struct target_sigcontext *sc =3D 0;
> +#if !defined(TARGET_ABI32)
>      struct image_info *image =3D ((TaskState *)thread_cpu->opaque)->info;
> +#endif
>  #endif
>
>      rt_sf_addr =3D get_sigframe(ka, env, sizeof(*rt_sf));
> @@ -557,7 +559,7 @@ void setup_rt_frame(int sig, struct target_sigaction =
*ka,
>      env->gpr[5] =3D (target_ulong) h2g(&rt_sf->uc);
>      env->gpr[6] =3D (target_ulong) h2g(rt_sf);
>
> -#if defined(TARGET_PPC64)
> +#if defined(TARGET_PPC64) && !defined(TARGET_ABI32)
>      if (get_ppc64_abi(image) < 2) {
>          /* ELFv1 PPC64 function pointers are pointers to OPD entries. */
>          struct target_func_ptr *handler =3D
> diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
> index 6c4a471aeae..e8a1a1495fc 100755
> --- a/tests/tcg/configure.sh
> +++ b/tests/tcg/configure.sh
> @@ -54,6 +54,7 @@ fi
>  : ${cross_cc_cflags_ppc=3D"-m32"}
>  : ${cross_cc_ppc64=3D"powerpc-linux-gnu-gcc"}
>  : ${cross_cc_cflags_ppc64=3D"-m64"}
> +: ${cross_cc_cflags_ppc64abi32=3D"-mcpu=3Dpower8"}
>  : ${cross_cc_ppc64le=3D"powerpc64le-linux-gnu-gcc"}
>  : ${cross_cc_cflags_s390x=3D"-m64"}
>  : ${cross_cc_cflags_sparc=3D"-m32 -mv8plus -mcpu=3Dultrasparc"}
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Ma=
kefile.target
> index 6b1e30e2fec..e6893b2e283 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -12,11 +12,6 @@ VPATH 		+=3D $(MULTIARCH_SRC)
>  MULTIARCH_SRCS   =3D$(notdir $(wildcard $(MULTIARCH_SRC)/*.c))
>  MULTIARCH_TESTS  =3D$(MULTIARCH_SRCS:.c=3D)
>
> -# FIXME: ppc64abi32 linux-test seems to have issues but the other basic =
tests work
> -ifeq ($(TARGET_NAME),ppc64abi32)
> -BROKEN_TESTS =3D linux-test
> -endif
> -
>  # Update TESTS
>  TESTS		+=3D $(filter-out $(BROKEN_TESTS), $(MULTIARCH_TESTS))


--
Alex Benn=C3=A9e

