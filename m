Received: from eggs.gnu.org ([2001:4830:134:3::10]:54334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fxLH1-0006EA-0s
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fxLGz-0000gA-V5
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:02:18 -0400
MIME-Version: 1.0
In-Reply-To: <20180901124639.19735-3-luc.michel@greensocs.com>
References: <20180901124639.19735-1-luc.michel@greensocs.com>
	<20180901124639.19735-3-luc.michel@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Sep 2018 17:01:45 -0700
Message-ID: <CAKmqyKPdwm4TPXCaigh6wH+EH0beaQfMFA9Qi_fdECK0w1ss3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/15] gdbstub: add multiprocess support to
 '?' packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Sat, Sep 1, 2018 at 5:46 AM, Luc Michel <luc.michel@greensocs.com> wrote:
> The gdb_get_cpu_pid() function does the PID lookup for the given CPU. It
> checks if the CPU is in a QOM container named after the
> GDB_CPU_GROUP_NAME macro. If found, it returns the correponding PID,
> which is the group ID plus one (group IDs start at 0, GDB PIDs at 1).
> When the CPU is not a child of such a container, PID 1 is returned.
>
> The get_thread_id() function generates the string to be used to identify
> a given thread, in a response packet for the peer. This function
> supports generating thread IDs when multiprocess mode is enabled (in the
> form `p<pid>.<tid>').
>
> Use it in the reply to a '?' request.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  gdbstub.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 5c86218f49..ec3105dbc1 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -640,10 +640,37 @@ static int memtox(char *buf, const char *mem, int len)
>          }
>      }
>      return p - buf;
>  }
>
> +static uint32_t gdb_get_cpu_pid(const GDBState *s, CPUState *cpu)
> +{
> +    gchar *path;
> +    gchar *cont;
> +    const char *left;
> +    unsigned long pid;
> +
> +    if (!s->multiprocess || (s->process_num == 1)) {
> +        return 1;
> +    }
> +
> +    path = object_get_canonical_path(OBJECT(cpu));
> +    cont = g_strrstr(path, "/" GDB_CPU_GROUP_NAME "[");
> +
> +    if (cont == NULL) {
> +        return 1;
> +    }
> +
> +    cont += strlen("/" GDB_CPU_GROUP_NAME "[");
> +
> +    if (qemu_strtoul(cont, &left, 10, &pid)) {
> +        return 1;
> +    }
> +
> +    return pid + 1;
> +}
> +
>  static const char *get_feature_xml(const char *p, const char **newp,
>                                     CPUClass *cc)
>  {
>      size_t len;
>      int i;
> @@ -909,10 +936,24 @@ static CPUState *find_cpu(uint32_t thread_id)
>      }
>
>      return NULL;
>  }
>
> +static char *get_thread_id(const GDBState *s, CPUState *cpu,
> +                           char *buf, size_t buf_size)
> +{
> +    if (s->multiprocess) {
> +        snprintf(buf, buf_size, "p%02x.%02x",
> +                 gdb_get_cpu_pid(s, cpu), cpu_gdb_index(cpu));
> +    } else {
> +        snprintf(buf, buf_size, "%02x", cpu_gdb_index(cpu));
> +
> +    }
> +
> +    return buf;
> +}
> +
>  static int is_query_packet(const char *p, const char *query, char separator)
>  {
>      unsigned int query_len = strlen(query);
>
>      return strncmp(p, query, query_len) == 0 &&
> @@ -1020,22 +1061,23 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>      const char *p;
>      uint32_t thread;
>      int ch, reg_size, type, res;
>      uint8_t mem_buf[MAX_PACKET_LENGTH];
>      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
> +    char thread_id[16];
>      uint8_t *registers;
>      target_ulong addr, len;
>
>      trace_gdbstub_io_command(line_buf);
>
>      p = line_buf;
>      ch = *p++;
>      switch(ch) {
>      case '?':
>          /* TODO: Make this return the correct value for user-mode.  */
> -        snprintf(buf, sizeof(buf), "T%02xthread:%02x;", GDB_SIGNAL_TRAP,
> -                 cpu_gdb_index(s->c_cpu));
> +        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
> +                 get_thread_id(s, s->c_cpu, thread_id, sizeof(thread_id)));
>          put_packet(s, buf);
>          /* Remove all the breakpoints when this query is issued,
>           * because gdb is doing and initial connect and the state
>           * should be cleaned up.
>           */
> --
> 2.18.0
>
>
