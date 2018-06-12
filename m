Received: from eggs.gnu.org ([2001:4830:134:3::10]:36692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSjS7-0005pb-IO
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSjRx-0002Pr-TE
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:35:15 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180611205203.2624-1-mreitz@redhat.com>
	<20180611205203.2624-7-mreitz@redhat.com>
Date: Tue, 12 Jun 2018 15:34:55 +0200
In-Reply-To: <20180611205203.2624-7-mreitz@redhat.com> (Max Reitz's message of
	"Mon, 11 Jun 2018 22:51:59 +0200")
Message-ID: <87wov4t9fk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 06/10] qdict: Make qdict_flatten()
 shallow-clone-friendly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>

Max Reitz <mreitz@redhat.com> writes:

> In its current form, qdict_flatten() removes all entries from nested
> QDicts that are moved to the root QDict.  It is completely sufficient to
> remove all old entries from the root QDict, however.  If the nested
> dicts have a refcount of 1, this will automatically delete them, too.
> And if they have a greater refcount, we probably do not want to modify
> them in the first place.
>
> The latter observation means that it was currently (in general)
> impossible to qdict_flatten() a shallowly cloned dict because that would
> empty nested QDicts in the original dict as well.  This patch changes
> this, so you can now use qdict_flatten(qdict_shallow_clone(dict)) to get
> a flattened copy without disturbing the original.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qobject/block-qdict.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
> index 0b2ae02627..7e0deb74c5 100644
> --- a/qobject/block-qdict.c
> +++ b/qobject/block-qdict.c
> @@ -114,19 +114,30 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *target, const char *prefix)
>  
>          /*
>           * Flatten non-empty QDict and QList recursively into @target,
> -         * copy other objects to @target
> +         * copy other objects to @target.
> +         * On the root level (if @qdict == @target), remove flattened
> +         * nested QDicts and QLists from @qdict.
> +         *
> +         * (Note that we do not need to remove entries from nested
> +         * dicts or lists.  Their reference count is decremented on
> +         * the root level, so there are no leaks.  In fact, if they
> +         * have a reference count greater than one, we are probably
> +         * well advised not to modify them altogether.)
>           */
>          if (dict_val && qdict_size(dict_val)) {
>              qdict_flatten_qdict(dict_val, target,
>                                  new_key ? new_key : entry->key);
> -            qdict_del(qdict, entry->key);
> +            if (target == qdict) {
> +                qdict_del(qdict, entry->key);
> +            }
>          } else if (list_val && !qlist_empty(list_val)) {
>              qdict_flatten_qlist(list_val, target,
>                                  new_key ? new_key : entry->key);
> -            qdict_del(qdict, entry->key);
> +            if (target == qdict) {
> +                qdict_del(qdict, entry->key);
> +            }
>          } else if (target != qdict) {
>              qdict_put_obj(target, new_key, qobject_ref(value));
> -            qdict_del(qdict, entry->key);
>          }
>  
>          g_free(new_key);

This simply makes sense, even without the later patch(es) that rely on
it.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
