Received: from eggs.gnu.org ([209.51.188.92]:58962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goCAQ-00013J-IL
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goCAP-00086T-Lh
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:01:58 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goCAP-00082e-G5
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:01:57 -0500
Received: by mail-ot1-x341.google.com with SMTP id 32so15573771ota.12
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 11:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20190124141147.8416-1-stefanha@redhat.com>
In-Reply-To: <20190124141147.8416-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 19:01:43 +0000
Message-ID: <CAFEAcA_NBtWFZi8G8goXrX0OHHeHheW6MK3W9ByHVi1DNX3JWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/microbit-test: Add tests for nRF51
 NVMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Thu, 24 Jan 2019 at 14:11, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> This resolves the conflict with Julia's UART test series due to
> global_qtest removal.
>
>  tests/microbit-test.c | 108 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>
> diff --git a/tests/microbit-test.c b/tests/microbit-test.c
> index 3bad947b6c..04e199ec33 100644
> --- a/tests/microbit-test.c
> +++ b/tests/microbit-test.c
> @@ -21,6 +21,7 @@
>  #include "hw/arm/nrf51.h"
>  #include "hw/char/nrf51_uart.h"
>  #include "hw/gpio/nrf51_gpio.h"
> +#include "hw/nvram/nrf51_nvm.h"
>  #include "hw/timer/nrf51_timer.h"
>  #include "hw/i2c/microbit_i2c.h"
>
> @@ -156,6 +157,112 @@ static void test_microbit_i2c(void)
>      qtest_quit(qts);
>  }
>
> +#define FLASH_SIZE          (256 * NRF51_PAGE_SIZE)
> +
> +static void fill_and_erase(QTestState *qts, hwaddr base, hwaddr size,
> +                           uint32_t address_reg)
> +{
> +    hwaddr i;
> +
> +    /* Erase Page */
> +    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
> +    qtest_writel(qts, NRF51_NVMC_BASE + address_reg, base);
> +    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
> +
> +    /* Check memory */
> +    for (i =3D 0; i < size / 4; i++) {
> +        g_assert_cmpuint(qtest_readl(qts, base + i * 4), =3D=3D, 0xFFFFF=
FFF);
> +    }
> +
> +    /* Fill memory */
> +    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
> +    for (i =3D 0; i < size / 4; i++) {
> +        qtest_writel(qts, base + i * 4, i);
> +        g_assert_cmpuint(qtest_readl(qts, base + i * 4), =3D=3D, i);

This assertion fails on PPC64 hosts:
ERROR:/home/pm215/qemu/tests/microbit-test.c:181:fill_and_erase:
assertion failed (qtest_readl(qts, base + i * 4) =3D=3D i): (16777216 =3D=
=3D
1)

I suspect an endianness issue, given that 16777216 is 0x0100_0000.
The test looks OK, though -- a word write ought to come back
the same on a word read -- so maybe it's in the implementation?

thanks
-- PMM
