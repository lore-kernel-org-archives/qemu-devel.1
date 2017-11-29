Received: from eggs.gnu.org ([2001:4830:134:3::10]:33390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eJz87-00052n-N4
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eJz84-0003pV-LI
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:58:11 -0500
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:46182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eJz84-0003nO-ET
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:58:08 -0500
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 78D08D3FB9
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 10:58:06 +0100 (CET)
References: <20171019151249.13663-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <17d7270b-9016-face-5fba-c6e321e92d88@kaod.org>
Date: Wed, 29 Nov 2017 10:58:00 +0100
MIME-Version: 1.0
In-Reply-To: <20171019151249.13663-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/8] aspeed: add a witherspoon-bmc
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 10/19/2017 05:12 PM, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> This series adds a new Aspeed machine to emulate the BMC of a
> Witherspoon system. It also extends the other Aspeed machines with I2C
> devices and adds a simple model for the pca9552 LED blinker present on
> the witherspoon board.
>=20
> Thanks,
>=20
> C.
>=20
> Changes since v4:
>=20
>  - use a ROM memory region
>=20
> Changes since v3:
>=20
>  - introduce a dummy ROM device to catch invalid writes
>  - removed 'ignore_memory_transaction_failures' on all Aspeed machines

So that was a bad idea because old firwmares run load/store loops
beyond the address space to guess how much RAM the SoC has. =20

I am wondering if it is possible to model the same behavior with
a MMIO region (of a correct size depending on the max ram size of=20
the SoC) and mapped beyond the RAM region to catch such accesses=20
and keep 'ignore_memory_transaction_failures' to false.=20
 =20
Thanks,

C.


>  - reworked PCA9552 device :
>    . simpler I2C handles
>    . auto-increment support
>    . unit test
>=20
> Changes since v2:
>=20
>  - removed comments on the I2C buffer size pf the PCA9552 device.
>  - removed 'ignore_memory_transaction_failures' flag on the
>    witherspoon machine.
>   =20
> Changes since v1:
>=20
>  - introduced smbus_eeprom_init_one()
>=20
> C=C3=A9dric Le Goater (8):
>   aspeed: use a ROM memory region to catch invalid writes
>   aspeed: remove ignore_memory_transaction_failures all boards
>   aspeed: add support for the witherspoon-bmc board
>   aspeed: add an I2C RTC device to all machines
>   smbus: add a smbus_eeprom_init_one() routine
>   aspeed: Add EEPROM I2C devices
>   misc: add pca9552 LED blinker model
>   aspeed: add the pc9552 chips to the witherspoon machine
>=20
>  default-configs/arm-softmmu.mak |   1 +
>  hw/arm/aspeed.c                 | 110 ++++++++++++++++-
>  hw/i2c/smbus_eeprom.c           |  16 ++-
>  hw/misc/Makefile.objs           |   1 +
>  hw/misc/pca9552.c               | 259 ++++++++++++++++++++++++++++++++=
++++++++
>  include/hw/i2c/smbus.h          |   1 +
>  include/hw/misc/pca9552.h       |  33 +++++
>  tests/Makefile.include          |   2 +
>  tests/pca9552-test.c            | 131 ++++++++++++++++++++
>  9 files changed, 544 insertions(+), 10 deletions(-)
>  create mode 100644 hw/misc/pca9552.c
>  create mode 100644 include/hw/misc/pca9552.h
>  create mode 100644 tests/pca9552-test.c
>=20
