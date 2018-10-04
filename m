Received: from eggs.gnu.org ([2001:4830:134:3::10]:55291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g87Vq-0001ZD-5C
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g87Vp-0001lz-7U
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:34:10 -0400
MIME-Version: 1.0
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-6-luc.michel@greensocs.com>
In-Reply-To: <20181001115704.701-6-luc.michel@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 4 Oct 2018 10:33:40 -0700
Message-ID: <CAKmqyKPbBMWvpGm1L6nCPDpHqB2hW_iHfuXO7HjVRdWPD5tuGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/15] gdbstub: add multiprocess support
 to 'sC' packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Mon, Oct 1, 2018 at 4:57 AM Luc Michel <luc.michel@greensocs.com> wrote:
>
> Change the sC packet handling to support the multiprocess extension.
> Instead of returning the first thread, we return the first thread of the
> current process.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  gdbstub.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 779cc8b241..3242f0d261 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1530,13 +1530,18 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>              type =3D strtoul(p, (char **)&p, 16);
>              sstep_flags =3D type;
>              put_packet(s, "OK");
>              break;
>          } else if (strcmp(p,"C") =3D=3D 0) {
> -            /* "Current thread" remains vague in the spec, so always ret=
urn
> -             *  the first CPU (gdb returns the first thread). */
> -            put_packet(s, "QC1");
> +            /* "Current thread" remains vague in the spec, so always ret=
urn the
> +             * first thread of the current process (gdb returns the firs=
t
> +             * thread).
> +             */
> +            cpu =3D get_first_cpu_in_process(s, gdb_get_cpu_process(s, s=
->g_cpu));
> +            snprintf(buf, sizeof(buf), "QC%s",
> +                     gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_=
id)));
> +            put_packet(s, buf);
>              break;
>          } else if (strcmp(p,"fThreadInfo") =3D=3D 0) {
>              s->query_cpu =3D first_cpu;
>              goto report_cpuinfo;
>          } else if (strcmp(p,"sThreadInfo") =3D=3D 0) {
> --
> 2.19.0
>
>
