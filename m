Received: from eggs.gnu.org ([2001:4830:134:3::10]:51272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTJQx-0003ow-HP
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTJQw-0006ds-NZ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:55:55 -0400
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-20-eblake@redhat.com>
	<20170706160203.GM5975@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ab0a0d0-5db0-8e5f-38ea-58b90bd92f41@redhat.com>
Date: Thu, 6 Jul 2017 21:55:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170706160203.GM5975@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FFFPBfmeX26XM3kpBuHA82lMK9bWPpXVk"
Subject: Re: [Qemu-devel] [PATCH v4 19/21] block: Make bdrv_is_allocated()
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FFFPBfmeX26XM3kpBuHA82lMK9bWPpXVk
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <2ab0a0d0-5db0-8e5f-38ea-58b90bd92f41@redhat.com>
Subject: Re: [PATCH v4 19/21] block: Make bdrv_is_allocated() byte-based
References: <20170705210842.960-1-eblake@redhat.com>
 <20170705210842.960-20-eblake@redhat.com>
 <20170706160203.GM5975@noname.redhat.com>
In-Reply-To: <20170706160203.GM5975@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/06/2017 11:02 AM, Kevin Wolf wrote:

>> +++ b/qemu-img.c
>> @@ -3229,6 +3229,7 @@ static int img_rebase(int argc, char **argv)
>>          int64_t new_backing_num_sectors =3D 0;
>>          uint64_t sector;
>>          int n;
>> +        int64_t count;
>>          float local_progress =3D 0;
>>
>>          buf_old =3D blk_blockalign(blk, IO_BUF_SIZE);
>> @@ -3276,12 +3277,14 @@ static int img_rebase(int argc, char **argv)
>>              }
>>
>>              /* If the cluster is allocated, we don't need to take act=
ion */
>> -            ret =3D bdrv_is_allocated(bs, sector, n, &n);
>> +            ret =3D bdrv_is_allocated(bs, sector << BDRV_SECTOR_BITS,=

>> +                                    n << BDRV_SECTOR_BITS, &count);
>>              if (ret < 0) {
>>                  error_report("error while reading image metadata: %s"=
,
>>                               strerror(-ret));
>>                  goto out;
>>              }
>> +            n =3D DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
>>              if (ret) {
>>                  continue;
>>              }
>=20
> Same thing. Sectors that are half allocated and half free must be
> considered completely allocated if the caller can't do byte alignment.
> Just rounding up without looking at ret isn't correct.

In reality, qemu-img rebase should probably be rewritten to exploit
bdrv_get_block_status() instead of the weaker bdrv_is_allocated(). Right
now, it is manually calling buffer_is_zero() on every sector to learn
what sectors are candidates for optimizing, rather than being able to
exploit BDRV_BLOCK_ZERO where possible (yes, we may STILL want to call
buffer_is_zero() on BDRV_BLOCK_DATA when we are trying to squeeze out
all parts of an image that can be compressed, but maybe that should be
an option, just as GNU dd has options for creating as much sparseness as
possible (slow, because it reads data) vs. preserving existing
sparseness (faster, because it relies on hole detection but leaves
explicit written zeroes as non-sparse).  I guess there's still lots of
ground for improving qemu-img, so for THIS series, I'll just leave it at
an assertion that things are sector-aligned.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FFFPBfmeX26XM3kpBuHA82lMK9bWPpXVk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXvgtAAoJEKeha0olJ0Nq4xcH/jWy1sWEk3i+pbAIYnpDXesL
Re02mPGJJm05v8s3Rk80PkBDKncYwe4iDP7bHV7vMaq8nigCzVto6Z1cf7dKPdwQ
b19zy5giHfKorKhZq0i3rfgKAT5oZH6PBk23CoXzJz4ZRjBybS1hxbJh5C0Ht2kE
IrqSVrYfbeHMgWX1mTRTjqAVfxrBa1Fogfuq9Nn09HHKbwts2lsvJBKXZl/f7YKA
S7nV91JWQQngIK4/rMiT6EZA3g8g/1SYp2fr7t8PcTmBTZ7Oc8oDSzlGMLVirsUO
mfI3AdJRnODCdqKq+r1Y0Nn5G3eliYq6fNh3XXl7hkiKamh/2LEr6tV1UjLUXMw=
=UViN
-----END PGP SIGNATURE-----

--FFFPBfmeX26XM3kpBuHA82lMK9bWPpXVk--
