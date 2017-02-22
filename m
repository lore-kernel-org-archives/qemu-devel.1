Received: from eggs.gnu.org ([2001:4830:134:3::10]:57051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgdM1-00028X-JW
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 15:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgdLz-00006f-76
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 15:17:37 -0500
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
Date: Wed, 22 Feb 2017 14:17:26 -0600
MIME-Version: 1.0
In-Reply-To: <1487710908-26356-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HDIl6W44esF6XcToS5tAvH711FhfLs9qE"
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/5] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HDIl6W44esF6XcToS5tAvH711FhfLs9qE
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org
Message-ID: <5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/5] keyval: New keyval_parse()
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
 <1487710908-26356-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1487710908-26356-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 03:01 PM, Markus Armbruster wrote:
> keyval_parse() parses KEY=3DVALUE,... into a QDict.  Works like
> qemu_opts_parse(), except:
>=20
> * Returns a QDict instead of a QemuOpts (d'oh).
>=20
> * It supports nesting, unlike QemuOpts: a KEY is split into key
>   components at '.' (dotted key convention; the block layer does
>   something similar on top of QemuOpts).  The key components are QDict
>   keys, and the last one's value is updated to VALUE.
>=20
> * Each key component may be up to 127 bytes long.  qemu_opts_parse()
>   limits the entire key to 127 bytes.
>=20
> * Overlong key components are rejected.  qemu_opts_parse() silently
>   truncates them.
>=20
> * Empty key components are rejected.  qemu_opts_parse() happily
>   accepts empty keys.
>=20
> * It does not store the returned value.  qemu_opts_parse() stores it
>   in the QemuOptsList.
>=20
> * It does not treat parameter "id" specially.  qemu_opts_parse()
>   ignores all but the first "id", and fails when its value isn't
>   id_wellformed(), or duplicate (a QemuOpts with the same ID is
>   already stored).  It also screws up when a value contains ",id=3D".
>=20
> I intend to grow this into a saner replacement for QemuOpts.  It'll
> take time, though.
>=20
> TODO Support lists
>=20
> TODO Function comment is missing.

Hence still being RFC, and I won't give R-b, but will still review.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> =20
> +QDict *keyval_parse(const char *params, const char *implied_key,
> +                    Error **errp);
> +

> +++ b/tests/test-keyval.c

> +
> +static void test_keyval_parse(void)
> +{
> +    Error *err =3D NULL;
> +    QDict *qdict, *sub_qdict;
> +    char long_key[129];
> +    char *params;
> +
> +    /* Nothing */
> +    qdict =3D keyval_parse("", NULL, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 0);
> +    QDECREF(qdict);
> +
> +    /* Empty key */
> +    qdict =3D keyval_parse("=3Dval", NULL, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +
> +    /* Empty key component */
> +    qdict =3D keyval_parse(".", NULL, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +    qdict =3D keyval_parse("key.", NULL, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);

Do you also want to test ".=3D" or "key.=3D" ?

> +
> +    /* Overlong key */
> +    memset(long_key, 'a', 127);
> +    long_key[127] =3D 'z';
> +    long_key[128] =3D 0;
> +    params =3D g_strdup_printf("k.%s=3Dv", long_key);
> +    qdict =3D keyval_parse(params + 2, NULL, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +
> +    /* Overlong key component */
> +    qdict =3D keyval_parse(params, NULL, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +    g_free(params);
> +
> +    /* Long key */
> +    params =3D g_strdup_printf("k.%s=3Dv", long_key + 1);
> +    qdict =3D keyval_parse(params + 2, NULL, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, long_key + 1), =3D=3D, "v=
");
> +    QDECREF(qdict);
> +
> +    /* Long key component */
> +    qdict =3D keyval_parse(params, NULL, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> +    sub_qdict =3D qdict_get_qdict(qdict, "k");
> +    g_assert(sub_qdict);
> +    g_assert_cmpuint(qdict_size(sub_qdict), =3D=3D, 1);
> +    g_assert_cmpstr(qdict_get_try_str(sub_qdict, long_key + 1), =3D=3D=
, "v");
> +    QDECREF(qdict);
> +    g_free(params);

As mentioned in the commit message, this works when QemuOpts would have
rejected it as overlong.  Good, in my opinion.

> +
> +    /* Multiple keys, last one wins */
> +    qdict =3D keyval_parse("a=3D1,b=3D2,,x,a=3D3", NULL, &error_abort)=
;
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 2);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "a"), =3D=3D, "3");
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "b"), =3D=3D, "2,x");
> +    QDECREF(qdict);
> +
> +    /* Even when it doesn't in QemuOpts */
> +    qdict =3D keyval_parse("id=3Dfoo,id=3Dbar", NULL, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "id"), =3D=3D, "bar");
> +    QDECREF(qdict);
> +
> +    /* Dotted keys */
> +    qdict =3D keyval_parse("a.b.c=3D1,a.b.c=3D2,d=3D3", NULL, &error_a=
bort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 2);
> +    sub_qdict =3D qdict_get_qdict(qdict, "a");
> +    g_assert(sub_qdict);
> +    g_assert_cmpuint(qdict_size(sub_qdict), =3D=3D, 1);
> +    sub_qdict =3D qdict_get_qdict(sub_qdict, "b");
> +    g_assert(sub_qdict);
> +    g_assert_cmpuint(qdict_size(sub_qdict), =3D=3D, 1);
> +    g_assert_cmpstr(qdict_get_try_str(sub_qdict, "c"), =3D=3D, "2");
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "d"), =3D=3D, "3");
> +    QDECREF(qdict);
> +
> +    /* Inconsistent dotted keys */
> +    qdict =3D keyval_parse("a.b=3D1,a=3D2", NULL, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +    qdict =3D keyval_parse("a.b=3D1,a.b.c=3D2", NULL, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);

Will probably need more tests for inconsistencies when you support arrays=
=2E

> +
> +    /* Implied value */
> +    qdict =3D keyval_parse("an,noaus,noaus=3D", NULL, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 3);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "an"), =3D=3D, "on");
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "aus"), =3D=3D, "off");
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "noaus"), =3D=3D, "");
> +    QDECREF(qdict);

Oh, so '$key' implies the same as '$key=3Dtrue'; 'no$key' implies the sam=
e
as '$key=3Dfalse', and the presence of =3D is what changes an implicit bo=
ol
(with magic 'no' prefix handling) into a full keyname.  Looks a bit
weird, but it matches what QemuOpts does so we do need to keep that
magic around.

> +
> +    /* Implied key */
> +    qdict =3D keyval_parse("an,noaus,noaus=3D", "implied", &error_abor=
t);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 3);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), =3D=3D, "an")=
;
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "aus"), =3D=3D, "off");
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "noaus"), =3D=3D, "");
> +    QDECREF(qdict);
> +
> +    /* Trailing comma is ignored */
> +    qdict =3D keyval_parse("x=3Dy,", NULL,  &error_abort);

Why two spaces here?

> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "x"), =3D=3D, "y");
> +    QDECREF(qdict);

Nice. Too bad JSON can't be as forgiving about trailing commas.

> +
> +    /* Except when it isn't */
> +    qdict =3D keyval_parse(",", NULL,  &err);

Again, why two spaces? (I'll quit pointing it out, if there's more)

> +    error_free_or_abort(&err);
> +    g_assert(!qdict);

Question: what happens with:

keyval_parse(",", "implied", &err)

Should that be the same as:

keyval_parse("implied=3D,", NULL, &err)

which in turn is the same as:

keyval_parse("implied=3D", NULL, &err)

Should you update "test-qemu-opts: Cover qemu_opts_parse()" to do a
QemuOpts counterpart of this question?

> +
> +    /* Value containing ,id=3D not misinterpreted as QemuOpts does */
> +    qdict =3D keyval_parse("x=3D,,id=3Dbar", NULL,  &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "x"), =3D=3D, ",id=3Dbar"=
);
> +    QDECREF(qdict);

Yes, definitely better than QemuOpts' wart.

> +
> +    /* Anti-social ID is left to caller */
> +    qdict =3D keyval_parse("id=3D666", NULL, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), =3D=3D, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "id"), =3D=3D, "666");
> +    QDECREF(qdict);

Nice to compare this to your earlier patch on enhancing QemuOpts tests
(your reminder of my chuckle on the "anti-social ID" on that patch was
worth it).  That test had:

+    /* TODO Cover .merge_lists =3D true */

which matches this RFC's TODO for adding list support; it also had:

+    /* Unknown key */

which is not needed here, since this focuses on just the parsing rather
than also the mapping into recognized QemuOpt key names (the counterpart
here would be that the caller would flag extra keys by using a strict
qobject-input parse on the resulting QObject).

> +++ b/util/keyval.c
> @@ -0,0 +1,150 @@
> +/*
> + * Parsing KEY=3DVALUE,... strings
> + *
> + * Copyright (C) 2017 Red Hat Inc.
> + *
> + * Authors:
> + *  Markus Armbruster <armbru@redhat.com>,
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qmp/qstring.h"
> +#include "qemu/option.h"
> +
> +/* TODO Support lists */
> +
> +static QObject *keyval_parse_put(QDict *qdict, const char *key, QStrin=
g *value,
> +                                 Error **errp)
> +{
> +    QObject *old, *new;
> +
> +    old =3D qdict_get(qdict, key);
> +    if (old) {
> +        if (qobject_type(old) !=3D (value ? QTYPE_QSTRING : QTYPE_QDIC=
T)) {
> +            error_setg(errp, "Option key '%s' used inconsistently", ke=
y);
> +            return NULL;
> +        }
> +        if (!value) {
> +            return old;
> +        }
> +        new =3D QOBJECT(value);

So if we've already seen key, it is either a subdict (and we return the
existing sub-dict to add more into it) or a string (and we replace the
old string with the new)...

> +    } else {
> +        new =3D QOBJECT(value) ?: QOBJECT(qdict_new());

=2E..and if we haven't seen key, we either add the string or a new subdic=
t...

> +    }
> +    qdict_put_obj(qdict, key, new);
> +    return new;

=2E..either way, we are returning the current value of the key within
qdict to the caller.

Comments may indeed help, because it took me a couple of reads before I
saw what was going on, but the function looks sane.

> +}
> +
> +static const char *keyval_parse_one(QDict *qdict, const char *params,
> +                                    const char *implied_key,
> +                                    Error **errp)
> +{
> +    QDict *cur =3D qdict;
> +    QObject *next;
> +    const char *s, *key;
> +    size_t len;
> +    char key_buf[128];
> +    QString *val;
> +
> +    s =3D params;
> +    len =3D strcspn(s, ".=3D,");
> +    if (implied_key && (s[len] =3D=3D ',' || !s[len])) {
> +        /* Desugar implied key */
> +        key =3D implied_key;

Should keyval_parse("=3Dfoo", "implied", &err) also behave the same as
keyval_parse("implied=3D=3Dfoo", NULL, &err) (resulting in "=3Dfoo" as th=
e value)?

> +    } else {
> +        key_buf[0] =3D 0;
> +        for (;;) {
> +            if (!len) {
> +                error_setg(errp, "Invalid option key");
> +                return NULL;
> +            }
> +            if (len >=3D sizeof(key_buf)) {
> +                error_setg(errp, "Option key component '%.*s' is too l=
ong",
> +                           (int)len, s);
> +                return NULL;
> +            }
> +
> +            if (key_buf[0]) {
> +                next =3D keyval_parse_put(cur, key_buf, NULL, errp);
> +                if (!next) {
> +                    return NULL;
> +                }
> +                cur =3D qobject_to_qdict(next);
> +                assert(cur);
> +            }
> +
> +            memcpy(key_buf, s, len);
> +            key_buf[len] =3D 0;
> +            s +=3D len;
> +            if (*s !=3D '.') {
> +                break;
> +            }
> +            s++;
> +            len =3D strcspn(s, ".=3D,");
> +        }
> +        key =3D key_buf;
> +
> +        if (*s =3D=3D '=3D') {
> +            s++;

I'm not sure this condition is correct, if there is an implied key where
we want the value string to start with "=3D".  Or are we requiring that
starting a value with =3D requires that we can't use implicit key?
Missing testsuite coverage, I think?

> +        } else {
> +            /*
> +             * Desugar implied value: it's "on", except when @key
> +             * starts with "no", it's "off".  Thus, key "novocaine"
> +             * gets desugard to "vocaine=3Doff", not to "novocaine=3Do=
n".
> +             * If sugar isn't bad enough for you, make it ambiguous...=


So if I get this right,

keyval_parse(",", "implied", &err) =3D> "implied" =3D "on"
keyval_parse(",", "noimplied", &err) =3D> "implied" =3D "off"
keyval_parse("on", "noimplied", &err) =3D> "noimplied" =3D "on"

Eww. Not necessarily your fault.  But maybe this is our chance to tweak
it to be slightly different?

> +             */
> +            if (*s =3D=3D ',')
> +                s++;

Should this account for leading ",," with implied key (meaning a value
that starts with a comma)?  Or is that another thing where a leading
comma in a value cannot be mixed with an implied key?

> +            if (!strncmp(key, "no", 2)) {
> +                key +=3D 2;
> +                val =3D qstring_from_str("off");
> +            } else {
> +                val =3D qstring_from_str("on");
> +            }
> +            goto got_val;
> +        }
> +    }
> +
> +    val =3D qstring_new();
> +    for (;;) {
> +        if (!*s) {
> +            break;
> +        } else if (*s =3D=3D ',') {
> +            s++;
> +            if (*s !=3D ',') {
> +                break;
> +            }
> +        }
> +        qstring_append_chr(val, *s++);
> +    }
> +
> +got_val:
> +    if (!keyval_parse_put(cur, key, val, errp)) {
> +        return NULL;
> +    }
> +    return s;
> +}

You managed to make this fairly compact for how hairy it is!  I don't
know how lists will impact it (well, maybe you'll have integral keys on
this pass, and then a second pass that turns integral keys into list
members...)

> +
> +/* TODO function comment */
> +QDict *keyval_parse(const char *params, const char *implied_key,
> +                    Error **errp)
> +{
> +    QDict *qdict =3D qdict_new();
> +    const char *s;

Should we do any sort of validation on implied_key, such as making sure
it is non-NULL and non-empty, does not contain ".=3D,", looks like a
well-formed id?  Or is that merely documentation that a caller that
passes a garbage implied_key gets a garbage QDict result?

> +
> +    s =3D params;
> +    while (*s) {
> +        s =3D keyval_parse_one(qdict, s, implied_key, errp);
> +        if (!s) {
> +            QDECREF(qdict);
> +            return NULL;
> +        }
> +        implied_key =3D NULL;
> +    }
> +
> +    return qdict;
> +}
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--HDIl6W44esF6XcToS5tAvH711FhfLs9qE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrfHWAAoJEKeha0olJ0NqrigH/jhqzRhCaF/w7qAfvUPCs+42
Y4JwlTaV4ID6XxEFUHrhau03UB9WOquaaw6x6EICdRFomhzoKpoa5lQiWI5gsvml
qWxrRkDcpJmtcd7FUmM/D0xA4+0HGhzJF6AkZWbtM0Pe1WEdVmLLJWK0c62O6m2h
fqlmiUa4YFqFKfrsxnw5++kl03p0IixFxkF9rtzwYcn8GWlL275tktVrRXnuYpbD
UBz8EWI35Eqh39uCYZc6qH7jWDlVMr5FOeD85hoLBmUXWFoe/BB0K29ktVyb8r1C
y2FRGSP0IdVhw318HTOEqfAlnqpr2Kp06y5saKwshsQ/Y0Bhg4OAFbMaPluEsP4=
=6wD+
-----END PGP SIGNATURE-----

--HDIl6W44esF6XcToS5tAvH711FhfLs9qE--
