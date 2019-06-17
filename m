Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6DAC31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D599F2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZbyXHZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D599F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46442 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqTk-00070k-4F
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56103)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcq2W-0004yp-LO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcq2Q-00078z-1P
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:43:06 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcq2M-0006oK-99
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:42:59 -0400
Received: by mail-wm1-x344.google.com with SMTP id u8so8746493wmm.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 04:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Z1ZN9iJqo/eWoZkmHiwZcukv98e5lLOOCC52bzqXlxk=;
 b=AZbyXHZC7bTfpiSd25tlJLk4sdIkwwzdej5rdYuKFuPXyvkKtxHcEZ4Qk0obnSVEG1
 rI318AyjwWZGWzqbuQ3Pc6bq1ju0lsIvG67EB7vA2z/tEqTZb5Rpys/YmQDdLiizOcHA
 ATA0snRWT8nlBdfbHg5nmK41ekQWHNxgW6ivrWNWV5SRnT3IQdprApKsuctEAYDoEfKo
 RROkcJJ/FyHvexqY7fWHfZrxjy3WIqq4XHgpwQnBYou/FSY11ep1APrvBgZWdStLSXwI
 B3gagM9S3qOnZff24rDMzRDvFaXy5Q8m12/BAcvzIst1qCIg3JFTgkgVXXC+JtQlOTsA
 gUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Z1ZN9iJqo/eWoZkmHiwZcukv98e5lLOOCC52bzqXlxk=;
 b=VkpE4bMELkwNcwStD1Y+kJOjkM+LpIAWJQQN/Gm0j4+RKfiAVcVWZnCvaJGabrEeC9
 ciZ3qD37qpHGqErb0s9eWkw+kA9csbjbhSgneTDPbe+GBDrDrh+r9qzlmIGJIxnAFEXX
 A64gLiHtbmJR2Uou0tVwwzVbRcQoW4qN9bPGVjs2R6XQxWhBPLa9JJuk8UKthY8Tw2Vy
 wZUmUP2Gl+hmUHEWooaPMJxW0z15wM/YedrJnltAazh6t9nQBztOsXVU13rz0MAkIwnz
 bC7D/xGh42atRL37D2kgGKv3SK8BipxA2uBHv6ZOEEknEmMyK3LzM4a/2YfMU62cPRNd
 K6xw==
X-Gm-Message-State: APjAAAUMeA1Qgen4I9VFgdDIeNOmsmupu18fmviApSHNsKaGCXfx4/BX
 5Izn0vHdBeKBOYlsLurNmVevvA==
X-Google-Smtp-Source: APXvYqxdgWbI2wBpIHwvYIpkENJN7xLkHxUJ4JtW7g/GP7XyyT/bISyL7RShJ4a/LbiqZjb+wXMUYg==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr18381309wma.120.1560771771255; 
 Mon, 17 Jun 2019 04:42:51 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h21sm8658945wmb.47.2019.06.17.04.42.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 04:42:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1EEE31FF87;
 Mon, 17 Jun 2019 12:42:50 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-9-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190615154352.26824-9-philmd@redhat.com>
Date: Mon, 17 Jun 2019 12:42:50 +0100
Message-ID: <8736k8bfph.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 08/23] target/arm: Move all v7m insn
 helpers into their own file
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> From: Samuel Ortiz <sameo@linux.intel.com>
>
> In preparation for supporting TCG disablement on ARM, we move most
> of TCG related v7m helpers and APIs into their own file.
>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> [PMD: Patch rewritten]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Is there a way to not use $CONFIG_USER_ONLY?

Is this because the CONFIG_ARM_V7M symbol only appears for softmmu
targets but we still want vXm -cpu's for user mode?

>
>  target/arm/Makefile.objs |   1 +
>  target/arm/helper.c      | 633 -------------------------------------
>  target/arm/v7m_helper.c  | 654 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 655 insertions(+), 633 deletions(-)
>  create mode 100644 target/arm/v7m_helper.c
>
> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
> index 72b42f825f..5f3f965cc6 100644
> --- a/target/arm/Makefile.objs
> +++ b/target/arm/Makefile.objs
> @@ -35,6 +35,7 @@ obj-y +=3D translate.o op_helper.o
>  obj-y +=3D crypto_helper.o
>  obj-y +=3D iwmmxt_helper.o vec_helper.o
>  obj-y +=3D neon_helper.o vfp_helper.o
> +obj-$(call lor,$(CONFIG_USER_ONLY),$(CONFIG_ARM_V7M)) +=3D v7m_helper.o
>
>  obj-$(TARGET_AARCH64) +=3D translate-a64.o helper-a64.o
>  obj-$(TARGET_AARCH64) +=3D translate-sve.o sve_helper.o
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a1e74cc471..a829086c6d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -20,7 +20,6 @@
>  #include "qemu/crc32c.h"
>  #include "qemu/qemu-print.h"
>  #include "exec/exec-all.h"
> -#include "exec/cpu_ldst.h"
>  #include "arm_ldst.h"
>  #include <zlib.h> /* For crc32 */
>  #include "hw/semihosting/semihost.h"
> @@ -7456,75 +7455,6 @@ uint32_t HELPER(rbit)(uint32_t x)
>
>  #ifdef CONFIG_USER_ONLY
>
> -/* These should probably raise undefined insn exceptions.  */
> -void HELPER(v7m_msr)(CPUARMState *env, uint32_t reg, uint32_t val)
> -{
> -    ARMCPU *cpu =3D env_archcpu(env);
> -
> -    cpu_abort(CPU(cpu), "v7m_msr %d\n", reg);
> -}
> -
> -uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
> -{
> -    ARMCPU *cpu =3D env_archcpu(env);
> -
> -    cpu_abort(CPU(cpu), "v7m_mrs %d\n", reg);
> -    return 0;
> -}
> -
> -void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
> -{
> -    /* translate.c should never generate calls here in user-only mode */
> -    g_assert_not_reached();
> -}
> -
> -void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
> -{
> -    /* translate.c should never generate calls here in user-only mode */
> -    g_assert_not_reached();
> -}
> -
> -void HELPER(v7m_preserve_fp_state)(CPUARMState *env)
> -{
> -    /* translate.c should never generate calls here in user-only mode */
> -    g_assert_not_reached();
> -}
> -
> -void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
> -{
> -    /* translate.c should never generate calls here in user-only mode */
> -    g_assert_not_reached();
> -}
> -
> -void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
> -{
> -    /* translate.c should never generate calls here in user-only mode */
> -    g_assert_not_reached();
> -}
> -
> -uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
> -{
> -    /*
> -     * The TT instructions can be used by unprivileged code, but in
> -     * user-only emulation we don't have the MPU.
> -     * Luckily since we know we are NonSecure unprivileged (and that in
> -     * turn means that the A flag wasn't specified), all the bits in the
> -     * register must be zero:
> -     *  IREGION: 0 because IRVALID is 0
> -     *  IRVALID: 0 because NS
> -     *  S: 0 because NS
> -     *  NSRW: 0 because NS
> -     *  NSR: 0 because NS
> -     *  RW: 0 because unpriv and A flag not set
> -     *  R: 0 because unpriv and A flag not set
> -     *  SRVALID: 0 because NS
> -     *  MRVALID: 0 because unpriv and A flag not set
> -     *  SREGION: 0 becaus SRVALID is 0
> -     *  MREGION: 0 because MRVALID is 0
> -     */
> -    return 0;
> -}
> -
>  void switch_mode(CPUARMState *env, int mode)
>  {
>      ARMCPU *cpu =3D env_archcpu(env);
> @@ -8048,109 +7978,6 @@ void switch_v7m_security_state(CPUARMState *env, =
bool new_secstate)
>      }
>  }
>
> -void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
> -{
> -    /*
> -     * Handle v7M BXNS:
> -     *  - if the return value is a magic value, do exception return (lik=
e BX)
> -     *  - otherwise bit 0 of the return value is the target security sta=
te
> -     */
> -    uint32_t min_magic;
> -
> -    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
> -        /* Covers FNC_RETURN and EXC_RETURN magic */
> -        min_magic =3D FNC_RETURN_MIN_MAGIC;
> -    } else {
> -        /* EXC_RETURN magic only */
> -        min_magic =3D EXC_RETURN_MIN_MAGIC;
> -    }
> -
> -    if (dest >=3D min_magic) {
> -        /*
> -         * This is an exception return magic value; put it where
> -         * do_v7m_exception_exit() expects and raise EXCEPTION_EXIT.
> -         * Note that if we ever add gen_ss_advance() singlestep support =
to
> -         * M profile this should count as an "instruction execution comp=
lete"
> -         * event (compare gen_bx_excret_final_code()).
> -         */
> -        env->regs[15] =3D dest & ~1;
> -        env->thumb =3D dest & 1;
> -        HELPER(exception_internal)(env, EXCP_EXCEPTION_EXIT);
> -        /* notreached */
> -    }
> -
> -    /* translate.c should have made BXNS UNDEF unless we're secure */
> -    assert(env->v7m.secure);
> -
> -    if (!(dest & 1)) {
> -        env->v7m.control[M_REG_S] &=3D ~R_V7M_CONTROL_SFPA_MASK;
> -    }
> -    switch_v7m_security_state(env, dest & 1);
> -    env->thumb =3D 1;
> -    env->regs[15] =3D dest & ~1;
> -}
> -
> -void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
> -{
> -    /*
> -     * Handle v7M BLXNS:
> -     *  - bit 0 of the destination address is the target security state
> -     */
> -
> -    /* At this point regs[15] is the address just after the BLXNS */
> -    uint32_t nextinst =3D env->regs[15] | 1;
> -    uint32_t sp =3D env->regs[13] - 8;
> -    uint32_t saved_psr;
> -
> -    /* translate.c will have made BLXNS UNDEF unless we're secure */
> -    assert(env->v7m.secure);
> -
> -    if (dest & 1) {
> -        /*
> -         * Target is Secure, so this is just a normal BLX,
> -         * except that the low bit doesn't indicate Thumb/not.
> -         */
> -        env->regs[14] =3D nextinst;
> -        env->thumb =3D 1;
> -        env->regs[15] =3D dest & ~1;
> -        return;
> -    }
> -
> -    /* Target is non-secure: first push a stack frame */
> -    if (!QEMU_IS_ALIGNED(sp, 8)) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "BLXNS with misaligned SP is UNPREDICTABLE\n");
> -    }
> -
> -    if (sp < v7m_sp_limit(env)) {
> -        raise_exception(env, EXCP_STKOF, 0, 1);
> -    }
> -
> -    saved_psr =3D env->v7m.exception;
> -    if (env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK) {
> -        saved_psr |=3D XPSR_SFPA;
> -    }
> -
> -    /* Note that these stores can throw exceptions on MPU faults */
> -    cpu_stl_data(env, sp, nextinst);
> -    cpu_stl_data(env, sp + 4, saved_psr);
> -
> -    env->regs[13] =3D sp;
> -    env->regs[14] =3D 0xfeffffff;
> -    if (arm_v7m_is_handler_mode(env)) {
> -        /*
> -         * Write a dummy value to IPSR, to avoid leaking the current sec=
ure
> -         * exception number to non-secure code. This is guaranteed not
> -         * to cause write_v7m_exception() to actually change stacks.
> -         */
> -        write_v7m_exception(env, 1);
> -    }
> -    env->v7m.control[M_REG_S] &=3D ~R_V7M_CONTROL_SFPA_MASK;
> -    switch_v7m_security_state(env, 0);
> -    env->thumb =3D 1;
> -    env->regs[15] =3D dest;
> -}
> -
>  static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool thre=
admode,
>                                  bool spsel)
>  {
> @@ -12760,466 +12587,6 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUSta=
te *cs, vaddr addr,
>      return phys_addr;
>  }
>
> -uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
> -{
> -    uint32_t mask;
> -    unsigned el =3D arm_current_el(env);
> -
> -    /* First handle registers which unprivileged can read */
> -
> -    switch (reg) {
> -    case 0 ... 7: /* xPSR sub-fields */
> -        mask =3D 0;
> -        if ((reg & 1) && el) {
> -            mask |=3D XPSR_EXCP; /* IPSR (unpriv. reads as zero) */
> -        }
> -        if (!(reg & 4)) {
> -            mask |=3D XPSR_NZCV | XPSR_Q; /* APSR */
> -            if (arm_feature(env, ARM_FEATURE_THUMB_DSP)) {
> -                mask |=3D XPSR_GE;
> -            }
> -        }
> -        /* EPSR reads as zero */
> -        return xpsr_read(env) & mask;
> -        break;
> -    case 20: /* CONTROL */
> -    {
> -        uint32_t value =3D env->v7m.control[env->v7m.secure];
> -        if (!env->v7m.secure) {
> -            /* SFPA is RAZ/WI from NS; FPCA is stored in the M_REG_S ban=
k */
> -            value |=3D env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MA=
SK;
> -        }
> -        return value;
> -    }
> -    case 0x94: /* CONTROL_NS */
> -        /*
> -         * We have to handle this here because unprivileged Secure code
> -         * can read the NS CONTROL register.
> -         */
> -        if (!env->v7m.secure) {
> -            return 0;
> -        }
> -        return env->v7m.control[M_REG_NS] |
> -            (env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK);
> -    }
> -
> -    if (el =3D=3D 0) {
> -        return 0; /* unprivileged reads others as zero */
> -    }
> -
> -    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
> -        switch (reg) {
> -        case 0x88: /* MSP_NS */
> -            if (!env->v7m.secure) {
> -                return 0;
> -            }
> -            return env->v7m.other_ss_msp;
> -        case 0x89: /* PSP_NS */
> -            if (!env->v7m.secure) {
> -                return 0;
> -            }
> -            return env->v7m.other_ss_psp;
> -        case 0x8a: /* MSPLIM_NS */
> -            if (!env->v7m.secure) {
> -                return 0;
> -            }
> -            return env->v7m.msplim[M_REG_NS];
> -        case 0x8b: /* PSPLIM_NS */
> -            if (!env->v7m.secure) {
> -                return 0;
> -            }
> -            return env->v7m.psplim[M_REG_NS];
> -        case 0x90: /* PRIMASK_NS */
> -            if (!env->v7m.secure) {
> -                return 0;
> -            }
> -            return env->v7m.primask[M_REG_NS];
> -        case 0x91: /* BASEPRI_NS */
> -            if (!env->v7m.secure) {
> -                return 0;
> -            }
> -            return env->v7m.basepri[M_REG_NS];
> -        case 0x93: /* FAULTMASK_NS */
> -            if (!env->v7m.secure) {
> -                return 0;
> -            }
> -            return env->v7m.faultmask[M_REG_NS];
> -        case 0x98: /* SP_NS */
> -        {
> -            /*
> -             * This gives the non-secure SP selected based on whether we=
're
> -             * currently in handler mode or not, using the NS CONTROL.SP=
SEL.
> -             */
> -            bool spsel =3D env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SP=
SEL_MASK;
> -
> -            if (!env->v7m.secure) {
> -                return 0;
> -            }
> -            if (!arm_v7m_is_handler_mode(env) && spsel) {
> -                return env->v7m.other_ss_psp;
> -            } else {
> -                return env->v7m.other_ss_msp;
> -            }
> -        }
> -        default:
> -            break;
> -        }
> -    }
> -
> -    switch (reg) {
> -    case 8: /* MSP */
> -        return v7m_using_psp(env) ? env->v7m.other_sp : env->regs[13];
> -    case 9: /* PSP */
> -        return v7m_using_psp(env) ? env->regs[13] : env->v7m.other_sp;
> -    case 10: /* MSPLIM */
> -        if (!arm_feature(env, ARM_FEATURE_V8)) {
> -            goto bad_reg;
> -        }
> -        return env->v7m.msplim[env->v7m.secure];
> -    case 11: /* PSPLIM */
> -        if (!arm_feature(env, ARM_FEATURE_V8)) {
> -            goto bad_reg;
> -        }
> -        return env->v7m.psplim[env->v7m.secure];
> -    case 16: /* PRIMASK */
> -        return env->v7m.primask[env->v7m.secure];
> -    case 17: /* BASEPRI */
> -    case 18: /* BASEPRI_MAX */
> -        return env->v7m.basepri[env->v7m.secure];
> -    case 19: /* FAULTMASK */
> -        return env->v7m.faultmask[env->v7m.secure];
> -    default:
> -    bad_reg:
> -        qemu_log_mask(LOG_GUEST_ERROR, "Attempt to read unknown special"
> -                                       " register %d\n", reg);
> -        return 0;
> -    }
> -}
> -
> -void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
> -{
> -    /*
> -     * We're passed bits [11..0] of the instruction; extract
> -     * SYSm and the mask bits.
> -     * Invalid combinations of SYSm and mask are UNPREDICTABLE;
> -     * we choose to treat them as if the mask bits were valid.
> -     * NB that the pseudocode 'mask' variable is bits [11..10],
> -     * whereas ours is [11..8].
> -     */
> -    uint32_t mask =3D extract32(maskreg, 8, 4);
> -    uint32_t reg =3D extract32(maskreg, 0, 8);
> -    int cur_el =3D arm_current_el(env);
> -
> -    if (cur_el =3D=3D 0 && reg > 7 && reg !=3D 20) {
> -        /*
> -         * only xPSR sub-fields and CONTROL.SFPA may be written by
> -         * unprivileged code
> -         */
> -        return;
> -    }
> -
> -    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
> -        switch (reg) {
> -        case 0x88: /* MSP_NS */
> -            if (!env->v7m.secure) {
> -                return;
> -            }
> -            env->v7m.other_ss_msp =3D val;
> -            return;
> -        case 0x89: /* PSP_NS */
> -            if (!env->v7m.secure) {
> -                return;
> -            }
> -            env->v7m.other_ss_psp =3D val;
> -            return;
> -        case 0x8a: /* MSPLIM_NS */
> -            if (!env->v7m.secure) {
> -                return;
> -            }
> -            env->v7m.msplim[M_REG_NS] =3D val & ~7;
> -            return;
> -        case 0x8b: /* PSPLIM_NS */
> -            if (!env->v7m.secure) {
> -                return;
> -            }
> -            env->v7m.psplim[M_REG_NS] =3D val & ~7;
> -            return;
> -        case 0x90: /* PRIMASK_NS */
> -            if (!env->v7m.secure) {
> -                return;
> -            }
> -            env->v7m.primask[M_REG_NS] =3D val & 1;
> -            return;
> -        case 0x91: /* BASEPRI_NS */
> -            if (!env->v7m.secure || !arm_feature(env, ARM_FEATURE_M_MAIN=
)) {
> -                return;
> -            }
> -            env->v7m.basepri[M_REG_NS] =3D val & 0xff;
> -            return;
> -        case 0x93: /* FAULTMASK_NS */
> -            if (!env->v7m.secure || !arm_feature(env, ARM_FEATURE_M_MAIN=
)) {
> -                return;
> -            }
> -            env->v7m.faultmask[M_REG_NS] =3D val & 1;
> -            return;
> -        case 0x94: /* CONTROL_NS */
> -            if (!env->v7m.secure) {
> -                return;
> -            }
> -            write_v7m_control_spsel_for_secstate(env,
> -                                                 val & R_V7M_CONTROL_SPS=
EL_MASK,
> -                                                 M_REG_NS);
> -            if (arm_feature(env, ARM_FEATURE_M_MAIN)) {
> -                env->v7m.control[M_REG_NS] &=3D ~R_V7M_CONTROL_NPRIV_MAS=
K;
> -                env->v7m.control[M_REG_NS] |=3D val & R_V7M_CONTROL_NPRI=
V_MASK;
> -            }
> -            /*
> -             * SFPA is RAZ/WI from NS. FPCA is RO if NSACR.CP10 =3D=3D 0,
> -             * RES0 if the FPU is not present, and is stored in the S ba=
nk
> -             */
> -            if (arm_feature(env, ARM_FEATURE_VFP) &&
> -                extract32(env->v7m.nsacr, 10, 1)) {
> -                env->v7m.control[M_REG_S] &=3D ~R_V7M_CONTROL_FPCA_MASK;
> -                env->v7m.control[M_REG_S] |=3D val & R_V7M_CONTROL_FPCA_=
MASK;
> -            }
> -            return;
> -        case 0x98: /* SP_NS */
> -        {
> -            /*
> -             * This gives the non-secure SP selected based on whether we=
're
> -             * currently in handler mode or not, using the NS CONTROL.SP=
SEL.
> -             */
> -            bool spsel =3D env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SP=
SEL_MASK;
> -            bool is_psp =3D !arm_v7m_is_handler_mode(env) && spsel;
> -            uint32_t limit;
> -
> -            if (!env->v7m.secure) {
> -                return;
> -            }
> -
> -            limit =3D is_psp ? env->v7m.psplim[false] : env->v7m.msplim[=
false];
> -
> -            if (val < limit) {
> -                CPUState *cs =3D env_cpu(env);
> -
> -                cpu_restore_state(cs, GETPC(), true);
> -                raise_exception(env, EXCP_STKOF, 0, 1);
> -            }
> -
> -            if (is_psp) {
> -                env->v7m.other_ss_psp =3D val;
> -            } else {
> -                env->v7m.other_ss_msp =3D val;
> -            }
> -            return;
> -        }
> -        default:
> -            break;
> -        }
> -    }
> -
> -    switch (reg) {
> -    case 0 ... 7: /* xPSR sub-fields */
> -        /* only APSR is actually writable */
> -        if (!(reg & 4)) {
> -            uint32_t apsrmask =3D 0;
> -
> -            if (mask & 8) {
> -                apsrmask |=3D XPSR_NZCV | XPSR_Q;
> -            }
> -            if ((mask & 4) && arm_feature(env, ARM_FEATURE_THUMB_DSP)) {
> -                apsrmask |=3D XPSR_GE;
> -            }
> -            xpsr_write(env, val, apsrmask);
> -        }
> -        break;
> -    case 8: /* MSP */
> -        if (v7m_using_psp(env)) {
> -            env->v7m.other_sp =3D val;
> -        } else {
> -            env->regs[13] =3D val;
> -        }
> -        break;
> -    case 9: /* PSP */
> -        if (v7m_using_psp(env)) {
> -            env->regs[13] =3D val;
> -        } else {
> -            env->v7m.other_sp =3D val;
> -        }
> -        break;
> -    case 10: /* MSPLIM */
> -        if (!arm_feature(env, ARM_FEATURE_V8)) {
> -            goto bad_reg;
> -        }
> -        env->v7m.msplim[env->v7m.secure] =3D val & ~7;
> -        break;
> -    case 11: /* PSPLIM */
> -        if (!arm_feature(env, ARM_FEATURE_V8)) {
> -            goto bad_reg;
> -        }
> -        env->v7m.psplim[env->v7m.secure] =3D val & ~7;
> -        break;
> -    case 16: /* PRIMASK */
> -        env->v7m.primask[env->v7m.secure] =3D val & 1;
> -        break;
> -    case 17: /* BASEPRI */
> -        if (!arm_feature(env, ARM_FEATURE_M_MAIN)) {
> -            goto bad_reg;
> -        }
> -        env->v7m.basepri[env->v7m.secure] =3D val & 0xff;
> -        break;
> -    case 18: /* BASEPRI_MAX */
> -        if (!arm_feature(env, ARM_FEATURE_M_MAIN)) {
> -            goto bad_reg;
> -        }
> -        val &=3D 0xff;
> -        if (val !=3D 0 && (val < env->v7m.basepri[env->v7m.secure]
> -                         || env->v7m.basepri[env->v7m.secure] =3D=3D 0))=
 {
> -            env->v7m.basepri[env->v7m.secure] =3D val;
> -        }
> -        break;
> -    case 19: /* FAULTMASK */
> -        if (!arm_feature(env, ARM_FEATURE_M_MAIN)) {
> -            goto bad_reg;
> -        }
> -        env->v7m.faultmask[env->v7m.secure] =3D val & 1;
> -        break;
> -    case 20: /* CONTROL */
> -        /*
> -         * Writing to the SPSEL bit only has an effect if we are in
> -         * thread mode; other bits can be updated by any privileged code.
> -         * write_v7m_control_spsel() deals with updating the SPSEL bit in
> -         * env->v7m.control, so we only need update the others.
> -         * For v7M, we must just ignore explicit writes to SPSEL in hand=
ler
> -         * mode; for v8M the write is permitted but will have no effect.
> -         * All these bits are writes-ignored from non-privileged code,
> -         * except for SFPA.
> -         */
> -        if (cur_el > 0 && (arm_feature(env, ARM_FEATURE_V8) ||
> -                           !arm_v7m_is_handler_mode(env))) {
> -            write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK=
) !=3D 0);
> -        }
> -        if (cur_el > 0 && arm_feature(env, ARM_FEATURE_M_MAIN)) {
> -            env->v7m.control[env->v7m.secure] &=3D ~R_V7M_CONTROL_NPRIV_=
MASK;
> -            env->v7m.control[env->v7m.secure] |=3D val & R_V7M_CONTROL_N=
PRIV_MASK;
> -        }
> -        if (arm_feature(env, ARM_FEATURE_VFP)) {
> -            /*
> -             * SFPA is RAZ/WI from NS or if no FPU.
> -             * FPCA is RO if NSACR.CP10 =3D=3D 0, RES0 if the FPU is not=
 present.
> -             * Both are stored in the S bank.
> -             */
> -            if (env->v7m.secure) {
> -                env->v7m.control[M_REG_S] &=3D ~R_V7M_CONTROL_SFPA_MASK;
> -                env->v7m.control[M_REG_S] |=3D val & R_V7M_CONTROL_SFPA_=
MASK;
> -            }
> -            if (cur_el > 0 &&
> -                (env->v7m.secure || !arm_feature(env, ARM_FEATURE_M_SECU=
RITY) ||
> -                 extract32(env->v7m.nsacr, 10, 1))) {
> -                env->v7m.control[M_REG_S] &=3D ~R_V7M_CONTROL_FPCA_MASK;
> -                env->v7m.control[M_REG_S] |=3D val & R_V7M_CONTROL_FPCA_=
MASK;
> -            }
> -        }
> -        break;
> -    default:
> -    bad_reg:
> -        qemu_log_mask(LOG_GUEST_ERROR, "Attempt to write unknown special"
> -                                       " register %d\n", reg);
> -        return;
> -    }
> -}
> -
> -uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
> -{
> -    /* Implement the TT instruction. op is bits [7:6] of the insn. */
> -    bool forceunpriv =3D op & 1;
> -    bool alt =3D op & 2;
> -    V8M_SAttributes sattrs =3D {};
> -    uint32_t tt_resp;
> -    bool r, rw, nsr, nsrw, mrvalid;
> -    int prot;
> -    ARMMMUFaultInfo fi =3D {};
> -    MemTxAttrs attrs =3D {};
> -    hwaddr phys_addr;
> -    ARMMMUIdx mmu_idx;
> -    uint32_t mregion;
> -    bool targetpriv;
> -    bool targetsec =3D env->v7m.secure;
> -    bool is_subpage;
> -
> -    /*
> -     * Work out what the security state and privilege level we're
> -     * interested in is...
> -     */
> -    if (alt) {
> -        targetsec =3D !targetsec;
> -    }
> -
> -    if (forceunpriv) {
> -        targetpriv =3D false;
> -    } else {
> -        targetpriv =3D arm_v7m_is_handler_mode(env) ||
> -            !(env->v7m.control[targetsec] & R_V7M_CONTROL_NPRIV_MASK);
> -    }
> -
> -    /* ...and then figure out which MMU index this is */
> -    mmu_idx =3D arm_v7m_mmu_idx_for_secstate_and_priv(env, targetsec, ta=
rgetpriv);
> -
> -    /*
> -     * We know that the MPU and SAU don't care about the access type
> -     * for our purposes beyond that we don't want to claim to be
> -     * an insn fetch, so we arbitrarily call this a read.
> -     */
> -
> -    /*
> -     * MPU region info only available for privileged or if
> -     * inspecting the other MPU state.
> -     */
> -    if (arm_current_el(env) !=3D 0 || alt) {
> -        /* We can ignore the return value as prot is always set */
> -        pmsav8_mpu_lookup(env, addr, MMU_DATA_LOAD, mmu_idx,
> -                          &phys_addr, &attrs, &prot, &is_subpage,
> -                          &fi, &mregion);
> -        if (mregion =3D=3D -1) {
> -            mrvalid =3D false;
> -            mregion =3D 0;
> -        } else {
> -            mrvalid =3D true;
> -        }
> -        r =3D prot & PAGE_READ;
> -        rw =3D prot & PAGE_WRITE;
> -    } else {
> -        r =3D false;
> -        rw =3D false;
> -        mrvalid =3D false;
> -        mregion =3D 0;
> -    }
> -
> -    if (env->v7m.secure) {
> -        v8m_security_lookup(env, addr, MMU_DATA_LOAD, mmu_idx, &sattrs);
> -        nsr =3D sattrs.ns && r;
> -        nsrw =3D sattrs.ns && rw;
> -    } else {
> -        sattrs.ns =3D true;
> -        nsr =3D false;
> -        nsrw =3D false;
> -    }
> -
> -    tt_resp =3D (sattrs.iregion << 24) |
> -        (sattrs.irvalid << 23) |
> -        ((!sattrs.ns) << 22) |
> -        (nsrw << 21) |
> -        (nsr << 20) |
> -        (rw << 19) |
> -        (r << 18) |
> -        (sattrs.srvalid << 17) |
> -        (mrvalid << 16) |
> -        (sattrs.sregion << 8) |
> -        mregion;
> -
> -    return tt_resp;
> -}
> -
>  #endif
>
>  bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> diff --git a/target/arm/v7m_helper.c b/target/arm/v7m_helper.c
> new file mode 100644
> index 0000000000..321154966e
> --- /dev/null
> +++ b/target/arm/v7m_helper.c
> @@ -0,0 +1,654 @@
> +/*
> + * ARM v7-M helpers.
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include "sysemu/sysemu.h"
> +#include "cpu.h"
> +#include "internals.h"
> +#include "exec/helper-proto.h"
> +#include "exec/exec-all.h"
> +#include "arm_ldst.h"
> +#include "hw/semihosting/semihost.h"
> +#include "fpu/softfloat.h"
> +
> +#if defined(CONFIG_USER_ONLY)
> +
> +/* These should probably raise undefined insn exceptions.  */
> +void HELPER(v7m_msr)(CPUARMState *env, uint32_t reg, uint32_t val)
> +{
> +    ARMCPU *cpu =3D env_archcpu(env);
> +
> +    cpu_abort(CPU(cpu), "v7m_msr %d\n", reg);
> +}
> +
> +uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
> +{
> +    ARMCPU *cpu =3D env_archcpu(env);
> +
> +    cpu_abort(CPU(cpu), "v7m_mrs %d\n", reg);
> +    return 0;
> +}
> +
> +void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
> +{
> +    /* translate.c should never generate calls here in user-only mode */
> +    g_assert_not_reached();
> +}
> +
> +void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
> +{
> +    /* translate.c should never generate calls here in user-only mode */
> +    g_assert_not_reached();
> +}
> +
> +void HELPER(v7m_preserve_fp_state)(CPUARMState *env)
> +{
> +    /* translate.c should never generate calls here in user-only mode */
> +    g_assert_not_reached();
> +}
> +
> +void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
> +{
> +    /* translate.c should never generate calls here in user-only mode */
> +    g_assert_not_reached();
> +}
> +
> +void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
> +{
> +    /* translate.c should never generate calls here in user-only mode */
> +    g_assert_not_reached();
> +}
> +
> +uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
> +{
> +    /*
> +     * The TT instructions can be used by unprivileged code, but in
> +     * user-only emulation we don't have the MPU.
> +     * Luckily since we know we are NonSecure unprivileged (and that in
> +     * turn means that the A flag wasn't specified), all the bits in the
> +     * register must be zero:
> +     *  IREGION: 0 because IRVALID is 0
> +     *  IRVALID: 0 because NS
> +     *  S: 0 because NS
> +     *  NSRW: 0 because NS
> +     *  NSR: 0 because NS
> +     *  RW: 0 because unpriv and A flag not set
> +     *  R: 0 because unpriv and A flag not set
> +     *  SRVALID: 0 because NS
> +     *  MRVALID: 0 because unpriv and A flag not set
> +     *  SREGION: 0 becaus SRVALID is 0
> +     *  MREGION: 0 because MRVALID is 0
> +     */
> +    return 0;
> +}
> +
> +#else
> +
> +void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
> +{
> +    /*
> +     * Handle v7M BXNS:
> +     *  - if the return value is a magic value, do exception return (lik=
e BX)
> +     *  - otherwise bit 0 of the return value is the target security sta=
te
> +     */
> +    uint32_t min_magic;
> +
> +    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
> +        /* Covers FNC_RETURN and EXC_RETURN magic */
> +        min_magic =3D FNC_RETURN_MIN_MAGIC;
> +    } else {
> +        /* EXC_RETURN magic only */
> +        min_magic =3D EXC_RETURN_MIN_MAGIC;
> +    }
> +
> +    if (dest >=3D min_magic) {
> +        /*
> +         * This is an exception return magic value; put it where
> +         * do_v7m_exception_exit() expects and raise EXCEPTION_EXIT.
> +         * Note that if we ever add gen_ss_advance() singlestep support =
to
> +         * M profile this should count as an "instruction execution comp=
lete"
> +         * event (compare gen_bx_excret_final_code()).
> +         */
> +        env->regs[15] =3D dest & ~1;
> +        env->thumb =3D dest & 1;
> +        HELPER(exception_internal)(env, EXCP_EXCEPTION_EXIT);
> +        /* notreached */
> +    }
> +
> +    /* translate.c should have made BXNS UNDEF unless we're secure */
> +    assert(env->v7m.secure);
> +
> +    if (!(dest & 1)) {
> +        env->v7m.control[M_REG_S] &=3D ~R_V7M_CONTROL_SFPA_MASK;
> +    }
> +    switch_v7m_security_state(env, dest & 1);
> +    env->thumb =3D 1;
> +    env->regs[15] =3D dest & ~1;
> +}
> +
> +void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
> +{
> +    /*
> +     * Handle v7M BLXNS:
> +     *  - bit 0 of the destination address is the target security state
> +     */
> +
> +    /* At this point regs[15] is the address just after the BLXNS */
> +    uint32_t nextinst =3D env->regs[15] | 1;
> +    uint32_t sp =3D env->regs[13] - 8;
> +    uint32_t saved_psr;
> +
> +    /* translate.c will have made BLXNS UNDEF unless we're secure */
> +    assert(env->v7m.secure);
> +
> +    if (dest & 1) {
> +        /*
> +         * Target is Secure, so this is just a normal BLX,
> +         * except that the low bit doesn't indicate Thumb/not.
> +         */
> +        env->regs[14] =3D nextinst;
> +        env->thumb =3D 1;
> +        env->regs[15] =3D dest & ~1;
> +        return;
> +    }
> +
> +    /* Target is non-secure: first push a stack frame */
> +    if (!QEMU_IS_ALIGNED(sp, 8)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "BLXNS with misaligned SP is UNPREDICTABLE\n");
> +    }
> +
> +    if (sp < v7m_sp_limit(env)) {
> +        raise_exception(env, EXCP_STKOF, 0, 1);
> +    }
> +
> +    saved_psr =3D env->v7m.exception;
> +    if (env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK) {
> +        saved_psr |=3D XPSR_SFPA;
> +    }
> +
> +    /* Note that these stores can throw exceptions on MPU faults */
> +    cpu_stl_data(env, sp, nextinst);
> +    cpu_stl_data(env, sp + 4, saved_psr);
> +
> +    env->regs[13] =3D sp;
> +    env->regs[14] =3D 0xfeffffff;
> +    if (arm_v7m_is_handler_mode(env)) {
> +        /*
> +         * Write a dummy value to IPSR, to avoid leaking the current sec=
ure
> +         * exception number to non-secure code. This is guaranteed not
> +         * to cause write_v7m_exception() to actually change stacks.
> +         */
> +        write_v7m_exception(env, 1);
> +    }
> +    env->v7m.control[M_REG_S] &=3D ~R_V7M_CONTROL_SFPA_MASK;
> +    switch_v7m_security_state(env, 0);
> +    env->thumb =3D 1;
> +    env->regs[15] =3D dest;
> +}
> +
> +uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
> +{
> +    uint32_t mask;
> +    unsigned el =3D arm_current_el(env);
> +
> +    /* First handle registers which unprivileged can read */
> +
> +    switch (reg) {
> +    case 0 ... 7: /* xPSR sub-fields */
> +        mask =3D 0;
> +        if ((reg & 1) && el) {
> +            mask |=3D XPSR_EXCP; /* IPSR (unpriv. reads as zero) */
> +        }
> +        if (!(reg & 4)) {
> +            mask |=3D XPSR_NZCV | XPSR_Q; /* APSR */
> +            if (arm_feature(env, ARM_FEATURE_THUMB_DSP)) {
> +                mask |=3D XPSR_GE;
> +            }
> +        }
> +        /* EPSR reads as zero */
> +        return xpsr_read(env) & mask;
> +        break;
> +    case 20: /* CONTROL */
> +    {
> +        uint32_t value =3D env->v7m.control[env->v7m.secure];
> +        if (!env->v7m.secure) {
> +            /* SFPA is RAZ/WI from NS; FPCA is stored in the M_REG_S ban=
k */
> +            value |=3D env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MA=
SK;
> +        }
> +        return value;
> +    }
> +    case 0x94: /* CONTROL_NS */
> +        /*
> +         * We have to handle this here because unprivileged Secure code
> +         * can read the NS CONTROL register.
> +         */
> +        if (!env->v7m.secure) {
> +            return 0;
> +        }
> +        return env->v7m.control[M_REG_NS] |
> +            (env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK);
> +    }
> +
> +    if (el =3D=3D 0) {
> +        return 0; /* unprivileged reads others as zero */
> +    }
> +
> +    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
> +        switch (reg) {
> +        case 0x88: /* MSP_NS */
> +            if (!env->v7m.secure) {
> +                return 0;
> +            }
> +            return env->v7m.other_ss_msp;
> +        case 0x89: /* PSP_NS */
> +            if (!env->v7m.secure) {
> +                return 0;
> +            }
> +            return env->v7m.other_ss_psp;
> +        case 0x8a: /* MSPLIM_NS */
> +            if (!env->v7m.secure) {
> +                return 0;
> +            }
> +            return env->v7m.msplim[M_REG_NS];
> +        case 0x8b: /* PSPLIM_NS */
> +            if (!env->v7m.secure) {
> +                return 0;
> +            }
> +            return env->v7m.psplim[M_REG_NS];
> +        case 0x90: /* PRIMASK_NS */
> +            if (!env->v7m.secure) {
> +                return 0;
> +            }
> +            return env->v7m.primask[M_REG_NS];
> +        case 0x91: /* BASEPRI_NS */
> +            if (!env->v7m.secure) {
> +                return 0;
> +            }
> +            return env->v7m.basepri[M_REG_NS];
> +        case 0x93: /* FAULTMASK_NS */
> +            if (!env->v7m.secure) {
> +                return 0;
> +            }
> +            return env->v7m.faultmask[M_REG_NS];
> +        case 0x98: /* SP_NS */
> +        {
> +            /*
> +             * This gives the non-secure SP selected based on whether we=
're
> +             * currently in handler mode or not, using the NS CONTROL.SP=
SEL.
> +             */
> +            bool spsel =3D env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SP=
SEL_MASK;
> +
> +            if (!env->v7m.secure) {
> +                return 0;
> +            }
> +            if (!arm_v7m_is_handler_mode(env) && spsel) {
> +                return env->v7m.other_ss_psp;
> +            } else {
> +                return env->v7m.other_ss_msp;
> +            }
> +        }
> +        default:
> +            break;
> +        }
> +    }
> +
> +    switch (reg) {
> +    case 8: /* MSP */
> +        return v7m_using_psp(env) ? env->v7m.other_sp : env->regs[13];
> +    case 9: /* PSP */
> +        return v7m_using_psp(env) ? env->regs[13] : env->v7m.other_sp;
> +    case 10: /* MSPLIM */
> +        if (!arm_feature(env, ARM_FEATURE_V8)) {
> +            goto bad_reg;
> +        }
> +        return env->v7m.msplim[env->v7m.secure];
> +    case 11: /* PSPLIM */
> +        if (!arm_feature(env, ARM_FEATURE_V8)) {
> +            goto bad_reg;
> +        }
> +        return env->v7m.psplim[env->v7m.secure];
> +    case 16: /* PRIMASK */
> +        return env->v7m.primask[env->v7m.secure];
> +    case 17: /* BASEPRI */
> +    case 18: /* BASEPRI_MAX */
> +        return env->v7m.basepri[env->v7m.secure];
> +    case 19: /* FAULTMASK */
> +        return env->v7m.faultmask[env->v7m.secure];
> +    default:
> +    bad_reg:
> +        qemu_log_mask(LOG_GUEST_ERROR, "Attempt to read unknown special"
> +                                       " register %d\n", reg);
> +        return 0;
> +    }
> +}
> +
> +void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
> +{
> +    /*
> +     * We're passed bits [11..0] of the instruction; extract
> +     * SYSm and the mask bits.
> +     * Invalid combinations of SYSm and mask are UNPREDICTABLE;
> +     * we choose to treat them as if the mask bits were valid.
> +     * NB that the pseudocode 'mask' variable is bits [11..10],
> +     * whereas ours is [11..8].
> +     */
> +    uint32_t mask =3D extract32(maskreg, 8, 4);
> +    uint32_t reg =3D extract32(maskreg, 0, 8);
> +    int cur_el =3D arm_current_el(env);
> +
> +    if (cur_el =3D=3D 0 && reg > 7 && reg !=3D 20) {
> +        /*
> +         * only xPSR sub-fields and CONTROL.SFPA may be written by
> +         * unprivileged code
> +         */
> +        return;
> +    }
> +
> +    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
> +        switch (reg) {
> +        case 0x88: /* MSP_NS */
> +            if (!env->v7m.secure) {
> +                return;
> +            }
> +            env->v7m.other_ss_msp =3D val;
> +            return;
> +        case 0x89: /* PSP_NS */
> +            if (!env->v7m.secure) {
> +                return;
> +            }
> +            env->v7m.other_ss_psp =3D val;
> +            return;
> +        case 0x8a: /* MSPLIM_NS */
> +            if (!env->v7m.secure) {
> +                return;
> +            }
> +            env->v7m.msplim[M_REG_NS] =3D val & ~7;
> +            return;
> +        case 0x8b: /* PSPLIM_NS */
> +            if (!env->v7m.secure) {
> +                return;
> +            }
> +            env->v7m.psplim[M_REG_NS] =3D val & ~7;
> +            return;
> +        case 0x90: /* PRIMASK_NS */
> +            if (!env->v7m.secure) {
> +                return;
> +            }
> +            env->v7m.primask[M_REG_NS] =3D val & 1;
> +            return;
> +        case 0x91: /* BASEPRI_NS */
> +            if (!env->v7m.secure || !arm_feature(env, ARM_FEATURE_M_MAIN=
)) {
> +                return;
> +            }
> +            env->v7m.basepri[M_REG_NS] =3D val & 0xff;
> +            return;
> +        case 0x93: /* FAULTMASK_NS */
> +            if (!env->v7m.secure || !arm_feature(env, ARM_FEATURE_M_MAIN=
)) {
> +                return;
> +            }
> +            env->v7m.faultmask[M_REG_NS] =3D val & 1;
> +            return;
> +        case 0x94: /* CONTROL_NS */
> +            if (!env->v7m.secure) {
> +                return;
> +            }
> +            write_v7m_control_spsel_for_secstate(env,
> +                                                 val & R_V7M_CONTROL_SPS=
EL_MASK,
> +                                                 M_REG_NS);
> +            if (arm_feature(env, ARM_FEATURE_M_MAIN)) {
> +                env->v7m.control[M_REG_NS] &=3D ~R_V7M_CONTROL_NPRIV_MAS=
K;
> +                env->v7m.control[M_REG_NS] |=3D val & R_V7M_CONTROL_NPRI=
V_MASK;
> +            }
> +            /*
> +             * SFPA is RAZ/WI from NS. FPCA is RO if NSACR.CP10 =3D=3D 0,
> +             * RES0 if the FPU is not present, and is stored in the S ba=
nk
> +             */
> +            if (arm_feature(env, ARM_FEATURE_VFP) &&
> +                extract32(env->v7m.nsacr, 10, 1)) {
> +                env->v7m.control[M_REG_S] &=3D ~R_V7M_CONTROL_FPCA_MASK;
> +                env->v7m.control[M_REG_S] |=3D val & R_V7M_CONTROL_FPCA_=
MASK;
> +            }
> +            return;
> +        case 0x98: /* SP_NS */
> +        {
> +            /*
> +             * This gives the non-secure SP selected based on whether we=
're
> +             * currently in handler mode or not, using the NS CONTROL.SP=
SEL.
> +             */
> +            bool spsel =3D env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SP=
SEL_MASK;
> +            bool is_psp =3D !arm_v7m_is_handler_mode(env) && spsel;
> +            uint32_t limit;
> +
> +            if (!env->v7m.secure) {
> +                return;
> +            }
> +
> +            limit =3D is_psp ? env->v7m.psplim[false] : env->v7m.msplim[=
false];
> +
> +            if (val < limit) {
> +                CPUState *cs =3D env_cpu(env);
> +
> +                cpu_restore_state(cs, GETPC(), true);
> +                raise_exception(env, EXCP_STKOF, 0, 1);
> +            }
> +
> +            if (is_psp) {
> +                env->v7m.other_ss_psp =3D val;
> +            } else {
> +                env->v7m.other_ss_msp =3D val;
> +            }
> +            return;
> +        }
> +        default:
> +            break;
> +        }
> +    }
> +
> +    switch (reg) {
> +    case 0 ... 7: /* xPSR sub-fields */
> +        /* only APSR is actually writable */
> +        if (!(reg & 4)) {
> +            uint32_t apsrmask =3D 0;
> +
> +            if (mask & 8) {
> +                apsrmask |=3D XPSR_NZCV | XPSR_Q;
> +            }
> +            if ((mask & 4) && arm_feature(env, ARM_FEATURE_THUMB_DSP)) {
> +                apsrmask |=3D XPSR_GE;
> +            }
> +            xpsr_write(env, val, apsrmask);
> +        }
> +        break;
> +    case 8: /* MSP */
> +        if (v7m_using_psp(env)) {
> +            env->v7m.other_sp =3D val;
> +        } else {
> +            env->regs[13] =3D val;
> +        }
> +        break;
> +    case 9: /* PSP */
> +        if (v7m_using_psp(env)) {
> +            env->regs[13] =3D val;
> +        } else {
> +            env->v7m.other_sp =3D val;
> +        }
> +        break;
> +    case 10: /* MSPLIM */
> +        if (!arm_feature(env, ARM_FEATURE_V8)) {
> +            goto bad_reg;
> +        }
> +        env->v7m.msplim[env->v7m.secure] =3D val & ~7;
> +        break;
> +    case 11: /* PSPLIM */
> +        if (!arm_feature(env, ARM_FEATURE_V8)) {
> +            goto bad_reg;
> +        }
> +        env->v7m.psplim[env->v7m.secure] =3D val & ~7;
> +        break;
> +    case 16: /* PRIMASK */
> +        env->v7m.primask[env->v7m.secure] =3D val & 1;
> +        break;
> +    case 17: /* BASEPRI */
> +        if (!arm_feature(env, ARM_FEATURE_M_MAIN)) {
> +            goto bad_reg;
> +        }
> +        env->v7m.basepri[env->v7m.secure] =3D val & 0xff;
> +        break;
> +    case 18: /* BASEPRI_MAX */
> +        if (!arm_feature(env, ARM_FEATURE_M_MAIN)) {
> +            goto bad_reg;
> +        }
> +        val &=3D 0xff;
> +        if (val !=3D 0 && (val < env->v7m.basepri[env->v7m.secure]
> +                         || env->v7m.basepri[env->v7m.secure] =3D=3D 0))=
 {
> +            env->v7m.basepri[env->v7m.secure] =3D val;
> +        }
> +        break;
> +    case 19: /* FAULTMASK */
> +        if (!arm_feature(env, ARM_FEATURE_M_MAIN)) {
> +            goto bad_reg;
> +        }
> +        env->v7m.faultmask[env->v7m.secure] =3D val & 1;
> +        break;
> +    case 20: /* CONTROL */
> +        /*
> +         * Writing to the SPSEL bit only has an effect if we are in
> +         * thread mode; other bits can be updated by any privileged code.
> +         * write_v7m_control_spsel() deals with updating the SPSEL bit in
> +         * env->v7m.control, so we only need update the others.
> +         * For v7M, we must just ignore explicit writes to SPSEL in hand=
ler
> +         * mode; for v8M the write is permitted but will have no effect.
> +         * All these bits are writes-ignored from non-privileged code,
> +         * except for SFPA.
> +         */
> +        if (cur_el > 0 && (arm_feature(env, ARM_FEATURE_V8) ||
> +                           !arm_v7m_is_handler_mode(env))) {
> +            write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK=
) !=3D 0);
> +        }
> +        if (cur_el > 0 && arm_feature(env, ARM_FEATURE_M_MAIN)) {
> +            env->v7m.control[env->v7m.secure] &=3D ~R_V7M_CONTROL_NPRIV_=
MASK;
> +            env->v7m.control[env->v7m.secure] |=3D val & R_V7M_CONTROL_N=
PRIV_MASK;
> +        }
> +        if (arm_feature(env, ARM_FEATURE_VFP)) {
> +            /*
> +             * SFPA is RAZ/WI from NS or if no FPU.
> +             * FPCA is RO if NSACR.CP10 =3D=3D 0, RES0 if the FPU is not=
 present.
> +             * Both are stored in the S bank.
> +             */
> +            if (env->v7m.secure) {
> +                env->v7m.control[M_REG_S] &=3D ~R_V7M_CONTROL_SFPA_MASK;
> +                env->v7m.control[M_REG_S] |=3D val & R_V7M_CONTROL_SFPA_=
MASK;
> +            }
> +            if (cur_el > 0 &&
> +                (env->v7m.secure || !arm_feature(env, ARM_FEATURE_M_SECU=
RITY) ||
> +                 extract32(env->v7m.nsacr, 10, 1))) {
> +                env->v7m.control[M_REG_S] &=3D ~R_V7M_CONTROL_FPCA_MASK;
> +                env->v7m.control[M_REG_S] |=3D val & R_V7M_CONTROL_FPCA_=
MASK;
> +            }
> +        }
> +        break;
> +    default:
> +    bad_reg:
> +        qemu_log_mask(LOG_GUEST_ERROR, "Attempt to write unknown special"
> +                                       " register %d\n", reg);
> +        return;
> +    }
> +}
> +
> +uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
> +{
> +    /* Implement the TT instruction. op is bits [7:6] of the insn. */
> +    bool forceunpriv =3D op & 1;
> +    bool alt =3D op & 2;
> +    V8M_SAttributes sattrs =3D {};
> +    uint32_t tt_resp;
> +    bool r, rw, nsr, nsrw, mrvalid;
> +    int prot;
> +    ARMMMUFaultInfo fi =3D {};
> +    MemTxAttrs attrs =3D {};
> +    hwaddr phys_addr;
> +    ARMMMUIdx mmu_idx;
> +    uint32_t mregion;
> +    bool targetpriv;
> +    bool targetsec =3D env->v7m.secure;
> +    bool is_subpage;
> +
> +    /*
> +     * Work out what the security state and privilege level we're
> +     * interested in is...
> +     */
> +    if (alt) {
> +        targetsec =3D !targetsec;
> +    }
> +
> +    if (forceunpriv) {
> +        targetpriv =3D false;
> +    } else {
> +        targetpriv =3D arm_v7m_is_handler_mode(env) ||
> +            !(env->v7m.control[targetsec] & R_V7M_CONTROL_NPRIV_MASK);
> +    }
> +
> +    /* ...and then figure out which MMU index this is */
> +    mmu_idx =3D arm_v7m_mmu_idx_for_secstate_and_priv(env, targetsec, ta=
rgetpriv);
> +
> +    /*
> +     * We know that the MPU and SAU don't care about the access type
> +     * for our purposes beyond that we don't want to claim to be
> +     * an insn fetch, so we arbitrarily call this a read.
> +     */
> +
> +    /*
> +     * MPU region info only available for privileged or if
> +     * inspecting the other MPU state.
> +     */
> +    if (arm_current_el(env) !=3D 0 || alt) {
> +        /* We can ignore the return value as prot is always set */
> +        pmsav8_mpu_lookup(env, addr, MMU_DATA_LOAD, mmu_idx,
> +                          &phys_addr, &attrs, &prot, &is_subpage,
> +                          &fi, &mregion);
> +        if (mregion =3D=3D -1) {
> +            mrvalid =3D false;
> +            mregion =3D 0;
> +        } else {
> +            mrvalid =3D true;
> +        }
> +        r =3D prot & PAGE_READ;
> +        rw =3D prot & PAGE_WRITE;
> +    } else {
> +        r =3D false;
> +        rw =3D false;
> +        mrvalid =3D false;
> +        mregion =3D 0;
> +    }
> +
> +    if (env->v7m.secure) {
> +        v8m_security_lookup(env, addr, MMU_DATA_LOAD, mmu_idx, &sattrs);
> +        nsr =3D sattrs.ns && r;
> +        nsrw =3D sattrs.ns && rw;
> +    } else {
> +        sattrs.ns =3D true;
> +        nsr =3D false;
> +        nsrw =3D false;
> +    }
> +
> +    tt_resp =3D (sattrs.iregion << 24) |
> +        (sattrs.irvalid << 23) |
> +        ((!sattrs.ns) << 22) |
> +        (nsrw << 21) |
> +        (nsr << 20) |
> +        (rw << 19) |
> +        (r << 18) |
> +        (sattrs.srvalid << 17) |
> +        (mrvalid << 16) |
> +        (sattrs.sregion << 8) |
> +        mregion;
> +
> +    return tt_resp;
> +}
> +
> +#endif /* CONFIG_USER_ONLY */


--
Alex Benn=C3=A9e

