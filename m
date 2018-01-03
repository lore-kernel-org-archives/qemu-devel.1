Received: from eggs.gnu.org ([2001:4830:134:3::10]:58379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWi5Z-0001M2-KF
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWi5Y-0006it-AT
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:24:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWi5Y-0006ga-44
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:24:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E8E2369C9
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:24:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180103122017.14794-2-peterx@redhat.com> (Peter Xu's message of
	"Wed, 3 Jan 2018 20:20:05 +0800")
References: <20180103122017.14794-1-peterx@redhat.com>
	<20180103122017.14794-2-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 13:23:58 +0100
Message-ID: <87wp0zyvtt.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 01/13] migration: assert colo instead of
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> When reaching here if we are still "active" it means we must be in colo
> state.  After a quick discussion offlist, we decided to use the safer
> error_report().
>
> Finally I want to use "switch" here rather than lots of complicated if
> clauses.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>



> ---
>  migration/migration.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 4de3b551fe..5a12738447 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2309,7 +2309,15 @@ static void *migration_thread(void *opaque)
>          }
>          runstate_set(RUN_STATE_POSTMIGRATE);
>      } else {
> -        if (s->state == MIGRATION_STATUS_ACTIVE && enable_colo) {
> +        if (s->state == MIGRATION_STATUS_ACTIVE) {
> +            /*
> +             * We should really assert here, but since it's during
> +             * migration, let's try to reduce the usage of assertions.
> +             */
> +            if (!enable_colo) {
> +                error_report("%s: critical error: calling COLO code without "
> +                             "COLO enabled", __func__);

I will put on the error message something like:

"%s: critical error: State ACTIVE without COLO being enable.  That is
forbidden/imposible".

And then you don't need the previous comment?

Later, Juan.


> +            }
>              migrate_start_colo_process(s);
>              qemu_savevm_state_cleanup();
>              /*
