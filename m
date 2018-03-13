Received: from eggs.gnu.org ([2001:4830:134:3::10]:34216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evhf2-0001V8-Dc
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evhex-00019p-Gb
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:00:04 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:41453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evhex-00019H-A9
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:59:59 -0400
Received: by mail-wr0-x242.google.com with SMTP id f14so21324002wre.8
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 03:59:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180312214230.17561-1-wsa+renesas@sang-engineering.com>
	<20180312214230.17561-3-wsa+renesas@sang-engineering.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a6e49f6a-5c78-6628-d530-cfd47b566296@amsat.org>
Date: Tue, 13 Mar 2018 11:59:56 +0100
MIME-Version: 1.0
In-Reply-To: <20180312214230.17561-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] nvram: at24c: prevent segfault by
 checking "rom-size"
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

On 03/12/2018 10:42 PM, Wolfram Sang wrote:
> The value for "rom-size" is used as a divisor, so it must not be 0 or it
> will segfault. A size of 0 wouldn't make sense as well.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  hw/nvram/eeprom_at24c.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
> index 8507516b7e..d82710e1df 100644
> --- a/hw/nvram/eeprom_at24c.c
> +++ b/hw/nvram/eeprom_at24c.c
> @@ -120,6 +120,11 @@ int at24c_eeprom_init(I2CSlave *i2c)
>  {
>      EEPROMState *ee = AT24C_EE(i2c);
>  
> +    if (!ee->rsize) {
> +        ERR("rom-size not allowed to be 0\n");

This might be more useful:

           error_report("Minimum rom-size is %u", AT24C_ROMSIZE_MIN);

> +        exit(1);
> +    }
> +
>      ee->mem = g_malloc0(ee->rsize);
>  
>      if (ee->blk) {
> 
