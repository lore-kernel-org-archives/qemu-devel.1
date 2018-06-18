Received: from eggs.gnu.org ([2001:4830:134:3::10]:48340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fUtVl-00019k-Rv
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fUtVk-00042j-Ti
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:43:57 -0400
Date: Mon, 18 Jun 2018 14:43:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180618144349.7fb40512@redhat.com>
In-Reply-To: <20180615140448.32234-13-david@redhat.com>
References: <20180615140448.32234-1-david@redhat.com>
	<20180615140448.32234-13-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/13] nvdimm: make get_memory_region()
 perform checks and initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On Fri, 15 Jun 2018 16:04:47 +0200
David Hildenbrand <david@redhat.com> wrote:

> We might get a call to get_memory_region() before the device has been
> realized. We should return a consistent value, as the return value
> will e.g. later on be used in the pre_plug handler.
> 
> To avoid duplicating too much code, factor the initialization and checks
> out into a helper function.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/mem/nvdimm.c | 46 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index df7646488b..deba5719bc 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -71,20 +71,24 @@ static void nvdimm_init(Object *obj)
>                          NULL, NULL);
>  }
>  
> -static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
> +static void nvdimm_prepare_memory_region(NVDIMMDevice *nvdimm, Error **errp)
>  {
> -    NVDIMMDevice *nvdimm = NVDIMM(dimm);
> +    PCDIMMDevice *dimm = PC_DIMM(nvdimm);
> +    uint64_t align, pmem_size, size;
> +    MemoryRegion *mr;
>  
> -    return nvdimm->nvdimm_mr;
> -}
> +    if (nvdimm->nvdimm_mr) {
> +        return;
> +    }
>  
> -static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
> -{
> -    MemoryRegion *mr = host_memory_backend_get_memory(dimm->hostmem);
> -    NVDIMMDevice *nvdimm = NVDIMM(dimm);
> -    uint64_t align, pmem_size, size = memory_region_size(mr);
> +    if (!dimm->hostmem) {
> +        error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property must be set");
> +        return;
> +    }
>  
> +    mr = host_memory_backend_get_memory(dimm->hostmem);
>      align = memory_region_get_alignment(mr);
> +    size = memory_region_size(mr);
>  
>      pmem_size = size - nvdimm->label_size;
>      nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
> @@ -108,6 +112,30 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
>      nvdimm->nvdimm_mr->align = align;
>  }
>  
> +static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
> +{
> +    NVDIMMDevice *nvdimm = NVDIMM(dimm);
> +    Error *local_err = NULL;
> +
> +    if (!nvdimm->nvdimm_mr) {
> +        nvdimm_prepare_memory_region(nvdimm, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return NULL;
> +        }
> +    }
> +    return nvdimm->nvdimm_mr;
> +}
> +
> +static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
> +{
> +    NVDIMMDevice *nvdimm = NVDIMM(dimm);
> +
> +    if (!nvdimm->nvdimm_mr) {
> +        nvdimm_prepare_memory_region(nvdimm, errp);
> +    }
> +}
> +
>  /*
>   * the caller should check the input parameters before calling
>   * label read/write functions.
