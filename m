Received: from eggs.gnu.org ([2001:4830:134:3::10]:33847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fqiN0-00036Z-5p
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fqiMz-0003sI-7b
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:17:06 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:37545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fqiMy-0003rV-GN
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:17:05 -0400
Received: by mail-lf1-x143.google.com with SMTP id j8-v6so6402828lfb.4
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 10:17:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180817114619.22354-2-peter.maydell@linaro.org>
References: <20180817114619.22354-1-peter.maydell@linaro.org>
	<20180817114619.22354-2-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Aug 2018 10:16:31 -0700
Message-ID: <CAKmqyKNooJhmXm-kn1uDgj-EA57heTnw1M6S7YjpAQ66pHJ9OQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/ssi/xilinx_spips: Remove unneeded
 MMIO request_ptr code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Fri, Aug 17, 2018 at 4:46 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> We now support direct execution from MMIO regions in the
> core memory subsystem. This means that we don't need to
> have device-specific support for it, and we can remove
> the request_ptr handling from the Xilinx SPIPS device.
> (It was broken anyway due to race conditions, and disabled
> by default.)
>
> This device is the only in-tree user of this API.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/ssi/xilinx_spips.c | 46 -------------------------------------------
>  1 file changed, 46 deletions(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index c052bfc4b3c..16f88f74029 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1031,14 +1031,6 @@ static const MemoryRegionOps spips_ops = {
>
>  static void xilinx_qspips_invalidate_mmio_ptr(XilinxQSPIPS *q)
>  {
> -    XilinxSPIPS *s = &q->parent_obj;
> -
> -    if ((q->mmio_execution_enabled) && (q->lqspi_cached_addr != ~0ULL)) {
> -        /* Invalidate the current mapped mmio */
> -        memory_region_invalidate_mmio_ptr(&s->mmlqspi, q->lqspi_cached_addr,
> -                                          LQSPI_CACHE_SIZE);
> -    }
> -
>      q->lqspi_cached_addr = ~0ULL;
>  }
>
> @@ -1207,23 +1199,6 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
>      }
>  }
>
> -static void *lqspi_request_mmio_ptr(void *opaque, hwaddr addr, unsigned *size,
> -                                    unsigned *offset)
> -{
> -    XilinxQSPIPS *q = opaque;
> -    hwaddr offset_within_the_region;
> -
> -    if (!q->mmio_execution_enabled) {
> -        return NULL;
> -    }
> -
> -    offset_within_the_region = addr & ~(LQSPI_CACHE_SIZE - 1);
> -    lqspi_load_cache(opaque, offset_within_the_region);
> -    *size = LQSPI_CACHE_SIZE;
> -    *offset = offset_within_the_region;
> -    return q->lqspi_buf;
> -}
> -
>  static uint64_t
>  lqspi_read(void *opaque, hwaddr addr, unsigned int size)
>  {
> @@ -1245,7 +1220,6 @@ lqspi_read(void *opaque, hwaddr addr, unsigned int size)
>
>  static const MemoryRegionOps lqspi_ops = {
>      .read = lqspi_read,
> -    .request_ptr = lqspi_request_mmio_ptr,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
>          .min_access_size = 1,
> @@ -1322,15 +1296,6 @@ static void xilinx_qspips_realize(DeviceState *dev, Error **errp)
>      sysbus_init_mmio(sbd, &s->mmlqspi);
>
>      q->lqspi_cached_addr = ~0ULL;
> -
> -    /* mmio_execution breaks migration better aborting than having strange
> -     * bugs.
> -     */
> -    if (q->mmio_execution_enabled) {
> -        error_setg(&q->migration_blocker,
> -                   "enabling mmio_execution breaks migration");
> -        migrate_add_blocker(q->migration_blocker, &error_fatal);
> -    }
>  }
>
>  static void xlnx_zynqmp_qspips_realize(DeviceState *dev, Error **errp)
> @@ -1427,16 +1392,6 @@ static Property xilinx_zynqmp_qspips_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> -static Property xilinx_qspips_properties[] = {
> -    /* We had to turn this off for 2.10 as it is not compatible with migration.
> -     * It can be enabled but will prevent the device to be migrated.
> -     * This will go aways when a fix will be released.
> -     */
> -    DEFINE_PROP_BOOL("x-mmio-exec", XilinxQSPIPS, mmio_execution_enabled,
> -                     false),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static Property xilinx_spips_properties[] = {
>      DEFINE_PROP_UINT8("num-busses", XilinxSPIPS, num_busses, 1),
>      DEFINE_PROP_UINT8("num-ss-bits", XilinxSPIPS, num_cs, 4),
> @@ -1450,7 +1405,6 @@ static void xilinx_qspips_class_init(ObjectClass *klass, void * data)
>      XilinxSPIPSClass *xsc = XILINX_SPIPS_CLASS(klass);
>
>      dc->realize = xilinx_qspips_realize;
> -    dc->props = xilinx_qspips_properties;
>      xsc->reg_ops = &qspips_ops;
>      xsc->rx_fifo_size = RXFF_A_Q;
>      xsc->tx_fifo_size = TXFF_A_Q;
> --
> 2.18.0
>
>
