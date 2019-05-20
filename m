Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FBCC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E1A20656
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vb1bbOQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E1A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34602 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShAC-0005Sq-2J
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 08:13:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hSh8s-0004p4-Gz
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hSh8r-0001fi-7b
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:11:46 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hSh8q-0001f0-WF
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:11:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id y3so13050894wmm.2
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 05:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=eIxHZLqSD9RgVT3udenPNLoYboJQ/9agUtJJ4YCdVZc=;
	b=vb1bbOQ2BABQw50m092xL0kl/J5I8tLTj0YTYMi+OLoJSm0J/umsOxR3D1bLZTI290
	W2yiwTTzrdy8OWE77Cv31UcV1NCpbNbgszOAqfHk9nKl4bTNT7vrudKUu2fSbBDqtU4w
	aOTDytT3OWE1cIoTwsDRJ+zXBqlYY/Q535schc29B6mWHW7XyKWuj8dT3V4gm6n0I/dU
	V69FSuhrl3RVhjydhF5qShkNwuH3XUeOiNWmwDam4GLDsBtU9ozgyr+mQupGjji1ACHR
	CajJqPhLUrr9ERQD5SeR7M5YyPl6oKn/9Fep8Qld6f2nDkFaJG+KAg8Y8NemGOlUrqZ3
	ytaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=eIxHZLqSD9RgVT3udenPNLoYboJQ/9agUtJJ4YCdVZc=;
	b=OLcCdz/gMXYT/47NMTNLOrN+U4jv7eIXn/f2tH225aA2kKrOIo0C1bg8apFfk6zdQn
	Ozgn02TaZn46IUnTpNOwxCkuf6nZarcJTyNK7CpAipcbP2KTZI1PUrpAlewY+naPCvAN
	6bkh//0jPNHzHdJ3oHRLU/cXWSB/8VXHs8O9b/kMlVIlxUhCL42OklFM8UG1ubABAfew
	nCbTqRkNfM7Ha4lPYQfsGFCKqCzO9fQmRxXKT/LIcibr72HV8Vog39lAmGhfEBtPWiL2
	nDgmCQh2r9FgNCO+eL/8/Y5SSsVLd1E/yjGQEYThG9GkWLJIle1PtsW4J47l8ZmYA25L
	iUVQ==
X-Gm-Message-State: APjAAAVBuigfk3xI/1TW7Rmm1oRWIqiA1GNpeav+pRgVgrWM8k8iCuYu
	DjUz7kiuWAVo7B14vioQ0O83/g==
X-Google-Smtp-Source: APXvYqzGutqRDEhxw7TzoHpyi7NCBxXNHO0PHGlTX9GYy4Qs7ppyO9iYOVKGFVDxirTkgAfWnwr8HQ==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr12074108wmk.9.1558354303590;
	Mon, 20 May 2019 05:11:43 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	c63sm17861281wma.29.2019.05.20.05.11.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 05:11:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 6CAD11FF87;
	Mon, 20 May 2019 13:11:42 +0100 (BST)
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-5-jan.bobek@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190517224450.15566-5-jan.bobek@gmail.com>
Date: Mon, 20 May 2019 13:11:42 +0100
Message-ID: <8736l9iav5.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [RISU v2 04/11] risu_reginfo_i386: implement
 arch-specific reginfo interface
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

> CPU-specific code in risu_reginfo_* is expected to define and export
> the following symbols:
>
> - arch_long_opts, arch_extra_help, process_arch_opt
> - reginfo_size
> - reginfo_init
> - reginfo_is_eq
> - reginfo_dump, reginfo_dump_mismatch
>
> Make risu_reginfo_i386.c implement this interface; and while we're at
> it, expand the support to x86_64 as well.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  risu_reginfo_i386.h |  24 ++++----
>  risu_reginfo_i386.c | 147 ++++++++++++++++++++++++++++++++++----------
>  2 files changed, 127 insertions(+), 44 deletions(-)
>
> diff --git a/risu_reginfo_i386.h b/risu_reginfo_i386.h
> index 5bba439..e350f01 100644
> --- a/risu_reginfo_i386.h
> +++ b/risu_reginfo_i386.h
> @@ -12,7 +12,8 @@
>  #ifndef RISU_REGINFO_I386_H
>  #define RISU_REGINFO_I386_H
>
> -/* This is the data structure we pass over the socket.
> +/*
> + * This is the data structure we pass over the socket.
>   * It is a simplified and reduced subset of what can
>   * be obtained with a ucontext_t*
>   */
> @@ -21,17 +22,14 @@ struct reginfo {
>      gregset_t gregs;
>  };
>
> -#ifndef REG_GS
> -/* Assume that either we get all these defines or none */
> -#   define REG_GS      0
> -#   define REG_FS      1
> -#   define REG_ES      2
> -#   define REG_DS      3
> -#   define REG_ESP     7
> -#   define REG_TRAPNO 12
> -#   define REG_EIP    14
> -#   define REG_EFL    16
> -#   define REG_UESP   17
> -#endif /* !defined(REG_GS) */
> +/*
> + * For i386, the defines are named REG_EAX, etc.
> + * For x86_64, the defines are named REG_RAX, etc.
> + */
> +#ifdef __x86_64__
> +# define REG_E(X)   REG_R##X
> +#else
> +# define REG_E(X)   REG_E##X
> +#endif
>
>  #endif /* RISU_REGINFO_I386_H */
> diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
> index e8d671f..c4dc14a 100644
> --- a/risu_reginfo_i386.c
> +++ b/risu_reginfo_i386.c
> @@ -10,59 +10,144 @@
>   ***********************************************************************=
*******/
>
>  #include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
>  #include <ucontext.h>
> +#include <assert.h>
>
>  #include "risu.h"
>  #include "risu_reginfo_i386.h"
>
> -static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
> +const struct option * const arch_long_opts;
> +const char * const arch_extra_help;
> +
> +void process_arch_opt(int opt, const char *arg)
> +{
> +    abort();
> +}
> +
> +const int reginfo_size(void)
> +{
> +    return sizeof(struct reginfo);
> +}
> +
> +/* reginfo_init: initialize with a ucontext */
> +void reginfo_init(struct reginfo *ri, ucontext_t *uc)
>  {
>      int i;
> +
> +    memset(ri, 0, sizeof(*ri));
> +
>      for (i =3D 0; i < NGREG; i++) {
>          switch (i) {
> -        case REG_ESP:
> -        case REG_UESP:
> -        case REG_GS:
> -        case REG_FS:
> -        case REG_ES:
> -        case REG_DS:
> -        case REG_TRAPNO:
> -        case REG_EFL:
> -            /* Don't store these registers as it results in mismatches.
> -             * In particular valgrind has different values for some
> -             * segment registers, and they're boring anyway.
> -             * We really shouldn't be ignoring EFL but valgrind doesn't
> -             * seem to set it right and I don't care to investigate.
> -             */
> -            ri->gregs[i] =3D 0xDEADBEEF;
> -            break;
> -        case REG_EIP:
> -            /* Store the offset from the start of the test image */
> +        case REG_E(IP):
> +            /* Store the offset from the start of the test image.  */
>              ri->gregs[i] =3D uc->uc_mcontext.gregs[i] - image_start_addr=
ess;
>              break;
> -        default:
> +        case REG_EFL:
> +            /* Store only the "flaggy" bits: SF, ZF, AF, PF, CF.  */
> +            ri->gregs[i] =3D uc->uc_mcontext.gregs[i] & 0xd5;
> +            break;
> +        case REG_E(SP):
> +            /* Ignore the stack.  */
> +            ri->gregs[i] =3D 0xdeadbeef;
> +            break;
> +        case REG_E(AX):
> +        case REG_E(BX):
> +        case REG_E(CX):
> +        case REG_E(DX):
> +        case REG_E(DI):
> +        case REG_E(SI):
> +        case REG_E(BP):
> +#ifdef __x86_64__
> +        case REG_R8:
> +        case REG_R9:
> +        case REG_R10:
> +        case REG_R11:
> +        case REG_R12:
> +        case REG_R13:
> +        case REG_R14:
> +        case REG_R15:
> +#endif
>              ri->gregs[i] =3D uc->uc_mcontext.gregs[i];
>              break;
>          }
>      }
> -    /* x86 insns aren't 32 bit but we're not really testing x86 so
> -     * this is just to distinguish 'do compare' from 'stop'
> +
> +    /*
> +     * x86 insns aren't 32 bit but 3 bytes are sufficient to
> +     * distinguish 'do compare' from 'stop'.
>       */
> -    ri->faulting_insn =3D *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
> +    ri->faulting_insn =3D *(uint32_t *)uc->uc_mcontext.gregs[REG_E(IP)];
>  }
>
> -static char *regname[] =3D {
> -    "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
> -    "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
> -    "CS", "EFL", "UESP", "SS", 0
> +/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal =
*/
> +int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
> +{
> +    return 0 =3D=3D memcmp(m, a, sizeof(*m));
> +}
> +
> +static const char *const regname[NGREG] =3D {
> +    [REG_EFL] =3D "eflags",
> +#ifdef __x86_64__
> +    [REG_RIP] =3D "rip",
> +    [REG_RAX] =3D "rax",
> +    [REG_RBX] =3D "rbx",
> +    [REG_RCX] =3D "rcx",
> +    [REG_RDX] =3D "rdx",
> +    [REG_RDI] =3D "rdi",
> +    [REG_RSI] =3D "rsi",
> +    [REG_RBP] =3D "rbp",
> +    [REG_RSP] =3D "rsp",
> +    [REG_R8]  =3D "r8",
> +    [REG_R9]  =3D "r9",
> +    [REG_R10] =3D "r10",
> +    [REG_R11] =3D "r11",
> +    [REG_R12] =3D "r12",
> +    [REG_R13] =3D "r13",
> +    [REG_R14] =3D "r14",
> +    [REG_R15] =3D "r15",
> +#else
> +    [REG_EIP] =3D "eip",
> +    [REG_EAX] =3D "eax",
> +    [REG_EBX] =3D "ebx",
> +    [REG_ECX] =3D "ecx",
> +    [REG_EDX] =3D "edx",
> +    [REG_EDI] =3D "edi",
> +    [REG_ESI] =3D "esi",
> +    [REG_EBP] =3D "ebp",
> +    [REG_ESP] =3D "esp",
> +#endif
>  };
>
> -static void dump_reginfo(struct reginfo *ri)
> +#ifdef __x86_64__
> +# define PRIxREG   "%016llx"
> +#else
> +# define PRIxREG   "%08x"
> +#endif
> +
> +/* reginfo_dump: print state to a stream, returns nonzero on success */
> +int reginfo_dump(struct reginfo *ri, FILE *f)
>  {
>      int i;
> -    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
> +    fprintf(f, "  faulting insn %x\n", ri->faulting_insn);
>      for (i =3D 0; i < NGREG; i++) {
> -        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
> -                ri->gregs[i]);
> +        if (regname[i]) {
> +            fprintf(f, "  %-6s: " PRIxREG "\n", regname[i], ri->gregs[i]=
);
> +        }
>      }
> +    return !ferror(f);
> +}
> +
> +int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
> +{
> +    int i;
> +    for (i =3D 0; i < NGREG; i++) {
> +        if (m->gregs[i] !=3D a->gregs[i]) {
> +            assert(regname[i]);
> +            fprintf(f, "Mismatch: %s: " PRIxREG " v " PRIxREG "\n",
> +                    regname[i], m->gregs[i], a->gregs[i]);
> +        }
> +    }
> +    return !ferror(f);
>  }


--
Alex Benn=C3=A9e

