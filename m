Received: from eggs.gnu.org ([209.51.188.92]:43240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0qEr-0006Ga-JR
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0qEp-00077a-M0
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:14:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0qEl-0006yE-Qb
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:14:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id i16so6168374wrs.13
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 08:14:35 -0800 (PST)
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-6-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8691f7df-c802-9528-a474-3bcdfa2aa498@redhat.com>
Date: Mon, 4 Mar 2019 17:14:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190225183757.27378-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 5/6] vl: Create block backends before
 setting machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 2/25/19 7:37 PM, Markus Armbruster wrote:
> qemu-system-FOO's main() acts on command line arguments in its own
> idiosyncratic order.  There's not much method to its madness.
> Whenever we find a case where one kind of command line argument needs
> to refer to something created for another kind later, we rejigger the
> order.
> 
> Block devices get created long after machine properties get processed.
> Therefore, block device machine properties can be created, but not
> set.  No such properties exist.  But the next commit will create some.
> Time to rejigger again: create block devices earlier.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  vl.c | 66 ++++++++++++++++++++++++++++++------------------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 6ce3d2d448..5cb0810ffa 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4232,6 +4232,39 @@ int main(int argc, char **argv, char **envp)
>          exit(0);
>      }
>  

Can we extract this from the main, maybe as "parse_blockdev()"? This
will ease further rejigger :)

> +    /* If the currently selected machine wishes to override the units-per-bus
> +     * property of its default HBA interface type, do so now. */
> +    if (machine_class->units_per_default_bus) {
> +        override_max_devs(machine_class->block_default_type,
> +                          machine_class->units_per_default_bus);
> +    }
> +
> +    /* open the virtual block devices */
> +    while (!QSIMPLEQ_EMPTY(&bdo_queue)) {
> +        BlockdevOptions_queue *bdo = QSIMPLEQ_FIRST(&bdo_queue);
> +
> +        QSIMPLEQ_REMOVE_HEAD(&bdo_queue, entry);
> +        loc_push_restore(&bdo->loc);
> +        qmp_blockdev_add(bdo->bdo, &error_fatal);
> +        loc_pop(&bdo->loc);
> +        qapi_free_BlockdevOptions(bdo->bdo);
> +        g_free(bdo);
> +    }
> +    if (snapshot || replay_mode != REPLAY_MODE_NONE) {
> +        qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
> +                          NULL, NULL);
> +    }
> +    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
> +                          &machine_class->block_default_type, &error_fatal)) {
> +        /* We printed help */
> +        exit(0);
> +    }
> +
> +    default_drive(default_cdrom, snapshot, machine_class->block_default_type, 2,
> +                  CDROM_OPTS);
> +    default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
> +    default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
> +

Can you add a comment here such:

   /*
    * Arguments setting properties on devices has to be processed before
    * the following qemu_opt_foreach(...machine_set_property...) call.
    */

>      machine_opts = qemu_get_machine_opts();
>      qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
>                       &error_fatal);
> @@ -4355,39 +4388,6 @@ int main(int argc, char **argv, char **envp)
>      ram_mig_init();
>      dirty_bitmap_mig_init();
>  
> -    /* If the currently selected machine wishes to override the units-per-bus
> -     * property of its default HBA interface type, do so now. */
> -    if (machine_class->units_per_default_bus) {
> -        override_max_devs(machine_class->block_default_type,
> -                          machine_class->units_per_default_bus);
> -    }
> -
> -    /* open the virtual block devices */
> -    while (!QSIMPLEQ_EMPTY(&bdo_queue)) {
> -        BlockdevOptions_queue *bdo = QSIMPLEQ_FIRST(&bdo_queue);
> -
> -        QSIMPLEQ_REMOVE_HEAD(&bdo_queue, entry);
> -        loc_push_restore(&bdo->loc);
> -        qmp_blockdev_add(bdo->bdo, &error_fatal);
> -        loc_pop(&bdo->loc);
> -        qapi_free_BlockdevOptions(bdo->bdo);
> -        g_free(bdo);
> -    }
> -    if (snapshot || replay_mode != REPLAY_MODE_NONE) {
> -        qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
> -                          NULL, NULL);
> -    }
> -    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
> -                          &machine_class->block_default_type, &error_fatal)) {
> -        /* We printed help */
> -        exit(0);
> -    }
> -
> -    default_drive(default_cdrom, snapshot, machine_class->block_default_type, 2,
> -                  CDROM_OPTS);
> -    default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
> -    default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
> -
>      qemu_opts_foreach(qemu_find_opts("mon"),
>                        mon_init_func, NULL, &error_fatal);
>  

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
