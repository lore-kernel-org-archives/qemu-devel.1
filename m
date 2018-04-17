Received: from eggs.gnu.org ([2001:4830:134:3::10]:58736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1f8ZJl-0002Ba-Cj
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1f8ZJk-0004ck-3s
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:43:17 -0400
Received: from mail-pl0-x229.google.com ([2607:f8b0:400e:c01::229]:36373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1f8ZJj-0004bT-Q6
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:43:16 -0400
Received: by mail-pl0-x229.google.com with SMTP id m7-v6so1240244plt.3
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 15:43:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523974696-1965-2-git-send-email-saipava@xilinx.com>
References: <1523974696-1965-1-git-send-email-saipava@xilinx.com>
	<1523974696-1965-2-git-send-email-saipava@xilinx.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Wed, 18 Apr 2018 00:43:13 +0200
Message-ID: <CAAYMZQu5JOTOp3K4awXPvzbaE7oqvK0XqqoNzKjB5ShR=BJnzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] xilinx_spips: send dummy only if
 cmd requires it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Cc: alistair@alistair23.me, crosthwaite.peter@gmail.com, Peter Maydell <peter.maydell@linaro.org>, Edde <edgar.iglesias@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hi Sai,

[PATCH v1] xilinx_spips: send dummy only if cmd requires it

s/dummy/dummy cycles/

On 17 April 2018 at 16:18, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
wrote:

> For all the commands, which do not have an entry in
> xilinx_spips_num_dummies, present logic sends dummy byte when ever we
>

s/dummy byte/dummy cycles/


> are in SNOOP_NONE state, fix it to send only if cmd requires them.
>
> s/fix it to send only if cmd/fix it to only send dummy cycles if the
command/

Only transmit max of 1 dummy byte(i.e 8 cycles) is a single snoop cycle.
> And also convert dummy bytes to cycles (required by m25p80).
>

Maybe it is better to drop this two last lines (was already done before so
it could be misleading when reading git history).


>
>
Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
> ---
>  hw/ssi/xilinx_spips.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 426f971..8278930 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -627,10 +627,17 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS
> *s)
>                  tx_rx[i] = tx;
>              }
>          } else {
> -            /* Extract a dummy byte and generate dummy cycles according
> to the
> -             * link state */
>              tx = fifo8_pop(&s->tx_fifo);
> -            dummy_cycles = 8 / s->link_state;
> +            if (s->cmd_dummies > 0) {
> +                /* Extract a dummy byte and generate dummy cycles
> according to
> +                 * the link state */
> +                 dummy_cycles = (s->cmd_dummies ? 1 : 0) * 8 /
> s->link_state;
> +                 s->cmd_dummies--;
> +            } else {
> +                for (i = 0; i < num_effective_busses(s); ++i) {
> +                    tx_rx[i] = tx;
> +                }
> +            }
>          }
>
>
Could we replace above with below in the same if ladder so we don't
complicate the code more than necessary? (Should give the same result when
num_effective_busses == 1)

-        } else if (s->snoop_state == SNOOP_STRIPING) {
+        } else if (s->snoop_state == SNOOP_STRIPING ||
+                   s->snoop_state == SNOOP_NONE) {


Thank you!

Best regards,
Francisco Iglesias




>          for (i = 0; i < num_effective_busses(s); ++i) {
> --
> 2.7.4
>
>
