Received: from eggs.gnu.org ([2001:4830:134:3::10]:38494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFhFH-0004Lr-VS
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFhFD-0007xp-TR
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:31:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFhFD-0007xX-Ka
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:31:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40EB1C05683F
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:31:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495176212-14446-3-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Fri, 19 May 2017 14:43:28 +0800")
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-3-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 15:31:26 +0200
Message-ID: <87o9uafp3l.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 2/6] migration: isolate return path on
 src
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
> There are some places that binded "return path" with postcopy. Let's be
> prepared for its usage even without postcopy. This patch mainly did this
> on source side.
>
> This has no functional change. But it'll simplify further patches.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c  | 50 +++++++++++++++++++++++++++++++++++---------------
>  migration/trace-events |  4 ++--
>  2 files changed, 37 insertions(+), 17 deletions(-)




>  
> +/* Return true if success, otherwise false. */
> +static bool migrate_return_path_create(MigrationState *s)
> +{
> +    /* Whether we should enable return path */
> +    bool enable_return_path = false;
> +    /* Whether we should force its success */
> +    bool force_return_path = false;
> +
> +    if (migrate_postcopy_ram()) {
> +        enable_return_path = true;
> +        force_return_path = true;
> +    }
> +
> +    if (enable_return_path) {
> +        if (open_return_path_on_source(s) && force_return_path) {
> +            error_report("Unable to open return-path");
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +

what about this 

static bool migrate_return_patch_create(MigrationState *s)
{
    if (open_return_path_on_source(s)) {
        error_report("Unable to open return-path");
        return false;
    }

    return true;
}

>  void migrate_fd_connect(MigrationState *s)
>  {
>      s->expected_downtime = s->parameters.downtime_limit;
> @@ -2057,17 +2081,13 @@ void migrate_fd_connect(MigrationState *s)
>      notifier_list_notify(&migration_state_notifiers, s);
>  
>      /*
> -     * Open the return path; currently for postcopy but other things might
> -     * also want it.
> +     * Open the return path.
>       */
> -    if (migrate_postcopy_ram()) {
> -        if (open_return_path_on_source(s)) {
> -            error_report("Unable to open return-path for postcopy");
> -            migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> -                              MIGRATION_STATUS_FAILED);
> -            migrate_fd_cleanup(s);
> -            return;
> -        }
> +    if (!migrate_return_path_create(s)) {
> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> +                          MIGRATION_STATUS_FAILED);
> +        migrate_fd_cleanup(s);
> +        return;
>      }


And this?

>      /*
> -     * Open the return path; currently for postcopy but other things might
> -     * also want it.
> +     * Open the return path.
>       */
> -    if (migrate_postcopy_ram()) {
> -        if (open_return_path_on_source(s)) {
> -            error_report("Unable to open return-path for postcopy");
> -            migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> -                              MIGRATION_STATUS_FAILED);
> -            migrate_fd_cleanup(s);
> -            return;
> -        }
> +    if (!migrate_return_path_create(s)) {
> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> +                          MIGRATION_STATUS_FAILED);
> +        migrate_fd_cleanup(s);
> +        return;
>      }

    /*
     * Open the return path
     */

    if (migrate_postcopy_ram()) {
        if (!migrate_return_path_create(s)) {
            migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                              MIGRATION_STATUS_FAILED);
            migrate_fd_cleanup(s);
            return;
        }
    }

Two less booleans and same behaviour.  It is also shorter, but that was
not the idea.

Later, Juan.
