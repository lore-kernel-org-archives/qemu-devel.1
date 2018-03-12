Received: from eggs.gnu.org ([2001:4830:134:3::10]:57112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evRMs-0004P7-Hm
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evRMr-0008NP-Gh
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:36:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60170 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evRMr-0008My-7N
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:36:13 -0400
Date: Mon, 12 Mar 2018 17:36:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180312173609.GV3219@work-vm>
References: <20180309091535.13315-1-peterx@redhat.com>
	<20180309091535.13315-23-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309091535.13315-23-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 22/23] migration/qmp: add command
 migrate-pause
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
> It pauses an ongoing migration.  Currently it only supports postcopy.
> Note that this command will work on either side of the migration.
> Basically when we trigger this on one side, it'll interrupt the other
> side as well since the other side will get notified on the disconnect
> event.
> 
> However, it's still possible that the other side is not notified, for
> example, when the network is totally broken, or due to some firewall
> configuration changes.  In that case, we will also need to run the same
> command on the other side so both sides will go into the paused state.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 27 +++++++++++++++++++++++++++
>  qapi/migration.json   | 16 ++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 180552329c..f31fcbb0d5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1448,6 +1448,33 @@ void qmp_migrate_recover(const char *uri, Error **errp)
>      qemu_start_incoming_migration(uri, errp);
>  }
>  
> +void qmp_migrate_pause(Error **errp)
> +{
> +    MigrationState *ms = migrate_get_current();
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +    int ret;
> +
> +    if (ms->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +        /* Source side, during postcopy */
> +        ret = qemu_file_shutdown(ms->to_dst_file);

How did this fix the race I mentioned last time?

Dave

> +        if (ret) {
> +            error_setg(errp, "Failed to pause source migration");
> +        }
> +        return;
> +    }
> +
> +    if (mis->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +        ret = qemu_file_shutdown(mis->from_src_file);
> +        if (ret) {
> +            error_setg(errp, "Failed to pause destination migration");
> +        }
> +        return;
> +    }
> +
> +    error_setg(errp, "migrate-pause is currently only supported "
> +               "during postcopy-active state");
> +}
> +
>  bool migration_is_blocked(Error **errp)
>  {
>      if (qemu_savevm_state_blocked(errp)) {
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 451d8c572b..b8827d5ace 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1194,3 +1194,19 @@
>  ##
>  { 'command': 'migrate-recover', 'data': { 'uri': 'str' },
>    'allow-oob': true }
> +
> +##
> +# @migrate-pause:
> +#
> +# Pause a migration.  Currently it only supports postcopy.
> +#
> +# Returns: nothing.
> +#
> +# Example:
> +#
> +# -> { "execute": "migrate-pause" }
> +# <- { "return": {} }
> +#
> +# Since: 2.12
> +##
> +{ 'command': 'migrate-pause', 'allow-oob': true }
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
