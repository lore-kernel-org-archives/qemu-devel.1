Received: from eggs.gnu.org ([2001:4830:134:3::10]:33636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e52HH-0004za-98
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e52HC-000437-9P
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:17:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e52HC-00041Z-0V
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:17:46 -0400
Date: Thu, 19 Oct 2017 12:17:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171019041737.GS4166@pxdev.xzpeter.org>
References: <20171018174013.22709-1-dgilbert@redhat.com>
	<20171018174013.22709-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171018174013.22709-2-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/7] migration: Add
 'pause-before-switchover' capability
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

On Wed, Oct 18, 2017 at 06:40:07PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> When 'pause-before-switchover' is enabled, the outgoing migration
> will pause before invalidating the block devices and serializing
> the device state.
> At this point the management layer gets the chance to clean up any
> device jobs or other device users before the migration completes.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/migration.c | 10 ++++++++++
>  migration/migration.h |  1 +
>  qapi/migration.json   |  5 ++++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 98429dc843..fba3342368 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1521,6 +1521,16 @@ bool migrate_use_multifd(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_X_MULTIFD];
>  }
>  
> +bool migrate_pause_before_switchover(void)
> +{
> +    MigrationState *s;
> +
> +    s = migrate_get_current();
> +
> +    return s->enabled_capabilities[
> +        MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER];
> +}
> +
>  int migrate_multifd_channels(void)
>  {
>      MigrationState *s;
> diff --git a/migration/migration.h b/migration/migration.h
> index b83cceadc4..969866303e 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -177,6 +177,7 @@ bool migrate_zero_blocks(void);
>  
>  bool migrate_auto_converge(void);
>  bool migrate_use_multifd(void);
> +bool migrate_pause_before_switchover(void);
>  int migrate_multifd_channels(void);
>  int migrate_multifd_page_count(void);
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index f8b365e3f5..4960231ba2 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -341,6 +341,9 @@
>  # @return-path: If enabled, migration will use the return path even
>  #               for precopy. (since 2.10)
>  #
> +# @pause-before-switchover: Pause outgoing migration before serialising device
> +#          state and before disabling block IO (since 2.11)

Nit: Not sure whether it's good to avoid naming "disabling block IO",
since after all this pre-switch state can be used to do other things
as well in the future.

Reviewed-by: Peter Xu <peterx@redhat.com>

> +#
>  # @x-multifd: Use more than one fd for migration (since 2.11)
>  #
>  # Since: 1.2
> @@ -348,7 +351,7 @@
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
> -           'block', 'return-path', 'x-multifd' ] }
> +           'block', 'return-path', 'pause-before-switchover', 'x-multifd' ] }
>  
>  ##
>  # @MigrationCapabilityStatus:
> -- 
> 2.13.6
> 

-- 
Peter Xu
