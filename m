Received: from eggs.gnu.org ([2001:4830:134:3::10]:49946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWezB-00076p-5D
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWez5-0005nk-2N
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:05:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWez4-0005nA-MF
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:05:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB266C074EEB
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 09:05:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180103054043.25719-6-peterx@redhat.com> (Peter Xu's message of
	"Wed, 3 Jan 2018 13:40:37 +0800")
References: <20180103054043.25719-1-peterx@redhat.com>
	<20180103054043.25719-6-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 10:05:07 +0100
Message-ID: <87shbn2tz0.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 05/11] migration: move vm_old_running into
 global state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Firstly, it was passed around.  Let's just move it into MigrationState
> just like many other variables as state of migration.
>
> One thing to mention is that for postcopy, we actually don't need this
> knowledge at all since postcopy can't resume a VM even if it fails (we
> can see that from the old code too: when we try to resume we also check
> against "entered_postcopy" variable).  So further we do this:
>
> - in postcopy_start(), we don't update vm_old_running since useless
> - in migration_thread(), we don't need to check entered_postcopy when
>   resume, since it's only used for precopy.
>
> Comment this out too for that variable definition.

Reviewed-by: Juan Quintela <quintela@redhat.com>

But I wonder if we can came with a better name.  Best one that I can
think is
   vm_was_running

Any other name that I came is bad for precopy or colo.

i.e. restart_vm_on_cancel_error

is meaningful for precopy, but not for colo.

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 17 +++++++----------
>  migration/migration.h |  6 ++++++
>  2 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/migration/migration.h b/migration/migration.h
> index ac74a12713..0f5df2367c 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -111,6 +111,12 @@ struct MigrationState
>      int64_t expected_downtime;
>      bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
>      int64_t setup_time;
> +    /*
> +     * Whether the old VM is running for the last migration.  This is
> +     * used to resume the VM when precopy failed or cancelled somehow.
> +     * It's never used for postcopy.
> +     */
> +    bool old_vm_running;

I think this comment is right for precopy, but not for colo.  BTW, I
think that I would put the postcopy comment on its use, not here.

/me tries to improve the comment

  Guest was running when we enter the completion stage.  If migration don't
  sucess, we need to continue running guest on source.

What do you think?

Later, Juan.


>  
>      /* Flag set once the migration has been asked to enter postcopy */
>      bool start_postcopy;
