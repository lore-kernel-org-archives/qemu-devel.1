Received: from eggs.gnu.org ([2001:4830:134:3::10]:60344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehe98-0004Dw-Ri
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehe7l-0008U9-JF
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:24:43 -0500
References: <20180202160752.143796-1-vsementsov@virtuozzo.com>
	<ee7b1763-3106-cda3-cecb-097bc6248737@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ab2503df-81e8-dd66-bedf-b0950744321b@redhat.com>
Date: Fri, 2 Feb 2018 17:21:09 +0100
MIME-Version: 1.0
In-Reply-To: <ee7b1763-3106-cda3-cecb-097bc6248737@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RPnW62Z2Gfmd30r7oqt7t7BoSuZXs6IRZ"
Subject: Re: [Qemu-devel] [PATCH v3] block: maintain persistent disabled
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RPnW62Z2Gfmd30r7oqt7t7BoSuZXs6IRZ
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com,
 den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com
Message-ID: <ab2503df-81e8-dd66-bedf-b0950744321b@redhat.com>
Subject: Re: [PATCH v3] block: maintain persistent disabled bitmaps
References: <20180202160752.143796-1-vsementsov@virtuozzo.com>
 <ee7b1763-3106-cda3-cecb-097bc6248737@redhat.com>
In-Reply-To: <ee7b1763-3106-cda3-cecb-097bc6248737@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-02 17:18, Eric Blake wrote:
> On 02/02/2018 10:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>> To maintain load/store disabled bitmap there is new approach:
>>
>>  - deprecate @autoload flag of block-dirty-bitmap-add, make it ignored=

>>  - store enabled bitmaps as "auto" to qcow2
>>  - store disabled bitmaps without "auto" flag to qcow2
>>  - on qcow2 open load "auto" bitmaps as enabled and others
>>    as disabled (except in_use bitmaps)
>>
>> Also, adjust iotests 165 and 176 appropriately.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>=20
>> +++ b/qemu-doc.texi
>> @@ -2749,6 +2749,13 @@ used and it will be removed with no replacement=
=2E
>>  The ``convert -s snapshot_id_or_name'' argument is obsoleted
>>  by the ``convert -l snapshot_param'' argument instead.
>> =20
>> +@section QEMU Machine Protocol (QMP) commands
>> +
>> +@subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0=
)
>> +
>> +"autoload" parameter is now ignored. All bitmaps are automatically lo=
aded
>> +from qcow2 image.
>=20
> Won't later patches be adding the ability to enable/disable bitmaps,
> which then affects whether they are autoloaded?  So we don't forget to
> revisit this text in that patch, a better wording might be:
>=20
> The "autoload" parameter is ignored; all enabled persistent dirty
> bitmaps are automatically loaded from a qcow2 image, regardless of the
> initial setting requested in this parameter.
>=20
>=20
>> @@ -667,19 +662,6 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *=
bs)
>>  }
>> =20
>>  /* Called with BQL taken. */
>> -void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool aut=
oload)
>> -{
>> -    qemu_mutex_lock(bitmap->mutex);
>> -    bitmap->autoload =3D autoload;
>> -    qemu_mutex_unlock(bitmap->mutex);
>> -}
>> -
>> -bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap)
>> -{
>> -    return bitmap->autoload;
>> -}
>=20
> Will later patches be reintroducing these functions for learning which
> bitmaps are enabled/disabled?  But I'm okay with deleting them in this
> patch, even if that is more churn.

You mean bdrv_enable_dirty_bitmap(), bdrv_disable_dirty_bitmap(), and
bdrv_dirty_bitmap_enabled()? ;-)

Max


--RPnW62Z2Gfmd30r7oqt7t7BoSuZXs6IRZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp0j/USHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AkfwH/0tG7cqKPk5WQWPoNiHpNdMOtJRSmwz/
KM3Ew0KgIwMxGRJOAcTFeX0luyQOr8ukMF1f8xXFE7nIb/9S2bI7nslKN3nYmA3M
YN7elyWva2BHKcoTJsQPmo21gdUna6pUWwc3VuMCRkQhyG5ok2ikE9cxID7CLs8g
EXIWX1SZON75591V9nJL15G4jCTeiYjIceBc15OZpE+NMYYh7O36hULxsDng8RUt
q3vYl0asXOeOHnhZf1EFmjt7Lw4AfM3xYaLneSJ8mMwn/w7DVANvorD6bCRH7+np
ebc1Y4kxu2FNr/eRMrkE5ByIuFI5YzILrOstnRp0FlpfDWZdCabDvGc=
=H80D
-----END PGP SIGNATURE-----

--RPnW62Z2Gfmd30r7oqt7t7BoSuZXs6IRZ--
