Received: from eggs.gnu.org ([209.51.188.92]:40013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggpwG-0002uF-UO
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:52:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggpwF-0006MM-Pq
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:52:56 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggpwF-0006HV-Gc
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:52:55 -0500
Received: by mail-ot1-x342.google.com with SMTP id t5so3248507otk.1
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 03:52:54 -0800 (PST)
MIME-Version: 1.0
References: <20190105144429.8702-1-stefanha@redhat.com>
In-Reply-To: <20190105144429.8702-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 11:52:42 +0000
Message-ID: <CAFEAcA_NiH6Gj1_R6yUXKsgRjhnpqkYJ=84Ugd9t_mPd+af5Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim@groklearning.com>

On Sat, 5 Jan 2019 at 15:02, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
>
> Recent microbit firmwares panic if the TWI magnetometer/accelerometer
> devices are not detected during startup.  We don't implement TWI (I2C)
> so let's stub out these devices just to let the firmware boot.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Based-on: <20190103091119.9367-1-stefanha@redhat.com>
> ---
> Steffen: Please post your Signed-off-by.  I did some minor cleanups so
> your patch can be merged.  Thanks!
>
>  include/hw/arm/nrf51.h     |  1 +
>  include/hw/arm/nrf51_soc.h |  1 +
>  hw/arm/nrf51_soc.c         | 62 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+)

>
> +/* Two-Wire Interface (TWI) is not implemented but the microbit-dal firm=
ware
> + * panics if the TWI accelerometer and magnetometer WHO_AM_I registers c=
annot
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
> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u] =3D %" PRIx32 =
"\n",
> +                  __func__, addr, size, (uint32_t)data);
> +
> +
> +    return data;
> +}
> +
> +static void twi_write(void *opaque, hwaddr addr, uint64_t data,
> +                      unsigned int size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%=
u]\n",
> +                  __func__, addr, data, size);
> +    twi_regs[addr / 4] =3D data;
> +}
> +
> +static const MemoryRegionOps twi_ops =3D {
> +    .read =3D twi_read,
> +    .write =3D twi_write
> +};

Can you put this in its own device in its own source file,
please? This is too much device-specific code to have
in the SoC's source file.

thanks
-- PMM
