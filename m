Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A21DC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E03217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ijq5ufue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E03217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqeJm-0002Tq-Rt
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56697)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqeJY-00025U-Bp
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqeJV-0000B5-W9
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:01:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34261)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqeJV-0000AP-Jq
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:01:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id 31so50971671wrm.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DT8/93iloC6tNxOIbu3Kyideq/OUCt3AcV2F+/VEDPc=;
 b=Ijq5ufueKLlJew5B3nmzG+eKqz/5slepRfGgcFKKx6J/soPujrazcYqel1uwtdIdeY
 egNemeCfULyl0QM4F9TIRmLhdwCMC8QVcr20xitIyrKU6J/kjwFbA0G7PRZG/B6pk23E
 qHNdvRekD7RmetY3yN9n+2949IIBY0Llz/ysW8D2i92tzACnshR1EtEEEpticjtDxH0Y
 JpBoORkwhcegnGZEibQqcc8B8G11uc6n+hIFxXFnaFeXBwM3SsZDHmQNQMJdm/yFCeo7
 vlzgddsRUCv4c/w6XMMsuzVc2L+24+3IOO7C7+6JJbqsgy9VDMxl7ZO7BLu9aTi1AR86
 mE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DT8/93iloC6tNxOIbu3Kyideq/OUCt3AcV2F+/VEDPc=;
 b=UDRQQHd/v0TSXBa576kY6d5aDaYDvYgLo4hY4sSzPkUVeXyXMyhv5oVdjfOjOhL9uE
 acqe/kprFarKjlqLLBYnryU2QgNmq08dD2jL/PdooC3Lwt5uOepBUmOXd2YhwFIrSNT/
 fPfcDFjxJ1rHkmHpn57XP82pBf1mNjVaY/rM0e3jBRA2XpPkIkBdd8HeRC58+/frFrce
 vAM0rLh88DYeJFOVxGz/ae5UcQab9vIEShP/ZhGotbfiBG871Y4dDDlNMfP0I8dLSH/u
 lrzpxfV6cAOfzhlDIkCXW5oPWoyEyFEW1QbS48yWWbrnOWtJh+IAyVdUTYyEqdR2TvaT
 Vlrw==
X-Gm-Message-State: APjAAAVEnR+doRSjckUEumUHeCnyJjl4m75223yWluvqzSPtnzfY1Tkj
 E/TYS7OMsZxw+4e59vyrDVDbVg==
X-Google-Smtp-Source: APXvYqy64ycKLri/dwYu9MAlaYZ+8kQZfDUv20GKHqrGoLMAHymNx7DjQ0VKmBWg6nvq5kma5GJU4A==
X-Received: by 2002:adf:f851:: with SMTP id d17mr95793670wrq.77.1564063303508; 
 Thu, 25 Jul 2019 07:01:43 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 5sm41295637wmg.42.2019.07.25.07.01.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 07:01:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 647341FF87;
 Thu, 25 Jul 2019 15:01:42 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-13-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-13-richard.henderson@linaro.org>
Date: Thu, 25 Jul 2019 15:01:42 +0100
Message-ID: <871rye1ad5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH for-4.2 12/24] target/arm: Add VHE system
 register redirection and aliasing
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Several of the EL1/0 registers are redirected to the EL2 version when in
> EL2 and HCR_EL2.E2H is set.  Many of these registers have side effects.
> Link together the two ARMCPRegInfo structures after they have been
> properly instantiated.  Install common dispatch routines to all of the
> relevant registers.
>
> The same set of registers that are redirected also have additional
> EL12/EL02 aliases created to access the original register that was
> redirected.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    |  44 ++++++++----
>  target/arm/helper.c | 171 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 202 insertions(+), 13 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index bba4e1f984..a0f10b60eb 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2455,19 +2455,6 @@ struct ARMCPRegInfo {
>       */
>      ptrdiff_t fieldoffset; /* offsetof(CPUARMState, field) */
>
> -    /* Offsets of the secure and non-secure fields in CPUARMState for the
> -     * register if it is banked.  These fields are only used during the =
static
> -     * registration of a register.  During hashing the bank associated
> -     * with a given security state is copied to fieldoffset which is use=
d from
> -     * there on out.
> -     *
> -     * It is expected that register definitions use either fieldoffset or
> -     * bank_fieldoffsets in the definition but not both.  It is also exp=
ected
> -     * that both bank offsets are set when defining a banked register.  =
This
> -     * use indicates that a register is banked.
> -     */
> -    ptrdiff_t bank_fieldoffsets[2];
> -
>      /* Function for making any access checks for this register in additi=
on to
>       * those specified by the 'access' permissions bits. If NULL, no ext=
ra
>       * checks required. The access check is performed at runtime, not at
> @@ -2502,6 +2489,37 @@ struct ARMCPRegInfo {
>       * fieldoffset is 0 then no reset will be done.
>       */
>      CPResetFn *resetfn;
> +
> +    union {
> +        /*
> +         * Offsets of the secure and non-secure fields in CPUARMState for
> +         * the register if it is banked.  These fields are only used dur=
ing
> +         * the static registration of a register.  During hashing the ba=
nk
> +         * associated with a given security state is copied to fieldoffs=
et
> +         * which is used from there on out.
> +         *
> +         * It is expected that register definitions use either fieldoffs=
et
> +         * or bank_fieldoffsets in the definition but not both.  It is a=
lso
> +         * expected that both bank offsets are set when defining a banked
> +         * register.  This use indicates that a register is banked.
> +         */
> +        ptrdiff_t bank_fieldoffsets[2];

It seems a bit off that we are compressing this structure into a union
when we didn't bother with the above fieldoffset despite the statement
that only one or the other is used.

> +
> +        /*
> +         * "Original" writefn and readfn.
> +         * For ARMv8.1-VHE register aliases, we overwrite the read/write
> +         * accessor functions of various EL1/EL0 to perform the runtime
> +         * check for which sysreg should actually be modified, and then
> +         * forwards the operation.  Before overwriting the accessors,
> +         * the original function is copied here, so that accesses that
> +         * really do go to the EL1/EL0 version proceed normally.
> +         * (The corresponding EL2 register is linked via opaque.)
> +         */
> +        struct {
> +            CPReadFn *orig_readfn;
> +            CPWriteFn *orig_writefn;
> +        };

Is 2 pointers enough saving? Will we never see a re-directed register
that was using the banked fieldoffsets? Can we protect against that?

> +    };
>  };
>
>  /* Macros which are lvalues for the field in CPUARMState for the
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 329548e45d..9a9809ff4f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5228,6 +5228,169 @@ static const ARMCPRegInfo el3_cp_reginfo[] =3D {
>      REGINFO_SENTINEL
>  };
>

You already know about the ifndef CONFIG_USER_ONLY needed here:

> +/* Test if system register redirection is to occur in the current state.=
  */
> +static bool redirect_for_e2h(CPUARMState *env)
> +{
> +    return arm_current_el(env) =3D=3D 2 && (arm_hcr_el2_eff(env) & HCR_E=
2H);
> +}
> +
> +static uint64_t el2_e2h_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    CPReadFn *readfn;
> +
> +    if (redirect_for_e2h(env)) {
> +        /* Switch to the saved EL2 version of the register.  */
> +        ri =3D ri->opaque;
> +        readfn =3D ri->readfn;
> +    } else {
> +        readfn =3D ri->orig_readfn;
> +    }
> +    if (readfn =3D=3D NULL) {
> +        readfn =3D raw_read;
> +    }
> +    return readfn(env, ri);
> +}
> +
> +static void el2_e2h_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                          uint64_t value)
> +{
> +    CPWriteFn *writefn;
> +
> +    if (redirect_for_e2h(env)) {
> +        /* Switch to the saved EL2 version of the register.  */
> +        ri =3D ri->opaque;
> +        writefn =3D ri->writefn;
> +    } else {
> +        writefn =3D ri->orig_writefn;
> +    }
> +    if (writefn =3D=3D NULL) {
> +        writefn =3D raw_write;
> +    }
> +    writefn(env, ri, value);
> +}
> +
> +static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
> +{
> +    struct E2HAlias {
> +        uint32_t src_key, dst_key, new_key;
> +        const char *src_name, *dst_name, *new_name;

  /* some redirects are only enabled on feature detection */ ?

> +        bool (*feature)(const ARMISARegisters *id);
> +    };
> +
> +#define K(op0, op1, crn, crm, op2) \
> +    ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2)
> +
> +    static const struct E2HAlias aliases[] =3D {
> +        { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
> +          "SCTLR", "SCTLR_EL2", "SCTLR_EL12" },
> +        { K(3, 0,  1, 0, 2), K(3, 4,  1, 1, 2), K(3, 5, 1, 0, 2),
> +          "CPACR", "CPTR_EL2", "CPACR_EL12" },
> +        { K(3, 0,  2, 0, 0), K(3, 4,  2, 0, 0), K(3, 5, 2, 0, 0),
> +          "TTBR0_EL1", "TTBR0_EL2", "TTBR0_EL12" },
> +        { K(3, 0,  2, 0, 1), K(3, 4,  2, 0, 1), K(3, 5, 2, 0, 1),
> +          "TTBR1_EL1", "TTBR1_EL2", "TTBR1_EL12" },
> +        { K(3, 0,  2, 0, 2), K(3, 4,  2, 0, 2), K(3, 5, 2, 0, 2),
> +          "TCR_EL1", "TCR_EL2", "TCR_EL12" },
> +        { K(3, 0,  4, 0, 0), K(3, 4,  4, 0, 0), K(3, 5, 4, 0, 0),
> +          "SPSR_EL1", "SPSR_EL2", "SPSR_EL12" },
> +        { K(3, 0,  4, 0, 1), K(3, 4,  4, 0, 1), K(3, 5, 4, 0, 1),
> +          "ELR_EL1", "ELR_EL2", "ELR_EL12" },
> +        { K(3, 0,  5, 1, 0), K(3, 4,  5, 1, 0), K(3, 5, 5, 1, 0),
> +          "AFSR0_EL1", "AFSR0_EL2", "AFSR0_EL12" },
> +        { K(3, 0,  5, 1, 1), K(3, 4,  5, 1, 1), K(3, 5, 5, 1, 1),
> +          "AFSR1_EL1", "AFSR1_EL2", "AFSR1_EL12" },
> +        { K(3, 0,  5, 2, 0), K(3, 4,  5, 2, 0), K(3, 5, 5, 2, 0),
> +          "ESR_EL1", "ESR_EL2", "ESR_EL12" },
> +        { K(3, 0,  6, 0, 0), K(3, 4,  6, 0, 0), K(3, 5, 6, 0, 0),
> +          "FAR_EL1", "FAR_EL2", "FAR_EL12" },
> +        { K(3, 0, 10, 2, 0), K(3, 4, 10, 2, 0), K(3, 5, 10, 2, 0),
> +          "MAIR_EL1", "MAIR_EL2", "MAIR_EL12" },
> +        { K(3, 0, 10, 3, 0), K(3, 4, 10, 3, 0), K(3, 5, 10, 3, 0),
> +          "AMAIR0", "AMAIR_EL2", "AMAIR_EL12" },
> +        { K(3, 0, 12, 0, 0), K(3, 4, 12, 0, 0), K(3, 5, 12, 0, 0),
> +          "VBAR", "VBAR_EL2", "VBAR_EL12" },
> +        { K(3, 0, 13, 0, 1), K(3, 4, 13, 0, 1), K(3, 5, 13, 0, 1),
> +          "CONTEXTIDR_EL1", "CONTEXTIDR_EL2", "CONTEXTIDR_EL12" },
> +        { K(3, 0, 14, 1, 0), K(3, 4, 14, 1, 0), K(3, 5, 14, 1, 0),
> +          "CNTKCTL", "CNTHCTL_EL2", "CNTKCTL_EL12" },
> +        { K(3, 3, 14, 2, 0), K(3, 4, 14, 2, 0), K(3, 5, 14, 2, 0),
> +          "CNTP_TVAL_EL0", "CNTHP_TVAL_EL2", "CNTP_TVAL_EL02" },
> +        { K(3, 3, 14, 2, 1), K(3, 4, 14, 2, 1), K(3, 5, 14, 2, 1),
> +          "CNTP_CTL_EL0", "CNTHP_CTL_EL2", "CNTP_CTL_EL02" },
> +        { K(3, 3, 14, 2, 2), K(3, 4, 14, 2, 2), K(3, 5, 14, 2, 2),
> +          "CNTP_CVAL_EL0", "CNTHP_CVAL_EL2", "CNTP_CVAL_EL02" },
> +        { K(3, 3, 14, 3, 0), K(3, 4, 14, 3, 0), K(3, 5, 14, 3, 0),
> +          "CNTV_TVAL_EL0", "CNTHV_TVAL_EL2", "CNTV_TVAL_EL02" },
> +        { K(3, 3, 14, 3, 1), K(3, 4, 14, 3, 1), K(3, 5, 14, 3, 1),
> +          "CNTV_CTL_EL0", "CNTHV_CTL_EL2", "CNTV_CTL_EL02" },
> +        { K(3, 3, 14, 3, 2), K(3, 4, 14, 3, 2), K(3, 5, 14, 3, 2),
> +          "CNTV_CVAL_EL0", "CNTHV_CVAL_EL2", "CNTV_CVAL_EL02" },
> +        /*
> +         * CNTHV_CVAL is a special case because there is no separate
> +         * AArch32 EL2 register to which CNTV_CVAL may be directed.
> +         * The effect can be achieved via CNTHV_CVAL_EL2.
> +         */
> +        { ENCODE_CP_REG(15, 1, 1, 0, 14, 3, 0), K(3, 4, 14, 3, 2), 0,
> +          "CNTV_CVAL", "CNTHV_CVAL_EL2", NULL },
> +
> +        /*
> +         * Note that redirection of ZCR is mentioned in the description
> +         * of ZCR_EL2, and aliasing in the description of ZCR_EL1, but
> +         * not in the summary table.
> +         */
> +        { K(3, 0,  1, 2, 0), K(3, 4,  1, 2, 0), K(3, 5, 1, 2, 0),
> +          "ZCR_EL1", "ZCR_EL2", "ZCR_EL12", isar_feature_aa64_sve },
> +
> +        /* TODO: ARMv8.2-SPE -- PMSCR_EL2 */
> +        /* TODO: ARMv8.4-Trace -- TRFCR_EL2 */
> +    };
> +#undef K
> +
> +    size_t i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(aliases); i++) {
> +        const struct E2HAlias *a =3D &aliases[i];
> +        ARMCPRegInfo *src_reg, *dst_reg;
> +
> +        if (a->feature && !a->feature(&cpu->isar)) {
> +            continue;
> +        }
> +
> +        src_reg =3D g_hash_table_lookup(cpu->cp_regs, &a->src_key);
> +        dst_reg =3D g_hash_table_lookup(cpu->cp_regs, &a->dst_key);
> +        g_assert(src_reg !=3D NULL);
> +        g_assert(dst_reg !=3D NULL);
> +
> +        /* Cross-compare names to detect typos in the keys.  */
> +        g_assert(strcmp(src_reg->name, a->src_name) =3D=3D 0);
> +        g_assert(strcmp(dst_reg->name, a->dst_name) =3D=3D 0);
> +
> +        /* None of the core system registers use opaque; we will.  */
> +        g_assert(src_reg->opaque =3D=3D NULL);

re above: assert bank_fieldoffsets not used?

> +
> +        /* Create alias before redirection so we dup the right data. */
> +        if (a->new_key) {
> +            ARMCPRegInfo *new_reg =3D g_memdup(src_reg, sizeof(ARMCPRegI=
nfo));
> +            uint32_t *new_key =3D g_memdup(&a->new_key, sizeof(uint32_t)=
);
> +            bool ok;
> +
> +            new_reg->name =3D a->new_name;
> +            new_reg->type |=3D ARM_CP_ALIAS;
> +            /* Remove PL1/PL0 access, leaving PL2/PL3 R/W in place.  */
> +            new_reg->access &=3D 0xf0;
> +
> +            ok =3D g_hash_table_insert(cpu->cp_regs, new_key, new_reg);
> +            g_assert(ok);
> +        }
> +
> +        src_reg->opaque =3D dst_reg;
> +        src_reg->orig_readfn =3D src_reg->readfn;
> +        src_reg->orig_writefn =3D src_reg->writefn;
> +        src_reg->readfn =3D el2_e2h_read;
> +        src_reg->writefn =3D el2_e2h_write;
> +    }
> +}
> +
>  static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInf=
o *ri,
>                                       bool isread)
>  {
> @@ -6945,6 +7108,14 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          : cpu_isar_feature(aa32_predinv, cpu)) {
>          define_arm_cp_regs(cpu, predinv_reginfo);
>      }
> +
> +    /*
> +     * Register redirections and aliases must be done last,
> +     * after the registers from the other extensions have been defined.
> +     */
> +    if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, c=
pu)) {
> +        define_arm_vh_e2h_redirects_aliases(cpu);
> +    }
>  }
>
>  void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)


--
Alex Benn=C3=A9e

