Received: from eggs.gnu.org ([209.51.188.92]:39595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glZ2m-0007kc-Ka
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glZ2l-0003jH-Q4
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:51:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1glZ2l-0003iR-IG
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:51:11 -0500
References: <20190117161640.5496-1-jusual@mail.ru>
	<20190117161640.5496-4-jusual@mail.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c373d606-05a0-5373-11c3-3c46b379601b@redhat.com>
Date: Mon, 21 Jan 2019 13:51:04 +0100
MIME-Version: 1.0
In-Reply-To: <20190117161640.5496-4-jusual@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/3] tests/microbit-test: Check nRF51
 UART functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 2019-01-17 17:16, Julia Suvorova via Qemu-devel wrote:
> Some functional tests for:
>     Basic reception/transmittion
>     Suspending
>     INTEN* registers
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  tests/microbit-test.c | 84 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>=20
> diff --git a/tests/microbit-test.c b/tests/microbit-test.c
> index afeb6b082a..3da6d9529f 100644
> --- a/tests/microbit-test.c
> +++ b/tests/microbit-test.c
> @@ -19,10 +19,93 @@
>  #include "libqtest.h"
> =20
>  #include "hw/arm/nrf51.h"
> +#include "hw/char/nrf51_uart.h"
>  #include "hw/gpio/nrf51_gpio.h"
>  #include "hw/timer/nrf51_timer.h"
>  #include "hw/i2c/microbit_i2c.h"
> =20
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +
> +static bool uart_wait_for_event(QTestState *qts, uint32_t event_addr)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < 1000; i++) {
> +        if (qtest_readl(qts, event_addr) =3D=3D 1) {
> +            qtest_writel(qts, event_addr, 0x00);
> +            return true;
> +        }
> +        g_usleep(10000);
> +    }

So this times out after 10 seconds? ... this is likely plenty on a
normal host, but we run the tests on overloaded CI systems sometimes,
where 10 seconds are not that much...

I'd suggest to replace the condition in the for-loop with "i < 30000" or
even "i < 60000", just to be sure.

> +    return false;
> +}
> +
> +static void uart_rw_to_rxd(QTestState *qts, int sock_fd, const char *i=
n,
> +                           char *out)
> +{
> +    int i, in_len =3D strlen(in);
> +
> +    g_assert(write(sock_fd, in, in_len) =3D=3D in_len);

Sorry for being pedantic, but I'd really prefer to write it without
side-effects in g_assert() please. (same for the other occurrences in
this patch)

 Thomas
