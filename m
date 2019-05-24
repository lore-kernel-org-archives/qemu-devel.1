Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC18C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B0D217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txcGQ5x+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B0D217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51575 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU6XA-0006s3-TG
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 05:30:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hU6WF-0006My-KI
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hU6WD-0002tt-SJ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:29:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hU6WD-0002tP-KK
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:29:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id x64so8600316wmb.5
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 02:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=TVXpH3ZlIh57Nl/3gMEJpM5zOpuWdUxsneJdlduIvI8=;
	b=txcGQ5x+cVEoOeMZ+aeFpLfDOy7B3SrOeAtXOYw82hNRF7eb8DaGLvDjmVUfma25BT
	0pjm5T/uKX9HBddm5dDgyBUZOYNlToX+b+ELRTjKqPyeJGJD7wze+I+OCfRNTnIOdLyJ
	ARboYCGpkNBxIRdbKz0a9bZBrAN4fLvDm1zLa2qBQPw0zCygmrW4ynLWf3R7nVggYA+Z
	aiYBL3ttQEsdXVskKJCQCWh/Zh2z65xg1fU+cH2sNKgQotAKc9pm8562R82nFvGaSLjr
	1AwMNIvefTVVB8oTbqd7fNx9vPIeVNsyOF3i9jptDlVBQJ/o9uhv5/ZR/GKQMTPLBaJl
	A6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=TVXpH3ZlIh57Nl/3gMEJpM5zOpuWdUxsneJdlduIvI8=;
	b=jRnFKk/tzAUkezrOAoCewCB7V+iZ8nrB+8oe/OGUxythd/EXjg2JK/sN22L17wuu+q
	EN5fg94cZ90Jwr/dz2KAZt1KH6+EiFpqV1absdJt6WHYonBWmCZpWn9Rb6Kp5/FfZioa
	x4DwI3H677QuogvaL+Rwh52Q71zQi8hfTcPm2lLLU0gT07XxoQNtwywSDOJBXigBglIB
	qK846jQp0gsSOs9wOgpj2BhW2rjWjicijtRnTxWF0RMwfVYY0wPtFr+03FK5WaYj/oti
	gUFJDuZxTgF+YhiUuQVv0w4MDMOwvGENL7wQmFFylVr8JHbC5P9l18LiO6pfMZuqrZdp
	uYgg==
X-Gm-Message-State: APjAAAXmHIAr+jnRJ/jZWj/Pc8V2zZwuq6OK+6c0hpgLMFK9nnxrT3FS
	0IPr0npvG/mKaKuB4o7fwXvwTQ==
X-Google-Smtp-Source: APXvYqyveq348xLlSBIQ8xgli5tvGI1FwNkLzAnAbAqEt2uplyyAUd6A7dg6+f4Z+M1C+CmcUbNffg==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr16048004wma.130.1558690180390; 
	Fri, 24 May 2019 02:29:40 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id a14sm2235681wrv.3.2019.05.24.02.29.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 02:29:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7B9791FF87;
	Fri, 24 May 2019 10:29:39 +0100 (BST)
References: <20190523204409.21068-1-jan.bobek@gmail.com>
	<20190523204409.21068-10-jan.bobek@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190523204409.21068-10-jan.bobek@gmail.com>
Date: Fri, 24 May 2019 10:29:39 +0100
Message-ID: <87blzs19q4.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [RISU v3 09/11] i386: Add avx512 state to reginfo_t
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Bobek <jan.bobek@gmail.com> writes:

> From: Richard Henderson <richard.henderson@linaro.org>
>
> The state expected for a given test must be specifically requested
> with the --xfeatures=3Dmask command-line argument.  This is recorded
> with the saved state so that it is obvious if the apprentice is given
> a different argument.  Any features beyond what are present on the
> running cpu will read as zero.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  risu_reginfo_i386.h |  14 +++
>  risu_reginfo_i386.c | 228 ++++++++++++++++++++++++++++++++++++++++++--
>  test_i386.S         |  39 ++++++++
>  3 files changed, 273 insertions(+), 8 deletions(-)
>
> diff --git a/risu_reginfo_i386.h b/risu_reginfo_i386.h
> index e350f01..b468f79 100644
> --- a/risu_reginfo_i386.h
> +++ b/risu_reginfo_i386.h
> @@ -12,6 +12,10 @@
>  #ifndef RISU_REGINFO_I386_H
>  #define RISU_REGINFO_I386_H
>
> +struct avx512_reg {
> +    uint64_t q[8];
> +};
> +
>  /*
>   * This is the data structure we pass over the socket.
>   * It is a simplified and reduced subset of what can
> @@ -19,7 +23,17 @@
>   */
>  struct reginfo {
>      uint32_t faulting_insn;
> +    uint32_t mxcsr;
> +    uint64_t xfeatures;
> +
>      gregset_t gregs;
> +
> +#ifdef __x86_64__
> +    struct avx512_reg vregs[32];
> +#else
> +    struct avx512_reg vregs[8];
> +#endif
> +    uint64_t kregs[8];
>  };
>
>  /*
> diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
> index c4dc14a..83f9541 100644
> --- a/risu_reginfo_i386.c
> +++ b/risu_reginfo_i386.c
> @@ -11,19 +11,32 @@
>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <stddef.h>
>  #include <string.h>
>  #include <ucontext.h>
>  #include <assert.h>
> +#include <cpuid.h>
>
>  #include "risu.h"
>  #include "risu_reginfo_i386.h"
>
> -const struct option * const arch_long_opts;
> -const char * const arch_extra_help;
> +#include <asm/sigcontext.h>
> +
> +static uint64_t xfeatures =3D 3;  /* SSE */
> +
> +static const struct option extra_ops[] =3D {
> +    {"xfeatures", required_argument, NULL, FIRST_ARCH_OPT },
> +    {0, 0, 0, 0}
> +};
> +
> +const struct option * const arch_long_opts =3D extra_ops;
> +const char * const arch_extra_help
> +    =3D "  --xfeatures=3D<mask>  Use features in mask for XSAVE\n";
>
>  void process_arch_opt(int opt, const char *arg)
>  {
> -    abort();
> +    assert(opt =3D=3D FIRST_ARCH_OPT);
> +    xfeatures =3D strtoull(arg, 0, 0);
>  }
>
>  const int reginfo_size(void)
> @@ -31,13 +44,37 @@ const int reginfo_size(void)
>      return sizeof(struct reginfo);
>  }
>
> +static void *xsave_feature_buf(struct _xstate *xs, int feature)
> +{
> +    unsigned int eax, ebx, ecx, edx;
> +    int ok;
> +
> +    /*
> +     * Get the location of the XSAVE feature from the cpuid leaf.
> +     * Given that we know the xfeature bit is set, this must succeed.
> +     */
> +    ok =3D __get_cpuid_count(0xd, feature, &eax, &ebx, &ecx, &edx);
> +    assert(ok);
> +
> +    /* Sanity check that the frame stored by the kernel contains the dat=
a. */
> +    assert(xs->fpstate.sw_reserved.extended_size >=3D eax + ebx);
> +
> +    return (void *)xs + ebx;
> +}
> +
>  /* reginfo_init: initialize with a ucontext */
>  void reginfo_init(struct reginfo *ri, ucontext_t *uc)
>  {
> -    int i;
> +    int i, nvecregs;
> +    struct _fpstate *fp;
> +    struct _xstate *xs;
> +    uint64_t features;
>
>      memset(ri, 0, sizeof(*ri));
>
> +    /* Require master and apprentice to be given the same arguments.  */
> +    ri->xfeatures =3D xfeatures;
> +
>      for (i =3D 0; i < NGREG; i++) {
>          switch (i) {
>          case REG_E(IP):
> @@ -79,12 +116,89 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
>       * distinguish 'do compare' from 'stop'.
>       */
>      ri->faulting_insn =3D *(uint32_t *)uc->uc_mcontext.gregs[REG_E(IP)];
> +
> +    /*
> +     * FP state is omitted if unused (aka in init state).
> +     * Use the <asm/sigcontext.h> struct for access to AVX state.
> +     */
> +
> +    fp =3D (struct _fpstate *)uc->uc_mcontext.fpregs;
> +    if (fp =3D=3D NULL) {
> +        return;
> +    }
> +
> +#ifdef __x86_64__
> +    nvecregs =3D 16;
> +#else
> +    /* We don't (currently) care about the 80387 state, only SSE+.  */
> +    if (fp->magic !=3D X86_FXSR_MAGIC) {
> +        return;
> +    }
> +    nvecregs =3D 8;
> +#endif
> +
> +    /*
> +     * Now we know that _fpstate contains FXSAVE data.
> +     */
> +    ri->mxcsr =3D fp->mxcsr;
> +
> +    for (i =3D 0; i < nvecregs; ++i) {
> +#ifdef __x86_64__
> +        memcpy(&ri->vregs[i], &fp->xmm_space[i * 4], 16);
> +#else
> +        memcpy(&ri->vregs[i], &fp->_xmm[i], 16);
> +#endif
> +    }
> +
> +    if (fp->sw_reserved.magic1 !=3D FP_XSTATE_MAGIC1) {
> +        return;
> +    }
> +    xs =3D (struct _xstate *)fp;
> +    features =3D xfeatures & xs->xstate_hdr.xfeatures;
> +
> +    /*
> +     * Now we know that _fpstate contains XSAVE data.
> +     */
> +
> +    if (features & (1 << 2)) {
> +        /* YMM_Hi128 state */
> +        void *buf =3D xsave_feature_buf(xs, 2);
> +        for (i =3D 0; i < nvecregs; ++i) {
> +            memcpy(&ri->vregs[i].q[2], buf + 16 * i, 16);
> +        }
> +    }
> +
> +    if (features & (1 << 5)) {
> +        /* Opmask state */
> +        uint64_t *buf =3D xsave_feature_buf(xs, 5);
> +        for (i =3D 0; i < 8; ++i) {
> +            ri->kregs[i] =3D buf[i];
> +        }
> +    }
> +
> +    if (features & (1 << 6)) {
> +        /* ZMM_Hi256 state */
> +        void *buf =3D xsave_feature_buf(xs, 6);
> +        for (i =3D 0; i < nvecregs; ++i) {
> +            memcpy(&ri->vregs[i].q[4], buf + 32 * i, 32);
> +        }
> +    }
> +
> +#ifdef __x86_64__
> +    if (features & (1 << 7)) {
> +        /* Hi16_ZMM state */
> +        void *buf =3D xsave_feature_buf(xs, 7);
> +        for (i =3D 0; i < 16; ++i) {
> +            memcpy(&ri->vregs[i + 16], buf + 64 * i, 64);
> +        }
> +    }
> +#endif
>  }
>
>  /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal =
*/
>  int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
>  {
> -    return 0 =3D=3D memcmp(m, a, sizeof(*m));
> +    return !memcmp(m, a, sizeof(*m));
>  }
>
>  static const char *const regname[NGREG] =3D {
> @@ -126,28 +240,126 @@ static const char *const regname[NGREG] =3D {
>  # define PRIxREG   "%08x"
>  #endif
>
> +static int get_nvecregs(uint64_t features)
> +{
> +#ifdef __x86_64__
> +    return features & (1 << 7) ? 32 : 16;
> +#else
> +    return 8;
> +#endif
> +}
> +
> +static int get_nvecquads(uint64_t features)
> +{
> +    if (features & (1 << 6)) {
> +        return 8;
> +    } else if (features & (1 << 2)) {
> +        return 4;
> +    } else {
> +        return 2;
> +    }
> +}
> +
> +static char get_vecletter(uint64_t features)
> +{
> +    if (features & (1 << 6 | 1 << 7)) {
> +        return 'z';
> +    } else if (features & (1 << 2)) {
> +        return 'y';
> +    } else {
> +        return 'x';
> +    }
> +}
> +
>  /* reginfo_dump: print state to a stream, returns nonzero on success */
>  int reginfo_dump(struct reginfo *ri, FILE *f)
>  {
> -    int i;
> +    uint64_t features;
> +    int i, j, n, w;
> +    char r;
> +
>      fprintf(f, "  faulting insn %x\n", ri->faulting_insn);
>      for (i =3D 0; i < NGREG; i++) {
>          if (regname[i]) {
>              fprintf(f, "  %-6s: " PRIxREG "\n", regname[i], ri->gregs[i]=
);
>          }
>      }
> +
> +    fprintf(f, "  mxcsr : %x\n", ri->mxcsr);
> +    fprintf(f, "  xfeat : %" PRIx64 "\n", ri->xfeatures);
> +
> +    features =3D ri->xfeatures;
> +    n =3D get_nvecregs(features);
> +    w =3D get_nvecquads(features);
> +    r =3D get_vecletter(features);
> +
> +    for (i =3D 0; i < n; i++) {
> +        fprintf(f, "  %cmm%-3d: ", r, i);
> +        for (j =3D w - 1; j >=3D 0; j--) {
> +            fprintf(f, "%016" PRIx64 "%c",
> +                    ri->vregs[i].q[j], j =3D=3D 0 ? '\n' : ' ');
> +        }
> +    }
> +
> +    if (features & (1 << 5)) {
> +        for (i =3D 0; i < 8; i++) {
> +            fprintf(f, "  k%-5d: %016" PRIx64 "\n", i, ri->kregs[i]);
> +        }
> +    }
> +
>      return !ferror(f);
>  }
>
>  int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
>  {
> -    int i;
> +    int i, j, n, w;
> +    uint64_t features;
> +    char r;
> +
> +    fprintf(f, "Mismatch (master v apprentice):\n");
> +
>      for (i =3D 0; i < NGREG; i++) {
>          if (m->gregs[i] !=3D a->gregs[i]) {
>              assert(regname[i]);
> -            fprintf(f, "Mismatch: %s: " PRIxREG " v " PRIxREG "\n",
> +            fprintf(f, "  %-6s: " PRIxREG " v " PRIxREG "\n",
>                      regname[i], m->gregs[i], a->gregs[i]);
>          }
>      }
> +
> +    if (m->mxcsr !=3D a->mxcsr) {
> +        fprintf(f, "  mxcsr : %x v %x\n", m->mxcsr, a->mxcsr);
> +    }
> +    if (m->xfeatures !=3D a->xfeatures) {
> +        fprintf(f, "  xfeat : %" PRIx64 " v %" PRIx64 "\n",
> +                m->xfeatures, a->xfeatures);
> +    }
> +
> +    features =3D m->xfeatures;
> +    n =3D get_nvecregs(features);
> +    w =3D get_nvecquads(features);
> +    r =3D get_vecletter(features);
> +
> +    for (i =3D 0; i < n; i++) {
> +        if (memcmp(&m->vregs[i], &a->vregs[i], w * 8)) {
> +            fprintf(f, "  %cmm%-3d: ", r, i);
> +            for (j =3D w - 1; j >=3D 0; j--) {
> +                fprintf(f, "%016" PRIx64 "%c",
> +                        m->vregs[i].q[j], j =3D=3D 0 ? '\n' : ' ');
> +            }
> +            fprintf(f, "       v: ");
> +            for (j =3D w - 1; j >=3D 0; j--) {
> +                fprintf(f, "%016" PRIx64 "%c",
> +                        a->vregs[i].q[j], j =3D=3D 0 ? '\n' : ' ');
> +            }
> +        }
> +    }
> +
> +    for (i =3D 0; i < 8; i++) {
> +        if (m->kregs[i] !=3D a->kregs[i]) {
> +            fprintf(f, "  k%-5d: %016" PRIx64 " v %016" PRIx64 "\n",
> +                    i, m->kregs[i], a->kregs[i]);
> +        }
> +    }
> +
>      return !ferror(f);
>  }
> diff --git a/test_i386.S b/test_i386.S
> index 456b99c..05344d7 100644
> --- a/test_i386.S
> +++ b/test_i386.S
> @@ -12,6 +12,37 @@
>  /* A trivial test image for x86 */
>
>  /* Initialise the registers to avoid spurious mismatches */
> +
> +#ifdef __x86_64__
> +#define BASE	%rax
> +	lea	2f(%rip), BASE
> +#else
> +#define BASE	%eax
> +	call	1f
> +1:	pop	BASE
> +	add	$2f-1b, BASE
> +#endif
> +
> +	movdqa	0(BASE), %xmm0
> +	movdqa	1*16(BASE), %xmm1
> +	movdqa	2*16(BASE), %xmm2
> +	movdqa	3*16(BASE), %xmm3
> +	movdqa	4*16(BASE), %xmm4
> +	movdqa	5*16(BASE), %xmm5
> +	movdqa	6*16(BASE), %xmm6
> +	movdqa	7*16(BASE), %xmm7
> +
> +#ifdef __x86_64__
> +	movdqa	8*16(BASE), %xmm8
> +	movdqa	9*16(BASE), %xmm9
> +	movdqa	10*16(BASE), %xmm10
> +	movdqa	11*16(BASE), %xmm11
> +	movdqa	12*16(BASE), %xmm12
> +	movdqa	13*16(BASE), %xmm13
> +	movdqa	14*16(BASE), %xmm14
> +	movdqa	15*16(BASE), %xmm15
> +#endif
> +
>  	xor	%eax, %eax
>  	sahf				/* init eflags */
>
> @@ -39,3 +70,11 @@
>
>  /* exit test */
>  	ud1	%ecx, %eax
> +
> +	.p2align 16
> +2:
> +	.set	i, 0
> +	.rept	256
> +	.byte	i
> +	.set	i, i + 1
> +	.endr


--
Alex Benn=C3=A9e

