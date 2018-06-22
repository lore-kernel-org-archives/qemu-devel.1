Received: from eggs.gnu.org ([2001:4830:134:3::10]:35849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWKYq-0000tu-HW
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWKYp-0001P9-Fo
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:49:04 -0400
References: <1529326004-32239-1-git-send-email-eric.auger@redhat.com>
	<1529326004-32239-4-git-send-email-eric.auger@redhat.com>
	<CAFEAcA9X2ASVtcG0Nw5_Bx-rn2+M5hW7g3+QhZvhASYn9aV+SA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <418f7043-8f4f-3b04-f771-b9e392c64d00@redhat.com>
Date: Fri, 22 Jun 2018 13:48:54 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9X2ASVtcG0Nw5_Bx-rn2+M5hW7g3+QhZvhASYn9aV+SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] hw/arm/virt: Silence dtc /memory
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexander Graf <agraf@suse.de>, ">" <crosthwaite.peter@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger.pro@gmail.com>

Hi Peter,

On 06/22/2018 01:02 PM, Peter Maydell wrote:
> On 18 June 2018 at 13:46, Eric Auger <eric.auger@redhat.com> wrote:
>> When running dtc on the guest /proc/device-tree we get the
>> following warning: Warning (unit_address_vs_reg): Node /memory
>> has a reg or ranges property, but no unit name".
>>
>> Let's fix that by adding the unit address to the node name. We also
>> don't create the /memory node anymore in create_fdt(). We directly
>> create it in load_dtb. /chosen still needs to be created in create_fdt
>> as the uart needs it. In case the user provided his own dtb, we nop
>> all memory nodes and create new one(s).
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/boot.c | 34 ++++++++++++++++++++--------------
>>  hw/arm/virt.c |  7 +------
>>  2 files changed, 21 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index 1e48166..de80d05 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -490,11 +490,13 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>>                   hwaddr addr_limit, AddressSpace *as)
>>  {
>>      void *fdt = NULL;
>> -    int size, rc;
>> +    int size, rc, n = 0;
>>      uint32_t acells, scells;
>>      char *nodename;
>>      unsigned int i;
>>      hwaddr mem_base, mem_len;
>> +    char **node_path;
>> +    Error *err = NULL;
>>
>>      if (binfo->dtb_filename) {
>>          char *filename;
>> @@ -546,12 +548,22 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>>          goto fail;
>>      }
>>
>> +    /* nop all nodes matching /memory or /memory@unit-address */
>> +    node_path = qemu_fdt_node_unit_path(fdt, "memory", &err);
>> +    if (err) {
>> +        error_report_err(err);
>> +        goto fail;
>> +    }
>> +    while (node_path[n]) {
>> +        qemu_fdt_nop_node(fdt, node_path[n++]);
>> +    }
>> +    g_strfreev(node_path);
> 
> This removes all nodes named "memory" or "memory@*", rather than
> just the ones in the root, right?

correct

 Is that definitely what we want to
> do? The old code only deleted /memory, and the comment implies
> that we only look in the root.
> 
> (I'm wondering if there are DTs that use memory nodes for random
> odd things other than system memory...)

I don't know the exact use case. Removing the exact /memory@40000000
node is simpler and does not require 2/3 I think. So if this is what is
expected I can stick to that node.

To my knowledge nothing prevents from having several memory nodes. This
is what I started to do in my PC-DIMM series. You can have a single
/memory node with several reg properties in it, corresponding to several
banks or you can have several /memory nodes.
> 
>> +
>>      if (nb_numa_nodes > 0) {
>>          /*
>>           * Turn the /memory node created before into a NOP node, then create
>>           * /memory@addr nodes for all numa nodes respectively.
>>           */
>> -        qemu_fdt_nop_node(fdt, "/memory");
> 
> This code change means the comment needs updating too.
definitively :-(

Thanks

Eric

> 
>>          mem_base = binfo->loader_start;
>>          for (i = 0; i < nb_numa_nodes; i++) {
>>              mem_len = numa_info[i].node_mem;
>> @@ -572,24 +584,18 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>>              g_free(nodename);
>>          }
>>      } else {
>> -        Error *err = NULL;
>> +        nodename = g_strdup_printf("/memory@%" PRIx64, binfo->loader_start);
>> +        qemu_fdt_add_subnode(fdt, nodename);
>> +        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
>>
>> -        rc = fdt_path_offset(fdt, "/memory");
>> -        if (rc < 0) {
>> -            qemu_fdt_add_subnode(fdt, "/memory");
>> -        }
>> -
>> -        if (!qemu_fdt_getprop(fdt, "/memory", "device_type", NULL, &err)) {
>> -            qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
>> -        }
>> -
>> -        rc = qemu_fdt_setprop_sized_cells(fdt, "/memory", "reg",
>> +        rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
>>                                            acells, binfo->loader_start,
>>                                            scells, binfo->ram_size);
>>          if (rc < 0) {
>> -            fprintf(stderr, "couldn't set /memory/reg\n");
>> +            fprintf(stderr, "couldn't set %s reg\n", nodename);
>>              goto fail;
>>          }
>> +        g_free(nodename);
>>      }
>>
>>      rc = fdt_path_offset(fdt, "/chosen");
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index cd0f350..71c27f1 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -200,13 +200,8 @@ static void create_fdt(VirtMachineState *vms)
>>      qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
>>      qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
>>
>> -    /*
>> -     * /chosen and /memory nodes must exist for load_dtb
>> -     * to fill in necessary properties later
>> -     */
>> +    /* /chosen must exist for load_dtb to fill in necessary properties later */
>>      qemu_fdt_add_subnode(fdt, "/chosen");
>> -    qemu_fdt_add_subnode(fdt, "/memory");
>> -    qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
>>
>>      /* Clock node, for the benefit of the UART. The kernel device tree
>>       * binding documentation claims the PL011 node clock properties are
>> --
>> 2.5.5
> 
> thanks
> -- PMM
> 
