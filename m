Received: from eggs.gnu.org ([2001:4830:134:3::10]:53452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dLymv-0001hg-4P
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 17:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dLymq-0007GX-Vi
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 17:28:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dLymq-0007FD-MF
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 17:28:12 -0400
References: <1497619387-11333-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497619387-11333-6-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5aeecfd3-69be-eec2-240d-68624adb3ffc@redhat.com>
Date: Fri, 16 Jun 2017 23:28:03 +0200
MIME-Version: 1.0
In-Reply-To: <1497619387-11333-6-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4 5/5] fw_cfg: move QOM type defines and
 fw_cfg types into fw_cfg.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

On 06/16/17 15:23, Mark Cave-Ayland wrote:
> This allows the device to be instantiated externally for boards that
> wish to wire up the fw_cfg device themselves.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/nvram/fw_cfg.c         |   56 -------------------------------------------
>  include/hw/nvram/fw_cfg.h |   58 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 56 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index b5f10ac..00771c9 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -40,14 +40,6 @@
>  #define FW_CFG_NAME "fw_cfg"
>  #define FW_CFG_PATH "/machine/" FW_CFG_NAME
>  
> -#define TYPE_FW_CFG     "fw_cfg"
> -#define TYPE_FW_CFG_IO  "fw_cfg_io"
> -#define TYPE_FW_CFG_MEM "fw_cfg_mem"
> -
> -#define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
> -#define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
> -#define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
> -
>  /* FW_CFG_VERSION bits */
>  #define FW_CFG_VERSION      0x01
>  #define FW_CFG_VERSION_DMA  0x02
> @@ -61,54 +53,6 @@
>  
>  #define FW_CFG_DMA_SIGNATURE 0x51454d5520434647ULL /* "QEMU CFG" */
>  
> -typedef struct FWCfgEntry {
> -    uint32_t len;
> -    bool allow_write;
> -    uint8_t *data;
> -    void *callback_opaque;
> -    FWCfgReadCallback read_callback;
> -} FWCfgEntry;
> -
> -struct FWCfgState {
> -    /*< private >*/
> -    SysBusDevice parent_obj;
> -    /*< public >*/
> -
> -    uint16_t file_slots;
> -    FWCfgEntry *entries[2];
> -    int *entry_order;
> -    FWCfgFiles *files;
> -    uint16_t cur_entry;
> -    uint32_t cur_offset;
> -    Notifier machine_ready;
> -
> -    int fw_cfg_order_override;
> -
> -    bool dma_enabled;
> -    dma_addr_t dma_addr;
> -    AddressSpace *dma_as;
> -    MemoryRegion dma_iomem;
> -};
> -
> -struct FWCfgIoState {
> -    /*< private >*/
> -    FWCfgState parent_obj;
> -    /*< public >*/
> -
> -    MemoryRegion comb_iomem;
> -    uint32_t iobase, dma_iobase;
> -};
> -
> -struct FWCfgMemState {
> -    /*< private >*/
> -    FWCfgState parent_obj;
> -    /*< public >*/
> -
> -    MemoryRegion ctl_iomem, data_iomem;
> -    uint32_t data_width;
> -    MemoryRegionOps wide_data_ops;
> -};
> -
>  #define JPG_FILE 0
>  #define BMP_FILE 1
>  
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index b980cba..a16907a 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -3,6 +3,16 @@
>  
>  #include "exec/hwaddr.h"
>  #include "hw/nvram/fw_cfg_keys.h"
> +#include "hw/sysbus.h"
> +#include "sysemu/dma.h"
> +
> +#define TYPE_FW_CFG     "fw_cfg"
> +#define TYPE_FW_CFG_IO  "fw_cfg_io"
> +#define TYPE_FW_CFG_MEM "fw_cfg_mem"
> +
> +#define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
> +#define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
> +#define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
>  
>  typedef struct FWCfgFile {
>      uint32_t  size;        /* file size */
> @@ -35,6 +45,54 @@ typedef struct FWCfgDmaAccess {
>  
>  typedef void (*FWCfgReadCallback)(void *opaque);
>  
> +typedef struct FWCfgEntry {
> +    uint32_t len;
> +    bool allow_write;
> +    uint8_t *data;
> +    void *callback_opaque;
> +    FWCfgReadCallback read_callback;
> +} FWCfgEntry;
> +
> +struct FWCfgState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    uint16_t file_slots;
> +    FWCfgEntry *entries[2];
> +    int *entry_order;
> +    FWCfgFiles *files;
> +    uint16_t cur_entry;
> +    uint32_t cur_offset;
> +    Notifier machine_ready;
> +
> +    int fw_cfg_order_override;
> +
> +    bool dma_enabled;
> +    dma_addr_t dma_addr;
> +    AddressSpace *dma_as;
> +    MemoryRegion dma_iomem;
> +};
> +
> +struct FWCfgIoState {
> +    /*< private >*/
> +    FWCfgState parent_obj;
> +    /*< public >*/
> +
> +    MemoryRegion comb_iomem;
> +    uint32_t iobase, dma_iobase;
> +};
> +
> +struct FWCfgMemState {
> +    /*< private >*/
> +    FWCfgState parent_obj;
> +    /*< public >*/
> +
> +    MemoryRegion ctl_iomem, data_iomem;
> +    uint32_t data_width;
> +    MemoryRegionOps wide_data_ops;
> +};
> +
>  /**
>   * fw_cfg_add_bytes:
>   * @s: fw_cfg device being modified
> 

This patch is generally good, but I'd like to suggest improvements:

(1) In the commit message, please mention that we are exposing the
internals of FWCfgIoState and FWCfgMemState so that board code can map
the MemoryRegion fields (such as comb_iomem) *by name*.

(2) FWCfgEntry need not be moved from the C file to the header file,
since we never depend on the *size* of that structure. Instead, please
add a single line to "include/qemu/typedefs.h":

   typedef struct FWCfgEntry FWCfgEntry;

and modify

    typedef struct FWCfgEntry {
    ...
    } FWCfgEntry;

in "fw_cfg.c" to just

    struct FWCfgEntry {
    ...
    };

Then "fw_cfg.h" can simply include "typedefs.h" and say

    ...
    FWCfgEntry *entries[2];
    ...

IOW, it's fine to leave FWCfgEntry an incomplete type in "fw_cfg.h".

(3) When you fix up patch #1 like I requested, removing the
"FWCfgIoState.iobase" and "FWCfgIoState.dma_iobase" fields, please don't
forget to update this patch as well, so that you not re-introduce those
fields in the header file.

... I'm positively satisfied with this series (I plan to "grant" my R-b
for PATCH v5 5/5, with the above updates), but given that I'm no QOM
expert by any means, I'd like someone with more QOM experience to review
the patchset as well.

Thanks!
Laszlo
