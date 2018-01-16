Received: from eggs.gnu.org ([2001:4830:134:3::10]:43060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZgx-0008RN-KJ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZgw-0006NO-N3
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:26:51 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<192986ad741749064e855bc67916a11460911992.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a634b25e-08d3-349e-7b71-6d25d7c7bc2c@redhat.com>
Date: Tue, 16 Jan 2018 16:26:40 -0600
MIME-Version: 1.0
In-Reply-To: <192986ad741749064e855bc67916a11460911992.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Of2l5qAKS1pJBiRjvPUbDxnPHqVumwZ1B"
Subject: Re: [Qemu-devel] [PATCH v2 16/32] qcow2: Update l2_allocate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Of2l5qAKS1pJBiRjvPUbDxnPHqVumwZ1B
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <a634b25e-08d3-349e-7b71-6d25d7c7bc2c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 16/32] qcow2: Update l2_allocate() to
 support L2 slices
References: <cover.1513342045.git.berto@igalia.com>
 <192986ad741749064e855bc67916a11460911992.1513342045.git.berto@igalia.com>
In-Reply-To: <192986ad741749064e855bc67916a11460911992.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This patch updates l2_allocate() to support the qcow2 cache returning
> L2 slices instead of full L2 tables.
>=20
> The old code simply gets an L2 table from the cache and initializes it
> with zeroes or with the contents of an existing table. With a cache
> that returns slices instead of tables the idea remains the same, but
> the code must now iterate over all the slices that are contained in an
> L2 table.
>=20
> Since now we're operating with slices the function can no longer
> return the newly-allocated table, so it's up to the caller to retrieve
> the appropriate L2 slice after calling l2_allocate() (note that with
> this patch the caller is still loading full L2 tables, but we'll deal
> with that in a separate patch).
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 86 +++++++++++++++++++++++++++++++------------=
--------
>  1 file changed, 52 insertions(+), 34 deletions(-)
>=20

> @@ -299,42 +300,50 @@ static int l2_allocate(BlockDriverState *bs, int =
l1_index, uint64_t **table)
> =20
>      /* allocate a new entry in the l2 cache */
> =20
> +    slice_size =3D s->l2_slice_size * sizeof(uint64_t);

Would this read any better if the earlier patch named it
s->l2_slice_entries?  (When I see size, I try to think bytes, even
though the earlier patch made l2_slice_size be the number of entries;
worse, you are multiplying it back to a local variable slice_size that
IS in bytes).


> +
> +        /* write the l2 slice to the file */
> +        BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_WRITE);
> =20
> -    /* write the l2 table to the file */
> -    BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_WRITE);
> +        trace_qcow2_l2_allocate_write_l2(bs, l1_index);
> +        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
> +        ret =3D qcow2_cache_flush(bs, s->l2_table_cache);

As Anton pointed out, flushing the cache seems like you could do it once
after the loop rather than on each iteration.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Of2l5qAKS1pJBiRjvPUbDxnPHqVumwZ1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpefCAACgkQp6FrSiUn
Q2rd1wgAh8vUwt9dAUAqHukQ4NhMcDqtTd4dTDRDlCBiDEnjCHBq7YHeTn8voaKJ
778s1Nns7ghZbKr2lcUlL7bRahfMklJfgFZKwiESWX0e2/buNUTVEkqmsuZ1A31x
zwD1BLDR/DMx3jrX4pSSx41e14aF8Zjts+AMswq2XIwOuqqYLyJz/hs/2iTtM+L7
XNOj0IV7YAPa9n4+AIWDW/JwRGtiFAZjuIpMviFvZsHdQf7BU7MTebqv5SBWiXs7
DbOMGA2pimwergSNRvkdWEBmGciBE6ipMAjc00Hl1aKE5YuEpAXDy82gRhAxhL5Y
eIUavTeSsFMZpdbgdZq1gMt6L9NwZA==
=Hu+H
-----END PGP SIGNATURE-----

--Of2l5qAKS1pJBiRjvPUbDxnPHqVumwZ1B--
