Received: from eggs.gnu.org ([2001:4830:134:3::10]:56360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXAho-0008Uo-OD
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXAhm-0000Jj-38
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:25:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXAhl-0000JR-P6
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:25:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27E467CB90
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 18:25:12 +0000 (UTC)
Date: Mon, 17 Jul 2017 15:25:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170717182505.GA6020@localhost.localdomain>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-8-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500279971-13875-8-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 07/11] migration: check global params
 for validity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jul 17, 2017 at 04:26:07PM +0800, Peter Xu wrote:
> Adding validity check for the migration parameters passed in via global
> properties.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 8c65054..5a7f22c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2109,6 +2109,39 @@ static void migration_instance_init(Object *obj)
>      ms->parameters.tls_hostname = g_strdup("");
>  }
>  
> +static void migration_instance_post_init(Object *obj)
> +{
> +    MigrationState *ms = (MigrationState *)obj;
> +    Error *err = NULL;
> +    MigrationParameters params = {
> +        .has_compress_level = true,
> +        .compress_level = ms->parameters.compress_level,
> +        .has_compress_threads = true,
> +        .compress_threads = ms->parameters.compress_threads,
> +        .has_decompress_threads = true,
> +        .decompress_threads = ms->parameters.decompress_threads,
> +        .has_cpu_throttle_initial = true,
> +        .cpu_throttle_initial = ms->parameters.cpu_throttle_initial,
> +        .has_cpu_throttle_increment = true,
> +        .cpu_throttle_increment = ms->parameters.cpu_throttle_increment,
> +        .has_max_bandwidth = true,
> +        .max_bandwidth = ms->parameters.max_bandwidth,
> +        .has_downtime_limit = true,
> +        .downtime_limit = ms->parameters.downtime_limit,
> +        .has_x_checkpoint_delay = true,
> +        .x_checkpoint_delay = ms->parameters.x_checkpoint_delay,
> +        .has_block_incremental = true,
> +        .block_incremental = ms->parameters.block_incremental,
> +    };
> +
> +    /* We have applied all the migration properties... */
> +
> +    if (!migrate_params_check(&params, &err)) {

Why not just:
  if (!migrate_params_check(&ms->parameters, &err))
?

If the ms->parameters.has_* fields are not set to true anywhere,
we can set them to true in instance_init.

(This would also also us to use QAPI_CLONE in
qmp_query_migrate_parameters() instead of manually copying each
field.


> +        error_report_err(err);
> +        exit(1);
> +    }
> +}

On real devices, this is normally done on realize (which has
proper error reporting).  We never realize the TYPE_MIGRATION
object because it's not a real device, though.

Doing error checks on post_init feels fragile, as the only way
errors can be handled is triggering exit(1) in the middle of an
object_new() call.

As we have only one place where the TYPE_MIGRATION object is
created, I suggest calling migrate_params_check() inside
migration_object_init().

> +
>  static const TypeInfo migration_type = {
>      .name = TYPE_MIGRATION,
>      /*
> @@ -2124,6 +2157,7 @@ static const TypeInfo migration_type = {
>      .class_size = sizeof(MigrationClass),
>      .instance_size = sizeof(MigrationState),
>      .instance_init = migration_instance_init,
> +    .instance_post_init = migration_instance_post_init,
>  };
>  
>  static void register_migration_types(void)
> -- 
> 2.7.4
> 

-- 
Eduardo
