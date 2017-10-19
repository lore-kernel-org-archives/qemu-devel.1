Received: from eggs.gnu.org ([2001:4830:134:3::10]:40376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e534C-00015o-FF
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 01:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e5344-0001ww-Pi
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 01:08:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e5344-0001vV-HC
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 01:08:16 -0400
Date: Thu, 19 Oct 2017 13:08:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171019050809.GW4166@pxdev.xzpeter.org>
References: <20171018174013.22709-1-dgilbert@redhat.com>
	<20171018174013.22709-8-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171018174013.22709-8-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 7/7] migration: pause-before-switchover
 for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com, wangjie88@huawei.com, quintela@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

On Wed, Oct 18, 2017 at 06:40:13PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Add pause-before-switchover support for postcopy.
> After starting postcopy it will transition
>     active->pre-switchover->postcopy_active
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/migration.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 756deb3e2c..af587377e9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -104,6 +104,9 @@ enum mig_rp_message_type {
>  static MigrationState *current_migration;
>  
>  static bool migration_object_check(MigrationState *ms, Error **errp);
> +static int migration_maybe_pause(MigrationState *s,
> +                                 int *current_active_state,
> +                                 int new_state);
>  
>  void migration_object_init(void)
>  {
> @@ -1830,8 +1833,11 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
>      QEMUFile *fb;
>      int64_t time_at_stop = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      bool restart_block = false;
> -    migrate_set_state(&ms->state, MIGRATION_STATUS_ACTIVE,
> -                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
> +    int cur_state = MIGRATION_STATUS_ACTIVE;
> +    if (!migrate_pause_before_switchover()) {
> +        migrate_set_state(&ms->state, MIGRATION_STATUS_ACTIVE,
> +                          MIGRATION_STATUS_POSTCOPY_ACTIVE);

(Note: so we are sending device data during
 MIGRATION_STATUS_POSTCOPY_ACTIVE state if "pause-before-switchover"
 is not set, and MIGRATION_STATUS_DEVICE state if that is set)

> +    }
>  
>      trace_postcopy_start();
>      qemu_mutex_lock_iothread();
> @@ -1845,6 +1851,12 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
>          goto fail;
>      }
>  
> +    ret = migration_maybe_pause(ms, &cur_state,
> +                                MIGRATION_STATUS_POSTCOPY_ACTIVE);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +

I think it works, so:

Reviewed-by: Peter Xu <peterx@redhat.com>

About the unification of state change I mentioned in cover letter,
what I proposed would look like this for postcopy (I would avoid
fiddling with cur_state and related, and for precopy it should be
similar):

migration_pre_switchover (ms)
{
  migrate_set_state(ms, MIGRATION_STATUS_PRE_SWITCHOVER);
  qemu_mutex_unlock_iothread();
  qemu_sem_wait();
  qemu_mutex_lock_iothread();
}

postcopy_start ()
{
  ...

  /* Whether we need extra pre-switchover state transition */
  if (migrate_pause_before_switchover ()) {
    migration_pre_switchover (ms);
  }

  /*
   * To "switchover" state to send device states, etc., no matter
   * whether "pause-before-switchover" is enabled
   */
  migration_set_state (ms, MIGRATION_STATUS_SWITCHOVER);

  /* send device states and the rest postcopy work... */

  migration_set_state (ms, MIGRATION_STATUS_POSTCOPY_ACTIVE)
}

I proposed this only for readability and cleaness of state transition.
At least then we'll know that we are always sending the device data
during SWITCHOVER state (or say, DEVICE state). Again, either way is
fine to me.  Thanks,

-- 
Peter Xu
