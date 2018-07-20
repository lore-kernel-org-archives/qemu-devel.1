Received: from eggs.gnu.org ([2001:4830:134:3::10]:38068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgNkm-0005N2-ND
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 01:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgNkk-0001AZ-0b
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 01:14:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50830 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fgNkj-0001AP-Q0
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 01:14:53 -0400
Date: Fri, 20 Jul 2018 13:14:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180720051448.GP4071@xz-mi>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
	<20180718154200.26777-2-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718154200.26777-2-dplotnikov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v1 01/17] migration: add background
 snapshot capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Wed, Jul 18, 2018 at 06:41:44PM +0300, Denis Plotnikov wrote:
> The capability is used for the background vmstate saving
> using the migration infrastructure.
> Background vmstate saving means that the majority of vmstate
> (RAM) is saved in the background when VM's vCPUS are running.
> This helps to reduce the VM downtime on VM snapshotting.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  migration/migration.c | 35 +++++++++++++++++++++++++++++++++++
>  migration/migration.h |  1 +
>  qapi/migration.json   |  6 +++++-
>  3 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index d780601f0c..87096d23ef 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -697,6 +697,12 @@ static bool migrate_caps_check(bool *cap_list,
>              return false;
>          }
>  
> +        if (cap_list[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
> +            error_setg(errp, "Postcopy is not compatible "
> +                        "with background snapshot");
> +            return false;
> +        }
> +
>          /* This check is reasonably expensive, so only when it's being
>           * set the first time, also it's only the destination that needs
>           * special support.
> @@ -711,6 +717,26 @@ static bool migrate_caps_check(bool *cap_list,
>          }
>      }
>  
> +    if (cap_list[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
> +        if (cap_list[MIGRATION_CAPABILITY_RELEASE_RAM]) {
> +            error_setg(errp, "Background snapshot is not compatible "
> +                        "with release ram capability");
> +            return false;
> +        }
> +
> +        if (cap_list[MIGRATION_CAPABILITY_COMPRESS]) {
> +            error_setg(errp, "Background snapshot is not "
> +                        "currently compatible with compression");
> +            return false;
> +        }
> +
> +        if (cap_list[MIGRATION_CAPABILITY_XBZRLE]) {
> +            error_setg(errp, "Background snapshot is not "
> +                        "currently compatible with XBZLRE");
> +            return false;
> +        }
> +    }
> +
>      return true;
>  }
>  
> @@ -1635,6 +1661,15 @@ bool migrate_use_block_incremental(void)
>      return s->parameters.block_incremental;
>  }
>  
> +bool migrate_background_snapshot(void)
> +{
> +    MigrationState *s;
> +
> +    s = migrate_get_current();
> +
> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT];
> +}
> +
>  /* migration thread support */
>  /*
>   * Something bad happened to the RP stream, mark an error
> diff --git a/migration/migration.h b/migration/migration.h
> index 663415fe48..21babbc008 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -201,6 +201,7 @@ int migrate_compress_level(void);
>  int migrate_compress_threads(void);
>  int migrate_decompress_threads(void);
>  bool migrate_use_events(void);
> +bool migrate_background_snapshot(void);
>  
>  /* Sending on the return path - generic and then for each message type */
>  void migrate_send_rp_shut(MigrationIncomingState *mis,
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 03f57c9616..eb5f52b7ff 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -352,12 +352,16 @@
>  #
>  # @x-multifd: Use more than one fd for migration (since 2.11)
>  #
> +# @background-snapshot: Using migration infrastructure makes VM snapshot
> +#         saving its RAM in background. This reduces  VM downtime. (since 2.12)
> +#

Please specify "(since 3.1)" in your next post.

The sentence is not that clear to me.  For example, "saving its RAM in
background" is done in every migration, not only for the live
snapshot.  The words "reduces VM downtime" sounds also like for a live
migration rather than snapshots.  My try:

  If enabled, the migration stream will be a snapshot of the VM
  exactly at the point when the migration procedure starts.

>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
> -           'block', 'return-path', 'pause-before-switchover', 'x-multifd' ] }
> +           'block', 'return-path', 'pause-before-switchover', 'x-multifd',
> +           'background-snapshot' ] }
>  
>  ##
>  # @MigrationCapabilityStatus:
> -- 
> 2.17.0
> 
> 

Regards,

-- 
Peter Xu
