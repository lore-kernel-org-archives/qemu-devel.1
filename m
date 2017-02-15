Received: from eggs.gnu.org ([2001:4830:134:3::10]:41165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdzFt-00019j-2q
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdzFp-0004E4-U7
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:04:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cdzFp-0004Dy-OF
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:04:17 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE4E565D11
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 13:04:17 +0000 (UTC)
Date: Wed, 15 Feb 2017 13:04:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170215130412.GD2731@work-vm>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
	<1487006388-7966-4-git-send-email-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487006388-7966-4-git-send-email-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PULL 03/12] migration: Add multifd capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/migration/migration.h | 1 +
>  migration/migration.c         | 9 +++++++++
>  qapi-schema.json              | 5 +++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 7528cc2..e8bba55 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -308,6 +308,7 @@ bool migrate_postcopy_ram(void);
>  bool migrate_zero_blocks(void);
> 
>  bool migrate_auto_converge(void);
> +bool migrate_use_multifd(void);
> 
>  int xbzrle_encode_buffer(uint8_t *old_buf, uint8_t *new_buf, int slen,
>                           uint8_t *dst, int dlen);
> diff --git a/migration/migration.c b/migration/migration.c
> index 2b179c6..37af7a4 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1369,6 +1369,15 @@ bool migrate_use_events(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_EVENTS];
>  }
> 
> +bool migrate_use_multifd(void)
> +{
> +    MigrationState *s;
> +
> +    s = migrate_get_current();
> +
> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_X_MULTIFD];
> +}
> +
>  int migrate_use_xbzrle(void)
>  {
>      MigrationState *s;
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 61151f3..ff7579e 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -865,12 +865,13 @@
>  #        side, this process is called COarse-Grain LOck Stepping (COLO) for
>  #        Non-stop Service. (since 2.8)
>  #
> +# @x-multifd: Use more than one fd for migration (since 2.9)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> -           'compress', 'events', 'postcopy-ram', 'x-colo'] }
> -
> +           'compress', 'events', 'postcopy-ram', 'x-colo', 'x-multifd'] }

That needs a minor remerge after 'release-ram' just went in.

Dave

>  ##
>  # @MigrationCapabilityStatus:
>  #
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
