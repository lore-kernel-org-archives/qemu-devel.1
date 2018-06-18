Received: from eggs.gnu.org ([2001:4830:134:3::10]:35902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fUsdg-0000Fo-Hj
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fUsdd-0004kL-CR
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:48:04 -0400
Date: Mon, 18 Jun 2018 13:47:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180618134750.047d82b5@redhat.com>
In-Reply-To: <20180615140448.32234-9-david@redhat.com>
References: <20180615140448.32234-1-david@redhat.com>
	<20180615140448.32234-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/13] pc-dimm: merge
 get_(vmstate_)memory_region()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S
	. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Fri, 15 Jun 2018 16:04:43 +0200
David Hildenbrand <david@redhat.com> wrote:

> Importantly, get_vmstate_memory_region() should also fail with a proper
> error if called before the device is realized. For a PCDIMM, both functions
> are to return the same thing, so share the implementation.
> 
> All current users are called after the device has been realized, so we
> can expect the calls to succeed.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/mem/pc-dimm.c         | 13 +++++--------
>  include/hw/mem/pc-dimm.h |  3 ++-
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 73f0eee4c7..4ff39b59ef 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -35,7 +35,8 @@ void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
>      int slot;
>      PCDIMMDevice *dimm = PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
> +    MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
> +                                                              &error_abort);
>      Error *local_err = NULL;
>      MemoryRegion *mr;
>      uint64_t addr;
> @@ -90,7 +91,8 @@ void pc_dimm_unplug(DeviceState *dev, MachineState *machine)
>  {
>      PCDIMMDevice *dimm = PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
> +    MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
> +                                                              &error_abort);
>      MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
>  
>      memory_device_unplug_region(machine, mr);
> @@ -229,11 +231,6 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
>      return host_memory_backend_get_memory(dimm->hostmem);
>  }
>  
> -static MemoryRegion *pc_dimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
> -{
> -    return host_memory_backend_get_memory(dimm->hostmem);
> -}
> -
>  static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
>  {
>      const PCDIMMDevice *dimm = PC_DIMM(md);
> @@ -298,7 +295,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
>      dc->desc = "DIMM memory module";
>  
>      ddc->get_memory_region = pc_dimm_get_memory_region;
> -    ddc->get_vmstate_memory_region = pc_dimm_get_vmstate_memory_region;
> +    ddc->get_vmstate_memory_region = pc_dimm_get_memory_region;
>  
>      mdc->get_addr = pc_dimm_md_get_addr;
>      /* for a dimm plugged_size == region_size */
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index cf71247630..5679a80465 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -73,7 +73,8 @@ typedef struct PCDIMMDeviceClass {
>      /* public */
>      void (*realize)(PCDIMMDevice *dimm, Error **errp);
>      MemoryRegion *(*get_memory_region)(PCDIMMDevice *dimm, Error **errp);
> -    MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm);
> +    MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm,
> +                                               Error **errp);
>  } PCDIMMDeviceClass;
>  
>  void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
