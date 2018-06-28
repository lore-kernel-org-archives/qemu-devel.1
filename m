Received: from eggs.gnu.org ([2001:4830:134:3::10]:50144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fYUrQ-0003X8-4r
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fYUrL-00052S-Fo
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:13:12 -0400
Date: Thu, 28 Jun 2018 12:12:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180628111247.GB2536@work-vm>
References: <20180627232951.14725-1-laurent@vivier.eu>
	<20180627232951.14725-6-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627232951.14725-6-laurent@vivier.eu>
Subject: Re: [Qemu-devel] [RFC v3 05/10] hw/m68k: Apple Sound Chip (ASC)
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

* Laurent Vivier (laurent@vivier.eu) wrote:
> This is broken as the linux driver seems broken too...
> 
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---

> +static int asc_post_load(void *opaque, int version_id)
> +{
> +    return 0;
> +}

Why does that exist?

> +static const VMStateDescription vmstate_asc = {
> +    .name = "apple-sound-chip",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .minimum_version_id_old = 1,
> +    .post_load = asc_post_load,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};

Similarly, that doesn't have anything to migrate.

Dave

> +static void asc_reset(DeviceState *d)
> +{
> +    ASCState *s = ASC(d);
> +
> +    AUD_set_active_out(s->channel, 0);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +    s->a_wptr = 0;
> +    s->a_rptr = 0;
> +    s->a_cnt = 0;
> +    s->b_wptr = 0;
> +    s->b_rptr = 0;
> +    s->b_cnt = 0;
> +}
> +
> +static void asc_init(Object *obj)
> +{
> +    ASCState *s = ASC(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    struct audsettings as;
> +
> +    AUD_register_card("Apple Sound Chip", &s->card);
> +
> +    as.freq = 22257;
> +    as.nchannels = 2;
> +    as.fmt = AUD_FMT_S8;
> +    as.endianness = 0;
> +
> +    s->channel = AUD_open_out(&s->card, s->channel, "asc.out",
> +                              s, asc_out_cb, &as);
> +
> +    s->fifo = g_malloc0(ASC_BUF_SIZE);
> +
> +    memory_region_init_io(&s->mem_regs, NULL, &asc_mmio_ops, s, "asc",
> +                          ASC_LENGTH);
> +
> +    sysbus_init_irq(sbd, &s->irq);
> +    sysbus_init_mmio(sbd, &s->mem_regs);
> +}
> +
> +static Property asc_properties[] = {
> +    DEFINE_PROP_UINT8("asctype", ASCState, type, ASC_TYPE_ASC),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void asc_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->reset = asc_reset;
> +    dc->vmsd = &vmstate_asc;
> +    dc->props = asc_properties;
> +}
> +
> +static TypeInfo asc_info = {
> +    .name = TYPE_ASC,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(ASCState),
> +    .instance_init = asc_init,
> +    .class_init = asc_class_init,
> +};
> +
> +static void asc_register_types(void)
> +{
> +    type_register_static(&asc_info);
> +}
> +
> +type_init(asc_register_types)
> diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
> new file mode 100644
> index 0000000000..3540e32f69
> --- /dev/null
> +++ b/include/hw/audio/asc.h
> @@ -0,0 +1,48 @@
> +/*
> + *  Copyright (c) 2012-2018 Laurent Vivier <laurent@vivier.eu>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef HW_AUDIO_ASC_H
> +#define HW_AUDIO_ASC_H
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "audio/audio.h"
> +
> +enum {
> +    ASC_TYPE_ASC    = 0,  /* original discrete Apple Sound Chip */
> +    ASC_TYPE_EASC   = 1,  /* discrete Enhanced Apple Sound Chip */
> +    ASC_TYPE_V8     = 2,  /* ASC included in the V8 ASIC (LC/LCII) */
> +    ASC_TYPE_EAGLE  = 3,  /* ASC included in the Eagle ASIC (Classic II) */
> +    ASC_TYPE_SPICE  = 4,  /* ASC included in the Spice ASIC (Color Classic) */
> +    ASC_TYPE_SONORA = 5,  /* ASC included in the Sonora ASIC (LCIII) */
> +    ASC_TYPE_VASP   = 6,  /* ASC included in the VASP ASIC  (IIvx/IIvi) */
> +    ASC_TYPE_ARDBEG = 7   /* ASC included in the Ardbeg ASIC (LC520) */
> +};
> +
> +typedef struct ASCState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mem_regs;
> +    QEMUSoundCard card;
> +    SWVoiceOut *channel;
> +
> +    qemu_irq irq;
> +
> +    uint8_t type;
> +    int a_wptr, a_rptr, a_cnt;
> +    int b_wptr, b_rptr, b_cnt;
> +
> +    uint8_t *fifo;
> +
> +    uint8_t regs[48];
> +} ASCState;
> +
> +#define TYPE_ASC "apple-sound-chip"
> +#define ASC(obj) OBJECT_CHECK(ASCState, (obj), TYPE_ASC)
> +
> +#endif
> -- 
> 2.14.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
