Received: from eggs.gnu.org ([2001:4830:134:3::10]:47341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQ9EI-0003iD-C5
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQ9ED-0003aB-9f
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:25:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQ9ED-0003Zp-0l
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:25:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4F85C0467C4
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 09:25:39 +0000 (UTC)
Date: Wed, 28 Jun 2017 10:25:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170628092533.GB2130@work-vm>
References: <1498472935-14461-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498472935-14461-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: add "return-path" capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> When this capability is enabled, QEMU will use the return path even for
> precopy migration. This is helpful at least in one case when destination
> failed to load the image while source quited without confirmation. With
> return path, source will wait for the last response from destination,
> and if destination fails, it'll fail the migration on source, then the
> guest can be run again on the source (rather than assuming to be good,
> then the guest will be lost after source quits).
> 
> It needs to be enabled explicitly on source, otherwise disabled.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

OK, so this looks fine, lets see what else we have.
The migration thread already calls savevm_send_open_return_path
if it's got a from_dst_file.

We already call 'await_return_path_close_on_source' in
migration_completion if we have a from_dst_file  so that should
already work.

and on the incoming side, migration_incoming_state_destroy calls
migrate_send_rp_shut  if it has a to_src_file.  So that should close it
as well.

So that looks like a full set.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 16 +++++++++++++---
>  migration/migration.h |  1 +
>  qapi-schema.json      |  5 ++++-
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index f588329..66fd81e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1304,6 +1304,15 @@ bool migrate_use_block(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK];
>  }
>  
> +bool migrate_use_return_path(void)
> +{
> +    MigrationState *s;
> +
> +    s = migrate_get_current();
> +
> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_RETURN_PATH];
> +}
> +
>  bool migrate_use_block_incremental(void)
>  {
>      MigrationState *s;
> @@ -1968,10 +1977,11 @@ void migrate_fd_connect(MigrationState *s)
>      notifier_list_notify(&migration_state_notifiers, s);
>  
>      /*
> -     * Open the return path; currently for postcopy but other things might
> -     * also want it.
> +     * Open the return path. For postcopy, it is used exclusively. For
> +     * precopy, only if user specified "return-path" capability would
> +     * QEMU uses the return path.
>       */
> -    if (migrate_postcopy_ram()) {
> +    if (migrate_postcopy_ram() || migrate_use_return_path()) {
>          if (open_return_path_on_source(s)) {
>              error_report("Unable to open return-path for postcopy");
>              migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> diff --git a/migration/migration.h b/migration/migration.h
> index d9a268a..e41fb68 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -144,6 +144,7 @@ bool migrate_colo_enabled(void);
>  
>  bool migrate_use_block(void);
>  bool migrate_use_block_incremental(void);
> +bool migrate_use_return_path(void);
>  
>  bool migrate_use_compression(void);
>  int migrate_compress_level(void);
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 4b50b65..9e34cf7 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -900,12 +900,15 @@
>  #          offers more flexibility.
>  #          (Since 2.10)
>  #
> +# @return-path: If enabled, migration will use the return path even
> +#               for precopy. (since 2.10)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
> -           'block' ] }
> +           'block', 'return-path' ] }
>  
>  ##
>  # @MigrationCapabilityStatus:
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
