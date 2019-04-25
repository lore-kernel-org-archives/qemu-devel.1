Received: from eggs.gnu.org ([209.51.188.92]:54863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfdp-0003LO-NT
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfdk-0004ct-4f
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:46:21 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJfdi-0004bM-0N
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:46:18 -0400
Received: by mail-wm1-x342.google.com with SMTP id y197so11002857wmd.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:46:17 -0700 (PDT)
References: <20190424142714.28460-1-arilou@gmail.com>
	<20190424142714.28460-2-arilou@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190424142714.28460-2-arilou@gmail.com>
Date: Thu, 25 Apr 2019 15:46:14 +0100
Message-ID: <87v9z2uoqx.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/20] gdbstub: Implement deatch (D pkt)
 with new infra
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jon Doron <arilou@gmail.com>


arilou@gmail.com writes:

> From: Jon Doron <arilou@gmail.com>
>
> Signed-otff-by: Jon Doron <arilou@gmail.com>

mini typo...

(btw you can either create a editor shortcut for adding s-o-b tags or
use --signoff while re-basing)

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub.c | 82 +++++++++++++++++++++++++++++--------------------------
>  1 file changed, 43 insertions(+), 39 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index b5bd01b913..34e6722a8c 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1435,10 +1435,6 @@ static inline int startswith(const char *string, c=
onst char *pattern)
>    return !strncmp(string, pattern, strlen(pattern));
>  }
>
> -__attribute__((unused)) static int process_string_cmd(
> -        GDBState *s, void *user_ctx, const char *data,
> -        GdbCmdParseEntry *cmds, int num_cmds);
> -
>  static int process_string_cmd(GDBState *s, void *user_ctx, const char *d=
ata,
>                                GdbCmdParseEntry *cmds, int num_cmds)
>  {
> @@ -1483,6 +1479,41 @@ static int process_string_cmd(GDBState *s, void *u=
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
> @@ -1597,42 +1628,15 @@ static int gdb_handle_packet(GDBState *s, const c=
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
> +            static GdbCmdParseEntry deatch_cmd_desc =3D {
> +                .handler =3D handle_detach,
> +                .cmd =3D "D",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "?.l0"
> +            };
> +            process_string_cmd(s, NULL, line_buf, &deatch_cmd_desc, 1);
>          }
> -        put_packet(s, "OK");
>          break;
>      case 's':
>          if (*p !=3D '\0') {


--
Alex Benn=C3=A9e
