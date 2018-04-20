Received: from eggs.gnu.org ([2001:4830:134:3::10]:56409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1f9ZoF-0005bv-Vx
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1f9ZoE-0002C3-PS
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:26:55 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:39631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1f9ZoE-0002AN-GP
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:26:54 -0400
Received: by mail-pl0-x243.google.com with SMTP id e7-v6so5627551plt.6
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 10:26:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1524119244-1240-1-git-send-email-saipava@xilinx.com>
References: <1524119244-1240-1-git-send-email-saipava@xilinx.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Fri, 20 Apr 2018 19:26:52 +0200
Message-ID: <CAAYMZQsP2UCa-4hbD9Mjryo5Ac=ZosQdEoDfcPoGA2r=kp5KVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] xilinx_spips: Correct SNOOP_NONE state
 when flushing the txfifo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Cc: alistair@alistair23.me, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Edde <edgar.iglesias@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 19 April 2018 at 08:27, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
wrote:

> SNOOP_NONE state handle is moved above in the if ladder, as it's same
> as SNOOP_STRIPPING during data cycles.
>
> Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>


> ---
> Changes for V2:
>         Fixed commit message
>         Reordered to code, to avoid code duplication.
> Changes for V3:
>         Dropped the cover letter, as its a minor fix now
>         Fixed commit message by explaining only what's fixed
>         removed the dummy_byte decrement changes
>
>  hw/ssi/xilinx_spips.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 426f971..03f5fae 100644
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
> --
> 2.7.4
>
>
>
