Received: from eggs.gnu.org ([209.51.188.92]:41322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3Ou0-0000oO-0x
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3Ogm-0000xC-VS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:26:13 -0400
References: <20190311165017.32247-1-kwolf@redhat.com>
	<20190311165017.32247-11-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2f72f4e8-879a-62a5-d131-8c6562bd4043@redhat.com>
Date: Mon, 11 Mar 2019 12:26:08 -0500
MIME-Version: 1.0
In-Reply-To: <20190311165017.32247-11-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ymk4KGeT8zrODFUhCBPxjTTmD5w8jByQU"
Subject: Re: [Qemu-devel] [PATCH v2 10/10] file-posix: Make auto-read-only
 dynamic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ymk4KGeT8zrODFUhCBPxjTTmD5w8jByQU
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, berto@igalia.com,
 qemu-devel@nongnu.org
Message-ID: <2f72f4e8-879a-62a5-d131-8c6562bd4043@redhat.com>
Subject: Re: [PATCH v2 10/10] file-posix: Make auto-read-only dynamic
References: <20190311165017.32247-1-kwolf@redhat.com>
 <20190311165017.32247-11-kwolf@redhat.com>
In-Reply-To: <20190311165017.32247-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/11/19 11:50 AM, Kevin Wolf wrote:
> Until now, with auto-read-only=3Don we tried to open the file read-writ=
e
> first and if that failed, read-only was tried. This is actually not goo=
d
> enough for libvirt, which gives QEMU SELinux permissions for read-write=

> only as soon as it actually intends to write to the image. So we need t=
o
> be able to switch between read-only and read-write at runtime.
>=20
> This patch makes auto-read-only dynamic, i.e. the file is opened
> read-only as long as no user of the node has requested write
> permissions, but it is automatically reopened read-write as soon as the=

> first writer is attached. Conversely, if the last writer goes away, the=

> file is reopened read-only again.
>=20
> bs->read_only is no longer set for auto-read-only=3Don files even if th=
e
> file descriptor is opened read-only because it will be transparently
> upgraded as soon as a writer is attached. This changes the output of
> qemu-iotests 232.

auto-read-only was introduced in 3.1, at which point we intentionally
had sufficiently loose wording to permit (but not require) dynamic state
checking; so you are not breaking the interface.  On the other hand, is
libvirt going to have problems introspecting whether it can use
auto-read-only and get the dynamic behavior it needs?  Or is there
enough else in the way of libvirt's switch to -blockdev that it won't
attempt anything that needs auto-read-only without other 4.0 interfaces
anyway, at which point detecting the presence of the field (but not
whether the field has a guarantee of dynamic behavior) on 3.1 doesn't
matter?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ymk4KGeT8zrODFUhCBPxjTTmD5w8jByQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyGmjEACgkQp6FrSiUn
Q2owvAgAn4XPIO64o3nHU8dSEq0IXQfktbWgrJhUj4O7HSF12N4q8bylYCS9fAvY
nINwbShuNBi6PtVOBqirVOtWhup4969TdxHLrETLIYjToZANh9Tht1+5YNMgZh9E
kIA8r5c04qxkLWauTy+3rpFFEO3zP8OHJNizBbzij/9FjkJui7sr5YSufY8daYwn
jUTOXPZ2VT3jovu4o0VsSyCZptxjevtJW0960zL+HZc6dgMGbz8ZdLYLAMozkpji
mZaPknuVVEfMXxwWnapUktAulmfdToiHsTbsNZHu6OvJiv11NgEB14j5iGabRRRx
2s3rZ8QdbZgCEIV4zXzAolBxCXebpw==
=cvWH
-----END PGP SIGNATURE-----

--ymk4KGeT8zrODFUhCBPxjTTmD5w8jByQU--
