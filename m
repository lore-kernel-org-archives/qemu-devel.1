Received: from eggs.gnu.org ([2001:4830:134:3::10]:48669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cEESZ-0006jx-88
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cEESW-0006VM-1o
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:02:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cEESV-0006VA-Oc
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:02:55 -0500
Date: Tue, 6 Dec 2016 13:02:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161206130249.6225908a@nial.brq.redhat.com>
In-Reply-To: <7723a0d7-0764-ab5d-51ce-25054f910c36@redhat.com>
References: <20161201170624.26496-1-lersek@redhat.com>
	<20161201170624.26496-3-lersek@redhat.com>
	<20161206115038.4495a217@nial.brq.redhat.com>
	<7723a0d7-0764-ab5d-51ce-25054f910c36@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/7] fw-cfg: turn FW_CFG_FILE_SLOTS into
 a device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, "Gabriel L. Somlo" <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 6 Dec 2016 12:43:06 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 12/06/16 11:50, Igor Mammedov wrote:
> > On Thu,  1 Dec 2016 18:06:19 +0100
> > Laszlo Ersek <lersek@redhat.com> wrote:
> >   
> >> We'd like to raise the value of FW_CFG_FILE_SLOTS. Doing it naively could
> >> lead to problems with backward migration: a more recent QEMU (running an
> >> older machine type) would allow the guest, in fw_cfg_select(), to select a
> >> high key value that is unavailable in the same machine type implemented by
> >> the older (target) QEMU. On the target host, fw_cfg_data_read() for
> >> example could dereference nonexistent entries.
> >>
> >> As first step, size the FWCfgState.entries[*] and FWCfgState.entry_order
> >> arrays dynamically. All three array sizes will be influenced by the new
> >> field (and device property) FWCfgState.file_slots.
> >>
> >> Make the following changes:
> >>
> >> - Replace the FW_CFG_FILE_SLOTS macro with FW_CFG_FILE_SLOTS_TRAD
> >>   (traditional count of fw_cfg file slots) in the header file. The value
> >>   remains 0x10.
> >>
> >> - Replace all uses of FW_CFG_FILE_SLOTS with a helper function called
> >>   fw_cfg_file_slots(), returning the new property.
> >>
> >> - Eliminate the macro FW_CFG_MAX_ENTRY, and replace all its uses with a
> >>   helper function called fw_cfg_max_entry().
> >>
> >> - In the MMIO- and IO-mapped realize functions both, allocate all three
> >>   arrays dynamically, based on the new property.
> >>
> >> - The new property defaults to 0x20; however at the moment we forcibly set
> >>   it to FW_CFG_FILE_SLOTS_TRAD on all code paths available to board code
> >>   (namely in the fw_cfg_init_io_dma() and fw_cfg_init_mem_wide() helper
> >>   functions). This is going to be customized in the following patches.
> >>
> >> Cc: "Gabriel L. Somlo" <somlo@cmu.edu>
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> Cc: Gerd Hoffmann <kraxel@redhat.com>
> >> Cc: Igor Mammedov <imammedo@redhat.com>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> >> ---
> >>
> >> Notes:
> >>     I know that upstream doesn't care about backward migration, but some
> >>     downstreams might.
> >>
> >>  docs/specs/fw_cfg.txt          |  2 +-
> >>  include/hw/nvram/fw_cfg_keys.h |  3 +-
> >>  hw/nvram/fw_cfg.c              | 85 ++++++++++++++++++++++++++++++++++++++----
> >>  3 files changed, 79 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
> >> index a19e2adbe1c6..84e2978706f5 100644
> >> --- a/docs/specs/fw_cfg.txt
> >> +++ b/docs/specs/fw_cfg.txt
> >> @@ -154,11 +154,11 @@ Selector Reg.    Range Usage
> >>  0x8000 - 0xbfff  Arch. Specific (0x0000 - 0x3fff, generally RO, possibly RW
> >>                                   through the DMA interface in QEMU v2.9+)
> >>  0xc000 - 0xffff  Arch. Specific (0x0000 - 0x3fff, RW, ignored in v2.4+)
> >>  
> >>  In practice, the number of allowed firmware configuration items is given
> >> -by the value of FW_CFG_MAX_ENTRY (see fw_cfg.h).
> >> +by the value (FW_CFG_FILE_FIRST + FW_CFG_FILE_SLOTS_TRAD) (see fw_cfg.h).
> >>  
> >>  = Guest-side DMA Interface =
> >>  
> >>  If bit 1 of the feature bitmap is set, the DMA interface is present. This does
> >>  not replace the existing fw_cfg interface, it is an add-on. This interface
> >> diff --git a/include/hw/nvram/fw_cfg_keys.h b/include/hw/nvram/fw_cfg_keys.h
> >> index 0f3e871884c0..627589793671 100644
> >> --- a/include/hw/nvram/fw_cfg_keys.h
> >> +++ b/include/hw/nvram/fw_cfg_keys.h
> >> @@ -27,12 +27,11 @@
> >>  #define FW_CFG_SETUP_SIZE       0x17
> >>  #define FW_CFG_SETUP_DATA       0x18
> >>  #define FW_CFG_FILE_DIR         0x19
> >>  
> >>  #define FW_CFG_FILE_FIRST       0x20
> >> -#define FW_CFG_FILE_SLOTS       0x10
> >> -#define FW_CFG_MAX_ENTRY        (FW_CFG_FILE_FIRST + FW_CFG_FILE_SLOTS)
> >> +#define FW_CFG_FILE_SLOTS_TRAD  0x10
> >>  
> >>  #define FW_CFG_WRITE_CHANNEL    0x4000
> >>  #define FW_CFG_ARCH_LOCAL       0x8000
> >>  #define FW_CFG_ENTRY_MASK       (~(FW_CFG_WRITE_CHANNEL | FW_CFG_ARCH_LOCAL))
> >>  
> >> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> >> index e0145c11a19b..2e1441c09750 100644
> >> --- a/hw/nvram/fw_cfg.c
> >> +++ b/hw/nvram/fw_cfg.c
> >> @@ -31,10 +31,13 @@
> >>  #include "hw/sysbus.h"
> >>  #include "trace.h"
> >>  #include "qemu/error-report.h"
> >>  #include "qemu/config-file.h"
> >>  #include "qemu/cutils.h"
> >> +#include "qapi/error.h"
> >> +
> >> +#define FW_CFG_FILE_SLOTS_DFLT 0x20
> >>  
> >>  #define FW_CFG_NAME "fw_cfg"
> >>  #define FW_CFG_PATH "/machine/" FW_CFG_NAME
> >>  
> >>  #define TYPE_FW_CFG     "fw_cfg"
> >> @@ -69,12 +72,13 @@ typedef struct FWCfgEntry {
> >>  struct FWCfgState {
> >>      /*< private >*/
> >>      SysBusDevice parent_obj;
> >>      /*< public >*/
> >>  
> >> -    FWCfgEntry entries[2][FW_CFG_MAX_ENTRY];
> >> -    int entry_order[FW_CFG_MAX_ENTRY];
> >> +    uint32_t file_slots;  
> > should it be uint16_t?
> > As below you use "uint16_t file_slots_max;" and do some UINT16
> > to calculate max limit.  
> 
> I think I had a reason for making this uint32_t. I think the argument
> was that fw_cfg_max_entry() could theoretically return a value that
> doesn't fit in a uint16_t. Looking again at the patch however, I think I
> can try to make this a uint16_t for the next version.
> 
> >   
> >> +    FWCfgEntry *entries[2];
> >> +    int *entry_order;
> >>      FWCfgFiles *files;
> >>      uint16_t cur_entry;
> >>      uint32_t cur_offset;
> >>      Notifier machine_ready;
> >>  
> >> @@ -255,17 +259,27 @@ static void fw_cfg_reboot(FWCfgState *s)
> >>  static void fw_cfg_write(FWCfgState *s, uint8_t value)
> >>  {
> >>      /* nothing, write support removed in QEMU v2.4+ */
> >>  }
> >>  
> >> +static inline uint32_t fw_cfg_file_slots(const FWCfgState *s)
> >> +{
> >> +    return s->file_slots;
> >> +}  
> > so far it doesn't look like this wrapper function is necessary,
> > I'd prefer accessing field directly as it's used only internally.
> > Or do you have plans to extend wrapper later?
> > (then it would be better introduce wrapper at that time)  
> 
> Originally I used "s->file_slots" in this patch, like you say, without
> this small wrapper function,, but the resultant patch was harder to
> review. With this wrapper, you have two kinds of changes in the patch:
> 
> *     FW_CFG_MAX_ENTRY
>   --> fw_cfg_max_entry(s)  
> 
> *     FW_CFG_FILE_SLOTS
>   --> fw_cfg_file_slots(s)  
> 
> Without the wrapper, the second bullet looks
> 
> *     FW_CFG_FILE_SLOTS
>   --> s->file_slots  
> 
> and to me that made the patch harder to verify.
to me this variant look clearer as I don't have to recall that 
fw_cfg_file_slots(s) is s->file_slots  and does nothing more.
But if you prefer wrapper I'm also fine with it.

> 
> >   
> >> +
> >> +static inline uint32_t fw_cfg_max_entry(const FWCfgState *s)
> >> +{
> >> +    return FW_CFG_FILE_FIRST + fw_cfg_file_slots(s);
> >> +}
> >> +
> >>  static int fw_cfg_select(FWCfgState *s, uint16_t key)
> >>  {
> >>      int arch, ret;
> >>      FWCfgEntry *e;
> >>  
> >>      s->cur_offset = 0;
> >> -    if ((key & FW_CFG_ENTRY_MASK) >= FW_CFG_MAX_ENTRY) {
> >> +    if ((key & FW_CFG_ENTRY_MASK) >= fw_cfg_max_entry(s)) {
> >>          s->cur_entry = FW_CFG_INVALID;
> >>          ret = 0;
> >>      } else {
> >>          s->cur_entry = key;
> >>          ret = 1;
> >> @@ -608,11 +622,11 @@ static void fw_cfg_add_bytes_read_callback(FWCfgState *s, uint16_t key,
> >>  {
> >>      int arch = !!(key & FW_CFG_ARCH_LOCAL);
> >>  
> >>      key &= FW_CFG_ENTRY_MASK;
> >>  
> >> -    assert(key < FW_CFG_MAX_ENTRY && len < UINT32_MAX);
> >> +    assert(key < fw_cfg_max_entry(s) && len < UINT32_MAX);
> >>      assert(s->entries[arch][key].data == NULL); /* avoid key conflict */
> >>  
> >>      s->entries[arch][key].data = data;
> >>      s->entries[arch][key].len = (uint32_t)len;
> >>      s->entries[arch][key].read_callback = callback;
> >> @@ -626,11 +640,11 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, uint16_t key,
> >>      void *ptr;
> >>      int arch = !!(key & FW_CFG_ARCH_LOCAL);
> >>  
> >>      key &= FW_CFG_ENTRY_MASK;
> >>  
> >> -    assert(key < FW_CFG_MAX_ENTRY && len < UINT32_MAX);
> >> +    assert(key < fw_cfg_max_entry(s) && len < UINT32_MAX);
> >>  
> >>      /* return the old data to the function caller, avoid memory leak */
> >>      ptr = s->entries[arch][key].data;
> >>      s->entries[arch][key].data = data;
> >>      s->entries[arch][key].len = len;
> >> @@ -775,17 +789,17 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
> >>      size_t dsize;
> >>      MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
> >>      int order = 0;
> >>  
> >>      if (!s->files) {
> >> -        dsize = sizeof(uint32_t) + sizeof(FWCfgFile) * FW_CFG_FILE_SLOTS;
> >> +        dsize = sizeof(uint32_t) + sizeof(FWCfgFile) * fw_cfg_file_slots(s);
> >>          s->files = g_malloc0(dsize);
> >>          fw_cfg_add_bytes(s, FW_CFG_FILE_DIR, s->files, dsize);
> >>      }
> >>  
> >>      count = be32_to_cpu(s->files->count);
> >> -    assert(count < FW_CFG_FILE_SLOTS);
> >> +    assert(count < fw_cfg_file_slots(s));
> >>  
> >>      /* Find the insertion point. */
> >>      if (mc->legacy_fw_cfg_order) {
> >>          /*
> >>           * Sort by order. For files with the same order, we keep them
> >> @@ -855,11 +869,11 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
> >>      void *ptr = NULL;
> >>  
> >>      assert(s->files);
> >>  
> >>      index = be32_to_cpu(s->files->count);
> >> -    assert(index < FW_CFG_FILE_SLOTS);
> >> +    assert(index < fw_cfg_file_slots(s));
> >>  
> >>      for (i = 0; i < index; i++) {
> >>          if (strcmp(filename, s->files->f[i].name) == 0) {
> >>              ptr = fw_cfg_modify_bytes_read(s, FW_CFG_FILE_FIRST + i,
> >>                                             data, len);
> >> @@ -926,10 +940,16 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
> >>      qdev_prop_set_uint32(dev, "dma_iobase", dma_iobase);
> >>      if (!dma_requested) {
> >>          qdev_prop_set_bit(dev, "dma_enabled", false);
> >>      }
> >>  
> >> +    /* Once we expose the "file_slots" property to callers of
> >> +     * fw_cfg_init_io_dma(), the following setting should become conditional on
> >> +     * the input parameter being lower than the current value of the property.
> >> +     */
> >> +    qdev_prop_set_uint32(dev, "file_slots", FW_CFG_FILE_SLOTS_TRAD);
> >> +
> >>      fw_cfg_init1(dev);
> >>      s = FW_CFG(dev);
> >>  
> >>      if (s->dma_enabled) {
> >>          /* 64 bits for the address field */
> >> @@ -963,10 +983,17 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
> >>      qdev_prop_set_uint32(dev, "data_width", data_width);
> >>      if (!dma_requested) {
> >>          qdev_prop_set_bit(dev, "dma_enabled", false);
> >>      }
> >>  
> >> +    /* Once we expose the "file_slots" property to callers of
> >> +     * fw_cfg_init_mem_wide(), the following setting should become conditional
> >> +     * on the input parameter being lower than the current value of the
> >> +     * property. Refer to fw_cfg_init_io_dma().
> >> +     */
> >> +    qdev_prop_set_uint32(dev, "file_slots", FW_CFG_FILE_SLOTS_TRAD);  
> > both above cases of qdev_prop_set_uint32() could be replaced by
> > compat property for fwcfg device which would clamp "file_slots"
> > to old value for old machine types in a cleaner way.  
> 
> The unconditional qdev_prop_set_uint32() call is already replaced, in
> fw_cfg_init_io_dma(), in the next patch, and the compat properties are
> added in the patch after it.
> 
> The current approach is:
> - patch #2 adds the property with the raised default, but clamps it
>   down in code that calls fw_cfg_init1() directly
> - patch #3 propagates the clamping-down a little bit outwards, towards
>   board code, but only in the IO-port mapped case,
> - patch #4 adds the 2.8 compat props and raises the limit in 2.9 pc
>   board code (i.e., 2.9 pc opts in)
> 
> The point is that
> (a) no old machine type should see any change
> (b) even for new machine types, the higher file slot count is opt-in for
>     board code (i.e., it shouldn't affect callers of
>     fw_cfg_init_mem_wide() and fw_cfg_init_io())
I'm not sure that we need (b) (i.e. optin for new machine versions)
Maybe all new machine types should use new default and we should
clamp it down for all old machine types the same way (compat prop).
It would be uniform and less confusing possibly making series simpler.

> 
> The qdev_prop_set_uint32() call that unconditionally remains in
> fw_cfg_init_mem_wide() at the end of this series is for ensuring (b).
> 
> The "hw/arm/virt.c" board calls fw_cfg_init_mem_wide(), and that board
> should not receive the increased fw_cfg file count even in 2.9+ (to
> which the compat props would not apply).
> 
> In order to remove the unconditional property setting from
> fw_cfg_init_mem_wide() too, I'd either have to modify the
> fw_cfg_init_mem_wide() prototype and also the call site in
> "hw/arm/virt.c", or we'd have to carry forward the compat property to
> 2.9 and later, indefinitely.
> 
> I'm open to reworking this code, but both goals (a) and (b) should be
> considered in any alternative implementation.
> 
> Thanks!
> Laszlo
> 
> >   
> >> +
> >>      fw_cfg_init1(dev);
> >>  
> >>      sbd = SYS_BUS_DEVICE(dev);
> >>      sysbus_mmio_map(sbd, 0, ctl_addr);
> >>      sysbus_mmio_map(sbd, 1, data_addr);
> >> @@ -1012,23 +1039,56 @@ static const TypeInfo fw_cfg_info = {
> >>      .abstract      = true,
> >>      .instance_size = sizeof(FWCfgState),
> >>      .class_init    = fw_cfg_class_init,
> >>  };
> >>  
> >> +static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
> >> +{
> >> +    uint16_t file_slots_max;
> >> +
> >> +    if (fw_cfg_file_slots(s) < FW_CFG_FILE_SLOTS_TRAD) {
> >> +        error_setg(errp, "\"file_slots\" must be at least 0x%x",
> >> +                   FW_CFG_FILE_SLOTS_TRAD);
> >> +        return;
> >> +    }
> >> +
> >> +    /* (UINT16_MAX & FW_CFG_ENTRY_MASK) is the highest inclusive selector value
> >> +     * that we permit. The actual (exclusive) value coming from the
> >> +     * configuration is (FW_CFG_FILE_FIRST + fw_cfg_file_slots(s)). */
> >> +    file_slots_max = (UINT16_MAX & FW_CFG_ENTRY_MASK) - FW_CFG_FILE_FIRST + 1;
> >> +    if (fw_cfg_file_slots(s) > file_slots_max) {
> >> +        error_setg(errp, "\"file_slots\" must not exceed 0x%" PRIx16,
> >> +                   file_slots_max);
> >> +        return;
> >> +    }
> >> +
> >> +    s->entries[0] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
> >> +    s->entries[1] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
> >> +    s->entry_order = g_new0(int, fw_cfg_max_entry(s));
> >> +}
> >>  
> >>  static Property fw_cfg_io_properties[] = {
> >>      DEFINE_PROP_UINT32("iobase", FWCfgIoState, iobase, -1),
> >>      DEFINE_PROP_UINT32("dma_iobase", FWCfgIoState, dma_iobase, -1),
> >>      DEFINE_PROP_BOOL("dma_enabled", FWCfgIoState, parent_obj.dma_enabled,
> >>                       true),
> >> +    DEFINE_PROP_UINT32("file_slots", FWCfgIoState, parent_obj.file_slots,
> >> +                       FW_CFG_FILE_SLOTS_DFLT),
> >>      DEFINE_PROP_END_OF_LIST(),
> >>  };
> >>  
> >>  static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
> >>  {
> >>      FWCfgIoState *s = FW_CFG_IO(dev);
> >>      SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> >> +    Error *local_err = NULL;
> >> +
> >> +    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >>  
> >>      /* when using port i/o, the 8-bit data register ALWAYS overlaps
> >>       * with half of the 16-bit control register. Hence, the total size
> >>       * of the i/o region used is FW_CFG_CTL_SIZE */
> >>      memory_region_init_io(&s->comb_iomem, OBJECT(s), &fw_cfg_comb_mem_ops,
> >> @@ -1061,18 +1121,27 @@ static const TypeInfo fw_cfg_io_info = {
> >>  
> >>  static Property fw_cfg_mem_properties[] = {
> >>      DEFINE_PROP_UINT32("data_width", FWCfgMemState, data_width, -1),
> >>      DEFINE_PROP_BOOL("dma_enabled", FWCfgMemState, parent_obj.dma_enabled,
> >>                       true),
> >> +    DEFINE_PROP_UINT32("file_slots", FWCfgMemState, parent_obj.file_slots,
> >> +                       FW_CFG_FILE_SLOTS_DFLT),
> >>      DEFINE_PROP_END_OF_LIST(),
> >>  };
> >>  
> >>  static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
> >>  {
> >>      FWCfgMemState *s = FW_CFG_MEM(dev);
> >>      SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> >>      const MemoryRegionOps *data_ops = &fw_cfg_data_mem_ops;
> >> +    Error *local_err = NULL;
> >> +
> >> +    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >>  
> >>      memory_region_init_io(&s->ctl_iomem, OBJECT(s), &fw_cfg_ctl_mem_ops,
> >>                            FW_CFG(s), "fwcfg.ctl", FW_CFG_CTL_SIZE);
> >>      sysbus_init_mmio(sbd, &s->ctl_iomem);
> >>    
> >   
> 
