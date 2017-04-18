Received: from eggs.gnu.org ([2001:4830:134:3::10]:49342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0X5H-0005mI-Ow
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0X5E-0003HA-JB
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:38:35 -0400
References: <fa564521b3660d574057fde906624e621d518c92.1492536554.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <80faa666-bbb3-a068-8eaf-3f35331eaa27@redhat.com>
Date: Tue, 18 Apr 2017 12:38:08 -0500
MIME-Version: 1.0
In-Reply-To: <fa564521b3660d574057fde906624e621d518c92.1492536554.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1CXrO2WhDWb6S6v5L9hJnXpgut5ddx2RQ"
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/1] qemu-iotests: _cleanup_qemu
 must be called on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1CXrO2WhDWb6S6v5L9hJnXpgut5ddx2RQ
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <80faa666-bbb3-a068-8eaf-3f35331eaa27@redhat.com>
Subject: Re: [PATCH for-2.10 1/1] qemu-iotests: _cleanup_qemu must be called
 on exit
References: <fa564521b3660d574057fde906624e621d518c92.1492536554.git.jcody@redhat.com>
In-Reply-To: <fa564521b3660d574057fde906624e621d518c92.1492536554.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/18/2017 12:31 PM, Jeff Cody wrote:
> For the tests that use the common.qemu functions for running a QEMU
> process, _cleanup_qemu must be called in the exit function.
>=20
> If it is not, if the qemu process aborts, then not all of the droppings=

> are cleaned up (e.g. pidfile, fifos).
>=20
> This updates those tests that did not have a cleanup in qemu-iotests.
>=20
> (I swapped spaces for tabs in test 102 as well)
>=20
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---

> +++ b/tests/qemu-iotests/094
> @@ -27,7 +27,14 @@ echo "QA output created by $seq"
>  here=3D"$PWD"
>  status=3D1	# failure is the default!
> =20
> -trap "exit \$status" 0 1 2 3 15
> +_cleanup()
> +{
> +    _cleanup_qemu
> +    _cleanup_test_img
> +    rm -f "$TEST_DIR/source.$IMGFMT"
> +}
> +
> +trap "cleanup; exit \$status" 0 1 2 3 15

s/cleanup/_cleanup/

Once you fix that typo,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1CXrO2WhDWb6S6v5L9hJnXpgut5ddx2RQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9k8AAAoJEKeha0olJ0NqrNsIAISesUXen/C3KSJvYr5/HNlu
PIjEeL9QmZO04IyN1qvha4ijmsMiOGtl1we9FsyswBPERfZZD+XLcEsbkh4dvdv+
Cfk/m/FUkJ5zd4Rr9na1GU9fhr8CawrR3JQF5SNyk8aXnKoUQL3RhmnahXBv1CKn
EeodN5um2HupuoT2fPXApsAW4k+ezMZsv9g7r/tM1xlSA3mtthbwHAO9GeaFIlnF
GjMBLbat3NM4n1MtqG2DKn0BPH7ns1tzBZUkjYgrOLtuRdkDi6oxbd5OoDo7SLuM
5pJ9t8M89McuWqbxRjt9VATXEGX1vZjAcQA5BMemKLz5IdU1ITgk0yj7ilQa3wA=
=+BBX
-----END PGP SIGNATURE-----

--1CXrO2WhDWb6S6v5L9hJnXpgut5ddx2RQ--
