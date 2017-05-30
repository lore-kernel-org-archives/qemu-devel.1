Received: from eggs.gnu.org ([2001:4830:134:3::10]:51162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFjPl-0003pO-9L
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFjPk-00037I-GY
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:50:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFjPk-00037D-9F
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:50:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38D1BC0099FD
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 15:50:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495176212-14446-5-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Fri, 19 May 2017 14:43:30 +0800")
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-5-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 17:50:27 +0200
Message-ID: <871sr6finw.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 4/6] migration: shut src return path
 unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> We were do the shutting off only for postcopy. Now we do this as long as
> the source return path is there.
>
> Moving the cleanup of from_src_file there too.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c    | 8 +++++++-
>  migration/postcopy-ram.c | 1 -
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 92617fc..a4006b4 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -131,10 +131,17 @@ void migration_incoming_state_destroy(void)
>      struct MigrationIncomingState *mis = migration_incoming_get_current();
>  
>      if (mis->to_src_file) {
> +        /* Tell source that we are done */
> +        migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);

Reviewed-by: Juan Quintela <quintela@redhat.com>


I think this one belongs to previous patch (with accompaining line from below).
But just if you want to change it.

>          qemu_fclose(mis->to_src_file);
>          mis->to_src_file = NULL;
>      }
>  
> +    if (mis->from_src_file) {
> +        qemu_fclose(mis->from_src_file);
> +        mis->from_src_file = NULL;
> +    }
> +
>      qemu_event_destroy(&mis->main_thread_load_event);
>      loadvm_free_handlers(mis);
>  }
> @@ -433,7 +440,6 @@ static void process_incoming_migration_co(void *opaque)
>          exit(EXIT_FAILURE);
>      }
>  
> -    qemu_fclose(f);
>      free_xbzrle_decoded_buf();
>  
>      mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index a0489f6..57aa208 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -320,7 +320,6 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>      }
>  
>      postcopy_state_set(POSTCOPY_INCOMING_END);
> -    migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
>  
>      if (mis->postcopy_tmp_page) {
>          munmap(mis->postcopy_tmp_page, mis->largest_page_size);
