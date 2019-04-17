Received: from eggs.gnu.org ([209.51.188.92]:32953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGoB6-00038y-BI
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGoB5-0004UU-Dr
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:16:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGoB5-0004Ti-4t
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:16:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190415142519.73060-1-vsementsov@virtuozzo.com>
Date: Wed, 17 Apr 2019 19:16:52 +0200
In-Reply-To: <20190415142519.73060-1-vsementsov@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Mon, 15 Apr 2019 17:25:19 +0300")
Message-ID: <877ebswnzv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] util/error: do not free error on
 error_abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> It would be nice to have Error object not freed away when debugging a
> coredump.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>
> v2: don't change error output format
>
>  util/error.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/util/error.c b/util/error.c
> index 934a78e1b1..22f8a7924f 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -34,7 +34,10 @@ static void error_handle_fatal(Error **errp, Error *err)
>      if (errp == &error_abort) {
>          fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
>                  err->func, err->src, err->line);
> -        error_report_err(err);
> +        error_report("%s", error_get_pretty(err));
> +        if (err->hint) {
> +            error_printf_unless_qmp("%s", err->hint->str);
> +        }
>          abort();
>      }
>      if (errp == &error_fatal) {

We've since found out that the hint should be printed with
error_printf(), see "[PATCH] error: Fix error_report_err(),
warn_report_err() hint printing".  With that:

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Queued with this change.  Thanks!
