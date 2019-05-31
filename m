Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764A3C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A852698E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIAZs6KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A852698E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWhmH-00056e-H4
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:41:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWhit-0002Ps-Kt
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWhfF-0004yP-5Z
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:33:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWhfE-0004wn-TM
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:33:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id l2so6543651wrb.9
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=XR0dSMHDtnjqbjfje9BMpv23BYYDBeaqPe+YuFryDww=;
	b=EIAZs6KXlvQZr5aWOaMwmcUA5cU8WXlf8KZMtYWTSn2+WanSMOg8eOXAgHu8qnIKeJ
	Rbt9OwxZro+3LKKsCoc+sQvgRcqbsLMIrsn4Vk3wDii+YGBCqMnHUwH2eVZmqFegCWUA
	ZhM1abunUWkpCBR+seobVzb28+X2m8hY7lPEooPH2RsQdPVFCSRJ+6Ur92xHBlzrZDGK
	s2/SfJ9ZKepdSC/9OcogQXHeIAgmKUaoVMwXpyec4ygCR2RAstp1X3Jb3YmsSudGbauI
	gSN+KXt3BuluMp6LNSe9cygkx/SIs2fJy3ENOJzFqPUr06PkQifos9TfjjxomoOWt3ko
	jkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=XR0dSMHDtnjqbjfje9BMpv23BYYDBeaqPe+YuFryDww=;
	b=YN5HSOKN1LhhqRjpgc+nDqwE5cl8/u0Wf+nvw78JyipD3rdUGdXW3BREs+683fSJZa
	7D7UOfD7sFgOF79qHqHIl7iY1HX2yAVtBfhNn3ByRHndyWQQhHrSnOCEUkfO+XHm7p7g
	tcTHGBkJ5xyki95Q11WFGU6xvfuimVRmE4z6xP03A3DkJJNExo7Qm1BahdFvPvPkxsrz
	LM9z+eRyqGneV8S7FQy80TgQ8tas/0LUhqosn3novfpd0x8gV1lD8Hy3F4DoEf1N20Nv
	BAEF9lXrZGQvySxF3W0rZKYS2qZUOT1ZoPmyfYPrmzLaq2cli0TzGlU9qbp0BfFopYxy
	b8bQ==
X-Gm-Message-State: APjAAAUr2UWXNUsPuS2aAePwdUW2V7msFHNb5K3Ngh7FRjmAdjddMP8J
	wY5R+jOQSAbbzmOc8dt/IqV2+g==
X-Google-Smtp-Source: APXvYqxuBkLSfMaVspgxaUdf4P+Dld2LmojYYdNQYgKCK0BmcilcpQHgrLE8ECLgE/VlAqO5qnVq6Q==
X-Received: by 2002:a5d:5391:: with SMTP id d17mr5914619wrv.340.1559309623114; 
	Fri, 31 May 2019 06:33:43 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id e6sm1089643wrw.83.2019.05.31.06.33.40
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 06:33:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 40E0D1FF87;
	Fri, 31 May 2019 14:33:40 +0100 (BST)
References: <20190529064148.19856-1-arilou@gmail.com>
	<20190529064148.19856-3-arilou@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190529064148.19856-3-arilou@gmail.com>
Date: Fri, 31 May 2019 14:33:40 +0100
Message-ID: <8736kuaguj.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v12 02/20] gdbstub: Implement deatch (D
 pkt) with new infra
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jon Doron <arilou@gmail.com> writes:

> Signed-off-by: Jon Doron <arilou@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub.c | 101 +++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 61 insertions(+), 40 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index e6d895177b..1db322c15a 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1413,11 +1413,6 @@ static inline int startswith(const char *string, c=
onst char *pattern)
>    return !strncmp(string, pattern, strlen(pattern));
>  }
>
> -static int process_string_cmd(
> -        GDBState *s, void *user_ctx, const char *data,
> -        const GdbCmdParseEntry *cmds, int num_cmds)
> -        __attribute__((unused));
> -
>  static int process_string_cmd(GDBState *s, void *user_ctx, const char *d=
ata,
>                                const GdbCmdParseEntry *cmds, int num_cmds)
>  {
> @@ -1463,6 +1458,55 @@ static int process_string_cmd(GDBState *s, void *u=
ser_ctx, const char *data,
>      return -1;
>  }
>
> +static void run_cmd_parser(GDBState *s, const char *data,
> +                           const GdbCmdParseEntry *cmd)
> +{
> +    if (!data) {
> +        return;
> +    }
> +
> +    /* In case there was an error during the command parsing we must
> +    * send a NULL packet to indicate the command is not supported */
> +    if (process_string_cmd(s, NULL, data, cmd, 1)) {
> +        put_packet(s, "");
> +    }
> +}
> +
> +static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    GDBProcess *process;
> +    GDBState *s =3D gdb_ctx->s;
> +    uint32_t pid =3D 1;
> +
> +    if (s->multiprocess) {
> +        if (!gdb_ctx->num_params) {
> +            put_packet(s, "E22");
> +            return;
> +        }
> +
> +        pid =3D gdb_ctx->params[0].val_ul;
> +    }
> +
> +    process =3D gdb_get_process(s, pid);
> +    gdb_process_breakpoint_remove_all(s, process);
> +    process->attached =3D false;
> +
> +    if (pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
> +        s->c_cpu =3D gdb_first_attached_cpu(s);
> +    }
> +
> +    if (pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
> +        s->g_cpu =3D gdb_first_attached_cpu(s);
> +    }
> +
> +    if (!s->c_cpu) {
> +        /* No more process attached */
> +        gdb_syscall_mode =3D GDB_SYS_DISABLED;
> +        gdb_continue(s);
> +    }
> +    put_packet(s, "OK");
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1477,6 +1521,7 @@ static int gdb_handle_packet(GDBState *s, const cha=
r *line_buf)
>      uint8_t *registers;
>      target_ulong addr, len;
>      GDBThreadIdKind thread_kind;
> +    const GdbCmdParseEntry *cmd_parser =3D NULL;
>
>      trace_gdbstub_io_command(line_buf);
>
> @@ -1577,42 +1622,15 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          error_report("QEMU: Terminated via GDBstub");
>          exit(0);
>      case 'D':
> -        /* Detach packet */
> -        pid =3D 1;
> -
> -        if (s->multiprocess) {
> -            unsigned long lpid;
> -            if (*p !=3D ';') {
> -                put_packet(s, "E22");
> -                break;
> -            }
> -
> -            if (qemu_strtoul(p + 1, &p, 16, &lpid)) {
> -                put_packet(s, "E22");
> -                break;
> -            }
> -
> -            pid =3D lpid;
> -        }
> -
> -        process =3D gdb_get_process(s, pid);
> -        gdb_process_breakpoint_remove_all(s, process);
> -        process->attached =3D false;
> -
> -        if (pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
> -            s->c_cpu =3D gdb_first_attached_cpu(s);
> -        }
> -
> -        if (pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
> -            s->g_cpu =3D gdb_first_attached_cpu(s);
> -        }
> -
> -        if (s->c_cpu =3D=3D NULL) {
> -            /* No more process attached */
> -            gdb_syscall_mode =3D GDB_SYS_DISABLED;
> -            gdb_continue(s);
> +        {
> +            static const GdbCmdParseEntry detach_cmd_desc =3D {
> +                .handler =3D handle_detach,
> +                .cmd =3D "D",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "?.l0"
> +            };
> +            cmd_parser =3D &detach_cmd_desc;
>          }
> -        put_packet(s, "OK");
>          break;
>      case 's':
>          if (*p !=3D '\0') {
> @@ -1985,6 +2003,9 @@ static int gdb_handle_packet(GDBState *s, const cha=
r *line_buf)
>          put_packet(s, buf);
>          break;
>      }
> +
> +    run_cmd_parser(s, line_buf, cmd_parser);
> +
>      return RS_IDLE;
>  }


--
Alex Benn=C3=A9e

