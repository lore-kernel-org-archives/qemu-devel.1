Received: from eggs.gnu.org ([2001:4830:134:3::10]:58154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eo914-0006lt-It
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eo90z-0001RD-CU
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:35:34 -0500
Date: Tue, 20 Feb 2018 15:35:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180220153510.27451354@redhat.com>
In-Reply-To: <1519022574-6817-2-git-send-email-bharata@linux.vnet.ibm.com>
References: <1519022574-6817-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1519022574-6817-2-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v0 1/2] pc-dimm: Make
 pc_dimm_built_list() global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com

On Mon, 19 Feb 2018 12:12:53 +0530
Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:

> Making pc_dimm_built_list() global allows other parts of QEMU code
> to build and walk through the DIMM list in address-sorted order.
> 
> This is needed in the next patch for sPAPR code to create
> ibm,dynamic-memory-v2 device tree property that will have entries
> for populated DIMMs as well as available hotpluggable areas.
> 
> CHECK: List of DIMMs is already available via qmp_pc_dimm_device_list(),
maybe make it sorted first and use it?

(i.e. use pc_dimm_built_list in qmp_pc_dimm_device_list) and hide
recursive callback ugliness from external users.

MemoryDeviceInfoList *qmp_pc_dimm_device_list(void) {
    object_child_foreach(qdev_get_machine(), pc_dimm_built_list, &list);
    ...
}

> but that doesn't provide a sorted list.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  hw/mem/pc-dimm.c         | 2 +-
>  include/hw/mem/pc-dimm.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 6e74b61..9bd61ca 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -261,7 +261,7 @@ static gint pc_dimm_addr_sort(gconstpointer a, gconstpointer b)
>      return 0;
>  }
>  
> -static int pc_dimm_built_list(Object *obj, void *opaque)
> +int pc_dimm_built_list(Object *obj, void *opaque)
>  {
>      GSList **list = opaque;
>  
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index d83b957..d880f5e 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -100,4 +100,5 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
>                           MemoryRegion *mr, uint64_t align, Error **errp);
>  void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
>                             MemoryRegion *mr);
> +int pc_dimm_built_list(Object *obj, void *opaque);
>  #endif
