Received: from eggs.gnu.org ([2001:4830:134:3::10]:57648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gSg9U-0005CZ-JJ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gSg9O-0000Ta-Io
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:36:04 -0500
Date: Fri, 30 Nov 2018 11:35:03 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181130103503.GI20151@toto>
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-8-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181123091729.29921-8-luc.michel@greensocs.com>
Subject: Re: [Qemu-devel] [PATCH v7 07/16] gdbstub: add multiprocess support
 to (f|s)ThreadInfo and ThreadExtraInfo
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

On Fri, Nov 23, 2018 at 10:17:20AM +0100, Luc Michel wrote:
> Change the thread info related packets handling to support multiprocess
> extension.
>=20
> Add the CPUs class name in the extra info to help differentiate
> them in multiprocess mode.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


>=20
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  gdbstub.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index 728efdabee..12d4e33c40 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1262,11 +1262,10 @@ out:
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
>      CPUClass *cc;
>      const char *p;
> -    uint32_t thread;
>      uint32_t pid, tid;
>      int ch, reg_size, type, res;
>      uint8_t mem_buf[MAX_PACKET_LENGTH];
>      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>      char thread_id[16];
> @@ -1558,30 +1557,48 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>              snprintf(buf, sizeof(buf), "QC%s",
>                       gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_=
id)));
>              put_packet(s, buf);
>              break;
>          } else if (strcmp(p,"fThreadInfo") =3D=3D 0) {
> -            s->query_cpu =3D first_cpu;
> +            s->query_cpu =3D gdb_first_attached_cpu(s);
>              goto report_cpuinfo;
>          } else if (strcmp(p,"sThreadInfo") =3D=3D 0) {
>          report_cpuinfo:
>              if (s->query_cpu) {
> -                snprintf(buf, sizeof(buf), "m%x", cpu_gdb_index(s->query=
_cpu));
> +                snprintf(buf, sizeof(buf), "m%s",
> +                         gdb_fmt_thread_id(s, s->query_cpu,
> +                                       thread_id, sizeof(thread_id)));
>                  put_packet(s, buf);
> -                s->query_cpu =3D CPU_NEXT(s->query_cpu);
> +                s->query_cpu =3D gdb_next_attached_cpu(s, s->query_cpu);
>              } else
>                  put_packet(s, "l");
>              break;
>          } else if (strncmp(p,"ThreadExtraInfo,", 16) =3D=3D 0) {
> -            thread =3D strtoull(p+16, (char **)&p, 16);
> -            cpu =3D find_cpu(thread);
> +            if (read_thread_id(p + 16, &p, &pid, &tid) =3D=3D GDB_READ_T=
HREAD_ERR) {
> +                put_packet(s, "E22");
> +                break;
> +            }
> +            cpu =3D gdb_get_cpu(s, pid, tid);
>              if (cpu !=3D NULL) {
>                  cpu_synchronize_state(cpu);
> -                /* memtohex() doubles the required space */
> -                len =3D snprintf((char *)mem_buf, sizeof(buf) / 2,
> -                               "CPU#%d [%s]", cpu->cpu_index,
> -                               cpu->halted ? "halted " : "running");
> +
> +                if (s->multiprocess && (s->process_num > 1)) {
> +                    /* Print the CPU model and name in multiprocess mode=
 */
> +                    ObjectClass *oc =3D object_get_class(OBJECT(cpu));
> +                    const char *cpu_model =3D object_class_get_name(oc);
> +                    char *cpu_name =3D
> +                        object_get_canonical_path_component(OBJECT(cpu))=
;
> +                    len =3D snprintf((char *)mem_buf, sizeof(buf) / 2,
> +                                   "%s %s [%s]", cpu_model, cpu_name,
> +                                   cpu->halted ? "halted " : "running");
> +                    g_free(cpu_name);
> +                } else {
> +                    /* memtohex() doubles the required space */
> +                    len =3D snprintf((char *)mem_buf, sizeof(buf) / 2,
> +                                   "CPU#%d [%s]", cpu->cpu_index,
> +                                   cpu->halted ? "halted " : "running");
> +                }
>                  trace_gdbstub_op_extra_info((char *)mem_buf);
>                  memtohex(buf, mem_buf, len);
>                  put_packet(s, buf);
>              }
>              break;
> --=20
> 2.19.1
>=20
