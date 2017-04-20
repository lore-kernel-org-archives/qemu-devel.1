Received: from eggs.gnu.org ([2001:4830:134:3::10]:58579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d1Bsy-0007P5-F6
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d1Bst-00014w-EV
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:12:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d1Bst-00014K-5h
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:12:31 -0400
Date: Thu, 20 Apr 2017 15:12:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170420151223.76a36fc1@nial.brq.redhat.com>
In-Reply-To: <20170331084147.32716-3-haozhong.zhang@intel.com>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170331084147.32716-3-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/4] nvdimm: add functions to
 initialize and perform flush on back store
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, dan.j.williams@intel.com, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

On Fri, 31 Mar 2017 16:41:45 +0800
Haozhong Zhang <haozhong.zhang@intel.com> wrote:

> fsync() is used to persist modifications to the back store. If the
s/back/backing/

> host NVDIMM is used as the back store, fsync() on Linux will trigger
> the write to the host flush hint address.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  hw/mem/nvdimm.c         | 22 ++++++++++++++++++++++
>  include/hw/mem/nvdimm.h | 13 +++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index db896b0..484ab8b 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -78,6 +78,26 @@ static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm)
>      return &nvdimm->nvdimm_mr;
>  }
>  
> +static void nvdimm_flush_init(NVDIMMDevice *nvdimm, MemoryRegion *hostmem_mr)
> +{
> +    if (nvdimm->flush_hint_enabled) {
> +        nvdimm->backend_fd = memory_region_get_fd(hostmem_mr);
> +    } else {
> +        nvdimm->backend_fd = -1;
> +    }
> +}
> +
> +void nvdimm_flush(NVDIMMDevice *nvdimm)
> +{
> +    if (nvdimm->backend_fd != -1) {
if backend isn't file and user asked for flush_hint, he/she silently won't get it.
maybe we should fail nvdimm_realize() if backend is not file.


> +        /*
> +         * If the backend store is a physical NVDIMM device, fsync()
> +         * will trigger the flush via the flush hint on the host device.
> +         */
> +        fsync(nvdimm->backend_fd);
> +    }
> +}
> +
>  static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
>  {
>      MemoryRegion *mr = host_memory_backend_get_memory(dimm->hostmem, errp);
> @@ -105,6 +125,8 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
>      memory_region_init_alias(&nvdimm->nvdimm_mr, OBJECT(dimm),
>                               "nvdimm-memory", mr, 0, pmem_size);
>      nvdimm->nvdimm_mr.align = align;
> +
> +    nvdimm_flush_init(nvdimm, mr);
>  }
>  
>  /*
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index 03e1ff9..eb71f41 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -71,6 +71,18 @@ struct NVDIMMDevice {
>       * guest via ACPI NFIT and _FIT method if NVDIMM hotplug is supported.
>       */
>      MemoryRegion nvdimm_mr;
> +
> +    /*
> +     * If true, a flush hint address structure will be built for this
> +     * NVDIMM device.
> +     */
> +    bool flush_hint_enabled;
> +    /*
> +     * File descriptor of the backend store, which is used in nvdimm
> +     * flush.  It's cached in NVDIMMDevice rather than being fetched
> +     * at each request in order to accelerate the flush a little bit.
> +     */
> +    int backend_fd;
>  };
>  typedef struct NVDIMMDevice NVDIMMDevice;
>  
> @@ -132,4 +144,5 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
>                         uint32_t ram_slots);
>  void nvdimm_plug(AcpiNVDIMMState *state);
>  void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev);
> +void nvdimm_flush(NVDIMMDevice *nvdimm);
>  #endif
