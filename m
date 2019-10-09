Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E17C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12811206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFxSbspJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12811206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFtS-0002ih-Pv
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iIARf-0001QH-Tn
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iIARd-0005Mv-Qv
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:47:55 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:46149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iIARd-0005Mg-Le
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:47:53 -0400
Received: by mail-io1-xd42.google.com with SMTP id c6so4141559ioo.13
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 04:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=U98Wd/tJ2fYitptqldGm5NQNmxvZ7yFkPvSDpC1AsU4=;
 b=YFxSbspJoAEC+pfYVCuu05igzg/Up6DnZ1gw+Zwdj860lEGrmcyeoCvOjgG9gmCvFO
 BcPY28TTGCm2sOJCbbH3npfy71S+JSdWTv0rlYsCrxhhJC8YQKfQzjEtuSQJg1vSugbU
 HEckHIyyfnitTb1LTEPqfJ/d8vndBAkZXHpPaGV+gGrFsqUNK+rSqomCuhn7LBxHaSKr
 SmOa/TnOfNNg6OkCWncdwbQn9KvCPiPqqgfzMXQ1V+YRU8T5yD7JOuc4IEh/cZWYruIl
 DwIHVdJ2vYj7EPiRTGrAysJTQNEuVKM5ZA5vavN4V9NFxglNI0ZwhlsUP2PKPlpYVTBq
 ea6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=U98Wd/tJ2fYitptqldGm5NQNmxvZ7yFkPvSDpC1AsU4=;
 b=lXYL0IXA7DUQeqOM/wdGUJXh1dztom3eJy3qLdMmcsHAKqvThtp1uroWuMTy2OLzQP
 nWx9FqkiW8FNd8t77BhkW5w7jz9fEUteqblCiyVvbcgVZB6tfvTLSqVB1SQiz9fMpXRV
 PDbt/5TB3CWrCha6dWDlj2Eh76lPpQ1iU9OAqOAxjRnvrqC/tkAD10WxYn+oxi1oKSdX
 2+VDU7pXWaXGKxg2QM1ymH3aR5LWOywtLazPPmpxW20W1z6svQOQje6USZxzPhcJ8TTj
 2dmN6tfdqjHS9x4jI0hSjUTbVa94Rqp2CjkNM7ujJa2SoDUzaHpPmlpvX95SSOlb5PEm
 du/g==
X-Gm-Message-State: APjAAAXvvaDYLkUs/dW85tMIQr1e3nYXq/0QhY9+xre+UtmnTxDVsK/t
 M1FZW3/yNzGo2COMFERtHKNIQiiNM//XSREq+bdS/A==
X-Google-Smtp-Source: APXvYqxfqStlxhaK+9WcX34SdYiwWAog8br9KgjqNE7LgZqV7xwaJVysQJ5cdkuY/yK3mfrmXID3bTbR8gpQmGc9JLk=
X-Received: by 2002:a92:7702:: with SMTP id s2mr2709489ilc.248.1570621671967; 
 Wed, 09 Oct 2019 04:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190910095610.4546-1-beata.michalska@linaro.org>
 <20190910095610.4546-5-beata.michalska@linaro.org> <87ftkmbmci.fsf@linaro.org>
In-Reply-To: <87ftkmbmci.fsf@linaro.org>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Wed, 9 Oct 2019 12:47:41 +0100
Message-ID: <CADSWDzuPnWSWFhEe38=V-W=otN5mhOBwkpmaW=TE1cGaxXQ5vQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] target/arm: Add support for DC CVAP & DC
 CVADP ins
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Peter Maydell <peter.maydell@linaro.org>, quintela@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 shameerali.kolothum.thodi@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 at 00:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Beata Michalska <beata.michalska@linaro.org> writes:
>
> > ARMv8.2 introduced support for Data Cache Clean instructions
> > to PoP (point-of-persistence) - DC CVAP and PoDP (point-of-deep-persist=
ence)
> > - DV CVADP. Both specify conceptual points in a memory system where all=
 writes
> > that are to reach them are considered persistent.
> > The support provided considers both to be actually the same so there is=
 no
> > distinction between the two. If none is available (there is no backing =
store
> > for given memory) both will result in Data Cache Clean up to the point =
of
> > coherency. Otherwise sync for the specified range shall be performed.
> >
> > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> > ---
> >  linux-user/elfload.c       | 18 +++++++++++++++++-
>
> There are conflicts from the recent elfload.c tweaks to fix on your next =
rebase.

Will address it in the next version.

> >  target/arm/cpu.h           | 13 ++++++++++++-
> >  target/arm/cpu64.c         |  1 +
> >  target/arm/helper.c        | 24 ++++++++++++++++++++++++
> >  target/arm/helper.h        |  1 +
> >  target/arm/op_helper.c     | 36 ++++++++++++++++++++++++++++++++++++
> >  target/arm/translate-a64.c |  5 +++++
> >  7 files changed, 96 insertions(+), 2 deletions(-)
> >
> > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> > index 3365e192eb..1ec00308d5 100644
> > --- a/linux-user/elfload.c
> > +++ b/linux-user/elfload.c
> > @@ -609,7 +609,12 @@ enum {
> >      ARM_HWCAP_A64_PACG          =3D 1UL << 31,
> >  };
> >
> > +enum {
> > +    ARM_HWCAP2_A64_DCPODP   =3D 1 << 0,
> > +};
> > +
> >  #define ELF_HWCAP get_elf_hwcap()
> > +#define ELF_HWCAP2 get_elf_hwcap2()
> >
> >  static uint32_t get_elf_hwcap(void)
> >  {
> > @@ -644,12 +649,23 @@ static uint32_t get_elf_hwcap(void)
> >      GET_FEATURE_ID(aa64_jscvt, ARM_HWCAP_A64_JSCVT);
> >      GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
> >      GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
> > +    GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
> >
> > -#undef GET_FEATURE_ID
> >
> >      return hwcaps;
> >  }
> >
> > +static uint32_t get_elf_hwcap2(void)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(thread_cpu);
> > +    uint32_t hwcaps =3D 0;
> > +
> > +    GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
> > +    return hwcaps;
> > +}
> > +
> > +#undef GET_FEATURE_ID
> > +
> >  #endif /* not TARGET_AARCH64 */
> >  #endif /* TARGET_ARM */
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 297ad5e47a..1713d76590 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -2229,7 +2229,8 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t c=
pregid)
> >  #define ARM_CP_NZCV              (ARM_CP_SPECIAL | 0x0300)
> >  #define ARM_CP_CURRENTEL         (ARM_CP_SPECIAL | 0x0400)
> >  #define ARM_CP_DC_ZVA            (ARM_CP_SPECIAL | 0x0500)
> > -#define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
> > +#define ARM_CP_DC_CVAP           (ARM_CP_SPECIAL | 0x0600)
> > +#define ARM_LAST_SPECIAL         ARM_CP_DC_CVAP
> >  #define ARM_CP_FPU               0x1000
> >  #define ARM_CP_SVE               0x2000
> >  #define ARM_CP_NO_GDB            0x4000
> > @@ -3572,6 +3573,16 @@ static inline bool isar_feature_aa64_frint(const=
 ARMISARegisters *id)
> >      return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FRINTTS) !=3D 0;
> >  }
> >
> > +static inline bool isar_feature_aa64_dcpop(const ARMISARegisters *id)
> > +{
> > +    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) !=3D 0;
> > +}
> > +
> > +static inline bool isar_feature_aa64_dcpodp(const ARMISARegisters *id)
> > +{
> > +    return (FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) >> 1) !=3D=
 0;
> > +}
> > +
> >  static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
> >  {
> >      /* We always set the AdvSIMD and FP fields identically wrt FP16.  =
*/
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index d7f5bf610a..20094f980d 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -331,6 +331,7 @@ static void aarch64_max_initfn(Object *obj)
> >          cpu->isar.id_aa64isar0 =3D t;
> >
> >          t =3D cpu->isar.id_aa64isar1;
> > +        t =3D FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);
> >          t =3D FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);
> >          t =3D FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
> >          t =3D FIELD_DP64(t, ID_AA64ISAR1, APA, 1); /* PAuth, architect=
ed only */
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 507026c915..99ae01b7e7 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -3843,6 +3843,22 @@ static CPAccessResult aa64_cacheop_access(CPUARM=
State *env,
> >      return CP_ACCESS_OK;
> >  }
> >
> > +static CPAccessResult aa64_cacheop_persist_access(CPUARMState *env,
> > +                                                  const ARMCPRegInfo *=
ri,
> > +                                                  bool isread)
> > +{
> > +    ARMCPU *cpu =3D env_archcpu(env);
> > +    /*
> > +     * Access is UNDEF if lacking implementation for either DC CVAP or=
 DC CVADP
> > +     * DC CVAP ->  CRm: 0xc
> > +     * DC CVADP -> CRm: 0xd
> > +     */
> > +    return (ri->crm =3D=3D 0xc && !cpu_isar_feature(aa64_dcpop, cpu)) =
||
> > +           (ri->crm =3D=3D 0xd && !cpu_isar_feature(aa64_dcpodp, cpu))
> > +           ? CP_ACCESS_TRAP_UNCATEGORIZED
> > +           : aa64_cacheop_access(env, ri, isread);
> > +}
> > +
> >  /* See: D4.7.2 TLB maintenance requirements and the TLB maintenance in=
structions
> >   * Page D4-1736 (DDI0487A.b)
> >   */
> > @@ -4251,6 +4267,14 @@ static const ARMCPRegInfo v8_cp_reginfo[] =3D {
> >        .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 10, .opc2 =3D 1,
> >        .access =3D PL0_W, .type =3D ARM_CP_NOP,
> >        .accessfn =3D aa64_cacheop_access },
> > +    { .name =3D "DC_CVAP", .state =3D ARM_CP_STATE_AA64,
> > +      .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 12, .opc2 =3D 1,
> > +      .access =3D PL0_W, .type =3D ARM_CP_DC_CVAP,
> > +      .accessfn =3D aa64_cacheop_persist_access },
> > +    { .name =3D "DC_CVADP", .state =3D ARM_CP_STATE_AA64,
> > +      .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 13, .opc2 =3D 1,
> > +      .access =3D PL0_W, .type =3D ARM_CP_DC_CVAP,
> > +      .accessfn =3D aa64_cacheop_persist_access },
> >      { .name =3D "DC_CSW", .state =3D ARM_CP_STATE_AA64,
> >        .opc0 =3D 1, .opc1 =3D 0, .crn =3D 7, .crm =3D 10, .opc2 =3D 2,
> >        .access =3D PL1_W, .type =3D ARM_CP_NOP },
> > diff --git a/target/arm/helper.h b/target/arm/helper.h
> > index 1fb2cb5a77..a850364944 100644
> > --- a/target/arm/helper.h
> > +++ b/target/arm/helper.h
> > @@ -561,6 +561,7 @@ DEF_HELPER_FLAGS_3(crypto_sm4ekey, TCG_CALL_NO_RWG,=
 void, ptr, ptr, ptr)
> >  DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
> >  DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
> >  DEF_HELPER_2(dc_zva, void, env, i64)
> > +DEF_HELPER_2(dc_cvap, void, env, i64)
> >
> >  DEF_HELPER_FLAGS_2(neon_pmull_64_lo, TCG_CALL_NO_RWG_SE, i64, i64, i64=
)
> >  DEF_HELPER_FLAGS_2(neon_pmull_64_hi, TCG_CALL_NO_RWG_SE, i64, i64, i64=
)
> > diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> > index 0fd4bd0238..75ebf6afa4 100644
> > --- a/target/arm/op_helper.c
> > +++ b/target/arm/op_helper.c
> > @@ -987,3 +987,39 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vad=
dr_in)
> >      memset(g2h(vaddr), 0, blocklen);
> >  #endif
> >  }
> > +
> > +void HELPER(dc_cvap)(CPUARMState *env, uint64_t vaddr_in)
> > +{
> > +#ifndef CONFIG_USER_ONLY
> > +    ARMCPU *cpu =3D env_archcpu(env);
> > +    /* CTR_EL0 System register -> DminLine, bits [19:16] */
> > +    uint64_t dline_size =3D 4 << ((cpu->ctr >> 16) & 0xF);
> > +    uint64_t vaddr =3D vaddr_in & ~(dline_size - 1);
> > +    void *haddr;
> > +    int mem_idx =3D cpu_mmu_index(env, false);
> > +
> > +    /* This won't be crossing page boundaries */
> > +    haddr =3D probe_read(env, vaddr, dline_size, mem_idx, GETPC());
> > +    if (haddr) {
> > +
> > +        ram_addr_t offset;
> > +        MemoryRegion *mr;
> > +
> > +        /*
> > +         * RCU critical section + ref counting,
> > +         * so that MR won't disappear behind the scene
> > +         */
> > +        rcu_read_lock();
> > +        mr =3D memory_region_from_host(haddr, &offset);
> > +        if (mr) {
> > +            memory_region_ref(mr);
> > +        }
> > +        rcu_read_unlock();
> > +
> > +        if (mr) {
> > +            memory_region_do_writeback(mr, offset, dline_size);
> > +            memory_region_unref(mr);
> > +        }
> > +    }
> > +#endif
> > +}
> > diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> > index 2d6cd09634..21ea3631d6 100644
> > --- a/target/arm/translate-a64.c
> > +++ b/target/arm/translate-a64.c
> > @@ -1746,6 +1746,11 @@ static void handle_sys(DisasContext *s, uint32_t=
 insn, bool isread,
> >          tcg_rt =3D cpu_reg(s, rt);
> >          gen_helper_dc_zva(cpu_env, tcg_rt);
> >          return;
> > +    case ARM_CP_DC_CVAP:
> > +        /* DC CVAP / DC CVADP */
> > +        tcg_rt =3D cpu_reg(s, rt);
> > +        gen_helper_dc_cvap(cpu_env, tcg_rt);
> > +        return;
> >      default:
> >          break;
> >      }
>
>
> --
> Alex Benn=C3=A9e

BR
Beata

