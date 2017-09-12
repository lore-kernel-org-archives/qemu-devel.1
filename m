Received: from eggs.gnu.org ([2001:4830:134:3::10]:48632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drqyL-00017O-NG
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 15:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drqyH-0008Po-Nf
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 15:35:49 -0400
References: <20170830210542.2153-1-eblake@redhat.com>
	<20170830210542.2153-6-eblake@redhat.com>
	<20170908122254.GG3283@localhost.localdomain>
	<cdd49114-e1a6-a2d2-8d6b-97d83d9d4be6@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac753e8f-c918-4fe1-6c45-d4764975f20a@redhat.com>
Date: Tue, 12 Sep 2017 14:35:31 -0500
MIME-Version: 1.0
In-Reply-To: <cdd49114-e1a6-a2d2-8d6b-97d83d9d4be6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wvEudaeX6x1kNDXe0epOJJMr0kXklMHnL"
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
Cc: vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wvEudaeX6x1kNDXe0epOJJMr0kXklMHnL
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 jsnow@redhat.com
Message-ID: <ac753e8f-c918-4fe1-6c45-d4764975f20a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 05/18] dirty-bitmap: Change
 bdrv_dirty_bitmap_size() to report bytes
References: <20170830210542.2153-1-eblake@redhat.com>
 <20170830210542.2153-6-eblake@redhat.com>
 <20170908122254.GG3283@localhost.localdomain>
 <cdd49114-e1a6-a2d2-8d6b-97d83d9d4be6@redhat.com>
In-Reply-To: <cdd49114-e1a6-a2d2-8d6b-97d83d9d4be6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/2017 09:04 AM, Eric Blake wrote:

>>>  void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
>>>  {
>>>      BdrvDirtyBitmap *bitmap;
>>> -    uint64_t size =3D bdrv_nb_sectors(bs);
>>> +    int64_t size =3D bdrv_getlength(bs);
>>>
>>> +    assert(size >=3D 0);
>>
>> How can you assert that there will never be an error? Even if it's
>> correct (I don't know whether you can have dirty bitmaps on devices th=
at
>> don't use the cached value), this needs at least a comment.
>=20
> The old code wasn't checking for errors; if an error occurs, we have no=

> way to report it. So I indeed need to audit whether all callers have a
> cached length at this point in time (it can't fail), or else change
> bdrv_dirty_bitmap_truncate() to be able to fail (pass failure along) an=
d
> update all callers.  This may indeed be reason for a respin, depending
> on what I find.

Verdict - it can indeed fail; bdrv_truncate() was blindly calling the
dirty bitmap resize even after a failed refresh_total_sectors(), which
could then resize the dirty bitmap to -1.  At least bdrv_truncate()
itself still failed, but it's cleaner to fail up front rather than get
internal state even more botched in the meantime, so fixing that will be
a separate patch in v7.  Sadly, the failure is probably more
theoretical, and I did not quickly see an easy way to write an iotests
to expose it (which has been the case with a lot of our recent
bdrv_nb_sectors/bdrv_getlength failure cleanup patches).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wvEudaeX6x1kNDXe0epOJJMr0kXklMHnL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm4NwMACgkQp6FrSiUn
Q2qRegf/dBHh5/SKEZ3HLRW0YhMiKBqfWMaU9nOuo2avrsOI/tkQC+71obZHBHJ5
J78i2rSXOZeDyBKDmfVOTZt1h/3XihHBnYF6K5zARg8GisdX81Z8zBFpMHgAMeNi
YQfdTemiiswcEOT7/rxB9uCu8NkdOvM/IzmTc45QZIlrneSOScxFEwXaBxL37xwQ
BM8425WrRh8uU0WE0pjsh2C7WTbInRZkl9+ZIa9m9/riFmedYwChGU6sDtKQx3T9
JBGKPriRrjepvsxCPcNbMg3O5jGR7Mk3j/2ML9FF7kbsBcFPvQDOFrV/0OMzBNYa
bFAcnJ92xGwcAXN9eBtZktyT8NOywg==
=XkKr
-----END PGP SIGNATURE-----

--wvEudaeX6x1kNDXe0epOJJMr0kXklMHnL--
