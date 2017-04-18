Received: from eggs.gnu.org ([2001:4830:134:3::10]:56038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d0XSx-0004jW-T0
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d0XSs-0005Cz-R2
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:03:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d0XSs-0005Cc-IV
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:02:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D0E685376
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 18:02:57 +0000 (UTC)
Date: Tue, 18 Apr 2017 19:02:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170418180253.GN2205@work-vm>
References: <20170417200041.2451-1-quintela@redhat.com>
	<20170417200041.2451-20-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417200041.2451-20-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 19/19] monitor: remove monitor parameter
 from save_vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> load_vmstate() already use error_report, so be consistent.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

See https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg03927.html

Dave

> ---
>  include/sysemu/sysemu.h  |  2 +-
>  migration/savevm.c       | 16 ++++++++--------
>  monitor.c                |  2 +-
>  replay/replay-snapshot.c |  2 +-
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 146a0dc..d2582fa 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -75,7 +75,7 @@ void qemu_remove_exit_notifier(Notifier *notify);
>  void qemu_add_machine_init_done_notifier(Notifier *notify);
>  void qemu_remove_machine_init_done_notifier(Notifier *notify);
>  
> -int save_vmstate(Monitor *mon, const char *name);
> +int save_vmstate(const char *name);
>  int load_vmstate(const char *name);
>  void hmp_delvm(Monitor *mon, const QDict *qdict);
>  void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index cbd7e0d..36a6002 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2055,7 +2055,7 @@ int qemu_loadvm_state(QEMUFile *f)
>      return ret;
>  }
>  
> -int save_vmstate(Monitor *mon, const char *name)
> +int save_vmstate(const char *name)
>  {
>      BlockDriverState *bs, *bs1;
>      QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
> @@ -2069,8 +2069,8 @@ int save_vmstate(Monitor *mon, const char *name)
>      AioContext *aio_context;
>  
>      if (!bdrv_all_can_snapshot(&bs)) {
> -        monitor_printf(mon, "Device '%s' is writable but does not "
> -                       "support snapshots.\n", bdrv_get_device_name(bs));
> +        error_report("Device '%s' is writable but does not support snapshots.",
> +                     bdrv_get_device_name(bs));
>          return ret;
>      }
>  
> @@ -2087,7 +2087,7 @@ int save_vmstate(Monitor *mon, const char *name)
>  
>      bs = bdrv_all_find_vmstate_bs();
>      if (bs == NULL) {
> -        monitor_printf(mon, "No block device can accept snapshots\n");
> +        error_report("No block device can accept snapshots");
>          return ret;
>      }
>      aio_context = bdrv_get_aio_context(bs);
> @@ -2096,7 +2096,7 @@ int save_vmstate(Monitor *mon, const char *name)
>  
>      ret = global_state_store();
>      if (ret) {
> -        monitor_printf(mon, "Error saving global state\n");
> +        error_report("Error saving global state");
>          return ret;
>      }
>      vm_stop(RUN_STATE_SAVE_VM);
> @@ -2128,7 +2128,7 @@ int save_vmstate(Monitor *mon, const char *name)
>      /* save the VM state */
>      f = qemu_fopen_bdrv(bs, 1);
>      if (!f) {
> -        monitor_printf(mon, "Could not open VM state file\n");
> +        error_report("Could not open VM state file");
>          goto the_end;
>      }
>      ret = qemu_savevm_state(f, &local_err);
> @@ -2141,8 +2141,8 @@ int save_vmstate(Monitor *mon, const char *name)
>  
>      ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, &bs);
>      if (ret < 0) {
> -        monitor_printf(mon, "Error while creating snapshot on '%s'\n",
> -                       bdrv_get_device_name(bs));
> +        error_report("Error while creating snapshot on '%s'",
> +                     bdrv_get_device_name(bs));
>          goto the_end;
>      }
>  
> diff --git a/monitor.c b/monitor.c
> index 2fca4fb..9e79a97 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1856,7 +1856,7 @@ static void hmp_loadvm(Monitor *mon, const QDict *qdict)
>  
>  static void hmp_savevm(Monitor *mon, const QDict *qdict)
>  {
> -    save_vmstate(mon, qdict_get_try_str(qdict, "name"));
> +    save_vmstate(qdict_get_try_str(qdict, "name"));
>  }
>  
>  int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
> diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
> index 65e2d37..8cced46 100644
> --- a/replay/replay-snapshot.c
> +++ b/replay/replay-snapshot.c
> @@ -64,7 +64,7 @@ void replay_vmstate_init(void)
>  {
>      if (replay_snapshot) {
>          if (replay_mode == REPLAY_MODE_RECORD) {
> -            if (save_vmstate(cur_mon, replay_snapshot) != 0) {
> +            if (save_vmstate(replay_snapshot) != 0) {
>                  error_report("Could not create snapshot for icount record");
>                  exit(1);
>              }
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
