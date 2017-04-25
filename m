Received: from eggs.gnu.org ([2001:4830:134:3::10]:55157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d31Fx-00024d-P2
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d31Fu-0007dc-IP
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:15:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1d31Fu-0007dN-7Y
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:15:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09A6F46D0A6
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 14:15:49 +0000 (UTC)
References: <20170425102446.4008-1-quintela@redhat.com>
	<20170425102446.4008-6-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <53bc98ec-fbfd-318c-4613-2c14b4e9b65e@redhat.com>
Date: Tue, 25 Apr 2017 16:15:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170425102446.4008-6-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] monitor: Move hmp_info_snapshots from
 savevm.c to hmp.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 25/04/2017 12:24, Juan Quintela wrote:
> It only uses block/* functions, nothing from migration.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Perhaps the monitor.h include in savevm.c can be removed in PATCH 1/6?

Laurent

> ---
>  hmp.c                   | 143 ++++++++++++++++++++++++++++++++++++++++++++++
>  hmp.h                   |   1 +
>  include/sysemu/sysemu.h |   1 -
>  migration/savevm.c      | 147 ------------------------------------------------
>  4 files changed, 144 insertions(+), 148 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index bb739ce..bd7b1ca 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1299,6 +1299,149 @@ void hmp_delvm(Monitor *mon, const QDict *qdict)
>      }
>  }
>  
> +void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
> +{
> +    BlockDriverState *bs, *bs1;
> +    BdrvNextIterator it1;
> +    QEMUSnapshotInfo *sn_tab, *sn;
> +    bool no_snapshot = true;
> +    int nb_sns, i;
> +    int total;
> +    int *global_snapshots;
> +    AioContext *aio_context;
> +
> +    typedef struct SnapshotEntry {
> +        QEMUSnapshotInfo sn;
> +        QTAILQ_ENTRY(SnapshotEntry) next;
> +    } SnapshotEntry;
> +
> +    typedef struct ImageEntry {
> +        const char *imagename;
> +        QTAILQ_ENTRY(ImageEntry) next;
> +        QTAILQ_HEAD(, SnapshotEntry) snapshots;
> +    } ImageEntry;
> +
> +    QTAILQ_HEAD(, ImageEntry) image_list =
> +        QTAILQ_HEAD_INITIALIZER(image_list);
> +
> +    ImageEntry *image_entry, *next_ie;
> +    SnapshotEntry *snapshot_entry;
> +
> +    bs = bdrv_all_find_vmstate_bs();
> +    if (!bs) {
> +        monitor_printf(mon, "No available block device supports snapshots\n");
> +        return;
> +    }
> +    aio_context = bdrv_get_aio_context(bs);
> +
> +    aio_context_acquire(aio_context);
> +    nb_sns = bdrv_snapshot_list(bs, &sn_tab);
> +    aio_context_release(aio_context);
> +
> +    if (nb_sns < 0) {
> +        monitor_printf(mon, "bdrv_snapshot_list: error %d\n", nb_sns);
> +        return;
> +    }
> +
> +    for (bs1 = bdrv_first(&it1); bs1; bs1 = bdrv_next(&it1)) {
> +        int bs1_nb_sns = 0;
> +        ImageEntry *ie;
> +        SnapshotEntry *se;
> +        AioContext *ctx = bdrv_get_aio_context(bs1);
> +
> +        aio_context_acquire(ctx);
> +        if (bdrv_can_snapshot(bs1)) {
> +            sn = NULL;
> +            bs1_nb_sns = bdrv_snapshot_list(bs1, &sn);
> +            if (bs1_nb_sns > 0) {
> +                no_snapshot = false;
> +                ie = g_new0(ImageEntry, 1);
> +                ie->imagename = bdrv_get_device_name(bs1);
> +                QTAILQ_INIT(&ie->snapshots);
> +                QTAILQ_INSERT_TAIL(&image_list, ie, next);
> +                for (i = 0; i < bs1_nb_sns; i++) {
> +                    se = g_new0(SnapshotEntry, 1);
> +                    se->sn = sn[i];
> +                    QTAILQ_INSERT_TAIL(&ie->snapshots, se, next);
> +                }
> +            }
> +            g_free(sn);
> +        }
> +        aio_context_release(ctx);
> +    }
> +
> +    if (no_snapshot) {
> +        monitor_printf(mon, "There is no snapshot available.\n");
> +        return;
> +    }
> +
> +    global_snapshots = g_new0(int, nb_sns);
> +    total = 0;
> +    for (i = 0; i < nb_sns; i++) {
> +        SnapshotEntry *next_sn;
> +        if (bdrv_all_find_snapshot(sn_tab[i].name, &bs1) == 0) {
> +            global_snapshots[total] = i;
> +            total++;
> +            QTAILQ_FOREACH(image_entry, &image_list, next) {
> +                QTAILQ_FOREACH_SAFE(snapshot_entry, &image_entry->snapshots,
> +                                    next, next_sn) {
> +                    if (!strcmp(sn_tab[i].name, snapshot_entry->sn.name)) {
> +                        QTAILQ_REMOVE(&image_entry->snapshots, snapshot_entry,
> +                                      next);
> +                        g_free(snapshot_entry);
> +                    }
> +                }
> +            }
> +        }
> +    }
> +
> +    monitor_printf(mon, "List of snapshots present on all disks:\n");
> +
> +    if (total > 0) {
> +        bdrv_snapshot_dump((fprintf_function)monitor_printf, mon, NULL);
> +        monitor_printf(mon, "\n");
> +        for (i = 0; i < total; i++) {
> +            sn = &sn_tab[global_snapshots[i]];
> +            /* The ID is not guaranteed to be the same on all images, so
> +             * overwrite it.
> +             */
> +            pstrcpy(sn->id_str, sizeof(sn->id_str), "--");
> +            bdrv_snapshot_dump((fprintf_function)monitor_printf, mon, sn);
> +            monitor_printf(mon, "\n");
> +        }
> +    } else {
> +        monitor_printf(mon, "None\n");
> +    }
> +
> +    QTAILQ_FOREACH(image_entry, &image_list, next) {
> +        if (QTAILQ_EMPTY(&image_entry->snapshots)) {
> +            continue;
> +        }
> +        monitor_printf(mon,
> +                       "\nList of partial (non-loadable) snapshots on '%s':\n",
> +                       image_entry->imagename);
> +        bdrv_snapshot_dump((fprintf_function)monitor_printf, mon, NULL);
> +        monitor_printf(mon, "\n");
> +        QTAILQ_FOREACH(snapshot_entry, &image_entry->snapshots, next) {
> +            bdrv_snapshot_dump((fprintf_function)monitor_printf, mon,
> +                               &snapshot_entry->sn);
> +            monitor_printf(mon, "\n");
> +        }
> +    }
> +
> +    QTAILQ_FOREACH_SAFE(image_entry, &image_list, next, next_ie) {
> +        SnapshotEntry *next_sn;
> +        QTAILQ_FOREACH_SAFE(snapshot_entry, &image_entry->snapshots, next,
> +                            next_sn) {
> +            g_free(snapshot_entry);
> +        }
> +        g_free(image_entry);
> +    }
> +    g_free(sn_tab);
> +    g_free(global_snapshots);
> +
> +}
> +
>  void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
>  {
>      qmp_migrate_cancel(NULL);
> diff --git a/hmp.h b/hmp.h
> index 6a402b1..37bb65a 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -66,6 +66,7 @@ void hmp_drive_backup(Monitor *mon, const QDict *qdict);
>  void hmp_loadvm(Monitor *mon, const QDict *qdict);
>  void hmp_savevm(Monitor *mon, const QDict *qdict);
>  void hmp_delvm(Monitor *mon, const QDict *qdict);
> +void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
>  void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
>  void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
>  void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict);
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index e4f355ceb..15656b7 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -77,7 +77,6 @@ void qemu_remove_machine_init_done_notifier(Notifier *notify);
>  
>  int save_vmstate(const char *name);
>  int load_vmstate(const char *name);
> -void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
>  
>  void qemu_announce_self(void);
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index acd304b..8dd4306 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -33,15 +33,12 @@
>  #include "hw/qdev.h"
>  #include "hw/xen/xen.h"
>  #include "net/net.h"
> -#include "monitor/monitor.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/timer.h"
> -#include "audio/audio.h"
>  #include "migration/migration.h"
>  #include "migration/postcopy-ram.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/error-report.h"
> -#include "qemu/sockets.h"
>  #include "qemu/queue.h"
>  #include "sysemu/cpus.h"
>  #include "exec/memory.h"
> @@ -50,7 +47,6 @@
>  #include "qemu/bitops.h"
>  #include "qemu/iov.h"
>  #include "block/snapshot.h"
> -#include "block/qapi.h"
>  #include "qemu/cutils.h"
>  #include "io/channel-buffer.h"
>  #include "io/channel-file.h"
> @@ -2304,149 +2300,6 @@ int load_vmstate(const char *name)
>      return 0;
>  }
>  
> -void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
> -{
> -    BlockDriverState *bs, *bs1;
> -    BdrvNextIterator it1;
> -    QEMUSnapshotInfo *sn_tab, *sn;
> -    bool no_snapshot = true;
> -    int nb_sns, i;
> -    int total;
> -    int *global_snapshots;
> -    AioContext *aio_context;
> -
> -    typedef struct SnapshotEntry {
> -        QEMUSnapshotInfo sn;
> -        QTAILQ_ENTRY(SnapshotEntry) next;
> -    } SnapshotEntry;
> -
> -    typedef struct ImageEntry {
> -        const char *imagename;
> -        QTAILQ_ENTRY(ImageEntry) next;
> -        QTAILQ_HEAD(, SnapshotEntry) snapshots;
> -    } ImageEntry;
> -
> -    QTAILQ_HEAD(, ImageEntry) image_list =
> -        QTAILQ_HEAD_INITIALIZER(image_list);
> -
> -    ImageEntry *image_entry, *next_ie;
> -    SnapshotEntry *snapshot_entry;
> -
> -    bs = bdrv_all_find_vmstate_bs();
> -    if (!bs) {
> -        monitor_printf(mon, "No available block device supports snapshots\n");
> -        return;
> -    }
> -    aio_context = bdrv_get_aio_context(bs);
> -
> -    aio_context_acquire(aio_context);
> -    nb_sns = bdrv_snapshot_list(bs, &sn_tab);
> -    aio_context_release(aio_context);
> -
> -    if (nb_sns < 0) {
> -        monitor_printf(mon, "bdrv_snapshot_list: error %d\n", nb_sns);
> -        return;
> -    }
> -
> -    for (bs1 = bdrv_first(&it1); bs1; bs1 = bdrv_next(&it1)) {
> -        int bs1_nb_sns = 0;
> -        ImageEntry *ie;
> -        SnapshotEntry *se;
> -        AioContext *ctx = bdrv_get_aio_context(bs1);
> -
> -        aio_context_acquire(ctx);
> -        if (bdrv_can_snapshot(bs1)) {
> -            sn = NULL;
> -            bs1_nb_sns = bdrv_snapshot_list(bs1, &sn);
> -            if (bs1_nb_sns > 0) {
> -                no_snapshot = false;
> -                ie = g_new0(ImageEntry, 1);
> -                ie->imagename = bdrv_get_device_name(bs1);
> -                QTAILQ_INIT(&ie->snapshots);
> -                QTAILQ_INSERT_TAIL(&image_list, ie, next);
> -                for (i = 0; i < bs1_nb_sns; i++) {
> -                    se = g_new0(SnapshotEntry, 1);
> -                    se->sn = sn[i];
> -                    QTAILQ_INSERT_TAIL(&ie->snapshots, se, next);
> -                }
> -            }
> -            g_free(sn);
> -        }
> -        aio_context_release(ctx);
> -    }
> -
> -    if (no_snapshot) {
> -        monitor_printf(mon, "There is no snapshot available.\n");
> -        return;
> -    }
> -
> -    global_snapshots = g_new0(int, nb_sns);
> -    total = 0;
> -    for (i = 0; i < nb_sns; i++) {
> -        SnapshotEntry *next_sn;
> -        if (bdrv_all_find_snapshot(sn_tab[i].name, &bs1) == 0) {
> -            global_snapshots[total] = i;
> -            total++;
> -            QTAILQ_FOREACH(image_entry, &image_list, next) {
> -                QTAILQ_FOREACH_SAFE(snapshot_entry, &image_entry->snapshots,
> -                                    next, next_sn) {
> -                    if (!strcmp(sn_tab[i].name, snapshot_entry->sn.name)) {
> -                        QTAILQ_REMOVE(&image_entry->snapshots, snapshot_entry,
> -                                      next);
> -                        g_free(snapshot_entry);
> -                    }
> -                }
> -            }
> -        }
> -    }
> -
> -    monitor_printf(mon, "List of snapshots present on all disks:\n");
> -
> -    if (total > 0) {
> -        bdrv_snapshot_dump((fprintf_function)monitor_printf, mon, NULL);
> -        monitor_printf(mon, "\n");
> -        for (i = 0; i < total; i++) {
> -            sn = &sn_tab[global_snapshots[i]];
> -            /* The ID is not guaranteed to be the same on all images, so
> -             * overwrite it.
> -             */
> -            pstrcpy(sn->id_str, sizeof(sn->id_str), "--");
> -            bdrv_snapshot_dump((fprintf_function)monitor_printf, mon, sn);
> -            monitor_printf(mon, "\n");
> -        }
> -    } else {
> -        monitor_printf(mon, "None\n");
> -    }
> -
> -    QTAILQ_FOREACH(image_entry, &image_list, next) {
> -        if (QTAILQ_EMPTY(&image_entry->snapshots)) {
> -            continue;
> -        }
> -        monitor_printf(mon,
> -                       "\nList of partial (non-loadable) snapshots on '%s':\n",
> -                       image_entry->imagename);
> -        bdrv_snapshot_dump((fprintf_function)monitor_printf, mon, NULL);
> -        monitor_printf(mon, "\n");
> -        QTAILQ_FOREACH(snapshot_entry, &image_entry->snapshots, next) {
> -            bdrv_snapshot_dump((fprintf_function)monitor_printf, mon,
> -                               &snapshot_entry->sn);
> -            monitor_printf(mon, "\n");
> -        }
> -    }
> -
> -    QTAILQ_FOREACH_SAFE(image_entry, &image_list, next, next_ie) {
> -        SnapshotEntry *next_sn;
> -        QTAILQ_FOREACH_SAFE(snapshot_entry, &image_entry->snapshots, next,
> -                            next_sn) {
> -            g_free(snapshot_entry);
> -        }
> -        g_free(image_entry);
> -    }
> -    g_free(sn_tab);
> -    g_free(global_snapshots);
> -
> -}
> -
>  void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
>  {
>      qemu_ram_set_idstr(mr->ram_block,
> 
