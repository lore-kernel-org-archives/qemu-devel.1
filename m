Received: from eggs.gnu.org ([2001:4830:134:3::10]:59461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEd08-0003bb-P6
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEd07-0003LL-Kl
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:19:48 -0500
References: <20171110221329.24176-1-mreitz@redhat.com>
	<20171110221329.24176-3-mreitz@redhat.com>
	<87zi7oritd.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0d5967d9-4f7c-0c14-5dfd-f633575e452c@redhat.com>
Date: Tue, 14 Nov 2017 16:19:38 +0100
MIME-Version: 1.0
In-Reply-To: <87zi7oritd.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KPpKl5b8h0MWpsCbfkqsos61WR7q6CE0j"
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/3] block: Handle null backing
 link
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
--KPpKl5b8h0MWpsCbfkqsos61WR7q6CE0j
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <0d5967d9-4f7c-0c14-5dfd-f633575e452c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/3] block: Handle null backing link
References: <20171110221329.24176-1-mreitz@redhat.com>
 <20171110221329.24176-3-mreitz@redhat.com>
 <87zi7oritd.fsf@dusky.pond.sub.org>
In-Reply-To: <87zi7oritd.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 16:17, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> Instead of converting all "backing": null instances into "backing": ""=
,
>> handle a null value directly in bdrv_open_inherit().
>>
>> This enables explicitly null backing links for json:{} filenames.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block.c                    |  2 +-
>>  blockdev.c                 | 14 --------------
>>  tests/qemu-iotests/089     | 20 ++++++++++++++++++++
>>  tests/qemu-iotests/089.out |  8 ++++++++
>>  4 files changed, 29 insertions(+), 15 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 85427df577..bc92ddd5a0 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -2558,7 +2558,7 @@ static BlockDriverState *bdrv_open_inherit(const=
 char *filename,
>> =20
>>      /* See cautionary note on accessing @options above */
>>      backing =3D qdict_get_try_str(options, "backing");
>> -    if (backing && *backing =3D=3D '\0') {
>> +    if (qdict_is_qnull(options, "backing") || (backing && *backing =3D=
=3D '\0')) {
>>          flags |=3D BDRV_O_NO_BACKING;
>>          qdict_del(options, "backing");
>>      }
>=20
> Consider a comment pointing out "" is deprecated.

Would not really be necessary after patch 3, but let's see how well
patch 3 is received. :-)

(And in any case, a comment certainly won't hurt.)

Max

> See also my reply to PATCH 1/3.
>=20
>> diff --git a/blockdev.c b/blockdev.c
>> index 56a6b24a0b..99ef618b39 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -3885,7 +3885,6 @@ void qmp_blockdev_add(BlockdevOptions *options, =
Error **errp)
>>      QObject *obj;
>>      Visitor *v =3D qobject_output_visitor_new(&obj);
>>      QDict *qdict;
>> -    const QDictEntry *ent;
>>      Error *local_err =3D NULL;
>> =20
>>      visit_type_BlockdevOptions(v, NULL, &options, &local_err);
>> @@ -3899,19 +3898,6 @@ void qmp_blockdev_add(BlockdevOptions *options,=
 Error **errp)
>> =20
>>      qdict_flatten(qdict);
>> =20
>> -    /*
>> -     * Rewrite "backing": null to "backing": ""
>> -     * TODO Rewrite "" to null instead, and perhaps not even here
>> -     */
>> -    for (ent =3D qdict_first(qdict); ent; ent =3D qdict_next(qdict, e=
nt)) {
>> -        char *dot =3D strrchr(ent->key, '.');
>> -
>> -        if (!strcmp(dot ? dot + 1 : ent->key, "backing")
>> -            && qobject_type(ent->value) =3D=3D QTYPE_QNULL) {
>> -            qdict_put(qdict, ent->key, qstring_new());
>> -        }
>> -    }
>> -
>>      if (!qdict_get_try_str(qdict, "node-name")) {
>>          error_setg(errp, "'node-name' must be specified for the root =
node");
>>          goto fail;
>> diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
>> index 9bfe2307b3..832eac1248 100755
>> --- a/tests/qemu-iotests/089
>> +++ b/tests/qemu-iotests/089
>> @@ -82,6 +82,26 @@ $QEMU_IO_PROG --cache $CACHEMODE \
>>  $QEMU_IO -c 'read -P 42 0 512' "$TEST_IMG" | _filter_qemu_io
>> =20
>> =20
>> +echo
>> +echo "=3D=3D=3D Testing correct handling of 'backing':null =3D=3D=3D"=

>> +echo
>> +
>> +_make_test_img -b "$TEST_IMG.base" $IMG_SIZE
>> +
>> +# This should read 42
>> +$QEMU_IO -c 'read -P 42 0 512' "$TEST_IMG" | _filter_qemu_io
>> +
>> +# This should read 0
>> +$QEMU_IO -c 'read -P 0 0 512' "json:{\
>> +    'driver': '$IMGFMT',
>> +    'file': {
>> +        'driver': 'file',
>> +        'filename': '$TEST_IMG'
>> +    },
>> +    'backing': null
>> +}" | _filter_qemu_io
>> +
>> +
>>  # Taken from test 071
>>  echo
>>  echo "=3D=3D=3D Testing blkdebug =3D=3D=3D"
>> diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
>> index 18f5fdda7a..607a9c6d9c 100644
>> --- a/tests/qemu-iotests/089.out
>> +++ b/tests/qemu-iotests/089.out
>> @@ -19,6 +19,14 @@ Pattern verification failed at offset 0, 512 bytes
>>  read 512/512 bytes at offset 0
>>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =20
>> +=3D=3D=3D Testing correct handling of 'backing':null =3D=3D=3D
>> +
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_=
file=3DTEST_DIR/t.IMGFMT.base
>> +read 512/512 bytes at offset 0
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +read 512/512 bytes at offset 0
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +
>>  =3D=3D=3D Testing blkdebug =3D=3D=3D
>> =20
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20



--KPpKl5b8h0MWpsCbfkqsos61WR7q6CE0j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLCYoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AggoH/R8O21oTI/SLB6kkwM70OHQfmsi7xFo7
bJq1ritGDlxTN0otbhCyvhiBJLvr2l6rjHzxIjMUMK9kzvSqbkaIF6S2vB8JFVK3
aw/KNhkOXvPgBbehd5sM0EQZJV/A2qSLhMeFEywirhH7qkeWNYWuJywhsbKZrK2U
b3zmLzm1YPIufeVN4gPmWcGzXGD1E/kWG3bmtHWcCez+kUaXPLq7p6avUJvxb384
IHsxyu1+q+ljhV1MU1LsBVO1RafXze505TPPmcTaj0glYzTCNdtlj1Et6PZ2NviW
/+80A2jBjhct1BTG5FauQjOvX7O/QVflcDnExyQVtT9vReoIIgr7qYI=
=hyOh
-----END PGP SIGNATURE-----

--KPpKl5b8h0MWpsCbfkqsos61WR7q6CE0j--
