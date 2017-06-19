Received: from eggs.gnu.org ([2001:4830:134:3::10]:49315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dMy9Q-0000bH-NI
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dMy9M-0003Jp-Og
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:59:36 -0400
References: <20170614153102.9077-1-mreitz@redhat.com>
	<20170614153102.9077-3-mreitz@redhat.com>
	<20170619135525.GG6113@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <151020e7-3e68-3a57-34c2-100542a02c36@redhat.com>
Date: Mon, 19 Jun 2017 16:59:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170619135525.GG6113@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Gtm1K17L4AeFcShGkLWm5PKSdN4UbHTnf"
Subject: Re: [Qemu-devel] [PATCH 2/4] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gtm1K17L4AeFcShGkLWm5PKSdN4UbHTnf
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <151020e7-3e68-3a57-34c2-100542a02c36@redhat.com>
Subject: Re: [PATCH 2/4] qapi: Add qobject_is_equal()
References: <20170614153102.9077-1-mreitz@redhat.com>
 <20170614153102.9077-3-mreitz@redhat.com>
 <20170619135525.GG6113@noname.redhat.com>
In-Reply-To: <20170619135525.GG6113@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-19 15:55, Kevin Wolf wrote:
> Am 14.06.2017 um 17:31 hat Max Reitz geschrieben:
>> This generic function (along with its implementations for different
>> types) determines whether two QObjects are equal.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
>> diff --git a/qobject/qdict.c b/qobject/qdict.c
>> index 88e2ecd..2ed57ca 100644
>> --- a/qobject/qdict.c
>> +++ b/qobject/qdict.c
>> @@ -410,6 +410,30 @@ void qdict_del(QDict *qdict, const char *key)
>>  }
>> =20
>>  /**
>> + * qdict_is_equal(): Tests whether the two QDicts are equal
>=20
> This should specify what equality means for QDicts: Do their entries
> have to point to the same objects, or is it enough if the objects
> compare equal? It seems you're trying to implement the lattter.

Yes, I'll add a comment.

>> + */
>> +bool qdict_is_equal(const QObject *x, const QObject *y)
>> +{
>> +    const QDict *dict_x =3D qobject_to_qdict(x), *dict_y =3D qobject_=
to_qdict(y);
>> +    const QDictEntry *e;
>> +
>> +    if (qdict_size(dict_x) !=3D qdict_size(dict_y)) {
>> +        return false;
>> +    }
>> +
>> +    for (e =3D qdict_first(dict_x); e; e =3D qdict_next(dict_x, e)) {=

>> +        const QObject *obj_x =3D qdict_entry_value(e);
>> +        const QObject *obj_y =3D qdict_get(dict_y, qdict_entry_key(e)=
);
>> +
>> +        if (!qobject_is_equal(obj_x, obj_y)) {
>> +            return false;
>> +        }
>> +    }
>> +
>> +    return true;
>> +}
>=20
> If I'm not mistaken, this doesn't actually check equality, but that the=

> entries of x are a subset of the entries of y.

That's why I'm checking that x and y have the same size before.

>> +/**
>>   * qdict_destroy_obj(): Free all the memory allocated by a QDict
>>   */
>>  void qdict_destroy_obj(QObject *obj)
>> diff --git a/qobject/qlist.c b/qobject/qlist.c
>> index 86b60cb..b3033c6 100644
>> --- a/qobject/qlist.c
>> +++ b/qobject/qlist.c
>> @@ -140,6 +140,31 @@ QList *qobject_to_qlist(const QObject *obj)
>>  }
>> =20
>>  /**
>> + * qlist_is_equal(): Tests whether the two QLists are equal
>=20
> Like for QDict, this isn't a complete description.

Yes, I'll add a comment here, too.

> Your implementation seems to check that both lists contain objects that=

> compare equal at each index (i.e. order matters).

Of course it does because lists are not sets but arrays (in contrast to
dicts).

Max

>> + */
>> +bool qlist_is_equal(const QObject *x, const QObject *y)
>> +{
>> +    const QList *list_x =3D qobject_to_qlist(x), *list_y =3D qobject_=
to_qlist(y);
>> +    const QListEntry *entry_x, *entry_y;
>> +
>> +    entry_x =3D qlist_first(list_x);
>> +    entry_y =3D qlist_first(list_y);
>> +
>> +    while (entry_x && entry_y) {
>> +        if (!qobject_is_equal(qlist_entry_obj(entry_x),
>> +                              qlist_entry_obj(entry_y)))
>> +        {
>> +            return false;
>> +        }
>> +
>> +        entry_x =3D qlist_next(entry_x);
>> +        entry_y =3D qlist_next(entry_y);
>> +    }
>> +
>> +    return !entry_x && !entry_y;
>> +}
>> +
>> +/**
>>   * qlist_destroy_obj(): Free all the memory allocated by a QList
>>   */
>=20
> Kevin
>=20



--Gtm1K17L4AeFcShGkLWm5PKSdN4UbHTnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZR+bEEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJyV
CAC5JJ7WQ6nSmqiYcTn1NOx7JL+FUAbnAegup5xYOEK1BXcLoSZnLxjoZTmOorMO
wGmTgv6sUybrY6wkd0+yt1LWrpMUwV15/CO2ek+/LloQdczOEvXKugglrZJtkV/k
0aQ+TYGYZTmKxj72+OK+axUpehpQj2V61dzG/Eid/vB8MzAQ9OBIYhY6Y12DIdFE
8xd5VU5uZbPakyChpkIhgz2gdH8h5eh2hzP11ZJpgZ9V+ylo7huExv7SJbLMnp6R
DQuhw8wV4SzZ8YuOuwtegXEEQbdJOAdD78RFCvnS6vvmkSpFWC1lVQNuzE49ufUX
ZMOx9r476Akk9Y4MrlRAnLxU
=xgHJ
-----END PGP SIGNATURE-----

--Gtm1K17L4AeFcShGkLWm5PKSdN4UbHTnf--
