Received: from eggs.gnu.org ([2001:4830:134:3::10]:36579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fMLMP-00045q-Vy
	for qemu-devel@nongnu.org; Fri, 25 May 2018 18:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fMLMO-0006eQ-Um
	for qemu-devel@nongnu.org; Fri, 25 May 2018 18:38:58 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:41337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fMLMO-0006dK-P2
	for qemu-devel@nongnu.org; Fri, 25 May 2018 18:38:56 -0400
Received: by mail-wr0-x242.google.com with SMTP id u12-v6so11537553wrn.8
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 15:38:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-25-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-25-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 25 May 2018 15:38:25 -0700
Message-ID: <CAKmqyKM7E5g-24sLEwM_EGBwEV+tzd4svm-B7Z8g+RFZ5rgMaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 24/30] RISC-V: Fix PLIC pending bitfield
 reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On Tue, May 22, 2018 at 5:15 PM, Michael Clark <mjc@sifive.com> wrote:
> The address calculation for the pending bitfield had
> a copy paste bug. This bug went unnoticed because the Linux
> PLIC driver does not read the pending bitfield, rather it
> reads pending interrupt numbers from the claim register
> and writes acknowledgements back to the claim register.
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Reported-by: Vincent Siles <vincent.siles@ens-lyon.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_plic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
> index 28e28d932f7c..b81d29faff99 100644
> --- a/hw/riscv/sifive_plic.c
> +++ b/hw/riscv/sifive_plic.c
> @@ -215,7 +215,7 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
>      } else if (addr >= plic->pending_base && /* 1 bit per source */
>                 addr < plic->pending_base + (plic->num_sources >> 3))
>      {
> -        uint32_t word = (addr - plic->priority_base) >> 2;
> +        uint32_t word = (addr - plic->pending_base) >> 2;
>          if (RISCV_DEBUG_PLIC) {
>              qemu_log("plic: read pending: word=%d value=%d\n",
>                  word, plic->pending[word]);
> --
> 2.7.0
>
>
