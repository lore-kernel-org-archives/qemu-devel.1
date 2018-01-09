Received: from eggs.gnu.org ([2001:4830:134:3::10]:41490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZ3AP-0008MW-Ql
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 18:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZ3AO-0001H3-Rh
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 18:18:49 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180108154303.6522-12-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
	<20180108154303.6522-12-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 9 Jan 2018 15:18:17 -0800
Message-ID: <CAKmqyKOOnwp6ExPCy+ZxcjrLUUMmfyaWex6CuyQJ6Urt97xBWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 11/31] hw/arm/exynos4210: use the
 "samsung, exynos4210-dw-mshc" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?Q?Gr=C3=A9gory_Estrade?= <gregory.estrade@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Clement Deschamps <clement.deschamps@antfield.fr>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Jan 8, 2018 at 7:42 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/exynos4210.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index e8e1d81e62..eb95131221 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -75,7 +75,6 @@
>  #define EXYNOS4210_INT_COMBINER_BASE_ADDR   0x10448000
>
>  /* SD/MMC host controllers */
> -#define EXYNOS4210_SDHCI_CAPABILITIES       0x05E80080
>  #define EXYNOS4210_SDHCI_BASE_ADDR          0x12510000
>  #define EXYNOS4210_SDHCI_ADDR(n)            (EXYNOS4210_SDHCI_BASE_ADDR =
+ \
>                                                  0x00010000 * (n))
> @@ -377,13 +376,10 @@ Exynos4210State *exynos4210_init(MemoryRegion *syst=
em_mem)
>          BlockBackend *blk;
>          DriveInfo *di;
>
> -        dev =3D qdev_create(NULL, TYPE_SYSBUS_SDHCI);
> -        qdev_prop_set_uint32(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITI=
ES);
> -        qdev_init_nofail(dev);
> -
> -        busdev =3D SYS_BUS_DEVICE(dev);
> -        sysbus_mmio_map(busdev, 0, EXYNOS4210_SDHCI_ADDR(n));
> -        sysbus_connect_irq(busdev, 0, s->irq_table[exynos4210_get_irq(29=
, n)]);
> +        dev =3D sysbus_create_varargs("samsung,exynos4210-dw-mshc",

Isn't this a legacy function, shouldn't we be moving away from it?

Alistair

> +                                    EXYNOS4210_SDHCI_ADDR(n),
> +                                    s->irq_table[exynos4210_get_irq(29, =
n)],
> +                                    NULL);
>
>          di =3D drive_get(IF_SD, 0, n);
>          blk =3D di ? blk_by_legacy_dinfo(di) : NULL;
> --
> 2.15.1
>
>
