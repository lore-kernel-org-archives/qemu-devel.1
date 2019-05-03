Received: from eggs.gnu.org ([209.51.188.92]:56004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMZml-0005JR-Et
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMZmk-0004BH-3Q
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:07:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMZmj-0004Aa-Tn
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:07:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id p21so7503507wmc.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:07:37 -0700 (PDT)
References: <20190503022958.1394-1-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1f32879b-63ac-5cf2-2f1e-6bcc4da99220@redhat.com>
Date: Fri, 3 May 2019 17:07:35 +0200
MIME-Version: 1.0
In-Reply-To: <20190503022958.1394-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] arm: aspeed: Set SDRAM size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 5/3/19 4:29 AM, Joel Stanley wrote:
> We currently use Qemu's default of 128MB. As we know how much ram each
> machine ships with, make it easier on users by setting a default.
> 
> It can still be overridden with -m on the command line.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I did review this patch:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00109.html

So:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v2:
>  - Fix 'if' style issue. Thanks patchew
>  - Use units.h defines
> 
>  hw/arm/aspeed.c         | 8 ++++++++
>  include/hw/arm/aspeed.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 1c23ebd99252..29d225ed1405 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -25,6 +25,7 @@
>  #include "sysemu/block-backend.h"
>  #include "hw/loader.h"
>  #include "qemu/error-report.h"
> +#include "qemu/units.h"
>  
>  static struct arm_boot_info aspeed_board_binfo = {
>      .board_id = -1, /* device-tree-only board */
> @@ -331,6 +332,9 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
>      mc->no_parallel = 1;
> +    if (board->ram) {
> +        mc->default_ram_size = board->ram;
> +    }
>      amc->board = board;
>  }
>  
> @@ -352,6 +356,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
>          .spi_model = "mx25l25635e",
>          .num_cs    = 1,
>          .i2c_init  = palmetto_bmc_i2c_init,
> +        .ram       = 256 * MiB,
>      }, {
>          .name      = MACHINE_TYPE_NAME("ast2500-evb"),
>          .desc      = "Aspeed AST2500 EVB (ARM1176)",
> @@ -361,6 +366,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
>          .spi_model = "mx25l25635e",
>          .num_cs    = 1,
>          .i2c_init  = ast2500_evb_i2c_init,
> +        .ram       = 512 * MiB,
>      }, {
>          .name      = MACHINE_TYPE_NAME("romulus-bmc"),
>          .desc      = "OpenPOWER Romulus BMC (ARM1176)",
> @@ -370,6 +376,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
>          .spi_model = "mx66l1g45g",
>          .num_cs    = 2,
>          .i2c_init  = romulus_bmc_i2c_init,
> +        .ram       = 512 * MiB,
>      }, {
>          .name      = MACHINE_TYPE_NAME("witherspoon-bmc"),
>          .desc      = "OpenPOWER Witherspoon BMC (ARM1176)",
> @@ -379,6 +386,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
>          .spi_model = "mx66l1g45g",
>          .num_cs    = 2,
>          .i2c_init  = witherspoon_bmc_i2c_init,
> +        .ram       = 512 * MiB,
>      },
>  };
>  
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index 325c091d09e4..02073a6b4d61 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -22,6 +22,7 @@ typedef struct AspeedBoardConfig {
>      const char *spi_model;
>      uint32_t num_cs;
>      void (*i2c_init)(AspeedBoardState *bmc);
> +    uint32_t ram;
>  } AspeedBoardConfig;
>  
>  #define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
> 
