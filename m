Received: from eggs.gnu.org ([2001:4830:134:3::10]:36283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d31lj-0005mm-CE
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d31li-0002lt-BD
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:48:43 -0400
Date: Tue, 25 Apr 2017 16:48:30 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170425144830.3gesewid2vwkyqix@kamzik.brq.redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490189568-167621-6-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 05/23] numa: move source of
 default CPUs to NUMA node mapping into boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, Mar 22, 2017 at 02:32:30PM +0100, Igor Mammedov wrote:
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0cbcbc1..8748d25 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1554,6 +1554,16 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
>      }
>  }
>  
> +static CpuInstanceProperties
> +virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
> +
> +    assert(cpu_index < possible_cpus->len);
> +    return possible_cpus->cpus[cpu_index].props;;
> +}
> +
>  static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>  {
>      int n;
> @@ -1573,8 +1583,12 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>          ms->possible_cpus->cpus[n].props.has_thread_id = true;
>          ms->possible_cpus->cpus[n].props.thread_id = n;
>  
> -        /* TODO: add 'has_node/node' here to describe
> -           to which node core belongs */
> +        /* default distribution of CPUs over NUMA nodes */
> +        if (nb_numa_nodes) {
> +            /* preset values but do not enable them i.e. 'has_node_id = false',
> +             * board will enable them if manual mapping wasn't present on CLI */
> +            ms->possible_cpus->cpus[n].props.node_id = n % nb_numa_nodes;;

extra ;

drew
