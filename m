Received: from eggs.gnu.org ([209.51.188.92]:56386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gyzh6-0007ny-Od
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gyzh2-0005c0-TP
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:56:20 -0500
Date: Wed, 27 Feb 2019 13:40:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190227134035.5b8a0b98@redhat.com>
In-Reply-To: <2cd3fb96-6f46-18db-cb55-5c4e30fd3bac@redhat.com>
References: <20190226135014.31854-1-eric.auger@redhat.com>
	<20190226135014.31854-13-eric.auger@redhat.com>
	<20190226180841.0c30af3c@Igors-MacBook-Pro.local>
	<2cd3fb96-6f46-18db-cb55-5c4e30fd3bac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 12/18] hw/arm/boot: Expose the PC-DIMM
 nodes in the DT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com, pbonzini@redhat.com

On Tue, 26 Feb 2019 18:59:49 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Igor,
> 
> On 2/26/19 6:08 PM, Igor Mammedov wrote:
> > On Tue, 26 Feb 2019 14:50:08 +0100
> > Eric Auger <eric.auger@redhat.com> wrote:
> >   
> >> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> >>
> >> This patch adds memory nodes corresponding to PC-DIMM regions.
> >>
> >> NVDIMM and ACPI_NVDIMM configs are not yet set for ARM so we
> >> don't need to care about NVDIMM at this stage.
> >>
> >> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Reviewed-by: Igor Mammedov <imammedo@redhat.com>  
> > I'm having second thoughts on this one,
> > maybe we should drop this patch or at least not to do this by default.  
> See my reply on your cover letter remark.
Replied there.

> > In the later case it would mean some kind of property that user could use
> > to turn this on which in its own turn adds more clutter to user tunables
> > (which is not desirable). So I'm leaning more towards dropping this patch for now.  
> So what about DT support? Doesn't it make sense to support
> cold-pluggable DIMMS?
It would have a sense if initial memory was also dimms, in that case
for static cases it would be possible to describe numa mapping using
only -device, but we are far from being ale to do it yet.

So right now, I'm not sure if is there are a compelling reasons for
cold-plugged dimms, at startup time initial RAM is sufficient to do the job.
Main goal was to introduce most of infrastructure so that it would be
easier to add hotplug on top. 


> 
> Thanks
> 
> Eric
> >   
> >>
> >> ---
> >> v7 -> v8:
> >> - s/NV_DIMM/NVDIMM
> >> - fix indent
> >> v6 -> v7:
> >> - rework the error messages, use a switch/case
> >> v3 -> v4:
> >> - git rid of @base and @len in fdt_add_hotpluggable_memory_nodes
> >>
> >> v1 -> v2:
> >> - added qapi_free_MemoryDeviceInfoList and simplify the loop
> >> ---
> >>  hw/arm/boot.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 42 insertions(+)
> >>
> >> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> >> index a830655e1a..4caaf91583 100644
> >> --- a/hw/arm/boot.c
> >> +++ b/hw/arm/boot.c
> >> @@ -19,6 +19,7 @@
> >>  #include "sysemu/numa.h"
> >>  #include "hw/boards.h"
> >>  #include "hw/loader.h"
> >> +#include "hw/mem/memory-device.h"
> >>  #include "elf.h"
> >>  #include "sysemu/device_tree.h"
> >>  #include "qemu/config-file.h"
> >> @@ -522,6 +523,41 @@ static void fdt_add_psci_node(void *fdt)
> >>      qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
> >>  }
> >>  
> >> +static int fdt_add_hotpluggable_memory_nodes(void *fdt,
> >> +                                             uint32_t acells, uint32_t scells) {
> >> +    MemoryDeviceInfoList *info, *info_list = qmp_memory_device_list();
> >> +    MemoryDeviceInfo *mi;
> >> +    int ret = 0;
> >> +
> >> +    for (info = info_list; info != NULL; info = info->next) {
> >> +        mi = info->value;
> >> +        switch (mi->type) {
> >> +        case MEMORY_DEVICE_INFO_KIND_DIMM:
> >> +        {
> >> +            PCDIMMDeviceInfo *di = mi->u.dimm.data;
> >> +
> >> +            ret = fdt_add_memory_node(fdt, acells, di->addr,
> >> +                                      scells, di->size, di->node);
> >> +            if (ret) {
> >> +                fprintf(stderr,
> >> +                        "couldn't add PCDIMM /memory@%"PRIx64" node\n",
> >> +                        di->addr);
> >> +                goto out;
> >> +            }
> >> +            break;
> >> +        }
> >> +        default:
> >> +            fprintf(stderr, "%s memory nodes are not yet supported\n",
> >> +                    MemoryDeviceInfoKind_str(mi->type));
> >> +            ret = -ENOENT;
> >> +            goto out;
> >> +        }
> >> +    }
> >> +out:
> >> +    qapi_free_MemoryDeviceInfoList(info_list);
> >> +    return ret;
> >> +}
> >> +
> >>  int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
> >>                   hwaddr addr_limit, AddressSpace *as)
> >>  {
> >> @@ -621,6 +657,12 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
> >>          }
> >>      }
> >>  
> >> +    rc = fdt_add_hotpluggable_memory_nodes(fdt, acells, scells);
> >> +    if (rc < 0) {
> >> +        fprintf(stderr, "couldn't add hotpluggable memory nodes\n");
> >> +        goto fail;
> >> +    }
> >> +
> >>      rc = fdt_path_offset(fdt, "/chosen");
> >>      if (rc < 0) {
> >>          qemu_fdt_add_subnode(fdt, "/chosen");  
> >   
