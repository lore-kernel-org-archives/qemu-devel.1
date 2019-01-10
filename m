Received: from eggs.gnu.org ([209.51.188.92]:54462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ghcDW-00018R-QU
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ghcDV-0004ho-UX
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:25:58 -0500
References: <20190108163008.7006-1-peter.maydell@linaro.org>
	<20190108163008.7006-5-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <ff365022-d3da-adc9-efcd-b8d013835b44@greensocs.com>
Date: Thu, 10 Jan 2019 16:15:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190108163008.7006-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] gdbstub: Simplify gdb_get_cpu_pid() to
 use cpu->cluster_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>, "Emilio G . Cota" <cota@braap.org>, patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 1/8/19 5:30 PM, Peter Maydell wrote:
> Now we're keeping the cluster index in the CPUState, we don't
> need to jump through hoops in gdb_get_cpu_pid() to find the
> associated cluster object.
Aah better :-)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
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
> 
