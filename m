Received: from eggs.gnu.org ([2001:4830:134:3::10]:54987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dc9gN-000099-Ie
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dc9gM-0001lz-DU
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:20:23 -0400
References: <cover.1501477080.git.jcody@redhat.com>
	<157a4bba4b5821c08110b6e2465813a4e5925e6a.1501477080.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8f268bae-1ec2-20af-299e-b87b342165c7@redhat.com>
Date: Mon, 31 Jul 2017 07:20:03 -0500
MIME-Version: 1.0
In-Reply-To: <157a4bba4b5821c08110b6e2465813a4e5925e6a.1501477080.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GnuxCc6M4WXO40Rdtk5Cr4f2qsItD3dwe"
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/3] qemu-iotests: remove file
 cleanup from bash tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GnuxCc6M4WXO40Rdtk5Cr4f2qsItD3dwe
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com
Message-ID: <8f268bae-1ec2-20af-299e-b87b342165c7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/3] qemu-iotests: remove file
 cleanup from bash tests
References: <cover.1501477080.git.jcody@redhat.com>
 <157a4bba4b5821c08110b6e2465813a4e5925e6a.1501477080.git.jcody@redhat.com>
In-Reply-To: <157a4bba4b5821c08110b6e2465813a4e5925e6a.1501477080.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 12:04 AM, Jeff Cody wrote:
> All files for a given test are now self-contained in a subdirectory,
> and therefore the "./check" script can do all file-related cleanup
> without any help.
>=20
> This removes file cleanups from the bash tests.  The only cleanup left
> is whatever is needed to kill any spawned processes; e.g. _cleanup_qemu=
=2E
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---

>  tests/qemu-iotests/189     |  6 ------
>  148 files changed, 18 insertions(+), 938 deletions(-)

Fun diffstat!

My test 190 is on Kevin's queue, presumably for 2.10; that will also
need this cleanup.
https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg08567.html

> +++ b/tests/qemu-iotests/048
> @@ -27,14 +27,6 @@ echo "QA output created by $seq"
> =20
>  status=3D1        # failure is the default!
> =20
> -_cleanup()
> -{
> -    echo "Cleanup"

Interesting outlier for being verbose about cleanup.

> -    _cleanup_test_img
> -    rm "${TEST_IMG_FILE2}"
> -}
> -trap "_cleanup; exit \$status" 0 1 2 3 15
> -
>  _compare()
>  {
>      $QEMU_IMG compare $QEMU_IMG_EXTRA_ARGS "$@" "$TEST_IMG" "${TEST_IM=
G2}"
> diff --git a/tests/qemu-iotests/048.out b/tests/qemu-iotests/048.out
> index 0bcf663..3318eed 100644
> --- a/tests/qemu-iotests/048.out
> +++ b/tests/qemu-iotests/048.out
> @@ -39,4 +39,3 @@ wrote 512/512 bytes at offset 512
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  Content mismatch at offset 512!
>  1
> -Cleanup

And evidence that you tested your change.

> +++ b/tests/qemu-iotests/058
> @@ -79,7 +79,6 @@ _cleanup()
>  {
>      _cleanup_nbd
>      _cleanup_test_img
> -    rm -f "$converted_image"
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15

I understand keeping _cleanup_nbd in this exit trap; but should we
remove the _cleanup_test_img so that the temporary files can be left
behind after 3/3?

> +++ b/tests/qemu-iotests/085
> @@ -37,18 +37,7 @@ snapshot_virt1=3D"snapshot-v1.qcow2"
> =20
>  SNAPSHOTS=3D10
> =20
> -_cleanup()
> -{
> -    _cleanup_qemu
> -    for i in $(seq 1 ${SNAPSHOTS})
> -    do
> -        rm -f "${TEST_DIR}/${i}-${snapshot_virt0}"
> -        rm -f "${TEST_DIR}/${i}-${snapshot_virt1}"
> -    done
> -    rm -f "${TEST_IMG}" "${TEST_IMG}.1" "${TEST_IMG}.2" "${TEST_IMG}.b=
ase"
> -
> -}
> -trap "_cleanup; exit \$status" 0 1 2 3 15
> +trap "_cleanup_qemu; exit \$status" 0 1 2 3 15

Nice what the subdirectory lets you skip.


> +++ b/tests/qemu-iotests/091
> @@ -31,14 +31,6 @@ status=3D1    # failure is the default!
> =20
>  MIG_FIFO=3D"${TEST_DIR}/migrate"
> =20
> -_cleanup()
> -{
> -    rm -f "${MIG_FIFO}"
> -    _cleanup_qemu
> -    _cleanup_test_img
> -}
> -trap "_cleanup; exit \$status" 0 1 2 3 15

Isn't _cleanup_qemu important here (especially given that you preserved
it elsewhere)?

> +++ b/tests/qemu-iotests/104
> @@ -27,8 +27,6 @@ echo "QA output created by $seq"
>  here=3D`pwd`
>  status=3D1	# failure is the default!
> =20
> -trap "exit \$status" 0 1 2 3 15
> -

Unusual to install a trap like that.  Good riddance!

> +++ b/tests/qemu-iotests/182
> @@ -28,11 +28,7 @@ here=3D"$PWD"
>  tmp=3D/tmp/$$
>  status=3D1	# failure is the default!
> =20
> -_cleanup()
> -{
> -    _cleanup_test_img
> -}
> -trap "_cleanup; exit \$status" 0 1 2 3 15
> +trap "_cleanup_qemu; exit \$status" 0 1 2 3 15

Umm, why is _cleanup_qemu added?

Overall, looks nice. Given my comments, it will need a v2, preferably
rebased on top of Kevin's branch (if that hasn't landed yet)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GnuxCc6M4WXO40Rdtk5Cr4f2qsItD3dwe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/IHMACgkQp6FrSiUn
Q2oRhgf+Jor37Toh6OCdjGIfdWjZVlNJ5Vw0ovdvAjYGSuyfgnKYH1JwKARDq9Js
FnFJJ0bJmDZqIosGuPS3GZViRILo056uwe3+llw/hSTOdh2dXFURxBhwVTKGklN1
pm0Ris4grQlPRuIZSDGK9oA60ZGwmaiEOxEkV8WjUKtAcMDx81oLiMpBKKydAMsx
ZbJPClQUVfzI9yrV+uqnetmByUfu0JUTOLWViWXCl14Bvo1Q9IFgB039embvgREr
FxWaz/YGEeCnDHIZytGxuEeWSfv9fvIEQAf7PqOv3Wd0coNuOUqPzEwrB8GBtyYq
PF1abLkMi7y2CyPkqK39wvACzP1z8A==
=hJuc
-----END PGP SIGNATURE-----

--GnuxCc6M4WXO40Rdtk5Cr4f2qsItD3dwe--
