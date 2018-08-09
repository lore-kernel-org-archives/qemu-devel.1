Received: from eggs.gnu.org ([2001:4830:134:3::10]:40173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnglZ-0001vE-CG
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 04:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnglY-0002bZ-Ay
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 04:57:57 -0400
Date: Thu, 9 Aug 2018 10:57:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180809105746.78156191@redhat.com>
In-Reply-To: <ff206af7-91fb-1ed7-9f92-c24980044254@redhat.com>
References: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
	<1530602398-16127-9-git-send-email-eric.auger@redhat.com>
	<20180718160413.5c4dc514@redhat.com>
	<ff206af7-91fb-1ed7-9f92-c24980044254@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 08/15] hw/arm/boot: introduce
 fdt_add_memory_node helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com

On Wed, 8 Aug 2018 11:44:14 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Igor,
> 
> On 07/18/2018 04:04 PM, Igor Mammedov wrote:
> > On Tue,  3 Jul 2018 09:19:51 +0200
> > Eric Auger <eric.auger@redhat.com> wrote:
> >   
> >> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> >>
> >> We introduce an helper to create a memory node.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> >>
> >> ---
> >>
> >> v1 -> v2:
> >> - nop of existing /memory nodes was already handled
> >> ---
> >>  hw/arm/boot.c | 54 ++++++++++++++++++++++++++++++++++--------------------
> >>  1 file changed, 34 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> >> index e09201c..5243a25 100644
> >> --- a/hw/arm/boot.c
> >> +++ b/hw/arm/boot.c
> >> @@ -413,6 +413,36 @@ static void set_kernel_args_old(const struct arm_boot_info *info,
> >>      }
> >>  }
> >>  
> >> +static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
> >> +                               uint32_t scells, hwaddr mem_len,
> >> +                               int numa_node_id)
> >> +{
> >> +    char *nodename = NULL;
> >> +    int ret;
> >> +
> >> +    nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
> >> +    qemu_fdt_add_subnode(fdt, nodename);
> >> +    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> >> +    ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells, mem_base,
> >> +                                       scells, mem_len);
> >> +    if (ret < 0) {
> >> +        fprintf(stderr, "couldn't set %s/reg\n", nodename);
> >> +        goto out;
> >> +    }
> >> +    if (numa_node_id < 0) {
> >> +        goto out;
> >> +    }
> >> +
> >> +    ret = qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id", numa_node_id);
> >> +    if (ret < 0) {
> >> +        fprintf(stderr, "couldn't set %s/numa-node-id\n", nodename);
> >> +    }
> >> +
> >> +out:
> >> +    g_free(nodename);
> >> +    return ret;
> >> +}
> >> +  
> > 
> > not related question from hotplug POV,
> > is entry size fixed?  
> Sorry I don't get what entry you are referring to?
> > can we estimate exact size for #slots number of dimms and reserve it in advance
> > in FDT 'rom'?  
> Not sure I get your drift either.
> 
> patch "[RFC v3 09/15] hw/arm/boot: Expose the PC-DIMM nodes in the DT"
> builds the DT nodes for each node, by enumerating the MemoryDeviceInfoList.

In case of hotplug we don not care about adding DTB node at runtime
(guest won't see it anyways). However if we reboot machine it's reasonable
to regenerate DTB on reboot so guest would see previously hotplugged DIMMs.
Problem is that DTB is stored in fixed size 'rom' that's copied into guest's
RAM, so we should reserve a space for possible slots in advance or switch
to another mechanism to provide DTB to guest. (it could be a memory region
mapped outside of RAM)

[...]
