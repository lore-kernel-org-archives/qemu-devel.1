Received: from eggs.gnu.org ([2001:4830:134:3::10]:57649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faZ5E-0002Me-La
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 00:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faZ5B-0006UA-ER
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 00:08:00 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faZ5B-0006Tv-8l
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 00:07:57 -0400
Received: by mail-qt0-x241.google.com with SMTP id l10-v6so3547076qtj.0
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 21:07:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1530047900.git.balaton@eik.bme.hu>
	<5891c3b9e3f878407dc5e9b2284eb68f4ee8cf55.1530047900.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a64fa167-0ac7-f094-3a60-3eb982aaf9ca@amsat.org>
Date: Wed, 4 Jul 2018 01:07:51 -0300
MIME-Version: 1.0
In-Reply-To: <5891c3b9e3f878407dc5e9b2284eb68f4ee8cf55.1530047900.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/7] sm501: Implement i2c part for
 reading monitor EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>

Hi Zoltan,

On 06/26/2018 06:18 PM, BALATON Zoltan wrote:
> Emulate the i2c part of SM501 which is used to access the EDID info
> from a monitor.
> 
> The vmstate structure is changed and its version is increased but
> SM501 is only used on SH and PPC sam460ex machines that don't support
> cross-version migration.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v2:
> - added constants for register bits
> - fix clearing error bit in reset reg
> - set max access size to 1
> v1: fixed build with SH
> 
>  default-configs/ppc-softmmu.mak    |   1 +
>  default-configs/ppcemb-softmmu.mak |   1 +
>  default-configs/sh4-softmmu.mak    |   2 +
>  default-configs/sh4eb-softmmu.mak  |   2 +
>  hw/display/sm501.c                 | 146 ++++++++++++++++++++++++++++++++++++-
>  5 files changed, 148 insertions(+), 4 deletions(-)
> 
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
> index b8b0526..e131e24 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -24,6 +24,7 @@ CONFIG_ETSEC=y
>  # For Sam460ex
>  CONFIG_USB_EHCI_SYSBUS=y
>  CONFIG_SM501=y
> +CONFIG_DDC=y
>  CONFIG_IDE_SII3112=y
>  CONFIG_I2C=y
>  CONFIG_BITBANG_I2C=y
> diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-softmmu.mak
> index 37af193..ac44f15 100644
> --- a/default-configs/ppcemb-softmmu.mak
> +++ b/default-configs/ppcemb-softmmu.mak
> @@ -17,6 +17,7 @@ CONFIG_XILINX=y
>  CONFIG_XILINX_ETHLITE=y
>  CONFIG_USB_EHCI_SYSBUS=y
>  CONFIG_SM501=y
> +CONFIG_DDC=y
>  CONFIG_IDE_SII3112=y
>  CONFIG_I2C=y
>  CONFIG_BITBANG_I2C=y
> diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
> index 546d855..caeccd5 100644
> --- a/default-configs/sh4-softmmu.mak
> +++ b/default-configs/sh4-softmmu.mak
> @@ -9,6 +9,8 @@ CONFIG_PFLASH_CFI02=y
>  CONFIG_SH4=y
>  CONFIG_IDE_MMIO=y
>  CONFIG_SM501=y
> +CONFIG_I2C=y
> +CONFIG_DDC=y
>  CONFIG_ISA_TESTDEV=y
>  CONFIG_I82378=y
>  CONFIG_I8259=y
> diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
> index 2d3fd49..53b9cd7 100644
> --- a/default-configs/sh4eb-softmmu.mak
> +++ b/default-configs/sh4eb-softmmu.mak
> @@ -9,6 +9,8 @@ CONFIG_PFLASH_CFI02=y
>  CONFIG_SH4=y
>  CONFIG_IDE_MMIO=y
>  CONFIG_SM501=y
> +CONFIG_I2C=y
> +CONFIG_DDC=y
>  CONFIG_ISA_TESTDEV=y
>  CONFIG_I82378=y
>  CONFIG_I8259=y
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 8206ae8..273495e 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -26,6 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qapi/error.h"
> +#include "qemu/log.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/hw.h"
> @@ -34,6 +35,8 @@
>  #include "hw/devices.h"
>  #include "hw/sysbus.h"
>  #include "hw/pci/pci.h"
> +#include "hw/i2c/i2c.h"
> +#include "hw/i2c/i2c-ddc.h"
>  #include "qemu/range.h"
>  #include "ui/pixel_ops.h"
>  
> @@ -216,6 +219,14 @@
>  #define SM501_I2C_SLAVE_ADDRESS         (0x03)
>  #define SM501_I2C_DATA                  (0x04)
>  
> +#define SM501_I2C_CONTROL_START         (1 << 2)
> +#define SM501_I2C_CONTROL_ENABLE        (1 << 0)
> +
> +#define SM501_I2C_STATUS_COMPLETE       (1 << 3)
> +#define SM501_I2C_STATUS_ERROR          (1 << 2)
> +
> +#define SM501_I2C_RESET_ERROR           (1 << 2)
> +
>  /* SSP base */
>  #define SM501_SSP                       (0x020000)
>  
> @@ -471,10 +482,12 @@ typedef struct SM501State {
>      MemoryRegion local_mem_region;
>      MemoryRegion mmio_region;
>      MemoryRegion system_config_region;
> +    MemoryRegion i2c_region;
>      MemoryRegion disp_ctrl_region;
>      MemoryRegion twoD_engine_region;
>      uint32_t last_width;
>      uint32_t last_height;
> +    I2CBus *i2c_bus;
>  
>      /* mmio registers */
>      uint32_t system_control;
> @@ -487,6 +500,11 @@ typedef struct SM501State {
>      uint32_t misc_timing;
>      uint32_t power_mode_control;
>  
> +    uint8_t i2c_byte_count;
> +    uint8_t i2c_status;
> +    uint8_t i2c_addr;
> +    uint8_t i2c_data[16];
> +
>      uint32_t uart0_ier;
>      uint32_t uart0_lcr;
>      uint32_t uart0_mcr;
> @@ -897,6 +915,109 @@ static const MemoryRegionOps sm501_system_config_ops = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> +static uint64_t sm501_i2c_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    SM501State *s = (SM501State *)opaque;
> +    uint8_t ret = 0;
> +
> +    switch (addr) {
> +    case SM501_I2C_BYTE_COUNT:
> +        ret = s->i2c_byte_count;
> +        break;
> +    case SM501_I2C_STATUS:
> +        ret = s->i2c_status;
> +        break;
> +    case SM501_I2C_SLAVE_ADDRESS:
> +        ret = s->i2c_addr;
> +        break;
> +    case SM501_I2C_DATA ... SM501_I2C_DATA + 15:
> +        ret = s->i2c_data[addr - SM501_I2C_DATA];
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "sm501 i2c : not implemented register read."
> +                      " addr=0x%" HWADDR_PRIx "\n", addr);
> +    }
> +
> +    SM501_DPRINTF("sm501 i2c regs : read addr=%" HWADDR_PRIx " val=%x\n",
> +                  addr, ret);
> +    return ret;
> +}
> +
> +static void sm501_i2c_write(void *opaque, hwaddr addr, uint64_t value,
> +                            unsigned size)
> +{
> +    SM501State *s = (SM501State *)opaque;
> +    SM501_DPRINTF("sm501 i2c regs : write addr=%" HWADDR_PRIx
> +                  " val=%" PRIx64 "\n", addr, value);
> +
> +    switch (addr) {
> +    case SM501_I2C_BYTE_COUNT:
> +        s->i2c_byte_count = value & 0xf;
> +        break;
> +    case SM501_I2C_CONTROL:
> +        if (value & SM501_I2C_CONTROL_ENABLE) {
> +            if (value & SM501_I2C_CONTROL_START) {
> +                int res = i2c_start_transfer(s->i2c_bus,
> +                                             s->i2c_addr >> 1,
> +                                             s->i2c_addr & 1);
> +                s->i2c_status |= (res ? SM501_I2C_STATUS_ERROR : 0);
> +                if (!res) {
> +                    int i;
> +                    SM501_DPRINTF("sm501 i2c : transferring %d bytes to 0x%x\n",
> +                                  s->i2c_byte_count + 1, s->i2c_addr >> 1);
> +                    for (i = 0; i <= s->i2c_byte_count; i++) {
> +                        res = i2c_send_recv(s->i2c_bus, &s->i2c_data[i],
> +                                            !(s->i2c_addr & 1));
> +                        if (res) {
> +                            SM501_DPRINTF("sm501 i2c : transfer failed"
> +                                          " i=%d, res=%d\n", i, res);
> +                            s->i2c_status |= (res ? SM501_I2C_STATUS_ERROR : 0);
> +                            return;
> +                        }
> +                    }
> +                    if (i) {
> +                        SM501_DPRINTF("sm501 i2c : transferred %d bytes\n", i);
> +                        s->i2c_status = SM501_I2C_STATUS_COMPLETE;
> +                    }
> +                }
> +            } else {
> +                SM501_DPRINTF("sm501 i2c : end transfer\n");
> +                i2c_end_transfer(s->i2c_bus);
> +                s->i2c_status &= ~SM501_I2C_STATUS_ERROR;
> +            }
> +        }
> +        break;
> +    case SM501_I2C_RESET:
> +        if ((value & SM501_I2C_RESET_ERROR) == 0) {
> +            s->i2c_status &= SM501_I2C_STATUS_ERROR;

Shouldn't be the negate mask?:

               s->i2c_status &= ~SM501_I2C_STATUS_ERROR;

> +        }
> +        break;
> +    case SM501_I2C_SLAVE_ADDRESS:
> +        s->i2c_addr = value & 0xff;
> +        break;
> +    case SM501_I2C_DATA ... SM501_I2C_DATA + 15:
> +        s->i2c_data[addr - SM501_I2C_DATA] = value & 0xff;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "sm501 i2c : not implemented register write. "
> +                      "addr=0x%" HWADDR_PRIx " val=%" PRIx64 "\n", addr, value);
> +    }
> +}
> +
> +static const MemoryRegionOps sm501_i2c_ops = {
> +    .read = sm501_i2c_read,
> +    .write = sm501_i2c_write,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,
> +    },
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,
> +    },
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
>  static uint32_t sm501_palette_read(void *opaque, hwaddr addr)
>  {
>      SM501State *s = (SM501State *)opaque;
> @@ -1577,6 +1698,10 @@ static void sm501_reset(SM501State *s)
>      s->irq_mask = 0;
>      s->misc_timing = 0;
>      s->power_mode_control = 0;
> +    s->i2c_byte_count = 0;
> +    s->i2c_status = 0;
> +    s->i2c_addr = 0;
> +    memset(s->i2c_data, 0, 16);

       memset(s->i2c_data, 0, sizeof(s->i2c_data));

>      s->dc_panel_control = 0x00010000; /* FIFO level 3 */
>      s->dc_video_control = 0;
>      s->dc_crt_control = 0x00010000;
> @@ -1615,6 +1740,11 @@ static void sm501_init(SM501State *s, DeviceState *dev,
>      memory_region_set_log(&s->local_mem_region, true, DIRTY_MEMORY_VGA);
>      s->local_mem = memory_region_get_ram_ptr(&s->local_mem_region);
>  
> +    /* i2c */
> +    s->i2c_bus = i2c_init_bus(dev, "sm501.i2c");

I'd appreciate a separator here:

       /* ddc */

> +    I2CDDCState *ddc = I2CDDC(qdev_create(BUS(s->i2c_bus), TYPE_I2CDDC));
> +    i2c_set_slave_address(I2C_SLAVE(ddc), 0x50);
> +
>      /* mmio */
>      memory_region_init(&s->mmio_region, OBJECT(dev), "sm501.mmio", MMIO_SIZE);
>      memory_region_init_io(&s->system_config_region, OBJECT(dev),
> @@ -1622,6 +1752,9 @@ static void sm501_init(SM501State *s, DeviceState *dev,
>                            "sm501-system-config", 0x6c);
>      memory_region_add_subregion(&s->mmio_region, SM501_SYS_CONFIG,
>                                  &s->system_config_region);
> +    memory_region_init_io(&s->i2c_region, OBJECT(dev), &sm501_i2c_ops, s,
> +                          "sm501-i2c", 0x14);
> +    memory_region_add_subregion(&s->mmio_region, SM501_I2C, &s->i2c_region);
>      memory_region_init_io(&s->disp_ctrl_region, OBJECT(dev),
>                            &sm501_disp_ctrl_ops, s,
>                            "sm501-disp-ctrl", 0x1000);
> @@ -1705,6 +1838,11 @@ static const VMStateDescription vmstate_sm501_state = {
>          VMSTATE_UINT32(twoD_destination_base, SM501State),
>          VMSTATE_UINT32(twoD_alpha, SM501State),
>          VMSTATE_UINT32(twoD_wrap, SM501State),
> +        /* Added in version 2 */
> +        VMSTATE_UINT8(i2c_byte_count, SM501State),
> +        VMSTATE_UINT8(i2c_status, SM501State),
> +        VMSTATE_UINT8(i2c_addr, SM501State),
> +        VMSTATE_UINT8_ARRAY(i2c_data, SM501State, 16),
>          VMSTATE_END_OF_LIST()
>       }
>  };
> @@ -1770,8 +1908,8 @@ static void sm501_reset_sysbus(DeviceState *dev)
>  
>  static const VMStateDescription vmstate_sm501_sysbus = {
>      .name = TYPE_SYSBUS_SM501,
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (VMStateField[]) {
>          VMSTATE_STRUCT(state, SM501SysBusState, 1,
>                         vmstate_sm501_state, SM501State),
> @@ -1843,8 +1981,8 @@ static void sm501_reset_pci(DeviceState *dev)
>  
>  static const VMStateDescription vmstate_sm501_pci = {
>      .name = TYPE_PCI_SM501,
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (VMStateField[]) {
>          VMSTATE_PCI_DEVICE(parent_obj, SM501PCIState),
>          VMSTATE_STRUCT(state, SM501PCIState, 1,
> 

With the negate mask in SM501_I2C_RESET:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
