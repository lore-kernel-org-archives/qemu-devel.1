Received: from eggs.gnu.org ([2001:4830:134:3::10]:37398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEG0f-0000mq-JT
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 08:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEG0e-0004TF-Hc
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 08:42:17 -0500
Date: Tue, 6 Dec 2016 14:42:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161206134211.GD4990@noname.str.redhat.com>
References: <1479555831-30960-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479555831-30960-1-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] migration: re-active images when migration
 fails to complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: quintela@redhat.com, amit.shah@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 19.11.2016 um 12:43 hat zhanghailiang geschrieben:
> commit fe904ea8242cbae2d7e69c052c754b8f5f1ba1d6 fixed a case
> which migration aborted QEMU because it didn't regain the control
> of images while some errors happened.
> 
> Actually, we have another case in that error path to abort QEMU
> because of the same reason:
>     migration_thread()
>         migration_completion()
>            bdrv_inactivate_all() ----------------> inactivate images
>            qemu_savevm_state_complete_precopy()
>                socket_writev_buffer() --------> error because destination fails
>              qemu_fflush() -------------------> set error on migration stream
>            qemu_mutex_unlock_iothread() ------> unlock
>     qmp_migrate_cancel() ---------------------> user cancelled migration
>         migrate_set_state() ------------------> set migrate CANCELLING

Important to note here: qmp_migrate_cancel() is executed by a concurrent
thread, it doesn't depend on any code paths in migration_completion().

>     migration_completion() -----------------> go on to fail_invalidate
>         if (s->state == MIGRATION_STATUS_ACTIVE) -> Jump this branch
>     migration_thread() -----------------------> break migration loop
>       vm_start() -----------------------------> restart guest with inactive
>                                                 images
> We failed to regain the control of images because we only regain it
> while the migration state is "active", but here users cancelled the migration
> when they found some errors happened (for example, libvirtd daemon is shutdown
> in destination unexpectedly).
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>  migration/migration.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index f498ab8..0c1ee6d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1752,7 +1752,8 @@ fail_invalidate:
>      /* If not doing postcopy, vm_start() will be called: let's regain
>       * control on images.
>       */
> -    if (s->state == MIGRATION_STATUS_ACTIVE) {

This if condition tries to check whether we ran the code path that
called bdrv_inactivate_all(), so that we only try to reactivate images
it if we really inactivated them first.

The problem with it is that it ignores a possible concurrent
modification of s->state.

> +    if (s->state == MIGRATION_STATUS_ACTIVE ||
> +        s->state == MIGRATION_STATUS_CANCELLING) {

This adds another state that we could end up with with a concurrent
modification, so that even in this case we undo the inactivation.

However, it is no longer limited to the cases where we inactivated the
image. It also applies to other code paths (like the postcopy one) where
we didn't inactivate images.

What saves the patch is that bdrv_invalidate_cache() is a no-op for
block devices that aren't inactivated, so calling it more often than
necessary is okay.

But then, if we're going to rely on this, it would be much better to
just remove the if altogether. I can't say whether there are any other
possible values of s->state that we should consider, and by removing the
if we would be guaranteed to catch all of them.

If we don't want to rely on it, just keep a local bool that remembers
whether we inactivated images and check that here.

>          Error *local_err = NULL;
>  
>          bdrv_invalidate_cache_all(&local_err);

So in summary, this is a horrible patch because it checks the wrong
thing, and for I can't really say if it covers everything it needs to
cover, but arguably it happens to correctly fix the outcome of a
previously failing case.

Normally I would reject such a patch and require a clean solution, but
then we're on the day of -rc3, so if you can't send v2 right away, we
might not have the time for it.

Tough call...

Kevin
