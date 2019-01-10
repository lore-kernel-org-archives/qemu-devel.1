Received: from eggs.gnu.org ([209.51.188.92]:42658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghWxH-0004pI-Du
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:48:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghWxG-0006CL-JB
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:48:51 -0500
References: <20190110094020.18354-1-stefanha@redhat.com>
	<20190110094020.18354-3-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cd32de08-afd0-4b8b-a10a-99e1d88d1755@redhat.com>
Date: Thu, 10 Jan 2019 10:48:36 +0100
MIME-Version: 1.0
In-Reply-To: <20190110094020.18354-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests/microbit-test: add TWI stub
 device test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, qemu-arm@nongnu.org, jusual@mail.ru, contrib@steffen-goertz.de

On 2019-01-10 10:40, Stefan Hajnoczi wrote:
> This test verifies that we read back the expected I2C WHO_AM_I register
> values for the accelerometer/magnetometer.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/microbit-test.c | 44 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/tests/microbit-test.c b/tests/microbit-test.c
> index 0c125535f6..dcdc0cd41a 100644
> --- a/tests/microbit-test.c
> +++ b/tests/microbit-test.c
> @@ -21,6 +21,49 @@
>  #include "hw/arm/nrf51.h"
>  #include "hw/gpio/nrf51_gpio.h"
>  #include "hw/timer/nrf51_timer.h"
> +#include "hw/i2c/microbit_i2c.h"
> +
> +/* Read a byte from I2C device at @addr from register @reg */
> +static uint32_t i2c_read_byte(uint32_t addr, uint32_t reg)
> +{
> +    uint32_t val;
> +
> +    writel(NRF51_TWI_BASE + NRF51_TWI_REG_ADDRESS, addr);
> +    writel(NRF51_TWI_BASE + NRF51_TWI_TASK_STARTTX, 1);
> +    writel(NRF51_TWI_BASE + NRF51_TWI_REG_TXD, reg);
> +    val = readl(NRF51_TWI_BASE + NRF51_TWI_EVENT_TXDSENT);
> +    g_assert_cmpuint(val, ==, 1);
> +    writel(NRF51_TWI_BASE + NRF51_TWI_TASK_STOP, 1);
> +
> +    writel(NRF51_TWI_BASE + NRF51_TWI_TASK_STARTRX, 1);
> +    val = readl(NRF51_TWI_BASE + NRF51_TWI_EVENT_RXDREADY);
> +    g_assert_cmpuint(val, ==, 1);
> +    val = readl(NRF51_TWI_BASE + NRF51_TWI_REG_RXD);
> +    writel(NRF51_TWI_BASE + NRF51_TWI_TASK_STOP, 1);

Any chance that you could use qemu_writel() right from the start here?
That will make it easier to finally get rid of global_qtest one day...

 Thomas
