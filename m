Received: from eggs.gnu.org ([2001:4830:134:3::10]:48352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eRFc4-0005qO-2J
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eRFc1-0001cq-0Z
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:59:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eRFc0-0001bK-OG
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:59:04 -0500
Date: Tue, 19 Dec 2017 10:58:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171219105859.GC2730@work-vm>
References: <20171205065307.21853-1-peterx@redhat.com>
	<20171205065307.21853-27-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205065307.21853-27-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 26/28] migration: allow migrate_cancel
 to pause postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>

* Peter Xu (peterx@redhat.com) wrote:
> It was allowed in the past to even cancel a postcopy migration, but it
> does not really make sense, and no one should be using it, since
> cancelling a migration during postcopy means crashing the VM at no time.
> 
> Let's just use re-use this command as a way to pause the postcopy
> migration when we detected that we are in postcopy migration.  This can
> be used when we want to trigger the postcopy recovery manually.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Yes, OK, this is a little odd without having any flags or anything, but
it's essentially the saem reason that cancel exists - to stop a
migration we know that's broken for some reason.

(I could argue whether this should be special cased in migrate_fd_cancel
instead, but that's just a preference).


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  hmp-commands.hx       |  8 ++++++--
>  migration/migration.c | 18 +++++++++++++++++-
>  qapi/migration.json   |  3 ++-
>  3 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index ffcdc34652..32fdd52212 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -952,14 +952,18 @@ ETEXI
>          .name       = "migrate_cancel",
>          .args_type  = "",
>          .params     = "",
> -        .help       = "cancel the current VM migration",
> +        .help       = "cancel the current VM precopy migration, or "
> +                      "pause the migration if it's in postcopy state, "
> +                      "so that a postcopy recovery can be carried out later.",
>          .cmd        = hmp_migrate_cancel,
>      },
>  
>  STEXI
>  @item migrate_cancel
>  @findex migrate_cancel
> -Cancel the current VM migration.
> +If during a precopy, this command cancels the migration.  If during
> +postcopy, this command pauses the migration (so that a postcopy
> +recovery can be carried out afterward).
>  ETEXI
>  
>      {
> diff --git a/migration/migration.c b/migration/migration.c
> index 8762fad9be..0c1a783df2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1535,7 +1535,23 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>  
>  void qmp_migrate_cancel(Error **errp)
>  {
> -    migrate_fd_cancel(migrate_get_current());
> +    MigrationState *ms = migrate_get_current();
> +    int ret;
> +
> +    if (ms->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +        /*
> +         * Cancelling a postcopy migration does not really make sense.
> +         * Here instead we pause the migration only, so another
> +         * recovery can take place if needed.
> +         */
> +        ret = qemu_file_shutdown(ms->to_dst_file);
> +        if (ret) {
> +            error_setg(errp, "Failed to pause migration stream.");
> +        }
> +        return;
> +    }
> +
> +    migrate_fd_cancel(ms);
>  }
>  
>  void qmp_migrate_continue(MigrationStatus state, Error **errp)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5dfac0681d..e15bb516cd 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -881,7 +881,8 @@
>  ##
>  # @migrate_cancel:
>  #
> -# Cancel the current executing migration process.
> +# Cancel the current executing migration process for precopy.  For
> +# postcopy, it'll pause the migration instead.
>  #
>  # Returns: nothing on success
>  #
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
