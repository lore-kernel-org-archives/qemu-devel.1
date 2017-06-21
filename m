Received: from eggs.gnu.org ([2001:4830:134:3::10]:58843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNi95-0006mt-Hn
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNi94-000599-Hk
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:06:19 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170621134744.8047-1-mreitz@redhat.com>
	<20170621134744.8047-4-mreitz@redhat.com>
Date: Wed, 21 Jun 2017 18:06:09 +0200
In-Reply-To: <20170621134744.8047-4-mreitz@redhat.com> (Max Reitz's message of
	"Wed, 21 Jun 2017 15:47:43 +0200")
Message-ID: <87h8z9wcjy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/4] block: qobject_is_equal() in
 bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> Currently, bdrv_reopen_prepare() assumes that all BDS options are
> strings. However, this is not the case if the BDS has been created
> through the json: pseudo-protocol or blockdev-add.
>
> Note that the user-invokable reopen command is an HMP command, so you
> can only specify strings there. Therefore, specifying a non-string
> option with the "same" value as it was when originally created will now
> return an error because the values are supposedly similar (and there is
> no way for the user to circumvent this but to just not specify the
> option again -- however, this is still strictly better than just
> crashing).
>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/block.c b/block.c
> index fa1d06d..23424d5 100644
> --- a/block.c
> +++ b/block.c
> @@ -2950,19 +2950,10 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
>          const QDictEntry *entry = qdict_first(reopen_state->options);
>  
>          do {
> -            QString *new_obj = qobject_to_qstring(entry->value);
> -            const char *new = qstring_get_str(new_obj);
> -            /*
> -             * Caution: while qdict_get_try_str() is fine, getting
> -             * non-string types would require more care.  When
> -             * bs->options come from -blockdev or blockdev_add, its
> -             * members are typed according to the QAPI schema, but
> -             * when they come from -drive, they're all QString.
> -             */

Your commit message makes me suspect this comment still applies in some
form.  Does it?

> -            const char *old = qdict_get_try_str(reopen_state->bs->options,
> -                                                entry->key);
> +            QObject *new = entry->value;
> +            QObject *old = qdict_get(reopen_state->bs->options, entry->key);
>  
> -            if (!old || strcmp(new, old)) {
> +            if (!qobject_is_equal(new, old)) {
>                  error_setg(errp, "Cannot change the option '%s'", entry->key);
>                  ret = -EINVAL;
>                  goto error;
