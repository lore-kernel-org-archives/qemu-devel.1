Received: from eggs.gnu.org ([2001:4830:134:3::10]:40657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fVAXV-0003Dt-Vr
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fVAXU-0002oH-9s
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:54:54 -0400
Date: Tue, 19 Jun 2018 08:54:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180619085448.65e009a1@redhat.com>
In-Reply-To: <20180618142536.23995-11-david@redhat.com>
References: <20180618142536.23995-1-david@redhat.com>
	<20180618142536.23995-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 10/12] nvdimm: convert nvdimm_mr into a
 pointer
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

On Mon, 18 Jun 2018 16:25:34 +0200
David Hildenbrand <david@redhat.com> wrote:

> This way we can easily check if the region has already been inititalized
> without having to rely on the size of an uninitialized region being 0.
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/mem/nvdimm.c         | 9 +++++----
>  include/hw/mem/nvdimm.h | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 7260c9c6b1..db7d8c3050 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -43,7 +43,7 @@ static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
>      Error *local_err = NULL;
>      uint64_t value;
>  
> -    if (memory_region_size(&nvdimm->nvdimm_mr)) {
> +    if (nvdimm->nvdimm_mr) {
>          error_setg(&local_err, "cannot change property value");
>          goto out;
>      }
> @@ -75,7 +75,7 @@ static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
>  {
>      NVDIMMDevice *nvdimm = NVDIMM(dimm);
>  
> -    return &nvdimm->nvdimm_mr;
> +    return nvdimm->nvdimm_mr;
>  }
>  
>  static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
> @@ -102,9 +102,10 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
>          return;
>      }
>  
> -    memory_region_init_alias(&nvdimm->nvdimm_mr, OBJECT(dimm),
> +    nvdimm->nvdimm_mr = g_new(MemoryRegion, 1);
missed leak,
you need to free this manually in unrealize() in this patch but
considering that the next patches would move this allocation before
realize, it has to be move to finalize(). So make a note in commit
message explaining why finalize() is used prematurely.

probably no need to respin whole series, just send v5 of this patch
as reply here if change doesn't break series.

> +    memory_region_init_alias(nvdimm->nvdimm_mr, OBJECT(dimm),
>                               "nvdimm-memory", mr, 0, pmem_size);
> -    nvdimm->nvdimm_mr.align = align;
> +    nvdimm->nvdimm_mr->align = align;
>  }
>  
>  /*
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index 9340631cfc..c5c9b3c7f8 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -74,7 +74,7 @@ struct NVDIMMDevice {
>       * it's the PMEM region in NVDIMM device, which is presented to
>       * guest via ACPI NFIT and _FIT method if NVDIMM hotplug is supported.
>       */
> -    MemoryRegion nvdimm_mr;
> +    MemoryRegion *nvdimm_mr;
>  
>      /*
>       * The 'on' value results in the unarmed flag set in ACPI NFIT,
