Received: from eggs.gnu.org ([2001:4830:134:3::10]:57635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHbrV-00081d-6u
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:43:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHbrT-00061l-Fp
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:43:13 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA82Y3fWJyAUwOSxy6btutrS+FPa7sRm3AOKZM_GTcmBrA@mail.gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-12-andrew.smirnov@gmail.com>
	<CAFEAcA82Y3fWJyAUwOSxy6btutrS+FPa7sRm3AOKZM_GTcmBrA@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 22 Nov 2017 12:43:06 -0800
Message-ID: <CAHQ1cqHm1MRWaxh7v4EWgRraS4Ezrx2QdbH43ao_FOX3P6MZQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/30] sdhci: Add i.MX specific subtype
 of SDHCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Tue, Nov 21, 2017 at 10:02 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 6 November 2017 at 15:47, Andrey Smirnov <andrew.smirnov@gmail.com> wr=
ote:
>> IP block found on several generations of i.MX family does not use
>> vanilla SDHCI implementation and it comes with a number of quirks.
>>
>> Introduce i.MX SDHCI subtype of SDHCI block to add code necessary to
>> support unmodified Linux guest driver.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> Hi. Mostly this looks ok; some comments below.
>
>> ---
>>  hw/sd/sdhci-internal.h |  15 ++++++
>>  hw/sd/sdhci.c          | 127 ++++++++++++++++++++++++++++++++++++++++++=
++++++-
>>  include/hw/sd/sdhci.h  |   8 ++++
>>  3 files changed, 148 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
>> index 161177cf39..2a1b4b06ee 100644
>> --- a/hw/sd/sdhci-internal.h
>> +++ b/hw/sd/sdhci-internal.h
>> @@ -91,6 +91,8 @@
>>  #define SDHC_CTRL_ADMA2_32             0x10
>>  #define SDHC_CTRL_ADMA2_64             0x18
>>  #define SDHC_DMA_TYPE(x)               ((x) & SDHC_CTRL_DMA_CHECK_MASK)
>> +#define SDHC_CTRL_4BITBUS              0x02
>> +#define SDHC_CTRL_8BITBUS              0x20
>>
>>  /* R/W Power Control Register 0x0 */
>>  #define SDHC_PWRCON                    0x29
>> @@ -229,4 +231,17 @@ enum {
>>
>>  extern const VMStateDescription sdhci_vmstate;
>>
>> +
>> +#define ESDHC_MIX_CTRL                  0x48
>> +#define ESDHC_VENDOR_SPEC               0xc0
>> +#define ESDHC_DLL_CTRL                  0x60
>> +
>> +#define ESDHC_TUNING_CTRL               0xcc
>> +#define ESDHC_TUNE_CTRL_STATUS          0x68
>> +#define ESDHC_WTMK_LVL                  0x44
>> +
>> +#define ESDHC_CTRL_4BITBUS              (0x1 << 1)
>> +#define ESDHC_CTRL_8BITBUS              (0x2 << 1)
>> +
>> +
>>  #endif
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index 6d6a791ee9..f561cc44e3 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -265,7 +265,8 @@ static void sdhci_send_command(SDHCIState *s)
>>              }
>>          }
>>
>> -        if ((s->norintstsen & SDHC_NISEN_TRSCMP) &&
>> +        if (!(s->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
>> +            (s->norintstsen & SDHC_NISEN_TRSCMP) &&
>>              (s->cmdreg & SDHC_CMD_RESPONSE) =3D=3D SDHC_CMD_RSP_WITH_BU=
SY) {
>>              s->norintsts |=3D SDHC_NIS_TRSCMP;
>>          }
>> @@ -1191,6 +1192,8 @@ static void sdhci_initfn(SDHCIState *s)
>>
>>      s->insert_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_raise_in=
sertion_irq, s);
>>      s->transfer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_t=
ransfer, s);
>> +
>> +    s->io_ops =3D &sdhci_mmio_ops;
>>  }
>>
>>  static void sdhci_uninitfn(SDHCIState *s)
>> @@ -1347,7 +1350,7 @@ static void sdhci_sysbus_realize(DeviceState *dev,=
 Error ** errp)
>>      s->buf_maxsz =3D sdhci_get_fifolen(s);
>>      s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
>>      sysbus_init_irq(sbd, &s->irq);
>> -    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sd=
hci",
>> +    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, "sdhci",
>>              SDHC_REGISTERS_MAP_SIZE);
>>      sysbus_init_mmio(sbd, &s->iomem);
>>  }
>> @@ -1386,11 +1389,131 @@ static const TypeInfo sdhci_bus_info =3D {
>>      .class_init =3D sdhci_bus_class_init,
>>  };
>>
>> +static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
>> +{
>> +    SDHCIState *s =3D SYSBUS_SDHCI(opaque);
>> +    uint32_t ret;
>> +    uint16_t hostctl;
>> +
>> +    switch (offset) {
>> +    default:
>> +        return sdhci_read(opaque, offset, size);
>> +
>> +    case SDHC_HOSTCTL:
>> +        hostctl =3D SDHC_DMA_TYPE(s->hostctl) << 5;
>> +
>> +        if (s->hostctl & SDHC_CTRL_8BITBUS) {
>> +            hostctl |=3D ESDHC_CTRL_8BITBUS;
>> +        }
>> +
>> +        if (s->hostctl & SDHC_CTRL_4BITBUS) {
>> +            hostctl |=3D ESDHC_CTRL_4BITBUS;
>> +        }
>> +
>> +        ret =3D hostctl | (s->blkgap << 16) |
>> +            (s->wakcon << 24);
>> +
>> +        break;
>> +
>> +    case ESDHC_DLL_CTRL:
>> +    case ESDHC_TUNE_CTRL_STATUS:
>> +    case 0x6c:
>> +    case ESDHC_TUNING_CTRL:
>> +    case ESDHC_VENDOR_SPEC:
>> +    case ESDHC_MIX_CTRL:
>> +    case ESDHC_WTMK_LVL:
>> +        ret =3D 0;
>> +        break;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static void
>> +usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>> +{
>> +    SDHCIState *s =3D SYSBUS_SDHCI(opaque);
>> +    uint8_t hostctl =3D 0;
>> +    uint32_t value =3D (uint32_t)val;
>> +
>> +    switch (offset) {
>> +    case ESDHC_DLL_CTRL:
>> +    case ESDHC_TUNE_CTRL_STATUS:
>> +    case 0x6c:
>> +    case ESDHC_TUNING_CTRL:
>> +    case ESDHC_WTMK_LVL:
>> +    case ESDHC_VENDOR_SPEC:
>> +        break;
>> +
>> +    case SDHC_HOSTCTL:
>> +        if (value & ESDHC_CTRL_8BITBUS) {
>> +            hostctl |=3D SDHC_CTRL_8BITBUS;
>> +        }
>> +
>> +        if (value & ESDHC_CTRL_4BITBUS) {
>> +            hostctl |=3D ESDHC_CTRL_4BITBUS;
>> +        }
>> +
>> +        hostctl |=3D SDHC_DMA_TYPE(value >> 5);
>> +
>> +        value &=3D ~0xFE;
>> +        value |=3D hostctl;
>> +        value &=3D ~0xFF00;
>> +        value |=3D s->pwrcon;
>> +
>> +        sdhci_write(opaque, offset, value, size);
>
> This is pretty confusing, because we both mess about directly
> with the pwrcon field and also pass the write through
> to sdhci_write(). (a) some comments would help and

Sure, will do.

> (b) would it be clearer to just implement the different
> SDHC_HOSTCTL behaviour entirely here rather than trying to
> reuse the code in sdhci_write()? I get the impression that
> at least some of this is trying to shuffle stuff around so
> that code can unshuffle it.
>

Main reason I did this is because those bit transformations are the
inverse (or at least should be) of what Linux driver does in its
"SDHCI -> ESDHC" conversion code.

>> +        break;
>> +
>> +    case ESDHC_MIX_CTRL:
>> +        /*
>> +         * The layout of the register is slightly different, but we
>> +         * don't care about those bits
>> +         */
>> +        s->trnmod =3D value & 0xFFFF;
>> +        break;
>> +    case SDHC_TRNMOD:
>> +        sdhci_write(opaque, offset, val | s->trnmod, size);
>
> This one's simpler, but a comment would assist.
>

OK, will add.

>> +        break;
>> +    case SDHC_BLKSIZE:
>> +        val |=3D 0x7 << 12;
>> +    default:                    /* FALLTHROUGH */
>> +        sdhci_write(opaque, offset, val, size);
>> +        break;
>> +    }
>> +}
>> +
>> +
>> +static const MemoryRegionOps usdhc_mmio_ops =3D {
>> +    .read =3D usdhc_read,
>> +    .write =3D usdhc_write,
>> +    .valid =3D {
>> +        .min_access_size =3D 1,
>> +        .max_access_size =3D 4,
>> +        .unaligned =3D false
>> +    },
>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>> +};
>> +
>> +static void imx_usdhc_init(Object *obj)
>> +{
>> +    SDHCIState *s =3D SYSBUS_SDHCI(obj);
>> +
>> +    s->io_ops =3D &usdhc_mmio_ops;
>> +    s->quirks =3D SDHCI_QUIRK_NO_BUSY_IRQ;
>> +}
>> +
>> +static const TypeInfo imx_usdhc_info =3D {
>> +    .name =3D TYPE_IMX_USDHC,
>> +    .parent =3D TYPE_SYSBUS_SDHCI,
>> +    .instance_init =3D imx_usdhc_init,
>> +};
>> +
>>  static void sdhci_register_types(void)
>>  {
>>      type_register_static(&sdhci_pci_info);
>>      type_register_static(&sdhci_sysbus_info);
>>      type_register_static(&sdhci_bus_info);
>> +    type_register_static(&imx_usdhc_info);
>>  }
>>
>>  type_init(sdhci_register_types)
>> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
>> index 0f0c3f1e64..dc1856a33d 100644
>> --- a/include/hw/sd/sdhci.h
>> +++ b/include/hw/sd/sdhci.h
>> @@ -39,6 +39,7 @@ typedef struct SDHCIState {
>>      };
>>      SDBus sdbus;
>>      MemoryRegion iomem;
>> +    const MemoryRegionOps *io_ops;
>>
>>      QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
>>      QEMUTimer *transfer_timer;
>> @@ -83,8 +84,13 @@ typedef struct SDHCIState {
>>      /* Force Event Auto CMD12 Error Interrupt Reg - write only */
>>      /* Force Event Error Interrupt Register- write only */
>>      /* RO Host Controller Version Register always reads as 0x2401 */
>> +
>> +    unsigned long quirks;
>
> Don't use 'unsigned long', it differs in size from host to host.
>

OK, sure.

>>  } SDHCIState;
>>
>> +/* Controller does not provide transfer-complete interrupt when not bus=
y */
>> +#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
>
> We only have one quirk, so why is it bit 14?
>

I took that code from Linux kernel, so I tried to keep it as is (same
with unsigned long in quirks field).

Thanks,
Andrey Smirnov
