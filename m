Received: from eggs.gnu.org ([2001:4830:134:3::10]:50136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7kZY-0004B7-76
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7kZX-0004LF-3B
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:27:40 -0400
References: <20170507000552.20847-1-eblake@redhat.com>
	<20170507000552.20847-2-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <35324a73-aae8-e677-f411-00dfaf6d4f38@redhat.com>
Date: Mon, 8 May 2017 17:27:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170507000552.20847-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KW5PUkB8USjCCc7DExQSRfvsHPVRDaVJK"
Subject: Re: [Qemu-devel] [PATCH v13 01/12] qcow2: Nicer variable names in
 qcow2_update_snapshot_refcount()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KW5PUkB8USjCCc7DExQSRfvsHPVRDaVJK
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <35324a73-aae8-e677-f411-00dfaf6d4f38@redhat.com>
Subject: Re: [PATCH v13 01/12] qcow2: Nicer variable names in
 qcow2_update_snapshot_refcount()
References: <20170507000552.20847-1-eblake@redhat.com>
 <20170507000552.20847-2-eblake@redhat.com>
In-Reply-To: <20170507000552.20847-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.05.2017 02:05, Eric Blake wrote:
> In order to keep checkpatch happy when the next patch changes
> indentation, we first have to shorten some long lines.  The easiest
> approach is to use a new variable in place of
> 'offset & L2E_OFFSET_MASK', except that 'offset' is the best name
> for that variable.  Change '[old_]offset' to '[old_]entry' to
> make room.
>=20
> While touching things, also fix checkpatch warnings about unusual
> 'for' statements.
>=20
> Suggested by Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v13: new patch
> ---
>  block/qcow2-refcount.c | 42 ++++++++++++++++++++++--------------------=

>  1 file changed, 22 insertions(+), 20 deletions(-)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 4efca7e..db0af2c 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c

[...]

> @@ -1117,20 +1118,22 @@ int qcow2_update_snapshot_refcount(BlockDriverS=
tate *bs,
>                  goto fail;
>              }
>=20
> -            for(j =3D 0; j < s->l2_size; j++) {
> +            for (j =3D 0; j < s->l2_size; j++) {
>                  uint64_t cluster_index;
> +                uint64_t offset;

Actually, introducing entry and old_entry in this scope would have
sufficed, too, because they aren't used anywhere else. But nobody
actually cares (O:-)), so:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>=20
> -                offset =3D be64_to_cpu(l2_table[j]);
> -                old_offset =3D offset;
> -                offset &=3D ~QCOW_OFLAG_COPIED;
> +                entry =3D be64_to_cpu(l2_table[j]);
> +                old_entry =3D entry;
> +                entry &=3D ~QCOW_OFLAG_COPIED;
> +                offset =3D entry & L2E_OFFSET_MASK;
>=20
> -                switch (qcow2_get_cluster_type(offset)) {
> +                switch (qcow2_get_cluster_type(entry)) {
>                      case QCOW2_CLUSTER_COMPRESSED:
> -                        nb_csectors =3D ((offset >> s->csize_shift) &
> +                        nb_csectors =3D ((entry >> s->csize_shift) &
>                                         s->csize_mask) + 1;
>                          if (addend !=3D 0) {
>                              ret =3D update_refcount(bs,
> -                                (offset & s->cluster_offset_mask) & ~5=
11,
> +                                (entry & s->cluster_offset_mask) & ~51=
1,
>                                  nb_csectors * 512, abs(addend), addend=
 < 0,
>                                  QCOW2_DISCARD_SNAPSHOT);
>                              if (ret < 0) {


--KW5PUkB8USjCCc7DExQSRfvsHPVRDaVJK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkQjmQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ADUUIAL+C6TMtVLHXwEyO9oRG1ga2Lpc7RNYl
0xCRwG4y6Y3vQG+zhc5yl5blN4kl9839DBCSf3rvgOGOVxiKcBB+VubILH1aiGQu
o8tzIxLPvMLNr0NhHua6yxLzhO0dk2fps/P3ggRtRE2Cjl1JOB/7wQ9/dghBsF0i
vZJKiA7oqn3bRqCjt/wFhULx3gq52klxRsrgzpBTaf/a2tzL1SOmRrB9ZuR6RTe0
QmBVK7o14Oie0MqQRe5WNr2T/LywX/2LzxcX4x1BYYjsFEWiIU5Pt7EScMPW46K6
bvbe3UZMJth+Q8zQhsw8vLYj+iJ0EvfKDhdpfT/7PzU69FvHHMqs8rs=
=QZ9J
-----END PGP SIGNATURE-----

--KW5PUkB8USjCCc7DExQSRfvsHPVRDaVJK--
