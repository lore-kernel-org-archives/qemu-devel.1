Received: from eggs.gnu.org ([2001:4830:134:3::10]:51177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dDnoK-0001rx-Di
	for qemu-devel@nongnu.org; Thu, 25 May 2017 04:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dDnoF-000409-GO
	for qemu-devel@nongnu.org; Thu, 25 May 2017 04:07:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dDnoF-0003xb-BU
	for qemu-devel@nongnu.org; Thu, 25 May 2017 04:07:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E286E4E341
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 08:07:48 +0000 (UTC)
Date: Thu, 25 May 2017 10:07:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170525100745.107b91a8@nial.brq.redhat.com>
In-Reply-To: <20170525070747.29890-1-lprosek@redhat.com>
References: <20170525070747.29890-1-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] pc: ACPI BIOS: use highest NUMA node
 for hotplug mem hole SRAT entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, lersek@redhat.com

On Thu, 25 May 2017 09:07:47 +0200
Ladi Prosek <lprosek@redhat.com> wrote:

> For reasons unknown, Windows won't online all memory, both at command
> line and hot-plugged later, unless the hotplug mem hole SRAT entry
> specifies a node greater than or equal to the ones where memory is
> added.
> 
> Using the highest node on the machine makes recent versions of Windows
> happy.
> 
> With this example command line:
>   ... \
>   -m 1024,slots=4,maxmem=32G \
>   -numa node,nodeid=0 \
>   -numa node,nodeid=1 \
>   -numa node,nodeid=2 \
>   -numa node,nodeid=3 \
>   -object memory-backend-ram,size=1G,id=mem-mem1 \
>   -device pc-dimm,id=dimm-mem1,memdev=mem-mem1,node=1
> 
> Windows reports a total of 1G of RAM without this commit and the expected
> 2G with this commit.
> 
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> 
> note to maintainer:
> tests/acpi-test-data need to be updated due to change in SRAT table
> 
>  hw/i386/acpi-build.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index afcadac..82bd44f 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2404,14 +2404,17 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>      }
>  
>      /*
> -     * Entry is required for Windows to enable memory hotplug in OS.
> +     * Entry is required for Windows to enable memory hotplug in OS
> +     * and for Linux to enable SWIOTLB when booted with less than
> +     * 4G of RAM. Windows works better if the entry sets proximity
> +     * to the highest NUMA node in the machine.
>       * Memory devices may override proximity set by this entry,
>       * providing _PXM method if necessary.
>       */
>      if (hotplugabble_address_space_size) {
>          numamem = acpi_data_push(table_data, sizeof *numamem);
>          build_srat_memory(numamem, pcms->hotplug_memory.base,
> -                          hotplugabble_address_space_size, 0,
> +                          hotplugabble_address_space_size, pcms->numa_nodes - 1,
>                            MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>      }
>  
