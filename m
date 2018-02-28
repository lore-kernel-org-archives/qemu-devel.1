Received: from eggs.gnu.org ([2001:4830:134:3::10]:44091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er3BG-0007rc-Lf
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er3BF-00056l-Op
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:58:06 -0500
References: <20180122220806.22154-1-mreitz@redhat.com>
	<20180122220806.22154-12-mreitz@redhat.com>
	<20180227090639.GC25412@lemon.usersys.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4aa6ecd3-616a-a1f1-b874-ec19fdf930fc@redhat.com>
Date: Wed, 28 Feb 2018 15:57:49 +0100
MIME-Version: 1.0
In-Reply-To: <20180227090639.GC25412@lemon.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1Biny5C7QzMHZooOY3vu0Mbhq0xMSjkwS"
Subject: Re: [Qemu-devel] [PATCH v2 11/16] block/dirty-bitmap: Add
 bdrv_dirty_iter_next_area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1Biny5C7QzMHZooOY3vu0Mbhq0xMSjkwS
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <4aa6ecd3-616a-a1f1-b874-ec19fdf930fc@redhat.com>
Subject: Re: [PATCH v2 11/16] block/dirty-bitmap: Add
 bdrv_dirty_iter_next_area
References: <20180122220806.22154-1-mreitz@redhat.com>
 <20180122220806.22154-12-mreitz@redhat.com>
 <20180227090639.GC25412@lemon.usersys.redhat.com>
In-Reply-To: <20180227090639.GC25412@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-27 10:06, Fam Zheng wrote:
> On Mon, 01/22 23:08, Max Reitz wrote:
>> This new function allows to look for a consecutively dirty area in a
>> dirty bitmap.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/block/dirty-bitmap.h |  2 ++
>>  block/dirty-bitmap.c         | 51 +++++++++++++++++++++++++++++++++++=
+++++++++
>>  2 files changed, 53 insertions(+)
>>
>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap=
=2Eh
>> index a591c27213..35f3ccc44c 100644
>> --- a/include/block/dirty-bitmap.h
>> +++ b/include/block/dirty-bitmap.h
>> @@ -79,6 +79,8 @@ void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *b=
itmap,
>>  void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
>>                                      int64_t offset, int64_t bytes);
>>  int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
>> +bool bdrv_dirty_iter_next_area(BdrvDirtyBitmapIter *iter, uint64_t ma=
x_offset,
>> +                               uint64_t *offset, int *bytes);
>>  void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t offset);
>>  int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
>>  int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 50564fa1e2..484b5dda43 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -501,6 +501,57 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter =
*iter)
>>      return hbitmap_iter_next(&iter->hbi, true);
>>  }
>> =20
>> +/**
>> + * Return the next consecutively dirty area in the dirty bitmap
>> + * belonging to the given iterator @iter.
>> + *
>> + * @max_offset: Maximum value that may be returned for
>> + *              *offset + *bytes
>> + * @offset:     Will contain the start offset of the next dirty area
>> + * @bytes:      Will contain the length of the next dirty area
>> + *
>> + * Returns: True if a dirty area could be found before max_offset
>> + *          (which means that *offset and *bytes then contain valid
>> + *          values), false otherwise.
>=20
> Also document the change to the iter cursor depending on the return val=
ue?

Good point, since it may be unexpected that it isn't advanced if
max_offset would be exceeded.

Max


--1Biny5C7QzMHZooOY3vu0Mbhq0xMSjkwS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqWw20SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+8wH/20glRtiD17RAkSvku9P8XRqU+5KQcbS
IbbLqgNgmeMHaQQIy/n7O6Sl+UNXm4ZRZmb7xTFMw1qB621c0655PgXUIddk7mCN
T4o2l981EJlQRwiEdG/h2I4DSAHfPZOg+fiW7bh40dXzS7O+AQjcxwPAaka3LpZB
6lcJMqNtvPt2xVOrNNHYmWRWFYIfslJym+BBYOU/hgHJ6H25JdKvA4rs25/OcT5y
x7ERStcHSo+pKd0sl0M6l0w+BOnPAY43jIqkffXTorVcKvRwS8sR71tKhOhpWy6U
h76ti2Sea6Z2T78ZhABFz8RH00pb6y7qc3YyGyuQl9FEBACb6Z7I2ME=
=g89g
-----END PGP SIGNATURE-----

--1Biny5C7QzMHZooOY3vu0Mbhq0xMSjkwS--
