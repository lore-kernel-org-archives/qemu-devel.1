Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5944C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E64020818
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EcfMdWYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E64020818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52680 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQcaQ-0005J8-S8
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 14:55:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQcZc-0004vH-RK
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQcZb-0004TM-Pg
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:54:48 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQcZb-0004Qs-Fv
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:54:47 -0400
Received: by mail-wr1-x441.google.com with SMTP id f8so2557046wrt.1
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=rzitx8izZqy6sKYf9JlLt7s+D1Z8++5z3EYNS1CGv+8=;
	b=EcfMdWYSgnn1tcVyEziEBWVMrXDvQBn0xJc9XLHU7RO4QFdgPDnnqa2m9uCxqJm+ov
	0BKHfZmWeadi6zp6JjG0SjfqYVU7mYANGFCuFzBqeWCKc275dpIOzIdmMxY1+Bcd3hzi
	XOX7HiUZcZNS7CvRvm2eJ9IlBD+XiH+Gg4mJPBQyg7dvGhWSFEKniqT9mDxplNbH+f3W
	WrAiSFOHJKduClQldwqu2+I8XRbyQKwGXttsDSWwahDxmuih/fbomGWTNLdAHR4AIFtO
	D1QJhid5vsbUpLNLn7Q5Z8vp8O7vW8RSvjJI3sp2NUqZceV4WOLmwS9U6smP6ZsLX2FK
	uG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=rzitx8izZqy6sKYf9JlLt7s+D1Z8++5z3EYNS1CGv+8=;
	b=roaAgLTDWFaC9+XvOMS9z+L2S+By1zy74R3U+MeTmL12SvPDDLkOlfoyv9anROa4+q
	TqXQMlGUV1SDVTUKY2Tx/GkUtDYwnnggk6IjHcDVdFGjKhnspo4kfdpkymKww1M9t0dG
	+p5nz3rArIA9GsdwZIdowyUiRNkHDXQKEk77MQDyxzZY6wcKgZuypyYW6Mx2oAQnACyA
	zlhOZ4WkVZ1Zyw/CUTJhAbSbW7pHAJoTmTPKHnud5qWNF6QhnFNv5DN8T4iMzB7nYUd9
	3cVI+Ta0A30JdHc3JTaj2LlY/dRJCVqfWmAwhalR3H/PDOpAu93oUeV5sNdBE9inYkd9
	gdcA==
X-Gm-Message-State: APjAAAU3LeR83eaBFnUHSf8OvJF7OKLoBhNisnoDqqqQu2viwETVTNLR
	N9D//n0EBWROJ7wOkO3tFtBmjA==
X-Google-Smtp-Source: APXvYqwuhyJoEmMeoSfL8kYKdrtbOHPcK6ZKq67+uV/WUYO6mgteU9JkBvEyX8LtFPehOlX5l3sdnQ==
X-Received: by 2002:adf:8367:: with SMTP id 94mr11338439wrd.179.1557860085785; 
	Tue, 14 May 2019 11:54:45 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	p14sm16145087wrt.53.2019.05.14.11.54.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 14 May 2019 11:54:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id BE4ED1FF87;
	Tue, 14 May 2019 19:54:44 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-3-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-3-arilou@gmail.com>
Date: Tue, 14 May 2019 19:54:44 +0100
Message-ID: <877easooi3.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v9 02/27] gdbstub: Implement deatch (D pkt)
 with new infra
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
> ---
>  gdbstub.c | 90 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 50 insertions(+), 40 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index d5e0f3878a..621d689868 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1418,11 +1418,6 @@ static inline int startswith(const char *string, c=
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
> @@ -1468,6 +1463,41 @@ static int process_string_cmd(GDBState *s, void *u=
ser_ctx, const char *data,
>      return -1;
>  }
>
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
> @@ -1482,6 +1512,7 @@ static int gdb_handle_packet(GDBState *s, const cha=
r *line_buf)
>      uint8_t *registers;
>      target_ulong addr, len;
>      GDBThreadIdKind thread_kind;
> +    const GdbCmdParseEntry *cmd_parser =3D NULL;
>
>      trace_gdbstub_io_command(line_buf);
>
> @@ -1582,42 +1613,15 @@ static int gdb_handle_packet(GDBState *s, const c=
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
> @@ -1990,6 +1994,12 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
>          put_packet(s, buf);
>          break;
>      }
> +
> +    if (cmd_parser &&
> +        process_string_cmd(s, NULL, line_buf, cmd_parser, 1)) {
> +        put_packet(s, "");

Why this null put_packet at the end? You've passed the handling of the
OK reply back to your handler so this seems superfluous.

--
Alex Benn=C3=A9e

