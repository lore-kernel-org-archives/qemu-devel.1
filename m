Received: from eggs.gnu.org ([2001:4830:134:3::10]:44999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dqJtj-00074I-DD
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dqJte-0004ug-Nf
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:04:43 -0400
References: <20170830210542.2153-1-eblake@redhat.com>
	<20170830210542.2153-6-eblake@redhat.com>
	<20170908122254.GG3283@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cdd49114-e1a6-a2d2-8d6b-97d83d9d4be6@redhat.com>
Date: Fri, 8 Sep 2017 09:04:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170908122254.GG3283@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cKkUkAJGQdBoQceJPXeEVJPcGLmNGMiq0"
Subject: Re: [Qemu-devel] [PATCH v6 05/18] dirty-bitmap: Change
 bdrv_dirty_bitmap_size() to report bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cKkUkAJGQdBoQceJPXeEVJPcGLmNGMiq0
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <cdd49114-e1a6-a2d2-8d6b-97d83d9d4be6@redhat.com>
Subject: Re: [PATCH v6 05/18] dirty-bitmap: Change bdrv_dirty_bitmap_size() to
 report bytes
References: <20170830210542.2153-1-eblake@redhat.com>
 <20170830210542.2153-6-eblake@redhat.com>
 <20170908122254.GG3283@localhost.localdomain>
In-Reply-To: <20170908122254.GG3283@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/2017 07:22 AM, Kevin Wolf wrote:
> Am 30.08.2017 um 23:05 hat Eric Blake geschrieben:
>> We are still using an internal hbitmap that tracks a size in sectors,
>> with the granularity scaled down accordingly, because it lets us
>> use a shortcut for our iterators which are currently sector-based.
>> But there's no reason we can't track the dirty bitmap size in bytes,
>> since it is (mostly) an internal-only variable (remember, the size
>> is how many bytes are covered by the bitmap, not how many bytes the
>> bitmap occupies).  Furthermore, we're already reporting bytes for
>> bdrv_dirty_bitmap_granularity(); mixing bytes and sectors in our
>> return values is a recipe for confusion.  A later cleanup will
>> convert dirty bitmap internals to be entirely byte-based,
>> eliminating the intermediate sector rounding added here; and
>> technically, since bdrv_getlength() already rounds up to sectors,
>> our use of DIV_ROUND_UP is more for theoretical completeness than
>> for any actual rounding.
>>
>> The only external caller in qcow2-bitmap.c is temporarily more verbose=

>> (because it is still using sector-based math), but will later be
>> switched to track progress by bytes instead of sectors.
>>
>> Use is_power_of_2() while at it, instead of open-coding that, and
>> add an assertion where bdrv_getlength() should not fail.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>=20
> I think I would have preferred to change the unit of
> BdrvDirtyBitmap.size in one patch and the unit of the return value of
> bdrv_dirty_bitmap_size() in another one to keep review a bit easier.

I can split on respin, if there's still enough reason for a respin.

>> @@ -305,13 +307,14 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(Block=
DriverState *bs,
>>  void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
>>  {
>>      BdrvDirtyBitmap *bitmap;
>> -    uint64_t size =3D bdrv_nb_sectors(bs);
>> +    int64_t size =3D bdrv_getlength(bs);
>>
>> +    assert(size >=3D 0);
>=20
> How can you assert that there will never be an error? Even if it's
> correct (I don't know whether you can have dirty bitmaps on devices tha=
t
> don't use the cached value), this needs at least a comment.

The old code wasn't checking for errors; if an error occurs, we have no
way to report it. So I indeed need to audit whether all callers have a
cached length at this point in time (it can't fail), or else change
bdrv_dirty_bitmap_truncate() to be able to fail (pass failure along) and
update all callers.  This may indeed be reason for a respin, depending
on what I find.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cKkUkAJGQdBoQceJPXeEVJPcGLmNGMiq0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmyo2AACgkQp6FrSiUn
Q2oR7ggApHv0KqSX1Ur4EGGL/3ta/VE7ZNk4goZTKCp+nZzIjST6lNIeVCeWseOx
sWeJ7kqzoR3o/jLvpksT+oq7ROz24TME8fM9AyPIkM9BQ8tRXzZsStGixeS69jPw
32r6O49TUV+Ef8INuKFhia5pI4f0qOnatn+yB1AXrgv/Fs21tC18vpFMibZ5Bj6C
POeRCnc9Un3ejWcdbSGAfOU3fQq3CJzyoaPk+uxu1DABxh6zpeVVf/P6aGw8weqk
A9J6rIhF9MODXFRIwBrOzCPTsxJieeICVbhXTWyMA5P+ACTp8/YFiURC51Su7e+6
22T+qhDgLcVn4cbLhJ+UjSOoAfuotg==
=PgHy
-----END PGP SIGNATURE-----

--cKkUkAJGQdBoQceJPXeEVJPcGLmNGMiq0--
