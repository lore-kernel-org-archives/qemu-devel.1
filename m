Received: from eggs.gnu.org ([2001:4830:134:3::10]:44875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dGqBp-0006Nt-1m
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 13:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dGqBo-0007L6-7Y
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 13:16:45 -0400
Date: Fri, 2 Jun 2017 14:16:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170602171636.GF4294@thinpad.lan.raisama.net>
References: <20170531133201.GS32274@thinpad.lan.raisama.net>
	<1496314408-163972-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496314408-163972-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 7/7] numa: cpu: calculate/set default
 node-ids after all -numa CLI options are parsed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

On Thu, Jun 01, 2017 at 12:53:28PM +0200, Igor Mammedov wrote:
> Calculating default node-ids for CPUs in possible_cpu_arch_ids()
> is rather fragile since defaults calculation uses nb_numa_nodes but
> callback might be potentially called early before all -numa CLI
> options are parsed, which would lead to cpus assigned only upto
> nb_numa_nodes at the time possible_cpu_arch_ids() is called.
> 
> Issue was introduced by
> (7c88e65 numa: mirror cpu to node mapping in MachineState::possible_cpus)
> and for example CLI:
>   -smp 4 -numa node,cpus=0 -numa node
> would set props.node-id in possible_cpus array for every non
> explicitly mapped CPU to the first node.
> 
> Issue is not visible to guest nor to mgmt interface due to
>   1) implictly mapped cpus are forced to the first node in
>      case of partial mapping
>   2) in case of default mapping possible_cpu_arch_ids() is
>      called after all -numa options are parsed (resulting
>      in correct mapping).
> 
> However it's fragile to rely on late execution of
> possible_cpu_arch_ids(), therefore add machine specific
> callback that returns node-id for CPU and use it to calculate/
> set defaults at machine_numa_finish_init() time when all -numa
> options are parsed.
> 
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queued on numa-next.  Thanks!

-- 
Eduardo
