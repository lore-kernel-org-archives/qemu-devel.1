Received: from eggs.gnu.org ([2001:4830:134:3::10]:39181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1coY7p-00013G-3W
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1coY7l-00079Q-1g
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:19:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1coY7k-00079F-PC
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:19:36 -0400
Date: Thu, 16 Mar 2017 17:19:30 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170316161929.bn4kdlfz4om7vs34@hawk.localdomain>
References: <1489653504-25229-1-git-send-email-he.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489653504-25229-1-git-send-email-he.chen@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2] x86: Allow to set NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: He Chen <he.chen@linux.intel.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 16, 2017 at 04:38:24PM +0800, He Chen wrote:
> Current, QEMU does not provide a clear command to set vNUMA distance for
> guest although we already have `-numa` command to set vNUMA nodes.
> 
> vNUMA distance makes sense in certain scenario.
> But now, if we create a guest that has 4 vNUMA nodes, when we check NUMA
> info via `numactl -H`, we will see:
> 
> node distance:
> node    0    1    2    3
>   0:   10   20   20   20
>   1:   20   10   20   20
>   2:   20   20   10   20
>   3:   20   20   20   10
> 
> Guest kernel regards all local node as distance 10, and all remote node
> as distance 20 when there is no SLIT table since QEMU doesn't build it.
> It looks like a little strange when you have seen the distance in an
> actual physical machine that contains 4 NUMA nodes. My machine shows:
> 
> node distance:
> node    0    1    2    3
>   0:   10   21   31   41
>   1:   21   10   21   31
>   2:   31   21   10   21
>   3:   41   31   21   10
> 
> To set vNUMA distance, guest should see a complete SLIT table.
> I found QEMU has provide `-acpitable` command that allows users to add
> a ACPI table into guest, but it requires users building ACPI table by
> themselves first. Using `-acpitable` to add a SLIT table may be not so
> straightforward or flexible, imagine that when the vNUMA configuration
> is changes and we need to generate another SLIT table manually. It may
> not be friendly to users or upper software like libvirt.
> 
> This patch is going to add SLIT table support in QEMU, and provides
> additional option `dist` for command `-numa` to allow user set vNUMA
> distance by QEMU command.
> 
> With this patch, when a user wants to create a guest that contains
> several vNUMA nodes and also wants to set distance among those nodes,
> the QEMU command would like:
> 
> ```
> -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=0,policy=bind,id=node0 \
> -numa node,nodeid=0,cpus=0,memdev=node0 \
> -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=1,policy=bind,id=node1 \
> -numa node,nodeid=1,cpus=1,memdev=node1 \
> -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=2,policy=bind,id=node2 \
> -numa node,nodeid=2,cpus=2,memdev=node2 \
> -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=3,policy=bind,id=node3 \
> -numa node,nodeid=3,cpus=3,memdev=node3 \
> -numa dist,src=0,dst=1,val=21 \
> -numa dist,src=0,dst=2,val=31 \
> -numa dist,src=0,dst=3,val=41 \
> -numa dist,src=1,dst=0,val=21 \
> ...
> ```
> 
> Signed-off-by: He Chen <he.chen@linux.intel.com>
> ---
>  hw/i386/acpi-build.c    | 27 +++++++++++++++++++++++++++
>  include/sysemu/numa.h   |  1 +
>  include/sysemu/sysemu.h |  3 +++
>  numa.c                  | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  qapi-schema.json        | 24 ++++++++++++++++++++++--
>  qemu-options.hx         | 12 +++++++++++-
>  6 files changed, 108 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2073108..50906b9 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2395,6 +2395,31 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>                   table_data->len - srat_start, 1, NULL, NULL);
>  }
>  
> +/*
> + * ACPI spec 5.2.17 System Locality Distance Information Table
> + * (Revision 2.0 or later)
> + */
> +static void
> +build_slit(GArray *table_data, BIOSLinker *linker, MachineState *machine)
> +{
> +    int slit_start, i, j;
> +    slit_start = table_data->len;
> +
> +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
> +
> +    build_append_int_noprefix(table_data, nb_numa_nodes, 8);
> +    for (i = 0; i < nb_numa_nodes; i++) {
> +        for (j = 0; j < nb_numa_nodes; j++) {
> +            build_append_int_noprefix(table_data, numa_info[i].distance[j], 1);
> +        }
> +    }
> +
> +    build_header(linker, table_data,
> +                 (void *)(table_data->data + slit_start),
> +                 "SLIT",
> +                 table_data->len - slit_start, 1, NULL, NULL);
> +}
> +

There's no reason to put build_slit() in the x86-specific acpi code.
It can go in hw/acpi/aml-build.c, and then we can also use it for
ARM ACPI tables too.

Thanks,
drew
