Received: from eggs.gnu.org ([209.51.188.92]:43580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1x6D-0007l6-5u
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1x6C-0001lu-9S
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:46:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1x6C-0001lE-2D
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:46:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so18458393wrw.0
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:46:27 -0800 (PST)
References: <20190307172401.29451-1-armbru@redhat.com>
	<20190307172401.29451-7-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a0c9dbfd-8e5c-fe62-3b5f-e01050b166e4@redhat.com>
Date: Thu, 7 Mar 2019 18:46:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190307172401.29451-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 06/12] vl: Factor configure_blockdev()
 out of main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com

On 3/7/19 6:23 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> # Conflicts:
> #	vl.c

^ leftover?

> ---
>  vl.c | 71 +++++++++++++++++++++++++++++++++---------------------------
>  1 file changed, 39 insertions(+), 32 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 00cb8ea7ca..5a19d2a8ec 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1201,6 +1201,44 @@ typedef struct BlockdevOptionsQueueEntry {
>  
>  typedef QSIMPLEQ_HEAD(, BlockdevOptionsQueueEntry) BlockdevOptionsQueue;
>  
> +static void configure_blockdev(BlockdevOptionsQueue *bdo_queue,
> +                               MachineClass *machine_class, int snapshot)
> +{
> +    /* If the currently selected machine wishes to override the units-per-bus
> +     * property of its default HBA interface type, do so now. */
> +    if (machine_class->units_per_default_bus) {
> +        override_max_devs(machine_class->block_default_type,
> +                          machine_class->units_per_default_bus);
> +    }
> +
> +    /* open the virtual block devices */
> +    while (!QSIMPLEQ_EMPTY(bdo_queue)) {
> +        BlockdevOptionsQueueEntry *bdo = QSIMPLEQ_FIRST(bdo_queue);
> +
> +        QSIMPLEQ_REMOVE_HEAD(bdo_queue, entry);
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
> +}
> +
>  static QemuOptsList qemu_smp_opts = {
>      .name = "smp-opts",
>      .implied_opt_name = "cpus",
> @@ -4360,38 +4398,7 @@ int main(int argc, char **argv, char **envp)
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
> -        BlockdevOptionsQueueEntry *bdo = QSIMPLEQ_FIRST(&bdo_queue);
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
> +    configure_blockdev(&bdo_queue, machine_class, snapshot);

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>      qemu_opts_foreach(qemu_find_opts("mon"),
>                        mon_init_func, NULL, &error_fatal);
> 
