Received: from eggs.gnu.org ([2001:4830:134:3::10]:50447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB1J4-00066d-CC
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB1J3-0007CI-HM
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:00:42 -0400
References: <20180215192829.9944-1-eblake@redhat.com>
	<20180215192829.9944-4-eblake@redhat.com>
	<20180424155205.GD4080@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f9c2e87f-082e-36ce-971a-6b11cb65d843@redhat.com>
Date: Tue, 24 Apr 2018 12:00:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180424155205.GD4080@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0NiMcAP1U42ud3ScMk63QbWgXEnQebCzv"
Subject: Re: [Qemu-devel] [PATCH 3/6] null: Switch to byte-based read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0NiMcAP1U42ud3ScMk63QbWgXEnQebCzv
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng
 <famz@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <f9c2e87f-082e-36ce-971a-6b11cb65d843@redhat.com>
Subject: Re: [PATCH 3/6] null: Switch to byte-based read/write
References: <20180215192829.9944-1-eblake@redhat.com>
 <20180215192829.9944-4-eblake@redhat.com>
 <20180424155205.GD4080@localhost.localdomain>
In-Reply-To: <20180424155205.GD4080@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 10:52 AM, Kevin Wolf wrote:
> Am 15.02.2018 um 20:28 hat Eric Blake geschrieben:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  Make the change for the last few sector-based callbacks
>> in the null-co and null-aio drivers.
>>
>> Note that since the null driver does nothing on writes, it trivially
>> supports the BDRV_REQ_FUA flag (all writes have already landed to
>> the same bit-bucket without needing an extra flush call).  Furthermore=
,
>> bdrv_refresh_limits() defaults the block size to 512 for any driver
>> that does not support coroutines; while this is still correct for the
>> other aio-based drivers, the null driver does just as well with
>> byte-based requests, and being explicit means we can avoid cycles
>> wasted on read-modify-write.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
>> +static void null_refresh_limits(BlockDriverState *bs, Error **errp)
>> +{
>> +    bs->bl.request_alignment =3D 1;
>> +}
>=20
> I would rather modify bdrv_refresh_limits() so that it defaults to 1 fo=
r
> drivers supporting either .bdrv_co_preadv or .bdrv_aio_preadv.

Sure, I can do that (although then I may have to provide a
refresh_limits callback for each of the other drivers that I
specifically left at 512 alignment).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0NiMcAP1U42ud3ScMk63QbWgXEnQebCzv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfYqkACgkQp6FrSiUn
Q2p7sAf+LWxPzAkEcj8tBAf7r4orEtgV5beoWWKfo3fbkuFkg8t7Kzf8nMSoDmtY
qsbhleGJIMPKcnBKOM+cdGmgF9TrV+hmYAc+VxQYh3H1pTvhX2hDk877iF4nSKrX
PCdkYwCozGILxWCkdQno2UimJZ5u24T11RILqUN9AIXsnbLbhlXaOn3qnXYwvOVm
08DjuzIh721yeiDUq8ViXAcEatjSGoApJc20QyVYbNgVsIMaKVkT9c4uogqKey+c
jeYa7Xa9N8BiIsBwHf9uwrWTsDC7fe0JAmeZXBjSTV2sWkkkphtq+rtnFn5MPztf
W14PJQrcfqHb+UaMv2KSFiWtfHOMBg==
=byIC
-----END PGP SIGNATURE-----

--0NiMcAP1U42ud3ScMk63QbWgXEnQebCzv--
