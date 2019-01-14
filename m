Received: from eggs.gnu.org ([209.51.188.92]:53694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gj39R-0000OZ-V8
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gj39Q-0007nR-M9
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:23:41 -0500
References: <20190114130829.21790-1-philmd@redhat.com>
	<20190114130829.21790-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <fdbd9b49-fbb4-1339-9d59-591ad5891a44@redhat.com>
Date: Mon, 14 Jan 2019 15:23:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190114130829.21790-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] hw/nvram/fw_cfg: Remove various
 typedefs from "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>, Peter Maydell <peter.maydell@linaro.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "open list:Virt" <qemu-arm@nongnu.org>

Hi Phil,

On 01/14/19 14:08, Philippe Mathieu-Daud=C3=A9 wrote:
> There are only three include files requiring these typedefs, let them
> include "hw/nvram/fw_cfg.h" directly to simplify "qemu/typedefs.h".
>
> To clean "qemu/typedefs.h", move the declarations to "hw/nvram/fw_cfg.h=
".
> Reorder two function declarations to avoid forward typedef declarations=
.

No, this is not what I meant. I didn't suggest that we should remove
forward declarations.

I suggested that we should place the forward declarations *ahead of* the
first references to them:

  http://mid.mail-archive.com/32678400-47af-a842-0563-0d1a72712b4a@redhat=
.com

See below.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  include/hw/acpi/vmgenid.h |  1 +
>  include/hw/arm/virt.h     |  1 +
>  include/hw/mem/nvdimm.h   |  1 +
>  include/hw/nvram/fw_cfg.h | 22 ++++++++++++----------
>  include/qemu/typedefs.h   |  4 ----
>  5 files changed, 15 insertions(+), 14 deletions(-)

[...]

> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index f5a6895a74..cc744d5268 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -14,15 +14,12 @@
>  #define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG=
_IO)
>  #define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG=
_MEM)

On these lines, you have references to FWCfgState, FWCfgIoState,
FWCfgMemState. Pre-patch, that is OK, because you get the types via the
#includes, *and* the #include directives come first.

(Note: this is not about compilation safety; it is about how a human
reads this file.)

Post-patch, however:

>
> -typedef struct fw_cfg_file FWCfgFile;
> -
>  #define FW_CFG_ORDER_OVERRIDE_VGA    70
>  #define FW_CFG_ORDER_OVERRIDE_NIC    80
>  #define FW_CFG_ORDER_OVERRIDE_USER   100
>  #define FW_CFG_ORDER_OVERRIDE_DEVICE 110
>
> -void fw_cfg_set_order_override(FWCfgState *fw_cfg, int order);
> -void fw_cfg_reset_order_override(FWCfgState *fw_cfg);
> +typedef struct fw_cfg_file FWCfgFile;
>
>  typedef struct FWCfgFiles {
>      uint32_t  count;
> @@ -34,7 +31,9 @@ typedef struct fw_cfg_dma_access FWCfgDmaAccess;
>  typedef void (*FWCfgCallback)(void *opaque);
>  typedef void (*FWCfgWriteCallback)(void *opaque, off_t start, size_t l=
en);
>
> -struct FWCfgState {
> +typedef struct FWCfgEntry FWCfgEntry;
> +
> +typedef struct FWCfgState {
>      /*< private >*/
>      SysBusDevice parent_obj;
>      /*< public >*/
> @@ -53,17 +52,17 @@ struct FWCfgState {
>      dma_addr_t dma_addr;
>      AddressSpace *dma_as;
>      MemoryRegion dma_iomem;
> -};
> +} FWCfgState;
>
> -struct FWCfgIoState {
> +typedef struct FWCfgIoState {
>      /*< private >*/
>      FWCfgState parent_obj;
>      /*< public >*/
>
>      MemoryRegion comb_iomem;
> -};
> +} FWCfgIoState;
>
> -struct FWCfgMemState {
> +typedef struct FWCfgMemState {
>      /*< private >*/
>      FWCfgState parent_obj;
>      /*< public >*/
> @@ -71,7 +70,10 @@ struct FWCfgMemState {
>      MemoryRegion ctl_iomem, data_iomem;
>      uint32_t data_width;
>      MemoryRegionOps wide_data_ops;
> -};
> +} FWCfgMemState;
> +
> +void fw_cfg_set_order_override(FWCfgState *fw_cfg, int order);
> +void fw_cfg_reset_order_override(FWCfgState *fw_cfg);
>
>  /**
>   * fw_cfg_add_bytes:

the type names are introduced only later. Thus, when a human reads the
file, the type references in the OBJECT_CHECK() macros appear before the
same type names are introduced in any way.

What I meant, for v1, was simply:

> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index 244ed78afafb..063375e07b2d 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -5,20 +5,20 @@
>  #include "standard-headers/linux/qemu_fw_cfg.h"
>  #include "hw/sysbus.h"
>  #include "sysemu/dma.h"
>
> +typedef struct FWCfgState FWCfgState;
> +typedef struct FWCfgIoState FWCfgIoState;
> +typedef struct FWCfgMemState FWCfgMemState;
> +
>  #define TYPE_FW_CFG     "fw_cfg"
>  #define TYPE_FW_CFG_IO  "fw_cfg_io"
>  #define TYPE_FW_CFG_MEM "fw_cfg_mem"
>
>  #define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG=
)
>  #define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG=
_IO)
>  #define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG=
_MEM)
>
> -typedef struct FWCfgState FWCfgState;
> -typedef struct FWCfgIoState FWCfgIoState;
> -typedef struct FWCfgMemState FWCfgMemState;
> -
>  #define FW_CFG_ORDER_OVERRIDE_VGA    70
>  #define FW_CFG_ORDER_OVERRIDE_NIC    80
>  #define FW_CFG_ORDER_OVERRIDE_USER   100
>  #define FW_CFG_ORDER_OVERRIDE_DEVICE 110

Now, if you argued that this was not idiomatic for QEMU, or it was
undesirable for some other reason, that could be a valid observation,
and then we should discuss it further.

My point here is that I didn't intend my v1 suggestion as, or my R-b
for, the code that's visible in v2.

Thanks,
Laszlo
