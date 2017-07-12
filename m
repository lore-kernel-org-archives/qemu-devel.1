Received: from eggs.gnu.org ([2001:4830:134:3::10]:53517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVMhY-0000qH-2A
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVMhV-00035b-1M
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:49:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dVMhU-00035D-OW
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:49:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0BEF8B134
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 18:49:27 +0000 (UTC)
Date: Wed, 12 Jul 2017 19:49:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170712184921.GK30658@work-vm>
References: <1499842423-21101-1-git-send-email-peterx@redhat.com>
	<1499842423-21101-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499842423-21101-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: export parameters to props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> Export migration parameters to qdev properties. Then we can use, for
> example:
> 
>   -global migration.cpu-throttle-initial=xxx
> 
> To specify migration parameters during init.
> 
> One thing to mention is that, this usage should only be used for
> debugging/testing purpose, and should never be used elsewhere.
> Meanwhile, we don't guarantee the compatibility of this interface. It
> can alter anytime in the future.
> 
> (Ok, it won't change a lot. But it'll just work like HMP - Let's just be
>  prepare for any possible change to it)
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index a0db40d..fd00670 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2009,6 +2009,31 @@ static Property migration_properties[] = {
>                       send_configuration, true),
>      DEFINE_PROP_BOOL("send-section-footer", MigrationState,
>                       send_section_footer, true),
> +
> +    /* Migration parameters */
> +    DEFINE_PROP_INT64("compress-level", MigrationState,
> +                      parameters.compress_level,
> +                      DEFAULT_MIGRATE_COMPRESS_LEVEL),
> +    DEFINE_PROP_INT64("compress-threads", MigrationState,
> +                      parameters.compress_threads,
> +                      DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT),
> +    DEFINE_PROP_INT64("decompress-threads", MigrationState,
> +                      parameters.decompress_threads,
> +                      DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT),
> +    DEFINE_PROP_INT64("cpu-throttle-initial", MigrationState,
> +                      parameters.cpu_throttle_initial,
> +                      DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL),
> +    DEFINE_PROP_INT64("cpu-throttle-increment", MigrationState,
> +                      parameters.cpu_throttle_increment,
> +                      DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
> +    DEFINE_PROP_INT64("max-bandwidth", MigrationState,
> +                      parameters.max_bandwidth, MAX_THROTTLE),
> +    DEFINE_PROP_INT64("downtime-limit", MigrationState,
> +                      parameters.downtime_limit,
> +                      DEFAULT_MIGRATE_SET_DOWNTIME),
> +    DEFINE_PROP_INT64("x-checkpoint-delay", MigrationState,
> +                      parameters.x_checkpoint_delay,
> +                      DEFAULT_MIGRATE_X_CHECKPOINT_DELAY),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -2027,16 +2052,6 @@ static void migration_instance_init(Object *obj)
>      ms->state = MIGRATION_STATUS_NONE;
>      ms->xbzrle_cache_size = DEFAULT_MIGRATE_CACHE_SIZE;
>      ms->mbps = -1;
> -    ms->parameters = (MigrationParameters) {
> -        .compress_level = DEFAULT_MIGRATE_COMPRESS_LEVEL,
> -        .compress_threads = DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT,
> -        .decompress_threads = DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT,
> -        .cpu_throttle_initial = DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL,
> -        .cpu_throttle_increment = DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT,
> -        .max_bandwidth = MAX_THROTTLE,
> -        .downtime_limit = DEFAULT_MIGRATE_SET_DOWNTIME,
> -        .x_checkpoint_delay = DEFAULT_MIGRATE_X_CHECKPOINT_DELAY,
> -    };
>      ms->parameters.tls_creds = g_strdup("");
>      ms->parameters.tls_hostname = g_strdup("");
>  }
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
