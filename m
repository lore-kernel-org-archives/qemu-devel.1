Received: from eggs.gnu.org ([2001:4830:134:3::10]:59810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cVer0-0003Ne-Qo
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 08:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cVeqz-0001vC-KP
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 08:40:14 -0500
Date: Mon, 23 Jan 2017 13:40:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170123134002.GB14858@work-vm>
References: <1484836667-26460-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484836667-26460-1-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] migration: re-active images while
 migration been canceled after inactive them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, quintela@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, xuquan8@huawei.com

* zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
> commit fe904ea8242cbae2d7e69c052c754b8f5f1ba1d6 fixed a case
> which migration aborted QEMU because it didn't regain the control
> of images while some errors happened.
> 
> Actually, there are another two cases can trigger the same error reports:
> " bdrv_co_do_pwritev: Assertion `!(bs->open_flags & 0x0800)' failed",
> 
> Case 1, codes path:
> migration_thread()
>     migration_completion()
>         bdrv_inactivate_all() ----------------> inactivate images
>         qemu_savevm_state_complete_precopy()
>             socket_writev_buffer() --------> error because destination fails
>                 qemu_fflush() -------------------> set error on migration stream
> -> qmp_migrate_cancel() ---------------------> user cancelled migration concurrently
>     -> migrate_set_state() ------------------> set migrate CANCELLIN
>     migration_completion() -----------------> go on to fail_invalidate
> 	if (s->state == MIGRATION_STATUS_ACTIVE) -> Jump this branch
> 
> Case 2, codes path:
> migration_thread()
>     migration_completion()
>         bdrv_inactivate_all() ----------------> inactivate images
>     migreation_completion() finished
> -> qmp_migrate_cancel() ---------------------> user cancelled migration concurrently
>     qemu_mutex_lock_iothread();
>     qemu_bh_schedule (s->cleanup_bh);
> 
> As we can see from above, qmp_migrate_cancel can slip in whenever
> migration_thread does not hold the global lock. If this happens after
> bdrv_inactive_all() been called, the above error reports will appear.
> 
> To prevent this, we can call bdrv_invalidate_cache_all() in qmp_migrate_cancel()
> directly if we find images become inactive.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
> Hi,
> 
> I have sent another patch before to fix this problem, but didn't cover
> all the scenes, and there are some discussions about this problem,
> For more detail, please refer to
> https://lists.gnu.org/archive/html/qemu-block/2016-12/msg00003.html
> ---
>  include/migration/migration.h |  3 +++
>  migration/migration.c         | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index c309d23..2d5b724 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -177,6 +177,9 @@ struct MigrationState
>      /* Flag set once the migration thread is running (and needs joining) */
>      bool migration_thread_running;
>  
> +    /* Flag set once the migration thread called bdrv_inactivate_all */
> +    bool block_inactive;
> +
>      /* Queue of outstanding page requests from the destination */
>      QemuMutex src_page_req_mutex;
>      QSIMPLEQ_HEAD(src_page_requests, MigrationSrcPageRequest) src_page_requests;
> diff --git a/migration/migration.c b/migration/migration.c
> index f498ab8..9defb3e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1006,6 +1006,16 @@ static void migrate_fd_cancel(MigrationState *s)
>      if (s->state == MIGRATION_STATUS_CANCELLING && f) {
>          qemu_file_shutdown(f);
>      }
> +    if (s->state == MIGRATION_STATUS_CANCELLING && s->block_inactive) {
> +        Error *local_err = NULL;
> +
> +        bdrv_invalidate_cache_all(&local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        } else {
> +            s->block_inactive = false;
> +        }
> +    }
>  }
>  
>  void add_migration_state_change_notifier(Notifier *notify)
> @@ -1705,6 +1715,7 @@ static void migration_completion(MigrationState *s, int current_active_state,
>              if (ret >= 0) {
>                  qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
>                  qemu_savevm_state_complete_precopy(s->to_dst_file, false);
> +                s->block_inactive = true;
>              }
>          }
>          qemu_mutex_unlock_iothread();
> @@ -1758,6 +1769,8 @@ fail_invalidate:
>          bdrv_invalidate_cache_all(&local_err);
>          if (local_err) {
>              error_report_err(local_err);
> +        } else {
> +            s->block_inactive = false;
>          }

I think the fe904 commit also add the problem that this bdrv_invalidate_cache_all
is done outside the big lock (Stefan and Kevin tell me bdrv_* calls generally
need the lock).

Dave

>      }
>  
> -- 
> 1.8.3.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
