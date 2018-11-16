Received: from eggs.gnu.org ([2001:4830:134:3::10]:42646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gNat8-0006Vz-TV
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gNat8-0002dK-1x
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:58:10 -0500
Date: Fri, 16 Nov 2018 10:57:45 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181116095745.GP7447@toto>
References: <20181115094207.22846-1-luc.michel@greensocs.com>
	<20181115094207.22846-7-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181115094207.22846-7-luc.michel@greensocs.com>
Subject: Re: [Qemu-devel] [PATCH v6 06/16] gdbstub: add multiprocess support
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
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, mark.burton@greensocs.com, Eduardo Habkost <ehabkost@redhat.com>

On Thu, Nov 15, 2018 at 10:41:57AM +0100, Luc Michel wrote:
> Change the sC packet handling to support the multiprocess extension.
> Instead of returning the first thread, we return the first thread of the
> current process.
>=20
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  gdbstub.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index f1ec3481cb..d19b0137e8 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1546,13 +1546,18 @@ static int gdb_handle_packet(GDBState *s, const c=
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
> --=20
> 2.19.1
>=20
