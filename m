Received: from eggs.gnu.org ([2001:4830:134:3::10]:58203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fkEkV-0005c8-Q1
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fkEkQ-0000Ck-Sj
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:26:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fkEkQ-0000BN-JK
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:26:30 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7337B85363
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 20:26:29 +0000 (UTC)
Date: Mon, 30 Jul 2018 17:26:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180730202624.GN12380@localhost.localdomain>
References: <1532943701-83614-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532943701-83614-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0 v2] pc: acpi: fix memory hotplug
 regression by reducing stub SRAT entry size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

On Mon, Jul 30, 2018 at 11:41:41AM +0200, Igor Mammedov wrote:
> Commit 848a1cc1e (hw/acpi-build: build SRAT memory affinity structures for DIMM devices)
> broke the first dimm hotplug in following cases:
> 
>  1: there is no coldplugged dimm in the last numa node
>     but there is a coldplugged dimm in another node
> 
>   -m 4096,slots=4,maxmem=32G               \
>   -object memory-backend-ram,id=m0,size=2G \
>   -device pc-dimm,memdev=m0,node=0         \
>   -numa node,nodeid=0                      \
>   -numa node,nodeid=1
> 
>  2: if order of dimms on CLI is:
>        1st plugged dimm in node1
>        2nd plugged dimm in node0
> 
>   -m 4096,slots=4,maxmem=32G               \
>   -object memory-backend-ram,size=2G,id=m0 \
>   -device pc-dimm,memdev=m0,node=1         \
>   -object memory-backend-ram,id=m1,size=2G \
>   -device pc-dimm,memdev=m1,node=0         \
>   -numa node,nodeid=0                      \
>   -numa node,nodeid=1
> 
> (qemu) object_add memory-backend-ram,id=m2,size=1G
> (qemu) device_add pc-dimm,memdev=m2,node=0
> 
> the first DIMM hotplug to any node except the last one
> fails (Windows is unable to online it).
> 
> Length reduction of stub hotplug memory SRAT entry,
> fixes issue for some reason.
> 

I'm really bothered by the lack of automated testing for all
these NUMA/ACPI corner cases.

This looks like a good candidate for an avocado_qemu test case.
Can you show pseudo-code of how exactly the bug fix could be
verified, so we can try to write a test case?


> RHBZ: 1609234

I suggest including full URL of bug report[1].  I doubt anybody
outside Red Hat knows what "RHBZ" means.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1609234

> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> NOTE TO MAINTAINER: UPDATE REFERENCE APCI TABLE BLOBS
> 
> v2:
>  fixup examples in commit message
>  (they were in wrong order and with duplicate memdev=m1)
> ---
>  hw/i386/acpi-build.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9e8350c..b52fdb2 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2269,7 +2269,16 @@ static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
>          numamem = acpi_data_push(table_data, sizeof *numamem);
>  
>          if (!info) {
> -            build_srat_memory(numamem, cur, end - cur, default_node,
> +            /*
> +             * Entry is required for Windows to enable memory hotplug in OS
> +             * and for Linux to enable SWIOTLB when booted with less than
> +             * 4G of RAM. Windows works better if the entry sets proximity
> +             * to the highest NUMA node in the machine at the end of the
> +             * reserved space.
> +             * Memory devices may override proximity set by this entry,
> +             * providing _PXM method if necessary.
> +             */
> +            build_srat_memory(numamem, end - 1, 1, default_node,
>                                MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>              break;
>          }
> @@ -2402,14 +2411,6 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>          build_srat_memory(numamem, 0, 0, 0, MEM_AFFINITY_NOFLAGS);
>      }
>  
> -    /*
> -     * Entry is required for Windows to enable memory hotplug in OS
> -     * and for Linux to enable SWIOTLB when booted with less than
> -     * 4G of RAM. Windows works better if the entry sets proximity
> -     * to the highest NUMA node in the machine.
> -     * Memory devices may override proximity set by this entry,
> -     * providing _PXM method if necessary.
> -     */
>      if (hotplugabble_address_space_size) {
>          build_srat_hotpluggable_memory(table_data, machine->device_memory->base,
>                                         hotplugabble_address_space_size,
> -- 
> 2.7.4
> 

-- 
Eduardo
