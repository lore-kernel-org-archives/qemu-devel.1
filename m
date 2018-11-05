Received: from eggs.gnu.org ([2001:4830:134:3::10]:56153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJi6J-00075i-DN
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:51:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJi6H-0003oL-OH
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:51:43 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJi6H-0003gx-CP
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:51:41 -0500
Received: by mail-oi1-x242.google.com with SMTP id 192-v6so7304349oii.6
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 08:51:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102170730.12432-8-contrib@steffen-goertz.de>
References: <20181102170730.12432-1-contrib@steffen-goertz.de>
	<20181102170730.12432-8-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 16:51:04 +0000
Message-ID: <CAFEAcA8arFtAxVDxd_XTnLFnEcMY7BHSA1PjYChp07HwzQqmqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 07/13] tests: Add bbc:microbit / nRF51
 test suite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 2 November 2018 at 17:07, Steffen G=C3=B6rtz <contrib@steffen-goertz.de>=
 wrote:
> The microbit-test includes tests for the nRF51 NVMC
> peripheral and will host future nRF51 peripheral tests
> and board-level bbc:microbit tests.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/Makefile.include |   2 +
>  tests/microbit-test.c  | 117 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 119 insertions(+)
>  create mode 100644 tests/microbit-test.c
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index f77a495109..602346eeed 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -274,6 +274,7 @@ check-qtest-sparc64-y +=3D tests/boot-serial-test$(EX=
ESUF)
>  check-qtest-arm-y +=3D tests/tmp105-test$(EXESUF)
>  check-qtest-arm-y +=3D tests/pca9552-test$(EXESUF)
>  check-qtest-arm-y +=3D tests/ds1338-test$(EXESUF)
> +check-qtest-arm-y +=3D tests/microbit-test$(EXESUF)
>  check-qtest-arm-y +=3D tests/m25p80-test$(EXESUF)
>  check-qtest-arm-y +=3D tests/virtio-blk-test$(EXESUF)
>  check-qtest-arm-y +=3D tests/test-arm-mptimer$(EXESUF)
> @@ -695,6 +696,7 @@ tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-=
sector.o $(libqos-obj-y)
>  tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
>  tests/pca9552-test$(EXESUF): tests/pca9552-test.o $(libqos-omap-obj-y)
>  tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
> +tests/microbit-test$(EXESUF): tests/microbit-test.o
>  tests/m25p80-test$(EXESUF): tests/m25p80-test.o
>  tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
>  tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
> diff --git a/tests/microbit-test.c b/tests/microbit-test.c
> new file mode 100644
> index 0000000000..743f831466
> --- /dev/null
> +++ b/tests/microbit-test.c
> @@ -0,0 +1,117 @@
> + /*
> + * QTest testcase for Microbit board using the Nordic Semiconductor nRF5=
1 SoC.
> + *
> + * nRF51:
> + * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.=
pdf
> + * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1.p=
df
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
> +static void fill_and_erase(hwaddr base, hwaddr size, uint32_t address_re=
g)
> +{
> +    /* Fill memory */
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
> +    for (hwaddr i =3D 0; i < size; i++) {

Looks like you missed this "declaration inside for()".

> +        writeb(base + i, i);
> +        g_assert_cmpuint(readb(base + i), =3D=3D, i & 0xFF);
> +    }

thanks
-- PMM
