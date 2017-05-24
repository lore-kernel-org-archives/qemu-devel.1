Received: from eggs.gnu.org ([2001:4830:134:3::10]:51143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDUYz-00061h-9w
	for qemu-devel@nongnu.org; Wed, 24 May 2017 07:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDUYy-0007YQ-HU
	for qemu-devel@nongnu.org; Wed, 24 May 2017 07:34:49 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495548064-10926-3-git-send-email-kwolf@redhat.com> (Kevin
	Wolf's message of "Tue, 23 May 2017 16:01:02 +0200")
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
	<1495548064-10926-3-git-send-email-kwolf@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 24 May 2017 13:34:35 +0200
Message-ID: <87vaoq5vzo.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/4] migration: Inactivate images after
 .save_live_complete_precopy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Kevin Wolf <kwolf@redhat.com> wrote:
> Block migration may still access the image during its
> .save_live_complete_precopy() implementation, so we should only
> inactivate the image afterwards.
>
> Another reason for the change is that inactivating an image fails when
> there is still a non-device BlockBackend using it, which includes the
> BBs used by block migration. We want to give block migration a chance to
> release the BBs before trying to inactivate the image (this will be done
> in another patch).
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> ---
>  migration/migration.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 0304c01..846ba09 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1787,17 +1787,19 @@ static void migration_completion(MigrationState *s, int current_active_state,
>  
>          if (!ret) {
>              ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
> +            if (ret >= 0) {
> +                qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
> +                qemu_savevm_state_complete_precopy(s->to_dst_file, false);
> +            }
>              /*
>               * Don't mark the image with BDRV_O_INACTIVE flag if
>               * we will go into COLO stage later.
>               */
>              if (ret >= 0 && !migrate_colo_enabled()) {
>                  ret = bdrv_inactivate_all();
> -            }
> -            if (ret >= 0) {
> -                qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
> -                qemu_savevm_state_complete_precopy(s->to_dst_file, false);
> -                s->block_inactive = true;
> +                if (ret >= 0) {
> +                    s->block_inactive = true;
> +                }
>              }
>          }
>          qemu_mutex_unlock_iothread();
