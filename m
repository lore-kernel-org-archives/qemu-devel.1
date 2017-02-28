Received: from eggs.gnu.org ([2001:4830:134:3::10]:50431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cinPF-0001LT-La
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cinPD-0005Ni-VZ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:25:53 -0500
Date: Tue, 28 Feb 2017 20:25:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170228192543.GZ4090@noname.redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-25-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488194450-28056-25-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 24/24] keyval: Support lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com

Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
> Additionally permit non-negative integers as key components.  A
> dictionary's keys must either be all integers or none.  If all keys
> are integers, convert the dictionary to a list.  The set of keys must
> be [0,N].
> 
> Examples:
> 
> * list.1=goner,list.0=null,list.1=eins,list.2=zwei
>   is equivalent to JSON [ "null", "eins", "zwei" ]
> 
> * a.b.c=1,a.b.0=2
>   is inconsistent: a.b.c clashes with a.b.0
> 
> * list.0=null,list.2=eins,list.2=zwei
>   has a hole: list.1 is missing
> 
> Similar design flaw as for objects: there is now way to denote an

s/now/no/

> empty list.  While interpreting "key absent" as empty list seems
> natural (removing a list member from the input string works when there
> are multiple ones, so why not when there's just one), it doesn't work:
> "key absent" already means "optional list absent", which isn't the
> same as "empty list present".
> 
> Update the keyval object visitor to use this a.0 syntax in error
> messages rather than the usual a[0].
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

valgrind finds a quite a few leaks while running tests/test-keyval. Not
sure if I caught all of them, maybe you want to just run it yourself.

>  qapi/qobject-input-visitor.c |   5 +-
>  tests/test-keyval.c          | 117 ++++++++++++++++++++++++++++
>  util/keyval.c                | 177 ++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 286 insertions(+), 13 deletions(-)
> 
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index 1d7b420..4c159e0 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -41,6 +41,7 @@ struct QObjectInputVisitor {
>  
>      /* Root of visit at visitor creation. */
>      QObject *root;
> +    bool keyval;                /* Assume @root made with keyval_parse() */

Who sets this? I can't seem to find it in this patch, and it's the final
patch of the series.

>      /* Stack of objects being visited (all entries will be either
>       * QDict or QList). */
> @@ -73,7 +74,9 @@ static const char *full_name_nth(QObjectInputVisitor *qiv, const char *name,
>              g_string_prepend(qiv->errname, name ?: "<anonymous>");
>              g_string_prepend_c(qiv->errname, '.');
>          } else {
> -            snprintf(buf, sizeof(buf), "[%u]", so->index);
> +            snprintf(buf, sizeof(buf),
> +                     qiv->keyval ? ".%u" : "[%u]",
> +                     so->index);
>              g_string_prepend(qiv->errname, buf);
>          }
>          name = so->name;

> diff --git a/util/keyval.c b/util/keyval.c
> index 1170dad..3621f28 100644
> --- a/util/keyval.c
> +++ b/util/keyval.c
> @@ -21,10 +21,12 @@
>   *
>   * Semantics defined by reduction to JSON:
>   *
> - *   key-vals defines a tree of objects rooted at R
> + *   key-vals is a tree of objects and arrays rooted at object R
>   *   where for each key-val = key-fragment . ... = val in key-vals
>   *       R op key-fragment op ... = val'
> - *       where (left-associative) op is member reference L.key-fragment
> + *       where (left-associative) op is
> + *                 array subscript L[key-fragment] for numeric key-fragment
> + *                 member reference L.key-fragment otherwise
>   *             val' is val with ',,' replaced by ','
>   *   and only R may be empty.
>   *
> @@ -34,16 +36,16 @@
>   *   doesn't have one, because R.a must be an object to satisfy a.b=1
>   *   and a string to satisfy a=2.
>   *
> - * Key-fragments must be valid QAPI names.
> + * Key-fragments must be valid QAPI names or consist only of digits.
>   *
>   * The length of any key-fragment must be between 1 and 127.
>   *
> - * Design flaw: there is no way to denote an empty non-root object.
> - * While interpreting "key absent" as empty object seems natural
> + * Design flaw: there is no way to denote an empty array or non-root
> + * object.  While interpreting "key absent" as empty seems natural
>   * (removing a key-val from the input string removes the member when
>   * there are more, so why not when it's the last), it doesn't work:
> - * "key absent" already means "optional object absent", which isn't
> - * the same as "empty object present".
> + * "key absent" already means "optional object/array absent", which
> + * isn't the same as "empty object/array present".
>   *
>   * Additional syntax for use with an implied key:
>   *
> @@ -51,17 +53,43 @@
>   *   val-no-key   = / [^,]* /
>   *
>   * where no-key is syntactic sugar for implied-key=val-no-key.
> - *
> - * TODO support lists
>   */
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qapi/util.h"
> +#include "qemu/cutils.h"
>  #include "qemu/option.h"
>  
>  /*
> + * Convert @key to a list index.
> + * Convert all leading digits to a (non-negative) number, capped at
> + * INT_MAX.
> + * If @end is non-null, assign a pointer to the first character after
> + * the number to *@end.
> + * Else, fail if any characters follow.
> + * On success, return the converted number.
> + * On failure, return a negative value.
> + * Note: since only digits are converted, no two keys can map to the
> + * same number, except by overflow to INT_MAX.
> + */
> +static int key_to_index(const char *key, const char **end)
> +{
> +    int ret;
> +    unsigned long index;
> +
> +    if (*key < '0' || *key > '9') {
> +        return -EINVAL;
> +    }
> +    ret = qemu_strtoul(key, end, 10, &index);
> +    if (ret) {
> +        return ret == -ERANGE ? INT_MAX : ret;
> +    }
> +    return index <= INT_MAX ? index : INT_MAX;
> +}
> +
> +/*
>   * Ensure @cur maps @key_in_cur the right way.
>   * If @value is null, it needs to map to a QDict, else to this
>   * QString.
> @@ -113,7 +141,7 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
>                                      const char *implied_key,
>                                      Error **errp)
>  {
> -    const char *key, *key_end, *s;
> +    const char *key, *key_end, *s, *end;
>      size_t len;
>      char key_in_cur[128];
>      QDict *cur;
> @@ -137,8 +165,13 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
>      cur = qdict;
>      s = key;
>      for (;;) {
> -        ret = parse_qapi_name(s, false);
> -        len = ret < 0 ? 0 : ret;
> +        /* Want a key index (unless it's first) or a QAPI name */
> +        if (s != key && key_to_index(s, &end) >= 0) {
> +            len = end - s;
> +        } else {
> +            ret = parse_qapi_name(s, false);
> +            len = ret < 0 ? 0 : ret;
> +        }
>          assert(s + len <= key_end);
>          if (!len || (s + len < key_end && s[len] != '.')) {
>              assert(key != implied_key);
> @@ -205,6 +238,119 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
>      return s;
>  }
>  
> +static char *reassemble_key(GSList *key)
> +{
> +    GString *s = g_string_new("");
> +    GSList *p;
> +
> +    for (p = key; p; p = p->next) {
> +        g_string_prepend_c(s, '.');
> +        g_string_prepend(s, (char *)p->data);
> +    }
> +
> +    return g_string_free(s, FALSE);
> +}
> +
> +/*
> + * Listify @cur recursively.
> + * Replace QDicts whose keys are all valid list indexes by QLists.
> + * @key_of_cur is the list of key fragments leading up to @cur.
> + * On success, return either @cur or its replacement.
> + * On failure, store an error through @errp and return NULL.
> + */
> +static QObject *keyval_listify(QDict *cur, GSList *key_of_cur, Error **errp)
> +{
> +    GSList key_node;
> +    bool has_index, has_member;
> +    const QDictEntry *ent;
> +    QDict *qdict;
> +    QObject *val;
> +    char *key;
> +    size_t nelt;
> +    QObject **elt;
> +    int index, i;
> +    QList *list;
> +
> +    key_node.next = key_of_cur;
> +
> +    /*
> +     * Recursively listify @cur's members, and figure out whether @cur
> +     * itself is to be listified.
> +     */
> +    has_index = false;
> +    has_member = false;
> +    for (ent = qdict_first(cur); ent; ent = qdict_next(cur, ent)) {
> +        if (key_to_index(ent->key, NULL) >= 0) {
> +            has_index = true;
> +        } else {
> +            has_member = true;
> +        }
> +
> +        qdict = qobject_to_qdict(ent->value);
> +        if (!qdict) {
> +            continue;
> +        }
> +
> +        key_node.data = ent->key;
> +        val = keyval_listify(qdict, &key_node, errp);
> +        if (!val) {
> +            return NULL;
> +        }
> +        if (val != ent->value) {
> +            qdict_put_obj(cur, ent->key, val);
> +        }
> +    }
> +
> +    if (has_index && has_member) {
> +        key = reassemble_key(key_of_cur);
> +        error_setg(errp, "Parameters '%s*' used inconsistently", key);
> +        g_free(key);
> +        return NULL;
> +    }
> +    if (!has_index) {
> +        return QOBJECT(cur);
> +    }
> +
> +    /* Copy @cur's values to @elt[] */
> +    nelt = qdict_size(cur);
> +    elt = g_new0(QObject *, nelt);

This doesn't seem to be freed.

> +    for (ent = qdict_first(cur); ent; ent = qdict_next(cur, ent)) {
> +        index = key_to_index(ent->key, NULL);
> +        assert(index >= 0);
> +        /*
> +         * We iterate @nelt times.  Because the dictionary keys are
> +         * distinct, the indexes are also distinct (key_to_index()
> +         * ensures it).

Really? What about leading zeros?

> +                        If we get one exceeding @nelt here, we will
> +         * leave a hole in @elt[], triggering the error in the next
> +         * loop.
> +         *
> +         * Well, I lied.  key_to_index() can return INT_MAX multiple
> +         * times, but INT_MAX surely exceeds @nelt.
> +         */
> +        if ((size_t)index >= nelt) {
> +            continue;
> +        }
> +        assert(!elt[index]);
> +        elt[index] = ent->value;
> +        qobject_incref(elt[index]);

We forget to decref this in error cases. Maybe it would be better to
only incref immediately before qlist_append_obj().

> +    }
> +
> +    /* Make a list from @elt[] */
> +    list = qlist_new();
> +    for (i = 0; i < nelt; i++) {
> +        if (!elt[i]) {
> +            key = reassemble_key(key_of_cur);
> +            error_setg(errp, "Parameter '%s%d' missing", key, i);
> +            g_free(key);
> +            QDECREF(list);
> +            return NULL;
> +        }
> +        qlist_append_obj(list, elt[i]);
> +    }
> +
> +    return QOBJECT(list);
> +}
> +
>  /*
>   * Parse @params in QEMU's traditional KEY=VALUE,... syntax.
>   * If @implied_key, the first KEY= can be omitted.  @implied_key is
> @@ -216,6 +362,7 @@ QDict *keyval_parse(const char *params, const char *implied_key,
>                      Error **errp)
>  {
>      QDict *qdict = qdict_new();
> +    QObject *listified;
>      const char *s;
>  
>      s = params;
> @@ -228,5 +375,11 @@ QDict *keyval_parse(const char *params, const char *implied_key,
>          implied_key = NULL;
>      }
>  
> +    listified = keyval_listify(qdict, NULL, errp);
> +    if (!listified) {
> +        QDECREF(qdict);
> +        return NULL;
> +    }
> +    assert(listified == QOBJECT(qdict));
>      return qdict;
>  }

Kevin
