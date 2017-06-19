Received: from eggs.gnu.org ([2001:4830:134:3::10]:60390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dMx9S-0008WE-9j
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dMx9R-00025j-D9
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:55:34 -0400
Date: Mon, 19 Jun 2017 15:55:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170619135525.GG6113@noname.redhat.com>
References: <20170614153102.9077-1-mreitz@redhat.com>
	<20170614153102.9077-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614153102.9077-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

Am 14.06.2017 um 17:31 hat Max Reitz geschrieben:
> This generic function (along with its implementations for different
> types) determines whether two QObjects are equal.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

> diff --git a/qobject/qdict.c b/qobject/qdict.c
> index 88e2ecd..2ed57ca 100644
> --- a/qobject/qdict.c
> +++ b/qobject/qdict.c
> @@ -410,6 +410,30 @@ void qdict_del(QDict *qdict, const char *key)
>  }
>  
>  /**
> + * qdict_is_equal(): Tests whether the two QDicts are equal

This should specify what equality means for QDicts: Do their entries
have to point to the same objects, or is it enough if the objects
compare equal? It seems you're trying to implement the lattter.

> + */
> +bool qdict_is_equal(const QObject *x, const QObject *y)
> +{
> +    const QDict *dict_x = qobject_to_qdict(x), *dict_y = qobject_to_qdict(y);
> +    const QDictEntry *e;
> +
> +    if (qdict_size(dict_x) != qdict_size(dict_y)) {
> +        return false;
> +    }
> +
> +    for (e = qdict_first(dict_x); e; e = qdict_next(dict_x, e)) {
> +        const QObject *obj_x = qdict_entry_value(e);
> +        const QObject *obj_y = qdict_get(dict_y, qdict_entry_key(e));
> +
> +        if (!qobject_is_equal(obj_x, obj_y)) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}

If I'm not mistaken, this doesn't actually check equality, but that the
entries of x are a subset of the entries of y.

> +/**
>   * qdict_destroy_obj(): Free all the memory allocated by a QDict
>   */
>  void qdict_destroy_obj(QObject *obj)
> diff --git a/qobject/qlist.c b/qobject/qlist.c
> index 86b60cb..b3033c6 100644
> --- a/qobject/qlist.c
> +++ b/qobject/qlist.c
> @@ -140,6 +140,31 @@ QList *qobject_to_qlist(const QObject *obj)
>  }
>  
>  /**
> + * qlist_is_equal(): Tests whether the two QLists are equal

Like for QDict, this isn't a complete description.

Your implementation seems to check that both lists contain objects that
compare equal at each index (i.e. order matters).

> + */
> +bool qlist_is_equal(const QObject *x, const QObject *y)
> +{
> +    const QList *list_x = qobject_to_qlist(x), *list_y = qobject_to_qlist(y);
> +    const QListEntry *entry_x, *entry_y;
> +
> +    entry_x = qlist_first(list_x);
> +    entry_y = qlist_first(list_y);
> +
> +    while (entry_x && entry_y) {
> +        if (!qobject_is_equal(qlist_entry_obj(entry_x),
> +                              qlist_entry_obj(entry_y)))
> +        {
> +            return false;
> +        }
> +
> +        entry_x = qlist_next(entry_x);
> +        entry_y = qlist_next(entry_y);
> +    }
> +
> +    return !entry_x && !entry_y;
> +}
> +
> +/**
>   * qlist_destroy_obj(): Free all the memory allocated by a QList
>   */

Kevin
