Received: from eggs.gnu.org ([2001:4830:134:3::10]:36106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8nic-0004dU-1G
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8niL-00008Z-N4
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:05:54 -0400
References: <20180413181401.46318-1-vsementsov@virtuozzo.com>
	<20180413181401.46318-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dc98f4cc-e863-2c1a-9729-a049229a40e6@redhat.com>
Date: Wed, 18 Apr 2018 09:05:16 -0500
MIME-Version: 1.0
In-Reply-To: <20180413181401.46318-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9OqbMaweZhHiJFVEQXhvr8ciTvbvtCIHj"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, pbonzini@redhat.com, armbru@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9OqbMaweZhHiJFVEQXhvr8ciTvbvtCIHj
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, pbonzini@redhat.com,
 armbru@redhat.com, jsnow@redhat.com
Message-ID: <dc98f4cc-e863-2c1a-9729-a049229a40e6@redhat.com>
Subject: Re: [PATCH v2 2/3] nbd/server: implement dirty bitmap export
References: <20180413181401.46318-1-vsementsov@virtuozzo.com>
 <20180413181401.46318-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180413181401.46318-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2018 01:14 PM, Vladimir Sementsov-Ogievskiy wrote:
> Handle new NBD meta namespace: "qemu", and corresponding queries:
> "qemu:dirty-bitmap:<export bitmap name>".
>=20
> With new metadata context negotiated, BLOCK_STATUS query will reply
> with dirty-bitmap data, converted to extents. New public function
> nbd_export_bitmap selects bitmap to export. For now, only one bitmap
> may be exported.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h |   6 ++
>  nbd/server.c        | 234 ++++++++++++++++++++++++++++++++++++++++++++=
++++----
>  2 files changed, 224 insertions(+), 16 deletions(-)
>=20

> =20
> +/* nbd_meta_bitmap_query
> + *
> + * Handle query to 'qemu-dirty-bitmap' namespace.

Stale comment

> + * 'len' is the amount of text remaining to be read from the current n=
ame, after
> + * the 'qemu-dirty-bitmap:' portion has been stripped.

and again

> + *
> + * Return -errno on I/O error, 0 if option was completely handled by
> + * sending a reply about inconsistent lengths, or 1 on success. */
> +static int nbd_meta_bitmap_query(NBDClient *client, NBDExportMetaConte=
xts *meta,
> +                                 uint32_t len, Error **errp)
> +{
> +    if (!client->exp->export_bitmap) {
> +        return nbd_opt_skip(client, len, errp);
> +    }
> +
> +    return nbd_meta_single_query(
> +            client, client->exp->export_bitmap_context + strlen("qemu:=
"), len,
> +            &meta->dirty_bitmap, errp);

Wait, so client->exp->export_bitmap_context is stored WITH the "qemu:"
prefix as part of the name?

During _LIST, you are allowing a query of "qemu:" to list all
qemu-specific contexts (namely, qemu:dirty-bitmap:<export-name>); but
should we also make it work that if you do "qemu:dirty-bitmap:", you get
a list of just dirty-bitmap contexts even if "qemu:" has added other
contexts in the meantime?

> @@ -1800,6 +1851,94 @@ static int nbd_co_send_block_status(NBDClient *c=
lient, uint64_t handle,
>      return nbd_co_send_extents(client, handle, &extent, 1, context_id,=
 errp);
>  }
> =20
> +/* Set several extents, describing region of given @length with given =
@flags.
> + * Do not set more than @nb_extents, return number of set extents.
> + */
> +static unsigned add_extents(NBDExtent *extents, unsigned nb_extents,
> +                            uint64_t length, uint32_t flags)
> +{
> +    unsigned i =3D 0;
> +    uint32_t max_extent =3D QEMU_ALIGN_DOWN(INT32_MAX, 512);
> +    /* TODO: should be somehow in agreement with blocksize of OPT_GO,
> +     * and this should be documented in NBD proto. */

nbd.git commit 218c446 documented that descriptor lengths MUST be an
integer multiple of minimum block size; as for maximum, I see no reason
why BLOCK_STATUS can't report larger extents than what NBD_CMD_READ can
do.  Do we need further doc tweaks to nbd.git?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9OqbMaweZhHiJFVEQXhvr8ciTvbvtCIHj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrXUJwACgkQp6FrSiUn
Q2q+1wf/X9Xtiyk0a4yHPChKk7He8cJHZecJ1CqRZIea/J/SdretyGev7eEqg1Ox
31pFRQ9OlXpW0ea0GgZs0v+TKi6DDxY845YS0fqhcpxwOb+0MVYwelEaiXCQ1eSL
bLW8Q7jLl66eaUdF49N+vZ9N9wvrfZkbeMsS/HuWIKxIM/vELbbnQyFzP0FSVIe6
wK5rF8qS4FDon11340uyxsnl0tpnlBu7rfPm/SGotYBU4Y4uwT6wynkIbvFKMB4/
mLX9IIPCgSe7Lvk2Z0D70zux+9TMq3yAjy3SrB7AAbktJd7G8wqZJN9PX0Ipc+Qe
SfIyORg7mEjQ2vZlkt2rXyA0GVTFSw==
=Ukcj
-----END PGP SIGNATURE-----

--9OqbMaweZhHiJFVEQXhvr8ciTvbvtCIHj--
