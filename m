Received: from eggs.gnu.org ([2001:4830:134:3::10]:46895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dMy01-0004vg-BG
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dMxzx-00071y-Hz
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dMxzx-00071d-8t
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:49:49 -0400
Date: Mon, 19 Jun 2017 15:49:32 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170619144932.GI2640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170616160658.32290-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170616160658.32290-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Fix race of image locking
 between src and dst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com

On Sat, Jun 17, 2017 at 12:06:58AM +0800, Fam Zheng wrote:
> Previously, dst side will immediately try to lock the write byte upon
> receiving QEMU_VM_EOF, but at src side, bdrv_inactivate_all() is only
> done after sending it. If the src host is under load, dst may fail to
> acquire the lock due to racing with the src unlocking it.
> 
> Fix this by hoisting the bdrv_inactivate_all() operation before
> QEMU_VM_EOF.
> 
> N.B. A further improvement could possibly be done to cleanly handover
> locks between src and dst, so that there is no window where a third QEMU
> could steal the locks and prevent src and dst from running.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  migration/colo.c      |  2 +-
>  migration/migration.c | 19 +++++++------------
>  migration/savevm.c    | 19 +++++++++++++++----
>  migration/savevm.h    |  3 ++-
>  4 files changed, 25 insertions(+), 18 deletions(-)

[snip]

> @@ -1695,20 +1695,15 @@ static void migration_completion(MigrationState *s, int current_active_state,
>          ret = global_state_store();
>  
>          if (!ret) {
> +            bool inactivate = !migrate_colo_enabled();
>              ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
>              if (ret >= 0) {
>                  qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
> -                qemu_savevm_state_complete_precopy(s->to_dst_file, false);
> +                ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
> +                                                         inactivate);
>              }
> -            /*
> -             * Don't mark the image with BDRV_O_INACTIVE flag if
> -             * we will go into COLO stage later.
> -             */
> -            if (ret >= 0 && !migrate_colo_enabled()) {
> -                ret = bdrv_inactivate_all();
> -                if (ret >= 0) {
> -                    s->block_inactive = true;
> -                }
> +            if (inactivate && ret >= 0) {
> +                s->block_inactive = true;
>              }
>          }
>          qemu_mutex_unlock_iothread();

[snip]

> @@ -1173,6 +1174,15 @@ void qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
>          json_end_object(vmdesc);
>      }
>  
> +    if (inactivate_disks) {
> +        /* Inactivate before sending QEMU_VM_EOF so that the
> +         * bdrv_invalidate_cache_all() on the other end won't fail. */
> +        ret = bdrv_inactivate_all();
> +        if (ret) {
> +            qemu_file_set_error(f, ret);
> +            return ret;
> +        }
> +    }

IIUC as well as fixing the race condition, you're also improving
error reporting by using qemu_file_set_error() which was not done
previously. Would be nice to mention that in the commit message
too if you respin for any other reason, but that's just a nit-pick
so

  Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
