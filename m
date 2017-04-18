Received: from eggs.gnu.org ([2001:4830:134:3::10]:34382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0VKE-0006NG-KT
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0VKD-0000P2-IR
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:45:54 -0400
References: <20170418075911.7579-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7b84374c-d7e7-36d3-6ad8-b770febe183d@redhat.com>
Date: Tue, 18 Apr 2017 10:45:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170418075911.7579-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="speMr3xwF14D0XqWTHE9vCRWSpgNjqwUg"
Subject: Re: [Qemu-devel] [PATCH for-2.10] iotests: 109: Filter out "len" of
 failed jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--speMr3xwF14D0XqWTHE9vCRWSpgNjqwUg
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <7b84374c-d7e7-36d3-6ad8-b770febe183d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] iotests: 109: Filter out "len" of
 failed jobs
References: <20170418075911.7579-1-famz@redhat.com>
In-Reply-To: <20170418075911.7579-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/18/2017 02:59 AM, Fam Zheng wrote:
> Mirror calculates job len from current I/O progress:
>=20
>     s->common.len =3D s->common.offset +
>                     (cnt + s->sectors_in_flight) * BDRV_SECTOR_SIZE;
>=20
> The final "len" of a failed mirror job in iotests 109 depends on the
> subtle timing of the completion of read and write issued in the first
> mirror iteration.  The second iteration may or may not have run when th=
e
> I/O error happens, resulting in an undeterministic output of the

perhaps s/an undeterministic/non-deterministic/

> BLOCK_JOB_COMPLETED event text.

I can definitely reproduce hitting those issues (often with ./check -raw
109).

>=20
> Similar to what was done in a752e4786, filter out the field to make the=

> test robust.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/109           |  3 ++-
>  tests/qemu-iotests/109.out       | 12 ++++++------
>  tests/qemu-iotests/common.filter |  6 ++++++
>  3 files changed, 14 insertions(+), 7 deletions(-)
>=20

> diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
> index 927151a..6d61cf1 100755
> --- a/tests/qemu-iotests/109
> +++ b/tests/qemu-iotests/109
> @@ -80,7 +80,8 @@ for fmt in qcow qcow2 qed vdi vmdk vpc; do
> =20
>      # This first test should fail: The image format was probed, we may=
 not
>      # write an image header at the start of the image
> -    run_qemu "$TEST_IMG" "$TEST_IMG.src" "" "BLOCK_JOB_ERROR"
> +    run_qemu "$TEST_IMG" "$TEST_IMG.src" "" "BLOCK_JOB_ERROR" | \

Technically, \ after | is not necessary; but it doesn't hurt to leave it
in (shell grammar is weird).

> +++ b/tests/qemu-iotests/common.filter
> @@ -92,6 +92,12 @@ _filter_block_job_offset()
>      sed -e 's/, "offset": [0-9]\+,/, "offset": OFFSET,/'
>  }
> =20
> +# replace block job len
> +_filter_block_job_len()
> +{
> +    sed -e 's/, "len": [0-9]\+,/, "len": LEN,/'

Right now, we only have one "len" per line; but do you want to add the g
flag (s/.../.../g), for future robustness?

Use of \+ is not POSIX, but it is portable enough in practice (at any
rate, we already have several other tests using it), and sure beats the
more portable alternative of [0-9][0-9]* in conciseness.

So whether or not you add the 'g',

Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--speMr3xwF14D0XqWTHE9vCRWSpgNjqwUg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9jSmAAoJEKeha0olJ0NqNGUH/RWWOpoA7IBqc5edA1cLLRDD
teUYSD3ZShTmC+kCfr/3FmlbU1rvGgFlpmHmjlSR8Gb2/TGz6V+DTLAjZgsND2OL
dMdMJ+RK9QT1ZgrdkfjCnMOi/Y2C5LFgrwnD2RbVEKN8t8aT7KcaCp/XL0fm3vjM
v6RDpA65HldRZ6BaoMxzfSdlxJoTTyUuisc933pAIDXLS42U97kHhJ4bb16fgp0p
iLUg/wYDwncXQeVJI4Y1/tRV1VtYC+OcIOE+nzy5VYpN/xqjsloN6WwtEBIe6Gkr
39gZO30cOO6xZv9VqKnChA1OVfFiFtDZLc19IAzznmFRrb4V69Frg7fH0B9uw8Y=
=Ek7u
-----END PGP SIGNATURE-----

--speMr3xwF14D0XqWTHE9vCRWSpgNjqwUg--
