Received: from eggs.gnu.org ([2001:4830:134:3::10]:44197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fSlOB-00021r-Bi
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fSlOA-0001At-37
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:39:19 -0400
Date: Tue, 12 Jun 2018 17:39:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180612153909.GG4355@localhost.localdomain>
References: <20180612125821.4229-1-armbru@redhat.com>
	<20180612125821.4229-13-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612125821.4229-13-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/18] block-qdict: Clean up
 qdict_crumple() a bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

Am 12.06.2018 um 14:58 hat Markus Armbruster geschrieben:
> When you mix scalar and non-scalar keys, whether you get an "already
> set as scalar" or an "already set as dict" error depends on qdict
> iteration order.  Neither message makes much sense.  Replace by
> ""Cannot mix scalar and non-scalar keys".  This is similar to the
> message we get for mixing list and non-list keys.
> 
> I find qdict_crumple()'s first loop hard to understand.  Rearrange it
> and add a comment.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

To be honest, I found the old version of the loop more obvious.

>  qobject/block-qdict.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
> index a4e1c8d08f..35e9052816 100644
> --- a/qobject/block-qdict.c
> +++ b/qobject/block-qdict.c
> @@ -403,7 +403,7 @@ static int qdict_is_list(QDict *maybe_list, Error **errp)
>  QObject *qdict_crumple(const QDict *src, Error **errp)
>  {
>      const QDictEntry *ent;
> -    QDict *two_level, *multi_level = NULL;
> +    QDict *two_level, *multi_level = NULL, *child_dict;
>      QObject *dst = NULL, *child;
>      size_t i;
>      char *prefix = NULL;
> @@ -422,29 +422,29 @@ QObject *qdict_crumple(const QDict *src, Error **errp)
>          }
>  
>          qdict_split_flat_key(ent->key, &prefix, &suffix);
> -
>          child = qdict_get(two_level, prefix);
> +        child_dict = qobject_to(QDict, child);
> +
> +        if (child) {
> +            /*
> +             * An existing child must be a dict and @ent must be a
> +             * dict member (i.e. suffix not null), or else @ent
> +             * clashes.
> +             */
> +            if (!child_dict || !suffix) {
> +                error_setg(errp,
> +                           "Cannot mix scalar and non-scalar keys");
> +                goto error;
> +            }
> +        } else if (suffix) {
> +            child_dict = qdict_new();
> +            qdict_put(two_level, prefix, child_dict);
> +        } else {
> +            qdict_put_obj(two_level, prefix, qobject_ref(ent->value));
> +        }

At least, can you please move the else branch to the if below so that
the addition of the new entry is symmetrical for both scalars and dicts?
As the code is, it mixes the conflict check, creation of the child dict
and addition of scalars (but not to the child dict) in a weird way in a
single if block.

Or maybe organise it like this:

if (child && !(child_dict && suffix)) {
    error
}

if (suffix) {
    if (!child_dict) {
        create it
        add it to two_level
    }
    add entry to child_dict
} else {
    add entry to two_level
}

Kevin
