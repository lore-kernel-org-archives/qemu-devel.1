Received: from eggs.gnu.org ([2001:4830:134:3::10]:44057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBe5C-0002aZ-9Y
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBe57-0002I7-C4
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:20:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dBe57-0002Hu-4D
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:20:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83CB943A46
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 09:20:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170518111837.29212-1-quintela@redhat.com>
	<20170518111837.29212-3-quintela@redhat.com>
Date: Fri, 19 May 2017 11:20:16 +0200
In-Reply-To: <20170518111837.29212-3-quintela@redhat.com> (Juan Quintela's
	message of "Thu, 18 May 2017 13:18:34 +0200")
Message-ID: <87efvlcien.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: Create block capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Juan Quintela <quintela@redhat.com> writes:

> Create one capability for block migration and one parameter for
> incremental block migration.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
[...]
> diff --git a/include/migration/block.h b/include/migration/block.h
> index 41a1ac8..5225af9 100644
> --- a/include/migration/block.h
> +++ b/include/migration/block.h
> @@ -20,4 +20,6 @@ uint64_t blk_mig_bytes_transferred(void);
>  uint64_t blk_mig_bytes_remaining(void);
>  uint64_t blk_mig_bytes_total(void);
>  
> +void migrate_set_block_enabled(bool value, Error **errp);
> +
>  #endif /* MIGRATION_BLOCK_H */
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 49ec501..024a048 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -153,6 +153,9 @@ struct MigrationState
>  
>      /* The last error that occurred */
>      Error *error;
> +    /* Do we have to clean up -b/-i from old migrate parameters */

The sentence is a question, so it should end with a '?'.

> +    /* This feature is deprecated and will be removed */
> +    bool must_remove_block_options;
>  };
>  
>  void migrate_set_state(int *state, int old_state, int new_state);
> @@ -265,6 +268,9 @@ bool migrate_colo_enabled(void);
>  
>  int64_t xbzrle_cache_resize(int64_t new_size);
>  
> +bool migrate_use_block(void);
> +bool migrate_use_block_incremental(void);
> +
>  bool migrate_use_compression(void);
>  int migrate_compress_level(void);
>  int migrate_compress_threads(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index 0304c01..c13c0a2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
[...]
> @@ -1207,6 +1242,24 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>          return;
>      }
>  
> +    if ((has_blk && blk) || (has_inc && inc)) {
> +        if (migrate_use_block() || migrate_use_block_incremental()) {
> +            error_setg(errp, "Command options are incompatible with "
> +                       "current migration capabilities");
> +            return;
> +        }
> +        migrate_set_block_enabled(true, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +        s->must_remove_block_options = true;
> +    }
> +
> +    if (has_inc && inc) {
> +        migrate_set_block_incremental(s, true);
> +    }
> +

Putting this within the previous conditional might be clearer.  Your
choice.

>      s = migrate_init(&params);
>  
>      if (strstart(uri, "tcp:", &p)) {
[...]

Only nitpicks, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>
