Received: from eggs.gnu.org ([2001:4830:134:3::10]:55735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUXdo-0004V6-FZ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUXdn-0004ix-GR
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:18:16 -0400
Date: Mon, 10 Jul 2017 13:18:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710121810.GD14195@stefanha-x1.localdomain>
References: <20170629132749.997-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Content-Disposition: inline
In-Reply-To: <20170629132749.997-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/11] Block layer thread-safety, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2017 at 03:27:38PM +0200, Paolo Bonzini wrote:
> This part takes care of drivers and devices, making sure that they can
> accept concurrent I/O from multiple AioContext.
>=20
> The following drivers are thread-safe without using any QemuMutex/CoMutex:
> crypto, gluster, null, rbd, win32-aio.  NBD has already been fixed,
> because the patch fixed an unrelated testcase.
>=20
> The following drivers already use mutexes for everything except possibly
> snapshots, which do not (yet?) need protection: bochs, cloop, dmg, qcow,
> parallels, vhdx, vmdk, curl, iscsi, nfs.
>=20
> The following drivers already use mutexes for _almost_ everything: vpc
> (missing get_block_status), vdi (missing bitmap access), vvfat (missing
> commit), not protected), qcow2 (must call CoQueue APIs under CoMutex).
> They are fixed by patches 1-5.
>=20
> The following drivers must be changed to use CoMutex to protect internal
> data: qed (patches 6-9), sheepdog (patch 10).
>=20
> The following driver must be changed to support I/O from any AioContext:
> ssh.  It is fixed by patch 11.
>=20
> Paolo
>=20
> v1->v2: new patch 8 + adjustments to patch 9 to fix qemu-iotests testcase
>         183 (bdrv_invalidate_cache from block migration)
>=20
> Paolo Bonzini (11):
>   qcow2: call CoQueue APIs under CoMutex
>   coroutine-lock: add qemu_co_rwlock_downgrade and
>     qemu_co_rwlock_upgrade
>   vdi: make it thread-safe
>   vpc: make it thread-safe
>   vvfat: make it thread-safe
>   qed: move tail of qed_aio_write_main to qed_aio_write_{cow,alloc}
>   block: invoke .bdrv_drain callback in coroutine context and from
>     AioContext
>   qed: introduce bdrv_qed_init_state
>   qed: protect table cache with CoMutex
>   sheepdog: add queue_lock
>   ssh: support I/O from any AioContext
>=20
>  block/io.c                 |  42 +++++++--
>  block/qcow2.c              |   4 +-
>  block/qed-cluster.c        |   4 +-
>  block/qed-l2-cache.c       |   6 ++
>  block/qed-table.c          |  24 +++--
>  block/qed.c                | 214 ++++++++++++++++++++++++++++-----------=
------
>  block/qed.h                |  11 ++-
>  block/sheepdog.c           |  21 ++++-
>  block/ssh.c                |  24 +++--
>  block/vdi.c                |  48 +++++-----
>  block/vpc.c                |  20 ++---
>  block/vvfat.c              |   8 +-
>  include/block/block_int.h  |   2 +-
>  include/qemu/coroutine.h   |  18 ++++
>  util/qemu-coroutine-lock.c |  35 ++++++++
>  15 files changed, 331 insertions(+), 150 deletions(-)
>=20
> --=20
> 2.13.0
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY3CCAAoJEJykq7OBq3PIjxEH/1Iny0EY91BzrtTbv6KpmLe4
7g3k1ylZVjBxnglKeBdRHRn5hR9KugiJV0QI18E4J24cAV+S6kNC8ZSTdl9sLubO
W65yldnnNvbBtKM8DbZYAgDwn8EspQje6dgnW8Q/zTIFzZ08CATkMBdgZuL5H2W8
xectD7NWIjr2T5ziycp6yoLtlzIJY73mpsaulHqbgxOblvSv0t8It8uR4ETQYx88
4/XyZMKOTy22L91u7fDfhJeM9jKkkQyoiH13Xz0vbz7yCCSXHUMb1sJ+hQHen/Xz
Fu4cl2D8XCcnGqgjBJNxbOY1HevNFJsDcjPguEMsQNACNywosOn1FZegHr+b6Jc=
=MNxx
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
