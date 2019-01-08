Received: from eggs.gnu.org ([209.51.188.92]:54024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gguLt-000712-JV
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gguLs-0008Lo-Lm
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:35:41 -0500
References: <20190105144429.8702-1-stefanha@redhat.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <598e64e2-ea00-2ef3-ba21-1c5511aa6410@steffen-goertz.de>
Date: Tue, 8 Jan 2019 17:35:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190105144429.8702-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] arm: Stub out NRF51 TWI
 magnetometer/accelerometer detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: contrib@steffen-goertz.de, joel@jms.id.au, Peter Maydell <peter.maydell@linaro.org>, jusual@mail.ru, qemu-arm@nongnu.org, jim@groklearning.com

Signed-off by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>

On 05.01.19 15:44, Stefan Hajnoczi wrote:
> From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
>=20
> Recent microbit firmwares panic if the TWI magnetometer/accelerometer
> devices are not detected during startup.  We don't implement TWI (I2C)
> so let's stub out these devices just to let the firmware boot.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Based-on: <20190103091119.9367-1-stefanha@redhat.com>
> ---
> Steffen: Please post your Signed-off-by.  I did some minor cleanups so
> your patch can be merged.  Thanks!
>=20
>  include/hw/arm/nrf51.h     |  1 +
>  include/hw/arm/nrf51_soc.h |  1 +
>  hw/arm/nrf51_soc.c         | 62 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+)
>=20
> diff --git a/include/hw/arm/nrf51.h b/include/hw/arm/nrf51.h
> index 175bb6c301..5411121b66 100644
> --- a/include/hw/arm/nrf51.h
> +++ b/include/hw/arm/nrf51.h
> @@ -25,6 +25,7 @@
>  #define NRF51_IOMEM_SIZE      0x20000000
> =20
>  #define NRF51_UART_BASE       0x40002000
> +#define NRF51_TWI_BASE        0x40003000
>  #define NRF51_TIMER_BASE      0x40008000
>  #define NRF51_TIMER_SIZE      0x00001000
>  #define NRF51_RNG_BASE        0x4000D000
> diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
> index e06f0304b4..fbdefc07e4 100644
> --- a/include/hw/arm/nrf51_soc.h
> +++ b/include/hw/arm/nrf51_soc.h
> @@ -39,6 +39,7 @@ typedef struct NRF51State {
>      MemoryRegion sram;
>      MemoryRegion flash;
>      MemoryRegion clock;
> +    MemoryRegion twi;
> =20
>      uint32_t sram_size;
>      uint32_t flash_size;
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index 1630c27594..265438f916 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -32,6 +32,11 @@
>  #define NRF51822_FLASH_SIZE     (256 * NRF51_PAGE_SIZE)
>  #define NRF51822_SRAM_SIZE      (16 * NRF51_PAGE_SIZE)
> =20
> +#define NRF51_TWI_EVENT_STOPPED 0x104
> +#define NRF51_TWI_EVENT_RXDREADY 0x108
> +#define NRF51_TWI_EVENT_TXDSENT 0x11c
> +#define NRF51_TWI_REG_RXD 0x518
> +
>  #define BASE_TO_IRQ(base) ((base >> 12) & 0x1F)
> =20
>  static uint64_t clock_read(void *opaque, hwaddr addr, unsigned int siz=
e)
> @@ -53,6 +58,58 @@ static const MemoryRegionOps clock_ops =3D {
>      .write =3D clock_write
>  };
> =20
> +/* Two-Wire Interface (TWI) is not implemented but the microbit-dal fi=
rmware
> + * panics if the TWI accelerometer and magnetometer WHO_AM_I registers=
 cannot
> + * be read.  Stub out this read sequence so microbit-dal starts up.
> + */
> +static uint32_t twi_read_sequence[] =3D {0x5A, 0x5A, 0x40};
> +static uint32_t twi_regs[0x1000 / 4];
> +
> +static uint64_t twi_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    static int i;
> +    uint64_t data =3D 0x00;
> +
> +    switch (addr) {
> +    case NRF51_TWI_EVENT_STOPPED:
> +        data =3D 0x01;
> +        break;
> +    case NRF51_TWI_EVENT_RXDREADY:
> +        data =3D 0x01;
> +        break;
> +    case NRF51_TWI_EVENT_TXDSENT:
> +        data =3D 0x01;
> +        break;
> +    case NRF51_TWI_REG_RXD:
> +        data =3D twi_read_sequence[i];
> +        if (i < ARRAY_SIZE(twi_read_sequence)) {
> +            i++;
> +        }
> +        break;
> +    default:
> +        data =3D twi_regs[addr / 4];
> +        break;
> +    }
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u] =3D %" PRIx3=
2 "\n",
> +                  __func__, addr, size, (uint32_t)data);
> +
> +
> +    return data;
> +}
> +
> +static void twi_write(void *opaque, hwaddr addr, uint64_t data,
> +                      unsigned int size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " =
[%u]\n",
> +                  __func__, addr, data, size);
> +    twi_regs[addr / 4] =3D data;
> +}
> +
> +static const MemoryRegionOps twi_ops =3D {
> +    .read =3D twi_read,
> +    .write =3D twi_write
> +};
> =20
>  static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
>  {
> @@ -156,6 +213,11 @@ static void nrf51_soc_realize(DeviceState *dev_soc=
, Error **errp)
>      memory_region_add_subregion_overlap(&s->container,
>                                          NRF51_IOMEM_BASE, &s->clock, -=
1);
> =20
> +    memory_region_init_io(&s->twi, NULL, &twi_ops, NULL,
> +                          "nrf51_soc.twi", 0x1000);
> +    memory_region_add_subregion_overlap(&s->container,
> +                                        NRF51_TWI_BASE, &s->twi, -1);
> +
>      create_unimplemented_device("nrf51_soc.io", NRF51_IOMEM_BASE,
>                                  NRF51_IOMEM_SIZE);
>      create_unimplemented_device("nrf51_soc.ficr", NRF51_FICR_BASE,
>=20
