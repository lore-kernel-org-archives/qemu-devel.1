Received: from eggs.gnu.org ([2001:4830:134:3::10]:57697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dL1xc-0004J4-Lz
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dL1xZ-0003vW-Hb
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:39:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dL1xZ-0003vM-8U
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:39:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2211485A07
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 06:39:20 +0000 (UTC)
Date: Wed, 14 Jun 2017 14:39:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170614063914.GI11751@pxdev.xzpeter.org>
References: <20170613095251.11493-1-quintela@redhat.com>
	<20170613095251.11493-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170613095251.11493-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] migration: Remove unneeded includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Tue, Jun 13, 2017 at 11:52:51AM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/colo.h  | 3 ---
>  include/migration/misc.h  | 2 ++
>  migration/block.c         | 6 ------
>  migration/colo-failover.c | 2 ++
>  migration/colo.c          | 2 --
>  migration/exec.c          | 2 --
>  migration/fd.c            | 2 --
>  migration/global_state.c  | 1 -
>  migration/migration.c     | 6 ------
>  migration/migration.h     | 2 --
>  migration/postcopy-ram.c  | 4 +---
>  migration/qemu-file.c     | 2 --
>  migration/ram.c           | 4 ----
>  migration/savevm.c        | 6 ------
>  14 files changed, 5 insertions(+), 39 deletions(-)
> 
> diff --git a/include/migration/colo.h b/include/migration/colo.h
> index ba0bb6e..be6beba 100644
> --- a/include/migration/colo.h
> +++ b/include/migration/colo.h
> @@ -14,9 +14,6 @@
>  #define QEMU_COLO_H
>  
>  #include "qemu-common.h"
> -#include "qemu/coroutine_int.h"
> -#include "qemu/thread.h"
> -#include "qemu/main-loop.h"
>  
>  bool colo_supported(void);
>  void colo_info_init(void);
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index d5a433a..65c7070 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -14,6 +14,8 @@
>  #ifndef MIGRATION_MISC_H
>  #define MIGRATION_MISC_H
>  
> +#include "qemu/notify.h"
> +

Since we added this new line (I believe it's for Notifier), do we need
to include "qemu/typedefs.h" as well? Since I see Error and
MigrationState is used as well.

>  /* migration/ram.c */
>  
>  void ram_mig_init(void);
> diff --git a/migration/block.c b/migration/block.c
> index ae06975..3aae5a3 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -15,19 +15,13 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "qemu-common.h"
> -#include "block/block.h"
>  #include "qemu/error-report.h"
> -#include "qemu/main-loop.h"
> -#include "hw/hw.h"
>  #include "qemu/cutils.h"
>  #include "qemu/queue.h"
> -#include "qemu/timer.h"
>  #include "block.h"
>  #include "migration/misc.h"
>  #include "migration.h"
>  #include "migration/register.h"
> -#include "sysemu/blockdev.h"
>  #include "qemu-file.h"
>  #include "migration/vmstate.h"
>  #include "sysemu/block-backend.h"
> diff --git a/migration/colo-failover.c b/migration/colo-failover.c
> index cc229f5..f991486 100644
> --- a/migration/colo-failover.c
> +++ b/migration/colo-failover.c
> @@ -13,6 +13,8 @@
>  #include "qemu/osdep.h"
>  #include "migration/colo.h"
>  #include "migration/failover.h"
> +#include "qemu/main-loop.h"
> +#include "migration.h"
>  #include "qmp-commands.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/error-report.h"
> diff --git a/migration/colo.c b/migration/colo.c
> index 45e9b46..c436d63 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -11,7 +11,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu/timer.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu-file-channel.h"
>  #include "migration.h"
> @@ -22,7 +21,6 @@
>  #include "io/channel-buffer.h"
>  #include "trace.h"
>  #include "qemu/error-report.h"
> -#include "qapi/error.h"
>  #include "migration/failover.h"
>  #include "replication.h"
>  #include "qmp-commands.h"
> diff --git a/migration/exec.c b/migration/exec.c
> index b1de445..08b599e 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -19,10 +19,8 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "qemu-common.h"
>  #include "channel.h"
>  #include "exec.h"
> -#include "migration.h"
>  #include "io/channel-command.h"
>  #include "trace.h"
>  
> diff --git a/migration/fd.c b/migration/fd.c
> index b2384bf..30f5258 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -16,10 +16,8 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "qemu-common.h"
>  #include "channel.h"
>  #include "fd.h"
> -#include "migration.h"
>  #include "monitor/monitor.h"
>  #include "io/channel-util.h"
>  #include "trace.h"
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 16ac63f..f792cf5 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -17,7 +17,6 @@
>  #include "qapi/util.h"
>  #include "migration/global_state.h"
>  #include "migration/vmstate.h"
> -#include "sysemu/sysemu.h"
>  #include "trace.h"
>  
>  typedef struct {
> diff --git a/migration/migration.c b/migration/migration.c
> index 8ef6d6c..52dac9d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -16,7 +16,6 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
> -#include "qemu/main-loop.h"
>  #include "migration/blocker.h"
>  #include "exec.h"
>  #include "fd.h"
> @@ -30,11 +29,9 @@
>  #include "qemu-file-channel.h"
>  #include "qemu-file.h"
>  #include "migration/vmstate.h"
> -#include "sysemu/sysemu.h"
>  #include "block/block.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qapi/util.h"
> -#include "qemu/sockets.h"
>  #include "qemu/rcu.h"
>  #include "block.h"
>  #include "postcopy-ram.h"
> @@ -42,9 +39,6 @@
>  #include "qmp-commands.h"
>  #include "trace.h"
>  #include "qapi-event.h"
> -#include "qom/cpu.h"
> -#include "exec/memory.h"
> -#include "exec/address-spaces.h"
>  #include "exec/target_page.h"
>  #include "io/channel-buffer.h"
>  #include "migration/colo.h"
> diff --git a/migration/migration.h b/migration/migration.h
> index 601e4ab..d9a268a 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -14,10 +14,8 @@
>  #ifndef QEMU_MIGRATION_H
>  #define QEMU_MIGRATION_H
>  
> -#include "qapi/qmp/qdict.h"
>  #include "qemu-common.h"
>  #include "qemu/thread.h"
> -#include "qemu/notify.h"
>  #include "qapi-types.h"
>  #include "exec/cpu-common.h"
>  #include "qemu/coroutine_int.h"
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index c8c4500..922702b 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -17,14 +17,12 @@
>   */
>  
>  #include "qemu/osdep.h"
> -
> -#include "qemu-common.h"
>  #include "exec/target_page.h"
>  #include "migration.h"
>  #include "qemu-file.h"
> -#include "savevm.h"
>  #include "postcopy-ram.h"
>  #include "ram.h"
> +#include "savevm.h"

Just curious about whether there's any specific reason to move this
line from above to here?

Besides the nits:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
