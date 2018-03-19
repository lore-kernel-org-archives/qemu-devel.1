Received: from eggs.gnu.org ([2001:4830:134:3::10]:46017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exxaZ-0003Nh-Fj
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exxaY-0006Nt-Ed
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:24:47 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:45209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1exxaY-0006Ma-AE
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:24:46 -0400
Received: by mail-oi0-x241.google.com with SMTP id 71so3401290oie.12
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 09:24:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521470177-14760-2-git-send-email-zhaoshenglong@huawei.com>
References: <1521470177-14760-1-git-send-email-zhaoshenglong@huawei.com>
	<1521470177-14760-2-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 16:24:25 +0000
Message-ID: <CAFEAcA8+Gqn=TMnu2X7YcSjtJxnGPGY15Epi_ds1x=dguycyvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] arm_gicv3_kvm: increase clroffset
 accordingly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>

On 19 March 2018 at 14:36, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> It forgot to increase clroffset during the loop. So it only clear the
> first 4 bytes.
>
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
> ---
>  hw/intc/arm_gicv3_kvm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index ec37177..7000716 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -232,9 +232,10 @@ static void kvm_dist_getbmp(GICv3State *s, uint32_t offset, uint32_t *bmp)
>  static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
>                              uint32_t clroffset, uint32_t *bmp)
>  {
> -    uint32_t reg;
> +    uint32_t reg, clroffset_index;
>      int irq;
>
> +    clroffset_index = clroffset;
>      for_each_dist_irq_reg(irq, s->num_irq, 1) {
>          /* If this bitmap is a set/clear register pair, first write to the
>           * clear-reg to clear all bits before using the set-reg to write
> @@ -242,7 +243,8 @@ static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
>           */
>          if (clroffset != 0) {
>              reg = 0;
> -            kvm_gicd_access(s, clroffset, &reg, true);
> +            kvm_gicd_access(s, clroffset_index, &reg, true);
> +            clroffset_index += 4;
>          }
>          reg = *gic_bmp_ptr32(bmp, irq);
>          kvm_gicd_access(s, offset, &reg, true);

You might as well just use 'clroffset' directly rather than
creating a new clroffset_index variable, I think.

thanks
-- PMM
