Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC14DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39DD2073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLhLVlRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39DD2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itVYo-0007td-0W
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itVXS-0007LX-7X
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itVXO-00013c-8T
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:48:14 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itVXO-00011v-0n
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:48:10 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so29242769wrh.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 03:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qetT29bnKFaUMfyXC3S0MZLXLBXmKTg5Hq99ZNIU0g4=;
 b=pLhLVlRA086u/o2cAxp9YLq1gkQfq481nTGNBWPpoibhMQbMGrQFV/69GJCxewRMJh
 npCEzZ9vIPYXK98/Y6iEZT58BTCAzMIMKs5HJK8lkRe/RwhIr+z4imfM0aAbvUPzxHG+
 pG7j8JcEtNa8c9oeRLQ8dpkW6g2l46WUaNMsPsJEj7EtebgRAybHKPt2+NUbWBzcyOZg
 NSWTDcGke0gPOHC0X8CoWET1s2J8TCmnLosgbKpdZqvzOPx/BStTBQ8Cg6ENuc78+wob
 0DTKLq91raVRM0pRgXxYasQ+vUHsvDFBDPqkF/Nygqvlv5N7lRN8OxOnIJEiexUfyKUf
 4G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qetT29bnKFaUMfyXC3S0MZLXLBXmKTg5Hq99ZNIU0g4=;
 b=rQttonHQli1hBCgmNSx6WlzrQE47giQ8EnAIYBjh9DSpQAzsevtKb5WTxMye5OUfVs
 mK+EwXyLQC3mi+BemuiCDxBOEdLryl+TC7VLl/DrqeZywiOwiKLAJWVEb02PxAnq9gaM
 wd5detAslbIX7QlOERJeO4gFl05EwP/NpBlHIkDA1ZoRwyhuzb5xxwGjtE3vgp3GJU6h
 en/TtoiVN0fhjpytDRKgn5Z15dRjldSjKwGG5DkHRgpVk8FGBSDjTY7gSW8mMlfQsfaQ
 yj5lfF5AeLEIFuASCAwd1lfGgxltSLZciEWTSrvGZMdKWoEQX6sQmpzaubad+rNIbnyN
 9eXA==
X-Gm-Message-State: APjAAAUny0WPah/m1rQnfgGMLIkDeiVQ+6v9YMa9xAzEnnZiOAzjYMyT
 K9O6yclAh5Rz+6GqkAwGaoIZQA==
X-Google-Smtp-Source: APXvYqw0cmuvnx0mT/tZI4v/aiyN6EdycEz+wcIkbI9ZkoUfGXyTkVLSzAttCTGgELNOIK0B20DL7g==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr17508566wrr.82.1579520888561; 
 Mon, 20 Jan 2020 03:48:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h2sm48132814wrv.66.2020.01.20.03.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 03:48:07 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9EB161FF87;
 Mon, 20 Jan 2020 11:48:06 +0000 (GMT)
References: <20200116194341.402-1-richard.henderson@linaro.org>
 <20200116194341.402-4-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 3/5] linux-user/i386: Emulate x86_64 vsyscalls
In-reply-to: <20200116194341.402-4-richard.henderson@linaro.org>
Date: Mon, 20 Jan 2020 11:48:06 +0000
Message-ID: <87v9p62vt5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Notice the magic page during translate, much like we already
> do for the arm32 commpage.  At runtime, raise an exception to
> return cpu_loop for emulation.
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/cpu.h          |   1 +
>  linux-user/i386/cpu_loop.c | 105 +++++++++++++++++++++++++++++++++++++
>  target/i386/translate.c    |  16 +++++-
>  3 files changed, 121 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 164d038d1f..3fb2d2a986 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1000,6 +1000,7 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
>=20=20
>  #define EXCP_VMEXIT     0x100 /* only for system emulation */
>  #define EXCP_SYSCALL    0x101 /* only for user emulation */
> +#define EXCP_VSYSCALL   0x102 /* only for user emulation */
>=20=20
>  /* i386-specific interrupt pending bits.  */
>  #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
> diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
> index e217cca5ee..f9bf6cec27 100644
> --- a/linux-user/i386/cpu_loop.c
> +++ b/linux-user/i386/cpu_loop.c
> @@ -92,6 +92,106 @@ static void gen_signal(CPUX86State *env, int sig, int=
 code, abi_ptr addr)
>      queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
>  }
>=20=20
> +#ifdef TARGET_X86_64
> +static bool write_ok_or_segv(CPUX86State *env, abi_ptr addr, size_t len)
> +{
> +    /*
> +     * For all the vsyscalls, NULL means "don't write anything" not
> +     * "write it at address 0".
> +     */
> +    if (addr =3D=3D 0 || access_ok(VERIFY_WRITE, addr, len)) {
> +        return true;
> +    }
> +
> +    env->error_code =3D PG_ERROR_W_MASK | PG_ERROR_U_MASK;
> +    gen_signal(env, TARGET_SIGSEGV, TARGET_SEGV_MAPERR, addr);
> +    return false;
> +}
> +
> +/*
> + * Since v3.1, the kernel traps and emulates the vsyscall page.
> + * Entry points other than the official generate SIGSEGV.
> + */
> +static void emulate_vsyscall(CPUX86State *env)
> +{
> +    int syscall;
> +    abi_ulong ret;
> +    uint64_t caller;
> +
> +    /*
> +     * Validate the entry point.  We have already validated the page
> +     * during translation, now verify the offset.
> +     */
> +    switch (env->eip & ~TARGET_PAGE_MASK) {
> +    case 0x000:
> +        syscall =3D TARGET_NR_gettimeofday;
> +        break;
> +    case 0x400:
> +        syscall =3D TARGET_NR_time;
> +        break;
> +    case 0x800:
> +        syscall =3D TARGET_NR_getcpu;
> +        break;
> +    default:
> +    sigsegv:

this label looks a little extraneous.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

