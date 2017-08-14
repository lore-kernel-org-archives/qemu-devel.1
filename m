Received: from eggs.gnu.org ([2001:4830:134:3::10]:47023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhEjj-0004Qb-Pu
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhEjf-0000eQ-95
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhEjf-0000dz-2k
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:44:47 -0400
Date: Mon, 14 Aug 2017 09:44:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170814124439.GM3108@localhost.localdomain>
References: <1502705471-28407-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502705471-28407-1-git-send-email-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH] numa: Add a check whether the node0 has
 memory or not
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, dgilbert@redhat.com, armbru@redhat.com, david@redhat.com

On Mon, Aug 14, 2017 at 06:11:11PM +0800, Dou Liyang wrote:
> Currently, Using the fisrt node without memory on the machine makes
> QEMU unhappy. With this example command line:
>   ... \
>   -m 1024M,slots=4,maxmem=32G \
>   -numa node,nodeid=0 \
>   -numa node,mem=1024M,nodeid=1 \
>   -numa node,nodeid=2 \
>   -numa node,nodeid=3 \
> Guest reports "No NUMA configuration found" and the NUMA topology is
> wrong.
> 
> This is because when QEMU builds ACPI SRAT, it regards node0 as the
> default node to deal with the memory hole(640K-1M). this means the
> node0 must have some memory(>1M) firstly.
> 
> Add a check in parse_numa_opts to avoid this situation.
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  numa.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/numa.c b/numa.c
> index e32af04..1d6f73f 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -464,6 +464,10 @@ void parse_numa_opts(MachineState *ms)
>          if (i == nb_numa_nodes) {
>              assert(mc->numa_auto_assign_ram);
>              mc->numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram_size);
> +        } else if (i != 0) {
> +            error_report("The first NUMA node must have some memory"
> +                          " for building ACPI SART");
> +            exit(1);

This doesn't belong to numa.c.  numa.c is generic code, and the
requirement you described is specific for PC.

Anyway, adding this check would make existing VM configurations
refuse to run after a QEMU upgrade.  I suggest fixing the bug in
the ACPI code instead.

-- 
Eduardo
