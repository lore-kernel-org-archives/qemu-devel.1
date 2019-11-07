Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4538C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC7F214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1gZkVAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC7F214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkbr-0005Iq-Lb
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iSkbA-0004qM-EA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iSkb8-0000ji-CC
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:25:28 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34686)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iSkb8-0000jK-2Q
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:25:26 -0500
Received: by mail-wm1-x341.google.com with SMTP id v3so5277608wmh.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 08:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0+0dA56KOZqPL2jF+A067jha4ApyQmyc/3kxyrczMIM=;
 b=U1gZkVAJila1xNpfAeuNAFff5B0MWH34DygJYtqLNlQJmmmZjtH7gGxrqnvLUDutgE
 gn/SLbqlogdQEZmgXutPuurYEuTAdqbw8hYlX/7q+9GX/9o5mj5DMeM0FoNyQHf5PhIM
 rFrC6fzKO+8+JCPzW8yPsSzjaelkpCt9Z+A+wgkTXweSe//kkk6tNJhWJdlxYZCZOzMz
 dHGv+8MYnxSpPVuCp1hSqmEhrLwHmeO+GQRCyJwV4AmIYKuDlG0a8ymbh/vemI/COgqf
 Gg5UjqgYod/5RQoZNgfqDKLdwk3AlUz5VDLfhF61wHfW0nWXwe/fA82vv03adV0Q0bcn
 3zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0+0dA56KOZqPL2jF+A067jha4ApyQmyc/3kxyrczMIM=;
 b=DeNHUWo4kDXgoySOAbGzbn5EmK2SywdTIDfSl69ZvguhWH8fULUDr26rBMcdwGv8xF
 LO26KskQDgLWPjqzWbic070gS8C9L50luqwjZLmo3gIPSkTndqLQOy4phWlYavu9n3VW
 xtc2uYr9jiLOEJEnav3IE/UnjI7H0461K+VbrJQGWj+tfGe5KXkjDBjfzm6VQLZcqEes
 UorXYNqyM0Zh1pzK3mPL+mLKmWE1Z1nbXsMm+tZp6Od42Boc+bqHO7ABOBRY0876Uxio
 jdS+vRsG5HZgatLsPDP65F2OptdU8u9+NX/rL29bfVbKWs/wpiSkMpN+lmf9uiurp0Xo
 bf8Q==
X-Gm-Message-State: APjAAAVQrtQWFwDdvZ6/PLIOR6a4kKDc12U06HG5uynNZ93o4m7FEOaO
 5S2J8/tNps47KUdAQEX9NdJAKFdOzOI=
X-Google-Smtp-Source: APXvYqxEUIj9kB00XMiW0xFE8uxirvkg4qFjg4dYEYUhdZOPe+LXqoMth8VWgpEn7Ad3zzIuHozEaw==
X-Received: by 2002:a1c:96c9:: with SMTP id y192mr3962205wmd.8.1573143924543; 
 Thu, 07 Nov 2019 08:25:24 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y2sm3124601wmy.2.2019.11.07.08.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 08:25:23 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B3B3D1FF87;
 Thu,  7 Nov 2019 16:25:22 +0000 (GMT)
References: <20191107142613.2379-1-robert.foley@linaro.org>
 <20191107142613.2379-4-robert.foley@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 3/4] qemu_log_lock/unlock now preserves the qemu_logfile
 handle.
In-reply-to: <20191107142613.2379-4-robert.foley@linaro.org>
Date: Thu, 07 Nov 2019 16:25:22 +0000
Message-ID: <87wocbhcwd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.puhov@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> qemu_log_lock() now returns a handle and qemu_log_unlock() receives a
> handle to unlock.  This allows for changing the handle during logging
> and ensures the lock() and unlock() are for the same file.

Ahh there it is!

We probably want to put the API change through before we add the RCU
support - so swap the patch order around.

>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  include/qemu/log.h            | 14 +++++++-------
>  accel/tcg/cpu-exec.c          |  4 ++--
>  accel/tcg/translate-all.c     |  4 ++--
>  accel/tcg/translator.c        |  4 ++--
>  exec.c                        |  4 ++--
>  hw/net/can/can_sja1000.c      |  4 ++--
>  net/can/can_socketcan.c       |  5 ++---
>  target/cris/translate.c       |  4 ++--
>  target/i386/translate.c       |  5 +++--
>  target/lm32/translate.c       |  4 ++--
>  target/microblaze/translate.c |  4 ++--
>  target/nios2/translate.c      |  4 ++--
>  target/tilegx/translate.c     |  7 ++++---
>  target/unicore32/translate.c  |  4 ++--
>  tcg/tcg.c                     | 16 ++++++++--------
>  15 files changed, 44 insertions(+), 43 deletions(-)
>
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index 975de18e23..3d0f47a479 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -71,25 +71,25 @@ static inline bool qemu_log_separate(void)
>   * qemu_loglevel is never set when qemu_logfile is unset.
>   */
>
> -static inline void qemu_log_lock(void)
> +static inline FILE *qemu_log_lock(void)
>  {
>      QemuLogFile *logfile;
>      rcu_read_lock();
>      logfile =3D atomic_rcu_read(&qemu_logfile);
>      if (logfile) {
>          qemu_flockfile(logfile->fd);
> +        return logfile->fd;
>      }
>      rcu_read_unlock();
> +    return NULL;
>  }
>
> -static inline void qemu_log_unlock(void)
> +static inline void qemu_log_unlock(FILE *fd)
>  {
> -    QemuLogFile *logfile;
> -    logfile =3D atomic_rcu_read(&qemu_logfile);
> -    if (logfile) {
> -        qemu_funlockfile(logfile->fd);
> +    if (fd) {
> +        qemu_funlockfile(fd);
> +        rcu_read_unlock();
>      }
> -    rcu_read_unlock();
>  }
>
>  /* Logging functions: */
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index c01f59c743..62068d10c3 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -156,7 +156,7 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *=
cpu, TranslationBlock *itb)
>  #if defined(DEBUG_DISAS)
>      if (qemu_loglevel_mask(CPU_LOG_TB_CPU)
>          && qemu_log_in_addr_range(itb->pc)) {
> -        qemu_log_lock();
> +        FILE *logfile =3D qemu_log_lock();
>          int flags =3D 0;
>          if (qemu_loglevel_mask(CPU_LOG_TB_FPU)) {
>              flags |=3D CPU_DUMP_FPU;
> @@ -165,7 +165,7 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *=
cpu, TranslationBlock *itb)
>          flags |=3D CPU_DUMP_CCOP;
>  #endif
>          log_cpu_state(cpu, flags);
> -        qemu_log_unlock();
> +        qemu_log_unlock(logfile);
>      }
>  #endif /* DEBUG_DISAS */
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 9f48da9472..bb325a2bc4 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1804,7 +1804,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>  #ifdef DEBUG_DISAS
>      if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
>          qemu_log_in_addr_range(tb->pc)) {
> -        qemu_log_lock();
> +        FILE *logfile =3D qemu_log_lock();
>          qemu_log("OUT: [size=3D%d]\n", gen_code_size);
>          if (tcg_ctx->data_gen_ptr) {
>              size_t code_size =3D tcg_ctx->data_gen_ptr - tb->tc.ptr;
> @@ -1829,7 +1829,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>          }
>          qemu_log("\n");
>          qemu_log_flush();
> -        qemu_log_unlock();
> +        qemu_log_unlock(logfile);
>      }
>  #endif
>
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index f977682be7..603d17ff83 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -138,11 +138,11 @@ void translator_loop(const TranslatorOps *ops, Disa=
sContextBase *db,
>  #ifdef DEBUG_DISAS
>      if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
>          && qemu_log_in_addr_range(db->pc_first)) {
> -        qemu_log_lock();
> +        FILE *logfile =3D qemu_log_lock();
>          qemu_log("----------------\n");
>          ops->disas_log(db, cpu);
>          qemu_log("\n");
> -        qemu_log_unlock();
> +        qemu_log_unlock(logfile);
>      }
>  #endif
>  }
> diff --git a/exec.c b/exec.c
> index ffdb518535..c994a00f10 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1223,13 +1223,13 @@ void cpu_abort(CPUState *cpu, const char *fmt, ..=
.)
>      fprintf(stderr, "\n");
>      cpu_dump_state(cpu, stderr, CPU_DUMP_FPU | CPU_DUMP_CCOP);
>      if (qemu_log_separate()) {
> -        qemu_log_lock();
> +        FILE *logfile =3D qemu_log_lock();
>          qemu_log("qemu: fatal: ");
>          qemu_log_vprintf(fmt, ap2);
>          qemu_log("\n");
>          log_cpu_state(cpu, CPU_DUMP_FPU | CPU_DUMP_CCOP);
>          qemu_log_flush();
> -        qemu_log_unlock();
> +        qemu_log_unlock(logfile);
>          qemu_log_close();
>      }
>      va_end(ap2);
> diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
> index 1f81341554..39c78faf9b 100644
> --- a/hw/net/can/can_sja1000.c
> +++ b/hw/net/can/can_sja1000.c
> @@ -247,8 +247,8 @@ int can_sja_accept_filter(CanSJA1000State *s,
>  static void can_display_msg(const char *prefix, const qemu_can_frame *ms=
g)
>  {
>      int i;
> +    FILE *logfile =3D qemu_log_lock();
>
> -    qemu_log_lock();
>      qemu_log("%s%03X [%01d] %s %s",
>               prefix,
>               msg->can_id & QEMU_CAN_EFF_MASK,
> @@ -261,7 +261,7 @@ static void can_display_msg(const char *prefix, const=
 qemu_can_frame *msg)
>      }
>      qemu_log("\n");
>      qemu_log_flush();
> -    qemu_log_unlock();
> +    qemu_log_unlock(logfile);
>  }
>
>  static void buff2frame_pel(const uint8_t *buff, qemu_can_frame *frame)
> diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
> index 8a6ffad40c..29bfacd4f8 100644
> --- a/net/can/can_socketcan.c
> +++ b/net/can/can_socketcan.c
> @@ -76,8 +76,7 @@ QEMU_BUILD_BUG_ON(offsetof(qemu_can_frame, data)
>  static void can_host_socketcan_display_msg(struct qemu_can_frame *msg)
>  {
>      int i;
> -
> -    qemu_log_lock();
> +    FILE *logfile =3D qemu_log_lock();
>      qemu_log("[cansocketcan]: %03X [%01d] %s %s",
>               msg->can_id & QEMU_CAN_EFF_MASK,
>               msg->can_dlc,
> @@ -89,7 +88,7 @@ static void can_host_socketcan_display_msg(struct qemu_=
can_frame *msg)
>      }
>      qemu_log("\n");
>      qemu_log_flush();
> -    qemu_log_unlock();
> +    qemu_log_unlock(logfile);
>  }
>
>  static void can_host_socketcan_read(void *opaque)
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index e752bd0609..cb57516a44 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -3273,11 +3273,11 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb, int max_insns)
>  #if !DISAS_CRIS
>      if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
>          && qemu_log_in_addr_range(pc_start)) {
> -        qemu_log_lock();
> +        FILE *logfile =3D qemu_log_lock();
>          qemu_log("--------------\n");
>          qemu_log("IN: %s\n", lookup_symbol(pc_start));
>          log_target_disas(cs, pc_start, dc->pc - pc_start);
> -        qemu_log_unlock();
> +        qemu_log_unlock(logfile);
>      }
>  #endif
>  #endif
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 77e932d827..7c99ef1385 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -2502,14 +2502,15 @@ static void gen_unknown_opcode(CPUX86State *env, =
DisasContext *s)
>      gen_illegal_opcode(s);
>
>      if (qemu_loglevel_mask(LOG_UNIMP)) {
> +        FILE *logfile =3D qemu_log_lock();
>          target_ulong pc =3D s->pc_start, end =3D s->pc;
> -        qemu_log_lock();
> +
>          qemu_log("ILLOPC: " TARGET_FMT_lx ":", pc);
>          for (; pc < end; ++pc) {
>              qemu_log(" %02x", cpu_ldub_code(env, pc));
>          }
>          qemu_log("\n");
> -        qemu_log_unlock();
> +        qemu_log_unlock(logfile);
>      }
>  }
>
> diff --git a/target/lm32/translate.c b/target/lm32/translate.c
> index 778cae1e81..73db9654d6 100644
> --- a/target/lm32/translate.c
> +++ b/target/lm32/translate.c
> @@ -1137,10 +1137,10 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb, int max_insns)
>  #ifdef DEBUG_DISAS
>      if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
>          && qemu_log_in_addr_range(pc_start)) {
> -        qemu_log_lock();
> +        FILE *logfile =3D qemu_log_lock();
>          qemu_log("\n");
>          log_target_disas(cs, pc_start, dc->pc - pc_start);
> -        qemu_log_unlock();
> +        qemu_log_unlock(logfile);
>      }
>  #endif
>  }
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 761f535357..cc1ad15656 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1766,10 +1766,10 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb, int max_insns)
>  #if !SIM_COMPAT
>      if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
>          && qemu_log_in_addr_range(pc_start)) {
> -        qemu_log_lock();
> +        FILE *logfile =3D qemu_log_lock();
>          qemu_log("--------------\n");
>          log_target_disas(cs, pc_start, dc->pc - pc_start);
> -        qemu_log_unlock();
> +        qemu_log_unlock(logfile);
>      }
>  #endif
>  #endif
> diff --git a/target/nios2/translate.c b/target/nios2/translate.c
> index e17656e66f..82107bf270 100644
> --- a/target/nios2/translate.c
> +++ b/target/nios2/translate.c
> @@ -892,11 +892,11 @@ void gen_intermediate_code(CPUState *cs, Translatio=
nBlock *tb, int max_insns)
>  #ifdef DEBUG_DISAS
>      if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
>          && qemu_log_in_addr_range(tb->pc)) {
> -        qemu_log_lock();
> +        FILE *logfile =3D qemu_log_lock();
>          qemu_log("IN: %s\n", lookup_symbol(tb->pc));
>          log_target_disas(cs, tb->pc, dc->pc - tb->pc);
>          qemu_log("\n");
> -        qemu_log_unlock();
> +        qemu_log_unlock(logfile);
>      }
>  #endif
>  }
> diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
> index 68dd4aa2d8..fd406f4f71 100644
> --- a/target/tilegx/translate.c
> +++ b/target/tilegx/translate.c
> @@ -2377,6 +2377,7 @@ void gen_intermediate_code(CPUState *cs, Translatio=
nBlock *tb, int max_insns)
>      uint64_t pc_start =3D tb->pc;
>      uint64_t page_start =3D pc_start & TARGET_PAGE_MASK;
>      int num_insns =3D 0;
> +    FILE *logfile =3D NULL;
>
>      dc->pc =3D pc_start;
>      dc->mmuidx =3D 0;
> @@ -2388,7 +2389,7 @@ void gen_intermediate_code(CPUState *cs, Translatio=
nBlock *tb, int max_insns)
>      dc->zero =3D NULL;
>
>      if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)) {
> -        qemu_log_lock();
> +        logfile =3D qemu_log_lock();
>          qemu_log("IN: %s\n", lookup_symbol(pc_start));
>      }
>      gen_tb_start(tb);
> @@ -2418,9 +2419,9 @@ void gen_intermediate_code(CPUState *cs, Translatio=
nBlock *tb, int max_insns)
>      tb->size =3D dc->pc - pc_start;
>      tb->icount =3D num_insns;
>
> -    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)) {
> +    if (logfile) {
>          qemu_log("\n");
> -        qemu_log_unlock();
> +        qemu_log_unlock(logfile);
>      }
>  }
>
> diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
> index 0e01f35856..0f6891b8aa 100644
> --- a/target/unicore32/translate.c
> +++ b/target/unicore32/translate.c
> @@ -1994,12 +1994,12 @@ done_generating:
>  #ifdef DEBUG_DISAS
>      if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
>          && qemu_log_in_addr_range(pc_start)) {
> -        qemu_log_lock();
> +        FILE *logfile =3D qemu_log_lock();
>          qemu_log("----------------\n");
>          qemu_log("IN: %s\n", lookup_symbol(pc_start));
>          log_target_disas(cs, pc_start, dc->pc - pc_start);
>          qemu_log("\n");
> -        qemu_log_unlock();
> +        qemu_log_unlock(logfile);
>      }
>  #endif
>      tb->size =3D dc->pc - pc_start;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 220eaac7c7..4f616ba38b 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1085,7 +1085,7 @@ void tcg_prologue_init(TCGContext *s)
>
>  #ifdef DEBUG_DISAS
>      if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM)) {
> -        qemu_log_lock();
> +        FILE *logfile =3D qemu_log_lock();
>          qemu_log("PROLOGUE: [size=3D%zu]\n", prologue_size);
>          if (s->data_gen_ptr) {
>              size_t code_size =3D s->data_gen_ptr - buf0;
> @@ -1110,7 +1110,7 @@ void tcg_prologue_init(TCGContext *s)
>          }
>          qemu_log("\n");
>          qemu_log_flush();
> -        qemu_log_unlock();
> +        qemu_log_unlock(logfile);
>      }
>  #endif
>
> @@ -4049,11 +4049,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock =
*tb)
>  #ifdef DEBUG_DISAS
>      if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP)
>                   && qemu_log_in_addr_range(tb->pc))) {
> -        qemu_log_lock();
> +        FILE *logfile =3D qemu_log_lock();
>          qemu_log("OP:\n");
>          tcg_dump_ops(s, false);
>          qemu_log("\n");
> -        qemu_log_unlock();
> +        qemu_log_unlock(logfile);
>      }
>  #endif
>
> @@ -4094,11 +4094,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock =
*tb)
>  #ifdef DEBUG_DISAS
>          if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_IND)
>                       && qemu_log_in_addr_range(tb->pc))) {
> -            qemu_log_lock();
> +            FILE *logfile =3D qemu_log_lock();
>              qemu_log("OP before indirect lowering:\n");
>              tcg_dump_ops(s, false);
>              qemu_log("\n");
> -            qemu_log_unlock();
> +            qemu_log_unlock(logfile);
>          }
>  #endif
>          /* Replace indirect temps with direct temps.  */
> @@ -4115,11 +4115,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock =
*tb)
>  #ifdef DEBUG_DISAS
>      if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_OPT)
>                   && qemu_log_in_addr_range(tb->pc))) {
> -        qemu_log_lock();
> +        FILE *logfile =3D qemu_log_lock();
>          qemu_log("OP after optimization and liveness analysis:\n");
>          tcg_dump_ops(s, true);
>          qemu_log("\n");
> -        qemu_log_unlock();
> +        qemu_log_unlock(logfile);
>      }
>  #endif


--
Alex Benn=C3=A9e

