Received: from eggs.gnu.org ([2001:4830:134:3::10]:35227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dwaOx-0003Lt-Vr
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dwaOw-00042D-W3
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dwaOw-00041r-NB
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8PKsd3u131323
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:54:43 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d74g7770s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:54:42 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 25 Sep 2017 16:54:41 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <1505997152-16980-1-git-send-email-pl@kamp.de>
References: <1505997152-16980-1-git-send-email-pl@kamp.de>
Date: Mon, 25 Sep 2017 15:53:29 -0500
Message-Id: <150637280903.26688.16951846700405077637@sif>
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH] migration: disable
 auto-converge during bulk block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, qemu-stable@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com

Quoting Peter Lieven (2017-09-21 07:32:32)
> auto-converge and block migration currently do not play well together.
> During block migration the auto-converge logic detects that ram
> migration makes no progress and thus throttles down the vm until
> it nearly stalls completely. Avoid this by disabling the throttling
> logic during the bulk phase of the block migration.
> =

> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>

FYI: this patch has been tagged for stable 2.10.1, but is not yet
upstream. Patch freeze for 2.10.1 is September 27th.

> ---
>  migration/block.c | 5 +++++
>  migration/block.h | 7 +++++++
>  migration/ram.c   | 3 ++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
> =

> diff --git a/migration/block.c b/migration/block.c
> index 9171f60..606ad4d 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -161,6 +161,11 @@ int blk_mig_active(void)
>      return !QSIMPLEQ_EMPTY(&block_mig_state.bmds_list);
>  }
> =

> +int blk_mig_bulk_active(void)
> +{
> +    return blk_mig_active() && !block_mig_state.bulk_completed;
> +}
> +
>  uint64_t blk_mig_bytes_transferred(void)
>  {
>      BlkMigDevState *bmds;
> diff --git a/migration/block.h b/migration/block.h
> index 22ebe94..3178609 100644
> --- a/migration/block.h
> +++ b/migration/block.h
> @@ -16,6 +16,7 @@
> =

>  #ifdef CONFIG_LIVE_BLOCK_MIGRATION
>  int blk_mig_active(void);
> +int blk_mig_bulk_active(void);
>  uint64_t blk_mig_bytes_transferred(void);
>  uint64_t blk_mig_bytes_remaining(void);
>  uint64_t blk_mig_bytes_total(void);
> @@ -25,6 +26,12 @@ static inline int blk_mig_active(void)
>  {
>      return false;
>  }
> +
> +static inline int blk_mig_bulk_active(void)
> +{
> +    return false;
> +}
> +
>  static inline uint64_t blk_mig_bytes_transferred(void)
>  {
>      return 0;
> diff --git a/migration/ram.c b/migration/ram.c
> index e18b3e2..720470e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -46,6 +46,7 @@
>  #include "exec/ram_addr.h"
>  #include "qemu/rcu_queue.h"
>  #include "migration/colo.h"
> +#include "migration/block.h"
> =

>  /***********************************************************/
>  /* ram save/restore */
> @@ -623,7 +624,7 @@ static void migration_bitmap_sync(RAMState *rs)
>              / (end_time - rs->time_last_bitmap_sync);
>          bytes_xfer_now =3D ram_counters.transferred;
> =

> -        if (migrate_auto_converge()) {
> +        if (migrate_auto_converge() && !blk_mig_bulk_active()) {
>              /* The following detection logic can be refined later. For n=
ow:
>                 Check to see if the dirtied bytes is 50% more than the ap=
prox.
>                 amount of bytes that just got transferred since the last =
time we
> -- =

> 1.9.1
> =

>=20
