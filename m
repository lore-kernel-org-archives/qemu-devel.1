Received: from eggs.gnu.org ([2001:4830:134:3::10]:54504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dv5jT-0002Zd-Vk
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dv5jP-0007bW-MJ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:57:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dv5jP-0007ae-85
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:57:47 -0400
Date: Thu, 21 Sep 2017 18:57:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170921175739.GF3401@work-vm>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-9-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504081950-2528-9-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 08/33] migration: new postcopy-pause state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> Introducing a new state "postcopy-paused", which can be used when the
> postcopy migration is paused. It is targeted for postcopy network
> failure recovery.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 2 ++
>  qapi-schema.json      | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 92bf9b8..f6130db 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -470,6 +470,7 @@ static bool migration_is_setup_or_active(int state)
>      switch (state) {
>      case MIGRATION_STATUS_ACTIVE:
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> +    case MIGRATION_STATUS_POSTCOPY_PAUSED:
>      case MIGRATION_STATUS_SETUP:
>          return true;

That's quite interesting; but yes I think it's right.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


> @@ -545,6 +546,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
>      case MIGRATION_STATUS_ACTIVE:
>      case MIGRATION_STATUS_CANCELLING:
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> +    case MIGRATION_STATUS_POSTCOPY_PAUSED:
>           /* TODO add some postcopy stats */
>          info->has_status = true;
>          info->has_total_time = true;
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 802ea53..368b592 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -667,6 +667,8 @@
>  #
>  # @postcopy-active: like active, but now in postcopy mode. (since 2.5)
>  #
> +# @postcopy-paused: during postcopy but paused. (since 2.11)
> +#
>  # @completed: migration is finished.
>  #
>  # @failed: some error occurred during migration process.
> @@ -679,7 +681,8 @@
>  ##
>  { 'enum': 'MigrationStatus',
>    'data': [ 'none', 'setup', 'cancelling', 'cancelled',
> -            'active', 'postcopy-active', 'completed', 'failed', 'colo' ] }
> +            'active', 'postcopy-active', 'postcopy-paused',
> +            'completed', 'failed', 'colo' ] }
>  
>  ##
>  # @MigrationInfo:
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
