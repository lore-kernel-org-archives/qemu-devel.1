Received: from eggs.gnu.org ([209.51.188.92]:43118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gw0JV-00009o-N7
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gw0JQ-0004oj-D7
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:59:36 -0500
Date: Tue, 19 Feb 2019 08:59:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190219085916.7b739718@redhat.com>
In-Reply-To: <154943065253.27958.18316807886952418325.stgit@lep8c.aus.stglabs.ibm.com>
References: <154943058200.27958.11497653677605446596.stgit@lep8c.aus.stglabs.ibm.com>
	<154943065253.27958.18316807886952418325.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/4] mem: make nvdimm_device_list global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, mst@redhat.com, bharata@linux.ibm.com, qemu-ppc@nongnu.org, vaibhav@linux.ibm.com, david@gibson.dropbear.id.au

On Tue, 05 Feb 2019 23:25:54 -0600
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> nvdimm_device_list is required for parsing the list for devices
> in subsequent patches. Move it to common area.
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/nvdimm.c        |   27 ---------------------------
>  hw/mem/nvdimm.c         |   27 +++++++++++++++++++++++++++
>  include/hw/mem/nvdimm.h |    2 ++
>  3 files changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index e53b2cb681..34322298c2 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -33,33 +33,6 @@
>  #include "hw/nvram/fw_cfg.h"
>  #include "hw/mem/nvdimm.h"
>  
> -static int nvdimm_device_list(Object *obj, void *opaque)
> -{
> -    GSList **list = opaque;
> -
> -    if (object_dynamic_cast(obj, TYPE_NVDIMM)) {
> -        *list = g_slist_append(*list, DEVICE(obj));
> -    }
> -
> -    object_child_foreach(obj, nvdimm_device_list, opaque);
> -    return 0;
> -}
> -
> -/*
> - * inquire NVDIMM devices and link them into the list which is
> - * returned to the caller.
> - *
> - * Note: it is the caller's responsibility to free the list to avoid
> - * memory leak.
> - */
> -static GSList *nvdimm_get_device_list(void)
> -{
> -    GSList *list = NULL;
> -
> -    object_child_foreach(qdev_get_machine(), nvdimm_device_list, &list);
> -    return list;
> -}
> -
>  #define NVDIMM_UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)             \
>     { (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
>       (b) & 0xff, ((b) >> 8) & 0xff, (c) & 0xff, ((c) >> 8) & 0xff,          \
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index bf2adf5e16..f221ec7a9a 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -29,6 +29,33 @@
>  #include "hw/mem/nvdimm.h"
>  #include "hw/mem/memory-device.h"
>  
> +static int nvdimm_device_list(Object *obj, void *opaque)
> +{
> +    GSList **list = opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_NVDIMM)) {
> +        *list = g_slist_append(*list, DEVICE(obj));
> +    }
> +
> +    object_child_foreach(obj, nvdimm_device_list, opaque);
> +    return 0;
> +}
> +
> +/*
> + * inquire NVDIMM devices and link them into the list which is
> + * returned to the caller.
> + *
> + * Note: it is the caller's responsibility to free the list to avoid
> + * memory leak.
> + */
> +GSList *nvdimm_get_device_list(void)
> +{
> +    GSList *list = NULL;
> +
> +    object_child_foreach(qdev_get_machine(), nvdimm_device_list, &list);
> +    return list;
> +}
> +
>  static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
>                                    void *opaque, Error **errp)
>  {
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index c5c9b3c7f8..e8b086f2df 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -150,4 +150,6 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
>                         uint32_t ram_slots);
>  void nvdimm_plug(AcpiNVDIMMState *state);
>  void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev);
> +GSList *nvdimm_get_device_list(void);
> +
>  #endif
> 
> 
