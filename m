Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D56C3F2C0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D812469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2AOyA7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D812469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7R9R-0007tA-9O
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 16:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j7R8d-00077M-5O
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j7R8a-00026Q-P4
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:56:10 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46561)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j7R8a-00025V-Cs; Thu, 27 Feb 2020 16:56:08 -0500
Received: by mail-lj1-x244.google.com with SMTP id h18so820743ljl.13;
 Thu, 27 Feb 2020 13:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DyTLL3r5UNEzruoWdbkV+qYduVCTa59xT3YDALLn2+E=;
 b=K2AOyA7Q1MVMPudMD+HsaEWuvebeXxgUtcy24A4mY2LSMi+G0EClAblZrLU2hSSgjL
 Nl9RnRI1WzWubSofrc36svu1sxE7SCdcfHjPPzorTrPL0O/3FyPxihEIFl20SvDEKDVr
 hBjVOzePzeWC+2saF9F6lT2yg8RCukqIVF+/LOi95bFED2yLFhiM40IUZiqpTigVQL8J
 WWD7xwCox/xMOyWEqmFnnpE+Fy/0UzR6Ns6hQIAOgBngc9G/ZfmqRYwEsVyzZqKPc2jq
 DX2dO3xvMc3lR58gK/XvUWG6gAYoagUBNIZfBaYitYCEOFsHHjMPEg3BmDn3E0tHd9T8
 neMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DyTLL3r5UNEzruoWdbkV+qYduVCTa59xT3YDALLn2+E=;
 b=uoEJFJRQYjRv3Xqyetd9mQkXXF+L99p/2RGr4j96kQyS2JWVV5rwg+EcQeAwLzFThN
 eaq1I+sC1ze4Ci112wkIcDHF44ROC0ljo8fCm6FZnpBVN3UKJ0AXKUSwmZqILxXDfzpQ
 bdWiDiJhnvXFjRsErzF/Hy45mI7PMe5eByWFqU2yUvhfBg8PuXyUejWIjprsWYaa05F7
 MyqMPQsj8kECT15hpBzEFboRUlXhTdS5bGACaD2vgPWlVTGPg9jgvF0Da1PdbnNJv3/3
 RFqDccK+apN/ykcJJk+gosKrsbFBAWm1HYrZ2cOD2+or2MRoMUgrbws6BC86y43R2EY7
 sYKA==
X-Gm-Message-State: ANhLgQ2enAbzbgRArhMfQN0wygUH1xBF+zVnexu4nQB6PRWFG9UAyihN
 V8b/LYLfWC3vFypEXgS6PGKXuEWQuDchsGzHEtE=
X-Google-Smtp-Source: ADFU+vvgAhyxMosUzK8IpSQMvDV4OsUEDp0sduvkDOfeHVyCieOfIT6H0U0OJUD28ImihsZQVDBk8aztpvAGxcUMV5Y=
X-Received: by 2002:a2e:544:: with SMTP id 65mr769295ljf.76.1582840566426;
 Thu, 27 Feb 2020 13:56:06 -0800 (PST)
MIME-Version: 1.0
References: <20200221094531.61894-1-zhiwei_liu@c-sky.com>
 <20200221094531.61894-5-zhiwei_liu@c-sky.com>
 <CAKmqyKP81rcQ_meiqij-DLWvvqtH2N-zLZjkrpq+MM05ALhLhQ@mail.gmail.com>
 <4cecb8aa-dc32-2e8f-db0c-8d444f1c768e@c-sky.com>
In-Reply-To: <4cecb8aa-dc32-2e8f-db0c-8d444f1c768e@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 27 Feb 2020 13:48:24 -0800
Message-ID: <CAKmqyKM_q7AS0zW2yB_JXtt3erRaTd_nJjQd6wSAiaK6AzoZYQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] target/riscv: add vector configure instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 5:41 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
>
>
> On 2020/2/27 3:20, Alistair Francis wrote:
> >   On Fri, Feb 21, 2020 at 1:45 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wro=
te:
> >> vsetvl and vsetvli are two configure instructions for vl, vtype. TB fl=
ags
> >> should update after configure instructions. The (ill, lmul, sew ) of v=
type
> >> and the bit of (VSTART =3D=3D 0 && VL =3D=3D VLMAX) will be placed wit=
hin tb_flags.
> >>
> >> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> >> ---
> >>   MAINTAINERS                             |  1 +
> >>   target/riscv/Makefile.objs              |  2 +-
> >>   target/riscv/cpu.h                      | 61 +++++++++++++++++++---
> >>   target/riscv/helper.h                   |  2 +
> >>   target/riscv/insn32.decode              |  5 ++
> >>   target/riscv/insn_trans/trans_rvv.inc.c | 69 +++++++++++++++++++++++=
++
> >>   target/riscv/translate.c                | 17 +++++-
> >>   target/riscv/vector_helper.c            | 53 +++++++++++++++++++
> >>   8 files changed, 199 insertions(+), 11 deletions(-)
> >>   create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
> >>   create mode 100644 target/riscv/vector_helper.c
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 1740a4fddc..cd2e200db9 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -266,6 +266,7 @@ M: Palmer Dabbelt <palmer@dabbelt.com>
> >>   M: Alistair Francis <Alistair.Francis@wdc.com>
> >>   M: Sagar Karandikar <sagark@eecs.berkeley.edu>
> >>   M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> >> +M: LIU Zhiwei <zhiwei_liu@c-sky.com>
> > I don't think you should add yourself here. MAINTAINERS is more for
> > people doing active patch review.
> OK.
> > RISC-V QEMU can really do with more maintainers though, so if you do
> > want to be involved you could help review patches.
> Actually my main job is to maintain and develop QEMU code=EF=BC=8Cso I'd =
like to
> review target/riscv code,
> however vector upstream takes a lot time .

Great! I know reviewing code can be touch and time consuming but it
really helps the project. Just as upstreaming can be time consuming
but it's worth it.

Just try to help review what you can, every little bit helps a lot :)

Anyone can review code (you don't have to be a maintainer) so it's a
good place to start. Once you are activley reviewing patches we can
add you as a RISC-V maintainer.

> >>   L: qemu-riscv@nongnu.org
> >>   S: Supported
> >>   F: target/riscv/
> >> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> >> index ff651f69f6..ff38df6219 100644
> >> --- a/target/riscv/Makefile.objs
> >> +++ b/target/riscv/Makefile.objs
> >> @@ -1,4 +1,4 @@
> >> -obj-y +=3D translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helpe=
r.o gdbstub.o
> >> +obj-y +=3D translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helpe=
r.o vector_helper.o gdbstub.o
> >>   obj-$(CONFIG_SOFTMMU) +=3D pmp.o
> >>
> >>   ifeq ($(CONFIG_SOFTMMU),y)
> >> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> >> index 748bd557f9..f7003edb86 100644
> >> --- a/target/riscv/cpu.h
> >> +++ b/target/riscv/cpu.h
> >> @@ -21,6 +21,7 @@
> >>   #define RISCV_CPU_H
> >>
> >>   #include "hw/core/cpu.h"
> >> +#include "hw/registerfields.h"
> >>   #include "exec/cpu-defs.h"
> >>   #include "fpu/softfloat-types.h"
> >>
> >> @@ -98,6 +99,12 @@ typedef struct CPURISCVState CPURISCVState;
> >>
> >>   #define RV_VLEN_MAX 512
> >>
> >> +FIELD(VTYPE, LMUL, 0, 2)
> > Shouldn't this be VLMUL?
> OK. The same with VSEW and VEDIV.
> >
> >> +FIELD(VTYPE, SEW, 2, 3)
> > VSEW?
> >
> >> +FIELD(VTYPE, EDIV, 5, 2)
> > VEDIV?
> >
> >> +FIELD(VTYPE, RESERVED, 7, sizeof(target_ulong) * 8 - 9)
> >> +FIELD(VTYPE, VILL, sizeof(target_ulong) * 8 - 2, 1)
> >> +
> >>   struct CPURISCVState {
> >>       target_ulong gpr[32];
> >>       uint64_t fpr[32]; /* assume both F and D extensions */
> >> @@ -302,16 +309,59 @@ void riscv_cpu_set_fflags(CPURISCVState *env, ta=
rget_ulong);
> >>   #define TB_FLAGS_MMU_MASK   3
> >>   #define TB_FLAGS_MSTATUS_FS MSTATUS_FS
> >>
> >> +typedef CPURISCVState CPUArchState;
> >> +typedef RISCVCPU ArchCPU;
> >> +#include "exec/cpu-all.h"
> > Why do you need this? Shouldn't the TB_FLAGS fields work without this.
> Because env_archcpu in cpu_get_tb_cpu_state will use it.

Ah fair enough.

> >> +
> >> +FIELD(TB_FLAGS, VL_EQ_VLMAX, 2, 1)
> >> +FIELD(TB_FLAGS, LMUL, 3, 2)
> >> +FIELD(TB_FLAGS, SEW, 5, 3)
> >> +FIELD(TB_FLAGS, VILL, 8, 1)
> > These should probably be defined with the other TB_FLAGS (or if you
> > need them here you can move the others up here).
> I'd like to put other TB_FLAGS in other separate patch.
> >
> >> +
> >> +/*
> >> + * A simplification for VLMAX
> >> + * =3D (1 << LMUL) * VLEN / (8 * (1 << SEW))
> >> + * =3D (VLEN << LMUL) / (8 << SEW)
> >> + * =3D (VLEN << LMUL) >> (SEW + 3)
> >> + * =3D VLEN >> (SEW + 3 - LMUL)
> >> + */
> >> +static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vty=
pe)
> >> +{
> >> +    uint8_t sew, lmul;
> >> +
> >> +    sew =3D FIELD_EX64(vtype, VTYPE, SEW);
> >> +    lmul =3D FIELD_EX64(vtype, VTYPE, LMUL);
> >> +    return cpu->cfg.vlen >> (sew + 3 - lmul);
> > Shouldn't we assert this isn't over RV_VLEN_MAX?
> I don't think so.  VLEN is vector register length in bits. It is checked
> against RV_VLEN_MAX in cpu realize function. If it is over RV_VLEN_MAX,
> it will exits before translate any tb.

Ah ok. I see. This looks good then.

Alistair

>
> Zhiwei
>
> >
> > Alistair
> >
> >> +}
> >> +
> >>   static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_u=
long *pc,
> >> -                                        target_ulong *cs_base, uint32=
_t *flags)
> >> +                                        target_ulong *cs_base, uint32=
_t *pflags)
> >>   {
> >> +    uint32_t flags =3D 0;
> >> +
> >>       *pc =3D env->pc;
> >>       *cs_base =3D 0;
> >> +
> >> +    if (env->misa & RVV) {
> >> +        uint32_t vlmax =3D vext_get_vlmax(env_archcpu(env), env->vtyp=
e);
> >> +        bool vl_eq_vlmax =3D (env->vstart =3D=3D 0) && (vlmax =3D=3D =
env->vl);
> >> +        flags =3D FIELD_DP32(flags, TB_FLAGS, VILL,
> >> +                    FIELD_EX64(env->vtype, VTYPE, VILL));
> >> +        flags =3D FIELD_DP32(flags, TB_FLAGS, SEW,
> >> +                    FIELD_EX64(env->vtype, VTYPE, SEW));
> >> +        flags =3D FIELD_DP32(flags, TB_FLAGS, LMUL,
> >> +                    FIELD_EX64(env->vtype, VTYPE, LMUL));
> >> +        flags =3D FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlma=
x);
> >> +    } else {
> >> +        flags =3D FIELD_DP32(flags, TB_FLAGS, VILL, 1);
> >> +    }
> >> +
> >>   #ifdef CONFIG_USER_ONLY
> >> -    *flags =3D TB_FLAGS_MSTATUS_FS;
> >> +    flags |=3D TB_FLAGS_MSTATUS_FS;
> >>   #else
> >> -    *flags =3D cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
> >> +    flags |=3D cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
> >>   #endif
> >> +    *pflags =3D flags;
> >>   }
> >>
> >>   int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_val=
ue,
> >> @@ -352,9 +402,4 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operat=
ions *ops);
> >>
> >>   void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
> >>
> >> -typedef CPURISCVState CPUArchState;
> >> -typedef RISCVCPU ArchCPU;
> >> -
> >> -#include "exec/cpu-all.h"
> >> -
> >>   #endif /* RISCV_CPU_H */
> >> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> >> index debb22a480..3c28c7e407 100644
> >> --- a/target/riscv/helper.h
> >> +++ b/target/riscv/helper.h
> >> @@ -76,3 +76,5 @@ DEF_HELPER_2(mret, tl, env, tl)
> >>   DEF_HELPER_1(wfi, void, env)
> >>   DEF_HELPER_1(tlb_flush, void, env)
> >>   #endif
> >> +/* Vector functions */
> >> +DEF_HELPER_3(vsetvl, tl, env, tl, tl)
> >> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> >> index 77f794ed70..5dc009c3cd 100644
> >> --- a/target/riscv/insn32.decode
> >> +++ b/target/riscv/insn32.decode
> >> @@ -62,6 +62,7 @@
> >>   @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
> >>   @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
> >>   @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
> >> +@r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
> >>
> >>   @sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
> >>   @sfence_vm  ....... ..... .....   ... ..... ....... %rs1
> >> @@ -203,3 +204,7 @@ fcvt_w_d   1100001  00000 ..... ... ..... 1010011 =
@r2_rm
> >>   fcvt_wu_d  1100001  00001 ..... ... ..... 1010011 @r2_rm
> >>   fcvt_d_w   1101001  00000 ..... ... ..... 1010011 @r2_rm
> >>   fcvt_d_wu  1101001  00001 ..... ... ..... 1010011 @r2_rm
> >> +
> >> +# *** RV32V Extension ***
> >> +vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
> >> +vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> >> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/in=
sn_trans/trans_rvv.inc.c
> >> new file mode 100644
> >> index 0000000000..da82c72bbf
> >> --- /dev/null
> >> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> >> @@ -0,0 +1,69 @@
> >> +/*
> >> + * RISC-V translation routines for the RVV Standard Extension.
> >> + *
> >> + * Copyright (c) 2020 C-SKY Limited. All rights reserved.
> >> + *
> >> + * This program is free software; you can redistribute it and/or modi=
fy it
> >> + * under the terms and conditions of the GNU General Public License,
> >> + * version 2 or later, as published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope it will be useful, but WIT=
HOUT
> >> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY=
 or
> >> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lice=
nse for
> >> + * more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License =
along with
> >> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> >> + */
> >> +
> >> +static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl * a)
> >> +{
> >> +    TCGv s1, s2, dst;
> >> +    s2 =3D tcg_temp_new();
> >> +    dst =3D tcg_temp_new();
> >> +
> >> +    /* Using x0 as the rs1 register specifier, encodes an infinite AV=
L */
> >> +    if (a->rs1 =3D=3D 0) {
> >> +        /* As the mask is at least one bit, RV_VLEN_MAX is >=3D VLMAX=
 */
> >> +        s1 =3D tcg_const_tl(RV_VLEN_MAX);
> >> +    } else {
> >> +        s1 =3D tcg_temp_new();
> >> +        gen_get_gpr(s1, a->rs1);
> >> +    }
> >> +    gen_get_gpr(s2, a->rs2);
> >> +    gen_helper_vsetvl(dst, cpu_env, s1, s2);
> >> +    gen_set_gpr(a->rd, dst);
> >> +    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
> >> +    exit_tb(ctx);
> >> +    ctx->base.is_jmp =3D DISAS_NORETURN;
> >> +
> >> +    tcg_temp_free(s1);
> >> +    tcg_temp_free(s2);
> >> +    tcg_temp_free(dst);
> >> +    return true;
> >> +}
> >> +
> >> +static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli * a)
> >> +{
> >> +    TCGv s1, s2, dst;
> >> +    s2 =3D tcg_const_tl(a->zimm);
> >> +    dst =3D tcg_temp_new();
> >> +
> >> +    /* Using x0 as the rs1 register specifier, encodes an infinite AV=
L */
> >> +    if (a->rs1 =3D=3D 0) {
> >> +        /* As the mask is at least one bit, RV_VLEN_MAX is >=3D VLMAX=
 */
> >> +        s1 =3D tcg_const_tl(RV_VLEN_MAX);
> >> +    } else {
> >> +        s1 =3D tcg_temp_new();
> >> +        gen_get_gpr(s1, a->rs1);
> >> +    }
> >> +    gen_helper_vsetvl(dst, cpu_env, s1, s2);
> >> +    gen_set_gpr(a->rd, dst);
> >> +    gen_goto_tb(ctx, 0, ctx->pc_succ_insn);
> >> +    ctx->base.is_jmp =3D DISAS_NORETURN;
> >> +
> >> +    tcg_temp_free(s1);
> >> +    tcg_temp_free(s2);
> >> +    tcg_temp_free(dst);
> >> +    return true;
> >> +}
> >> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> >> index 14dc71156b..cc356aabd8 100644
> >> --- a/target/riscv/translate.c
> >> +++ b/target/riscv/translate.c
> >> @@ -55,6 +55,12 @@ typedef struct DisasContext {
> >>          to reset this known value.  */
> >>       int frm;
> >>       bool ext_ifencei;
> >> +    /* vector extension */
> >> +    bool vill;
> >> +    uint8_t lmul;
> >> +    uint8_t sew;
> >> +    uint16_t vlen;
> >> +    bool vl_eq_vlmax;
> >>   } DisasContext;
> >>
> >>   #ifdef TARGET_RISCV64
> >> @@ -704,6 +710,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
> >>   #include "insn_trans/trans_rva.inc.c"
> >>   #include "insn_trans/trans_rvf.inc.c"
> >>   #include "insn_trans/trans_rvd.inc.c"
> >> +#include "insn_trans/trans_rvv.inc.c"
> >>   #include "insn_trans/trans_privileged.inc.c"
> >>
> >>   /* Include the auto-generated decoder for 16 bit insn */
> >> @@ -735,14 +742,20 @@ static void riscv_tr_init_disas_context(DisasCon=
textBase *dcbase, CPUState *cs)
> >>       DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
> >>       CPURISCVState *env =3D cs->env_ptr;
> >>       RISCVCPU *cpu =3D RISCV_CPU(cs);
> >> +    uint32_t tb_flags =3D ctx->base.tb->flags;
> >>
> >>       ctx->pc_succ_insn =3D ctx->base.pc_first;
> >> -    ctx->mem_idx =3D ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
> >> -    ctx->mstatus_fs =3D ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
> >> +    ctx->mem_idx =3D tb_flags & TB_FLAGS_MMU_MASK;
> >> +    ctx->mstatus_fs =3D tb_flags & TB_FLAGS_MSTATUS_FS;
> >>       ctx->priv_ver =3D env->priv_ver;
> >>       ctx->misa =3D env->misa;
> >>       ctx->frm =3D -1;  /* unknown rounding mode */
> >>       ctx->ext_ifencei =3D cpu->cfg.ext_ifencei;
> >> +    ctx->vlen =3D cpu->cfg.vlen;
> >> +    ctx->vill =3D FIELD_EX32(tb_flags, TB_FLAGS, VILL);
> >> +    ctx->sew =3D FIELD_EX32(tb_flags, TB_FLAGS, SEW);
> >> +    ctx->lmul =3D FIELD_EX32(tb_flags, TB_FLAGS, LMUL);
> >> +    ctx->vl_eq_vlmax =3D FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
> >>   }
> >>
> >>   static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
> >> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper=
.c
> >> new file mode 100644
> >> index 0000000000..07db704656
> >> --- /dev/null
> >> +++ b/target/riscv/vector_helper.c
> >> @@ -0,0 +1,53 @@
> >> +/*
> >> + * RISC-V Vector Extension Helpers for QEMU.
> >> + *
> >> + * Copyright (c) 2020 C-SKY Limited. All rights reserved.
> >> + *
> >> + * This program is free software; you can redistribute it and/or modi=
fy it
> >> + * under the terms and conditions of the GNU General Public License,
> >> + * version 2 or later, as published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope it will be useful, but WIT=
HOUT
> >> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY=
 or
> >> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lice=
nse for
> >> + * more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License =
along with
> >> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> >> + */
> >> +
> >> +#include "qemu/osdep.h"
> >> +#include "cpu.h"
> >> +#include "exec/exec-all.h"
> >> +#include "exec/helper-proto.h"
> >> +#include <math.h>
> >> +
> >> +target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
> >> +    target_ulong s2)
> >> +{
> >> +    int vlmax, vl;
> >> +    RISCVCPU *cpu =3D env_archcpu(env);
> >> +    uint16_t sew =3D 1 << FIELD_EX64(s2, VTYPE, SEW);
> >> +    uint8_t ediv =3D FIELD_EX64(s2, VTYPE, EDIV);
> >> +    bool vill =3D FIELD_EX64(s2, VTYPE, VILL);
> >> +    target_ulong reserved =3D FIELD_EX64(s2, VTYPE, RESERVED);
> >> +
> >> +    if ((sew > cpu->cfg.elen) || vill || (ediv !=3D 0) || (reserved !=
=3D 0)) {
> >> +        /* only set vill bit. */
> >> +        env->vtype =3D FIELD_DP64(0, VTYPE, VILL, 1);
> >> +        env->vl =3D 0;
> >> +        env->vstart =3D 0;
> >> +        return 0;
> >> +    }
> >> +
> >> +    vlmax =3D vext_get_vlmax(cpu, s2);
> >> +    if (s1 <=3D vlmax) {
> >> +        vl =3D s1;
> >> +    } else {
> >> +        vl =3D vlmax;
> >> +    }
> >> +    env->vl =3D vl;
> >> +    env->vtype =3D s2;
> >> +    env->vstart =3D 0;
> >> +    return vl;
> >> +}
> >> --
> >> 2.23.0
> >>
>

