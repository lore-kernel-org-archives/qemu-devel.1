Received: from eggs.gnu.org ([2001:4830:134:3::10]:34822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpCVe-00030Q-W8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpCVa-0003lu-6q
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:59:15 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpCVZ-0003lD-Um
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:59:10 -0400
Received: by mail-wm0-x235.google.com with SMTP id u26so18146710wma.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 04:59:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170905112152.8851-1-ppandit@redhat.com>
References: <20170905112152.8851-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 12:58:47 +0100
Message-ID: <CAFEAcA8B4EwXCPSBsftt=QkAuH8jCBbK23-uU7NA7G3k6ADHLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] intc: arm_gicv3: limit GICR ipriority index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Guoxiang Niu <niuguoxiang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 5 September 2017 at 12:21, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> When reading or writing to GICR ipriority array, index 'irq'
> could go beyond its bounds; Restrict it within array limits.
>
> Reported-by: Guoxiang Niu <niuguoxiang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/intc/arm_gicv3_redist.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
> index 77e5cfa327..7683c4cc7f 100644
> --- a/hw/intc/arm_gicv3_redist.c
> +++ b/hw/intc/arm_gicv3_redist.c
> @@ -187,7 +187,7 @@ static MemTxResult gicr_readl(GICv3CPUState *cs, hwaddr offset,
>      case GICR_ICACTIVER0:
>          *data = gicr_read_bitmap_reg(cs, attrs, cs->gicr_iactiver0);
>          return MEMTX_OK;
> -    case GICR_IPRIORITYR ... GICR_IPRIORITYR + 0x1f:
> +    case GICR_IPRIORITYR ... GICR_IPRIORITYR + 0x1c:
>      {
>          int i, irq = offset - GICR_IPRIORITYR;
>          uint32_t value = 0;
> @@ -310,7 +310,7 @@ static MemTxResult gicr_writel(GICv3CPUState *cs, hwaddr offset,
>      case GICR_ICACTIVER0:
>          gicr_write_clear_bitmap_reg(cs, attrs, &cs->gicr_iactiver0, value);
>          return MEMTX_OK;
> -    case GICR_IPRIORITYR ... GICR_IPRIORITYR + 0x1f:
> +    case GICR_IPRIORITYR ... GICR_IPRIORITYR + 0x1c:
>      {
>          int i, irq = offset - GICR_IPRIORITYR;

Why do you think the buffer can be overrun? These functions
are the word (4 byte) access functions, and they cannot
be called with a non-4-aligned offset (see the asserts in
gicv3_redist_read() and gicv3_redist_write()).

thanks
-- PMM
