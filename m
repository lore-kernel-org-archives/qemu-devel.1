Received: from eggs.gnu.org ([209.51.188.92]:44511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gvmIv-00040g-Hz
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gvmIu-0001zn-QO
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:02:05 -0500
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-10-armbru@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <24f3ced9-10cd-0ceb-0ed7-1e10a7803eca@redhat.com>
Date: Mon, 18 Feb 2019 18:01:58 +0100
MIME-Version: 1.0
In-Reply-To: <20190218125615.18970-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/10] pflash: Clean up after commit
 368a354f02b part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org

On 02/18/19 13:56, Markus Armbruster wrote:
> QOMification left parameter @size unused in pflash_cfi01_register()
> and pflash_cfi02_register().  register().  Obviously, @size should
> match @sector_len and @nb_blocs, i.e. size == sector_len * nb_blocs.
> All callers satisfy this.
> 
> Remove @nb_blocs and compute it from @size and @sector_len.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/collie.c                          | 5 +++--
>  hw/arm/digic_boards.c                    | 1 -
>  hw/arm/gumstix.c                         | 4 ++--
>  hw/arm/mainstone.c                       | 2 +-
>  hw/arm/musicpal.c                        | 4 ++--
>  hw/arm/omap_sx1.c                        | 4 ++--
>  hw/arm/versatilepb.c                     | 1 -
>  hw/arm/xilinx_zynq.c                     | 3 +--
>  hw/arm/z2.c                              | 2 +-
>  hw/block/pflash_cfi01.c                  | 5 +++--
>  hw/block/pflash_cfi02.c                  | 5 +++--
>  hw/i386/pc_sysfw.c                       | 6 +-----
>  hw/lm32/lm32_boards.c                    | 4 ++--
>  hw/lm32/milkymist.c                      | 2 +-
>  hw/microblaze/petalogix_ml605_mmu.c      | 2 +-
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 +-
>  hw/mips/mips_malta.c                     | 7 +++----
>  hw/mips/mips_r4k.c                       | 2 +-
>  hw/ppc/ppc405_boards.c                   | 6 +++---
>  hw/ppc/sam460ex.c                        | 2 +-
>  hw/ppc/virtex_ml507.c                    | 2 +-
>  hw/sh4/r2d.c                             | 2 +-
>  include/hw/block/flash.h                 | 4 ++--
>  23 files changed, 36 insertions(+), 41 deletions(-)

> @@ -1268,15 +1267,15 @@ void mips_malta_init(MachineState *machine)
>  #ifdef DEBUG_BOARD_INIT
>      if (dinfo) {
>          printf("Register parallel flash %d size " TARGET_FMT_lx " at "
> -               "addr %08llx '%s' %x\n",
> +               "addr %08llx '%s'\n",
>                 fl_idx, FLASH_SIZE, FLASH_ADDRESS,
> -               blk_name(dinfo->bdrv), fl_sectors);
> +               blk_name(dinfo->bdrv));
>      }
>  #endif

This change is somewhat observable, but I guess it's harmless.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
