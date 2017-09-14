Received: from eggs.gnu.org ([2001:4830:134:3::10]:35541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsSkw-0000na-6s
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsSkv-0003Yq-4y
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:56:30 -0400
References: <20170912203119.24166-1-eblake@redhat.com>
	<20170912203119.24166-6-eblake@redhat.com>
	<84d98f85-958f-ad74-6951-68fd4241fcdf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb5ad4ab-1b47-2488-1787-2536b62568ad@redhat.com>
Date: Thu, 14 Sep 2017 06:56:13 -0500
MIME-Version: 1.0
In-Reply-To: <84d98f85-958f-ad74-6951-68fd4241fcdf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g651pGaWqKfeEjFlFd3fhdHJbp1h2FNsB"
Subject: Re: [Qemu-devel] [PATCH v7 05/20] dirty-bitmap: Check for size
 query failure during truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g651pGaWqKfeEjFlFd3fhdHJbp1h2FNsB
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <bb5ad4ab-1b47-2488-1787-2536b62568ad@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 05/20] dirty-bitmap: Check for size query
 failure during truncate
References: <20170912203119.24166-1-eblake@redhat.com>
 <20170912203119.24166-6-eblake@redhat.com>
 <84d98f85-958f-ad74-6951-68fd4241fcdf@redhat.com>
In-Reply-To: <84d98f85-958f-ad74-6951-68fd4241fcdf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/13/2017 06:27 PM, John Snow wrote:
>=20
>=20
> On 09/12/2017 04:31 PM, Eric Blake wrote:
>> We've previously fixed several places where we failed to account
>> for possible errors from bdrv_nb_sectors().  Fix another one by
>> making bdrv_dirty_bitmap_truncate() report the error rather then
>> silently resizing bitmaps to -1.  Then adjust the sole caller
>=20
> Nice failure mode. It was not immediately obvious to me that this could=

> fail, but here we all are.
>=20
>> bdrv_truncate() to both reduce the likelihood of failure (blindly
>> calling bdrv_dirty_bitmap_truncate() after refresh_total_sectors()
>> fails was not nice) as well as propagate any actual failures.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>>      ret =3D drv->bdrv_truncate(bs, offset, prealloc, errp);
>> -    if (ret =3D=3D 0) {
>> -        ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS)=
;
>> -        bdrv_dirty_bitmap_truncate(bs);
>> -        bdrv_parent_cb_resize(bs);
>> -        atomic_inc(&bs->write_gen);
>> +    if (ret < 0) {
>> +        return ret;
>>      }
>> +    ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
>> +    if (ret < 0) {
>> +        error_setg_errno(errp, -ret, "Could not refresh total sector =
count");
>> +        return ret;
>> +    }
>> +    ret =3D bdrv_dirty_bitmap_truncate(bs);
>> +    if (ret < 0) {
>> +        error_setg_errno(errp, -ret, "Could not refresh total sector =
count");
>=20
> You probably meant to write a different error message here.
>=20
> Also, what happens if the actual truncate call works, but the bitmap
> resizing fails? What state does that leave us in?

Another option: bdrv_dirty_bitmap_truncate() can only fail if
bdrv_nb_sectors() can fail.  We WANT to use the actual size of the
device (which might be slightly different than the requested size passed
to bdrv_truncate in the first place), but we could change
bdrv_dirty_bitmap_truncate() to take an actual size as a parameter
instead of having to query bdrv_nb_sectors() for the size; and we can
change the contract of refresh_total_sectors() to query the actual size
before returning (remember, offset >> BDRV_SECTOR_BITS is only the hint
size, and may differ from the actual size).  That way, if
refresh_total_sectors() succeeds, then bdrv_dirty_bitmap_truncate()
cannot fail.

I'm not sure, however, how invasive it will be to make
refresh_total_sectors() guarantee that it can return the actual size
that was set even when that size differs from the hint.  Still, it
sounds like the right approach to take, so I'll play with it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--g651pGaWqKfeEjFlFd3fhdHJbp1h2FNsB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm6bl0ACgkQp6FrSiUn
Q2r16Qf/e1qudX6FwKSvp1VRyYmG08Ced4lN0e4wQRwXa2xIphz3040B+zWk4BkM
i7YPaMW4K1OIx/lchFP6NrnFuRP4dRN6z9yDbcKTfxJjAlZCJAPRKTKo/KbvorCE
qGw3vhmBbE0UnSy8BktyFT8OUupKL53S3k8TMm9pv/A4oj7L6/1Amj2v5pIP9KRt
ZKLYDoFI42sKDxgdi5smjRwUAcyorOx6Ydna3cUlqmNqojceN/3XVVZv9BYfeqwF
Swe8U0oZCM7a88Giow2mWMTxoWJnRFT1TGT4YQmDA4wzKJXdZ1SGG+2qz1IuUakm
8rsMzSiszTofwJVB4Furc0eNXHLBjQ==
=b7X4
-----END PGP SIGNATURE-----

--g651pGaWqKfeEjFlFd3fhdHJbp1h2FNsB--
