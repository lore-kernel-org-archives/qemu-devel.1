Received: from eggs.gnu.org ([2001:4830:134:3::10]:46045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chMOj-0008KV-2x
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chMOf-00043T-0r
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:23:25 -0500
Date: Fri, 24 Feb 2017 21:23:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA8YGAyG3_uKwGJhff+ruearUP6eyQ0DROqZhGmdcaq6dw@mail.gmail.com>
Message-ID: <alpine.BSF.2.20.1702242118560.76443@zero.eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<c2915d0d2f3966ddb92005129b680727a69a3bcd.1487522123.git.balaton@eik.bme.hu>
	<CAFEAcA8YGAyG3_uKwGJhff+ruearUP6eyQ0DROqZhGmdcaq6dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 03/10] sm501: QOMify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, 24 Feb 2017, Peter Maydell wrote:
> On 19 February 2017 at 16:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/sm501.c   | 133 +++++++++++++++++++++++++++++++++++----------------
>>  hw/sh4/r2d.c         |  11 ++++-
>>  include/hw/devices.h |   5 --
>>  3 files changed, 101 insertions(+), 48 deletions(-)
>>
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index 4eb085c..b592022 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -58,8 +58,8 @@
>>  #define SM501_DPRINTF(fmt, ...) do {} while (0)
>>  #endif
>>
>> -
>>  #define MMIO_BASE_OFFSET 0x3e00000
>> +#define MMIO_SIZE 0x200000
>>
>>  /* SM501 register definitions taken from "linux/include/linux/sm501-regs.h" */
>>
>> @@ -464,6 +464,7 @@ typedef struct SM501State {
>>      uint32_t local_mem_size_index;
>>      uint8_t *local_mem;
>>      MemoryRegion local_mem_region;
>> +    MemoryRegion mmio_region;
>>      uint32_t last_width;
>>      uint32_t last_height;
>>
>> @@ -1396,20 +1397,14 @@ static const GraphicHwOps sm501_ops = {
>>      .gfx_update  = sm501_update_display,
>>  };
>>
>> -void sm501_init(MemoryRegion *address_space_mem, uint32_t base,
>> -                uint32_t local_mem_bytes, qemu_irq irq, Chardev *chr)
>> +static void sm501_init(SM501State *s, DeviceState *dev, uint32_t base,
>> +                       uint32_t local_mem_bytes)
>>  {
>> -    SM501State *s;
>> -    DeviceState *dev;
>> -    MemoryRegion *sm501_system_config = g_new(MemoryRegion, 1);
>> -    MemoryRegion *sm501_disp_ctrl = g_new(MemoryRegion, 1);
>> -    MemoryRegion *sm501_2d_engine = g_new(MemoryRegion, 1);
>> -
>> -    /* allocate management data region */
>> -    s = g_new0(SM501State, 1);
>> +    MemoryRegion *mr;
>> +
>>      s->base = base;
>>      s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
>> -    SM501_DPRINTF("local mem size=%x. index=%d\n", get_local_mem_size(s),
>> +    SM501_DPRINTF("sm501 local mem size=%x. index=%d\n", get_local_mem_size(s),
>>                    s->local_mem_size_index);
>>      s->system_control = 0x00100000; /* 2D engine FIFO empty */
>>      s->misc_control = SM501_MISC_IRQ_INVERT; /* assumes SH, active=low */
>> @@ -1417,46 +1412,102 @@ void sm501_init(MemoryRegion *address_space_mem, uint32_t base,
>>      s->dc_crt_control = 0x00010000;
>>
>>      /* allocate local memory */
>> -    memory_region_init_ram(&s->local_mem_region, NULL, "sm501.local",
>> +    memory_region_init_ram(&s->local_mem_region, OBJECT(dev), "sm501.local",
>>                             local_mem_bytes, &error_fatal);
>>      vmstate_register_ram_global(&s->local_mem_region);
>>      memory_region_set_log(&s->local_mem_region, true, DIRTY_MEMORY_VGA);
>>      s->local_mem = memory_region_get_ram_ptr(&s->local_mem_region);
>> -    memory_region_add_subregion(address_space_mem, base, &s->local_mem_region);
>> -
>> -    /* map mmio */
>> -    memory_region_init_io(sm501_system_config, NULL, &sm501_system_config_ops,
>> -                          s, "sm501-system-config", 0x6c);
>> -    memory_region_add_subregion(address_space_mem, base + MMIO_BASE_OFFSET,
>> -                                sm501_system_config);
>> -    memory_region_init_io(sm501_disp_ctrl, NULL, &sm501_disp_ctrl_ops, s,
>> +
>> +    /* allocate mmio */
>> +    memory_region_init(&s->mmio_region, OBJECT(dev), "sm501.mmio", MMIO_SIZE);
>> +    mr = g_new(MemoryRegion, 1);
>
> There's no need to dynamically allocate any of these memory regions;
> just make them be MemoryRegion fields inside SM501State.
>
>> +    memory_region_init_io(mr, OBJECT(dev), &sm501_system_config_ops, s,
>> +                          "sm501-system-config", 0x6c);
>> +    memory_region_add_subregion(&s->mmio_region, SM501_SYS_CONFIG, mr);
>> +    mr = g_new(MemoryRegion, 1);
>> +    memory_region_init_io(mr, OBJECT(dev), &sm501_disp_ctrl_ops, s,
>>                            "sm501-disp-ctrl", 0x1000);
>> -    memory_region_add_subregion(address_space_mem,
>> -                                base + MMIO_BASE_OFFSET + SM501_DC,
>> -                                sm501_disp_ctrl);
>> -    memory_region_init_io(sm501_2d_engine, NULL, &sm501_2d_engine_ops, s,
>> +    memory_region_add_subregion(&s->mmio_region, SM501_DC, mr);
>> +    mr = g_new(MemoryRegion, 1);
>> +    memory_region_init_io(mr, OBJECT(dev), &sm501_2d_engine_ops, s,
>>                            "sm501-2d-engine", 0x54);
>> -    memory_region_add_subregion(address_space_mem,
>> -                                base + MMIO_BASE_OFFSET + SM501_2D_ENGINE,
>> -                                sm501_2d_engine);
>> +    memory_region_add_subregion(&s->mmio_region, SM501_2D_ENGINE, mr);
>> +
>> +    /* create qemu graphic console */
>> +    s->con = graphic_console_init(DEVICE(dev), 0, &sm501_ops, s);
>> +}
>> +
>> +#define TYPE_SYSBUS_SM501 "sysbus-sm501"
>> +#define SYSBUS_SM501(obj) \
>> +    OBJECT_CHECK(SM501SysBusState, (obj), TYPE_SYSBUS_SM501)
>> +
>> +typedef struct {
>> +    /*< private >*/
>> +    SysBusDevice parent_obj;
>> +    /*< public >*/
>> +    SM501State state;
>> +    uint32_t vram_size;
>> +    uint32_t base;
>> +    void *chr_state;
>> +} SM501SysBusState;
>> +
>> +static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
>> +{
>> +    SM501SysBusState *s = SYSBUS_SM501(dev);
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> +    DeviceState *usb_dev;
>> +
>> +    sm501_init(&s->state, dev, s->base, s->vram_size);
>> +    sysbus_init_mmio(sbd, &s->state.local_mem_region);
>> +    sysbus_init_mmio(sbd, &s->state.mmio_region);
>>
>>      /* bridge to usb host emulation module */
>> -    dev = qdev_create(NULL, "sysbus-ohci");
>> -    qdev_prop_set_uint32(dev, "num-ports", 2);
>> -    qdev_prop_set_uint64(dev, "dma-offset", base);
>> -    qdev_init_nofail(dev);
>> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
>> -                    base + MMIO_BASE_OFFSET + SM501_USB_HOST);
>> -    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
>> +    usb_dev = qdev_create(NULL, "sysbus-ohci");
>> +    qdev_prop_set_uint32(usb_dev, "num-ports", 2);
>> +    qdev_prop_set_uint64(usb_dev, "dma-offset", s->base);
>> +    qdev_init_nofail(usb_dev);
>
> Why is a display controller device creating a USB controller?
> This looks like something that should be being done by the board.
>
>> +    memory_region_add_subregion(&s->state.mmio_region, SM501_USB_HOST,
>> +                       sysbus_mmio_get_region(SYS_BUS_DEVICE(usb_dev), 0));
>> +    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(usb_dev));
>>
>>      /* bridge to serial emulation module */
>> -    if (chr) {
>> -        serial_mm_init(address_space_mem,
>> -                       base + MMIO_BASE_OFFSET + SM501_UART0, 2,
>> +    if (s->chr_state) {
>> +        serial_mm_init(&s->state.mmio_region, SM501_UART0, 2,
>>                         NULL, /* TODO : chain irq to IRL */
>> -                       115200, chr, DEVICE_NATIVE_ENDIAN);
>> +                       115200, s->chr_state, DEVICE_NATIVE_ENDIAN);
>>      }
>> +}
>
> Similarly, what's going on here with the serial?

The SM501/SM502 is a multimedia chip that besides a display controller 
also contains some other functions (see 
http://cateee.net/lkddb/web-lkddb/MFD_SM501.html) and this is what is 
emulated here as these are part of the chip itself.

>
>>
>> -    /* create qemu graphic console */
>> -    s->con = graphic_console_init(DEVICE(dev), 0, &sm501_ops, s);
>> +static Property sm501_sysbus_properties[] = {
>> +    DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
>> +    DEFINE_PROP_UINT32("base", SM501SysBusState, base, 0),
>> +    DEFINE_PROP_PTR("chr-state", SM501SysBusState, chr_state),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>
>> +static void sm501_sysbus_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->realize = sm501_realize_sysbus;
>> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>> +    dc->desc = "SM501 Multimedia Companion";
>> +    dc->props = sm501_sysbus_properties;
>> +/* Note: pointer property "chr-state" may remain null, thus
>> + * no need for dc->cannot_instantiate_with_device_add_yet = true;
>> + */
>> }
>
> You also need a VMState struct registered in dc->vmsd and a reset
> function registered in dc->reset.

Even if no migration is supported? Is there a simple example I could look 
at on what should go into these?
