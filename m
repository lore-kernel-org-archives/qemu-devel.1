Received: from eggs.gnu.org ([2001:4830:134:3::10]:33734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce0f6-0006uM-Tf
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce0f2-0005MW-0V
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:34:28 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-2-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1012b97a-db5f-9f2c-04c5-c9912a2e71f8@redhat.com>
Date: Wed, 15 Feb 2017 15:34:07 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-2-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2g03l0iA17Ot4xpB9WShRU5NLxW3bxb0S"
Subject: Re: [Qemu-devel] [RFC PATCH 01/41] block: Attach bs->file only
 during .bdrv_open()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2g03l0iA17Ot4xpB9WShRU5NLxW3bxb0S
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <1012b97a-db5f-9f2c-04c5-c9912a2e71f8@redhat.com>
Subject: Re: [RFC PATCH 01/41] block: Attach bs->file only during .bdrv_open()
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-2-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> The way that attaching bs->file worked was a bit unusual in that it was=

> the only child that would be attached to a node which is not opened yet=
=2E
> Because of this, the block layer couldn't know yet which permissions th=
e
> driver would eventually need.
>=20
> This patch moves the point where bs->file is attached to the beginning
> of the individual .bdrv_open() implementations, so drivers already know=

> what they are going to do with the child. This is also more consistent
> with how driver-specific children work.

Can't say I'm convinced by this because I personally do consider
bs->file to be special. It's fine and maybe even good if it's not like
driver-specific children (or even bs->backing).

But the fact that it doesn't work with a good op blocker model is more
than compelling.

> bdrv_open() still needs its own BdrvChild to perform image probing, but=

> instead of directly assigning this BdrvChild to the BDS, it becomes a
> temporary one and the node name is passed as an option to the drivers,
> so that they can simply use bdrv_open_child() to create another
> reference for their own use.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                       | 34 +++++++++++++++++++++++-----------
>  block/bochs.c                 |  6 ++++++
>  block/cloop.c                 |  6 ++++++
>  block/crypto.c                |  6 ++++++
>  block/dmg.c                   |  6 ++++++
>  block/parallels.c             |  6 ++++++
>  block/qcow.c                  |  6 ++++++
>  block/qcow2.c                 | 18 +++++++++++++++---
>  block/qed.c                   | 18 +++++++++++++++---
>  block/raw-format.c            |  6 ++++++
>  block/replication.c           |  6 ++++++
>  block/vdi.c                   |  6 ++++++
>  block/vhdx.c                  |  6 ++++++
>  block/vmdk.c                  |  6 ++++++
>  block/vpc.c                   |  6 ++++++
>  tests/qemu-iotests/051.out    |  4 ++--
>  tests/qemu-iotests/051.pc.out |  4 ++--
>  17 files changed, 129 insertions(+), 21 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 743c349..0618f4b 100644
> --- a/block.c
> +++ b/block.c
> @@ -1103,13 +1103,6 @@ static int bdrv_open_common(BlockDriverState *bs=
, BdrvChild *file,
>          assert(!drv->bdrv_needs_filename || filename !=3D NULL);
>          ret =3D drv->bdrv_file_open(bs, options, open_flags, &local_er=
r);
>      } else {
> -        if (file =3D=3D NULL) {
> -            error_setg(errp, "Can't use '%s' as a block driver for the=
 "
> -                       "protocol level", drv->format_name);
> -            ret =3D -EINVAL;
> -            goto free_and_fail;
> -        }

Interesting. I like that this explicit check becomes unnecessary. I'm
not sure whether I like how the error messages changes, but I can't say
that I was a fan of this one to begin with.

> -        bs->file =3D file;
>          ret =3D drv->bdrv_open(bs, options, open_flags, &local_err);
>      }
> =20
> @@ -1145,7 +1138,6 @@ static int bdrv_open_common(BlockDriverState *bs,=
 BdrvChild *file,
>      return 0;
> =20
>  free_and_fail:
> -    bs->file =3D NULL;
>      g_free(bs->opaque);
>      bs->opaque =3D NULL;
>      bs->drv =3D NULL;
> @@ -1368,7 +1360,18 @@ void bdrv_unref_child(BlockDriverState *parent, =
BdrvChild *child)
>      }
> =20
>      if (child->bs->inherits_from =3D=3D parent) {
> -        child->bs->inherits_from =3D NULL;
> +        BdrvChild *c;
> +
> +        /* Remove inherits_from only when the last reference between p=
arent and
> +         * child->bs goes away. */
> +        QLIST_FOREACH(c, &parent->children, next) {
> +            if (c !=3D child && c->bs =3D=3D child->bs) {
> +                break;
> +            }
> +        }

That's pretty kaputt. I'm not sure if I like it.

(But I like the reason for this even less, see below.)

> +        if (c =3D=3D NULL) {
> +            child->bs->inherits_from =3D NULL;
> +        }
>      }
> =20
>      bdrv_root_unref_child(child);
> @@ -1789,13 +1792,19 @@ static BlockDriverState *bdrv_open_inherit(cons=
t char *filename,
>          qdict_del(options, "backing");
>      }
> =20
> -    /* Open image file without format layer */
> +    /* Open image file without format layer. This BdrvChild is only us=
ed for
> +     * probing, the block drivers will do their own bdrv_open_child() =
for the
> +     * same BDS, which is why we put the node name back into options. =
*/
>      if ((flags & BDRV_O_PROTOCOL) =3D=3D 0) {
>          file =3D bdrv_open_child(filename, options, "file", bs,
>                                 &child_file, true, &local_err);
>          if (local_err) {
>              goto fail;
>          }
> +        if (file !=3D NULL) {
> +            qdict_put(options, "file",
> +                      qstring_from_str(bdrv_get_node_name(file->bs)));=

> +        }

Verrry interesting. I would say "Well, I guess it works" but I can't say
I'm glad with how it requires multiple BdrvChild pointing to the same
BDS attached to the same parent. Not only that, but both children have
the same BdrvChild.name which I don't like at all. In my opinion, that
name is supposed to be a unique ID and I don't find the fact that it's
just temporary a very good excuse. Neither do I find "Well, they have
the same ID and point to the same BDS, so it doesn't really matter" very
compelling. (Worsened by the fact that the block driver can just choose
to attach some other BDS as its file, then both "file" children no
longer point to the same BDS.)

Actually, I'd be happier if you just invoked bdrv_ref() and
bdrv_unref_child() (or just bdrv_detach_child(), I don't think NULLing
inherits_from is important here) right after bdrv_open_child().

We want @file for probing and probing only. It should be independent of
@bs now. The only reason I'm not proposing using bdrv_open_inherit()
directly is because using bdrv_open_child() saves us from having to
extract the file's options. But I don't see why @file should be
connected to @bs after this point (until the block driver potentially
decides to re-attach it as bs->file, but bdrv_open_child() will handle
all of that).

Max


--2g03l0iA17Ot4xpB9WShRU5NLxW3bxb0S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlikZt8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AcIQH/3oQWZ03JdNqgwzn3V+MeuZrIdCa8Dv4
ZGwNmtmYtaxmcA6VfhBT9SX3PqjGFXyAFE4iQNNZr6kXQVfiVCneCyWEQXyBHA+f
UvesX2G9EhoakQRGuqocaZZJGZehX99RT1gmJNl8CjQdpHnrJ0/x/kTjAF0L5LHb
meLgu9LrgoR2kz0yXmCOaqYunXgATXFoCB3XrVz60wBJk6cuH+nltChnsZbFlsOh
+rpIKiBOr4PnYSbg9mq/qcqanQFi/7NXTjlt8oM8oim6EwgzoDMURAEXFBbytbcF
bycpvjwmHOjPXtsVFJjOtSPIGbG4supry/hW/FEkivipwaQqYiyf5VM=
=eVOy
-----END PGP SIGNATURE-----

--2g03l0iA17Ot4xpB9WShRU5NLxW3bxb0S--
