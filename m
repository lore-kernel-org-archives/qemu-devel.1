Received: from eggs.gnu.org ([2001:4830:134:3::10]:57296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciq56-0000b5-FM
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciq55-0004u3-5n
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:17:16 -0500
Date: Tue, 28 Feb 2017 23:17:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170228221706.GI4090@noname.redhat.com>
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
	<1488317230-26248-25-git-send-email-armbru@redhat.com>
	<20170228220241.GD4090@noname.redhat.com>
	<87tw7e2cfg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tw7e2cfg.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 24/24] keyval: Support lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mdroth@linux.vnet.ibm.com

Am 28.02.2017 um 23:11 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 28.02.2017 um 22:27 hat Markus Armbruster geschrieben:
> >> Additionally permit non-negative integers as key components.  A
> >> dictionary's keys must either be all integers or none.  If all keys
> >> are integers, convert the dictionary to a list.  The set of keys must
> >> be [0,N].
> >> 
> >> Examples:
> >> 
> >> * list.1=goner,list.0=null,list.1=eins,list.2=zwei
> >>   is equivalent to JSON [ "null", "eins", "zwei" ]
> >> 
> >> * a.b.c=1,a.b.0=2
> >>   is inconsistent: a.b.c clashes with a.b.0
> >> 
> >> * list.0=null,list.2=eins,list.2=zwei
> >>   has a hole: list.1 is missing
> >> 
> >> Similar design flaw as for objects: there is no way to denote an empty
> >> list.  While interpreting "key absent" as empty list seems natural
> >> (removing a list member from the input string works when there are
> >> multiple ones, so why not when there's just one), it doesn't work:
> >> "key absent" already means "optional list absent", which isn't the
> >> same as "empty list present".
> >> 
> >> Update the keyval object visitor to use this a.0 syntax in error
> >> messages rather than the usual a[0].
> >> 
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >
> >> +/*
> >> + * Listify @cur recursively.
> >> + * Replace QDicts whose keys are all valid list indexes by QLists.
> >> + * @key_of_cur is the list of key fragments leading up to @cur.
> >> + * On success, return either @cur or its replacement.
> >> + * On failure, store an error through @errp and return NULL.
> >> + */
> >> +static QObject *keyval_listify(QDict *cur, GSList *key_of_cur, Error **errp)
> >> +{
> >> +    GSList key_node;
> >> +    bool has_index, has_member;
> >> +    const QDictEntry *ent;
> >> +    QDict *qdict;
> >> +    QObject *val;
> >> +    char *key;
> >> +    size_t nelt;
> >> +    QObject **elt;
> >> +    int index, max_index, i;
> >> +    QList *list;
> >> +
> >> +    key_node.next = key_of_cur;
> >> +
> >> +    /*
> >> +     * Recursively listify @cur's members, and figure out whether @cur
> >> +     * itself is to be listified.
> >> +     */
> >> +    has_index = false;
> >> +    has_member = false;
> >> +    for (ent = qdict_first(cur); ent; ent = qdict_next(cur, ent)) {
> >> +        if (key_to_index(ent->key, NULL) >= 0) {
> >> +            has_index = true;
> >> +        } else {
> >> +            has_member = true;
> >> +        }
> >> +
> >> +        qdict = qobject_to_qdict(ent->value);
> >> +        if (!qdict) {
> >> +            continue;
> >> +        }
> >> +
> >> +        key_node.data = ent->key;
> >> +        val = keyval_listify(qdict, &key_node, errp);
> >> +        if (!val) {
> >> +            return NULL;
> >> +        }
> >> +        if (val != ent->value) {
> >> +            qdict_put_obj(cur, ent->key, val);
> >> +        }
> >> +    }
> >> +
> >> +    if (has_index && has_member) {
> >> +        key = reassemble_key(key_of_cur);
> >> +        error_setg(errp, "Parameters '%s*' used inconsistently", key);
> >> +        g_free(key);
> >> +        return NULL;
> >> +    }
> >> +    if (!has_index) {
> >> +        return QOBJECT(cur);
> >> +    }
> >> +
> >> +    /* Copy @cur's values to @elt[] */
> >> +    nelt = qdict_size(cur) + 1; /* one extra, for use as sentinel */
> >> +    elt = g_new0(QObject *, nelt);
> >> +    max_index = -1;
> >> +    for (ent = qdict_first(cur); ent; ent = qdict_next(cur, ent)) {
> >> +        index = key_to_index(ent->key, NULL);
> >> +        assert(index >= 0);
> >> +        if (index > max_index) {
> >> +            max_index = index;
> >> +        }
> >> +        /*
> >> +         * We iterate @nelt times.  If we get one exceeding @nelt
> >> +         * here, we will put less than @nelt values into @elt[],
> >> +         * triggering the error in the next loop.
> >> +         */
> >> +        if ((size_t)index >= nelt) {
> >
> > I think this needs to be index >= nelt - 1 now...
> >
> >> +            continue;
> >> +        }
> >> +        /* Even though dict keys are distinct, indexes need not be */
> >> +        elt[index] = ent->value;
> >> +    }
> >> +
> >> +    /*
> >> +     * Make a list from @elt[], reporting any missing elements.
> >> +     * If we dropped an index >= nelt in the previous loop, this loop
> >> +     * will run into the sentinel and report index @nelt missing.
> >> +     */
> >> +    list = qlist_new();
> >> +    assert(!elt[nelt-1]);       /* need the sentinel to be null */
> >
> > ...or this assertion can fail.
> 
> Yup.
> 
> Appended fix squashed in and pushed to my public repo.  R-by?
> 
> >> +    for (i = 0; i < MIN(nelt, max_index + 1); i++) {
> >> +        if (!elt[i]) {
> >> +            key = reassemble_key(key_of_cur);
> >> +            error_setg(errp, "Parameter '%s%d' missing", key, i);
> >> +            g_free(key);
> >> +            g_free(elt);
> >> +            QDECREF(list);
> >> +            return NULL;
> >> +        }
> >> +        qobject_incref(elt[i]);
> >> +        qlist_append_obj(list, elt[i]);
> >> +    }
> >> +
> >> +    g_free(elt);
> >> +    return QOBJECT(list);
> >> +}
> >
> > Kevin
> 
> 
> diff --git a/util/keyval.c b/util/keyval.c
> index b57a742..c316aaa 100644
> --- a/util/keyval.c
> +++ b/util/keyval.c
> @@ -329,7 +329,7 @@ static QObject *keyval_listify(QDict *cur, GSList *key_of_cur, Error **errp)
>           * here, we will put less than @nelt values into @elt[],
>           * triggering the error in the next loop.
>           */
> -        if ((size_t)index >= nelt) {
> +        if ((size_t)index >= nelt - 1) {
>              continue;
>          }
>          /* Even though dict keys are distinct, indexes need not be */

With this squashed in:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
