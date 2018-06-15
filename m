Received: from eggs.gnu.org ([2001:4830:134:3::10]:38081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fToE8-0003Hc-GN
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fToE3-0007p5-Jh
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:53:16 -0400
Date: Fri, 15 Jun 2018 14:53:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180615145303.319140cb@redhat.com>
In-Reply-To: <20180615112500.19854-11-david@redhat.com>
References: <20180615112500.19854-1-david@redhat.com>
	<20180615112500.19854-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/12] nvdimm: convert "label-size" into
 a static property
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

On Fri, 15 Jun 2018 13:24:58 +0200
David Hildenbrand <david@redhat.com> wrote:

> We don't allow to modify it after realization. So we can simply turn
> it into a static property. The value is now validated during realize().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/mem/nvdimm.c | 53 ++++++++-----------------------------------------
>  1 file changed, 8 insertions(+), 45 deletions(-)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 7260c9c6b1..d3e8a5bcbb 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -27,50 +27,6 @@
>  #include "qapi/visitor.h"
>  #include "hw/mem/nvdimm.h"
>  
> -static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
> -                                  void *opaque, Error **errp)
> -{
> -    NVDIMMDevice *nvdimm = NVDIMM(obj);
> -    uint64_t value = nvdimm->label_size;
> -
> -    visit_type_size(v, name, &value, errp);
> -}
> -
> -static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
> -                                  void *opaque, Error **errp)
> -{
> -    NVDIMMDevice *nvdimm = NVDIMM(obj);
> -    Error *local_err = NULL;
> -    uint64_t value;
> -
> -    if (memory_region_size(&nvdimm->nvdimm_mr)) {
> -        error_setg(&local_err, "cannot change property value");
> -        goto out;
> -    }
> -
> -    visit_type_size(v, name, &value, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -    if (value < MIN_NAMESPACE_LABEL_SIZE) {
> -        error_setg(&local_err, "Property '%s.%s' (0x%" PRIx64 ") is required"
> -                   " at least 0x%lx", object_get_typename(obj),
> -                   name, value, MIN_NAMESPACE_LABEL_SIZE);
> -        goto out;
> -    }
doesn't seem right,
property setter should throw out error at the time it's set if possible.

I'd keep this one check where it is and property dynamic.

and fix only access to uninitialized "if (memory_region_size(&nvdimm->nvdimm_mr)) {"

> -
> -    nvdimm->label_size = value;
> -out:
> -    error_propagate(errp, local_err);
> -}
> -
> -static void nvdimm_init(Object *obj)
> -{
> -    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
> -                        nvdimm_get_label_size, nvdimm_set_label_size, NULL,
> -                        NULL, NULL);
> -}
> -
>  static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
>  {
>      NVDIMMDevice *nvdimm = NVDIMM(dimm);
> @@ -86,6 +42,13 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
>  
>      align = memory_region_get_alignment(mr);
>  
> +    if (nvdimm->label_size && nvdimm->label_size < MIN_NAMESPACE_LABEL_SIZE) {
> +        error_setg(errp, "the label-size (0x%" PRIx64 ") has to be "
> +                   "either 0 or at least 0x%lx",
> +                   nvdimm->label_size, MIN_NAMESPACE_LABEL_SIZE);
> +        return;
> +    }
> +
>      pmem_size = size - nvdimm->label_size;
>      nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
>      pmem_size = QEMU_ALIGN_DOWN(pmem_size, align);
> @@ -143,6 +106,7 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
>  
>  static Property nvdimm_properties[] = {
>      DEFINE_PROP_BOOL(NVDIMM_UNARMED_PROP, NVDIMMDevice, unarmed, false),
> +    DEFINE_PROP_UINT64(NVDIMM_LABEL_SIZE_PROP, NVDIMMDevice, label_size, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -166,7 +130,6 @@ static TypeInfo nvdimm_info = {
>      .class_size    = sizeof(NVDIMMClass),
>      .class_init    = nvdimm_class_init,
>      .instance_size = sizeof(NVDIMMDevice),
> -    .instance_init = nvdimm_init,
>  };
>  
>  static void nvdimm_register_types(void)
