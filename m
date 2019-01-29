Received: from eggs.gnu.org ([209.51.188.92]:51759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1goLRu-0000RM-Nq
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 23:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1goLRn-0000tH-Ck
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 23:56:35 -0500
MIME-Version: 1.0
References: <20181207090135.7651-1-luc.michel@greensocs.com>
	<20181207090135.7651-8-luc.michel@greensocs.com>
In-Reply-To: <20181207090135.7651-8-luc.michel@greensocs.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 28 Jan 2019 20:56:09 -0800
Message-ID: <CAMo8Bf+siB=vdjK+WPKvRCqKS59OVGOcAoH0HtN6VSvFyOc9gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 07/16] gdbstub: add multiprocess support
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, saipava@xilinx.com, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

Hello,

On Fri, Dec 7, 2018 at 1:04 AM Luc Michel <luc.michel@greensocs.com> wrote:
>
> Change the thread info related packets handling to support multiprocess
> extension.
>
> Add the CPUs class name in the extra info to help differentiate
> them in multiprocess mode.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  gdbstub.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)

Starting with this commit it is no longer possible to kill QEMU
with the 'kill' command from the gdb. This was a nice feature,
was this removal intentional, or is it just an implementation
bug?

> diff --git a/gdbstub.c b/gdbstub.c
> index bea0215f30..770915446a 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1267,11 +1267,10 @@ out:
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
> @@ -1563,30 +1562,48 @@ static int gdb_handle_packet(GDBState *s, const c=
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
> --
> 2.19.2
>
>


--=20
Thanks.
-- Max
