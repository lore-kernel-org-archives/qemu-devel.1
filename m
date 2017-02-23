Received: from eggs.gnu.org ([2001:4830:134:3::10]:55459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgppY-000295-F4
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgppW-0000KJ-4f
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:36:56 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-3-git-send-email-armbru@redhat.com>
	<5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
Date: Thu, 23 Feb 2017 10:36:42 +0100
In-Reply-To: <5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com> (Eric Blake's
	message of "Wed, 22 Feb 2017 14:17:26 -0600")
Message-ID: <878toxmeol.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/5] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/21/2017 03:01 PM, Markus Armbruster wrote:
>> keyval_parse() parses KEY=VALUE,... into a QDict.  Works like
>> qemu_opts_parse(), except:
>> 
>> * Returns a QDict instead of a QemuOpts (d'oh).
>> 
>> * It supports nesting, unlike QemuOpts: a KEY is split into key
>>   components at '.' (dotted key convention; the block layer does
>>   something similar on top of QemuOpts).  The key components are QDict
>>   keys, and the last one's value is updated to VALUE.
>> 
>> * Each key component may be up to 127 bytes long.  qemu_opts_parse()
>>   limits the entire key to 127 bytes.
>> 
>> * Overlong key components are rejected.  qemu_opts_parse() silently
>>   truncates them.
>> 
>> * Empty key components are rejected.  qemu_opts_parse() happily
>>   accepts empty keys.
>> 
>> * It does not store the returned value.  qemu_opts_parse() stores it
>>   in the QemuOptsList.
>> 
>> * It does not treat parameter "id" specially.  qemu_opts_parse()
>>   ignores all but the first "id", and fails when its value isn't
>>   id_wellformed(), or duplicate (a QemuOpts with the same ID is
>>   already stored).  It also screws up when a value contains ",id=".
>> 
>> I intend to grow this into a saner replacement for QemuOpts.  It'll
>> take time, though.
>> 
>> TODO Support lists
>> 
>> TODO Function comment is missing.
>
> Hence still being RFC, and I won't give R-b, but will still review.
>
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>>  
>> +QDict *keyval_parse(const char *params, const char *implied_key,
>> +                    Error **errp);
>> +
>
>> +++ b/tests/test-keyval.c
>
>> +
>> +static void test_keyval_parse(void)
>> +{
>> +    Error *err = NULL;
>> +    QDict *qdict, *sub_qdict;
>> +    char long_key[129];
>> +    char *params;
>> +
>> +    /* Nothing */
>> +    qdict = keyval_parse("", NULL, &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 0);
>> +    QDECREF(qdict);
>> +
>> +    /* Empty key */
>> +    qdict = keyval_parse("=val", NULL, &err);
>> +    error_free_or_abort(&err);
>> +    g_assert(!qdict);
>> +
>> +    /* Empty key component */
>> +    qdict = keyval_parse(".", NULL, &err);
>> +    error_free_or_abort(&err);
>> +    g_assert(!qdict);
>> +    qdict = keyval_parse("key.", NULL, &err);
>> +    error_free_or_abort(&err);
>> +    g_assert(!qdict);
>
> Do you also want to test ".=" or "key.=" ?

For ".=", keyval_parse() balks at '.'  and doesn't look any further.
Same for any string starting with '.', '=', or ','.

For "key.=", it takes the exact same path as for "key.".  Same for
"key.." and "key.,".

My point is: coverage is fine as is.  Additional test cases aren't
exactly expensive, or course.  Want some?

>> +
>> +    /* Overlong key */
>> +    memset(long_key, 'a', 127);
>> +    long_key[127] = 'z';
>> +    long_key[128] = 0;
>> +    params = g_strdup_printf("k.%s=v", long_key);
>> +    qdict = keyval_parse(params + 2, NULL, &err);
>> +    error_free_or_abort(&err);
>> +    g_assert(!qdict);
>> +
>> +    /* Overlong key component */
>> +    qdict = keyval_parse(params, NULL, &err);
>> +    error_free_or_abort(&err);
>> +    g_assert(!qdict);
>> +    g_free(params);
>> +
>> +    /* Long key */
>> +    params = g_strdup_printf("k.%s=v", long_key + 1);
>> +    qdict = keyval_parse(params + 2, NULL, &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 1);
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, long_key + 1), ==, "v");
>> +    QDECREF(qdict);
>> +
>> +    /* Long key component */
>> +    qdict = keyval_parse(params, NULL, &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 1);
>> +    sub_qdict = qdict_get_qdict(qdict, "k");
>> +    g_assert(sub_qdict);
>> +    g_assert_cmpuint(qdict_size(sub_qdict), ==, 1);
>> +    g_assert_cmpstr(qdict_get_try_str(sub_qdict, long_key + 1), ==, "v");
>> +    QDECREF(qdict);
>> +    g_free(params);
>
> As mentioned in the commit message, this works when QemuOpts would have
> rejected it as overlong.  Good, in my opinion.

QemuOpts is even worse: it silently truncates.

>> +
>> +    /* Multiple keys, last one wins */
>> +    qdict = keyval_parse("a=1,b=2,,x,a=3", NULL, &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 2);
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "a"), ==, "3");
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "b"), ==, "2,x");
>> +    QDECREF(qdict);
>> +
>> +    /* Even when it doesn't in QemuOpts */
>> +    qdict = keyval_parse("id=foo,id=bar", NULL, &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 1);
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "id"), ==, "bar");
>> +    QDECREF(qdict);
>> +
>> +    /* Dotted keys */
>> +    qdict = keyval_parse("a.b.c=1,a.b.c=2,d=3", NULL, &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 2);
>> +    sub_qdict = qdict_get_qdict(qdict, "a");
>> +    g_assert(sub_qdict);
>> +    g_assert_cmpuint(qdict_size(sub_qdict), ==, 1);
>> +    sub_qdict = qdict_get_qdict(sub_qdict, "b");
>> +    g_assert(sub_qdict);
>> +    g_assert_cmpuint(qdict_size(sub_qdict), ==, 1);
>> +    g_assert_cmpstr(qdict_get_try_str(sub_qdict, "c"), ==, "2");
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "d"), ==, "3");
>> +    QDECREF(qdict);
>> +
>> +    /* Inconsistent dotted keys */
>> +    qdict = keyval_parse("a.b=1,a=2", NULL, &err);
>> +    error_free_or_abort(&err);
>> +    g_assert(!qdict);
>> +    qdict = keyval_parse("a.b=1,a.b.c=2", NULL, &err);
>> +    error_free_or_abort(&err);
>> +    g_assert(!qdict);
>
> Will probably need more tests for inconsistencies when you support arrays.

One step at a time.  I might even do arrays as a separate patch to ease
review.

>> +
>> +    /* Implied value */
>> +    qdict = keyval_parse("an,noaus,noaus=", NULL, &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 3);
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "an"), ==, "on");
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "aus"), ==, "off");
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "noaus"), ==, "");
>> +    QDECREF(qdict);
>
> Oh, so '$key' implies the same as '$key=true'; 'no$key' implies the same
> as '$key=false', and the presence of = is what changes an implicit bool
> (with magic 'no' prefix handling) into a full keyname.  Looks a bit
> weird, but it matches what QemuOpts does so we do need to keep that
> magic around.

I hate the 'no$key' sugar, and would love to get rid of it.  It makes
things ambiguous (thus confusing) for precious little gain: 'novocaine'
can mean 'novocaine=on' or 'vocaine=off'.  QemuOpts picks the latter,
even when a QemuOpt named 'novocaine' has been declared.

keyval_parse() is meant to behave like QemuOpts, so I'm reproducing this
bit of bad sugar, reluctantly.

>> +
>> +    /* Implied key */
>> +    qdict = keyval_parse("an,noaus,noaus=", "implied", &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 3);
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "an");
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "aus"), ==, "off");
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "noaus"), ==, "");
>> +    QDECREF(qdict);
>> +
>> +    /* Trailing comma is ignored */
>> +    qdict = keyval_parse("x=y,", NULL,  &error_abort);
>
> Why two spaces here?

Editing accident, will fix.

>> +    g_assert_cmpuint(qdict_size(qdict), ==, 1);
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "x"), ==, "y");
>> +    QDECREF(qdict);
>
> Nice. Too bad JSON can't be as forgiving about trailing commas.
>
>> +
>> +    /* Except when it isn't */
>> +    qdict = keyval_parse(",", NULL,  &err);
>
> Again, why two spaces? (I'll quit pointing it out, if there's more)

I'll search for it.

Intentional deviation from QemuOpts, by the way: QemuOpts interprets ","
as key "" with value "on".  I find that too ridiculous to copy.  Hmm,
should mention it in the commit message.

>> +    error_free_or_abort(&err);
>> +    g_assert(!qdict);
>
> Question: what happens with:
>
> keyval_parse(",", "implied", &err)
>
> Should that be the same as:
>
> keyval_parse("implied=,", NULL, &err)
>
> which in turn is the same as:
>
> keyval_parse("implied=", NULL, &err)

That's how it behaves now.  Matches QemuOpts.

I don't like it, because keyval_parse(",", NULL, &err) fails.  QemuOpts
doesn't (see above).  Hmm.

I'll add a test case.

> Should you update "test-qemu-opts: Cover qemu_opts_parse()" to do a
> QemuOpts counterpart of this question?

Yes, the two tests should be kept in sync.

>> +
>> +    /* Value containing ,id= not misinterpreted as QemuOpts does */
>> +    qdict = keyval_parse("x=,,id=bar", NULL,  &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 1);
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "x"), ==, ",id=bar");
>> +    QDECREF(qdict);
>
> Yes, definitely better than QemuOpts' wart.

"Fortunately", that wart isn't just ugly, but also buggy, which I feel
gives me license not reproduce it in keyval_parse().

>> +
>> +    /* Anti-social ID is left to caller */
>> +    qdict = keyval_parse("id=666", NULL, &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 1);
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "id"), ==, "666");
>> +    QDECREF(qdict);
>
> Nice to compare this to your earlier patch on enhancing QemuOpts tests
> (your reminder of my chuckle on the "anti-social ID" on that patch was
> worth it).  That test had:
>
> +    /* TODO Cover .merge_lists = true */
>
> which matches this RFC's TODO for adding list support;

Not really.

Normally, each qemu_opts_parse() creates a new QemuOpts.  Fails when a
QemuOpts with the same ID already exists.

With .mergelists = true, don't fail, but reuse the existing QemuOpts,
i.e. append the new settings.  Do this even without an ID, i.e. you can
have at most one QemuOpts without an ID then.

keyval_parse() doesn't attempt to support this part of QemuOpts for now.

Lists in the sense of this RFC's TODO are something else, namely list
values.  QemuOpts sort of supports them via repeated keys.
Implementation accident that got pressed into service.

keyval_parse() doesn't attempt to support that part of QemuOpts for now.

However, test-qemu-opts.c needs a TODO Cover repeated keys.

>                                                        it also had:
>
> +    /* Unknown key */
>
> which is not needed here, since this focuses on just the parsing rather
> than also the mapping into recognized QemuOpt key names (the counterpart
> here would be that the caller would flag extra keys by using a strict
> qobject-input parse on the resulting QObject).

Exactly.

keyval_parse() is like QemuOpts with an empty .desc[] (any key goes).
Making sense of the keys and parsing (string) values according to their
key is left for later.

>> +++ b/util/keyval.c
>> @@ -0,0 +1,150 @@
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
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qapi/qmp/qstring.h"
>> +#include "qemu/option.h"
>> +
>> +/* TODO Support lists */
>> +
>> +static QObject *keyval_parse_put(QDict *qdict, const char *key, QString *value,
>> +                                 Error **errp)
>> +{
>> +    QObject *old, *new;
>> +
>> +    old = qdict_get(qdict, key);
>> +    if (old) {
>> +        if (qobject_type(old) != (value ? QTYPE_QSTRING : QTYPE_QDICT)) {
>> +            error_setg(errp, "Option key '%s' used inconsistently", key);
>> +            return NULL;
>> +        }
>> +        if (!value) {
>> +            return old;
>> +        }
>> +        new = QOBJECT(value);
>
> So if we've already seen key, it is either a subdict (and we return the
> existing sub-dict to add more into it) or a string (and we replace the
> old string with the new)...
>
>> +    } else {
>> +        new = QOBJECT(value) ?: QOBJECT(qdict_new());
>
> ...and if we haven't seen key, we either add the string or a new subdict...
>
>> +    }
>> +    qdict_put_obj(qdict, key, new);
>> +    return new;
>
> ...either way, we are returning the current value of the key within
> qdict to the caller.
>
> Comments may indeed help, because it took me a couple of reads before I
> saw what was going on, but the function looks sane.

I'll try to make it easier to understand.

>> +}
>> +
>> +static const char *keyval_parse_one(QDict *qdict, const char *params,
>> +                                    const char *implied_key,
>> +                                    Error **errp)
>> +{
>> +    QDict *cur = qdict;
>> +    QObject *next;
>> +    const char *s, *key;
>> +    size_t len;
>> +    char key_buf[128];
>> +    QString *val;
>> +
>> +    s = params;
>> +    len = strcspn(s, ".=,");
>> +    if (implied_key && (s[len] == ',' || !s[len])) {
>> +        /* Desugar implied key */
>> +        key = implied_key;
>
> Should keyval_parse("=foo", "implied", &err) also behave the same as
> keyval_parse("implied==foo", NULL, &err) (resulting in "=foo" as the value)?

QemuOpts interprets this as empty key with value "foo".

keyval_parse() does the same, but rejects empty keys.

I'll add a test case to both.

>> +    } else {
>> +        key_buf[0] = 0;
>> +        for (;;) {
>> +            if (!len) {
>> +                error_setg(errp, "Invalid option key");
>> +                return NULL;
>> +            }
>> +            if (len >= sizeof(key_buf)) {
>> +                error_setg(errp, "Option key component '%.*s' is too long",
>> +                           (int)len, s);
>> +                return NULL;
>> +            }
>> +
>> +            if (key_buf[0]) {
>> +                next = keyval_parse_put(cur, key_buf, NULL, errp);
>> +                if (!next) {
>> +                    return NULL;
>> +                }
>> +                cur = qobject_to_qdict(next);
>> +                assert(cur);
>> +            }
>> +
>> +            memcpy(key_buf, s, len);
>> +            key_buf[len] = 0;
>> +            s += len;
>> +            if (*s != '.') {
>> +                break;
>> +            }
>> +            s++;
>> +            len = strcspn(s, ".=,");
>> +        }
>> +        key = key_buf;
>> +
>> +        if (*s == '=') {
>> +            s++;
>
> I'm not sure this condition is correct, if there is an implied key where
> we want the value string to start with "=".  Or are we requiring that
> starting a value with = requires that we can't use implicit key?

The loop eats a key, which extends to the first '=', ',' or '\0'.  Empty
keys are rejected.

Note that QemuOpts treats double comma specially only in *values*, not
in keys.  So does keyval_parse().  Therefore, stopping at the first ','
is correct.

When we get to the conditional, @s points to a '=', ',' or '\0' behind a
non-empty key.  Two cases: it points to "=VALUE" (condition is true), or
no value follows (condition is false).

> Missing testsuite coverage, I think?

What test cases do you have in mind beyond "=foo"?

>> +        } else {
>> +            /*
>> +             * Desugar implied value: it's "on", except when @key
>> +             * starts with "no", it's "off".  Thus, key "novocaine"
>> +             * gets desugard to "vocaine=off", not to "novocaine=on".
>> +             * If sugar isn't bad enough for you, make it ambiguous...
>
> So if I get this right,

No, the QemuOpts sugar works differently:

> keyval_parse(",", "implied", &err) => "implied" = "on"

No, it's "implied" = ""

> keyval_parse(",", "noimplied", &err) => "implied" = "off"

"noimplied" = ""

> keyval_parse("on", "noimplied", &err) => "noimplied" = "on"

Yes.

> Eww. Not necessarily your fault.  But maybe this is our chance to tweak
> it to be slightly different?

QemuOpts is a diabetic.

Hard rule for the initial version of keyval_parse(): no new sugar.

Soft rule: all the old sugar.

"Soft" means we can consider dropping really bad / confusing / useless
old sugar.

>> +             */
>> +            if (*s == ',')
>> +                s++;
>
> Should this account for leading ",," with implied key (meaning a value
> that starts with a comma)?  Or is that another thing where a leading
> comma in a value cannot be mixed with an implied key?

You're driving me nuts :)  Or actually, QemuOpts is driving us both
nuts.

Remember that double comma is only special in values.  We're looking at
a key here.  Implied key never gets here, it runs the other arm of the
outermost conditional.

I'll add a test case for ",,,a=1".  Quick quiz, what does it mean?
Solution at [*].

>> +            if (!strncmp(key, "no", 2)) {
>> +                key += 2;
>> +                val = qstring_from_str("off");
>> +            } else {
>> +                val = qstring_from_str("on");
>> +            }
>> +            goto got_val;
>> +        }
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
>> +got_val:
>> +    if (!keyval_parse_put(cur, key, val, errp)) {
>> +        return NULL;
>> +    }
>> +    return s;
>> +}
>
> You managed to make this fairly compact for how hairy it is!  I don't

Thanks!

> know how lists will impact it (well, maybe you'll have integral keys on
> this pass, and then a second pass that turns integral keys into list
> members...)

Wait and see :)

>> +
>> +/* TODO function comment */
>> +QDict *keyval_parse(const char *params, const char *implied_key,
>> +                    Error **errp)
>> +{
>> +    QDict *qdict = qdict_new();
>> +    const char *s;
>
> Should we do any sort of validation on implied_key, such as making sure
> it is non-NULL and non-empty, does not contain ".=,", looks like a
> well-formed id?  Or is that merely documentation that a caller that
> passes a garbage implied_key gets a garbage QDict result?

I absolutely intend to restrict keys according to QAPI naming rules, as
discussed in "Non-flat command line option argument syntax".

>> +
>> +    s = params;
>> +    while (*s) {
>> +        s = keyval_parse_one(qdict, s, implied_key, errp);
>> +        if (!s) {
>> +            QDECREF(qdict);
>> +            return NULL;
>> +        }
>> +        implied_key = NULL;
>> +    }
>> +
>> +    return qdict;
>> +}
>> 

Thanks a lot for your review, it was timely and useful!


[*] Quick quiz solution:

    "implied" = ","
    "a"       = "1"
