Received: from eggs.gnu.org ([2001:4830:134:3::10]:57239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJi9P-0001B1-Kn
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJi9O-0007A0-ML
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:54:55 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJi9O-0006sK-B8
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:54:54 -0500
Received: by mail-ot1-x342.google.com with SMTP id x4so8626303otg.3
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 08:54:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102170730.12432-11-contrib@steffen-goertz.de>
References: <20181102170730.12432-1-contrib@steffen-goertz.de>
	<20181102170730.12432-11-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 16:54:16 +0000
Message-ID: <CAFEAcA9mVMTaQy+Xgd0DE8Csnd=BWjPXotWxVm3OibNG2-iJ9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/13] tests/microbit-test: Add Tests
 for nRF51 GPIO
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
> The test suite for the nRF51 GPIO peripheral for now
> only tests initial state. Additionally a set of
> tests testing an implementation detail of the model
> are included.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/microbit-test.c | 137 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 131 insertions(+), 6 deletions(-)
>
> diff --git a/tests/microbit-test.c b/tests/microbit-test.c
> index 743f831466..acdb9d1c02 100644
> --- a/tests/microbit-test.c
> +++ b/tests/microbit-test.c
> @@ -20,14 +20,17 @@
>
>  #include "hw/arm/nrf51.h"
>  #include "hw/nvram/nrf51_nvm.h"
> +#include "hw/gpio/nrf51_gpio.h"
>
>  #define FLASH_SIZE          (256 * NRF51_PAGE_SIZE)
>
>  static void fill_and_erase(hwaddr base, hwaddr size, uint32_t address_re=
g)
>  {
> +    uint64_t i;
> +
>      /* Fill memory */
>      writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
> -    for (hwaddr i =3D 0; i < size; i++) {
> +    for (i =3D 0; i < size; i++) {
>          writeb(base + i, i);
>          g_assert_cmpuint(readb(base + i), =3D=3D, i & 0xFF);
>      }
> @@ -39,7 +42,7 @@ static void fill_and_erase(hwaddr base, hwaddr size, ui=
nt32_t address_reg)
>      writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
>
>      /* Check memory */
> -    for (hwaddr i =3D 0; i < size; i++) {
> +    for (i =3D 0; i < size; i++) {
>          g_assert_cmpuint(readb(base + i), =3D=3D, 0xFF);
>      }
>  }

Ah, here are the fixes for the initializers. You should all squash these
down into patch 7.


> +static void test_nrf51_gpio(void)
> +{
> +    size_t i;
> +    uint32_t actual, expected;
> +
> +    struct {
> +        hwaddr addr;
> +        uint32_t expected;
> +    } reset_state[] =3D {
> +        {NRF51_GPIO_REG_OUT, 0x00000000}, {NRF51_GPIO_REG_OUTSET, 0x0000=
0000},
> +        {NRF51_GPIO_REG_OUTCLR, 0x00000000}, {NRF51_GPIO_REG_IN, 0x00000=
000},
> +        {NRF51_GPIO_REG_DIR, 0x00000000}, {NRF51_GPIO_REG_DIRSET, 0x0000=
0000},
> +        {NRF51_GPIO_REG_DIRCLR, 0x00000000}
> +    };

You could mark this array as const, I think ?


> +    /* Check short-circuit - generates an guest_error which must be chec=
ked
> +       manually as long as qtest can not scan qemu_log messages */

Odd multiline comment format again.

thanks
-- PMM
