Received: from eggs.gnu.org ([2001:4830:134:3::10]:50314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQXTW-0003mH-6E
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQXTU-00008h-Tt
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:46:50 -0500
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:33218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQXTU-00008X-PW
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:46:48 -0500
Received: by mail-ua0-x22a.google.com with SMTP id i68so354155818uad.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 02:46:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170104220624.26557-1-jcd@tribudubois.net>
References: <20170104220624.26557-1-jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 10:46:27 +0000
Message-ID: <CAFEAcA8dwhoSZTWS9JJ6-vSUs1Asw8ymktmD+oOqx0DNpCV2XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] [i.MX] fix CS handling during SPI
 access.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marcin_Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>

On 4 January 2017 at 22:06, Jean-Christophe Dubois <jcd@tribudubois.net> wr=
ote:
> The i.MX SPI device was not de-asserting the CS line at the end of
> memory access.
>
> This triggered a SIGSEGV in Qemu when the sabrelite emulator was acessing
> a SPI flash memory.
>
> Whith this path the CS signal is correctly asserted and deasserted arroun=
d
> memory access.
>
> Assertion level is now based on SPI device configuration.
>
> This was tested by:
> * booting linux on Sabrelite Qemu emulator.
> * booting xvisor on Sabrelite Qemu emultor.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> Acked-by: Marcin Krzemi=C5=84ski <mar.krzeminski@gmail.com>

>  static void imx_spi_reset(DeviceState *dev)
>  {
>      IMXSPIState *s =3D IMX_SPI(dev);
> +    uint32_t i;
>
>      DPRINTF("\n");
>
> @@ -243,6 +263,11 @@ static void imx_spi_reset(DeviceState *dev)
>      imx_spi_update_irq(s);
>
>      s->burst_length =3D 0;
> +
> +    /* Disable all CS lines */
> +    for (i =3D 0; i < 4; i++) {
> +        qemu_set_irq(s->cs_lines[i], !imx_spi_channel_pol(s, i));
> +    }

Calling qemu_set_irq() in a device reset function is a bit
tricky, because in a full system reset the device at the other
end might have already reset or might not, and calling into
its handler function for the irq line change might provoke
an unwanted change of its state. We don't really have a coherent
model here but for the moment we just try to avoid calling
set_irq in a reset method.

thanks
-- PMM
