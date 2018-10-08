Received: from eggs.gnu.org ([2001:4830:134:3::10]:59489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9UgM-0003g6-QA
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9UgL-00078g-SH
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:30:42 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9UgL-00077I-Cs
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:30:41 -0400
Received: by mail-ot1-x342.google.com with SMTP id l58so4532487otd.6
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 05:30:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538579266-8389-7-git-send-email-edgar.iglesias@gmail.com>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-7-git-send-email-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 13:30:20 +0100
Message-ID: <CAFEAcA9_EOFV=5i-4S1GWVgewAa89hJDTegnf9Ot3w7rfkZWYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 06/12] net: cadence_gem: Add support for
 selecting the DMA MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 3 October 2018 at 16:07, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add support for selecting the Memory Region that the GEM
> will do DMA to.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  hw/net/cadence_gem.c         | 63 ++++++++++++++++++++++++++++----------------
>  include/hw/net/cadence_gem.h |  2 ++
>  2 files changed, 43 insertions(+), 22 deletions(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 759c1d7..ab02515 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -28,6 +28,7 @@
>  #include "hw/net/cadence_gem.h"
>  #include "qapi/error.h"
>  #include "qemu/log.h"
> +#include "sysemu/dma.h"
>  #include "net/checksum.h"
>
>  #ifdef CADENCE_GEM_ERR_DEBUG
> @@ -835,9 +836,9 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
>  {
>      DB_PRINT("read descriptor 0x%x\n", (unsigned)s->rx_desc_addr[q]);
>      /* read current descriptor */
> -    cpu_physical_memory_read(s->rx_desc_addr[q],
> -                             (uint8_t *)s->rx_desc[q],
> -                             sizeof(uint32_t) * gem_get_desc_len(s, true));
> +    address_space_read(s->dma_as, s->rx_desc_addr[q], MEMTXATTRS_UNSPECIFIED,
> +                       (uint8_t *)s->rx_desc[q],
> +                       sizeof(uint32_t) * gem_get_desc_len(s, true));

At some point you might want to add support for handling "descriptor
read/write failed", incidentally: address_space_read/write return a
MemTxResult which you can check for != MEMTX_OK.

thanks
-- PMM
