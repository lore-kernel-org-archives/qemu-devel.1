Received: from eggs.gnu.org ([209.51.188.92]:40458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggpxL-0003bq-Te
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggpxK-0000M5-59
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:54:02 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggpxJ-0000DZ-V3
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:54:02 -0500
Received: by mail-oi1-x241.google.com with SMTP id j21so3054650oii.8
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 03:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20190104182057.8778-1-philmd@redhat.com>
In-Reply-To: <20190104182057.8778-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 11:53:47 +0000
Message-ID: <CAFEAcA8z1c8=x3Ndrn2dRRJPaC_tUPQgWSRSsha57BoAnYHJoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/char/stm32f2xx_usart: Do not update
 data register when device is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Alistair Francis <alistair@alistair23.me>

On Fri, 4 Jan 2019 at 18:21, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> When the device is disable, the internal circuitry keep the data
> register loaded and doesn't update it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/char/stm32f2xx_usart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
> index f3363a2952..10392c70e2 100644
> --- a/hw/char/stm32f2xx_usart.c
> +++ b/hw/char/stm32f2xx_usart.c
> @@ -53,14 +53,13 @@ static void stm32f2xx_usart_receive(void *opaque, con=
st uint8_t *buf, int size)
>  {
>      STM32F2XXUsartState *s =3D opaque;
>
> -    s->usart_dr =3D *buf;
> -
>      if (!(s->usart_cr1 & USART_CR1_UE && s->usart_cr1 & USART_CR1_RE)) {
>          /* USART not enabled - drop the chars */
>          DB_PRINT("Dropping the chars\n");
>          return;
>      }
>
> +    s->usart_dr =3D *buf;
>      s->usart_sr |=3D USART_SR_RXNE;
>
>      if (s->usart_cr1 & USART_CR1_RXNEIE) {
> --
> 2.17.2




Applied to target-arm.next, thanks (with the commit message typos fixed).

-- PMM
