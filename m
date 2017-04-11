Received: from eggs.gnu.org ([2001:4830:134:3::10]:54050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cxyAA-0007cG-HT
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cxyA9-00008L-Ni
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:57:02 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1cxyA9-000075-Ix
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:57:01 -0400
Received: by mail-oi0-x241.google.com with SMTP id b187so277679oif.3
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 08:57:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a0557701e77d1dcb7332b0885cab8f6b719c5139.1491865973.git.alistair.francis@xilinx.com>
References: <cover.1491865973.git.alistair.francis@xilinx.com>
	<a0557701e77d1dcb7332b0885cab8f6b719c5139.1491865973.git.alistair.francis@xilinx.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Apr 2017 08:56:30 -0700
Message-ID: <CAKmqyKO=L4WnTWrcRbJuhgGM0Y9qQUoBWyy8q=j9WgqiBYikAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 3/5] cadence_gem: Correct the interupt
 logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Mon, Apr 10, 2017 at 4:43 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> This patch fixes two mistakes in the interrupt logic.
>
> First we only trigger single-queue or multi-queue interrupts if the status
> register is set. This logic was already used for non multi-queue interrupts
> but it also applies to multi-queue interrupts.
>
> Secondly we need to lower the interrupts if the ISR isn't set. As part
> of this we can remove the other interrupt lowering logic and consolidate
> it inside gem_update_int_status().
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

This patch can be cleaned up more, I'll send a V3.

Thanks,

Alistair

> ---
>
>  hw/net/cadence_gem.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index a66a9cc..fc3a184 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -509,7 +509,18 @@ static void gem_update_int_status(CadenceGEMState *s)
>  {
>      int i;
>
> -    if ((s->num_priority_queues == 1) && s->regs[GEM_ISR]) {
> +    if (!s->regs[GEM_ISR]) {
> +        /* ISR isn't set, clear all the interrupts */
> +        for (i = 0; i < s->num_priority_queues; ++i) {
> +            qemu_set_irq(s->irq[i], 0);
> +        }
> +        return;
> +    }
> +
> +    /* If we get here we know s->regs[GEM_ISR] is set, so we don't need to
> +     * check it again.
> +     */
> +    if (s->num_priority_queues == 1) {
>          /* No priority queues, just trigger the interrupt */
>          DB_PRINT("asserting int.\n");
>          qemu_set_irq(s->irq[0], 1);
> @@ -1274,7 +1285,6 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
>  {
>      CadenceGEMState *s;
>      uint32_t retval;
> -    int i;
>      s = (CadenceGEMState *)opaque;
>
>      offset >>= 2;
> @@ -1285,9 +1295,7 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
>      switch (offset) {
>      case GEM_ISR:
>          DB_PRINT("lowering irqs on ISR read\n");
> -        for (i = 0; i < s->num_priority_queues; ++i) {
> -            qemu_set_irq(s->irq[i], 0);
> -        }
> +        gem_update_int_status(s);
>          break;
>      case GEM_PHYMNTNC:
>          if (retval & GEM_PHYMNTNC_OP_R) {
> --
> 2.9.3
>
