Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCDCC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010D5208CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+YI6QqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010D5208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcu0e-0000ia-Gi
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50168)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcstq-0007ES-3e
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcstn-0008J0-AV
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:46:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcstl-0008DA-5c
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:46:17 -0400
Received: by mail-wm1-x341.google.com with SMTP id c66so9597269wmf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=kUDaIYiEHqtf3yY6EEM+mFPZ4JuzcELa3Byy8F5bCqs=;
 b=D+YI6QqSEs91Tpx5l46tmGX3eyBYI1ZNjS3YuppFqJaKujDUOtNGPbW7XpbcyIvTp8
 kiNXoEjY2qTkCO4BwZ79cP6vmud65i7HNDHCs5Rq3elLcKLG/tb52bqmIzbBhozCN+wH
 lovCvxAgTRGFqv8wrZY9D7uv/xZDd14I2xd4PimlcsUTlA2rk2iOUMl+cbjcjtyiSvoR
 0fsED4ReMERgeTpRsH4rgXkzjNgF9biQOdvkvQJUyatlIxnQKhwtOVAv+H6/zdRSoSOL
 Yx6PFGxPg+KmaKQpFk57L/eqHcAFKotSITPxV6oZTtVc7LSRSfcJPUzHAAxErSisv7IT
 D2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=kUDaIYiEHqtf3yY6EEM+mFPZ4JuzcELa3Byy8F5bCqs=;
 b=RmHnwFnpqfKbUB2lWJGJqu0wTFEwmA33pIvUigkVaNjYnV0aM1YEFfZzxRuqNYq8YN
 fq4vb+lqQh8iX+LbQZvHEszjSu+b6ocIHvfnGLbJEDcfPo111VRV8fKTS2KRsG3r2gvh
 qDg7Eie9MPc8tNJzzrzxF3dp8JYwQx7JEqlp3qLhg31ZsXq8aaLAmIdvSgodQDMdRb9F
 43kuAvlOAWFdOIcSvkt3ywN38jwWMSX8DltYD/hqJdhM5CmftWEgn6mAZe+kaQPt+7yf
 az/muUwVA1mxwPpNycHSGN3r4ljwYarD2J5RAF6cKpGmPStGWHrSyIJ5QLMuSUUNIYSM
 2pVg==
X-Gm-Message-State: APjAAAWbEO7LQQG7sMfSVa7krBCx0yaqHYmbRxc4UG+b/pm1qgcnaFwg
 279Tcuq1OsKV1JGpfgFrRnMXeA==
X-Google-Smtp-Source: APXvYqzqr9lHq1W4ZKJE02H958W11/BC3tDMgoCCavRIeeM/NeuPsF4V6ZDX3dMmASp1cRTXBKVMlg==
X-Received: by 2002:a1c:c8:: with SMTP id 191mr19443885wma.6.1560782769217;
 Mon, 17 Jun 2019 07:46:09 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p3sm13765213wrd.47.2019.06.17.07.46.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 07:46:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 40F271FF87;
 Mon, 17 Jun 2019 15:46:08 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-20-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-20-philmd@redhat.com>
Date: Mon, 17 Jun 2019 15:46:08 +0100
Message-ID: <87fto89snj.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 19/23] target/arm: Move
 watchpoints APIs to helper.c
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Robert Bradford <robert.bradford@intel.com>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> From: Samuel Ortiz <sameo@linux.intel.com>
>
> Here again, those APIs are not TCG dependent and can move to the always
> built helper.c.

Are you sure about that?

Under KVM BP and WP exceptions only ever make there way to QEMU when
guest debug is in effect. At which point it goes through
kvm_arm_handle_debug where we decide if this is a BP/WP set by guest
debugging or actually a real nested debug event which we currently fail
to deliver correctly.

If guest debug is not in effect then these BP/WP exceptions should be
delivered directly to the guest EL1 and never come to us.

I think these functions are TCG only for emulation of debug hardware.

>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
> [PMD: Rebased]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/arm/helper.c    | 213 +++++++++++++++++++++++++++++++++++++++++
>  target/arm/internals.h |   6 ++
>  target/arm/op_helper.c | 213 -----------------------------------------
>  3 files changed, 219 insertions(+), 213 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8c32b2bc0d..8b7ce0561b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11508,3 +11508,216 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, =
int flags)
>          qemu_fprintf(f, "FPSCR: %08x\n", vfp_get_fpscr(env));
>      }
>  }
> +
> +/* Return true if the linked breakpoint entry lbn passes its checks */
> +static bool linked_bp_matches(ARMCPU *cpu, int lbn)
> +{
> +    CPUARMState *env =3D &cpu->env;
> +    uint64_t bcr =3D env->cp15.dbgbcr[lbn];
> +    int brps =3D extract32(cpu->dbgdidr, 24, 4);
> +    int ctx_cmps =3D extract32(cpu->dbgdidr, 20, 4);
> +    int bt;
> +    uint32_t contextidr;
> +
> +    /*
> +     * Links to unimplemented or non-context aware breakpoints are
> +     * CONSTRAINED UNPREDICTABLE: either behave as if disabled, or
> +     * as if linked to an UNKNOWN context-aware breakpoint (in which
> +     * case DBGWCR<n>_EL1.LBN must indicate that breakpoint).
> +     * We choose the former.
> +     */
> +    if (lbn > brps || lbn < (brps - ctx_cmps)) {
> +        return false;
> +    }
> +
> +    bcr =3D env->cp15.dbgbcr[lbn];
> +
> +    if (extract64(bcr, 0, 1) =3D=3D 0) {
> +        /* Linked breakpoint disabled : generate no events */
> +        return false;
> +    }
> +
> +    bt =3D extract64(bcr, 20, 4);
> +
> +    /*
> +     * We match the whole register even if this is AArch32 using the
> +     * short descriptor format (in which case it holds both PROCID and A=
SID),
> +     * since we don't implement the optional v7 context ID masking.
> +     */
> +    contextidr =3D extract64(env->cp15.contextidr_el[1], 0, 32);
> +
> +    switch (bt) {
> +    case 3: /* linked context ID match */
> +        if (arm_current_el(env) > 1) {
> +            /* Context matches never fire in EL2 or (AArch64) EL3 */
> +            return false;
> +        }
> +        return (contextidr =3D=3D extract64(env->cp15.dbgbvr[lbn], 0, 32=
));
> +    case 5: /* linked address mismatch (reserved in AArch64) */
> +    case 9: /* linked VMID match (reserved if no EL2) */
> +    case 11: /* linked context ID and VMID match (reserved if no EL2) */
> +    default:
> +        /*
> +         * Links to Unlinked context breakpoints must generate no
> +         * events; we choose to do the same for reserved values too.
> +         */
> +        return false;
> +    }
> +
> +    return false;
> +}
> +
> +bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
> +{
> +    CPUARMState *env =3D &cpu->env;
> +    uint64_t cr;
> +    int pac, hmc, ssc, wt, lbn;
> +    /*
> +     * Note that for watchpoints the check is against the CPU security
> +     * state, not the S/NS attribute on the offending data access.
> +     */
> +    bool is_secure =3D arm_is_secure(env);
> +    int access_el =3D arm_current_el(env);
> +
> +    if (is_wp) {
> +        CPUWatchpoint *wp =3D env->cpu_watchpoint[n];
> +
> +        if (!wp || !(wp->flags & BP_WATCHPOINT_HIT)) {
> +            return false;
> +        }
> +        cr =3D env->cp15.dbgwcr[n];
> +        if (wp->hitattrs.user) {
> +            /*
> +             * The LDRT/STRT/LDT/STT "unprivileged access" instructions =
should
> +             * match watchpoints as if they were accesses done at EL0, e=
ven if
> +             * the CPU is at EL1 or higher.
> +             */
> +            access_el =3D 0;
> +        }
> +    } else {
> +        uint64_t pc =3D is_a64(env) ? env->pc : env->regs[15];
> +
> +        if (!env->cpu_breakpoint[n] || env->cpu_breakpoint[n]->pc !=3D p=
c) {
> +            return false;
> +        }
> +        cr =3D env->cp15.dbgbcr[n];
> +    }
> +    /*
> +     * The WATCHPOINT_HIT flag guarantees us that the watchpoint is
> +     * enabled and that the address and access type match; for breakpoin=
ts
> +     * we know the address matched; check the remaining fields, including
> +     * linked breakpoints. We rely on WCR and BCR having the same layout
> +     * for the LBN, SSC, HMC, PAC/PMC and is-linked fields.
> +     * Note that some combinations of {PAC, HMC, SSC} are reserved and
> +     * must act either like some valid combination or as if the watchpoi=
nt
> +     * were disabled. We choose the former, and use this together with
> +     * the fact that EL3 must always be Secure and EL2 must always be
> +     * Non-Secure to simplify the code slightly compared to the full
> +     * table in the ARM ARM.
> +     */
> +    pac =3D extract64(cr, 1, 2);
> +    hmc =3D extract64(cr, 13, 1);
> +    ssc =3D extract64(cr, 14, 2);
> +
> +    switch (ssc) {
> +    case 0:
> +        break;
> +    case 1:
> +    case 3:
> +        if (is_secure) {
> +            return false;
> +        }
> +        break;
> +    case 2:
> +        if (!is_secure) {
> +            return false;
> +        }
> +        break;
> +    }
> +
> +    switch (access_el) {
> +    case 3:
> +    case 2:
> +        if (!hmc) {
> +            return false;
> +        }
> +        break;
> +    case 1:
> +        if (extract32(pac, 0, 1) =3D=3D 0) {
> +            return false;
> +        }
> +        break;
> +    case 0:
> +        if (extract32(pac, 1, 1) =3D=3D 0) {
> +            return false;
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    wt =3D extract64(cr, 20, 1);
> +    lbn =3D extract64(cr, 16, 4);
> +
> +    if (wt && !linked_bp_matches(cpu, lbn)) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static bool check_watchpoints(ARMCPU *cpu)
> +{
> +    CPUARMState *env =3D &cpu->env;
> +    int n;
> +
> +    /*
> +     * If watchpoints are disabled globally or we can't take debug
> +     * exceptions here then watchpoint firings are ignored.
> +     */
> +    if (extract32(env->cp15.mdscr_el1, 15, 1) =3D=3D 0
> +        || !arm_generate_debug_exceptions(env)) {
> +        return false;
> +    }
> +
> +    for (n =3D 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
> +        if (bp_wp_matches(cpu, n, true)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
> +{
> +    /*
> +     * Called by core code when a CPU watchpoint fires; need to check if=
 this
> +     * is also an architectural watchpoint match.
> +     */
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +
> +    return check_watchpoints(cpu);
> +}
> +
> +vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +    CPUARMState *env =3D &cpu->env;
> +
> +    /*
> +     * In BE32 system mode, target memory is stored byteswapped (on a
> +     * little-endian host system), and by the time we reach here (via an
> +     * opcode helper) the addresses of subword accesses have been adjust=
ed
> +     * to account for that, which means that watchpoints will not match.
> +     * Undo the adjustment here.
> +     */
> +    if (arm_sctlr_b(env)) {
> +        if (len =3D=3D 1) {
> +            addr ^=3D 3;
> +        } else if (len =3D=3D 2) {
> +            addr ^=3D 2;
> +        }
> +    }
> +
> +    return addr;
> +}
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 56281d8ece..fbbc701bb0 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1042,6 +1042,12 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t =
address,
>                         int *prot, bool *is_subpage,
>                         ARMMMUFaultInfo *fi, uint32_t *mregion);
>
> +/*
> + * Returns true when the current CPU execution context matches
> + * the watchpoint or the breakpoint pointed at by n.
> + */
> +bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp);
> +
>  #ifdef TARGET_AARCH64
>  void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags);
>  #else
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 63bce32810..68740e1b30 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -1018,185 +1018,6 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t s=
yndrome)
>      }
>  }
>
> -/* Return true if the linked breakpoint entry lbn passes its checks */
> -static bool linked_bp_matches(ARMCPU *cpu, int lbn)
> -{
> -    CPUARMState *env =3D &cpu->env;
> -    uint64_t bcr =3D env->cp15.dbgbcr[lbn];
> -    int brps =3D extract32(cpu->dbgdidr, 24, 4);
> -    int ctx_cmps =3D extract32(cpu->dbgdidr, 20, 4);
> -    int bt;
> -    uint32_t contextidr;
> -
> -    /*
> -     * Links to unimplemented or non-context aware breakpoints are
> -     * CONSTRAINED UNPREDICTABLE: either behave as if disabled, or
> -     * as if linked to an UNKNOWN context-aware breakpoint (in which
> -     * case DBGWCR<n>_EL1.LBN must indicate that breakpoint).
> -     * We choose the former.
> -     */
> -    if (lbn > brps || lbn < (brps - ctx_cmps)) {
> -        return false;
> -    }
> -
> -    bcr =3D env->cp15.dbgbcr[lbn];
> -
> -    if (extract64(bcr, 0, 1) =3D=3D 0) {
> -        /* Linked breakpoint disabled : generate no events */
> -        return false;
> -    }
> -
> -    bt =3D extract64(bcr, 20, 4);
> -
> -    /*
> -     * We match the whole register even if this is AArch32 using the
> -     * short descriptor format (in which case it holds both PROCID and A=
SID),
> -     * since we don't implement the optional v7 context ID masking.
> -     */
> -    contextidr =3D extract64(env->cp15.contextidr_el[1], 0, 32);
> -
> -    switch (bt) {
> -    case 3: /* linked context ID match */
> -        if (arm_current_el(env) > 1) {
> -            /* Context matches never fire in EL2 or (AArch64) EL3 */
> -            return false;
> -        }
> -        return (contextidr =3D=3D extract64(env->cp15.dbgbvr[lbn], 0, 32=
));
> -    case 5: /* linked address mismatch (reserved in AArch64) */
> -    case 9: /* linked VMID match (reserved if no EL2) */
> -    case 11: /* linked context ID and VMID match (reserved if no EL2) */
> -    default:
> -        /*
> -         * Links to Unlinked context breakpoints must generate no
> -         * events; we choose to do the same for reserved values too.
> -         */
> -        return false;
> -    }
> -
> -    return false;
> -}
> -
> -static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
> -{
> -    CPUARMState *env =3D &cpu->env;
> -    uint64_t cr;
> -    int pac, hmc, ssc, wt, lbn;
> -    /*
> -     * Note that for watchpoints the check is against the CPU security
> -     * state, not the S/NS attribute on the offending data access.
> -     */
> -    bool is_secure =3D arm_is_secure(env);
> -    int access_el =3D arm_current_el(env);
> -
> -    if (is_wp) {
> -        CPUWatchpoint *wp =3D env->cpu_watchpoint[n];
> -
> -        if (!wp || !(wp->flags & BP_WATCHPOINT_HIT)) {
> -            return false;
> -        }
> -        cr =3D env->cp15.dbgwcr[n];
> -        if (wp->hitattrs.user) {
> -            /*
> -             * The LDRT/STRT/LDT/STT "unprivileged access" instructions =
should
> -             * match watchpoints as if they were accesses done at EL0, e=
ven if
> -             * the CPU is at EL1 or higher.
> -             */
> -            access_el =3D 0;
> -        }
> -    } else {
> -        uint64_t pc =3D is_a64(env) ? env->pc : env->regs[15];
> -
> -        if (!env->cpu_breakpoint[n] || env->cpu_breakpoint[n]->pc !=3D p=
c) {
> -            return false;
> -        }
> -        cr =3D env->cp15.dbgbcr[n];
> -    }
> -    /*
> -     * The WATCHPOINT_HIT flag guarantees us that the watchpoint is
> -     * enabled and that the address and access type match; for breakpoin=
ts
> -     * we know the address matched; check the remaining fields, including
> -     * linked breakpoints. We rely on WCR and BCR having the same layout
> -     * for the LBN, SSC, HMC, PAC/PMC and is-linked fields.
> -     * Note that some combinations of {PAC, HMC, SSC} are reserved and
> -     * must act either like some valid combination or as if the watchpoi=
nt
> -     * were disabled. We choose the former, and use this together with
> -     * the fact that EL3 must always be Secure and EL2 must always be
> -     * Non-Secure to simplify the code slightly compared to the full
> -     * table in the ARM ARM.
> -     */
> -    pac =3D extract64(cr, 1, 2);
> -    hmc =3D extract64(cr, 13, 1);
> -    ssc =3D extract64(cr, 14, 2);
> -
> -    switch (ssc) {
> -    case 0:
> -        break;
> -    case 1:
> -    case 3:
> -        if (is_secure) {
> -            return false;
> -        }
> -        break;
> -    case 2:
> -        if (!is_secure) {
> -            return false;
> -        }
> -        break;
> -    }
> -
> -    switch (access_el) {
> -    case 3:
> -    case 2:
> -        if (!hmc) {
> -            return false;
> -        }
> -        break;
> -    case 1:
> -        if (extract32(pac, 0, 1) =3D=3D 0) {
> -            return false;
> -        }
> -        break;
> -    case 0:
> -        if (extract32(pac, 1, 1) =3D=3D 0) {
> -            return false;
> -        }
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -
> -    wt =3D extract64(cr, 20, 1);
> -    lbn =3D extract64(cr, 16, 4);
> -
> -    if (wt && !linked_bp_matches(cpu, lbn)) {
> -        return false;
> -    }
> -
> -    return true;
> -}
> -
> -static bool check_watchpoints(ARMCPU *cpu)
> -{
> -    CPUARMState *env =3D &cpu->env;
> -    int n;
> -
> -    /*
> -     * If watchpoints are disabled globally or we can't take debug
> -     * exceptions here then watchpoint firings are ignored.
> -     */
> -    if (extract32(env->cp15.mdscr_el1, 15, 1) =3D=3D 0
> -        || !arm_generate_debug_exceptions(env)) {
> -        return false;
> -    }
> -
> -    for (n =3D 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
> -        if (bp_wp_matches(cpu, n, true)) {
> -            return true;
> -        }
> -    }
> -    return false;
> -}
> -
>  static bool check_breakpoints(ARMCPU *cpu)
>  {
>      CPUARMState *env =3D &cpu->env;
> @@ -1227,40 +1048,6 @@ void HELPER(check_breakpoints)(CPUARMState *env)
>      }
>  }
>
> -bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
> -{
> -    /*
> -     * Called by core code when a CPU watchpoint fires; need to check if=
 this
> -     * is also an architectural watchpoint match.
> -     */
> -    ARMCPU *cpu =3D ARM_CPU(cs);
> -
> -    return check_watchpoints(cpu);
> -}
> -
> -vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len)
> -{
> -    ARMCPU *cpu =3D ARM_CPU(cs);
> -    CPUARMState *env =3D &cpu->env;
> -
> -    /*
> -     * In BE32 system mode, target memory is stored byteswapped (on a
> -     * little-endian host system), and by the time we reach here (via an
> -     * opcode helper) the addresses of subword accesses have been adjust=
ed
> -     * to account for that, which means that watchpoints will not match.
> -     * Undo the adjustment here.
> -     */
> -    if (arm_sctlr_b(env)) {
> -        if (len =3D=3D 1) {
> -            addr ^=3D 3;
> -        } else if (len =3D=3D 2) {
> -            addr ^=3D 2;
> -        }
> -    }
> -
> -    return addr;
> -}
> -
>  void arm_debug_excp_handler(CPUState *cs)
>  {
>      /* Called by core code when a watchpoint or breakpoint fires;


--
Alex Benn=C3=A9e

