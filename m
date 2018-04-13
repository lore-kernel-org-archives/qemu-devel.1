Received: from eggs.gnu.org ([2001:4830:134:3::10]:56070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6yF7-0002wT-SN
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6yF7-0004bk-2T
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:55:53 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:34022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6yF6-0004bE-UB
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:55:53 -0400
Received: by mail-oi0-x234.google.com with SMTP id u141-v6so8267211oif.1
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 05:55:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180324192455.12254-12-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
	<20180324192455.12254-12-mdavidsaver@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 13:55:31 +0100
Message-ID: <CAFEAcA9QkUQwnvnm+9jrFM4jr8mh87EzKCg4PxrOUmf=LHxLPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 11/14] timer: generalize ds1338
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>

On 24 March 2018 at 19:24, Michael Davidsaver <mdavidsaver@gmail.com> wrote:
> Add class level handling for address space size
> and control register.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---

> @@ -206,22 +216,15 @@ static void dsrtc_update(DSRTCState *s)
>  static int dsrtc_send(I2CSlave *i2c, uint8_t data)
>  {
>      DSRTCState *s = DSRTC(i2c);
> +    DSRTCClass *k = DSRTC_GET_CLASS(s);
>
>      if (s->addr_byte) {
> -        s->ptr = data & (NVRAM_SIZE - 1);
> +        s->ptr = data % k->addr_size;
>          s->addr_byte = false;
>          return 0;
>      }
> -    if (s->ptr == R_CTRL) {
> -        /* Control register. */
> -
> -        /* Ensure bits 2, 3 and 6 will read back as zero. */
> -        data &= 0xB3;
> -
> -        /* Attempting to write the OSF flag to logic 1 leaves the
> -           value unchanged. */
> -        data = (data & ~CTRL_OSF) | (data & s->nvram[s->ptr] & CTRL_OSF);
> -
> +    if (s->ptr == k->ctrl_offset) {
> +        (k->ctrl_write)(s, data);
>      }
>      s->nvram[s->ptr] = data;
>      if (s->ptr <= R_YEAR) {
> @@ -256,15 +259,41 @@ static void dsrtc_class_init(ObjectClass *klass, void *data)
>  }
>
>  static const TypeInfo dsrtc_info = {
> +    .abstract      = true,
>      .name          = TYPE_DSRTC,
>      .parent        = TYPE_I2C_SLAVE,
>      .instance_size = sizeof(DSRTCState),
>      .class_init    = dsrtc_class_init,
>  };
>
> +static void ds1338_control_write(DSRTCState *s, uint8_t data)
> +{
> +    /* Control register. */
> +
> +    /* allow guest to set no-op controls for clock out pin */
> +    s->nvram[R_DS1338_CTRL] = data & 0x93;

This is mixing a behavioural change with an otherwise
pure refactoring -- can you split them out, please?

Otherwise the patch looks good.

thanks
-- PMM
