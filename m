Received: from eggs.gnu.org ([2001:4830:134:3::10]:46025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSeW9-00048U-UA
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSeW8-0007F5-Su
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-4-mreitz@redhat.com>
Date: Wed, 05 Jul 2017 09:14:22 +0200
In-Reply-To: <20170703122505.32017-4-mreitz@redhat.com> (Max Reitz's message
	of "Mon, 3 Jul 2017 14:25:03 +0200")
Message-ID: <87k23ne4oh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/5] block: qobject_is_equal() in
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
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/block.c b/block.c
> index 913bb43..45eb248 100644
> --- a/block.c
> +++ b/block.c
> @@ -2947,19 +2947,24 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
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
> -            const char *old = qdict_get_try_str(reopen_state->bs->options,
> -                                                entry->key);
> -
> -            if (!old || strcmp(new, old)) {
> +            QObject *new = entry->value;
> +            QObject *old = qdict_get(reopen_state->bs->options, entry->key);
> +
> +            /* TODO: When using -drive to specify blockdev options, all values
> +             * will be strings; however, when using -blockdev, blockdev-add or
> +             * filenames using the json:{} pseudo-protocol, they will be
> +             * correctly typed.
> +             * In contrast, reopening options are (currently) always strings
> +             * (because you can only specify them through qemu-io; all other
> +             * callers do not specify any options).
> +             * Therefore, when using anything other than -drive to create a BDS,
> +             * this cannot detect non-string options as unchanged, because
> +             * qobject_is_equal() always returns false for objects of different
> +             * type.  In the future, this should be remedied by correctly typing
> +             * all options.  For now, this is not too big of an issue because
> +             * the user simply can not specify options which cannot be changed
> +             * anyway, so they will stay unchanged. */

I'm not the maintainer, and this is not a demand: consider winging this
comment and wrapping lines around column 70.

As much as I fancy word play (see your reply to Eric), I have to admit
that I had to read "the user simply can not specify options" about three
times to make sense of it.  Please consider a wording that's easier to
grasp, perhaps "the user can simply refrain from specifying options that
cannot be changed".

> +            if (!qobject_is_equal(new, old)) {
>                  error_setg(errp, "Cannot change the option '%s'", entry->key);
>                  ret = -EINVAL;
>                  goto error;
