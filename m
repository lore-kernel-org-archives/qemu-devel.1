Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160FDC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 01:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B65207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 01:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+R+/FdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B65207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39511 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCZT2-0008TG-SN
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 21:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCZRK-0007ZW-0V
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 21:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCZRI-0005l0-4x
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 21:16:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCZRH-0005hw-Uo
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 21:16:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id b24so140217wmj.5
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 18:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=oi2CuPlc5OGi+jNU9pn/shw56DGES4ALBm1HN25zFl4=;
 b=g+R+/FdZ/u9SQMR151XnPII8UofTts4P8Cv5sCTQoWUacgge83N7CjqPWcJKGysMfK
 UfWdjyYxqeW4B/K3sBvspwsX2Di9aX+yKE9R5x96mE/5p6GwFD5XrnenijuVuiPihCHE
 YZaY94s2kB0Qp4AtnHgt7TQwk7dArRRgTHzr+ZTzdxdakV3JkB2fITPQrh1JQ5f8giWh
 uobl9qLQxlZNmLzhNoAuUXmvAwG0v39+cadaTdKGwhaKzzzK7EhaptUYmmjdsdrS9Q2P
 Zgiye7iujVdZIW3yP8GQpf0QJTLv6TK3CE0/PR2e3BOGEMh2hTTN2MnXmYX0iR0jO2R+
 Qd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=oi2CuPlc5OGi+jNU9pn/shw56DGES4ALBm1HN25zFl4=;
 b=ScCPMD4U6IidAkUCeDgWMbyrtisvPH9PwudteBbRyy4boC3d1VlF3uQ6saTLll1GdH
 eZQxRlSzqyZp0dGB2gZwFJde0GJFPH7Fb2jWQwExCSLAkc3j64wod7G0xUSOB5ohX4Jl
 +YSsLBf0xcNzABFl5nBPax97o2dcyG5tcKjkzzcZmpp0Jsnuv1LFYChGQh14Wfzcp62q
 5UU8h9q6Hg021hKMf/5xckuEIrQf0km4hbaShZYKJ/YLnwOUeiq2hwqwe/ETzWqWvhct
 oLqcVShkVADz8azoGbL26Eg166mkiyg8hvdgVXa8aaN8SvFWF5BeR7pswMyuo2+RxjiQ
 Cv5w==
X-Gm-Message-State: APjAAAV/KEqmXKlo2uGYzekV7/nP0UOEpoAB+BfXbo+TSA11naTAb4Xf
 w/rR1VcVFtxG6xIO+8PbSjRQLA==
X-Google-Smtp-Source: APXvYqwn9bD3aX5MH9BTKmWgD6gNwi147Svuq/0gjk7wD9/zhTOJNrX8rXG9HD7evoKFOFBVzg0j1w==
X-Received: by 2002:a1c:9c51:: with SMTP id f78mr297881wme.144.1569287775952; 
 Mon, 23 Sep 2019 18:16:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g138sm120648wmg.29.2019.09.23.18.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 18:16:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7A1831FF87;
 Tue, 24 Sep 2019 02:16:14 +0100 (BST)
References: <20190910095610.4546-1-beata.michalska@linaro.org>
 <20190910095610.4546-5-beata.michalska@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [PATCH 4/4] target/arm: Add support for DC CVAP &
 DC CVADP ins
In-reply-to: <20190910095610.4546-5-beata.michalska@linaro.org>
Date: Tue, 24 Sep 2019 02:16:14 +0100
Message-ID: <87blvabijl.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, Beata Michalska <beata.michalska@linaro.org>,
 quintela@redhat.com, richard.henderson@linaro.org, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Beata Michalska <beata.michalska@linaro.org> writes:

> ARMv8.2 introduced support for Data Cache Clean instructions
> to PoP (point-of-persistence) - DC CVAP and PoDP (point-of-deep-persisten=
ce)
> - DV CVADP. Both specify conceptual points in a memory system where all w=
rites
> that are to reach them are considered persistent.
> The support provided considers both to be actually the same so there is no
> distinction between the two. If none is available (there is no backing st=
ore
> for given memory) both will result in Data Cache Clean up to the point of
> coherency. Otherwise sync for the specified range shall be performed.
>
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> ---
>  linux-user/elfload.c       | 18 +++++++++++++++++-
>  target/arm/cpu.h           | 13 ++++++++++++-
>  target/arm/cpu64.c         |  1 +
>  target/arm/helper.c        | 24 ++++++++++++++++++++++++
>  target/arm/helper.h        |  1 +
>  target/arm/op_helper.c     | 36 ++++++++++++++++++++++++++++++++++++
>  target/arm/translate-a64.c |  5 +++++
>  7 files changed, 96 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 3365e192eb..1ec00308d5 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -609,7 +609,12 @@ enum {
>      ARM_HWCAP_A64_PACG          =3D 1UL << 31,
>  };
>
> +enum {
> +    ARM_HWCAP2_A64_DCPODP   =3D 1 << 0,
> +};
> +
>  #define ELF_HWCAP get_elf_hwcap()
> +#define ELF_HWCAP2 get_elf_hwcap2()
>
>  static uint32_t get_elf_hwcap(void)
>  {
> @@ -644,12 +649,23 @@ static uint32_t get_elf_hwcap(void)
>      GET_FEATURE_ID(aa64_jscvt, ARM_HWCAP_A64_JSCVT);
>      GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
>      GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
> +    GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
>
> -#undef GET_FEATURE_ID
>
>      return hwcaps;
>  }
>
> +static uint32_t get_elf_hwcap2(void)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(thread_cpu);
> +    uint32_t hwcaps =3D 0;
> +
> +    GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
> +    return hwcaps;
> +}
> +
> +#undef GET_FEATURE_ID
> +
>  #endif /* not TARGET_AARCH64 */
>  #endif /* TARGET_ARM */
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 297ad5e47a..1713d76590 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2229,7 +2229,8 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpr=
egid)
>  #define ARM_CP_NZCV              (ARM_CP_SPECIAL | 0x0300)
>  #define ARM_CP_CURRENTEL         (ARM_CP_SPECIAL | 0x0400)
>  #define ARM_CP_DC_ZVA            (ARM_CP_SPECIAL | 0x0500)
> -#define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
> +#define ARM_CP_DC_CVAP           (ARM_CP_SPECIAL | 0x0600)
> +#define ARM_LAST_SPECIAL         ARM_CP_DC_CVAP
>  #define ARM_CP_FPU               0x1000
>  #define ARM_CP_SVE               0x2000
>  #define ARM_CP_NO_GDB            0x4000
> @@ -3572,6 +3573,16 @@ static inline bool isar_feature_aa64_frint(const A=
RMISARegisters *id)
>      return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FRINTTS) !=3D 0;
>  }
>
> +static inline bool isar_feature_aa64_dcpop(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) !=3D 0;
> +}
> +
> +static inline bool isar_feature_aa64_dcpodp(const ARMISARegisters *id)
> +{
> +    return (FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) >> 1) !=3D 0;
> +}
> +
>  static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
>  {
>      /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index d7f5bf610a..20094f980d 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -331,6 +331,7 @@ static void aarch64_max_initfn(Object *obj)
>          cpu->isar.id_aa64isar0 =3D t;
>
>          t =3D cpu->isar.id_aa64isar1;
> +        t =3D FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);
>          t =3D FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);
>          t =3D FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
>          t =3D FIELD_DP64(t, ID_AA64ISAR1, APA, 1); /* PAuth, architected=
 only */
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 507026c915..99ae01b7e7 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3843,6 +3843,22 @@ static CPAccessResult aa64_cacheop_access(CPUARMSt=
ate *env,
>      return CP_ACCESS_OK;
>  }
>
> +static CPAccessResult aa64_cacheop_persist_access(CPUARMState *env,
> +                                                  const ARMCPRegInfo *ri,
> +                                                  bool isread)
> +{
> +    ARMCPU *cpu =3D env_archcpu(env);
> +    /*
> +     * Access is UNDEF if lacking implementation for either DC CVAP or D=
C CVADP
> +     * DC CVAP ->  CRm: 0xc
> +     * DC CVADP -> CRm: 0xd
> +     */
> +    return (ri->crm =3D=3D 0xc && !cpu_isar_feature(aa64_dcpop, cpu)) ||
> +           (ri->crm =3D=3D 0xd && !cpu_isar_feature(aa64_dcpodp, cpu))
> +           ? CP_ACCESS_TRAP_UNCATEGORIZED
> +           : aa64_cacheop_access(env, ri, isread);
> +}
> +
>  /* See: D4.7.2 TLB maintenance requirements and the TLB maintenance inst=
ructions
>   * Page D4-1736 (DDI0487A.b)
>   */
> @@ -4251,6 +4267,14 @@ static const ARMCPRegInfo v8_cp_reginfo[] =3D {
>        .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 10, .opc2 =3D 1,
>        .access =3D PL0_W, .type =3D ARM_CP_NOP,
>        .accessfn =3D aa64_cacheop_access },
> +    { .name =3D "DC_CVAP", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 12, .opc2 =3D 1,
> +      .access =3D PL0_W, .type =3D ARM_CP_DC_CVAP,
> +      .accessfn =3D aa64_cacheop_persist_access },
> +    { .name =3D "DC_CVADP", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 13, .opc2 =3D 1,
> +      .access =3D PL0_W, .type =3D ARM_CP_DC_CVAP,
> +      .accessfn =3D aa64_cacheop_persist_access },
>      { .name =3D "DC_CSW", .state =3D ARM_CP_STATE_AA64,
>        .opc0 =3D 1, .opc1 =3D 0, .crn =3D 7, .crm =3D 10, .opc2 =3D 2,
>        .access =3D PL1_W, .type =3D ARM_CP_NOP },
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 1fb2cb5a77..a850364944 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -561,6 +561,7 @@ DEF_HELPER_FLAGS_3(crypto_sm4ekey, TCG_CALL_NO_RWG, v=
oid, ptr, ptr, ptr)
>  DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
>  DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
>  DEF_HELPER_2(dc_zva, void, env, i64)
> +DEF_HELPER_2(dc_cvap, void, env, i64)
>
>  DEF_HELPER_FLAGS_2(neon_pmull_64_lo, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>  DEF_HELPER_FLAGS_2(neon_pmull_64_hi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 0fd4bd0238..75ebf6afa4 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -987,3 +987,39 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr=
_in)
>      memset(g2h(vaddr), 0, blocklen);
>  #endif
>  }
> +
> +void HELPER(dc_cvap)(CPUARMState *env, uint64_t vaddr_in)
> +{
> +#ifndef CONFIG_USER_ONLY

Are we essentially saying the operation is a NOP for user-mode
emulation? Is it just because we don't really expose HW to linux-user?

If so move the #ifndef outside the HELPER definition and...

> +    ARMCPU *cpu =3D env_archcpu(env);
> +    /* CTR_EL0 System register -> DminLine, bits [19:16] */
> +    uint64_t dline_size =3D 4 << ((cpu->ctr >> 16) & 0xF);
> +    uint64_t vaddr =3D vaddr_in & ~(dline_size - 1);
> +    void *haddr;
> +    int mem_idx =3D cpu_mmu_index(env, false);
> +
> +    /* This won't be crossing page boundaries */
> +    haddr =3D probe_read(env, vaddr, dline_size, mem_idx, GETPC());
> +    if (haddr) {
> +
> +        ram_addr_t offset;
> +        MemoryRegion *mr;
> +
> +        /*
> +         * RCU critical section + ref counting,
> +         * so that MR won't disappear behind the scene
> +         */
> +        rcu_read_lock();
> +        mr =3D memory_region_from_host(haddr, &offset);
> +        if (mr) {
> +            memory_region_ref(mr);
> +        }
> +        rcu_read_unlock();
> +
> +        if (mr) {
> +            memory_region_do_writeback(mr, offset, dline_size);
> +            memory_region_unref(mr);
> +        }
> +    }
> +#endif
> +}
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 2d6cd09634..21ea3631d6 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1746,6 +1746,11 @@ static void handle_sys(DisasContext *s, uint32_t i=
nsn, bool isread,
>          tcg_rt =3D cpu_reg(s, rt);
>          gen_helper_dc_zva(cpu_env, tcg_rt);
>          return;
> +    case ARM_CP_DC_CVAP:
> +        /* DC CVAP / DC CVADP */

.. #ifndef CONFIG_USER_ONLY this code so we don't add the overhead of a
helper call in linux-user mode.

> +        tcg_rt =3D cpu_reg(s, rt);
> +        gen_helper_dc_cvap(cpu_env, tcg_rt);
> +        return;
>      default:
>          break;
>      }


--
Alex Benn=C3=A9e

