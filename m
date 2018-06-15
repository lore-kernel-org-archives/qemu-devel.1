Received: from eggs.gnu.org ([2001:4830:134:3::10]:42384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fToZ0-0002zo-NG
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fToYx-0003Rb-Fq
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:14:50 -0400
Date: Fri, 15 Jun 2018 15:14:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180615151438.3dfb50ce@redhat.com>
In-Reply-To: <20180615112500.19854-12-david@redhat.com>
References: <20180615112500.19854-1-david@redhat.com>
	<20180615112500.19854-12-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/12] nvdimm: make get_memory_region()
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

On Fri, 15 Jun 2018 13:24:59 +0200
David Hildenbrand <david@redhat.com> wrote:

> We might get a call to get_memory_region() before the device has been
> realized. We should return a consistent value, as the return value
> will e.g. later on be used in the pre_plug handler.
> 
> To avoid duplicating too much code, factor the initialization and checks
> out into a helper function.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/mem/nvdimm.c | 49 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index d3e8a5bcbb..9048ce0b84 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -27,20 +27,19 @@
>  #include "qapi/visitor.h"
>  #include "hw/mem/nvdimm.h"
>  
> -static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
> +static void nvdimm_prepare_memory_region(NVDIMMDevice *nvdimm, Error **errp)
>  {
> -    NVDIMMDevice *nvdimm = NVDIMM(dimm);
> -
> -    return &nvdimm->nvdimm_mr;
> -}
> +    PCDIMMDevice *dimm = PC_DIMM(nvdimm);
> +    uint64_t align, pmem_size, size;
> +    MemoryRegion *mr;
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
> -    align = memory_region_get_alignment(mr);
> +    g_assert(!memory_region_size(&nvdimm->nvdimm_mr));
> +    mr = host_memory_backend_get_memory(dimm->hostmem);
>  
>      if (nvdimm->label_size && nvdimm->label_size < MIN_NAMESPACE_LABEL_SIZE) {
>          error_setg(errp, "the label-size (0x%" PRIx64 ") has to be "
> @@ -49,6 +48,9 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
>          return;
>      }
>  
> +    align = memory_region_get_alignment(mr);
> +    size = memory_region_size(mr);
> +
>      pmem_size = size - nvdimm->label_size;
>      nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
>      pmem_size = QEMU_ALIGN_DOWN(pmem_size, align);
> @@ -70,6 +72,31 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
>      nvdimm->nvdimm_mr.align = align;
>  }
>  
> +static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
> +{
> +    NVDIMMDevice *nvdimm = NVDIMM(dimm);
> +    Error *local_err = NULL;
> +
> +    if (!memory_region_size(&nvdimm->nvdimm_mr)) {
ditto as in 10/12, this check works by accident (because memory is zero initialized,
hence memory_region_size() returns 0) and not by design.

one way to fix it, could be to make nvdimm->nvdimm_mr a pointer and dynamically
allocate it and use NULL check to see if it's initialized.
one would need to add finalize to free it on nvdimm destruction though.

> +        nvdimm_prepare_memory_region(nvdimm, &local_err);
> +    }
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +    return &nvdimm->nvdimm_mr;
> +}
> +
> +static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
> +{
> +    NVDIMMDevice *nvdimm = NVDIMM(dimm);
> +
> +    if (!memory_region_size(&nvdimm->nvdimm_mr)) {
ditto

> +        nvdimm_prepare_memory_region(nvdimm, errp);
> +    }
> +}
> +
>  /*
>   * the caller should check the input parameters before calling
>   * label read/write functions.
