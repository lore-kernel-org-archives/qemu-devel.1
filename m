Received: from eggs.gnu.org ([209.51.188.92]:48244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjnYE-0008JH-68
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjnYC-0000kG-5t
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:56:22 -0500
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
	<20180731173033.75467-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9ebc0045-6192-b88a-f94f-4c0ed62a5b2b@redhat.com>
Date: Wed, 16 Jan 2019 09:56:15 -0600
MIME-Version: 1.0
In-Reply-To: <20180731173033.75467-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tLq4n0owNrohVu6fIPseughJefuoxG2vD"
Subject: Re: [Qemu-devel] [PATCH v4 02/10] block/nbd: move connection code
 from block/nbd to block/nbd-client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tLq4n0owNrohVu6fIPseughJefuoxG2vD
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Message-ID: <9ebc0045-6192-b88a-f94f-4c0ed62a5b2b@redhat.com>
Subject: Re: [PATCH v4 02/10] block/nbd: move connection code from block/nbd
 to block/nbd-client
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
 <20180731173033.75467-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7/31/18 12:30 PM, Vladimir Sementsov-Ogievskiy wrote:
> Keep all connection code in one file, to be able to implement reconnect=

> in further patches.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.h |  2 +-
>  block/nbd-client.c | 37 +++++++++++++++++++++++++++++++++++--
>  block/nbd.c        | 40 ++--------------------------------------
>  3 files changed, 38 insertions(+), 41 deletions(-)
>=20

> @@ -1001,12 +1033,14 @@ int nbd_client_init(BlockDriverState *bs,
>      g_free(client->info.x_dirty_bitmap);
>      if (ret < 0) {
>          logout("Failed to negotiate with the NBD server\n");
> +        object_unref(OBJECT(sioc));
>          return ret;
>      }
>      if (client->info.flags & NBD_FLAG_READ_ONLY &&
>          !bdrv_is_read_only(bs)) {
>          error_setg(errp,
>                     "request for write access conflicts with read-only =
export");
> +        object_unref(OBJECT(sioc));
>          return -EACCES;
>      }

Conflicts with changes committed in the meantime. I think I can resolve
the conflicts, but you may want to post a v5.

The patch itself looks reasonable;
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--tLq4n0owNrohVu6fIPseughJefuoxG2vD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/VB8ACgkQp6FrSiUn
Q2q6UggAsDDMFy0p2nxR6hL+/VEk4tKbmBWR3vnYIsioIaGXiCxqZn7jgPuLbYon
UrB81Km8Mz0P8csChRLFPGtee06YLhv9+vOU7zfRiXDGM3OpJY3raLSF5tMKUWWm
zcRlByh2jsVc6BDB8dl7L2Sz6LAecRRQAn1o4x5mghZcRvwxKe69eX7n9/dsQ2NH
TO8NAilLdV5VXHEknwhDftiKfZpHHQW+owt5gEAHpIiqBFGPdChctbsUbGkqZ+Yy
8213VJf4P0LKplz+nlRevQdv+m56E74/V1Wl/nlj9f8ejFxZ1Of1je/3W7KuzohM
ZOpsoxUeA7Ls4grkdrkWc2IgYfn3kQ==
=wKJo
-----END PGP SIGNATURE-----

--tLq4n0owNrohVu6fIPseughJefuoxG2vD--
