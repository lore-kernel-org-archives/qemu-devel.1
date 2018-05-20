Received: from eggs.gnu.org ([2001:4830:134:3::10]:35133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fKONk-0006bf-9z
	for qemu-devel@nongnu.org; Sun, 20 May 2018 09:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fKONj-0006k4-EE
	for qemu-devel@nongnu.org; Sun, 20 May 2018 09:28:16 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:36678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fKONj-0006ig-9K
	for qemu-devel@nongnu.org; Sun, 20 May 2018 09:28:15 -0400
Received: by mail-ot0-x241.google.com with SMTP id m11-v6so14098698otf.3
	for <qemu-devel@nongnu.org>; Sun, 20 May 2018 06:28:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180520070037.8593-4-wsa+renesas@sang-engineering.com>
References: <20180520070037.8593-1-wsa+renesas@sang-engineering.com>
	<20180520070037.8593-4-wsa+renesas@sang-engineering.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 20 May 2018 14:27:54 +0100
Message-ID: <CAFEAcA9-gA2PYsiOLu3cGFtg1aeCs8n5z+pydsVDeFhzzy2Axg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 RESEND 3/3] nvram: at24c: use standard
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 20 May 2018 at 08:00, Wolfram Sang <wsa+renesas@sang-engineering.com> wr=
ote:
> Replace the ERR macro with error_report() because fprintf is deprecated.
> This also fixes the prefix printed out twice.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  hw/nvram/eeprom_at24c.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> @@ -63,8 +61,7 @@ int at24c_eeprom_event(I2CSlave *s, enum i2c_event even=
t)
>          if (ee->blk && ee->changed) {
>              int len =3D blk_pwrite(ee->blk, 0, ee->mem, ee->rsize, 0);
>              if (len !=3D ee->rsize) {
> -                ERR(TYPE_AT24C_EE
> -                        " : failed to write backing file\n");
> +                error_report("failed to write backing file");
>              }
>              DPRINTK("Wrote to backing file\n");
>          }
> @@ -125,7 +122,7 @@ int at24c_eeprom_init(I2CSlave *i2c)
>      EEPROMState *ee =3D AT24C_EE(i2c);
>
>      if (!ee->rsize) {
> -        ERR("rom-size not allowed to be 0\n");
> +        error_report("rom-size not allowed to be 0");
>          exit(1);
>      }

Hi; if we're going to overhaul the error handling for this
device, I think we might as well do it properly, by moving
the code in this init function which can fail into a new
device realize method. The realize method takes an Error**
and can report failures that way rather than by causing
QEMU to exit.

> @@ -166,8 +162,7 @@ void at24c_eeprom_reset(DeviceState *state)
>          int len =3D blk_pread(ee->blk, 0, ee->mem, ee->rsize);
>
>          if (len !=3D ee->rsize) {
> -            ERR(TYPE_AT24C_EE
> -                    " : Failed initial sync with backing file\n");
> +            error_report("Failed initial sync with backing file");
>          }
>          DPRINTK("Reset read backing file\n");
>      }

Errors in reset and event methods are a bit more awkward;
error_report is an improvement in those cases.

thanks
-- PMM
