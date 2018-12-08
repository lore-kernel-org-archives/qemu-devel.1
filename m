Received: from eggs.gnu.org ([2001:4830:134:3::10]:42972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gVQuz-0002Qc-72
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gVQuy-0004f5-0w
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:56:29 -0500
MIME-Version: 1.0
References: <20181207090135.7651-1-luc.michel@greensocs.com>
	<20181207090135.7651-5-luc.michel@greensocs.com>
In-Reply-To: <20181207090135.7651-5-luc.michel@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 7 Dec 2018 16:55:58 -0800
Message-ID: <CAKmqyKNgS2qr-BFsU7qP0LQ+jieWG_QaCvFpFBgOJyvP+dNamg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 04/16] gdbstub: add multiprocess support
 to 'H' and 'T' packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Fri, Dec 7, 2018 at 1:02 AM Luc Michel <luc.michel@greensocs.com> wrote:
>
> Add a couple of helper functions to cope with GDB threads and processes.
>
> The gdb_get_process() function looks for a process given a pid.
>
> The gdb_get_cpu() function returns the CPU corresponding to the (pid,
> tid) pair given as parameters.
>
> The read_thread_id() function parses the thread-id sent by the peer.
> This function supports the multiprocess extension thread-id syntax.  The
> return value specifies if the parsing failed, or if a special case was
> encountered (all processes or all threads).
>
> Use them in 'H' and 'T' packets handling to support the multiprocess
> extension.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  gdbstub.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 136 insertions(+), 18 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 07508c2e6b..911faa225a 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -685,10 +685,75 @@ out:
>      /* TODO: In user mode, we should use the task state PID */
>      return s->processes[s->process_num - 1].pid;
>  #endif
>  }
>
> +static GDBProcess *gdb_get_process(const GDBState *s, uint32_t pid)
> +{
> +    int i;
> +
> +    if (!pid) {
> +        /* 0 means any process, we take the first one */
> +        return &s->processes[0];
> +    }
> +
> +    for (i =3D 0; i < s->process_num; i++) {
> +        if (s->processes[i].pid =3D=3D pid) {
> +            return &s->processes[i];
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +static GDBProcess *gdb_get_cpu_process(const GDBState *s, CPUState *cpu)
> +{
> +    return gdb_get_process(s, gdb_get_cpu_pid(s, cpu));
> +}
> +
> +static CPUState *find_cpu(uint32_t thread_id)
> +{
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        if (cpu_gdb_index(cpu) =3D=3D thread_id) {
> +            return cpu;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_t t=
id)
> +{
> +    GDBProcess *process;
> +    CPUState *cpu;
> +
> +    if (!tid) {
> +        /* 0 means any thread, we take the first one */
> +        tid =3D 1;
> +    }
> +
> +    cpu =3D find_cpu(tid);
> +
> +    if (cpu =3D=3D NULL) {
> +        return NULL;
> +    }
> +
> +    process =3D gdb_get_cpu_process(s, cpu);
> +
> +    if (process->pid !=3D pid) {
> +        return NULL;
> +    }
> +
> +    if (!process->attached) {
> +        return NULL;
> +    }
> +
> +    return cpu;
> +}
> +
>  static const char *get_feature_xml(const char *p, const char **newp,
>                                     CPUClass *cc)
>  {
>      size_t len;
>      int i;
> @@ -941,23 +1006,10 @@ static void gdb_set_cpu_pc(GDBState *s, target_ulo=
ng pc)
>
>      cpu_synchronize_state(cpu);
>      cpu_set_pc(cpu, pc);
>  }
>
> -static CPUState *find_cpu(uint32_t thread_id)
> -{
> -    CPUState *cpu;
> -
> -    CPU_FOREACH(cpu) {
> -        if (cpu_gdb_index(cpu) =3D=3D thread_id) {
> -            return cpu;
> -        }
> -    }
> -
> -    return NULL;
> -}
> -
>  static char *gdb_fmt_thread_id(const GDBState *s, CPUState *cpu,
>                             char *buf, size_t buf_size)
>  {
>      if (s->multiprocess) {
>          snprintf(buf, buf_size, "p%02x.%02x",
> @@ -967,10 +1019,64 @@ static char *gdb_fmt_thread_id(const GDBState *s, =
CPUState *cpu,
>      }
>
>      return buf;
>  }
>
> +typedef enum GDBThreadIdKind {
> +    GDB_ONE_THREAD =3D 0,
> +    GDB_ALL_THREADS,     /* One process, all threads */
> +    GDB_ALL_PROCESSES,
> +    GDB_READ_THREAD_ERR
> +} GDBThreadIdKind;
> +
> +static GDBThreadIdKind read_thread_id(const char *buf, const char **end_=
buf,
> +                                      uint32_t *pid, uint32_t *tid)
> +{
> +    unsigned long p, t;
> +    int ret;
> +
> +    if (*buf =3D=3D 'p') {
> +        buf++;
> +        ret =3D qemu_strtoul(buf, &buf, 16, &p);
> +
> +        if (ret) {
> +            return GDB_READ_THREAD_ERR;
> +        }
> +
> +        /* Skip '.' */
> +        buf++;
> +    } else {
> +        p =3D 1;
> +    }
> +
> +    ret =3D qemu_strtoul(buf, &buf, 16, &t);
> +
> +    if (ret) {
> +        return GDB_READ_THREAD_ERR;
> +    }
> +
> +    *end_buf =3D buf;
> +
> +    if (p =3D=3D -1) {
> +        return GDB_ALL_PROCESSES;
> +    }
> +
> +    if (pid) {
> +        *pid =3D p;
> +    }
> +
> +    if (t =3D=3D -1) {
> +        return GDB_ALL_THREADS;
> +    }
> +
> +    if (tid) {
> +        *tid =3D t;
> +    }
> +
> +    return GDB_ONE_THREAD;
> +}
> +
>  static int is_query_packet(const char *p, const char *query, char separa=
tor)
>  {
>      unsigned int query_len =3D strlen(query);
>
>      return strncmp(p, query, query_len) =3D=3D 0 &&
> @@ -1075,16 +1181,18 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>  {
>      CPUState *cpu;
>      CPUClass *cc;
>      const char *p;
>      uint32_t thread;
> +    uint32_t pid, tid;
>      int ch, reg_size, type, res;
>      uint8_t mem_buf[MAX_PACKET_LENGTH];
>      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>      char thread_id[16];
>      uint8_t *registers;
>      target_ulong addr, len;
> +    GDBThreadIdKind thread_kind;
>
>      trace_gdbstub_io_command(line_buf);
>
>      p =3D line_buf;
>      ch =3D *p++;
> @@ -1288,16 +1396,22 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          else
>              put_packet(s, "E22");
>          break;
>      case 'H':
>          type =3D *p++;
> -        thread =3D strtoull(p, (char **)&p, 16);
> -        if (thread =3D=3D -1 || thread =3D=3D 0) {
> +
> +        thread_kind =3D read_thread_id(p, &p, &pid, &tid);
> +        if (thread_kind =3D=3D GDB_READ_THREAD_ERR) {
> +            put_packet(s, "E22");
> +            break;
> +        }
> +
> +        if (thread_kind !=3D GDB_ONE_THREAD) {
>              put_packet(s, "OK");
>              break;
>          }
> -        cpu =3D find_cpu(thread);
> +        cpu =3D gdb_get_cpu(s, pid, tid);
>          if (cpu =3D=3D NULL) {
>              put_packet(s, "E22");
>              break;
>          }
>          switch (type) {
> @@ -1313,12 +1427,16 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>               put_packet(s, "E22");
>               break;
>          }
>          break;
>      case 'T':
> -        thread =3D strtoull(p, (char **)&p, 16);
> -        cpu =3D find_cpu(thread);
> +        thread_kind =3D read_thread_id(p, &p, &pid, &tid);
> +        if (thread_kind =3D=3D GDB_READ_THREAD_ERR) {
> +            put_packet(s, "E22");
> +            break;
> +        }
> +        cpu =3D gdb_get_cpu(s, pid, tid);
>
>          if (cpu !=3D NULL) {
>              put_packet(s, "OK");
>          } else {
>              put_packet(s, "E22");
> --
> 2.19.2
>
>
