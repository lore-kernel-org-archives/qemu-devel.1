Received: from eggs.gnu.org ([2001:4830:134:3::10]:57657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddIFT-0001GY-Nt
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddIFS-00028B-N4
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:41:19 -0400
References: <20170803150301.10177-1-kwolf@redhat.com>
	<20170803150301.10177-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <43b8796a-8bc5-cdeb-2ff8-cd501d80d021@redhat.com>
Date: Thu, 3 Aug 2017 10:41:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170803150301.10177-6-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OwSjIW0oVbSmfbAeVU3gnHOWSK1X5Awa9"
Subject: Re: [Qemu-devel] [PATCH for-2.10 5/5] qemu-iotests: Test reopen
 between read-only and read-write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OwSjIW0oVbSmfbAeVU3gnHOWSK1X5Awa9
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <43b8796a-8bc5-cdeb-2ff8-cd501d80d021@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 5/5] qemu-iotests: Test reopen
 between read-only and read-write
References: <20170803150301.10177-1-kwolf@redhat.com>
 <20170803150301.10177-6-kwolf@redhat.com>
In-Reply-To: <20170803150301.10177-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 10:03 AM, Kevin Wolf wrote:
> This serves as a regression test for the bugs that were just fixed for
> bdrv_reopen() between read-only and read-write mode.

If I'm right that this also fixes the difference between intermediate
vs. live commit to an initial read-write image that can't be reopened,
can we add that to this test?

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/187     | 69 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/187.out | 18 ++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 88 insertions(+)
>  create mode 100755 tests/qemu-iotests/187
>  create mode 100644 tests/qemu-iotests/187.out
>=20

> +
> +_cleanup()
> +{
> +	_cleanup_test_img
> +    rm -f "$TEST_IMG.2"
> +    rm -f "$TEST_IMG.3"
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15

There are pending patches for 2.11 that will need to tweak this. But for
2.10, this is fine.


> +++ b/tests/qemu-iotests/187.out
> @@ -0,0 +1,18 @@
> +QA output created by 187
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
> +
> +Start from read-only
> +
> +Block node is read-only
> +wrote 65536/65536 bytes at offset 0
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Block node is read-only
> +

Why the difference in error messages, when starting read-only,

> +Start from read-write
> +
> +wrote 65536/65536 bytes at offset 0
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +write failed: Operation not permitted

vs. when reopened read-only?

I don't see it as a flaw in the test, so much as another odd difference
in code paths that we may later want to improve.

So, as written,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OwSjIW0oVbSmfbAeVU3gnHOWSK1X5Awa9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmDRBUACgkQp6FrSiUn
Q2ro8wf+JiIlue1aGcCVDGIqazbFrHq4kGCyiYsqM3TsFmKAo2++jGp0QgoA4Y7G
3CSWb/4UruGbAL7zhE5+FtItBHKGUNvrbVLBvHeFKz70Bh5RPs+R4bmK0Lr9ec/R
X4aFwWPdV7CQ5aNrav+C1AlrOu8efpm8asgg/Z3qWDutmUcb9cnKYWE+wCdRJKbG
IHp4j+YzYr5FUf2SzZUaokmNmd1euXnq+eiTaK6KIFgerr8wv+c01yGMA+D6dhur
SgyAfVfIqf8ot8qicfkbLqWpm+QWIjl4auIEN1KSxEtoSWFMaycuv1UKY6u83H+0
8lgZlxyruPDcaFn2nPGAdySMaCaUNw==
=b3n7
-----END PGP SIGNATURE-----

--OwSjIW0oVbSmfbAeVU3gnHOWSK1X5Awa9--
