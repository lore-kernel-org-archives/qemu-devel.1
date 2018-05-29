Received: from eggs.gnu.org ([2001:4830:134:3::10]:52734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNnja-0003DK-KQ
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNnjY-0008SE-Tf
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:08:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <eeaf7d84-71d0-b720-89c4-ca3c9536a68e@amsat.org>
Message-ID: <b19a920d-8c47-d018-6a2a-f2c43facd88e@amsat.org>
Date: Tue, 29 May 2018 20:08:22 -0300
MIME-Version: 1.0
In-Reply-To: <eeaf7d84-71d0-b720-89c4-ca3c9536a68e@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="f7daRM1mylxY9yuNerkO3QhttXwi0K9c2"
Subject: Re: [Qemu-devel] cmdline: How to connect a SD card to a specific SD
 controller?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f7daRM1mylxY9yuNerkO3QhttXwi0K9c2
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Thomas Huth <thuth@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Message-ID: <b19a920d-8c47-d018-6a2a-f2c43facd88e@amsat.org>
Subject: Re: cmdline: How to connect a SD card to a specific SD controller?
References: <eeaf7d84-71d0-b720-89c4-ca3c9536a68e@amsat.org>
In-Reply-To: <eeaf7d84-71d0-b720-89c4-ca3c9536a68e@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/28/2018 01:30 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> I'd like to connect a specific SD card to a specific SDHCI from command=

> line, and I'm getting a bit lost with command line options.
>=20
> I'm using an updated version of this patch, but this is not relevant to=

> this thread:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg01914.html
>=20
> In the following example, I'd like to connect an UHS-I enabled SD card
> to the first SHDCI of the Exynos4210 board (Nuri).
>=20
> I tried:
>=20
> $ ./arm-softmmu/qemu-system-arm -M nuri \
>   -device sd-card,id=3Dsd0,uhs=3D1 \
>   -drive if=3Dsd,id=3Dsd0,driver=3Dnull-co,size=3D4G \
>   -monitor stdio -S

Peter suggested on IRC to use:

  -drive if=3Dnone,id=3Dmydrive,... -device sd-card,...,drive=3Dmydrive

which indeed works enough for my tests:

  $ ./arm-softmmu/qemu-system-arm -M nuri \
    -drive if=3Dnone,id=3Dmydrive,driver=3Dnull-co,size=3D4G \
    -device sd-card,id=3Dsd0,uhs=3D1,drive=3Dmydrive \
    -monitor stdio -S

The same issues are still here but don't bother:

(qemu) info qtree
bus: main-system-bus
  type System
  dev: generic-sdhci, id ""
    gpio-out "sysbus-irq" 1
    sd-spec-version =3D 2 (0x2)
    uhs =3D 0 (0x0)
    capareg =3D 99090560 (0x5e80080)
    maxcurr =3D 0 (0x0)
    pending-insert-quirk =3D false
    dma =3D ""
    mmio 0000000012540000/0000000000000100
    bus: sd-bus
      type sdhci-bus
      dev: sd-card, id "sd0"
        drive =3D "mydrive"
        spi =3D false
        uhs =3D 1 (0x1)
      dev: sd-card, id ""
        drive =3D ""
        spi =3D false
        uhs =3D 0 (0x0)

        ^---- 2 cards

> But then the QTree looks unexpected:
>=20
> (qemu) info qtree
> bus: main-system-bus
>   type System
>   dev: generic-sdhci, id ""
>     gpio-out "sysbus-irq" 1
>     sd-spec-version =3D 2 (0x2)
>     uhs =3D 0 (0x0)
>     capareg =3D 99090560 (0x5e80080)
>     maxcurr =3D 0 (0x0)
>     pending-insert-quirk =3D false
>     dma =3D ""
>     mmio 0000000012540000/0000000000000100
>     bus: sd-bus
>       type sdhci-bus
>       dev: sd-card, id "sd0"
>         drive =3D ""
>         spi =3D false
>         uhs =3D 1 (0x1)
>       dev: sd-card, id ""
>         drive =3D ""
>         spi =3D false
>         uhs =3D 0 (0x0)
>=20
>       ^---- 2 cards
>=20
>   dev: generic-sdhci, id ""
>     gpio-out "sysbus-irq" 1
>     sd-spec-version =3D 2 (0x2)
>     uhs =3D 0 (0x0)
>     capareg =3D 99090560 (0x5e80080)
>     maxcurr =3D 0 (0x0)
>     pending-insert-quirk =3D false
>     dma =3D ""
>     mmio 0000000012530000/0000000000000100
>     bus: sd-bus
>       type sdhci-bus
>       dev: sd-card, id ""
>         drive =3D ""
>         spi =3D false
>         uhs =3D 0 (0x0)
>   dev: generic-sdhci, id ""
>     gpio-out "sysbus-irq" 1
>     sd-spec-version =3D 2 (0x2)
>     uhs =3D 0 (0x0)
>     capareg =3D 99090560 (0x5e80080)
>     maxcurr =3D 0 (0x0)
>     pending-insert-quirk =3D false
>     dma =3D ""
>     mmio 0000000012520000/0000000000000100
>     bus: sd-bus
>       type sdhci-bus
>       dev: sd-card, id ""
>         drive =3D ""
>         spi =3D false
>         uhs =3D 0 (0x0)
>   dev: generic-sdhci, id ""
>     gpio-out "sysbus-irq" 1
>     sd-spec-version =3D 2 (0x2)
>     uhs =3D 0 (0x0)
>     capareg =3D 99090560 (0x5e80080)
>     maxcurr =3D 0 (0x0)
>     pending-insert-quirk =3D false
>     dma =3D ""
>     mmio 0000000012510000/0000000000000100
>     bus: sd-bus
>       type sdhci-bus
>       dev: sd-card, id ""
>         drive =3D "sd0"
>=20
>         ^------- drive is here
>=20
>         spi =3D false
>         uhs =3D 0 (0x0)
>=20
> in hw/sd/core.c we have:
>=20
> static SDState *get_card(SDBus *sdbus)
> {
>     /* We only ever have one child on the bus so just return it */
>     BusChild *kid =3D QTAILQ_FIRST(&sdbus->qbus.children);
>=20
>     if (!kid) {
>         return NULL;
>     }
>     return SD_CARD(kid->child);
> }
>=20
> Spec v1 allow multiple cards per bus but Spec v2 (and up) restrict to 1=

> per bus.
>=20
>=20
> in exynos4210_init() we have:
>=20
>         di =3D drive_get(IF_SD, 0, n);
>         blk =3D di ? blk_by_legacy_dinfo(di) : NULL;
>         carddev =3D qdev_create(qdev_get_child_bus(dev, "sd-bus"),
> TYPE_SD_CARD);
>=20
> so there are no restriction in connecting various slaves to the same bu=
s.
>=20
> I also wonder about this drive_get(), is this an outdated API?
>=20
> Only used in 3 boards:
>=20
> $ git grep 'drive_get(IF_SD'
> hw/arm/exynos4210.c:397:        di =3D drive_get(IF_SD, 0, n);
> hw/arm/omap1.c:3990:    dinfo =3D drive_get(IF_SD, 0, 0);
> hw/arm/omap2.c:2489:    dinfo =3D drive_get(IF_SD, 0, 0);
> hw/arm/pxa2xx.c:2098:    dinfo =3D drive_get(IF_SD, 0, 0);
> hw/arm/pxa2xx.c:2222:    dinfo =3D drive_get(IF_SD, 0, 0);
>=20
> versus drive_get_next() used in others:
>=20
> hw/arm/mcimx7d-sabre.c:70:        di =3D drive_get_next(IF_SD);
> hw/arm/raspi.c:200:    di =3D drive_get_next(IF_SD);
> hw/arm/xilinx_zynq.c:269:        di =3D drive_get_next(IF_SD);
> hw/arm/xlnx-zcu102.c:114:        DriveInfo *di =3D drive_get_next(IF_SD=
);
> hw/sd/milkymist-memcard.c:279:    dinfo =3D drive_get_next(IF_SD);
> hw/sd/pl181.c:508:    dinfo =3D drive_get_next(IF_SD);
> hw/sd/ssi-sd.c:254:    dinfo =3D drive_get_next(IF_SD);
>=20
> Now trying with the PC machine:
>=20
> $ x86_64-softmmu/qemu-system-x86_64 -M pc \
>   -device sdhci-pci,id=3Dsdhci1 \
>   -device sdhci-pci,id=3Dsdhci2,sd-spec-version=3D3,uhs=3D2 \
>   -device sd-card,id=3Dsdcard0 \
>   -device sd-card,uhs=3D1,id=3Dsdcard1 \
>   -monitor stdio -S
>=20
> (qemu) info qtree
> bus: main-system-bus
>   type System
>   dev: i440FX-pcihost, id ""
>     bus: pci.0
>       type PCI
>       dev: sdhci-pci, id "sdhci2"
>         sd-spec-version =3D 3 (0x3)
>         uhs =3D 2 (0x2)
>         capareg =3D 91763892 (0x57834b4)
>         maxcurr =3D 0 (0x0)
>         addr =3D 05.0
>         romfile =3D ""
>         rombar =3D 1 (0x1)
>         multifunction =3D false
>         command_serr_enable =3D true
>         x-pcie-lnksta-dllla =3D true
>         x-pcie-extcap-init =3D true
>         class Class 0805, addr 00:05.0, pci id 1b36:0007 (sub 1af4:1100=
)
>         bar 0: mem at 0xffffffffffffffff [0xfe]
>         bus: sd-bus
>           type sdhci-bus
>           dev: sd-card, id "sdcard1"
>             drive =3D ""
>             spi =3D false
>             uhs =3D 1 (0x1)
>           dev: sd-card, id "sdcard0"
>             drive =3D ""
>             spi =3D false
>             uhs =3D 0 (0x0)
>=20
>           ^--- 2 cards...
>=20
>       dev: sdhci-pci, id "sdhci1"
>         sd-spec-version =3D 2 (0x2)
>         uhs =3D 0 (0x0)
>         capareg =3D 91763892 (0x57834b4)
>         maxcurr =3D 0 (0x0)
>         addr =3D 04.0
>         romfile =3D ""
>         rombar =3D 1 (0x1)
>         multifunction =3D false
>         command_serr_enable =3D true
>         x-pcie-lnksta-dllla =3D true
>         x-pcie-extcap-init =3D true
>         class Class 0805, addr 00:04.0, pci id 1b36:0007 (sub 1af4:1100=
)
>         bar 0: mem at 0xffffffffffffffff [0xfe]
>         bus: sd-bus
>           type sdhci-bus
>=20
>         ^--- no card
>=20
> And trying the -drive option:
>=20
> $ x86_64-softmmu/qemu-system-x86_64 -M pc \
>   -device sdhci-pci,id=3Dsdhci1 \
>   -device sdhci-pci,id=3Dsdhci2,sd-spec-version=3D3,uhs=3D2 \
>   -device sd-card,id=3Dsdcard0 \
>   -device sd-card,uhs=3D1,id=3Dsdcard1 \
>   -drive if=3Dsd,id=3Dsd0,driver=3Dnull-co,size=3D2G \
>   -drive if=3Dsd,id=3Dsd1,driver=3Dnull-co,size=3D4G
> qemu-system-x86_64: -drive if=3Dsd,id=3Dsd0,driver=3Dnull-co,size=3D2G:=
 machine
> type does not support if=3Dsd,bus=3D0,unit=3D0
> qemu-system-x86_64: -drive if=3Dsd,id=3Dsd1,driver=3Dnull-co,size=3D4G:=
 machine
> type does not support if=3Dsd,bus=3D0,unit=3D1
>=20
> How can I create the card with UHS-I enabled and connect it to the 2nd
> SDHCI?
>=20
> Thanks!
>=20
> Phil.
>=20


--f7daRM1mylxY9yuNerkO3QhttXwi0K9c2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsN3WwACgkQ4+MsLN6t
wN6FshAAiF5pffRWFwR+9DO+Y9YenLLEi5XyqudFmNglZgmcsLrrNC64Ui2A1Tc3
YLmJhsj9+j3+b/xvIFMH3DPNx2Vt6UhLcfkcklfzXXMb900XI8KeaNb+mqjLoo9u
znqDxWtq7Fd05+w+9HE5cg+kc4OZHe6tOfPdD9ynWADJlyCl0y/x10Msip28WAQW
7sEBchq1xjhik3ypNfsidV1n0zvJt1Z0w5dciHGzSZcOlZlzd+KifHPuSDsxVn63
8LUylhnzGo8v1V34NBSHnl7uZJhL58bvEQBhPbyXG2tW3+LskMt7fdPJEK7jaTIU
PLd4IFwSL3z2iT/qwuYPEl5kg/WP1J2mZYfalMybZMXLqiJTNKXi/zHLEDLrghWm
022+YUAQ9bJCqWmgQ8/gFDVC/k6Zzfe2kRf0PU0PIXxfh+/jnPRTGdpcoHN8sXh3
20i9C1LbqOZWGICvDVhMJqiNKtTsixfl0ogZmcssyhSFS4b632W7NmMqH0gTXrm9
F9cofhtmW8Zvm1IeCF3QG30zpS42gPYwON6HpMkwODGBoKLaFL+M5qL+AQt8eQ9m
c27RJiiPEeXjuB2Rd6DLwxgV8ywwRp6opcg0DxRSTGxWYeuze3tDdoiGqz9wWrTe
sAWQAKXf+53qMX1QMNhMEqHLMSR5VDjjUbdFU/41RPtB+dCEfNQ=
=DwqE
-----END PGP SIGNATURE-----

--f7daRM1mylxY9yuNerkO3QhttXwi0K9c2--
