Received: from eggs.gnu.org ([2001:4830:134:3::10]:48121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fGlcu-0000qU-F4
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fGlcp-0004Pe-Iw
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:28:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fGlcp-0004Pa-D5
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:28:51 -0400
Date: Thu, 10 May 2018 15:28:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180510152848.0f99ea07@redhat.com>
In-Reply-To: <20180427215314.23168-3-ross.zwisler@linux.intel.com>
References: <20180427215314.23168-1-ross.zwisler@linux.intel.com>
	<20180427215314.23168-3-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] nvdimm: platform capabilities command
 line option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, linux-nvdimm <linux-nvdimm@lists.01.org>

On Fri, 27 Apr 2018 15:53:14 -0600
Ross Zwisler <ross.zwisler@linux.intel.com> wrote:

> Add a device command line option to allow the user to control the Platform
> Capabilities Structure in the virtualized NFIT.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> ---
>  docs/nvdimm.txt         | 22 ++++++++++++++++++++++
>  hw/acpi/nvdimm.c        | 29 +++++++++++++++++++++++++----
>  hw/mem/nvdimm.c         | 28 ++++++++++++++++++++++++++++
>  include/hw/mem/nvdimm.h |  6 ++++++
>  4 files changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> index e903d8bb09..13a2c15b70 100644
> --- a/docs/nvdimm.txt
> +++ b/docs/nvdimm.txt
> @@ -153,3 +153,25 @@ guest NVDIMM region mapping structure.  This unarmed flag indicates
>  guest software that this vNVDIMM device contains a region that cannot
>  accept persistent writes. In result, for example, the guest Linux
>  NVDIMM driver, marks such vNVDIMM device as read-only.
> +
> +Platform Capabilities
> +---------------------
> +
> +ACPI 6.2 Errata A added support for a new Platform Capabilities Structure
> +which allows the platform to communicate what features it supports related to
> +NVDIMM data durability.  Users can provide a capabilities value to a guest via
> +the optional "cap" device command line option:
> +
> + -device nvdimm,id=nvdimm1,memdev=mem1,cap=3
> +
> +As of ACPI 6.2 Errata A, the following values are valid for the bottom two
> +bits:
> +
> +2 - Memory Controller Flush to NVDIMM Durability on Power Loss Capable.
> +3 - CPU Cache Flush to NVDIMM Durability on Power Loss Capable.
> +
> +For a complete list of the flags available please consult the ACPI spec.
> +
> +These platform capabilities apply to the entire virtual platform, so it is
> +recommended that only one "cap" device command option be given per virtual
> +machine.  This value will apply to all NVDIMMs in the virtual platform.
This looks like it should be machine property instead of per device one,
you can get rid of static variable and mismatch check and a weird nvdimm CLI
option that implies that the option is per device.

Also an extra patch to for make check that will test setting 'cap'
would be nice (an extra testcase in tests/bios-tables-test.c)

> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 859b390e07..375237c96c 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -370,7 +370,7 @@ static void nvdimm_build_structure_dcr(GArray *structures, DeviceState *dev)
>   * ACPI 6.2 Errata A: 5.2.25.9 NVDIMM Platform Capabilities Structure
>   */
>  static void
> -nvdimm_build_structure_caps(GArray *structures)
> +nvdimm_build_structure_caps(GArray *structures, uint32_t capabilities)
>  {
>      NvdimmNfitPlatformCaps *nfit_caps;
>  
> @@ -378,13 +378,31 @@ nvdimm_build_structure_caps(GArray *structures)
>  
>      nfit_caps->type = cpu_to_le16(7 /* NVDIMM Platform Capabilities */);
>      nfit_caps->length = cpu_to_le16(sizeof(*nfit_caps));
> -    nfit_caps->highest_cap = 1;
> -    nfit_caps->capabilities = cpu_to_le32(2 /* memory controller */);
> +    nfit_caps->highest_cap = 2;
> +    nfit_caps->capabilities = cpu_to_le32(capabilities);
>  }
> +
> +static uint32_t nvdimm_get_capabilities(DeviceState *dev)
> +{
> +    static uint32_t capabilities = 0;
> +    uint32_t this_cap = object_property_get_uint(OBJECT(dev),
> +                                            NVDIMM_CAPABILITIES_PROP, NULL);
> +
> +    if (this_cap && !capabilities)
> +        capabilities = this_cap;
> +
> +    if (this_cap && this_cap != capabilities)
> +        nvdimm_debug("WARNING: multiple capabilities (%d and %d) defined\n",
> +                this_cap, capabilities);
> +
> +    return capabilities;
> +}
> +
>  static GArray *nvdimm_build_device_structure(void)
>  {
>      GSList *device_list = nvdimm_get_device_list();
>      GArray *structures = g_array_new(false, true /* clear */, 1);
> +    uint32_t capabilities = 0;
>  
>      for (; device_list; device_list = device_list->next) {
>          DeviceState *dev = device_list->data;
> @@ -400,10 +418,13 @@ static GArray *nvdimm_build_device_structure(void)
>  
>          /* build NVDIMM Control Region Structure. */
>          nvdimm_build_structure_dcr(structures, dev);
> +
> +        capabilities = nvdimm_get_capabilities(dev);
>      }
>      g_slist_free(device_list);
>  
> -    nvdimm_build_structure_caps(structures);
> +    if (capabilities)
> +        nvdimm_build_structure_caps(structures, capabilities);
>  
>      return structures;
>  }
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 4087aca25e..923364e190 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -87,6 +87,31 @@ static void nvdimm_set_unarmed(Object *obj, bool value, Error **errp)
>      error_propagate(errp, local_err);
>  }
>  
> +static void nvdimm_get_capabilities(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    NVDIMMDevice *nvdimm = NVDIMM(obj);
> +    uint32_t value = nvdimm->capabilities;
> +
> +    visit_type_uint32(v, name, &value, errp);
> +}
> +
> +static void nvdimm_set_capabilities(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    NVDIMMDevice *nvdimm = NVDIMM(obj);
> +    Error *local_err = NULL;
> +    uint32_t value;
> +
> +    visit_type_uint32(v, name, &value, &local_err);
> +    if (local_err)
> +        goto out;
> +
> +    nvdimm->capabilities = value;
> +out:
> +    error_propagate(errp, local_err);
> +}
> +
>  static void nvdimm_init(Object *obj)
>  {
>      object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
> @@ -94,6 +119,9 @@ static void nvdimm_init(Object *obj)
>                          NULL, NULL);
>      object_property_add_bool(obj, NVDIMM_UNARMED_PROP,
>                               nvdimm_get_unarmed, nvdimm_set_unarmed, NULL);
> +    object_property_add(obj, NVDIMM_CAPABILITIES_PROP, "uint32",
> +                        nvdimm_get_capabilities, nvdimm_set_capabilities,
> +                        NULL, NULL, NULL);
>  }
>  
>  static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index 74c60332e1..68af64ff46 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -50,6 +50,7 @@
>  
>  #define NVDIMM_LABEL_SIZE_PROP "label-size"
>  #define NVDIMM_UNARMED_PROP    "unarmed"
> +#define NVDIMM_CAPABILITIES_PROP "cap"
>  
>  struct NVDIMMDevice {
>      /* private */
> @@ -83,6 +84,11 @@ struct NVDIMMDevice {
>       * the guest write persistence.
>       */
>      bool unarmed;
> +
> +    /*
> +     * Platform capabilities, section 5.2.25.9 of ACPI 6.2 Errata A
> +     */
> +    uint32_t capabilities;
>  };
>  typedef struct NVDIMMDevice NVDIMMDevice;
>  
