Received: from eggs.gnu.org ([2001:4830:134:3::10]:33792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evhcq-0008OO-B3
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evhck-0008Fr-MO
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:57:48 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:40298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evhck-0008Ew-FY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:57:42 -0400
Received: by mail-wr0-x241.google.com with SMTP id m4so8504769wrb.7
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 03:57:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180312214230.17561-1-wsa+renesas@sang-engineering.com>
	<20180312214230.17561-2-wsa+renesas@sang-engineering.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1bf57371-c1f5-6d5f-716f-8fd00cb9675b@amsat.org>
Date: Tue, 13 Mar 2018 11:57:39 +0100
MIME-Version: 1.0
In-Reply-To: <20180312214230.17561-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] nvram: at24c: remove doubled prefix
 for ERR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-devel@nongnu.org
Cc: linux-renesas-soc@vger.kernel.org, Michael Davidsaver <mdavidsaver@gmail.com>

Hi Wolfram,

On 03/12/2018 10:42 PM, Wolfram Sang wrote:
> The ERR macro already has the TYPE_AT24C_EE prefix, no need to repeat in
> the error message.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  hw/nvram/eeprom_at24c.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
> index 5494351976..8507516b7e 100644
> --- a/hw/nvram/eeprom_at24c.c
> +++ b/hw/nvram/eeprom_at24c.c
> @@ -60,8 +60,7 @@ int at24c_eeprom_event(I2CSlave *s, enum i2c_event event)
>          if (ee->blk && ee->changed) {
>              int len = blk_pwrite(ee->blk, 0, ee->mem, ee->rsize, 0);
>              if (len != ee->rsize) {
> -                ERR(TYPE_AT24C_EE
> -                        " : failed to write backing file\n");
> +                ERR("failed to write backing file\n");

printf/fprintf are deprecated, since you are modifying this file can you
use a newer API, "qemu/error-report.h" for example.

>              }
>              DPRINTK("Wrote to backing file\n");

DPRINTK() can be converted to tracepoint.

>          }
> @@ -127,7 +126,7 @@ int at24c_eeprom_init(I2CSlave *i2c)
>          int64_t len = blk_getlength(ee->blk);
>  
>          if (len != ee->rsize) {
> -            ERR(TYPE_AT24C_EE " : Backing file size %lu != %u\n",
> +            ERR("Backing file size %lu != %u\n",
>                      (unsigned long)len, (unsigned)ee->rsize);
>              exit(1);
>          }
> @@ -135,8 +134,7 @@ int at24c_eeprom_init(I2CSlave *i2c)
>          if (blk_set_perm(ee->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
>                           BLK_PERM_ALL, &error_fatal) < 0)
>          {
> -            ERR(TYPE_AT24C_EE
> -                    " : Backing file incorrect permission\n");
> +            ERR("Backing file incorrect permission\n");
>              exit(1);
>          }
>      }
> @@ -158,8 +156,7 @@ void at24c_eeprom_reset(DeviceState *state)
>          int len = blk_pread(ee->blk, 0, ee->mem, ee->rsize);
>  
>          if (len != ee->rsize) {
> -            ERR(TYPE_AT24C_EE
> -                    " : Failed initial sync with backing file\n");
> +            ERR("Failed initial sync with backing file\n");
>          }
>          DPRINTK("Reset read backing file\n");
>      }
> 
