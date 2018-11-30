Received: from eggs.gnu.org ([2001:4830:134:3::10]:35971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSmY8-0004XI-Hx
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSmY4-0002cL-IG
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:25:56 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSmY4-0002cF-CO
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:25:52 -0500
Received: by mail-oi1-x243.google.com with SMTP id x23so5375867oix.3
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 09:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-5-minyard@acm.org>
In-Reply-To: <20181126200435.23408-5-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 17:25:40 +0000
Message-ID: <CAFEAcA93S-9ujYS1jTw8g-sn+FMofxQmajM7nrfORNh_3rkbLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 04/16] i2c: Don't check return value
 from i2c_recv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

On Mon, 26 Nov 2018 at 20:04, <minyard@acm.org> wrote:
>
> From: Corey Minyard <cminyard@mvista.com>
>
> i2c_recv() cannot fail, so there is no need to check the return
> value.  It also returns unt8_t, so comparing with < 0 is not
> meaningful.
>
> Fix up various I2C controllers to remove the unneeded code.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> ---

> diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
> index c96fa7d7be..43f284eab7 100644
> --- a/hw/i2c/exynos4210_i2c.c
> +++ b/hw/i2c/exynos4210_i2c.c
> @@ -106,12 +106,12 @@ static inline void exynos4210_i2c_raise_interrupt(Exynos4210I2CState *s)
>  static void exynos4210_i2c_data_receive(void *opaque)
>  {
>      Exynos4210I2CState *s = (Exynos4210I2CState *)opaque;
> -    int ret;
> +    uint8_t ret;
>
>      s->i2cstat &= ~I2CSTAT_LAST_BIT;
>      s->scl_free = false;
>      ret = i2c_recv(s->bus);
> -    if (ret < 0 && (s->i2ccon & I2CCON_ACK_GEN)) {
> +    if (s->i2ccon & I2CCON_ACK_GEN) {
>          s->i2cstat |= I2CSTAT_LAST_BIT;  /* Data is not acknowledged */

Previously the code was doing this only if i2c_recv()
failed (returned a negative value) and ACK_GEN was set.
i2c_recv() can never fail, so this if() {} branch should
be deleted entirely ("false && something" simplifies
to "false", not "something").

>      } else {
>          s->i2cds = ret;

The rest of the patch looks good.

thanks
-- PMM
