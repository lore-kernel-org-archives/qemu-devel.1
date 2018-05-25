Received: from eggs.gnu.org ([2001:4830:134:3::10]:37625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fMLOL-0004wA-9r
	for qemu-devel@nongnu.org; Fri, 25 May 2018 18:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fMLOK-0000Rs-9E
	for qemu-devel@nongnu.org; Fri, 25 May 2018 18:40:57 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fMLOK-0000Qf-2a
	for qemu-devel@nongnu.org; Fri, 25 May 2018 18:40:56 -0400
Received: by mail-wr0-x241.google.com with SMTP id k5-v6so11562614wrn.3
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 15:40:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-24-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-24-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 25 May 2018 15:40:24 -0700
Message-ID: <CAKmqyKNkmx-x8tzX0_OMX3P7k9aXotWJNvmWNDQrcNOHBDjtMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 23/30] RISC-V: Fix CLINT timecmp low
 32-bit writes
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
> A missing shift made updates to the low order bits
> of timecmp erroneously copy the old low order bits
> into the high order bits of the 64-bit timecmp
> register. Add the missing shift and rename timecmp
> local variables to timecmp_hi and timecmp_lo.
>
> This bug didn't show up as the low order bits are
> usually written first followed by the high order
> bits meaning the high order bits contained an invalid
> value between the timecmp_lo and timecmp_hi update.
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Co-Authored-by: Johannes Haring <johannes.haring@gmx.net>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_clint.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
> index 0d2fd52487e6..d4c159e93736 100644
> --- a/hw/riscv/sifive_clint.c
> +++ b/hw/riscv/sifive_clint.c
> @@ -146,15 +146,15 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
>              error_report("clint: invalid timecmp hartid: %zu", hartid);
>          } else if ((addr & 0x7) == 0) {
>              /* timecmp_lo */
> -            uint64_t timecmp = env->timecmp;
> +            uint64_t timecmp_hi = env->timecmp >> 32;
>              sifive_clint_write_timecmp(RISCV_CPU(cpu),
> -                timecmp << 32 | (value & 0xFFFFFFFF));
> +                timecmp_hi << 32 | (value & 0xFFFFFFFF));
>              return;
>          } else if ((addr & 0x7) == 4) {
>              /* timecmp_hi */
> -            uint64_t timecmp = env->timecmp;
> +            uint64_t timecmp_lo = env->timecmp;
>              sifive_clint_write_timecmp(RISCV_CPU(cpu),
> -                value << 32 | (timecmp & 0xFFFFFFFF));
> +                value << 32 | (timecmp_lo & 0xFFFFFFFF));
>          } else {
>              error_report("clint: invalid timecmp write: %08x", (uint32_t)addr);
>          }
> --
> 2.7.0
>
>
