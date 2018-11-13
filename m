Received: from eggs.gnu.org ([2001:4830:134:3::10]:45480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMSN0-0005vd-Dk
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 01:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMSMw-0004g3-CA
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 01:40:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gMSMw-0004eK-2f
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 01:40:14 -0500
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
	<20181112214224.31560-8-contrib@steffen-goertz.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3b9c8331-c84a-414a-8ff3-905a9e4b3779@redhat.com>
Date: Tue, 13 Nov 2018 07:40:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181112214224.31560-8-contrib@steffen-goertz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 07/14] tests: Add bbc:microbit / nRF51
 test suite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On 2018-11-12 22:42, Steffen G=C3=B6rtz wrote:
> The microbit-test includes tests for the nRF51 NVMC
> peripheral and will host future nRF51 peripheral tests
> and board-level bbc:microbit tests.
>=20
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/Makefile.include |   2 +
>  tests/microbit-test.c  | 133 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 135 insertions(+)
>  create mode 100644 tests/microbit-test.c
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index f77a495109..602346eeed 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -274,6 +274,7 @@ check-qtest-sparc64-y +=3D tests/boot-serial-test$(=
EXESUF)
>  check-qtest-arm-y +=3D tests/tmp105-test$(EXESUF)
>  check-qtest-arm-y +=3D tests/pca9552-test$(EXESUF)
>  check-qtest-arm-y +=3D tests/ds1338-test$(EXESUF)
> +check-qtest-arm-y +=3D tests/microbit-test$(EXESUF)
>  check-qtest-arm-y +=3D tests/m25p80-test$(EXESUF)
>  check-qtest-arm-y +=3D tests/virtio-blk-test$(EXESUF)
>  check-qtest-arm-y +=3D tests/test-arm-mptimer$(EXESUF)
> @@ -695,6 +696,7 @@ tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boo=
t-sector.o $(libqos-obj-y)
>  tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
>  tests/pca9552-test$(EXESUF): tests/pca9552-test.o $(libqos-omap-obj-y)
>  tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
> +tests/microbit-test$(EXESUF): tests/microbit-test.o
>  tests/m25p80-test$(EXESUF): tests/m25p80-test.o
>  tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
>  tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
> diff --git a/tests/microbit-test.c b/tests/microbit-test.c
> new file mode 100644
> index 0000000000..40b8b4bc64
> --- /dev/null
> +++ b/tests/microbit-test.c
> @@ -0,0 +1,133 @@
> + /*
> + * QTest testcase for Microbit board using the Nordic Semiconductor nR=
F51 SoC.
> + *
> + * nRF51:
> + * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.=
0.pdf
> + * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1=
.pdf
> + *
> + * Microbit Board: http://microbit.org/
> + *
> + * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +
> +#include "qemu/osdep.h"
> +#include "exec/hwaddr.h"
> +#include "libqtest.h"
> +
> +#include "hw/arm/nrf51.h"
> +#include "hw/nvram/nrf51_nvm.h"
> +
> +#define FLASH_SIZE          (256 * NRF51_PAGE_SIZE)
> +
> +static void fill_and_erase(hwaddr base, hwaddr size, uint32_t address_=
reg)
> +{
> +    hwaddr i;
> +
> +    /* Erase Page */
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
> +    writel(NRF51_NVMC_BASE + address_reg, base);
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
> +
> +    /* Check memory */
> +    for (i =3D 0; i < size / 4; i++) {
> +        g_assert_cmpuint(readl(base + i * 4), =3D=3D, 0xFFFFFFFF);
> +    }
> +
> +    /* Fill memory */
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
> +    for (i =3D 0; i < size / 4; i++) {
> +        writel(base + i * 4, i);
> +        g_assert_cmpuint(readl(base + i * 4), =3D=3D, i);
> +    }
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
> +}
> +
> +static void test_nrf51_nvmc(void)
> +{
> +    uint32_t value;
> +    hwaddr i;
> +
> +    /* Test always ready */
> +    value =3D readl(NRF51_NVMC_BASE + NRF51_NVMC_READY);
> +    g_assert_cmpuint(value & 0x01, =3D=3D, 0x01);
> +
> +    /* Test write-read config register */
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x03);
> +    g_assert_cmpuint(readl(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG), =3D=3D=
, 0x03);
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
> +    g_assert_cmpuint(readl(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG), =3D=3D=
, 0x00);
> +
> +    /* Test PCR0 */
> +    fill_and_erase(NRF51_FLASH_BASE, NRF51_PAGE_SIZE, NRF51_NVMC_ERASE=
PCR0);
> +    fill_and_erase(NRF51_FLASH_BASE + NRF51_PAGE_SIZE,
> +                   NRF51_PAGE_SIZE, NRF51_NVMC_ERASEPCR0);
> +
> +    /* Test PCR1 */
> +    fill_and_erase(NRF51_FLASH_BASE, NRF51_PAGE_SIZE, NRF51_NVMC_ERASE=
PCR1);
> +    fill_and_erase(NRF51_FLASH_BASE + NRF51_PAGE_SIZE,
> +                   NRF51_PAGE_SIZE, NRF51_NVMC_ERASEPCR1);
> +
> +    /* Erase all */
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_ERASEALL, 0x01);
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
> +
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
> +    for (i =3D 0; i < FLASH_SIZE / 4; i++) {
> +        writel(NRF51_FLASH_BASE + i * 4, i);
> +        g_assert_cmpuint(readl(NRF51_FLASH_BASE + i * 4), =3D=3D, i);
> +    }
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
> +
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_ERASEALL, 0x01);
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
> +
> +    for (i =3D 0; i < FLASH_SIZE / 4; i++) {
> +        g_assert_cmpuint(readl(NRF51_FLASH_BASE + i * 4), =3D=3D, 0xFF=
FFFFFF);
> +    }
> +
> +    /* Erase UICR */
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_ERASEUICR, 0x01);
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
> +
> +    for (i =3D 0; i < NRF51_UICR_SIZE / 4; i++) {
> +        g_assert_cmpuint(readl(NRF51_UICR_BASE + i * 4), =3D=3D, 0xFFF=
FFFFF);
> +    }
> +
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
> +    for (i =3D 0; i < NRF51_UICR_SIZE / 4; i++) {
> +        writel(NRF51_UICR_BASE + i * 4, i);
> +        g_assert_cmpuint(readl(NRF51_UICR_BASE + i * 4), =3D=3D, i);
> +    }
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
> +
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_ERASEUICR, 0x01);
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
> +
> +    for (i =3D 0; i < NRF51_UICR_SIZE / 4; i++) {
> +        g_assert_cmpuint(readl(NRF51_UICR_BASE + i * 4), =3D=3D, 0xFFF=
FFFFF);
> +    }
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int ret;
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    global_qtest =3D qtest_initf("-machine microbit");
> +
> +    qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
> +
> +    ret =3D g_test_run();
> +
> +    qtest_quit(global_qtest);
> +    return ret;
> +}

If you could do me a big favour, then please try to write new qtests
without the global_qtest variable. I.e. move the qtest_initf into the
test_nrf51_nvmc function and pass around the local test state variable
there to qtest_writel() and friends. I just started yet another clean up
attempt for some other files, e.g. see here:

 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02196.html

(but if this is too much cumbersome right now for you, I also won't
object this patch in the current shape - we can still clean this up later=
)

 Thomas
