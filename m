Received: from eggs.gnu.org ([2001:4830:134:3::10]:44940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWTUu-0002Uk-JD
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWTUq-0007ZK-OP
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:49:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWTUq-0007YI-Eq
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:49:16 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1509369390-8285-2-git-send-email-a.perevalov@samsung.com>
	(Alexey Perevalov's message of "Mon, 30 Oct 2017 16:16:25 +0300")
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171030131647eucas1p2ea569225550a2250ee75f76b482b7498@eucas1p2.samsung.com>
	<1509369390-8285-2-git-send-email-a.perevalov@samsung.com>
Reply-To: quintela@redhat.com
Date: Tue, 02 Jan 2018 21:49:08 +0100
Message-ID: <87373o56m3.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 1/6] migration: introduce
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
Cc: qemu-devel@nongnu.org, peterx@redhat.com, i.maximets@samsung.com, heetae82.ahn@samsung.com, dgilbert@redhat.com

Alexey Perevalov <a.perevalov@samsung.com> wrote:
> Right now it could be used on destination side to
> enable vCPU blocktime calculation for postcopy live migration.
> vCPU blocktime - it's time since vCPU thread was put into
> interruptible sleep, till memory page was copied and thread awake.
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> ---
>  migration/migration.c | 9 +++++++++
>  migration/migration.h | 1 +
>  qapi/migration.json   | 6 +++++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 62761d5..c5244ae 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1492,6 +1492,15 @@ bool migrate_zero_blocks(void)
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
> diff --git a/migration/migration.h b/migration/migration.h
> index 8ccdd7a..5f5e527 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -202,6 +202,7 @@ int migrate_compress_level(void);
>  int migrate_compress_threads(void);
>  int migrate_decompress_threads(void);
>  bool migrate_use_events(void);
> +bool migrate_postcopy_blocktime(void);
>  
>  /* Sending on the return path - generic and then for each message type */
>  void migrate_send_rp_shut(MigrationIncomingState *mis,
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 6ae866e..c20caf4 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -352,12 +352,16 @@
>  #
>  # @x-multifd: Use more than one fd for migration (since 2.11)
>  #
> +# @postcopy-blocktime: Calculate downtime for postcopy live migration
> +#                     (since 2.11)
> +#

changed to 2.12

>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
> -           'block', 'return-path', 'pause-before-switchover', 'x-multifd' ] }
> +           'block', 'return-path', 'pause-before-switchover', 'x-multifd',
> +           'postcopy-blocktime' ] }
>  
>  ##
>  # @MigrationCapabilityStatus:
