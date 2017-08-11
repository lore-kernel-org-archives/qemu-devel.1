Received: from eggs.gnu.org ([2001:4830:134:3::10]:36197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dgAwu-0005q6-5o
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dgAwq-00057S-0Y
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:30:04 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:37073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dgAwp-00056s-No
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:29:59 -0400
Received: by mail-lf0-x244.google.com with SMTP id x16so2433087lfb.4
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 07:29:58 -0700 (PDT)
Date: Fri, 11 Aug 2017 16:29:54 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170811142954.GN4859@toto>
References: <1502438052-5117-1-git-send-email-frederic.konrad@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502438052-5117-1-git-send-email-frederic.konrad@adacore.com>
Subject: Re: [Qemu-devel] [PATCH V2 for-2.10] xlnx-qspi: add a property for
 mmio-execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, alistair.francis@xilinx.com, dgilbert@redhat.com, quintela@redhat.com

On Fri, Aug 11, 2017 at 09:54:12AM +0200, KONRAD Frederic wrote:
> This adds mmio-exec property to workaround the migration bug.
> When enabled the migration is blocked and will return an error.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>

Thanks Fred!

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> V1 -> V2:
>   * changed mmio-exec to x-mmio-exec
> ---
>  hw/ssi/xilinx_spips.c | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index e833028..ef56d35 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -31,6 +31,8 @@
>  #include "hw/ssi/ssi.h"
>  #include "qemu/bitops.h"
>  #include "hw/ssi/xilinx_spips.h"
> +#include "qapi/error.h"
> +#include "migration/blocker.h"
>  
>  #ifndef XILINX_SPIPS_ERR_DEBUG
>  #define XILINX_SPIPS_ERR_DEBUG 0
> @@ -139,6 +141,8 @@ typedef struct {
>  
>      uint8_t lqspi_buf[LQSPI_CACHE_SIZE];
>      hwaddr lqspi_cached_addr;
> +    Error *migration_blocker;
> +    bool mmio_execution_enabled;
>  } XilinxQSPIPS;
>  
>  typedef struct XilinxSPIPSClass {
> @@ -500,12 +504,13 @@ static void xilinx_qspips_invalidate_mmio_ptr(XilinxQSPIPS *q)
>  {
>      XilinxSPIPS *s = &q->parent_obj;
>  
> -    if (q->lqspi_cached_addr != ~0ULL) {
> +    if ((q->mmio_execution_enabled) && (q->lqspi_cached_addr != ~0ULL)) {
>          /* Invalidate the current mapped mmio */
>          memory_region_invalidate_mmio_ptr(&s->mmlqspi, q->lqspi_cached_addr,
>                                            LQSPI_CACHE_SIZE);
> -        q->lqspi_cached_addr = ~0ULL;
>      }
> +
> +    q->lqspi_cached_addr = ~0ULL;
>  }
>  
>  static void xilinx_qspips_write(void *opaque, hwaddr addr,
> @@ -601,8 +606,13 @@ static void *lqspi_request_mmio_ptr(void *opaque, hwaddr addr, unsigned *size,
>                                      unsigned *offset)
>  {
>      XilinxQSPIPS *q = opaque;
> -    hwaddr offset_within_the_region = addr & ~(LQSPI_CACHE_SIZE - 1);
> +    hwaddr offset_within_the_region;
>  
> +    if (!q->mmio_execution_enabled) {
> +        return NULL;
> +    }
> +
> +    offset_within_the_region = addr & ~(LQSPI_CACHE_SIZE - 1);
>      lqspi_load_cache(opaque, offset_within_the_region);
>      *size = LQSPI_CACHE_SIZE;
>      *offset = offset_within_the_region;
> @@ -693,6 +703,15 @@ static void xilinx_qspips_realize(DeviceState *dev, Error **errp)
>      sysbus_init_mmio(sbd, &s->mmlqspi);
>  
>      q->lqspi_cached_addr = ~0ULL;
> +
> +    /* mmio_execution breaks migration better aborting than having strange
> +     * bugs.
> +     */
> +    if (q->mmio_execution_enabled) {
> +        error_setg(&q->migration_blocker,
> +                   "enabling mmio_execution breaks migration");
> +        migrate_add_blocker(q->migration_blocker, &error_fatal);
> +    }
>  }
>  
>  static int xilinx_spips_post_load(void *opaque, int version_id)
> @@ -716,6 +735,16 @@ static const VMStateDescription vmstate_xilinx_spips = {
>      }
>  };
>  
> +static Property xilinx_qspips_properties[] = {
> +    /* We had to turn this off for 2.10 as it is not compatible with migration.
> +     * It can be enabled but will prevent the device to be migrated.
> +     * This will go aways when a fix will be released.
> +     */
> +    DEFINE_PROP_BOOL("x-mmio-exec", XilinxQSPIPS, mmio_execution_enabled,
> +                     false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static Property xilinx_spips_properties[] = {
>      DEFINE_PROP_UINT8("num-busses", XilinxSPIPS, num_busses, 1),
>      DEFINE_PROP_UINT8("num-ss-bits", XilinxSPIPS, num_cs, 4),
> @@ -729,6 +758,7 @@ static void xilinx_qspips_class_init(ObjectClass *klass, void * data)
>      XilinxSPIPSClass *xsc = XILINX_SPIPS_CLASS(klass);
>  
>      dc->realize = xilinx_qspips_realize;
> +    dc->props = xilinx_qspips_properties;
>      xsc->reg_ops = &qspips_ops;
>      xsc->rx_fifo_size = RXFF_A_Q;
>      xsc->tx_fifo_size = TXFF_A_Q;
> -- 
> 1.8.3.1
> 
