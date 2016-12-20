Received: from eggs.gnu.org ([2001:4830:134:3::10]:60459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1cJMnw-0002Hc-Eu
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 10:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1cJMnt-0002FV-OS
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 10:58:16 -0500
Reply-To: marcel@redhat.com
References: <20161201170624.26496-1-lersek@redhat.com>
	<20161201170624.26496-2-lersek@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <be3f9b2a-8205-3550-4593-73604e91ca78@gmail.com>
Date: Tue, 20 Dec 2016 17:58:00 +0200
MIME-Version: 1.0
In-Reply-To: <20161201170624.26496-2-lersek@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/7] fw-cfg: support writeable blobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Gabriel L. Somlo" <somlo@cmu.edu>, Shannon Zhao <zhaoshenglong@huawei.com>, Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 12/01/2016 07:06 PM, Laszlo Ersek wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
>
> Useful to send guest data back to QEMU.
>
> Changes from Laszlo Ersek <lersek@redhat.com>:
> - rebase the patch from Michael Tsirkin's original postings at [1] and [2]
>   to the following patches:
>   - loader: Allow a custom AddressSpace when loading ROMs
>   - loader: Add AddressSpace loading support to uImages
>   - loader: fix handling of custom address spaces when adding ROM blobs
> - reject such writes immediately that would exceed the end of the array,
>   rather than performing a partial write before setting the error bit: see
>   the (len != dma.length) condition
> - document the write interface
>
> [1] http://lists.nongnu.org/archive/html/qemu-devel/2016-02/msg04968.html
> [2] http://lists.nongnu.org/archive/html/qemu-devel/2016-03/msg02735.html
>
> Cc: "Gabriel L. Somlo" <somlo@cmu.edu>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Shannon Zhao <zhaoshenglong@huawei.com>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  docs/specs/fw_cfg.txt     | 32 +++++++++++++++++++++++++-------
>  hw/lm32/lm32_hwsetup.h    |  2 +-
>  include/hw/loader.h       |  7 ++++---
>  include/hw/nvram/fw_cfg.h |  3 ++-
>  hw/arm/virt-acpi-build.c  |  2 +-
>  hw/core/loader.c          | 18 +++++++++++-------
>  hw/i386/acpi-build.c      |  4 ++--
>  hw/nvram/fw_cfg.c         | 37 +++++++++++++++++++++++++++++--------
>  8 files changed, 75 insertions(+), 30 deletions(-)
>
> diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
> index 7a5f8c7824ce..a19e2adbe1c6 100644
> --- a/docs/specs/fw_cfg.txt
> +++ b/docs/specs/fw_cfg.txt
> @@ -31,21 +31,25 @@ register. In other words, configuration write mode is enabled when
>  the selector value is between 0x4000-0x7fff or 0xc000-0xffff.
>
>  NOTE: As of QEMU v2.4, writes to the fw_cfg data register are no
>        longer supported, and will be ignored (treated as no-ops)!
>
> +NOTE: As of QEMU v2.9, writes are reinstated, but only through the DMA
> +      interface (see below). Furthermore, writeability of any specific item is
> +      governed independently of Bit14 in the selector key value.
> +
>  Bit15 of the selector register indicates whether the configuration
>  setting is architecture specific. A value of 0 means the item is a
>  generic configuration item. A value of 1 means the item is specific
>  to a particular architecture. In other words, generic configuration
>  items are accessed with a selector value between 0x0000-0x7fff, and
>  architecture specific configuration items are accessed with a selector
>  value between 0x8000-0xffff.
>
>  == Data Register ==
>
> -* Read/Write (writes ignored as of QEMU v2.4)
> +* Read/Write (writes ignored as of QEMU v2.4, but see the DMA interface)
>  * Location: platform dependent (IOport [*] or MMIO)
>  * Width: 8-bit (if IOport), 8/16/32/64-bit (if MMIO)
>  * Endianness: string-preserving
>
>  [*] On platforms where the data register is exposed as an IOport, its
> @@ -132,23 +136,25 @@ struct FWCfgFile {		/* an individual file entry, 64 bytes total */
>      char name[56];		/* fw_cfg item name, NUL-terminated ascii */
>  };
>
>  === All Other Data Items ===
>
> -Please consult the QEMU source for the most up-to-date and authoritative
> -list of selector keys and their respective items' purpose and format.
> +Please consult the QEMU source for the most up-to-date and authoritative list
> +of selector keys and their respective items' purpose, format and writeability.
>
>  === Ranges ===
>
>  Theoretically, there may be up to 0x4000 generic firmware configuration
>  items, and up to 0x4000 architecturally specific ones.
>
>  Selector Reg.    Range Usage
>  ---------------  -----------
> -0x0000 - 0x3fff  Generic (0x0000 - 0x3fff, RO)
> +0x0000 - 0x3fff  Generic (0x0000 - 0x3fff, generally RO, possibly RW through
> +                          the DMA interface in QEMU v2.9+)
>  0x4000 - 0x7fff  Generic (0x0000 - 0x3fff, RW, ignored in QEMU v2.4+)
> -0x8000 - 0xbfff  Arch. Specific (0x0000 - 0x3fff, RO)
> +0x8000 - 0xbfff  Arch. Specific (0x0000 - 0x3fff, generally RO, possibly RW
> +                                 through the DMA interface in QEMU v2.9+)
>  0xc000 - 0xffff  Arch. Specific (0x0000 - 0x3fff, RW, ignored in v2.4+)
>
>  In practice, the number of allowed firmware configuration items is given
>  by the value of FW_CFG_MAX_ENTRY (see fw_cfg.h).
>
> @@ -180,21 +186,31 @@ address is the "control" field.
>  The "control" field has the following bits:
>   - Bit 0: Error
>   - Bit 1: Read
>   - Bit 2: Skip
>   - Bit 3: Select. The upper 16 bits are the selected index.
> + - Bit 4: Write
>
>  When an operation is triggered, if the "control" field has bit 3 set, the
>  upper 16 bits are interpreted as an index of a firmware configuration item.
>  This has the same effect as writing the selector register.
>
>  If the "control" field has bit 1 set, a read operation will be performed.
>  "length" bytes for the current selector and offset will be copied into the
>  physical RAM address specified by the "address" field.
>
> -If the "control" field has bit 2 set (and not bit 1), a skip operation will be
> -performed. The offset for the current selector will be advanced "length" bytes.
> +If the "control" field has bit 4 set (and not bit 1), a write operation will be
> +performed. "length" bytes will be copied from the physical RAM address
> +specified by the "address" field to the current selector and offset. QEMU
> +prevents starting or finishing the write beyond the end of the item associated
> +with the current selector (i.e., the item cannot be resized). Truncated writes
> +are dropped entirely. Writes to read-only items are also rejected. All of these
> +write errors set bit 0 (the error bit) in the "control" field.
> +
> +If the "control" field has bit 2 set (and neither bit 1 nor bit 4), a skip
> +operation will be performed. The offset for the current selector will be
> +advanced "length" bytes.
>
>  To check the result, read the "control" field:
>     error bit set        ->  something went wrong.
>     all bits cleared     ->  transfer finished successfully.
>     otherwise            ->  transfer still in progress (doesn't happen
> @@ -232,5 +248,7 @@ For historical reasons, "opt/ovmf/" is reserved for OVMF firmware.
>
>  Prefix "opt/org.qemu/" is reserved for QEMU itself.
>
>  Use of names not beginning with "opt/" is potentially dangerous and
>  entirely unsupported.  QEMU will warn if you try.
> +
> +All externally provided fw_cfg items are read-only to the guest.
> diff --git a/hw/lm32/lm32_hwsetup.h b/hw/lm32/lm32_hwsetup.h
> index 23e18784dffd..a01f6bc5dfeb 100644
> --- a/hw/lm32/lm32_hwsetup.h
> +++ b/hw/lm32/lm32_hwsetup.h
> @@ -73,11 +73,11 @@ static inline void hwsetup_free(HWSetup *hw)
>
>  static inline void hwsetup_create_rom(HWSetup *hw,
>          hwaddr base)
>  {
>      rom_add_blob("hwsetup", hw->data, TARGET_PAGE_SIZE,
> -                 TARGET_PAGE_SIZE, base, NULL, NULL, NULL, NULL);
> +                 TARGET_PAGE_SIZE, base, NULL, NULL, NULL, NULL, true);
>  }
>
>  static inline void hwsetup_add_u8(HWSetup *hw, uint8_t u)
>  {
>      stb_p(hw->ptr, u);
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 0c864cfd6046..0dbd8d6bf37a 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -178,11 +178,12 @@ int rom_add_file(const char *file, const char *fw_dir,
>                   bool option_rom, MemoryRegion *mr, AddressSpace *as);
>  MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
>                             size_t max_len, hwaddr addr,
>                             const char *fw_file_name,
>                             FWCfgReadCallback fw_callback,
> -                           void *callback_opaque, AddressSpace *as);
> +                           void *callback_opaque, AddressSpace *as,
> +                           bool read_only);
>  int rom_add_elf_program(const char *name, void *data, size_t datasize,
>                          size_t romsize, hwaddr addr, AddressSpace *as);
>  int rom_check_and_register_reset(void);
>  void rom_set_fw(FWCfgState *f);
>  void rom_set_order_override(int order);
> @@ -192,19 +193,19 @@ void *rom_ptr(hwaddr addr);
>  void hmp_info_roms(Monitor *mon, const QDict *qdict);
>
>  #define rom_add_file_fixed(_f, _a, _i)          \
>      rom_add_file(_f, NULL, _a, _i, false, NULL, NULL)
>  #define rom_add_blob_fixed(_f, _b, _l, _a)      \
> -    rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, NULL)
> +    rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, NULL, true)
>  #define rom_add_file_mr(_f, _mr, _i)            \
>      rom_add_file(_f, NULL, 0, _i, false, _mr, NULL)
>  #define rom_add_file_as(_f, _as, _i)            \
>      rom_add_file(_f, NULL, 0, _i, false, NULL, _as)
>  #define rom_add_file_fixed_as(_f, _a, _i, _as)          \
>      rom_add_file(_f, NULL, _a, _i, false, NULL, _as)
>  #define rom_add_blob_fixed_as(_f, _b, _l, _a, _as)      \
> -    rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, _as)
> +    rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, _as, true)
>
>  #define PC_ROM_MIN_VGA     0xc0000
>  #define PC_ROM_MIN_OPTION  0xc8000
>  #define PC_ROM_MAX         0xe0000
>  #define PC_ROM_ALIGN       0x800
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index 5c27a1f0d50b..b980cbaebf43 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -134,10 +134,11 @@ void fw_cfg_add_file(FWCfgState *s, const char *filename, void *data,
>   * @filename: name of new fw_cfg file item
>   * @callback: callback function
>   * @callback_opaque: argument to be passed into callback function
>   * @data: pointer to start of item data
>   * @len: size of item data
> + * @read_only: is file read only
>   *
>   * Add a new NAMED fw_cfg item as a raw "blob" of the given size. The data
>   * referenced by the starting pointer is only linked, NOT copied, into the
>   * data structure of the fw_cfg device.
>   * The next available (unused) selector key starting at FW_CFG_FILE_FIRST
> @@ -149,11 +150,11 @@ void fw_cfg_add_file(FWCfgState *s, const char *filename, void *data,
>   * the fw_cfg control register, or passed to QEMU in FWCfgDmaAccess.control
>   * with FW_CFG_DMA_CTL_SELECT).
>   */
>  void fw_cfg_add_file_callback(FWCfgState *s, const char *filename,
>                                FWCfgReadCallback callback, void *callback_opaque,
> -                              void *data, size_t len);
> +                              void *data, size_t len, bool read_only);
>
>  /**
>   * fw_cfg_modify_file:
>   * @s: fw_cfg device being modified
>   * @filename: name of new fw_cfg file item
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index d4160dfa7d34..542fb67239db 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -807,11 +807,11 @@ static void virt_acpi_build_reset(void *build_opaque)
>  static MemoryRegion *acpi_add_rom_blob(AcpiBuildState *build_state,
>                                         GArray *blob, const char *name,
>                                         uint64_t max_size)
>  {
>      return rom_add_blob(name, blob->data, acpi_data_len(blob), max_size, -1,
> -                        name, virt_acpi_build_update, build_state, NULL);
> +                        name, virt_acpi_build_update, build_state, NULL, true);
>  }
>
>  static const VMStateDescription vmstate_virt_acpi_build = {
>      .name = "virt_acpi_build",
>      .version_id = 1,
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 45742494e6fd..ee5abd6eb7f4 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -851,20 +851,20 @@ static void fw_cfg_resized(const char *id, uint64_t length, void *host)
>      if (fw_cfg) {
>          fw_cfg_modify_file(fw_cfg, id + strlen("/rom@"), host, length);
>      }
>  }
>
> -static void *rom_set_mr(Rom *rom, Object *owner, const char *name)
> +static void *rom_set_mr(Rom *rom, Object *owner, const char *name, bool ro)
>  {
>      void *data;
>
>      rom->mr = g_malloc(sizeof(*rom->mr));
>      memory_region_init_resizeable_ram(rom->mr, owner, name,
>                                        rom->datasize, rom->romsize,
>                                        fw_cfg_resized,
>                                        &error_fatal);
> -    memory_region_set_readonly(rom->mr, true);
> +    memory_region_set_readonly(rom->mr, ro);
>      vmstate_register_ram_global(rom->mr);
>
>      data = memory_region_get_ram_ptr(rom->mr);
>      memcpy(data, rom->data, rom->datasize);
>
> @@ -940,11 +940,11 @@ int rom_add_file(const char *file, const char *fw_dir,
>          snprintf(fw_file_name, sizeof(fw_file_name), "%s/%s", rom->fw_dir,
>                   basename);
>          snprintf(devpath, sizeof(devpath), "/rom@%s", fw_file_name);
>
>          if ((!option_rom || mc->option_rom_has_mr) && mc->rom_file_has_mr) {
> -            data = rom_set_mr(rom, OBJECT(fw_cfg), devpath);
> +            data = rom_set_mr(rom, OBJECT(fw_cfg), devpath, true);
>          } else {
>              data = rom->data;
>          }
>
>          fw_cfg_add_file(fw_cfg, fw_file_name, data, rom->romsize);
> @@ -977,11 +977,11 @@ err:
>  }
>
>  MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
>                     size_t max_len, hwaddr addr, const char *fw_file_name,
>                     FWCfgReadCallback fw_callback, void *callback_opaque,
> -                   AddressSpace *as)
> +                   AddressSpace *as, bool read_only)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
>      Rom *rom;
>      MemoryRegion *mr = NULL;
>
> @@ -996,22 +996,26 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
>      rom_insert(rom);
>      if (fw_file_name && fw_cfg) {
>          char devpath[100];
>          void *data;
>
> -        snprintf(devpath, sizeof(devpath), "/rom@%s", fw_file_name);
> +        if (read_only) {
> +            snprintf(devpath, sizeof(devpath), "/rom@%s", fw_file_name);
> +        } else {
> +            snprintf(devpath, sizeof(devpath), "/ram@%s", fw_file_name);
> +        }
>
>          if (mc->rom_file_has_mr) {
> -            data = rom_set_mr(rom, OBJECT(fw_cfg), devpath);
> +            data = rom_set_mr(rom, OBJECT(fw_cfg), devpath, read_only);
>              mr = rom->mr;
>          } else {
>              data = rom->data;
>          }
>
>          fw_cfg_add_file_callback(fw_cfg, fw_file_name,
>                                   fw_callback, callback_opaque,
> -                                 data, rom->datasize);
> +                                 data, rom->datasize, read_only);
>      }
>      return mr;
>  }
>
>  /* This function is specific for elf program because we don't need to allocate
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9708cdc463df..965cb4cd4c51 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2934,11 +2934,11 @@ static void acpi_build_reset(void *build_opaque)
>  static MemoryRegion *acpi_add_rom_blob(AcpiBuildState *build_state,
>                                         GArray *blob, const char *name,
>                                         uint64_t max_size)
>  {
>      return rom_add_blob(name, blob->data, acpi_data_len(blob), max_size, -1,
> -                        name, acpi_build_update, build_state, NULL);
> +                        name, acpi_build_update, build_state, NULL, true);
>  }
>
>  static const VMStateDescription vmstate_acpi_build = {
>      .name = "acpi_build",
>      .version_id = 1,
> @@ -3000,11 +3000,11 @@ void acpi_setup(void)
>          uint32_t rsdp_size = acpi_data_len(tables.rsdp);
>
>          build_state->rsdp = g_memdup(tables.rsdp->data, rsdp_size);
>          fw_cfg_add_file_callback(pcms->fw_cfg, ACPI_BUILD_RSDP_FILE,
>                                   acpi_build_update, build_state,
> -                                 build_state->rsdp, rsdp_size);
> +                                 build_state->rsdp, rsdp_size, true);
>          build_state->rsdp_mr = NULL;
>      } else {
>          build_state->rsdp = NULL;
>          build_state->rsdp_mr = acpi_add_rom_blob(build_state, tables.rsdp,
>                                                    ACPI_BUILD_RSDP_FILE, 0);
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 3ebecb22606a..e0145c11a19b 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -52,15 +52,17 @@
>  /* FW_CFG_DMA_CONTROL bits */
>  #define FW_CFG_DMA_CTL_ERROR   0x01
>  #define FW_CFG_DMA_CTL_READ    0x02
>  #define FW_CFG_DMA_CTL_SKIP    0x04
>  #define FW_CFG_DMA_CTL_SELECT  0x08
> +#define FW_CFG_DMA_CTL_WRITE   0x10
>
>  #define FW_CFG_DMA_SIGNATURE 0x51454d5520434647ULL /* "QEMU CFG" */
>
>  typedef struct FWCfgEntry {
>      uint32_t len;
> +    bool allow_write;
>      uint8_t *data;
>      void *callback_opaque;
>      FWCfgReadCallback read_callback;
>  } FWCfgEntry;
>
> @@ -324,11 +326,11 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
>  {
>      dma_addr_t len;
>      FWCfgDmaAccess dma;
>      int arch;
>      FWCfgEntry *e;
> -    int read;
> +    int read = 0, write = 0;
>      dma_addr_t dma_addr;
>
>      /* Reset the address before the next access */
>      dma_addr = s->dma_addr;
>      s->dma_addr = 0;
> @@ -351,12 +353,17 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
>      e = (s->cur_entry == FW_CFG_INVALID) ? NULL :
>          &s->entries[arch][s->cur_entry & FW_CFG_ENTRY_MASK];
>
>      if (dma.control & FW_CFG_DMA_CTL_READ) {
>          read = 1;
> +        write = 0;
> +    } else if (dma.control & FW_CFG_DMA_CTL_WRITE) {
> +        read = 0;
> +        write = 1;
>      } else if (dma.control & FW_CFG_DMA_CTL_SKIP) {
>          read = 0;
> +        write = 0;
>      } else {
>          dma.length = 0;
>      }
>
>      dma.control = 0;
> @@ -372,11 +379,13 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
>              if (read) {
>                  if (dma_memory_set(s->dma_as, dma.address, 0, len)) {
>                      dma.control |= FW_CFG_DMA_CTL_ERROR;
>                  }
>              }
> -
> +            if (write) {
> +                dma.control |= FW_CFG_DMA_CTL_ERROR;
> +            }
>          } else {
>              if (dma.length <= (e->len - s->cur_offset)) {
>                  len = dma.length;
>              } else {
>                  len = (e->len - s->cur_offset);
> @@ -389,10 +398,18 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
>                  if (dma_memory_write(s->dma_as, dma.address,
>                                      &e->data[s->cur_offset], len)) {
>                      dma.control |= FW_CFG_DMA_CTL_ERROR;
>                  }
>              }
> +            if (write) {
> +                if (!e->allow_write ||
> +                    len != dma.length ||
> +                    dma_memory_read(s->dma_as, dma.address,
> +                                    &e->data[s->cur_offset], len)) {
> +                    dma.control |= FW_CFG_DMA_CTL_ERROR;
> +                }
> +            }
>
>              s->cur_offset += len;
>          }
>
>          dma.address += len;
> @@ -584,11 +601,12 @@ static const VMStateDescription vmstate_fw_cfg = {
>  };
>
>  static void fw_cfg_add_bytes_read_callback(FWCfgState *s, uint16_t key,
>                                             FWCfgReadCallback callback,
>                                             void *callback_opaque,
> -                                           void *data, size_t len)
> +                                           void *data, size_t len,
> +                                           bool read_only)
>  {
>      int arch = !!(key & FW_CFG_ARCH_LOCAL);
>
>      key &= FW_CFG_ENTRY_MASK;
>
> @@ -597,10 +615,11 @@ static void fw_cfg_add_bytes_read_callback(FWCfgState *s, uint16_t key,
>
>      s->entries[arch][key].data = data;
>      s->entries[arch][key].len = (uint32_t)len;
>      s->entries[arch][key].read_callback = callback;
>      s->entries[arch][key].callback_opaque = callback_opaque;
> +    s->entries[arch][key].allow_write = !read_only;
>  }
>
>  static void *fw_cfg_modify_bytes_read(FWCfgState *s, uint16_t key,
>                                                void *data, size_t len)
>  {
> @@ -614,17 +633,18 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, uint16_t key,
>      /* return the old data to the function caller, avoid memory leak */
>      ptr = s->entries[arch][key].data;
>      s->entries[arch][key].data = data;
>      s->entries[arch][key].len = len;
>      s->entries[arch][key].callback_opaque = NULL;
> +    s->entries[arch][key].allow_write = false;
>
>      return ptr;
>  }
>
>  void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t len)
>  {
> -    fw_cfg_add_bytes_read_callback(s, key, NULL, NULL, data, len);
> +    fw_cfg_add_bytes_read_callback(s, key, NULL, NULL, data, len, true);
>  }
>
>  void fw_cfg_add_string(FWCfgState *s, uint16_t key, const char *value)
>  {
>      size_t sz = strlen(value) + 1;
> @@ -747,11 +767,11 @@ static int get_fw_cfg_order(FWCfgState *s, const char *name)
>      return FW_CFG_ORDER_OVERRIDE_LAST;
>  }
>
>  void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
>                                FWCfgReadCallback callback, void *callback_opaque,
> -                              void *data, size_t len)
> +                              void *data, size_t len, bool read_only)
>  {
>      int i, index, count;
>      size_t dsize;
>      MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
>      int order = 0;
> @@ -809,11 +829,12 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
>              exit(1);
>          }
>      }
>
>      fw_cfg_add_bytes_read_callback(s, FW_CFG_FILE_FIRST + index,
> -                                   callback, callback_opaque, data, len);
> +                                   callback, callback_opaque, data, len,
> +                                   read_only);
>
>      s->files->f[index].size   = cpu_to_be32(len);
>      s->files->f[index].select = cpu_to_be16(FW_CFG_FILE_FIRST + index);
>      s->entry_order[index] = order;
>      trace_fw_cfg_add_file(s, index, s->files->f[index].name, len);
> @@ -822,11 +843,11 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
>  }
>
>  void fw_cfg_add_file(FWCfgState *s,  const char *filename,
>                       void *data, size_t len)
>  {
> -    fw_cfg_add_file_callback(s, filename, NULL, NULL, data, len);
> +    fw_cfg_add_file_callback(s, filename, NULL, NULL, data, len, true);
>  }
>
>  void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
>                          void *data, size_t len)
>  {
> @@ -845,11 +866,11 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
>              s->files->f[i].size   = cpu_to_be32(len);
>              return ptr;
>          }
>      }
>      /* add new one */
> -    fw_cfg_add_file_callback(s, filename, NULL, NULL, data, len);
> +    fw_cfg_add_file_callback(s, filename, NULL, NULL, data, len, true);
>      return NULL;
>  }
>
>  static void fw_cfg_machine_reset(void *opaque)
>  {
>

Hi Laszlo,
The 'write' documentation is very helpful, thanks.
I would add that QEMU will 'use' the written values
when the guest selects another file (for reading),
that being protocol specific, of course.
But maybe is not connected directly.

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
