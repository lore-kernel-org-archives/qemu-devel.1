Received: from eggs.gnu.org ([2001:4830:134:3::10]:33102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cio2Y-0005nO-It
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cio2X-0005Du-B0
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:06:30 -0500
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-25-git-send-email-armbru@redhat.com>
	<20170228192543.GZ4090@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1efb07d-e5ab-b627-8cf7-1a0c364e7c86@redhat.com>
Date: Tue, 28 Feb 2017 14:06:20 -0600
MIME-Version: 1.0
In-Reply-To: <20170228192543.GZ4090@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rRBqMcsn4NxXioPCenxAHGaSkbFF6NaSX"
Subject: Re: [Qemu-devel] [PATCH 24/24] keyval: Support lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pkrempa@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rRBqMcsn4NxXioPCenxAHGaSkbFF6NaSX
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pkrempa@redhat.com
Message-ID: <c1efb07d-e5ab-b627-8cf7-1a0c364e7c86@redhat.com>
Subject: Re: [PATCH 24/24] keyval: Support lists
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
 <1488194450-28056-25-git-send-email-armbru@redhat.com>
 <20170228192543.GZ4090@noname.redhat.com>
In-Reply-To: <20170228192543.GZ4090@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2017 01:25 PM, Kevin Wolf wrote:
> Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
>> Additionally permit non-negative integers as key components.  A
>> dictionary's keys must either be all integers or none.  If all keys
>> are integers, convert the dictionary to a list.  The set of keys must
>> be [0,N].
>>

>> @@ -34,16 +36,16 @@
>>   *   doesn't have one, because R.a must be an object to satisfy a.b=3D=
1
>>   *   and a string to satisfy a=3D2.
>>   *
>> - * Key-fragments must be valid QAPI names.
>> + * Key-fragments must be valid QAPI names or consist only of digits.

>>  /*
>> + * Convert @key to a list index.
>> + * Convert all leading digits to a (non-negative) number, capped at
>> + * INT_MAX.
>> + * If @end is non-null, assign a pointer to the first character after=

>> + * the number to *@end.
>> + * Else, fail if any characters follow.
>> + * On success, return the converted number.
>> + * On failure, return a negative value.
>> + * Note: since only digits are converted, no two keys can map to the
>> + * same number, except by overflow to INT_MAX.
>> + */
>> +static int key_to_index(const char *key, const char **end)
>> +{
>> +    int ret;
>> +    unsigned long index;
>> +
>> +    if (*key < '0' || *key > '9') {
>> +        return -EINVAL;
>> +    }

So no leading whitespace, '+', or '-', even if strtoul would have
allowed it.  Such names are also invalid as member id names.  (There's
still the question if we want to allow arbitrary whitespace after
between-key-value ',', and maybe even after between-key-segment '.'
after this series, to make it easier to write strategically line-wrapped
command lines - but that's an independent thing to be done on top).

>> @@ -137,8 +165,13 @@ static const char *keyval_parse_one(QDict *qdict,=
 const char *params,
>>      cur =3D qdict;
>>      s =3D key;
>>      for (;;) {
>> -        ret =3D parse_qapi_name(s, false);
>> -        len =3D ret < 0 ? 0 : ret;
>> +        /* Want a key index (unless it's first) or a QAPI name */
>> +        if (s !=3D key && key_to_index(s, &end) >=3D 0) {
>> +            len =3D end - s;
>> +        } else {
>> +            ret =3D parse_qapi_name(s, false);
>> +            len =3D ret < 0 ? 0 : ret;
>> +        }

Does this mishandle keyval_parse(string, "0", err) - where we want to
assert that the caller always passes only a valid id name for an
implicit key?

>>          assert(s + len <=3D key_end);
>>          if (!len || (s + len < key_end && s[len] !=3D '.')) {
>>              assert(key !=3D implied_key);
>> @@ -205,6 +238,119 @@ static const char *keyval_parse_one(QDict *qdict=
, const char *params,
>>      return s;
>>  }
>> =20
>> +static char *reassemble_key(GSList *key)
>> +{
>> +    GString *s =3D g_string_new("");
>> +    GSList *p;
>> +
>> +    for (p =3D key; p; p =3D p->next) {
>> +        g_string_prepend_c(s, '.');
>> +        g_string_prepend(s, (char *)p->data);

Should this use the canonical form of an index, even if the user spelled
it with extra bytes like leading zero?


>> +    /* Copy @cur's values to @elt[] */
>> +    nelt =3D qdict_size(cur);
>> +    elt =3D g_new0(QObject *, nelt);
>=20
> This doesn't seem to be freed.
>=20
>> +    for (ent =3D qdict_first(cur); ent; ent =3D qdict_next(cur, ent))=
 {
>> +        index =3D key_to_index(ent->key, NULL);
>> +        assert(index >=3D 0);
>> +        /*
>> +         * We iterate @nelt times.  Because the dictionary keys are
>> +         * distinct, the indexes are also distinct (key_to_index()
>> +         * ensures it).
>=20
> Really? What about leading zeros?

key_to_index() should be used to convert "01" and "1" into the same key
when first computing the QDict during the initial parse; this post-pass
should thus only see a single "1" key (last-one-wins semantics,
regardless of the difference in spelling of the same index repeated on
the command line).


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rRBqMcsn4NxXioPCenxAHGaSkbFF6NaSX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtdg8AAoJEKeha0olJ0Nq330IAJ0VUaEDhVbNLkzeH03lvG4B
BY29ShGv8k1yDUhI8v7UzzThq4CDllrN3d2ijddMMYouywIYNxzdF3JB/7acE3Gr
OlC5AWfOy71oTRES4SW1WCn8uKpH+SN1PA26Yv7UqcWnkT4+Ea8hEWdcbsPZdZ3i
Tfy8tIMjBicW6b/dr1aAgkcoG7MeYqstbqw6r4zLwhy7CcV5jZbNztaQh3e0aohZ
GYKFwb9dQTtFLPmblAapn6+dd53eL1f59dwkS9DujpQPQgtrcUU893mxb10pEpeo
renDaXkhz0AQZ6bJ6HkuoqbTk6vk+lq8OLw3vKAhm2FyvnPOOV/Ryk6VJKJ8KqY=
=3KLi
-----END PGP SIGNATURE-----

--rRBqMcsn4NxXioPCenxAHGaSkbFF6NaSX--
