Received: from eggs.gnu.org ([2001:4830:134:3::10]:56209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciklo-0006QA-LI
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cikln-0002uN-4y
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:37:00 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-4-git-send-email-armbru@redhat.com>
	<20170228154836.GF4090@noname.redhat.com>
Date: Tue, 28 Feb 2017 17:36:50 +0100
In-Reply-To: <20170228154836.GF4090@noname.redhat.com> (Kevin Wolf's message
	of "Tue, 28 Feb 2017 16:48:36 +0100")
Message-ID: <87innunufx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 03/24] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
>> keyval_parse() parses KEY=VALUE,... into a QDict.  Works like
>> qemu_opts_parse(), except:
>> 
>> * Returns a QDict instead of a QemuOpts (d'oh).
>> 
>> * Supports nesting, unlike QemuOpts: a KEY is split into key
>>   fragments at '.' (dotted key convention; the block layer does
>>   something similar on top of QemuOpts).  The key fragments are QDict
>>   keys, and the last one's value is updated to VALUE.
>> 
>> * Each key fragment may be up to 127 bytes long.  qemu_opts_parse()
>>   limits the entire key to 127 bytes.
>> 
>> * Overlong key fragments are rejected.  qemu_opts_parse() silently
>>   truncates them.
>> 
>> * Empty key fragments are rejected.  qemu_opts_parse() happily
>>   accepts empty keys.
>> 
>> * It does not store the returned value.  qemu_opts_parse() stores it
>>   in the QemuOptsList.
>> 
>> * It does not treat parameter "id" specially.  qemu_opts_parse()
>>   ignores all but the first "id", and fails when its value isn't
>>   id_wellformed(), or duplicate (a QemuOpts with the same ID is
>>   already stored).  It also screws up when a value contains ",id=".
>
> This is important to keep in mind, callers need to explicitly check
> validity of the "id" key themselves.

Good point.  Come to think of it, I'm not sure I did %-}

>> * Implied value is not supported.  qemu_opts_parse() desugars "foo" to
>>   "foo=on", and "nofoo" to "foo=off".
>> 
>> * An implied key's value can't be empty, and can't contain ','.
>> 
>> I intend to grow this into a saner replacement for QemuOpts.  It'll
>> take time, though.
>> 
>> Note: keyval_parse() provides no way to do lists, and its key syntax
>> is incompatible with the __RFQDN_ prefix convention for downstream
>> extensions, because it blindly splits at '.', even in __RFQDN_.  Both
>> issues will be addressed later in the series.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>> diff --git a/util/keyval.c b/util/keyval.c
>> new file mode 100644
>> index 0000000..3904c39
>> --- /dev/null
>> +++ b/util/keyval.c
>> @@ -0,0 +1,228 @@
>> +/*
>> + * Parsing KEY=VALUE,... strings
>> + *
>> + * Copyright (C) 2017 Red Hat Inc.
>> + *
>> + * Authors:
>> + *  Markus Armbruster <armbru@redhat.com>,
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +/*
>> + * KEY=VALUE,... syntax:
>> + *
>> + *   key-vals     = [ key-val { ',' key-vals } ]
>> + *   key-val      = key '=' val
>> + *   key          = key-fragment { '.' key-fragment }
>> + *   key-fragment = / [^=,.]* /
>> + *   val          = { / [^,]* / | ',,' }
>> + *
>> + * Semantics defined by reduction to JSON:
>> + *
>> + *   key-vals defines a tree of objects rooted at R
>> + *   where for each key-val = key-fragment . ... = val in key-vals
>> + *       R op key-fragment op ... = val'
>> + *       where (left-associative) op is member reference L.key-fragment
>
> Maybe it's just me, but I can't say that I fully understand what these
> last two lines are supposed to tell me.

Okay, I'll try to clarify.

Last patch amends this part for lists.

>> + *             val' is val with ',,' replaced by ','
>> + *   and only R may be empty.
>> + *
>> + *   Duplicate keys are permitted; all but the last one are ignored.
>> + *
>> + *   The equations must have a solution.  Counter-example: a.b=1,a=2
>> + *   doesn't have one, because R.a must be an object to satisfy a.b=1
>> + *   and a string to satisfy a=2.
>> + *
>> + * The length of any key-fragment must be between 1 and 127.
>> + *
>> + * Design flaw: there is no way to denote an empty non-root object.
>> + * While interpreting "key absent" as empty object seems natural
>> + * (removing a key-val from the input string removes the member when
>> + * there are more, so why not when it's the last), it doesn't work:
>> + * "key absent" already means "optional object absent", which isn't
>> + * the same as "empty object present".
>> + *
>> + * Additional syntax for use with an implied key:
>> + *
>> + *   key-vals-ik  = val-no-key [ ',' key-vals ]
>> + *   val-no-key   = / [^,]* /
>> + *
>> + * where no-key is syntactic sugar for implied-key=val-no-key.
>
> s/no-key/val-no-key/ ?

Yes.

>> + *
>> + * TODO support lists
>> + * TODO support key-fragment with __RFQDN_ prefix (downstream extensions)
>
> Worth another TODO comment for implied values that contain a comma? The
> current restriction feels a bit artificial.

My reasons for the restriction are perhaps best explained with an
example.  Consider params = "a,,,b".

qemu_opts_parse(opt_list, params, true) splits into comma-separated
parts like this:

    #   part    key       value
    0   "a,,"   implied   "a,"
    1   "b"     "b"       "on"

qemu_opts_parse(list, params, false) like this:

    #   part    key       value
    0   "a"     "a"       "on"
    1   ""      ""        "on"
    2   ""      ""        "on"
    3   "b"     "b"       "on"

The split of depends on the permit_abbrev argument!  I consider that
tasteless design.  Or rather I would if I could bring myself to believe
in the existence of a design here.

The big hammer to make *syntactic* analysis invariant of whether we have
an implied key is to outlaw ',' val-no-key.  That way, the leftmost part
of param can be isolated the same with and without implied key: it ends
at the first '=' or ','.

Perhaps a smaller hammer can be found, but right now I'm in no mood for
checking grammars for ambiguity :)

>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qapi/qmp/qstring.h"
>> +#include "qemu/option.h"
>> +
>> +/*
>> + * Ensure @cur maps @key_in_cur the right way.
>> + * If @value is null, it needs to map to a QDict, else to this
>> + * QString.
>> + * If @cur doesn't have @key_in_cur, put an empty QDict or @value,
>> + * respectively.
>> + * Else, if it needs to map to a QDict, and already does, do nothing.
>> + * Else, if it needs to map to this QString, and already maps to a
>> + * QString, replace it by @value.
>> + * Else, fail because we have conflicting needs on how to map
>> + * @key_in_cur.
>> + * Use @key up to @key_cursor to identify the key in error messages.
>> + * On success, return the mapped value.
>> + * On failure, store an error through @errp and return NULL.
>> + */
>> +static QObject *keyval_parse_put(QDict *cur,
>> +                                 const char *key_in_cur, QString *value,
>> +                                 const char *key, const char *key_cursor,
>> +                                 Error **errp)
>> +{
>> +    QObject *old, *new;
>> +
>> +    old = qdict_get(cur, key_in_cur);
>> +    if (old) {
>> +        if (qobject_type(old) != (value ? QTYPE_QSTRING : QTYPE_QDICT)) {
>> +            error_setg(errp, "Parameters '%.*s.*' used inconsistently",
>> +                       (int)(key_cursor - key), key);
>> +            return NULL;
>> +        }
>> +        if (!value) {
>> +            return old;         /* already QDict, do nothing */
>> +        }
>> +        new = QOBJECT(value);   /* replacement */
>> +    } else {
>> +        new = QOBJECT(value) ?: QOBJECT(qdict_new());
>> +    }
>> +    qdict_put_obj(cur, key_in_cur, new);
>> +    return new;
>> +}
>> +
>> +/*
>> + * Parse one KEY=VALUE from @params, store result in @qdict.
>> + * The first fragment of KEY applies to @qdict.  Subsequent fragments
>> + * apply to nested QDicts, which are created on demand.  @implied_key
>> + * is as in keyval_parse().
>> + * On success, return a pointer to the next KEY=VALUE, or else to '\0'.
>> + * On failure, return NULL.
>> + */
>> +static const char *keyval_parse_one(QDict *qdict, const char *params,
>> +                                    const char *implied_key,
>> +                                    Error **errp)
>> +{
>> +    const char *key, *key_end, *s;
>> +    size_t len;
>> +    char key_in_cur[128];
>> +    QDict *cur;
>> +    QObject *next;
>> +    QString *val;
>> +
>> +    key = params;
>> +    len = strcspn(params, "=,");
>> +    if (implied_key && len && key[len] != '=') {
>> +        /* Desugar implied key */
>> +        key = implied_key;
>> +        len = strlen(implied_key);
>> +    }
>> +    key_end = key + len;
>> +
>> +    /*
>> +     * Loop over key fragments: @s points to current fragment, it
>> +     * applies to @cur.  @key_in_cur[] holds the previous fragment.
>> +     */
>> +    cur = qdict;
>> +    s = key;
>> +    for (;;) {
>> +        for (len = 0; s + len < key_end && s[len] != '.'; len++) {
>> +        }
>> +        if (!len) {
>> +            assert(key != implied_key);
>> +            error_setg(errp, "Invalid parameter '%.*s'",
>> +                       (int)(key_end - key), key);
>> +            return NULL;
>> +        }
>> +        if (len >= sizeof(key_in_cur)) {
>> +            assert(key != implied_key);
>> +            error_setg(errp, "Parameter%s '%.*s' is too long",
>> +                       s != key || s + len != key_end ? " fragment" : "",
>> +                       (int)len, s);
>> +            return NULL;
>> +        }
>> +
>> +        if (s != key) {
>> +            next = keyval_parse_put(cur, key_in_cur, NULL,
>> +                                    key, s - 1, errp);
>> +            if (!next) {
>> +                return NULL;
>> +            }
>> +            cur = qobject_to_qdict(next);
>> +            assert(cur);
>> +        }
>> +
>> +        memcpy(key_in_cur, s, len);
>> +        key_in_cur[len] = 0;
>> +        s += len;
>> +
>> +        if (*s != '.') {
>> +            break;
>> +        }
>> +        s++;
>> +    }
>> +
>> +    if (key == implied_key) {
>> +        assert(!*s);
>> +        s = params;
>> +    } else {
>> +        if (*s != '=') {
>> +            error_setg(errp, "Expected '=' after parameter '%.*s'",
>> +                       (int)(s - key), key);
>> +            return NULL;
>> +        }
>> +        s++;
>> +    }
>> +
>> +    val = qstring_new();
>> +    for (;;) {
>> +        if (!*s) {
>> +            break;
>> +        } else if (*s == ',') {
>> +            s++;
>> +            if (*s != ',') {
>> +                break;
>> +            }
>> +        }
>> +        qstring_append_chr(val, *s++);
>> +    }
>> +
>> +    if (!keyval_parse_put(cur, key_in_cur, val, key, key_end, errp)) {
>> +        return NULL;
>
> This leaks val.

Will fix, thanks!

>> +    }
>> +    return s;
>> +}
>
> Kevin
