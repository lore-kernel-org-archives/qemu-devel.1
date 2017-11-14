Received: from eggs.gnu.org ([2001:4830:134:3::10]:47866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEcgc-0003j2-KD
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEcgb-0004aP-M9
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:59:38 -0500
References: <20171110221329.24176-1-mreitz@redhat.com>
	<20171110221329.24176-2-mreitz@redhat.com>
	<874lpwsya7.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f7de124e-c624-9776-7cba-3caa255a65de@redhat.com>
Date: Tue, 14 Nov 2017 15:59:30 +0100
MIME-Version: 1.0
In-Reply-To: <874lpwsya7.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eD9uS2Wv9s88v3nwEk4XBGOjNxMQSxwxr"
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/3] qapi: Add qdict_is_null()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eD9uS2Wv9s88v3nwEk4XBGOjNxMQSxwxr
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <f7de124e-c624-9776-7cba-3caa255a65de@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/3] qapi: Add qdict_is_null()
References: <20171110221329.24176-1-mreitz@redhat.com>
 <20171110221329.24176-2-mreitz@redhat.com>
 <874lpwsya7.fsf@dusky.pond.sub.org>
In-Reply-To: <874lpwsya7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 15:57, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/qapi/qmp/qdict.h |  1 +
>>  qobject/qdict.c          | 10 ++++++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
>> index fc218e7be6..c65ebfc748 100644
>> --- a/include/qapi/qmp/qdict.h
>> +++ b/include/qapi/qmp/qdict.h
>> @@ -76,6 +76,7 @@ int64_t qdict_get_try_int(const QDict *qdict, const =
char *key,
>>                            int64_t def_value);
>>  bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def=
_value);
>>  const char *qdict_get_try_str(const QDict *qdict, const char *key);
>> +bool qdict_is_qnull(const QDict *qdict, const char *key);
>> =20
>>  void qdict_copy_default(QDict *dst, QDict *src, const char *key);
>>  void qdict_set_default_str(QDict *dst, const char *key, const char *v=
al);
>> diff --git a/qobject/qdict.c b/qobject/qdict.c
>> index e8f15f1132..a032ea629a 100644
>> --- a/qobject/qdict.c
>> +++ b/qobject/qdict.c
>> @@ -294,6 +294,16 @@ const char *qdict_get_try_str(const QDict *qdict,=
 const char *key)
>>  }
>> =20
>>  /**
>> + * qdict_is_qnull(): Return true if the value for 'key' is QNull
>> + */
>> +bool qdict_is_qnull(const QDict *qdict, const char *key)
>> +{
>> +    QObject *value =3D qdict_get(qdict, key);
>> +
>> +    return value && value->type =3D=3D QTYPE_QNULL;
>> +}
>> +
>> +/**
>>   * qdict_iter(): Iterate over all the dictionary's stored values.
>>   *
>>   * This function allows the user to provide an iterator, which will b=
e
>=20
> As far as I can tell, the new helper function is going to be used just
> once, by bdrv_open_inherit() in PATCH 2:
>=20
>     qdict_is_qnull(options, "backing")
>=20
> I dislike abstracting from just one concrete instance.
>=20
> Perhaps a more general helper could be more generally useful.  Somethin=
g
> like:
>=20
>     qobject_is(qdict_get(options, "backing", QTYPE_QNULL))
>=20
> There are numerous instances of
>=20
>     !obj || qobject_type(obj) =3D=3D T
>=20
> in the tree, which could then be replaced by
>=20
>     qobject_is(obj, T)
>=20
> An alternative helper: macro qobject_dynamic_cast(obj, T) that returns
> (T *)obj if obj is a T, else null.  Leads to something like
>=20
>     qobject_dynamic_cast(qdict_get(options, "backing", QNull))

If you think that's good, then that's good -- you know the QAPI code
better then me, after all.

To explain myself: I thought it would be the natural extension of the
qdict_get_try_*() functions for the QNull type.

Max


--eD9uS2Wv9s88v3nwEk4XBGOjNxMQSxwxr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLBNISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AUVYH/38rZtCj1OgSWGQr9pBjkhGkyJdmaRkn
e1G3NuY74WUGOySaKmPNuO8ZTORQmONKOp1ceFr1Ed1Ix9Mhf7vg2Fd9T9Z4JJOs
wCqvZWcahVftRXGiaOWtLbkR4QYAQtgDVzRA9KKZ7BpyF0ijzF/WmvElqMeZ3dgs
zFebChlCocxyUfnq/WQPYFbiBginCgFTisEOWirmwlA8BoAYT3y4XJfLW4YMHZt5
hNU8tq1FCN6kuRJ60dY6p0yFcwfze0+7H+E2LVDswk1LFecXpYQwrTuktQ9atp5P
vhHQJrJujn7fUY/GEcry2EbXbgoFNfnp8GZ9HQjlcy0HdIlFi2kiLys=
=GDyB
-----END PGP SIGNATURE-----

--eD9uS2Wv9s88v3nwEk4XBGOjNxMQSxwxr--
