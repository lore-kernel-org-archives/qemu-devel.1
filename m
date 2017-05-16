Received: from eggs.gnu.org ([2001:4830:134:3::10]:43255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dAZnn-0000xp-Fv
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dAZnj-0003SB-Ej
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:34:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dAZnj-0003Ry-5I
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:33:59 -0400
Date: Tue, 16 May 2017 11:33:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170516103352.GC2839@work-vm>
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512133146eucas1p2ba4841cabf508b66410fae6784952eaa@eucas1p2.samsung.com>
	<1494595886-30912-6-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494595886-30912-6-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH V5 5/9] migration: introduce
 postcopy-blocktime capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> Right now it could be used on destination side to
> enable vCPU blocktime calculation for postcopy live migration.
> vCPU blocktime - it's time since vCPU thread was put into
> interruptible sleep, till memory page was copied and thread awake.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/migration.h | 1 +
>  migration/migration.c         | 9 +++++++++
>  qapi-schema.json              | 5 ++++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index ba1a16c..82bbcd8 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -315,6 +315,7 @@ int migrate_compress_level(void);
>  int migrate_compress_threads(void);
>  int migrate_decompress_threads(void);
>  bool migrate_use_events(void);
> +bool migrate_postcopy_blocktime(void);
>  
>  /* Sending on the return path - generic and then for each message type */
>  void migrate_send_rp_message(MigrationIncomingState *mis,
> diff --git a/migration/migration.c b/migration/migration.c
> index 569a7f6..c0443ce 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1371,6 +1371,15 @@ bool migrate_zero_blocks(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_ZERO_BLOCKS];
>  }
>  
> +bool migrate_postcopy_blocktime(void)
> +{
> +    MigrationState *s;
> +
> +    s = migrate_get_current();
> +
> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME];
> +}
> +
>  bool migrate_use_compression(void)
>  {
>      MigrationState *s;
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 01b087f..fde6d63 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -894,11 +894,14 @@
>  # @release-ram: if enabled, qemu will free the migrated ram pages on the source
>  #        during postcopy-ram migration. (since 2.9)
>  #
> +# @postcopy-blocktime: Calculate downtime for postcopy live migration (since 2.10)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> -           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'] }
> +           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
> +           'postcopy-blocktime'] }
>  
>  ##
>  # @MigrationCapabilityStatus:
> -- 
> 1.9.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
