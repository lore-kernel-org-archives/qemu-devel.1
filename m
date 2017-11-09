Received: from eggs.gnu.org ([2001:4830:134:3::10]:45727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCty8-0004XT-UC
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 16:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCty7-0002aM-Vj
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 16:02:36 -0500
References: <20171109204315.27072-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e9e49f18-cf12-1dc0-4bd0-ae67c36fb30c@redhat.com>
Date: Thu, 9 Nov 2017 15:02:23 -0600
MIME-Version: 1.0
In-Reply-To: <20171109204315.27072-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7GLlIaXjhV7QjxOD97oFEu8TGtS3HrGBd"
Subject: Re: [Qemu-devel] [PATCH for-2.11] block: Keep strong reference when
 draining all BDS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7GLlIaXjhV7QjxOD97oFEu8TGtS3HrGBd
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <e9e49f18-cf12-1dc0-4bd0-ae67c36fb30c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] block: Keep strong reference when
 draining all BDS
References: <20171109204315.27072-1-mreitz@redhat.com>
In-Reply-To: <20171109204315.27072-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/2017 02:43 PM, Max Reitz wrote:
> Draining a BDS may lead to graph modifications, which in turn may resul=
t
> in it and other BDS being stripped of their current references.  If
> bdrv_drain_all_begin() and bdrv_drain_all_end() do not keep strong
> references themselves, the BDS they are trying to drain (or undrain) ma=
y
> disappear right under their feet -- or, more specifically, under the
> feet of BDRV_POLL_WHILE() in bdrv_drain_recurse().
>=20
> This fixes an occasional hang of iotest 194.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/io.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 3 deletions(-)

> +
> +        /* Keep a strong reference to all root BDS and copy them into
> +         * an own list because draining them may lead to graph

'an own' sounds awkward; maybe 'copy them into a local list'

> +         * modifications. */
> +        bdrv_ref(bs);
> +        bs_list =3D g_slist_prepend(bs_list, bs);
>      }

>  void bdrv_drain_all_end(void)
>  {
>      BlockDriverState *bs;
>      BdrvNextIterator it;
> +    GSList *bs_list =3D NULL, *bs_list_entry;
> +
> +    /* Must be called from the main loop */
> +    assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context(=
));
> =20
> +    /* Keep a strong reference to all root BDS and copy them into an
> +     * own list because draining them may lead to graph modifications.=


And again.

With that tweak,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7GLlIaXjhV7QjxOD97oFEu8TGtS3HrGBd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEwl8ACgkQp6FrSiUn
Q2oUWQf/YW6HXhEpemh3wgKEpz4lYy6FacOxrJjmM6nuj4UKb6DPKDQYu5b+ccgZ
cRASG3tcljlHbq8TcK2n6wRV5C353Sj6zd0sdodRK9Xw9XV4B7e8FZZDvKDoNSP4
lNau4na8DwlZYmQjqfo1HiZpm+yJcM4rPxVCb4IfyC2f8ri/RpF88zTbYfEst73y
pifj8hXncDdWfKVD5xQWBDjyEApF5Tf9EI25kJbC40a/EcEVR3hZQ8MOdPgN4P2C
vBm0gbTse3NFiCiTUm3YsPCjH69zm8GyDm6Go/EFcVLK9cuXF1TZunm0UNjgT01g
flhOgApdIAibf23v2+yjyJp1VjyK4g==
=M7rU
-----END PGP SIGNATURE-----

--7GLlIaXjhV7QjxOD97oFEu8TGtS3HrGBd--
