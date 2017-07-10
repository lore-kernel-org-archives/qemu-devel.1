Received: from eggs.gnu.org ([2001:4830:134:3::10]:43365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUg63-0008DC-UE
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUg63-0000Xq-1l
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:19:59 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-6-eblake@redhat.com>
	<6871f1c0-ad00-84b1-3045-657a998748c3@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dfae7b01-7a6a-d081-57b2-a02f4932a4e7@redhat.com>
Date: Mon, 10 Jul 2017 16:19:47 -0500
MIME-Version: 1.0
In-Reply-To: <6871f1c0-ad00-84b1-3045-657a998748c3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KSJNHK4aTDxXsh0u7T8fqe3Uc0E31OijL"
Subject: Re: [Qemu-devel] [PATCH v4 05/17] dirty-bitmap: Change
 bdrv_dirty_bitmap_size() to report bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KSJNHK4aTDxXsh0u7T8fqe3Uc0E31OijL
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <dfae7b01-7a6a-d081-57b2-a02f4932a4e7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 05/17] dirty-bitmap: Change
 bdrv_dirty_bitmap_size() to report bytes
References: <20170703151051.31327-1-eblake@redhat.com>
 <20170703151051.31327-6-eblake@redhat.com>
 <6871f1c0-ad00-84b1-3045-657a998748c3@redhat.com>
In-Reply-To: <6871f1c0-ad00-84b1-3045-657a998748c3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/10/2017 04:09 PM, John Snow wrote:
>=20
>=20
> On 07/03/2017 11:10 AM, Eric Blake wrote:
>> We are still using an internal hbitmap that tracks a size in sectors,
>> with the granularity scaled down accordingly, because it lets us
>> use a shortcut for our iterators which are currently sector-based.
>> But there's no reason we can't track the dirty bitmap size in bytes,
>> since it is (mostly) an internal-only variable (remember, the size
>> is how many bytes are covered by the bitmap, not how many bytes the
>> bitmap occupies).  Furthermore, we're already reporting bytes for
>> bdrv_dirty_bitmap_granularity(); mixing bytes and sectors in our
>> return values is a recipe for confusion.
>>
>> The only external caller in qcow2-bitmap.c is temporarily more verbose=

>> (because it is still using sector-based math), but will later be
>> switched to track progress by bytes instead of sectors.
>>
>> Use is_power_of_2() while at it, instead of open-coding that.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> @@ -305,8 +307,10 @@ BdrvDirtyBitmap
>> *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
>>   void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
>>   {
>>       BdrvDirtyBitmap *bitmap;
>> -    uint64_t size =3D bdrv_nb_sectors(bs);
>> +    int64_t size =3D bdrv_getlength(bs);
>>
>> +    assert(size >=3D 0);
>> +    size =3D DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
>=20
> Do we need a TODO here as well, or are we going to track these in terms=

> of "sectors" permanently?

The rounding goes away in patch 17/17 when I flip the internals to
byte-based.  If a TODO comment here (that goes away in patch 17) makes
review easier, I can add that.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KSJNHK4aTDxXsh0u7T8fqe3Uc0E31OijL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZY+9zAAoJEKeha0olJ0NqJekH+wQ3qpkrwjP38YrvYH8xIZ17
JjmCJ5duUhQls1eOviz6GwhoVozyONCFI+RQAu0rGsrq1gpQYXUeNqML2TLrJYPP
N9CXiaxGDHJCqdT/Ip2ZEyUH7YNXLvl6PjvjSK3Vnbti/llQLC7F6IiQj9QwlpZT
oTu62wfbtESt962dMCLNmlboZ8rWM858trxZJNQljDbkNBKJ66nWXTcmgTq/I650
4yAp9yJ8+dW9WnW2gsRlDX+6Azz6xzAVSFi5u0Pz1/bqkXsiPM2QLNCE3FpOjoOL
A5RJ17UiYVNFPpWFbodZhOCdPrIrf//yH9MlMneFk5p++e+lumPJRBkd5oZvWuY=
=1+jw
-----END PGP SIGNATURE-----

--KSJNHK4aTDxXsh0u7T8fqe3Uc0E31OijL--
