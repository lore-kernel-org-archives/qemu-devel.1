Received: from eggs.gnu.org ([209.51.188.92]:56519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGm6u-0001Ub-At
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGm6s-0004kj-2W
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:04:28 -0400
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
	<20190417100929.39943-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4552f220-7180-2d19-edf5-465bebe74011@redhat.com>
Date: Wed, 17 Apr 2019 10:04:05 -0500
MIME-Version: 1.0
In-Reply-To: <20190417100929.39943-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b7IjwEYe6rlrgZ9whkczUR3SGKmYgVLAI"
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: test big qcow2 shrink
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, mreitz@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b7IjwEYe6rlrgZ9whkczUR3SGKmYgVLAI
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, mreitz@redhat.com,
 stefanha@redhat.com
Message-ID: <4552f220-7180-2d19-edf5-465bebe74011@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: test big qcow2 shrink
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
 <20190417100929.39943-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190417100929.39943-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/17/19 5:09 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/249     | 69 ++++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/249.out | 30 +++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 100 insertions(+)
>  create mode 100755 tests/qemu-iotests/249
>  create mode 100644 tests/qemu-iotests/249.out

> +
> +# This test checks bug in qcow2_process_discards, fixed by previous co=
mmit.

This sentence makes sense in a commit message, but is a bit stale in the
test itself. Simpler to just state:

This test checks that qcow2_process_discards does not truncate a discard
request > 2G.

> +# The problem was that bdrv_pdiscard was called with uint64_t bytes pa=
rameter
> +# which was cropped to int.

then drop this sentence.

> +# To reproduce bug we need to overflow int by one sequential discard, =
so we
> +# need size > 2G, bigger cluster size (as with default 64k we may have=
 maximum
> +# of 512M sequential data, corresponding to one L1 entry, and we need =
to write

s/entry,/entry),/

> +# at offset 0 at last, to prevent bdrv_co_truncate(bs->file) in
> +# qcow2_co_truncate to stole the whole effect of failed discard.

and we need a second write at offset 0 to prevent
bdrv_co_truncate(bs->file) from short-circuiting the entire discard.

> +
> +size=3D2300M
> +IMGOPTS=3D"cluster_size=3D1M"
> +
> +_make_test_img $size
> +$QEMU_IO -c 'write 100M 2000M' -c 'write 2100M 200M' \
> +    -c 'write 0 100M' "$TEST_IMG" | _filter_qemu_io

This takes a LONG time to produce; and when I tried it on a 32-bit
machine, I got an ENOMEM failure for being unable to allocate a 2000M
buffer. Is there any faster way to produce a similar setup, perhaps by
manually messing with the qcow2 file rather than directly writing that
much consecutive data?  Even if there isn't, you'll want to at least
make the test gracefully skip rather than fail if it hits ENOMEM.

> +Image resized.
> +image: TEST_DIR/t.qcow2
> +file format: qcow2
> +virtual size: 50M (52428800 bytes)
> +disk size: 54M

I confirmed that when patch 1/2 is not present, this reports 2.2G
instead of 54M.

The output here will need tweaking if my patch to rework qemu-img
human-readable sizing lands first (it's currently queued on Kevin's
block-next tree, but needs a rework to fix a few more iotests and to
resolve a 32-bit compilation issue).

> +++ b/tests/qemu-iotests/group
> @@ -248,3 +248,4 @@
>  246 rw auto quick
>  247 rw auto quick
>  248 rw auto quick
> +249 rw auto
>=20

I agree that this isn't quick. I will also point out that at least three
earlier messages have also claimed 249:

Berto: [PATCH for-4.1 v2 2/2] iotests: Check that images are in
read-only mode after block-commit

Max: [PATCH v3 6/7] iotests: Test qemu-img convert --salvage

and yourself :) [PATCH v6 7/7] iotests: test nbd reconnect

so someone gets to rename.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--b7IjwEYe6rlrgZ9whkczUR3SGKmYgVLAI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly3QGUACgkQp6FrSiUn
Q2ofMQf/TNW2ExLgqJAwqfL3kJun0YPWhLj/aCzwPQF4L4DMtg+tB4FAI1MRC/Dj
aY9fX+1wpVr1YFyzxcz98aXpAFrxrSsWGWWIIYfUzXTCJAT706pPVqKtHvunw6DQ
O7I/9V+eiSZuBr/5M1rWBU0v2QLqAwqcZrEgTxmDz6kO03OcZWkdn78RICrKVtBc
Y1K+Va5k9U/tuAagIF0YAAH+70QIekQPSLJ3+DEvkbxQVqeMFmcF3IH8jhYTsMLl
hZ9D/KuTopLeD5x8ygxVXovxwwF6rSPv2loBSvraHiiRUhX9sATFJoYmnfYGDToE
tyOhOrUA3n3+q8pMmfEwHkcacGcJpg==
=KvL8
-----END PGP SIGNATURE-----

--b7IjwEYe6rlrgZ9whkczUR3SGKmYgVLAI--
