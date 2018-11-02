Received: from eggs.gnu.org ([2001:4830:134:3::10]:34688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gIPRz-0007Ul-Hg
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 22:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gIPLK-0007fs-6l
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 22:37:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gIPLI-0007f0-Ci
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 22:37:49 -0400
Date: Fri, 2 Nov 2018 10:37:38 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181102023738.GD7804@xz-x1>
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-6-fli@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181101101715.9443-6-fli@suse.com>
Subject: Re: [Qemu-devel] [PATCH RFC v7 5/9] migration: fix the multifd code
 when sending less channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, famz@redhat.com, quintela@redhat.com

On Thu, Nov 01, 2018 at 06:17:11PM +0800, Fei Li wrote:
> Set the migration state to "failed" instead of "setup" when failing
> to send packet via some channel.

Could you please provide more information in the commit message?
E.g., what will happen if without this patch?  Will it crash the
source or stall the source migration or others?  Otherwise it's a bit
hard for me to understand what's this patch for.

Normally I would prefer to not touch global states in feature specific
code path, but I'd like to know the problem more first...

Thanks,

> 
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>  migration/ram.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 4db3b3e8f4..c84d164fc8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1072,6 +1072,7 @@ out:
>  static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>  {
>      MultiFDSendParams *p = opaque;
> +    MigrationState *s = migrate_get_current();
>      QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
>      Error *local_err = NULL;
>  
> @@ -1083,6 +1084,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>          if (multifd_save_cleanup(&local_err) != 0) {
>              migrate_set_error(migrate_get_current(), local_err);
>          }
> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>      } else {
>          p->c = QIO_CHANNEL(sioc);
>          qio_channel_set_delay(p->c, false);
> -- 
> 2.13.7
> 

Regards,

-- 
Peter Xu
