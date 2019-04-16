Received: from eggs.gnu.org ([209.51.188.92]:37210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hGNmq-00033f-9y
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hGNmp-0007az-Cj
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:06:08 -0400
References: <20190416091348.26075-1-armbru@redhat.com>
	<20190416091348.26075-2-armbru@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <67a714c4-d76b-06dc-cb88-71142f5fbce6@redhat.com>
Date: Tue, 16 Apr 2019 15:04:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190416091348.26075-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] pc: Rearrange
 pc_system_firmware_init()'s legacy -drive loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, philmd@redhat.com

On 04/16/19 11:13, Markus Armbruster wrote:
> The loop does two things: map legacy -drive to properties, and collect
> all the backends for use after the loop.  The next patch will factor
> out the former for reuse in hw/arm/virt.c.  To make that easier,
> rearrange the loop so it does the first thing first, and the second
> thing second.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/i386/pc_sysfw.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index c628540774..75925f5d3f 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -280,21 +280,19 @@ void pc_system_firmware_init(PCMachineState *pcms,
>  
>      /* Map legacy -drive if=pflash to machine properties */
>      for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
> -        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>          pflash_drv = drive_get(IF_PFLASH, 0, i);
> -        if (!pflash_drv) {
> -            continue;
> +        if (pflash_drv) {
> +            loc_push_none(&loc);
> +            qemu_opts_loc_restore(pflash_drv->opts);
> +            if (pflash_cfi01_get_blk(pcms->flash[i])) {
> +                error_report("clashes with -machine");
> +                exit(1);
> +            }
> +            qdev_prop_set_drive(DEVICE(pcms->flash[i]), "drive",
> +                                blk_by_legacy_dinfo(pflash_drv), &error_fatal);
> +            loc_pop(&loc);
>          }
> -        loc_push_none(&loc);
> -        qemu_opts_loc_restore(pflash_drv->opts);
> -        if (pflash_blk[i]) {
> -            error_report("clashes with -machine");
> -            exit(1);
> -        }
> -        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
> -        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
> -                            "drive", pflash_blk[i], &error_fatal);
> -        loc_pop(&loc);
> +        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>      }
>  
>      /* Reject gaps */
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
