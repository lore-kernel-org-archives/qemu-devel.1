Received: from eggs.gnu.org ([2001:4830:134:3::10]:45151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d30fE-0005Fr-7o
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d30fA-0008UT-8x
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:37:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1d30f9-0008Tt-Vg
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:37:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1DD4C049D5B
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 13:37:50 +0000 (UTC)
References: <20170425102446.4008-1-quintela@redhat.com>
	<20170425102446.4008-3-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <542eb223-986c-6727-d4fc-c0a15b001bd1@redhat.com>
Date: Tue, 25 Apr 2017 15:37:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170425102446.4008-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] monitor: Move hmp_loadvm from
 monitor.c to hmp.c
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
> We are going to move the rest of hmp snapshots functions there instead
> of monitor.c.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  hmp.c     | 13 +++++++++++++
>  hmp.h     |  1 +
>  monitor.c | 13 -------------
>  3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index ab407d6..f6b8738 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -19,6 +19,7 @@
>  #include "net/eth.h"
>  #include "sysemu/char.h"
>  #include "sysemu/block-backend.h"
> +#include "sysemu/sysemu.h"
>  #include "qemu/config-file.h"
>  #include "qemu/option.h"
>  #include "qemu/timer.h"
> @@ -1268,6 +1269,18 @@ void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>  }
>  
> +void hmp_loadvm(Monitor *mon, const QDict *qdict)
> +{
> +    int saved_vm_running  = runstate_is_running();
> +    const char *name = qdict_get_str(qdict, "name");
> +
> +    vm_stop(RUN_STATE_RESTORE_VM);
> +
> +    if (load_vmstate(name) == 0 && saved_vm_running) {
> +        vm_start();
> +    }
> +}
> +
>  void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
>  {
>      qmp_migrate_cancel(NULL);
> diff --git a/hmp.h b/hmp.h
> index 799fd37..385332c 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -63,6 +63,7 @@ void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict);
>  void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdict);
>  void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
>  void hmp_drive_backup(Monitor *mon, const QDict *qdict);
> +void hmp_loadvm(Monitor *mon, const QDict *qdict);
>  void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
>  void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
>  void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict);
> diff --git a/monitor.c b/monitor.c
> index be282ec..d02900d 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -37,7 +37,6 @@
>  #include "net/slirp.h"
>  #include "sysemu/char.h"
>  #include "ui/qemu-spice.h"
> -#include "sysemu/sysemu.h"
>  #include "sysemu/numa.h"
>  #include "monitor/monitor.h"
>  #include "qemu/config-file.h"
> @@ -1843,18 +1842,6 @@ void qmp_closefd(const char *fdname, Error **errp)
>      error_setg(errp, QERR_FD_NOT_FOUND, fdname);
>  }
>  
> -static void hmp_loadvm(Monitor *mon, const QDict *qdict)
> -{
> -    int saved_vm_running  = runstate_is_running();
> -    const char *name = qdict_get_str(qdict, "name");
> -
> -    vm_stop(RUN_STATE_RESTORE_VM);
> -
> -    if (load_vmstate(name) == 0 && saved_vm_running) {
> -        vm_start();
> -    }
> -}
> -
>  int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>  {
>      mon_fd_t *monfd;
> 
