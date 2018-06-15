Received: from eggs.gnu.org ([2001:4830:134:3::10]:56370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTnVJ-0005Ax-25
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTnVF-0005YL-Tj
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:06:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40238 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fTnVF-0005YF-Oa
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:06:53 -0400
Date: Fri, 15 Jun 2018 13:06:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180615120649.GC2615@work-vm>
References: <20180609141457.6283-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609141457.6283-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] migration: invalidate cache before source
 start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> Invalidate cache before source start in case of failed migration.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Why doesn't the code at the bottom of migration_completion,
fail_invalidate:   and the code in migrate_fd_cancel   handle this?

What case did you see it in that those didn't handle?
(Also I guess it probably should set s->block_inactive = false)

Dave

> ---
> 
>  migration/migration.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 1e99ec9b7e..8f39e0dc02 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2806,7 +2806,14 @@ static void migration_iteration_finish(MigrationState *s)
>      case MIGRATION_STATUS_FAILED:
>      case MIGRATION_STATUS_CANCELLED:
>          if (s->vm_was_running) {
> -            vm_start();
> +            Error *local_err = NULL;
> +            bdrv_invalidate_cache_all(&local_err);
> +            if (local_err) {
> +                error_reportf_err(local_err, "Can't invalidate disks before "
> +                                  "source vm start");
> +            } else {
> +                vm_start();
> +            }
>          } else {
>              if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
>                  runstate_set(RUN_STATE_POSTMIGRATE);
> -- 
> 2.11.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
