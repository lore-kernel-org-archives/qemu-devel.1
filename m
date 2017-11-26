Received: from eggs.gnu.org ([2001:4830:134:3::10]:45534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIyZZ-0006zk-Im
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 10:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIyZU-0003X9-J4
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 10:10:21 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:45839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIyZU-0003Wd-E8
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 10:10:16 -0500
Received: by mail-qk0-x243.google.com with SMTP id d125so29525442qkc.12
	for <qemu-devel@nongnu.org>; Sun, 26 Nov 2017 07:10:16 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171124212938.7074-1-frasse.iglesias@gmail.com>
	<20171124212938.7074-6-frasse.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <36d54d9b-e3cd-f8a3-8b9c-297792d992fc@amsat.org>
Date: Sat, 25 Nov 2017 21:48:40 -0300
MIME-Version: 1.0
In-Reply-To: <20171124212938.7074-6-frasse.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 05/13] xilinx_spips: Move FlashCMD,
 XilinxQSPIPS and XilinxSPIPSClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, mar.krzeminski@gmail.com

On 11/24/2017 06:29 PM, Francisco Iglesias wrote:
> Move the FlashCMD enum, XilinxQSPIPS and XilinxSPIPSClass structures to the
> header for consistency (struct XilinxSPIPS is found there). Also move out
> a define and remove two double included headers (while touching the code).
> Finally, add 4 byte address commands to the FlashCMD enum.
> 
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ssi/xilinx_spips.c         | 35 -----------------------------------
>  include/hw/ssi/xilinx_spips.h | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 35 deletions(-)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index ef56d35..559fa79 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -27,8 +27,6 @@
>  #include "sysemu/sysemu.h"
>  #include "hw/ptimer.h"
>  #include "qemu/log.h"
> -#include "qemu/fifo8.h"
> -#include "hw/ssi/ssi.h"
>  #include "qemu/bitops.h"
>  #include "hw/ssi/xilinx_spips.h"
>  #include "qapi/error.h"
> @@ -116,44 +114,11 @@
>  
>  /* 16MB per linear region */
>  #define LQSPI_ADDRESS_BITS 24
> -/* Bite off 4k chunks at a time */
> -#define LQSPI_CACHE_SIZE 1024
>  
>  #define SNOOP_CHECKING 0xFF
>  #define SNOOP_NONE 0xFE
>  #define SNOOP_STRIPING 0
>  
> -typedef enum {
> -    READ = 0x3,
> -    FAST_READ = 0xb,
> -    DOR = 0x3b,
> -    QOR = 0x6b,
> -    DIOR = 0xbb,
> -    QIOR = 0xeb,
> -
> -    PP = 0x2,
> -    DPP = 0xa2,
> -    QPP = 0x32,
> -} FlashCMD;
> -
> -typedef struct {
> -    XilinxSPIPS parent_obj;
> -
> -    uint8_t lqspi_buf[LQSPI_CACHE_SIZE];
> -    hwaddr lqspi_cached_addr;
> -    Error *migration_blocker;
> -    bool mmio_execution_enabled;
> -} XilinxQSPIPS;
> -
> -typedef struct XilinxSPIPSClass {
> -    SysBusDeviceClass parent_class;
> -
> -    const MemoryRegionOps *reg_ops;
> -
> -    uint32_t rx_fifo_size;
> -    uint32_t tx_fifo_size;
> -} XilinxSPIPSClass;
> -
>  static inline int num_effective_busses(XilinxSPIPS *s)
>  {
>      return (s->regs[R_LQSPI_CFG] & LQSPI_CFG_SEP_BUS &&
> diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
> index 06aa096..7f9e2fc 100644
> --- a/include/hw/ssi/xilinx_spips.h
> +++ b/include/hw/ssi/xilinx_spips.h
> @@ -32,6 +32,22 @@ typedef struct XilinxSPIPS XilinxSPIPS;
>  
>  #define XLNX_SPIPS_R_MAX        (0x100 / 4)
>  
> +/* Bite off 4k chunks at a time */
> +#define LQSPI_CACHE_SIZE 1024
> +
> +typedef enum {
> +    READ = 0x3,         READ_4 = 0x13,
> +    FAST_READ = 0xb,    FAST_READ_4 = 0x0c,
> +    DOR = 0x3b,         DOR_4 = 0x3c,
> +    QOR = 0x6b,         QOR_4 = 0x6c,
> +    DIOR = 0xbb,        DIOR_4 = 0xbc,
> +    QIOR = 0xeb,        QIOR_4 = 0xec,
> +
> +    PP = 0x2,           PP_4 = 0x12,
> +    DPP = 0xa2,
> +    QPP = 0x32,         QPP_4 = 0x34,
> +} FlashCMD;
> +
>  struct XilinxSPIPS {
>      SysBusDevice parent_obj;
>  
> @@ -56,6 +72,24 @@ struct XilinxSPIPS {
>      uint32_t regs[XLNX_SPIPS_R_MAX];
>  };
>  
> +typedef struct {
> +    XilinxSPIPS parent_obj;
> +
> +    uint8_t lqspi_buf[LQSPI_CACHE_SIZE];
> +    hwaddr lqspi_cached_addr;
> +    Error *migration_blocker;
> +    bool mmio_execution_enabled;
> +} XilinxQSPIPS;
> +
> +typedef struct XilinxSPIPSClass {
> +    SysBusDeviceClass parent_class;
> +
> +    const MemoryRegionOps *reg_ops;
> +
> +    uint32_t rx_fifo_size;
> +    uint32_t tx_fifo_size;
> +} XilinxSPIPSClass;
> +
>  #define TYPE_XILINX_SPIPS "xlnx.ps7-spi"
>  #define TYPE_XILINX_QSPIPS "xlnx.ps7-qspi"
>  
> 
