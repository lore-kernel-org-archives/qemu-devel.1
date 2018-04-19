Received: from eggs.gnu.org ([2001:4830:134:3::10]:54129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1f9Ihe-0000OD-IU
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 19:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1f9Ihd-0004fi-HH
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 19:10:58 -0400
Received: from mail-lf0-x234.google.com ([2a00:1450:4010:c07::234]:34067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1f9Ihd-0004ds-9B
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 19:10:57 -0400
Received: by mail-lf0-x234.google.com with SMTP id r7-v6so2529121lfr.1
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 16:10:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180419112131.16932-5-edgar.iglesias@gmail.com>
References: <20180419112131.16932-1-edgar.iglesias@gmail.com>
	<20180419112131.16932-5-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Apr 2018 16:10:25 -0700
Message-ID: <CAKmqyKOZ-FRmxvHFw+EK-7cpiKqHZ76uv0SxLByMqMoVw8bA_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 4/5] target-microblaze: mmu: Make TLBSX
 write-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>

On Thu, Apr 19, 2018 at 4:21 AM, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Make TLBSX write-only and guest-error log reads from it.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/mmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index a0f06758f8..8391811900 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -182,7 +182,7 @@ done:
>  uint32_t mmu_read(CPUMBState *env, uint32_t rn)
>  {
>      unsigned int i;
> -    uint32_t r;
> +    uint32_t r = 0;
>
>      if (env->mmu.c_mmu < 2 || !env->mmu.c_mmu_tlb_access) {
>          qemu_log_mask(LOG_GUEST_ERROR, "MMU access on MMU-less system\n");
> @@ -211,6 +211,9 @@ uint32_t mmu_read(CPUMBState *env, uint32_t rn)
>              }
>              r = env->mmu.regs[rn];
>              break;
> +        case MMU_R_TLBSX:
> +            qemu_log_mask(LOG_GUEST_ERROR, "TLBSX is write-only.\n");
> +            break;
>          default:
>              r = env->mmu.regs[rn];
>              break;
> --
> 2.14.1
>
>
