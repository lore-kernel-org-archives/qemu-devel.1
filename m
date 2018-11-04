Received: from eggs.gnu.org ([2001:4830:134:3::10]:57188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJSH7-0008Sj-KD
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 18:57:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJSH6-0002Wy-NY
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 18:57:49 -0500
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
	<1539981546-10596-4-git-send-email-Liam.Merwick@oracle.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4aeb3510-9ff4-73e0-f371-58b974dce9e4@redhat.com>
Date: Mon, 5 Nov 2018 00:57:37 +0100
MIME-Version: 1.0
In-Reply-To: <1539981546-10596-4-git-send-email-Liam.Merwick@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nbKQsiY8o4SlTYixTT7k5rW4GdsPT3Pv8"
Subject: Re: [Qemu-devel] [PATCH v4 3/8] block: Null pointer dereference in
 blk_root_get_parent_desc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nbKQsiY8o4SlTYixTT7k5rW4GdsPT3Pv8
From: Max Reitz <mreitz@redhat.com>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 berrange@redhat.com
Message-ID: <4aeb3510-9ff4-73e0-f371-58b974dce9e4@redhat.com>
Subject: Re: [PATCH v4 3/8] block: Null pointer dereference in
 blk_root_get_parent_desc()
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
 <1539981546-10596-4-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1539981546-10596-4-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.10.18 22:39, Liam Merwick wrote:
> The dev_id returned by the call to blk_get_attached_dev_id() in
> blk_root_get_parent_desc() can be NULL (an internal call to
> object_get_canonical_path may have returned NULL).
>=20
> Instead of just checking this case before before dereferencing,
> adjust blk_get_attached_dev_id() to return the empty string if no
> object path can be found (similar to the case when blk->dev is NULL
> and an empty string is returned).
>=20
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> ---
>  block/block-backend.c | 6 +++++-
>  dtc                   | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index dc0cd5772413..e628920f3cd8 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -909,6 +909,7 @@ void *blk_get_attached_dev(BlockBackend *blk)
>  char *blk_get_attached_dev_id(BlockBackend *blk)
>  {
>      DeviceState *dev;
> +    char *dev_id;
> =20
>      assert(!blk->legacy_dev);
>      dev =3D blk->dev;
> @@ -918,7 +919,10 @@ char *blk_get_attached_dev_id(BlockBackend *blk)
>      } else if (dev->id) {
>          return g_strdup(dev->id);
>      }
> -    return object_get_canonical_path(OBJECT(dev));
> +
> +    dev_id =3D object_get_canonical_path(OBJECT(dev));
> +
> +    return dev_id ? dev_id : g_strdup("");
>  }
> =20
>  /*

Looks good, but since you'll have to respin anyway because of the hunk
below, you may want to consider

    return object_get_canonical_path(OBJECT(dev)) ?: g_strdup("");

instead.  (We have several instances of binary "?:" in the code already,
so it's fine to use it.  Of course you don't have to, though, if you
don't like it.)

> diff --git a/dtc b/dtc
> index 88f18909db73..e54388015af1 160000
> --- a/dtc
> +++ b/dtc
> @@ -1 +1 @@
> -Subproject commit 88f18909db731a627456f26d779445f84e449536
> +Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42

I don't think this hunk belongs here.

Max


--nbKQsiY8o4SlTYixTT7k5rW4GdsPT3Pv8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvfh3IACgkQ9AfbAGHV
z0BXCwgAt83KnHJXYxLEZdwEg+/d4a1+ivlZbqtrzO0cNib7QRY8hQtyZxdnL/W5
wxdq4znJE9OswFSp72PWfy+VboLT+zfw2nujQdEe6lwC7eMfGlXj/lGe2Ipwa9r8
8XLfiDwoAAeOFfqpZkq+HBu7w8hH6frNleKkdXdwzrE8zSFy+vQlRP5h4X7FVnwh
In9jkPlRurgMg31zvvbCa9wCFvZy1LdSCFi9/2R/4sqkO18kh028rlmBMUEPrTyd
mOoOPi/QNl9HMP/5SHmVtL6gwVLfwUcQmTBr6Vr/wUOq4I68eHQiAWrw3tfZEwlU
3TZ6rNdCPDQZqlKBULzQme7MS9dDtA==
=Rwwd
-----END PGP SIGNATURE-----

--nbKQsiY8o4SlTYixTT7k5rW4GdsPT3Pv8--
