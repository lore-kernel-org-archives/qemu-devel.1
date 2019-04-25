Received: from eggs.gnu.org ([209.51.188.92]:56116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfii-0004xi-Nr
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfih-0000XP-8d
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:51:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJfif-0000Sn-Sa
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:51:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id a9so13145672wrp.6
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:51:24 -0700 (PDT)
References: <20190424142714.28460-1-arilou@gmail.com>
	<20190424142714.28460-4-arilou@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190424142714.28460-4-arilou@gmail.com>
Date: Thu, 25 Apr 2019 15:51:21 +0100
Message-ID: <87tvemuoie.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/20] gdbstub: Implement continue (c
 pkt) with new infra
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
> Signed-off-by: Jon Doron <arilou@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 435b492b4f..a6d5acd6f0 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1538,6 +1538,16 @@ static void handle_thread_alive(GdbCmdContext *gdb=
_ctx, void *user_ctx)
>      put_packet(gdb_ctx->s, "OK");
>  }
>
> +static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    if (gdb_ctx->num_params) {
> +        gdb_set_cpu_pc(gdb_ctx->s, gdb_ctx->params[0].val_ull);
> +    }
> +
> +    gdb_ctx->s->signal =3D 0;
> +    gdb_continue(gdb_ctx->s);
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1573,13 +1583,16 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          gdb_breakpoint_remove_all();
>          break;
>      case 'c':
> -        if (*p !=3D '\0') {
> -            addr =3D strtoull(p, (char **)&p, 16);
> -            gdb_set_cpu_pc(s, addr);
> +        {
> +            static GdbCmdParseEntry continue_cmd_desc =3D {
> +                .handler =3D handle_continue,
> +                .cmd =3D "c",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "L0"
> +            };
> +            process_string_cmd(s, NULL, line_buf, &continue_cmd_desc, 1);
>          }
> -        s->signal =3D 0;
> -        gdb_continue(s);
> -        return RS_IDLE;
> +        break;
>      case 'C':
>          s->signal =3D gdb_signal_to_target (strtoul(p, (char **)&p, 16));
>          if (s->signal =3D=3D -1)


--
Alex Benn=C3=A9e
