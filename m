Received: from eggs.gnu.org ([2001:4830:134:3::10]:54569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gI0Dg-000467-9i
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 19:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gI0Df-0006z7-9D
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 19:48:16 -0400
References: <20181026081653.24602-1-luc.michel@greensocs.com>
	<20181026081653.24602-4-luc.michel@greensocs.com>
From: Alistair <alistair23@gmail.com>
Message-ID: <3b5854a8-66d5-a8ea-4f60-8e2534d5e0d5@gmail.com>
Date: Wed, 31 Oct 2018 16:48:04 -0700
MIME-Version: 1.0
In-Reply-To: <20181026081653.24602-4-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/16] gdbstub: add multiprocess support
 to '?' packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

On 10/26/18 1:16 AM, Luc Michel wrote:
> The gdb_get_cpu_pid() function does the PID lookup for the given CPU. It
> checks if the CPU is a direct child of a CPU cluster. If it is, the
> returned PID is the cluster ID plus one (cluster IDs start at 0, GDB
> PIDs at 1). When the CPU is not a child of such a container, the PID of
> the first process is returned.
> 
> The gdb_fmt_thread_id() function generates the string to be used to identify
> a given thread, in a response packet for the peer. This function
> supports generating thread IDs when multiprocess mode is enabled (in the
> form `p<pid>.<tid>').
> 
> Use them in the reply to a '?' request.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>   gdbstub.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 096ac8e99c..9ca743a4c6 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -638,10 +638,49 @@ static int memtox(char *buf, const char *mem, int len)
>           }
>       }
>       return p - buf;
>   }
>   
> +static uint32_t gdb_get_cpu_pid(const GDBState *s, CPUState *cpu)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    gchar *path, *name;
> +    Object *obj;
> +    CPUClusterState *cluster;
> +    uint32_t ret;
> +
> +    path = object_get_canonical_path(OBJECT(cpu));
> +    name = object_get_canonical_path_component(OBJECT(cpu));
> +
> +    if (path == NULL) {
> +        ret = s->processes[0].pid;
> +        goto out;
> +    }
> +
> +    path[strlen(path) - strlen(name) - 1] = '\0';

Can you add a comment here of what you are doing and why you are 
removing the name?

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +
> +    obj = object_resolve_path_type(path, TYPE_CPU_CLUSTER, NULL);
> +
> +    if (obj == NULL) {
> +        ret = s->processes[0].pid;
> +        goto out;
> +    }
> +
> +    cluster = CPU_CLUSTER(obj);
> +    ret = cluster->cluster_id + 1;
> +
> +out:
> +    g_free(name);
> +    g_free(path);
> +
> +    return ret;
> +
> +#else
> +    return s->processes[0].pid;
> +#endif
> +}
> +
>   static const char *get_feature_xml(const char *p, const char **newp,
>                                      CPUClass *cc)
>   {
>       size_t len;
>       int i;
> @@ -907,10 +946,23 @@ static CPUState *find_cpu(uint32_t thread_id)
>       }
>   
>       return NULL;
>   }
>   
> +static char *gdb_fmt_thread_id(const GDBState *s, CPUState *cpu,
> +                           char *buf, size_t buf_size)
> +{
> +    if (s->multiprocess) {
> +        snprintf(buf, buf_size, "p%02x.%02x",
> +                 gdb_get_cpu_pid(s, cpu), cpu_gdb_index(cpu));
> +    } else {
> +        snprintf(buf, buf_size, "%02x", cpu_gdb_index(cpu));
> +    }
> +
> +    return buf;
> +}
> +
>   static int is_query_packet(const char *p, const char *query, char separator)
>   {
>       unsigned int query_len = strlen(query);
>   
>       return strncmp(p, query, query_len) == 0 &&
> @@ -1018,22 +1070,23 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>       const char *p;
>       uint32_t thread;
>       int ch, reg_size, type, res;
>       uint8_t mem_buf[MAX_PACKET_LENGTH];
>       char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
> +    char thread_id[16];
>       uint8_t *registers;
>       target_ulong addr, len;
>   
>       trace_gdbstub_io_command(line_buf);
>   
>       p = line_buf;
>       ch = *p++;
>       switch(ch) {
>       case '?':
>           /* TODO: Make this return the correct value for user-mode.  */
> -        snprintf(buf, sizeof(buf), "T%02xthread:%02x;", GDB_SIGNAL_TRAP,
> -                 cpu_gdb_index(s->c_cpu));
> +        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
> +                 gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread_id)));
>           put_packet(s, buf);
>           /* Remove all the breakpoints when this query is issued,
>            * because gdb is doing and initial connect and the state
>            * should be cleaned up.
>            */
> 
