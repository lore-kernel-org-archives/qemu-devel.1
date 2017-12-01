Received: from eggs.gnu.org ([2001:4830:134:3::10]:44151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eKoZL-0003uf-2Q
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eKoZH-0003gH-3q
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:53:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eKoZG-0003f3-Rs
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:53:39 -0500
Date: Fri, 1 Dec 2017 16:53:28 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171201165327.GB2318@work-vm>
References: <20171108060130.3772-1-peterx@redhat.com>
	<20171108060130.3772-32-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171108060130.3772-32-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 31/32] migration,
 qmp: new command "migrate-pause"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> It is used to manually trigger the postcopy pause state.  It works just
> like when we found the migration stream failed during postcopy, but
> provide an explicit way for user in case of misterious socket hangs.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Can we change the name to something like 'migrate-disconnect' - pause
is a bit easy to confuse with other things and this is really more
an explicit network disconnect (Is it worth just making it a flag to
migrate-cancel?)


> ---
>  migration/migration.c | 18 ++++++++++++++++++
>  qapi/migration.json   | 22 ++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 536a771803..30348a5e27 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1485,6 +1485,24 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
>      once = false;
>  }
>  
> +void qmp_migrate_pause(Error **errp)
> +{
> +    int ret;
> +    MigrationState *ms = migrate_get_current();
> +
> +    if (ms->state != MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +        error_setg(errp, "Migration pause is currently only allowed during"
> +                   " an active postcopy phase.");
> +        return;
> +    }
> +
> +    ret = qemu_file_shutdown(ms->to_dst_file);
> +
> +    if (ret) {
> +        error_setg(errp, "Failed to pause migration stream.");
> +    }
> +}
> +
>  bool migration_is_blocked(Error **errp)
>  {
>      if (qemu_savevm_state_blocked(errp)) {
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 4a3eff62f1..52901f7e2e 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1074,6 +1074,28 @@
>  { 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
>  
>  ##
> +# @migrate-pause:
> +#
> +# Pause an migration.  Currently it can only pause a postcopy
> +# migration.  Pausing a precopy migration is not supported yet.
> +#
> +# It is mostly used as a manual way to trigger the postcopy paused
> +# state when the network sockets hang due to some reason, so that we
> +# can try a recovery afterward.

Can we say this explicitly;
'Force closes the migration connection to trigger the postcopy paused
 state when the network sockets hang due to some reason, so that we
can try a recovery afterwards'

Dave

> +# Returns: nothing on success
> +#
> +# Since: 2.12
> +#
> +# Example:
> +#
> +# -> { "execute": "migrate-pause" }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'migrate-pause' }
> +
> +##
>  # @xen-save-devices-state:
>  #
>  # Save the state of all devices to file. The RAM and the block devices
> -- 
> 2.13.6
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
