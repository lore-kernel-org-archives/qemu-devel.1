Received: from eggs.gnu.org ([2001:4830:134:3::10]:57706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAJL0-0004fT-SD
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAJKz-0006zF-V3
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:31:30 -0400
References: <cover.1509550787.git.berto@igalia.com>
	<090da3a925cd09404afb7cae97bd867697e7da21.1509550787.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8403f7a8-2ca1-d7b0-34d4-5e027112d005@redhat.com>
Date: Thu, 2 Nov 2017 18:31:18 +0100
MIME-Version: 1.0
In-Reply-To: <090da3a925cd09404afb7cae97bd867697e7da21.1509550787.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="61vr7W76UdQUbMs3XNwjtU2tN1lQKg7wx"
Subject: Re: [Qemu-devel] [PATCH 2/4] qcow2: Prevent allocating L2 tables at
 offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--61vr7W76UdQUbMs3XNwjtU2tN1lQKg7wx
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>
Message-ID: <8403f7a8-2ca1-d7b0-34d4-5e027112d005@redhat.com>
Subject: Re: [PATCH 2/4] qcow2: Prevent allocating L2 tables at offset 0
References: <cover.1509550787.git.berto@igalia.com>
 <090da3a925cd09404afb7cae97bd867697e7da21.1509550787.git.berto@igalia.com>
In-Reply-To: <090da3a925cd09404afb7cae97bd867697e7da21.1509550787.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-01 16:42, Alberto Garcia wrote:
> If the refcount data is corrupted then we can end up trying to
> allocate a new L2 table at offset 0 in the image, triggering an
> assertion in the qcow2 cache that would crash QEMU:
>=20
>   qcow2_cache_entry_mark_dirty: Assertion `c->entries[i].offset !=3D 0'=
 failed
>=20
> This patch adds an explicit check for this scenario and a new test
> case.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c      | 7 +++++++
>  tests/qemu-iotests/060     | 7 +++++++
>  tests/qemu-iotests/060.out | 6 ++++++
>  3 files changed, 20 insertions(+)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index fb10e26068..540af4d19d 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -278,6 +278,13 @@ static int l2_allocate(BlockDriverState *bs, int l=
1_index, uint64_t **table)
>          goto fail;
>      }
> =20
> +    /* If we're allocating the table at offset 0 then something is wro=
ng */
> +    if (l2_offset =3D=3D 0) {
> +        qcow2_signal_corruption(bs, true, -1, -1, "Preventing invalid =
"
> +                                "allocation of L2 table at offset 0");=

> +        return -EIO;

The other error paths in this function use a goto fail.  It doesn't make
a functional difference, but not doing it here looks a bit weird.

(Also, there's same thing about offset=3D0 and size=3Ds->cluster_size as =
in
patch 1.)

Functionally correct, though, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +    }
> +
>      ret =3D qcow2_cache_flush(bs, s->refcount_block_cache);
>      if (ret < 0) {
>          goto fail;
> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
> index dead26aeaf..40f85cc216 100755
> --- a/tests/qemu-iotests/060
> +++ b/tests/qemu-iotests/060
> @@ -253,6 +253,13 @@ poke_file "$TEST_IMG" "$rt_offset"        "\x00\x0=
0\x00\x00\x00\x00\x00\x00"
>  # causing a refcount block to be allocated at offset 0
>  $QEMU_IO -c "write 0 128k" "$TEST_IMG" | _filter_qemu_io
> =20
> +echo
> +echo "=3D=3D=3D Testing empty refcount block =3D=3D=3D"
> +echo
> +_make_test_img 64M
> +poke_file "$TEST_IMG" "$rb_offset"        "\x00\x00\x00\x00\x00\x00\x0=
0\x00"
> +$QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
> +
>  # success, all done
>  echo "*** done"
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
> index 872719009c..5b8b518486 100644
> --- a/tests/qemu-iotests/060.out
> +++ b/tests/qemu-iotests/060.out
> @@ -189,4 +189,10 @@ wrote 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  qcow2: Marking image as corrupt: Preventing invalid allocation of refc=
ount block at offset 0; further corruption events will be suppressed
>  write failed: Input/output error
> +
> +=3D=3D=3D Testing empty refcount block =3D=3D=3D
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
> +qcow2: Marking image as corrupt: Preventing invalid allocation of L2 t=
able at offset 0; further corruption events will be suppressed
> +write failed: Input/output error
>  *** done
>=20



--61vr7W76UdQUbMs3XNwjtU2tN1lQKg7wx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAln7VmYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJPoH/i+ErulfM/xe0wKlPRUDeiKD1JE3tYJ3
8xgReLLjkAB3iyZttWHFRrjUfEV2AsSkdrnrfznr8f7d4pObRfzwJzcak51dBU+O
Ob8/9FXUjCrizxfdvrPFML+8+sTJmx55cXPT1k+OVjL1wXTSi8IJlPtiolodNaRf
LnXOUuLRvxl9/GW4sdfXBggUczBm70qcTSeXQCNIBG9oGgPIpZy0g/fA9leYx4lk
YChg9Gqh29SudGZCRQUzTmNbLrZOD92BucdIsQU0/T4jHl0jnkzcJEz1JqwO3D0O
/VL8N+9z6d42mHqelA9hLVIKVzeGNN2U+BSe0ndSkqJWgXuykGMI6qM=
=1U5k
-----END PGP SIGNATURE-----

--61vr7W76UdQUbMs3XNwjtU2tN1lQKg7wx--
