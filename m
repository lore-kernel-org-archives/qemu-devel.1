Received: from eggs.gnu.org ([2001:4830:134:3::10]:37138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dE61C-0004p6-Ms
	for qemu-devel@nongnu.org; Thu, 25 May 2017 23:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dE61B-00079g-Ul
	for qemu-devel@nongnu.org; Thu, 25 May 2017 23:34:26 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:35778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1dE61B-00079T-O5
	for qemu-devel@nongnu.org; Thu, 25 May 2017 23:34:25 -0400
Received: by mail-oi0-x236.google.com with SMTP id l18so303449329oig.2
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 20:34:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170526023213.18741-1-haozhong.zhang@intel.com>
References: <20170526023213.18741-1-haozhong.zhang@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 25 May 2017 20:34:23 -0700
Message-ID: <CAPcyv4gp1CBFA+MMXSjxw1b3nSeHCYkMN1daMP2+r4DpfPmMug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RESEND PATCH 1/2] nvdimm: warn if the backend is
 not a DAX device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>

On Thu, May 25, 2017 at 7:32 PM, Haozhong Zhang
<haozhong.zhang@intel.com> wrote:
> Applications in Linux guest that use device-dax never trigger flush
> that can be trapped by KVM/QEMU. Meanwhile, if the host backend is not
> device-dax, QEMU cannot guarantee the persistence of guest writes.
> Before solving this flushing problem, QEMU should warn users if the
> host backend is not device-dax.

I think this needs to be stronger than a "warn" it needs to be
explicitly forbidden when it is known to be unsafe.

>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Message-id: CAPcyv4hV2-ZW8SMCRtD0P_86KgR3DHOvNe+6T5SY2u7wXg3gEg@mail.gmail.com
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Xiao Guangrong <guangrong.xiao@gmail.com>
> Cc: Stefan Hajnoczi <stefanha@gmail.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
> Resend because the wrong maintainer email address was used.
> ---
>  hw/mem/nvdimm.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index db896b0bb6..c7bb407f33 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -26,6 +26,7 @@
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "hw/mem/nvdimm.h"
> +#include "qemu/error-report.h"
>
>  static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
>                                    void *opaque, Error **errp)
> @@ -78,12 +79,48 @@ static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm)
>      return &nvdimm->nvdimm_mr;
>  }
>
> +static void nvdimm_check_dax(HostMemoryBackend *hostmem)
> +{
> +    char *mem_path =
> +        object_property_get_str(OBJECT(hostmem), "mem-path", NULL);
> +    char *dev_name = NULL, *sysfs_path = NULL;
> +    bool is_dax = false;
> +
> +    if (!mem_path) {
> +        goto out;
> +    }
> +
> +    if (!g_str_has_prefix(mem_path, "/dev/dax")) {
> +        goto out;
> +    }

What if we're using a symlink to a device-dax instance? The should
explicitly be looking up the major / minor number of the device (after
following any symlinks) and verifying that it is device-dax by
checking /sys/dev/char/$major:$minor refers to a device-dax instance.
