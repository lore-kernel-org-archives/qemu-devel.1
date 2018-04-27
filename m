Received: from eggs.gnu.org ([2001:4830:134:3::10]:58630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC5XJ-0001tU-U0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC5XI-00054f-U0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:43:49 -0400
References: <20180426134305.642080-1-eblake@redhat.com>
	<20180426134305.642080-4-eblake@redhat.com>
	<w5136zgbve8.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f7d5b3a3-e7d2-bff0-07c4-42f474e8b133@redhat.com>
Date: Fri, 27 Apr 2018 10:43:33 -0500
MIME-Version: 1.0
In-Reply-To: <w5136zgbve8.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CaTQpF0LpWIciBnGn4VR6e7bXBnLZOXQp"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] block: Removed unused
 sector-based blocking I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CaTQpF0LpWIciBnGn4VR6e7bXBnLZOXQp
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <f7d5b3a3-e7d2-bff0-07c4-42f474e8b133@redhat.com>
Subject: Re: [Qemu-block] [PATCH 3/3] block: Removed unused sector-based
 blocking I/O
References: <20180426134305.642080-1-eblake@redhat.com>
 <20180426134305.642080-4-eblake@redhat.com>
 <w5136zgbve8.fsf@maestria.local.igalia.com>
In-Reply-To: <w5136zgbve8.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 09:01 AM, Alberto Garcia wrote:
> On Thu 26 Apr 2018 03:43:05 PM CEST, Eric Blake wrote:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  Now that all callers of blocking I/O have been converted
>> to use our preferred byte-based bdrv_p{read,write}(), we can
>> delete the unused bdrv_{read,write}().
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
>> -static int bdrv_rw_co(BdrvChild *child, int64_t sector_num, uint8_t *=
buf,
>> -                      int nb_sectors, bool is_write, BdrvRequestFlags=
 flags)
>> -{
>> -    QEMUIOVector qiov;
>> -    struct iovec iov =3D {
>> -        .iov_base =3D (void *)buf,
>> -        .iov_len =3D nb_sectors * BDRV_SECTOR_SIZE,
>> -    };
>> -
>> -    if (nb_sectors < 0 || nb_sectors > BDRV_REQUEST_MAX_SECTORS) {
>> -        return -EINVAL;
>> -    }
>=20
> Do we have a check for BDRV_REQUEST_MAX_BYTES in the byte-based API?

No, but we don't need one.  First, note that bs->bl.max_transfer is
currently uint32_t, so right now, no driver can set it any larger than
4G; although they can certainly set it smaller (for example, NBD sets it
to 32M).  Then note that bdrv_co_pwritev() and friends take care of
fragmenting any >4G request down to max_transfer.  The old check was to
ensure that a sector count couldn't overflow larger than a 4G byte count
(since the sector API had a 32-bit intrinsic limit on byte count, even
though the parameter was in sectors); but the public byte-based API
doesn't have an intrinsic limit on byte count, and takes care of
fragmenting down to any intrinsic limit for the driver callbacks.

But, having said that, you've made me wonder if it's time to increase
max_transfer to [u]int64_t, then audit ALL drivers to ensure that they
either properly handle requests >=3D4G or else set max_transfer <4G
(ideally, the block layer will default max_transfer to the value of
BDRV_REQUEST_MAX_BYTES, even if the audit means we no longer need that
macro).  Should be a separate series, though.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CaTQpF0LpWIciBnGn4VR6e7bXBnLZOXQp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjRSUACgkQp6FrSiUn
Q2puAAf7Bp7LycAGPTfC7xE0m8zLz/qaYkU3KdbXaqHvF9jF8IL32+7KZ43m9Q+F
zaEY9PxI4BOQlGv85k6Kscb74bX7jIX8VLKkICBiyOo/yOA4iKxRy+MZk+7BZPFl
HFpO5EG37bYxDnimH/d8rTH6VkbYCWlAIBOEh8RmRioFJsWYSKtcXKV/887Dew2+
apwp8tLLt3kSgz4bsjXqBCjGSp8smLm3/EnO9QzavRjnmUjwb1fZn08er0ROVVd5
NJ8RcIMyeaxWKC7iClL89nSO2SsqOW3JCQiHSy9TN8AY9rzT4pFX94z08+Fv6AIf
aY+gS8/XloZF7cUmIp5F1OIMy/Snpg==
=Cytn
-----END PGP SIGNATURE-----

--CaTQpF0LpWIciBnGn4VR6e7bXBnLZOXQp--
