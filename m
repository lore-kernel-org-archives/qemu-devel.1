Received: from eggs.gnu.org ([2001:4830:134:3::10]:50494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dKE0R-0002ZH-W5
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 21:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dKE0O-0001ss-PD
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 21:18:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:51961)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dKE0O-0001qZ-ES
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 21:18:56 -0400
Date: Mon, 12 Jun 2017 09:18:51 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170612011851.gkamzmzlxhcvqjr3@hz-desktop>
References: <20170606072229.9302-1-haozhong.zhang@intel.com>
	<20170606072229.9302-4-haozhong.zhang@intel.com>
	<20170608155249-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608155249-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] nvdimm: add a boolean option
 "restrict"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>

On 06/08/17 15:56 +0300, Michael S. Tsirkin wrote:
> On Tue, Jun 06, 2017 at 03:22:28PM +0800, Haozhong Zhang wrote:
> > If a vNVDIMM device is not backed by a DAX device and its "restrict"
> > option is enabled, bit 3 of state flags in its region mapping
> > structure will be set, in order to notify the guest of the lack of
> > write persistence guarantee. Once this bit is set, the guest OS may
> > mark the vNVDIMM device as read-only.
> > 
> > This option is disabled by default for backwards compatibility. It's
> > recommended to enable for the formal usage.
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> 
> Seems wrong to me. E.g. it won't work in a nested
> virt setup. What if backend is dax but is not armed?
> Can't the armed bit of the backing device be tested?

If the not-arm bit of a host NVDIMM region is set, Linux NVDIMM driver
will make it read-only, and QEMU will fail when it tries to mmap it
with flags (PROT_READ | PROT_WRITE). Thus, we don't need to check
whether the host region is not armed.

> Name "restrict" is also confusing. Can we reuse cache=
> options? E.g. cache=unsafe etc.

I agree the name is confusing, and would like to use the name 'armed'
suggested by Stefan.

Thanks,
Haozhong

> 
> > ---
> >  hw/acpi/nvdimm.c        | 16 ++++++++++++++++
> >  hw/mem/nvdimm.c         | 38 +++++++++++++++++++++++++++++++++++++-
> >  include/hw/mem/nvdimm.h |  5 +++++
> >  3 files changed, 58 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> > index 8e7d6ec034..fd1ef6dc65 100644
> > --- a/hw/acpi/nvdimm.c
> > +++ b/hw/acpi/nvdimm.c
> > @@ -138,6 +138,8 @@ struct NvdimmNfitMemDev {
> >  } QEMU_PACKED;
> >  typedef struct NvdimmNfitMemDev NvdimmNfitMemDev;
> >  
> > +#define ACPI_NFIT_MEM_NOT_ARMED    (1 << 3)
> > +
> >  /*
> >   * NVDIMM Control Region Structure
> >   *
> > @@ -289,6 +291,10 @@ nvdimm_build_structure_memdev(GArray *structures, DeviceState *dev)
> >      int slot = object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
> >                                              NULL);
> >      uint32_t handle = nvdimm_slot_to_handle(slot);
> > +    bool dev_dax = object_property_get_bool(OBJECT(dev), NVDIMM_DEV_DAX_PROP,
> > +                                            NULL);
> > +    bool restrict_mode = object_property_get_bool(OBJECT(dev),
> > +                                                  NVDIMM_RESTRICT_PROP, NULL);
> >  
> >      nfit_memdev = acpi_data_push(structures, sizeof(*nfit_memdev));
> >  
> > @@ -312,6 +318,16 @@ nvdimm_build_structure_memdev(GArray *structures, DeviceState *dev)
> >  
> >      /* Only one interleave for PMEM. */
> >      nfit_memdev->interleave_ways = cpu_to_le16(1);
> > +
> > +    /*
> > +     * If a vNVDIMM device in the restrict mode and is not backed by a
> > +     * DAX device, QEMU will set ACPI_NFIT_MEM_NOT_ARMED bit of state
> > +     * flags in its region mapping structure, in order to notify the
> > +     * guest of the lack of write persistence guarantee.
> > +     */
> > +    if (!dev_dax && restrict_mode) {
> > +        nfit_memdev->flags = cpu_to_le16(ACPI_NFIT_MEM_NOT_ARMED);
> > +    }
> >  }
> >  
> >  /*
> > diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> > index b23542fbdf..cda416e5c8 100644
> > --- a/hw/mem/nvdimm.c
> > +++ b/hw/mem/nvdimm.c
> > @@ -65,11 +65,46 @@ out:
> >      error_propagate(errp, local_err);
> >  }
> >  
> > +static bool nvdimm_get_backend_dev_dax(Object *obj, Error **errp)
> > +{
> > +    NVDIMMDevice *nvdimm = NVDIMM(obj);
> > +
> > +    return nvdimm->backend_dev_dax;
> > +}
> > +
> > +static bool nvdimm_get_restrict(Object *obj, Error **errp)
> > +{
> > +    NVDIMMDevice *nvdimm = NVDIMM(obj);
> > +
> > +    return nvdimm->restrict_mode;
> > +}
> > +
> > +static void nvdimm_set_restrict(Object *obj, bool val, Error **errp)
> > +{
> > +    DeviceState *dev = DEVICE(obj);
> > +    NVDIMMDevice *nvdimm = NVDIMM(obj);
> > +    Error *local_err = NULL;
> > +
> > +    if (dev->realized) {
> > +        error_setg(&local_err, "cannot change property value");
> > +        goto out;
> > +    }
> > +
> > +    nvdimm->restrict_mode = val;
> > +
> > + out:
> > +    error_propagate(errp, local_err);
> > +}
> > +
> >  static void nvdimm_init(Object *obj)
> >  {
> >      object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
> >                          nvdimm_get_label_size, nvdimm_set_label_size, NULL,
> >                          NULL, NULL);
> > +    object_property_add_bool(obj, NVDIMM_DEV_DAX_PROP,
> > +                             nvdimm_get_backend_dev_dax, NULL, NULL);
> > +    object_property_add_bool(obj, NVDIMM_RESTRICT_PROP,
> > +                             nvdimm_get_restrict, nvdimm_set_restrict, NULL);
> >  }
> >  
> >  static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm)
> > @@ -85,7 +120,8 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
> >      NVDIMMDevice *nvdimm = NVDIMM(dimm);
> >      uint64_t align, pmem_size, size = memory_region_size(mr);
> >  
> > -    if (!qemu_fd_is_dev_dax(memory_region_get_fd(mr))) {
> > +    nvdimm->backend_dev_dax = qemu_fd_is_dev_dax(memory_region_get_fd(mr));
> > +    if (!nvdimm->backend_dev_dax) {
> >          error_report("warning: nvdimm backend does not look like a DAX device, "
> >                       "unable to guarantee persistence of guest writes");
> >      }
> > diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> > index f1f3987055..2fbe0d7858 100644
> > --- a/include/hw/mem/nvdimm.h
> > +++ b/include/hw/mem/nvdimm.h
> > @@ -49,6 +49,8 @@
> >                                                 TYPE_NVDIMM)
> >  
> >  #define NVDIMM_LABEL_SIZE_PROP "label-size"
> > +#define NVDIMM_DEV_DAX_PROP    "dev-dax"
> > +#define NVDIMM_RESTRICT_PROP   "restrict"
> >  
> >  struct NVDIMMDevice {
> >      /* private */
> > @@ -74,6 +76,9 @@ struct NVDIMMDevice {
> >       * guest via ACPI NFIT and _FIT method if NVDIMM hotplug is supported.
> >       */
> >      MemoryRegion nvdimm_mr;
> > +
> > +    bool backend_dev_dax;
> > +    bool restrict_mode;
> >  };
> >  typedef struct NVDIMMDevice NVDIMMDevice;
> >  
> > -- 
> > 2.11.0
