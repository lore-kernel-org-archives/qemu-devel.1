Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B92C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7D62080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTNPlI6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7D62080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFK3i-0005ui-Iy
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFK1y-0004Y6-5P
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:30:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFK1v-0007CV-Qe
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:30:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id c18so16371102wrm.9
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=70G2k0nVxBWbRNdmFY6r+XnQt+kk9E4LGuUjFcDxwvM=;
 b=VTNPlI6dPykzoEMQtb5rqJlUJslLFA+W+I9yMHIz8UgZdMcIjhmKXhVnDC3Jvats8h
 0O/o7/3NgIdRQQScr/JwGTNWoTB6LRuPFLLGKtSGHyHRcoVWY4b25UjLh2lVl9gHjIGq
 bsRp/3MRzhqxeJMIgWOjAubDEB1bCsMHODo6Lw17BKJ2Xwpd0PkAm63K87IiGkXlcyqa
 Xb5j7e1TGmB7y5RPBzOKpzZdAclz95mapHnsnFYVjOvpfbK2RUGwx6xADwWkxD9Q6WDw
 WqH6Y0snz0X5mi8dLIAGe3Bi+MGreLQwDIhF+dEtOM6EXhR13e5ah+vDzNiDyfPxDUdV
 pwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=70G2k0nVxBWbRNdmFY6r+XnQt+kk9E4LGuUjFcDxwvM=;
 b=Zy5ohunAN9OlYKhnlcqV0l/3Hwwr7QMOTslRxYFCLDx255IE2/Ynf+XHbTkjx2OfJQ
 6EDBmI2D4nuOZ5FozKwdnKAFPHU/7alcGtVaW2JkoDhVRILd0vbpe0iyYjHmvAPb2Lq0
 QU562c08dV9xQTjG3uvidsoO8LSlxTvKnbKG6Ga0RjczRlCJOUyLpEZAvqvoLy5zstJZ
 +a6coPqxrRrRPQHcrQ4jsVgA+3yS3Kcnl/S9G9MXt0qY75A2gpB7DnRcKRZXnktueHoQ
 QWl6GXdum0nQOIwjsMI+FVQkr5Md9c8VpQmtb4eHH5LWod4TRkQ46yL373PSDivKLC3P
 O5/w==
X-Gm-Message-State: AOAM530UebKMaxazhyda4WQ3F8661jdWy4EkY0CxUP/Mf4rWomZ1R6RT
 qw9ti5KxY0tFl4daHPWlHwOBqg==
X-Google-Smtp-Source: ABdhPJyzcPJOar3Su+8Lb0csJOaBzsG0l56srgZ2w4BGZKHsrTsbtSAKABaywxbi7ksjjALymCF3pQ==
X-Received: by 2002:adf:f14f:: with SMTP id y15mr8258504wro.69.1599496206178; 
 Mon, 07 Sep 2020 09:30:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y6sm9500017wrn.41.2020.09.07.09.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 09:30:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 37BB91FF7E;
 Mon,  7 Sep 2020 17:30:04 +0100 (BST)
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903461078.28509.9310557942659425312.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v3 11/15] gdbstub: add reverse step support in replay mode
In-reply-to: <159903461078.28509.9310557942659425312.stgit@pasha-ThinkPad-X280>
Date: Mon, 07 Sep 2020 17:30:04 +0100
Message-ID: <87blihr1mb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:

> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> GDB remote protocol supports two reverse debugging commands:
> reverse step and reverse continue.
> This patch adds support of the first one to the gdbstub.
> Reverse step is intended to step one instruction in the backwards
> direction. This is not possible in regular execution.
> But replayed execution is deterministic, therefore we can load one of
> the prior snapshots and proceed to the desired step. It is equivalent
> to stepping one instruction back.
> There should be at least one snapshot preceding the debugged part of
> the replay log.

Apropos of the 10/15 thread I currently get:

  (gdb) reverse-stepi
  warning: Remote failure reply: E14

  Program stopped.
  _isr_wrapper () at /home/galak/git/zephyr/arch/arm/core/aarch64/isr_wrapp=
er.S:36
  36      in /home/galak/git/zephyr/arch/arm/core/aarch64/isr_wrapper.S

After having manually triggered a loadvm rrstart in the monitor. The
step never happened:

  (qemu) loadvm rrstart
  loadvm rrstart
  (qemu) info replay
  info replay
  Replaying execution 'record.out': instruction count =3D 190506

  * reverse-stepi called in gdb window *

  (qemu) info replay
  info replay
  Replaying execution 'record.out': instruction count =3D 190506
  (qemu) info snapshots
  info snapshots
  List of snapshots present on all disks:
  ID        TAG               VM SIZE                DATE     VM CLOCK     =
ICOUNT
  --        rrstart           653 KiB 2020-09-07 17:12:42 00:00:00.000     =
     0


>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> ---
>  accel/tcg/translator.c    |    1 +
>  exec.c                    |    7 ++++++
>  gdbstub.c                 |   55 +++++++++++++++++++++++++++++++++++++++=
++++--
>  include/sysemu/replay.h   |   11 +++++++++
>  replay/replay-debugging.c |   33 +++++++++++++++++++++++++++
>  softmmu/cpus.c            |   14 +++++++++--
>  stubs/replay.c            |    5 ++++
>  7 files changed, 121 insertions(+), 5 deletions(-)
>
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 603d17ff83..fb1e19c585 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -17,6 +17,7 @@
>  #include "exec/log.h"
>  #include "exec/translator.h"
>  #include "exec/plugin-gen.h"
> +#include "sysemu/replay.h"
>=20=20
>  /* Pairs with tcg_clear_temp_count.
>     To be called by #TranslatorOps.{translate_insn,tb_stop} if
> diff --git a/exec.c b/exec.c
> index 7683afb6a8..47512e950c 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2750,6 +2750,13 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr add=
r, vaddr len,
>      QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
>          if (watchpoint_address_matches(wp, addr, len)
>              && (wp->flags & flags)) {
> +            if (replay_running_debug()) {
> +                /*
> +                 * Don't process the watchpoints when we are
> +                 * in a reverse debugging operation.
> +                 */
> +                return;
> +            }
>              if (flags =3D=3D BP_MEM_READ) {
>                  wp->flags |=3D BP_WATCHPOINT_HIT_READ;
>              } else {
> diff --git a/gdbstub.c b/gdbstub.c
> index 9dfb6e4142..79e8ccc050 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -51,6 +51,7 @@
>  #include "sysemu/runstate.h"
>  #include "hw/semihosting/semihost.h"
>  #include "exec/exec-all.h"
> +#include "sysemu/replay.h"
>=20=20
>  #ifdef CONFIG_USER_ONLY
>  #define GDB_ATTACHED "0"
> @@ -375,6 +376,20 @@ typedef struct GDBState {
>   */
>  static int sstep_flags =3D SSTEP_ENABLE|SSTEP_NOIRQ|SSTEP_NOTIMER;
>=20=20
> +/* Retrieves flags for single step mode. */
> +static int get_sstep_flags(void)
> +{
> +    /*
> +     * In replay mode all events written into the log should be replayed.
> +     * That is why NOIRQ flag is removed in this mode.
> +     */
> +    if (replay_mode !=3D REPLAY_MODE_NONE) {
> +        return SSTEP_ENABLE;
> +    } else {
> +        return sstep_flags;
> +    }
> +}
> +
>  static GDBState gdbserver_state;
>=20=20
>  static void init_gdbserver_state(void)
> @@ -501,7 +516,7 @@ static int gdb_continue_partial(char *newstates)
>                  break; /* nothing to do here */
>              case 's':
>                  trace_gdbstub_op_stepping(cpu->cpu_index);
> -                cpu_single_step(cpu, sstep_flags);
> +                cpu_single_step(cpu, get_sstep_flags());
>                  cpu_resume(cpu);
>                  flag =3D 1;
>                  break;
> @@ -1874,10 +1889,31 @@ static void handle_step(GdbCmdContext *gdb_ctx, v=
oid *user_ctx)
>          gdb_set_cpu_pc((target_ulong)gdb_ctx->params[0].val_ull);
>      }
>=20=20
> -    cpu_single_step(gdbserver_state.c_cpu, sstep_flags);
> +    cpu_single_step(gdbserver_state.c_cpu, get_sstep_flags());
>      gdb_continue();
>  }
>=20=20
> +static void handle_backward(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    if (replay_mode !=3D REPLAY_MODE_PLAY) {
> +        put_packet("E22");
> +    }
> +    if (gdb_ctx->num_params =3D=3D 1) {
> +        switch (gdb_ctx->params[0].opcode) {
> +        case 's':
> +            if (replay_reverse_step()) {
> +                gdb_continue();
> +            } else {
> +                put_packet("E14");
> +            }
> +            return;
> +        }
> +    }
> +
> +    /* Default invalid command */
> +    put_packet("");
> +}
> +
>  static void handle_v_cont_query(GdbCmdContext *gdb_ctx, void *user_ctx)
>  {
>      put_packet("vCont;c;C;s;S");
> @@ -2124,6 +2160,10 @@ static void handle_query_supported(GdbCmdContext *=
gdb_ctx, void *user_ctx)
>          g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+"=
);
>      }
>=20=20
> +    if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
> +        g_string_append(gdbserver_state.str_buf, ";ReverseStep+");
> +    }
> +
>      if (gdb_ctx->num_params &&
>          strstr(gdb_ctx->params[0].data, "multiprocess+")) {
>          gdbserver_state.multiprocess =3D true;
> @@ -2460,6 +2500,17 @@ static int gdb_handle_packet(const char *line_buf)
>              cmd_parser =3D &step_cmd_desc;
>          }
>          break;
> +    case 'b':
> +        {
> +            static const GdbCmdParseEntry backward_cmd_desc =3D {
> +                .handler =3D handle_backward,
> +                .cmd =3D "b",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "o0"
> +            };
> +            cmd_parser =3D &backward_cmd_desc;
> +        }
> +        break;
>      case 'F':
>          {
>              static const GdbCmdParseEntry file_io_cmd_desc =3D {
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index 239c01e7df..13a8123b09 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -75,6 +75,17 @@ void replay_finish(void);
>  void replay_add_blocker(Error *reason);
>  /* Returns name of the replay log file */
>  const char *replay_get_filename(void);
> +/*
> + * Start making one step in backward direction.
> + * Used by gdbstub for backwards debugging.
> + * Returns true on success.
> + */
> +bool replay_reverse_step(void);
> +/*
> + * Returns true if replay module is processing
> + * reverse_continue or reverse_step request
> + */
> +bool replay_running_debug(void);
>=20=20
>  /* Processing the instructions */
>=20=20
> diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
> index cfd0221692..aa3ca040e2 100644
> --- a/replay/replay-debugging.c
> +++ b/replay/replay-debugging.c
> @@ -22,6 +22,13 @@
>  #include "block/snapshot.h"
>  #include "migration/snapshot.h"
>=20=20
> +static bool replay_is_debugging;
> +
> +bool replay_running_debug(void)
> +{
> +    return replay_is_debugging;
> +}
> +
>  void hmp_info_replay(Monitor *mon, const QDict *qdict)
>  {
>      if (replay_mode =3D=3D REPLAY_MODE_NONE) {
> @@ -219,3 +226,29 @@ void hmp_replay_seek(Monitor *mon, const QDict *qdic=
t)
>          return;
>      }
>  }
> +
> +static void replay_stop_vm_debug(void *opaque)
> +{
> +    replay_is_debugging =3D false;
> +    vm_stop(RUN_STATE_DEBUG);
> +    replay_delete_break();
> +}
> +
> +bool replay_reverse_step(void)
> +{
> +    Error *err =3D NULL;
> +
> +    assert(replay_mode =3D=3D REPLAY_MODE_PLAY);
> +
> +    if (replay_get_current_icount() !=3D 0) {
> +        replay_seek(replay_get_current_icount() - 1, replay_stop_vm_debu=
g, &err);
> +        if (err) {
> +            error_free(err);
> +            return false;
> +        }
> +        replay_is_debugging =3D true;
> +        return true;
> +    }
> +
> +    return false;
> +}
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index a802e899ab..377fe3298c 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -1004,9 +1004,17 @@ static bool cpu_can_run(CPUState *cpu)
>=20=20
>  static void cpu_handle_guest_debug(CPUState *cpu)
>  {
> -    gdb_set_stop_cpu(cpu);
> -    qemu_system_debug_request();
> -    cpu->stopped =3D true;
> +    if (!replay_running_debug()) {
> +        gdb_set_stop_cpu(cpu);
> +        qemu_system_debug_request();
> +        cpu->stopped =3D true;
> +    } else {
> +        if (!cpu->singlestep_enabled) {
> +            cpu_single_step(cpu, SSTEP_ENABLE);
> +        } else {
> +            cpu_single_step(cpu, 0);
> +        }
> +    }
>  }
>=20=20
>  #ifdef CONFIG_LINUX
> diff --git a/stubs/replay.c b/stubs/replay.c
> index eacb366aa8..d5b52302e9 100644
> --- a/stubs/replay.c
> +++ b/stubs/replay.c
> @@ -93,3 +93,8 @@ uint64_t replay_get_current_icount(void)
>  {
>      return 0;
>  }
> +
> +bool replay_reverse_step(void)
> +{
> +    return false;
> +}


--=20
Alex Benn=C3=A9e

