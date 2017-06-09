Received: from eggs.gnu.org ([2001:4830:134:3::10]:57807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJLHt-0004yk-4W
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJLHs-0003ff-4n
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:53:21 -0400
References: <cover.1496844254.git.berto@igalia.com>
	<643c9f0a83c8f5c913a55a556dcddd13754d1275.1496844254.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <36215351-07f7-43ab-bad5-96ed1f6ecd61@redhat.com>
Date: Fri, 9 Jun 2017 09:53:05 -0500
MIME-Version: 1.0
In-Reply-To: <643c9f0a83c8f5c913a55a556dcddd13754d1275.1496844254.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2Ni4x5kEW3U8XwcOggGBrax9LUQDqDCAm"
Subject: Re: [Qemu-devel] [PATCH v2 4/7] qcow2: Split do_perform_cow() into
 _read(), _encrypt() and _write()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Ni4x5kEW3U8XwcOggGBrax9LUQDqDCAm
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <36215351-07f7-43ab-bad5-96ed1f6ecd61@redhat.com>
Subject: Re: [PATCH v2 4/7] qcow2: Split do_perform_cow() into _read(),
 _encrypt() and _write()
References: <cover.1496844254.git.berto@igalia.com>
 <643c9f0a83c8f5c913a55a556dcddd13754d1275.1496844254.git.berto@igalia.com>
In-Reply-To: <643c9f0a83c8f5c913a55a556dcddd13754d1275.1496844254.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2017 09:08 AM, Alberto Garcia wrote:
> This patch splits do_perform_cow() into three separate functions to
> read, encrypt and write the COW regions.
>=20
> perform_cow() can now read both regions first, then encrypt them and
> finally write them to disk. The memory allocation is also done in
> this function now, using one single buffer large enough to hold both
> regions.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 114 +++++++++++++++++++++++++++++++++++++-----=
--------
>  1 file changed, 84 insertions(+), 30 deletions(-)
>=20

Let's suppose we have a guest issuing 512-byte aligned requests and a
host that requires 4k alignment; and the guest does an operation that
needs a COW with one sector at both the front and end of the cluster.

> @@ -760,22 +776,59 @@ static int perform_cow(BlockDriverState *bs, QCow=
L2Meta *m)
>      BDRVQcow2State *s =3D bs->opaque;
>      Qcow2COWRegion *start =3D &m->cow_start;
>      Qcow2COWRegion *end =3D &m->cow_end;
> +    unsigned buffer_size =3D start->nb_bytes + end->nb_bytes;

This sets buffer_size to 1024 initially.

> +    uint8_t *start_buffer, *end_buffer;
>      int ret;
> =20
> +    assert(start->nb_bytes <=3D UINT_MAX - end->nb_bytes);
> +
>      if (start->nb_bytes =3D=3D 0 && end->nb_bytes =3D=3D 0) {
>          return 0;
>      }
> =20
> +    /* Reserve a buffer large enough to store the data from both the
> +     * start and end COW regions */
> +    start_buffer =3D qemu_try_blockalign(bs, buffer_size);

This is going to allocate a bigger buffer, namely one that is at least
4k in size (at least, that's my understanding - the block device is able
to track its preferred IO size/alignment).

> +    if (start_buffer =3D=3D NULL) {
> +        return -ENOMEM;
> +    }
> +    /* The part of the buffer where the end region is located */
> +    end_buffer =3D start_buffer + start->nb_bytes;

But now end_buffer does not have optimal alignment.  In the old code, we
called qemu_try_blockalign() twice, so that both read()s were called on
a 4k boundary; but now, the end read() is called unaligned to a 4k
boundary.  Of course, since we're only reading 512 bytes, instead of 4k,
it MIGHT not matter, but I don't know if we are going to cause a bounce
buffer to come into play that we could otherwise avoid if we were
smarter with our alignments.  Is that something we need to analyze
further, or even possibly intentionally over-allocate our buffer to
ensure optimal read alignments?

> +    /* And now we can write everything */
> +    ret =3D do_perform_cow_write(bs, m->alloc_offset, start->offset,
> +                               start_buffer, start->nb_bytes);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> =20
> +    ret =3D do_perform_cow_write(bs, m->alloc_offset, end->offset,
> +                               end_buffer, end->nb_bytes);

At any rate, other than the potential of a pessimization due to poor
alignments, your split looks sane, and it makes it more obvious that if
we set up the write iov, a later patch could then call a single
do_perform_cow_write using pwritev() over both chunks in one syscall.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2Ni4x5kEW3U8XwcOggGBrax9LUQDqDCAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOrZRAAoJEKeha0olJ0Nqco4H/22NOQzqTHBJ0gyPMxrMxc5v
xcx1kbLy/dpSWHdDlCcgRBfCPNG4k8iqwGBjs7f3UcpTht10ESKdS/aZHf++h3hD
OpX2z4ZDJMtbnmrMZxI9ff+iPAkMpjCVt2YyZQhfn7DwkgYOFYfJM/u07aOc/jUX
6UuOjuRrNlOXMd/w5wmuPEoYhW4Z18a2S0NZDSLGPMOoy8zaFfn1oRPhmohP9UYP
pZTyTigQqtS3Z/A4dU/7XNqso8SoF/WcR4J/G4VNTziH+RUdna9t6QH8ei7ChkOZ
N6rtPOWtqDeD/3pwTkDpwchpsCt2wf6dekbt1MPnIfnB/QKcEgIfSdJ293nFB+A=
=Undj
-----END PGP SIGNATURE-----

--2Ni4x5kEW3U8XwcOggGBrax9LUQDqDCAm--
