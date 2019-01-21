Received: from eggs.gnu.org ([209.51.188.92]:57329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1glg98-0005lR-Cn
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1glg96-00047i-JR
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:26:14 -0500
Date: Mon, 21 Jan 2019 12:25:36 -0800
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20190121202536.GC21062@toto>
References: <20190121152218.9592-1-peter.maydell@linaro.org>
	<20190121152218.9592-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121152218.9592-5-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 4/4] gdbstub: Simplify gdb_get_cpu_pid()
 to use cpu->cluster_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Emilio G . Cota" <cota@braap.org>, Aleksandar Markovic <aleksandar.m.mail@gmail.com>

On Mon, Jan 21, 2019 at 03:22:18PM +0000, Peter Maydell wrote:
> Now we're keeping the cluster index in the CPUState, we don't
> need to jump through hoops in gdb_get_cpu_pid() to find the
> associated cluster object.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Luc Michel <luc.michel@greensocs.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  gdbstub.c | 48 +++++-------------------------------------------
>  1 file changed, 5 insertions(+), 43 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index bfc7afb5096..5d6cbea9d35 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -644,50 +644,12 @@ static int memtox(char *buf, const char *mem, int len)
>  
>  static uint32_t gdb_get_cpu_pid(const GDBState *s, CPUState *cpu)
>  {
> -#ifndef CONFIG_USER_ONLY
> -    gchar *path, *name = NULL;
> -    Object *obj;
> -    CPUClusterState *cluster;
> -    uint32_t ret;
> -
> -    path = object_get_canonical_path(OBJECT(cpu));
> -
> -    if (path == NULL) {
> -        /* Return the default process' PID */
> -        ret = s->processes[s->process_num - 1].pid;
> -        goto out;
> -    }
> -
> -    name = object_get_canonical_path_component(OBJECT(cpu));
> -    assert(name != NULL);
> -
> -    /*
> -     * Retrieve the CPU parent path by removing the last '/' and the CPU name
> -     * from the CPU canonical path.
> -     */
> -    path[strlen(path) - strlen(name) - 1] = '\0';
> -
> -    obj = object_resolve_path_type(path, TYPE_CPU_CLUSTER, NULL);
> -
> -    if (obj == NULL) {
> -        /* Return the default process' PID */
> -        ret = s->processes[s->process_num - 1].pid;
> -        goto out;
> -    }
> -
> -    cluster = CPU_CLUSTER(obj);
> -    ret = cluster->cluster_id + 1;
> -
> -out:
> -    g_free(name);
> -    g_free(path);
> -
> -    return ret;
> -
> -#else
>      /* TODO: In user mode, we should use the task state PID */
> -    return s->processes[s->process_num - 1].pid;
> -#endif
> +    if (cpu->cluster_index == UNASSIGNED_CLUSTER_INDEX) {
> +        /* Return the default process' PID */
> +        return s->processes[s->process_num - 1].pid;
> +    }
> +    return cpu->cluster_index + 1;
>  }
>  
>  static GDBProcess *gdb_get_process(const GDBState *s, uint32_t pid)
> -- 
> 2.20.1
> 
