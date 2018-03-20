Received: from eggs.gnu.org ([2001:4830:134:3::10]:47784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ey5SJ-0002NP-QC
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ey5SE-00054i-UR
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:48:47 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ey5SE-00054N-No
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:48:42 -0400
Received: by mail-wr0-x243.google.com with SMTP id c24so8614201wrc.6
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 17:48:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180319213101.6100-1-wsa+renesas@sang-engineering.com>
	<20180319213101.6100-2-wsa+renesas@sang-engineering.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3005cdd5-f3c4-a0c0-f6db-abc2b7bf759a@amsat.org>
Date: Tue, 20 Mar 2018 01:48:39 +0100
MIME-Version: 1.0
In-Reply-To: <20180319213101.6100-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] nvram: at24c: prevent segfault by
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
Cc: linux-renesas-soc@vger.kernel.org

On 03/19/2018 10:30 PM, Wolfram Sang wrote:
> The value for "rom-size" is used as a divisor, so it must not be 0 or it
> will segfault. A size of 0 wouldn't make sense anyhow.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  hw/nvram/eeprom_at24c.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
> index 22183f5360..ccf78b25e4 100644
> --- a/hw/nvram/eeprom_at24c.c
> +++ b/hw/nvram/eeprom_at24c.c
> @@ -121,6 +121,11 @@ int at24c_eeprom_init(I2CSlave *i2c)
>  {
>      EEPROMState *ee = AT24C_EE(i2c);
>  
> +    if (!ee->rsize) {
> +        ERR("rom-size not allowed to be 0\n");

You can directly use error_report() in this patch.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +        exit(1);
> +    }
> +
>      ee->mem = g_malloc0(ee->rsize);
>  
>      if (ee->blk) {
> 
