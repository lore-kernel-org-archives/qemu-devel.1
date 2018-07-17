Received: from eggs.gnu.org ([2001:4830:134:3::10]:36448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffEfY-0001Fh-LA
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 21:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffEfU-0006zd-Lt
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 21:20:48 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:39578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffEfU-0006zP-Gl
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 21:20:44 -0400
Received: by mail-vk0-x244.google.com with SMTP id e139-v6so21247542vkf.6
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 18:20:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1531779837-20557-1-git-send-email-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c240db5a-ba24-bdea-ea90-d95a4d661889@amsat.org>
Date: Mon, 16 Jul 2018 22:20:37 -0300
MIME-Version: 1.0
In-Reply-To: <1531779837-20557-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/sd/bcm2835_sdhost: Fix PIO mode writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>, Clement Deschamps <clement.deschamps@antfield.fr>, Luc Michel <luc.michel@git.antfield.fr>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

Cc'ing ANTField folks who might have the specs.

On 07/16/2018 07:23 PM, Guenter Roeck wrote:
> Writes in PIO mode have two requirements:
> 
> - A data interrupt must be generated after a write command has been
>   issued to indicate that the chip is ready to receive data.
> - A block interrupt must be generated after each block to indicate
>   that the chip is ready to receive the next data block.
> 
> Rearrange the code to make this happen. Tested on raspi3 (in PIO mode)
> and raspi2 (in DMA mode).

Note to reviewers, this seems a follow-up of:
http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03397.html
(This patch makes more sens after reading this previous thread).

> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/sd/bcm2835_sdhost.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
> index 4df4de7..1b760b2 100644
> --- a/hw/sd/bcm2835_sdhost.c
> +++ b/hw/sd/bcm2835_sdhost.c
> @@ -179,9 +179,11 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostState *s)
>      uint32_t value = 0;
>      int n;
>      int is_read;
> +    int is_write;
>  
>      is_read = (s->cmd & SDCMD_READ_CMD) != 0;
> -    if (s->datacnt != 0 && (!is_read || sdbus_data_ready(&s->sdbus))) {
> +    is_write = (s->cmd & SDCMD_WRITE_CMD) != 0;
> +    if (s->datacnt != 0 && (is_write || sdbus_data_ready(&s->sdbus))) {
>          if (is_read) {
>              n = 0;
>              while (s->datacnt && s->fifo_len < BCM2835_SDHOST_FIFO_LEN) {
> @@ -201,8 +203,11 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostState *s)
>              if (n != 0) {
>                  bcm2835_sdhost_fifo_push(s, value);
>                  s->status |= SDHSTS_DATA_FLAG;
> +                if (s->config & SDHCFG_DATA_IRPT_EN) {
> +                    s->status |= SDHSTS_SDIO_IRPT;
> +                }
>              }
> -        } else { /* write */
> +        } else if (is_write) { /* write */
>              n = 0;
>              while (s->datacnt > 0 && (s->fifo_len > 0 || n > 0)) {
>                  if (n == 0) {
> @@ -223,11 +228,18 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostState *s)
>              s->edm &= ~SDEDM_FSM_MASK;
>              s->edm |= SDEDM_FSM_DATAMODE;
>              trace_bcm2835_sdhost_edm_change("datacnt 0", s->edm);
> -
> -            if ((s->cmd & SDCMD_WRITE_CMD) &&
> +        }
> +        if (is_write) {
> +            /* set block interrupt at end of each block transfer */
> +            if (s->hbct && s->datacnt % s->hbct == 0 &&
>                  (s->config & SDHCFG_BLOCK_IRPT_EN)) {
>                  s->status |= SDHSTS_BLOCK_IRPT;
>              }
> +            /* set data interrupt after each transfer */
> +            s->status |= SDHSTS_DATA_FLAG;
> +            if (s->config & SDHCFG_DATA_IRPT_EN) {
> +                s->status |= SDHSTS_SDIO_IRPT;
> +            }
>          }
>      }
>  
> 
