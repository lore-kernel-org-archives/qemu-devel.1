Received: from eggs.gnu.org ([2001:4830:134:3::10]:33044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1f8vG9-0007Ty-2J
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 18:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1f8vG7-0006vi-MC
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 18:09:01 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:34573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1f8vG7-0006us-Ef
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 18:08:59 -0400
Received: by mail-pf0-x233.google.com with SMTP id q9so1585583pff.1
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 15:08:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1524037298-23401-2-git-send-email-saipava@xilinx.com>
References: <1524037298-23401-1-git-send-email-saipava@xilinx.com>
	<1524037298-23401-2-git-send-email-saipava@xilinx.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Thu, 19 Apr 2018 00:08:57 +0200
Message-ID: <CAAYMZQt0-7=mj1m6nH74cZjmG3QtafiKp9bOXGFM=QuAawDVDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] xilinx_spips: send dummy cycles
 only if cmd requires it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Cc: alistair@alistair23.me, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Edde <edgar.iglesias@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hi Sai,

About the subject, what do you think about changing it to below?
xilinx_spips: Correct SNOOP_NONE state when flushing the txfifo

On 18 April 2018 at 09:41, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
wrote:

> For all the commands, which do not have an entry in
> xilinx_spips_num_dummies, present logic sends dummy cycles when ever we
> are in SNOOP_NONE state, fix it to only send dummy cycles if the cmd
> requires them.
>
> It feels like below sentence goes together with the 'fix' above so maybe
it could come directly after? (i.e. no new section but maybe with an 'also'
after 'handle is')

> SNOOP_NONE state handle is moved above (previously its part of default
> else

s/above/above in the if ladder/
s/its part of default/it was part of the default/

> case), as its same as SNOOP_STRIPPING during data cycles.

s/its/it's/

>
>
Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
> ---
> TODO: Maybe we could delete the SNOOP_NONE state as it seems to be
> same as SNOOP_STRIPPING

I agree that a cleanup commit later on could be considered, but I think
it's better not to include the todo in the commit message of this one so
could we remove it?


>
>  hw/ssi/xilinx_spips.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 426f971..4f6760d 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -616,7 +616,8 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
>          if (fifo8_is_empty(&s->tx_fifo)) {
>              xilinx_spips_update_ixr(s);
>              return;
> -        } else if (s->snoop_state == SNOOP_STRIPING) {
> +        } else if (s->snoop_state == SNOOP_STRIPING ||
> +                   s->snoop_state == SNOOP_NONE) {
>              for (i = 0; i < num_effective_busses(s); ++i) {
>                  tx_rx[i] = fifo8_pop(&s->tx_fifo);
>              }
> @@ -626,11 +627,12 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS
> *s)
>              for (i = 0; i < num_effective_busses(s); ++i) {
>                  tx_rx[i] = tx;
>              }
> -        } else {
> +        } else if (s->cmd_dummies > 0) {
>
The variable snoop_state already keeps track of the dummy cycles, the same
the 'else' to 'else if' change above together with the 'cmd_dummies'
decrementation below does, could we undo these two changes since it is
already handled?

Thank you!

Best regards,
Francisco Iglesias

             /* Extract a dummy byte and generate dummy cycles according to
> the
>               * link state */
>              tx = fifo8_pop(&s->tx_fifo);
>              dummy_cycles = 8 / s->link_state;
> +            s->cmd_dummies--;
>          }
>
>          for (i = 0; i < num_effective_busses(s); ++i) {
> --
> 2.7.4
>
>
>
