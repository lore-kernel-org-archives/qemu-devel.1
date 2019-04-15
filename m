Received: from eggs.gnu.org ([209.51.188.92]:41979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hFuWw-0003wX-TN
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hFuWv-0005UW-UE
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:51:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hFuWv-0005Sr-Ms
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:51:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190413160732.55505-1-vsementsov@virtuozzo.com>
Date: Mon, 15 Apr 2019 07:51:41 +0200
In-Reply-To: <20190413160732.55505-1-vsementsov@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Sat, 13 Apr 2019 19:07:32 +0300")
Message-ID: <87zhorbytu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] util/error: do not free error on
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
>  util/error.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/util/error.c b/util/error.c
> index 934a78e1b1..f9180c0f30 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -32,9 +32,11 @@ Error *error_fatal;
>  static void error_handle_fatal(Error **errp, Error *err)
>  {
>      if (errp == &error_abort) {
> -        fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
> -                err->func, err->src, err->line);
> -        error_report_err(err);
> +        error_report("Unexpected error in %s() at %s:%d: %s",
> +                     err->func, err->src, err->line, error_get_pretty(err));
> +        if (err->hint) {
> +            error_printf_unless_qmp("%s", err->hint->str);
> +        }
>          abort();
>      }
>      if (errp == &error_fatal) {

No objections to not freeing the error object on the path to abort().

You also format the error message differently.  Commit 1e9b65bb1ba's
example

        Unexpected error in parse_block_error_action() at .../qemu/blockdev.c:322:
        qemu-system-x86_64: -drive if=none,werror=foo: 'foo' invalid write error action
        Aborted (core dumped)

changes to (guesswork, not tested):

        qemu-system-x86_64: -drive if=none,werror=foo: Unexpected error in parse_block_error_action() at .../qemu/blockdev.c:322: 'foo' invalid write error action
        Aborted (core dumped)

Intentional?  It makes sense as an error message, but readability
suffers due to the long line.  If we decide we want this change, it
needs to be mentioned in the commit message.

Open-coding error_report_err() here so you can delete the error_free()
and a newline is a bit ugly, but factoring out the common part doesn't
seem worthwhile.

Hmm, perhaps factoring out

        if (err->hint) {
            error_printf_unless_qmp("%s", err->hint->str);
        }

into a static helper would be worthwhile.  We already have two copies.
