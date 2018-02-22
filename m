Received: from eggs.gnu.org ([2001:4830:134:3::10]:33900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eosSl-0006Qc-3U
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eosSj-0001kH-WC
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:07:11 -0500
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-5-mreitz@redhat.com>
	<20180222143411.GI4147@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <24f13400-a8b2-ad15-49c1-de2a9e8c46da@redhat.com>
Date: Thu, 22 Feb 2018 16:06:45 +0100
MIME-Version: 1.0
In-Reply-To: <20180222143411.GI4147@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8z8471VUaztwlol0m26oQLAhICE76q8eR"
Subject: Re: [Qemu-devel] [PATCH v8 04/26] iotests: Drop explicit base
 blockdev in 191
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8z8471VUaztwlol0m26oQLAhICE76q8eR
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Alberto Garcia <berto@igalia.com>
Message-ID: <24f13400-a8b2-ad15-49c1-de2a9e8c46da@redhat.com>
Subject: Re: [PATCH v8 04/26] iotests: Drop explicit base blockdev in 191
References: <20180205151835.20812-1-mreitz@redhat.com>
 <20180205151835.20812-5-mreitz@redhat.com>
 <20180222143411.GI4147@localhost.localdomain>
In-Reply-To: <20180222143411.GI4147@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-22 15:34, Kevin Wolf wrote:
> Am 05.02.2018 um 16:18 hat Max Reitz geschrieben:
>> Overriding the backing image should result in a json:{} pseudo-filenam=
e.
>> Then, you can no longer use the commit block job with filename
>> parameters.  Therefore, do not explicitly add the base and override th=
e
>> middle image in iotest 191, since we do not need to anyway.  This will=

>> allow us to continue to use the middle image's filename to identify it=
=2E
>>
>> In the long run, we want block-commit to accept node names for base an=
d
>> top (just like block-stream does).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Is this actually needed once the FIXME in patch 3 is addressed and only=

> significant fields are considered, or can we revert the patch at the en=
d
> of the series?

The empiric result is "no". :-)

In the series's current state, overriding the backing file always means
that it is being treated as overridden -- even if you override it with
itself and thus the resulting graph is basically the same.

I'm still open to suggestions whether we can do anything about this, but
the only thing that comes to my mind is:

(1) Open bs->backing_file as a BDS.
(2) Run bdrv_refresh_filename() on it (done automatically).
(3) Compare the result with bs->backing->bs->filename.

But you can't just open bs->backing_file twice (that is, have to BDS
that refer to the same file), except maybe with BDRV_O_NO_IO.  Still,
that would be a huge hack.  (And isn't guaranteed to work, even with
BDRV_O_NO_IO.)

So what we'd need is an off-line bdrv_refresh_filename() that constructs
a filename from filename+options, without a BDS.  But honestly, I don't
want to write that just so that we can continue to do blockdev-commit
with filenames.  I'd rather break it so we get node names there.

Max

> Once we implement a node-named based blockdev-commit, we'll want to tes=
t
> both versions here, so it would be good to be able to set a node-name
> and still be able to use the filename for the older interface.
>=20
> Kevin
>=20



--8z8471VUaztwlol0m26oQLAhICE76q8eR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqO3IUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AaoUIAMKPqW3LOkqZ8UWKk4L4JtBkc2dk5PJZ
MXih/NXBO3jIyBZjeY4a1DeDCduR5GAHmMHFZeXCv5YWgQrQnwzuwpsE8ebl40EU
P2PM2+lWQzKjzwyQcHBSnKWtSYj0K/sW97sNQ5Of/0phg81LL1CEgVpjgAnTaLXT
3OFNOvBKaD8Dw2CyVgvDVqri2d58CtJ+9G2Yj9MRRowRp8SOlllhOIwU3Y8wjt7U
Mwf/BYWspUELT+l0kul53HO6F2rlE8p1TAevWZM6kAMEbpCJpwNOwuHpsesQcWI5
N+/d1Rgq6WcAszSsSD7iEgugNluQFbdojhuCS2FzHsBM8zvVEjw6CE0=
=10lz
-----END PGP SIGNATURE-----

--8z8471VUaztwlol0m26oQLAhICE76q8eR--
