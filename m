Received: from eggs.gnu.org ([2001:4830:134:3::10]:59134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIayR-0008S3-18
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIayQ-0006rS-1z
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:02:58 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIayP-0006rF-SS
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:02:57 -0400
Received: by mail-oi1-x242.google.com with SMTP id p144-v6so1791077oic.12
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 08:02:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181031002526.14262-9-contrib@steffen-goertz.de>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-9-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 15:02:36 +0000
Message-ID: <CAFEAcA_0GzLviMx_ExqwFUkW5PPFvOCTbZhw4tOJKU4pU1qMSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 08/13] hw/gpio/nrf51_gpio: Add nRF51
 GPIO peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On 31 October 2018 at 00:25, Steffen G=C3=B6rtz <contrib@steffen-goertz.de>=
 wrote:
> This adds a model of the nRF51 GPIO peripheral.
>
> Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
>
> The nRF51 series microcontrollers support up to 32 GPIO pins in various c=
onfigurations.
> The pins can be used as input pins with pull-ups or pull-down.
> Furthermore, three different output driver modes per level are
> available (disconnected, standard, high-current).
>
> The GPIO-Peripheral has a mechanism for detecting level changes which is
> not featured in this model.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

> +
> +static void update_state(NRF51GPIOState *s)
> +{
> +    uint32_t pull;
> +    bool connected_out, dir, connected_in, out, input;
> +
> +    for (size_t i =3D 0; i < NRF51_GPIO_PINS; i++) {

Hi. This style of declaring the loop variable inside the for()
is not supported by all our compilers, and it's generating
compile warnings (you can see that patchew is mailing you the
logs for these as followups to your cover letter):

/tmp/qemu-test/src/hw/gpio/nrf51_gpio.c:64:5: error: 'for' loop
initial declarations are only allowed in C99 mode
     for (size_t i =3D 0; i < NRF51_GPIO_PINS; i++) {
     ^


> +static void reflect_dir_bit_in_cnf(NRF51GPIOState *s)
> +{
> +    uint32_t value =3D s->dir;
> +    for (size_t i =3D 0; i < NRF51_GPIO_PINS; i++) {

Similarly here, and I think I saw another use somewhere else
in this patchset too.


thanks
-- PMM
