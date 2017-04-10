Received: from eggs.gnu.org ([2001:4830:134:3::10]:50675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxYh0-0006BJ-Ge
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxYgu-0007jB-VI
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:45:14 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxYgu-0007hW-OA
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:45:08 -0400
Received: by mail-wm0-x231.google.com with SMTP id o81so37840708wmb.1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 05:45:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <325f60be9b819f261848db3d69554da640294ca4.1491349058.git.alistair.francis@xilinx.com>
References: <cover.1491349058.git.alistair.francis@xilinx.com>
	<325f60be9b819f261848db3d69554da640294ca4.1491349058.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 13:44:47 +0100
Message-ID: <CAFEAcA9Pp85ir53BEsd2dT=6iG8gi_6hH2hGkn12Fus0k1K8FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v1 3/5] cadence_gem: Only trigger
 interrupts if the status register is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On 5 April 2017 at 00:40, Alistair Francis <alistair.francis@xilinx.com> wrote:
> Only trigger multi-queue GEM interrupts if the interrupt status register
> is set. This logic was already used for non multi-queue interrupts but
> it also applies to multi-queue interrupts.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>
>  hw/net/cadence_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 3e37665..b9eaed4 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -518,7 +518,7 @@ static void gem_update_int_status(CadenceGEMState *s)
>      }
>
>      for (i = 0; i < s->num_priority_queues; ++i) {
> -        if (s->regs[GEM_INT_Q1_STATUS + i]) {
> +        if (s->regs[GEM_INT_Q1_STATUS + i] && s->regs[GEM_ISR]) {
>              DB_PRINT("asserting int. (q=%d)\n", i);
>              qemu_set_irq(s->irq[i], 1);
>          }

With this change, if s->regs[GEM_ISR] is zero then the entire
function never does anything, so you could hoist that up to
the start, rather than testing it inside the loop and in the
previous conditional.

Also the comment says "raise or lower interrupt based on current
status", but the code will only ever do qemu_set_irq(..., 1),
never 0. Which is right?

thanks
-- PMM
