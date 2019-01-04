Received: from eggs.gnu.org ([208.118.235.92]:36961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfQAx-0000K2-JH
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfQAt-0006TP-Rq
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:10:13 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfQAs-0006Pk-6D
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:10:11 -0500
Received: by mail-ot1-x341.google.com with SMTP id v23so32160947otk.9
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 06:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20181209193742.7582-1-f4bug@amsat.org>
In-Reply-To: <20181209193742.7582-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 14:09:58 +0000
Message-ID: <CAFEAcA_nOm4gcuF0NgYtqgAfB1UaW1MFmcRCtWwrUr9-X+Xe8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm/allwinner-a10: Add the 'A' SRAM and
 the SRAM controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Beniamino Galvani <b.galvani@gmail.com>, Charlie Smurthwaite <charlie@atech.media>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Sun, 9 Dec 2018 at 19:37, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> From the "A10 User Manual V1.20" p.29: "3.2. Memory Mapping" and:
>
>  7. System Control
>   7.1. Overview
>
>   A10 embeds a high-speed SRAM which has been split into five segments.
>   See detailed memory mapping in following table:
>
>   Area          Address        Size (Bytes)
>    A1    0x00000000-0x00003FFF 16K
>    A2    0x00004000-0x00007FFF 16K
>    A3    0x00008000-0x0000B3FF 13K
>    A4    0x0000B400-0x0000BFFF  3K
>
> Since for emulation purpose we don't need the segmentations, we simply de=
fine
> the 'A' area as a single 48KB SRAM.

>  static void aw_a10_init(Object *obj)
>  {
> @@ -85,6 +86,10 @@ static void aw_a10_realize(DeviceState *dev, Error **e=
rrp)
>      sysbus_connect_irq(sysbusdev, 4, s->irq[67]);
>      sysbus_connect_irq(sysbusdev, 5, s->irq[68]);
>
> +    memory_region_init_ram(&s->sram_a, NULL, "sram A", 48 * KiB, &error_=
fatal);

This creates the memory region with a NULL owner, which is
OK for board model code, but since we're a device object
here we should use OBJECT(dev) as the owner.

This is more important if the region creation happens
in the instance_init function, in which case it will
result in a leak of the memory region after the device
is destroyed (see for instance commit 09d98b69804cfd9e),
but it's worth getting right here anyway.

> +    memory_region_add_subregion(get_system_memory(), 0x00000000, &s->sra=
m_a);
> +    create_unimplemented_device("a10-sram-ctrl", 0x01c00000, 4 * KiB);
> +
>      /* FIXME use qdev NIC properties instead of nd_table[] */
>      if (nd_table[0].used) {
>          qemu_check_nic_model(&nd_table[0], TYPE_AW_EMAC);

thanks
-- PMM
