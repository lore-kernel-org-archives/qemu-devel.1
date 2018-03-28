Received: from eggs.gnu.org ([2001:4830:134:3::10]:55753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f1D37-0002AL-4N
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f1D32-0006lL-VS
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:31:41 -0400
References: <1522157418-8954-1-git-send-email-den@openvz.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <95ac7934-4f03-821f-2ee6-6dc30467ce36@redhat.com>
Date: Wed, 28 Mar 2018 17:31:21 +0200
MIME-Version: 1.0
In-Reply-To: <1522157418-8954-1-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dr4Ay593FRx1JkyfbJjGelyesONmrN859"
Subject: Re: [Qemu-devel] [PATCH for 2.12 1/1] block: allow recursive
 calling of bdrv_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dr4Ay593FRx1JkyfbJjGelyesONmrN859
From: Max Reitz <mreitz@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Message-ID: <95ac7934-4f03-821f-2ee6-6dc30467ce36@redhat.com>
Subject: Re: [PATCH for 2.12 1/1] block: allow recursive calling of
 bdrv_set_aio_context
References: <1522157418-8954-1-git-send-email-den@openvz.org>
In-Reply-To: <1522157418-8954-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-27 15:30, Denis V. Lunev wrote:
> We have received the following assert on QEMU 2.9:
>=20
> (gdb) bt
> 0  0x00007f6f67d281f7 in __GI_raise ()
> 1  0x00007f6f67d298e8 in __GI_abort ()
> 2  0x00007f6f67d21266 in __assert_fail_base ()
> 3  0x00007f6f67d21312 in __GI___assert_fail ()
> 4  0x000055a8faf76f9f in bdrv_detach_aio_context ()
> 5  0x000055a8faf76f68 in bdrv_detach_aio_context ()
> 6  0x000055a8faf770c6 in bdrv_set_aio_context ()
> 7  0x000055a8fafb780d in blk_set_aio_context ()
> 8  0x000055a8faf7af08 in block_job_attached_aio_context ()
> 9  0x000055a8faf77043 in bdrv_attach_aio_context ()
> 10 0x000055a8faf770d9 in bdrv_set_aio_context ()
> 11 0x000055a8fafb780d in blk_set_aio_context ()
> 12 0x000055a8fad580e7 in virtio_blk_data_plane_stop ()
> 13 0x000055a8faf11da5 in virtio_bus_stop_ioeventfd ()
> 14 0x000055a8fad85604 in virtio_vmstate_change ()
> 15 0x000055a8fae1ba52 in vm_state_notify ()
> 16 0x000055a8fad273e5 in do_vm_stop ()
> 17 vm_stop ()
> 18 0x000055a8face8f28 in main_loop_should_exit ()
> 19 main_loop ()
> 20 main ()
> (gdb)
>=20
> It does not look, that the code is fundumentally different in 2.12.
>=20
> block_job_attached_aio_context() calls backup_attached_aio_context(),
> which in turn calls bdrv_detach_aio_context() again. This results in
> assert(!bs->walking_aio_notifiers).
>=20
> The code in mirror is basically the same. The patch replaces boolean
> condition with incremental counter, which should solve the problem.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block_int.h |  2 +-
>  block.c                   | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)

Changing this to a counter looks OK to me, but dealing with a recursive
bdrv_set_aio_context() might be a bit more complicated than that.  It
calls for trouble if one of the aio_notifiers assigns a different
AioContext than was just assigned, if nothing else then because we have
to make sure not to call any other notifier with the old "new" context.

In this case, that shouldn't be an issue because we will simply assign
the new context again, so it's actually a no-op.  Maybe we could allow
that case alone, but even then we have to verify it.

Another thing I'm wondering is how this prevents infinite recursion.
Won't we just call the notifier again which will try to again set its
BlockBackend's AioContext?

What is the full case anyway?  The AioContext of the source changes,
which results in the call of backup's notifier, which will then change
the AioContext of the target.  So source and target would need to be in
the same chain if setting target's context conflicts with a context
change on source.

Max

> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 29cafa4..a290711 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -613,7 +613,7 @@ struct BlockDriverState {
>       * BDS may register themselves in this list to be notified of chan=
ges
>       * regarding this BDS's context */
>      QLIST_HEAD(, BdrvAioNotifier) aio_notifiers;
> -    bool walking_aio_notifiers; /* to make removal during iteration sa=
fe */
> +    int walking_aio_notifiers; /* to make removal during iteration saf=
e */
> =20
>      char filename[PATH_MAX];
>      char backing_file[PATH_MAX]; /* if non zero, the image is a diff o=
f
> diff --git a/block.c b/block.c
> index a8da4f2..82cc07b 100644
> --- a/block.c
> +++ b/block.c
> @@ -4739,8 +4739,7 @@ void bdrv_detach_aio_context(BlockDriverState *bs=
)
>          return;
>      }
> =20
> -    assert(!bs->walking_aio_notifiers);
> -    bs->walking_aio_notifiers =3D true;
> +    bs->walking_aio_notifiers++;
>      QLIST_FOREACH_SAFE(baf, &bs->aio_notifiers, list, baf_tmp) {
>          if (baf->deleted) {
>              bdrv_do_remove_aio_context_notifier(baf);
> @@ -4751,7 +4750,8 @@ void bdrv_detach_aio_context(BlockDriverState *bs=
)
>      /* Never mind iterating again to check for ->deleted.  bdrv_close(=
) will
>       * remove remaining aio notifiers if we aren't called again.
>       */
> -    bs->walking_aio_notifiers =3D false;
> +    bs->walking_aio_notifiers--;
> +    assert(bs->walking_aio_notifiers >=3D 0);
> =20
>      if (bs->drv->bdrv_detach_aio_context) {
>          bs->drv->bdrv_detach_aio_context(bs);
> @@ -4782,8 +4782,7 @@ void bdrv_attach_aio_context(BlockDriverState *bs=
,
>          bs->drv->bdrv_attach_aio_context(bs, new_context);
>      }
> =20
> -    assert(!bs->walking_aio_notifiers);
> -    bs->walking_aio_notifiers =3D true;
> +    bs->walking_aio_notifiers++;
>      QLIST_FOREACH_SAFE(ban, &bs->aio_notifiers, list, ban_tmp) {
>          if (ban->deleted) {
>              bdrv_do_remove_aio_context_notifier(ban);
> @@ -4791,7 +4790,8 @@ void bdrv_attach_aio_context(BlockDriverState *bs=
,
>              ban->attached_aio_context(new_context, ban->opaque);
>          }
>      }
> -    bs->walking_aio_notifiers =3D false;
> +    bs->walking_aio_notifiers--;
> +    assert(bs->walking_aio_notifiers >=3D 0);
>  }
> =20
>  void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_contex=
t)
>=20



--dr4Ay593FRx1JkyfbJjGelyesONmrN859
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlq7tUkACgkQ9AfbAGHV
z0CbaAgAiVeY2hEzXADh/lvoZbPeEopBLYl+FslnZHjiDdDpjiSerTdya4WHmpUQ
QKEFnaTBx2szgtQJENJ9irtD0Kof8KN3DzzDvpLggJ5RSpAgeMh2+U1HGXEFjZAs
BrazEXBONm2/BXka+zfus/wNvbTUUntbHjY+C5Rf+72Ei8HcrM18DciDJSBv2kLa
uP3Sr1DXldYO+4y3VJpIO1ukP+72OZsgNbt0PXPL4uboqK6Q4Fxi0qsIPWQLEeJa
UWKlgABhhN1fnBcrpZ9RPWkjqLg2JohQ7nBNsStImS49wm8je5sZygbvieXUUz6V
r11fQzGtZHldfM1f6fgYhAlGkxS5OQ==
=fHOL
-----END PGP SIGNATURE-----

--dr4Ay593FRx1JkyfbJjGelyesONmrN859--
