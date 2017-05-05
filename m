Received: from eggs.gnu.org ([2001:4830:134:3::10]:60125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6lo8-0005zN-5W
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6lo7-0008KF-3i
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:34:40 -0400
References: <20170429191419.30051-1-eblake@redhat.com>
	<20170429191419.30051-10-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9ba6f9fa-5ac7-894c-4112-ec0ca36eb82c@redhat.com>
Date: Sat, 6 May 2017 00:34:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170429191419.30051-10-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oDWFLNkb3iT5B8lTQxsRUUr0CrT45Uc98"
Subject: Re: [Qemu-devel] [PATCH v11 9/9] tests: Add coverage for recent
 block geometry fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oDWFLNkb3iT5B8lTQxsRUUr0CrT45Uc98
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <9ba6f9fa-5ac7-894c-4112-ec0ca36eb82c@redhat.com>
Subject: Re: [PATCH v11 9/9] tests: Add coverage for recent block geometry
 fixes
References: <20170429191419.30051-1-eblake@redhat.com>
 <20170429191419.30051-10-eblake@redhat.com>
In-Reply-To: <20170429191419.30051-10-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.04.2017 21:14, Eric Blake wrote:
> Use blkdebug's new geometry constraints to emulate setups that
> have needed past regression fixes: write zeroes asserting
> when running through a loopback block device with max-transfer
> smaller than cluster size, and discard rounding away portions
> of requests not aligned to preferred boundaries.  Also, add
> coverage that the block layer is honoring max transfer limits.
>=20
> For now, a single iotest performs all actions, with the idea
> that we can add future blkdebug constraint test cases in the
> same file; but it can be split into multiple iotests if we find
> reason to run one portion of the test in more setups than what
> are possible in the other.
>=20
> For reference, the final portion of the test (checking whether
> discard passes as much as possible to the lowest layers of the
> stack) works as follows:
>=20
> qemu-io: discard 30M at 80000001, passed to blkdebug
>   blkdebug: discard 511 bytes at 80000001, -ENOTSUP (smaller than
> blkdebug's 512 align)
>   blkdebug: discard 14371328 bytes at 80000512, passed to qcow2
>     qcow2: discard 739840 bytes at 80000512, -ENOTSUP (smaller than
> qcow2's 1M align)
>     qcow2: discard 13M bytes at 77M, succeeds
>   blkdebug: discard 15M bytes at 90M, passed to qcow2
>     qcow2: discard 15M bytes at 90M, succeeds
>   blkdebug: discard 1356800 bytes at 105M, passed to qcow2
>     qcow2: discard 1M at 105M, succeeds
>     qcow2: discard 308224 bytes at 106M, -ENOTSUP (smaller than qcow2's=

> 1M align)
>   blkdebug: discard 1 byte at 111457280, -ENOTSUP (smaller than
> blkdebug's 512 align)
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> ---
> v11: rebase to context
> v10: no change, rebase to context
> v9: no change
> v7-v8: not submitted (earlier half of series sent for 2.9)
> v6: rebase to master by renumbering s/175/177/
> v5: rebase to master by renumbering s/173/175/
> v4: clean up some comments, nicer backing file creation, more commit me=
ssage
> v3: make comments tied more to test at hand, rather than the
> particular hardware that led to the earlier patches being tested
> v2: new patch
> ---
>  tests/qemu-iotests/177     | 114 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/177.out |  49 +++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 164 insertions(+)
>  create mode 100755 tests/qemu-iotests/177
>  create mode 100644 tests/qemu-iotests/177.out
>=20
> diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
> new file mode 100755
> index 0000000..e4ddec7
> --- /dev/null
> +++ b/tests/qemu-iotests/177

[...]

> +echo
> +echo "=3D=3D verify image content =3D=3D"
> +
> +function verify_io()
> +{
> +    if ($QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" |
> +	    grep "compat: 0.10" > /dev/null); then
> +        # For v2 images, discarded clusters are read from the backing =
file
> +        discarded=3D11
> +    else
> +        # Discarded clusters are zeroed for v3 or later
> +        discarded=3D0
> +    fi
> +
> +    echo read -P 22 0 1000
> +    echo read -P 33 1000 128k
> +    echo read -P 22 132072 7871512
> +    echo read -P 0 8003584 2093056
> +    echo read -P 22 10096640 23457792
> +    echo read -P 0 32M 32M
> +    echo read -P 22 64M 13M
> +    echo read -P $discarded 77M 29M
> +    echo read -P 22 106M 22M
> +}
> +
> +verify_io | $QEMU_IO "$TEST_IMG" | _filter_qemu_io

This conflicts with Fam's image locking series that has been introduced
in the meantime (and unfortunately I'm the one who has to base his block
queue on Kevin's...). I suppose it's because the qemu_io process is
launched before the qemu_img info process.

Simply adding an -r to the qemu_io command fixes this, however. I'll do
so in my branch, assuming you're OK with that. :-)

Max


--oDWFLNkb3iT5B8lTQxsRUUr0CrT45Uc98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkM/fYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKqUH/iVHFbavwEAhEDEpSunZntvuYcZK1qm6
DmzIErUQTlo0wRHF+VL88ufdY9MMfRqYf/k7YD3fx9Xbn6yA74y0z94//XxdcVLR
sY+M7eII/39Tl/kWkJyr8N5RUmAltcKhUp9CDMkCEkTMDTSvv1gRE7qdmrFvL0EH
GLujZ+U9NSD0hkJwkal0O1e8qcfOkmBMjeK4lyoCuqjZeOckfB0g38dsiv9k4e3v
u6vEkkNuSjkSS67PbxitffOaMrUdbjca6IyV85nJiQG0wMafacwsjYGyjiGkyF+g
ZEPLrBbNq0/ylJ6gudBXVjs56S/uq4sNBRhKT5twd/G92tFGapsuQxM=
=dVtN
-----END PGP SIGNATURE-----

--oDWFLNkb3iT5B8lTQxsRUUr0CrT45Uc98--
