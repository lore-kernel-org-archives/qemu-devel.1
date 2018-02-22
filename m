Received: from eggs.gnu.org ([2001:4830:134:3::10]:53638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eorzP-0005Ft-AY
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eorzO-00048Y-Ci
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:36:51 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:44454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eorzO-00047O-85
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:36:50 -0500
Received: by mail-ot0-x243.google.com with SMTP id 79so4763098oth.11
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 06:36:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217140051.22731-1-linus.walleij@linaro.org>
References: <20180217140051.22731-1-linus.walleij@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 14:36:29 +0000
Message-ID: <CAFEAcA_RX7fmbAZX75pCJVPBEbN4im_W2BOH6m=ghgm6e-JtdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/3] hw/i2c-ddc: Do not fail
 writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 14:00, Linus Walleij <linus.walleij@linaro.org> wrote:
> The tx function of the DDC I2C slave emulation was returning 1
> on all writes resulting in NACK in the I2C bus. Changing it to
> 0 makes the DDC I2C work fine with bit-banged I2C such as the
> versatile I2C.
>
> I guess it was not affecting whatever I2C controller this was
> used with until now, but with the Versatile I2C it surely
> does not work.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  hw/i2c/i2c-ddc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i2c/i2c-ddc.c b/hw/i2c/i2c-ddc.c
> index 199dac9e41c1..bec0c91e2dd0 100644
> --- a/hw/i2c/i2c-ddc.c
> +++ b/hw/i2c/i2c-ddc.c
> @@ -259,12 +259,12 @@ static int i2c_ddc_tx(I2CSlave *i2c, uint8_t data)
>          s->reg = data;
>          s->firstbyte = false;
>          DPRINTF("[EDID] Written new pointer: %u\n", data);
> -        return 1;
> +        return 0;
>      }
>
>      /* Ignore all writes */
>      s->reg++;
> -    return 1;
> +    return 0;
>  }
>
>  static void i2c_ddc_init(Object *obj)
> --
> 2.14.3

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Does the guest attempting writes mean that we're missing functionality
that the hardware has? Is it interesting?

PS: I didn't see a cover letter email with this patchset --
if you can send a cover letter with multi-email patchsets that makes
our automated tooling much happier.

thanks
-- PMM
