Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C239CC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7680520651
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7elZ6J+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7680520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40757 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1V6-0001bX-LC
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49548)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hr1Uu-0001Br-E2
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hr1Us-0002q0-55
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:47:04 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hr1Ur-0002o9-Tx
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:47:02 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so54797633wrs.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tEZfUUHBtqryJx9RTj+IvkNexMlUWxLWzOdZlOiWvHU=;
 b=B7elZ6J+uW387ToCI7EiJ5fBzBKojRRBGJ3MNmWqdmu574oVts2ZTrQBsVN6g8u7Es
 O/04bWlAC8dUGkHvlaeDRjJSp5/nsG2mBLsQR7XjwSqUAK5Er8M5FhKBGXkpKoUnRk+n
 CCN/Wur7AxTonW+YTsFipf6AIIAul9lbNdMhGitF9eozxEpa52UtjuST/6zMxceJ4zK7
 HTy4LVq0LAFdBn+XK4QoRa8xaKw6SlDu/b1KpcSjANxElCI6eXSW8N8cTRPLsuKD9Nx1
 vEFILiAMsKwuPBCaHW/lhIB8PqXoThgBvP13W0elDtSdgdSMwMqsKv/w7E9+jwfLK7NF
 qZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tEZfUUHBtqryJx9RTj+IvkNexMlUWxLWzOdZlOiWvHU=;
 b=Arh+r2aqESWpUeoQUNz4KFJi7LQz8dOEPH7THiqyBGyaBbXvbfbm955RsaZbg4UtQH
 Z99MwwtkVri+HJVrlrPtx248K3tddaCp/12Dhl0FxJimtKOTBjA+RVDiWwLXtTboZnJK
 xqAk+FWnwK6PYPNWcR8h51XOU80Y7GS/unKlDEa2M1BD9J7YhB9Qo69P0wLSdUxRu6uV
 uiSFgwrn2DZ5Xq/fGeBNGcTlrxdI4ab97W8MPWeWJei2pjCY/ShKdvDOTtShdcuL0h6H
 TXLFOoRdGbeW+G6XA3RXc72TAeKAYrjy2V6imx5YfV3WxMCS9eCI3tvAqpDAfmkdh4BD
 7XnA==
X-Gm-Message-State: APjAAAUXhJ8CURB4kHbpnrYghpvueBVFTu2x2j5uVfrNMlnnptLPJHzg
 Z5Ndfr4Cyb5OLD4yLI7GRb/mEw==
X-Google-Smtp-Source: APXvYqyyRYOUJq4Q/GVWgelsRAFJzXT+rhQDoIRk9pmI6ondUPBn6tNuX2a3ULWB6N98dAbjGNgZaw==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr15104861wrs.289.1564152420039; 
 Fri, 26 Jul 2019 07:47:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id n1sm38710245wrx.39.2019.07.26.07.46.59
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 07:46:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 170731FF87;
 Fri, 26 Jul 2019 15:46:59 +0100 (BST)
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
 <20190720010235.32444-4-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190720010235.32444-4-vandersonmr2@gmail.com>
Date: Fri, 26 Jul 2019 15:46:59 +0100
Message-ID: <87r26chmzg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v4 3/7] accel: collecting JIT statistics
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> If a TB has a TBS (TBStatistics) with the TB_JIT_STATS
> enabled then we collect statistics of its translation
> processes and code translation. To collect the number
> of host instructions we used a modified version of the
> disas function to pass through the whole code without
> printing anything (fake_fprintf) but counting the number
> of instructions.
>
> Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
> ---
>  accel/tcg/translate-all.c |  18 +++++++
>  accel/tcg/translator.c    |   5 ++
>  disas.c                   | 108 ++++++++++++++++++++++++++++++++++++++
>  include/disas/disas.h     |   1 +
>  include/exec/tb-stats.h   |  14 +++++
>  include/qemu/log.h        |   1 +
>  tcg/tcg.c                 |  23 ++++++++
>  tcg/tcg.h                 |   2 +
>  8 files changed, 172 insertions(+)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 7497dae508..3a47ac6f2c 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1793,6 +1793,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>              }
>          }
>
> +        if (flag & TB_JIT_STATS) {
> +            tb->tb_stats->stats_enabled |=3D TB_JIT_STATS;
> +            atomic_inc(&tb->tb_stats->translations.total);
> +        }
>      } else {
>          tb->tb_stats =3D NULL;
>      }
> @@ -1870,6 +1874,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      atomic_set(&prof->search_out_len, prof->search_out_len + search_size=
);
>  #endif
>
> +    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
> +        size_t code_size =3D gen_code_size;
> +        if (tcg_ctx->data_gen_ptr) {
> +            code_size =3D tcg_ctx->data_gen_ptr - tb->tc.ptr;
> +        }
> +
> +        atomic_add(&tb->tb_stats->code.num_host_inst,
> +                    get_num_insts(tb->tc.ptr, code_size));

This is what is causing my crashes. I think invoking the disassembler stuff=
 is
too clunky here. Maybe we should just change the counter to
num_host_insn_byte, the ratio will still be interesting but it saves the
complication of re-counting.

Ideally the we'd like the core tcg code to tell us how many host
instructions it emitted for each tcg_op but I suspect that involves
heavier surgery.

> +    }
> +
> +
>  #ifdef DEBUG_DISAS
>      if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
>          qemu_log_in_addr_range(tb->pc)) {
> @@ -1927,6 +1942,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      phys_page2 =3D -1;
>      if ((pc & TARGET_PAGE_MASK) !=3D virt_page2) {
>          phys_page2 =3D get_page_addr_code(env, virt_page2);
> +        if (tb_stats_enabled(tb, TB_JIT_STATS)) {
> +            atomic_inc(&tb->tb_stats->translations.spanning);
> +        }
>      }
>      /*
>       * No explicit memory barrier is required -- tb_link_page() makes the
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 396a11e828..03c00bdb1b 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -117,6 +117,11 @@ void translator_loop(const TranslatorOps *ops, Disas=
ContextBase *db,
>      db->tb->size =3D db->pc_next - db->pc_first;
>      db->tb->icount =3D db->num_insns;
>
> +    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
> +        atomic_add(&db->tb->tb_stats->code.num_guest_inst, db->num_insns=
);
> +    }
> +
> +
>  #ifdef DEBUG_DISAS
>      if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
>          && qemu_log_in_addr_range(db->pc_first)) {
> diff --git a/disas.c b/disas.c
> index 3e2bfa572b..5dec754992 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -475,6 +475,114 @@ void target_disas(FILE *out, CPUState *cpu, target_=
ulong code,
>      }
>  }
>
> +static int fprintf_fake(struct _IO_FILE *a, const char *b, ...)
> +{
> +    return 1;
> +}
> +
> +/*
> + * This is a work around to get the number of host instructions with
> + * a small effort. It reuses the disas function with a fake printf to
> + * print nothing but count the number of instructions.
> + *
> + */
> +unsigned get_num_insts(void *code, unsigned long size)
> +{
> +    uintptr_t pc;
> +    int count;
> +    CPUDebug s;
> +    int (*print_insn)(bfd_vma pc, disassemble_info *info) =3D NULL;
> +
> +    INIT_DISASSEMBLE_INFO(s.info, NULL, fprintf_fake);
> +    s.info.print_address_func =3D generic_print_host_address;
> +
> +    s.info.buffer =3D code;
> +    s.info.buffer_vma =3D (uintptr_t)code;
> +    s.info.buffer_length =3D size;
> +    s.info.cap_arch =3D -1;
> +    s.info.cap_mode =3D 0;
> +    s.info.cap_insn_unit =3D 4;
> +    s.info.cap_insn_split =3D 4;
> +
> +#ifdef HOST_WORDS_BIGENDIAN
> +    s.info.endian =3D BFD_ENDIAN_BIG;
> +#else
> +    s.info.endian =3D BFD_ENDIAN_LITTLE;
> +#endif
> +#if defined(CONFIG_TCG_INTERPRETER)
> +    print_insn =3D print_insn_tci;
> +#elif defined(__i386__)
> +    s.info.mach =3D bfd_mach_i386_i386;
> +    print_insn =3D print_insn_i386;
> +    s.info.cap_arch =3D CS_ARCH_X86;
> +    s.info.cap_mode =3D CS_MODE_32;
> +    s.info.cap_insn_unit =3D 1;
> +    s.info.cap_insn_split =3D 8;
> +#elif defined(__x86_64__)
> +    s.info.mach =3D bfd_mach_x86_64;
> +    print_insn =3D print_insn_i386;
> +    s.info.cap_arch =3D CS_ARCH_X86;
> +    s.info.cap_mode =3D CS_MODE_64;
> +    s.info.cap_insn_unit =3D 1;
> +    s.info.cap_insn_split =3D 8;
> +#elif defined(_ARCH_PPC)
> +    s.info.disassembler_options =3D (char *)"any";
> +    print_insn =3D print_insn_ppc;
> +    s.info.cap_arch =3D CS_ARCH_PPC;
> +# ifdef _ARCH_PPC64
> +    s.info.cap_mode =3D CS_MODE_64;
> +# endif
> +#elif defined(__riscv) && defined(CONFIG_RISCV_DIS)
> +#if defined(_ILP32) || (__riscv_xlen =3D=3D 32)
> +    print_insn =3D print_insn_riscv32;
> +#elif defined(_LP64)
> +    print_insn =3D print_insn_riscv64;
> +#else
> +#error unsupported RISC-V ABI
> +#endif
> +#elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
> +    print_insn =3D print_insn_arm_a64;
> +    s.info.cap_arch =3D CS_ARCH_ARM64;
> +#elif defined(__alpha__)
> +    print_insn =3D print_insn_alpha;
> +#elif defined(__sparc__)
> +    print_insn =3D print_insn_sparc;
> +    s.info.mach =3D bfd_mach_sparc_v9b;
> +#elif defined(__arm__)
> +    print_insn =3D print_insn_arm;
> +    s.info.cap_arch =3D CS_ARCH_ARM;
> +    /* TCG only generates code for arm mode.  */
> +#elif defined(__MIPSEB__)
> +    print_insn =3D print_insn_big_mips;
> +#elif defined(__MIPSEL__)
> +    print_insn =3D print_insn_little_mips;
> +#elif defined(__m68k__)
> +    print_insn =3D print_insn_m68k;
> +#elif defined(__s390__)
> +    print_insn =3D print_insn_s390;
> +#elif defined(__hppa__)
> +    print_insn =3D print_insn_hppa;
> +#endif
> +
> +    if (print_insn =3D=3D NULL) {
> +        print_insn =3D print_insn_od_host;
> +    }
> +
> +    s.info.fprintf_func =3D fprintf_fake;
> +    unsigned num_insts =3D 0;
> +    for (pc =3D (uintptr_t)code; size > 0; pc +=3D count, size -=3D coun=
t) {
> +        num_insts++;
> +        count =3D print_insn(pc, &s.info);
> +        if (count < 0) {
> +            break;
> +        }
> +    }
> +    return num_insts;
> +}
> +
> +
> +
> +
>  /* Disassemble this for me please... (debugging). */
>  void disas(FILE *out, void *code, unsigned long size)
>  {
> diff --git a/include/disas/disas.h b/include/disas/disas.h
> index 15da511f49..9797ae7cfa 100644
> --- a/include/disas/disas.h
> +++ b/include/disas/disas.h
> @@ -7,6 +7,7 @@
>
>  /* Disassemble this for me please... (debugging). */
>  void disas(FILE *out, void *code, unsigned long size);
> +unsigned get_num_insts(void *code, unsigned long size);
>  void target_disas(FILE *out, CPUState *cpu, target_ulong code,
>                    target_ulong size);
>
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index ee1e8de0d3..6584b78c4a 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -33,6 +33,20 @@ struct TBStatistics {
>          unsigned long total;
>          unsigned long atomic;
>      } executions;
> +
> +    struct {
> +        unsigned num_guest_inst;
> +        unsigned num_host_inst;
> +        unsigned num_tcg_ops;
> +        unsigned num_tcg_ops_opt;
> +        unsigned spills;
> +    } code;
> +
> +    struct {
> +        unsigned long total;
> +        unsigned long uncached;
> +        unsigned long spanning;
> +    } translations;
>  };
>
>  bool tb_stats_cmp(const void *ap, const void *bp);
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index b213411836..8cdfc268ca 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -131,6 +131,7 @@ void qemu_log_close(void);
>
>  #define TB_NOTHING    0
>  #define TB_EXEC_STATS (1 << 1)
> +#define TB_JIT_STATS  (1 << 2)
>
>  void enable_collect_tb_stats(void);
>  void disable_collect_tb_stats(void);
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index be2c33c400..446e3d1708 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3126,6 +3126,11 @@ static void temp_sync(TCGContext *s, TCGTemp *ts, =
TCGRegSet allocated_regs,
>          case TEMP_VAL_REG:
>              tcg_out_st(s, ts->type, ts->reg,
>                         ts->mem_base->reg, ts->mem_offset);
> +
> +            /* Count number of spills */
> +            if (tb_stats_enabled(s->current_tb, TB_JIT_STATS)) {
> +                atomic_inc(&s->current_tb->tb_stats->code.spills);
> +            }
>              break;
>
>          case TEMP_VAL_MEM:
> @@ -3997,6 +4002,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *t=
b)
>      int i, num_insns;
>      TCGOp *op;
>
> +    s->current_tb =3D tb;
> +
>  #ifdef CONFIG_PROFILER
>      {
>          int n =3D 0;
> @@ -4028,6 +4035,14 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *=
tb)
>      }
>  #endif
>
> +    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
> +        int n =3D 0;
> +        QTAILQ_FOREACH(op, &s->ops, link) {
> +            n++;
> +        }
> +        atomic_add(&tb->tb_stats->code.num_tcg_ops, n);
> +    }
> +
>  #ifdef CONFIG_DEBUG_TCG
>      /* Ensure all labels referenced have been emitted.  */
>      {
> @@ -4094,6 +4109,14 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *=
tb)
>      }
>  #endif
>
> +    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
> +        int n =3D 0;
> +        QTAILQ_FOREACH(op, &s->ops, link) {
> +            n++;
> +        }
> +        atomic_add(&tb->tb_stats->code.num_tcg_ops_opt, n);
> +    }
> +
>      tcg_reg_alloc_start(s);
>
>      s->code_buf =3D tb->tc.ptr;
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index b411e17a28..bf6f3bcba3 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -738,6 +738,8 @@ struct TCGContext {
>
>      uint16_t gen_insn_end_off[TCG_MAX_INSNS];
>      target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
> +
> +    TranslationBlock *current_tb;
>  };
>
>  extern TCGContext tcg_init_ctx;

Without the disas hack:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

