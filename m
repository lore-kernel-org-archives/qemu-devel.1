Received: from eggs.gnu.org ([2001:4830:134:3::10]:34619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIwvX-0000kS-Oc
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIwvS-0000BO-Ob
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:52:39 -0400
Date: Thu, 8 Jun 2017 13:52:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170608125231.GJ4145@stefanha-x1.localdomain>
References: <20170531094330.1808-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pMCBjikF2xGw87uL"
Content-Disposition: inline
In-Reply-To: <20170531094330.1808-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 00/11] Block layer thread-safety, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com


--pMCBjikF2xGw87uL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 11:43:19AM +0200, Paolo Bonzini wrote:
> This part takes care of drivers and devices, making sure that they can
> accept concurrent I/O from multiple AioContext.  Only RFC for now because=
 it
> depends on Kevin's QED conversion to coroutines, which is still in flux.
>=20
> The following drivers are thread-safe without using any QemuMutex/CoMutex:
> crypto, gluster, null, rbd, win32-aio.
>=20
> The following drivers already use mutexes for everything except possibly
> snapshots, which do not (yet?) need protection: bochs, cloop, dmg, qcow,
> parallels, vhdx, vmdk, curl, iscsi, nfs.
>=20
> The following drivers already use mutexes for _almost_ everything: vpc
> (missing get_block_status), vdi (missing bitmap access), vvfat (missing
> commit), nbd (s->in_flight not protected), qcow2 (must call CoQueue APIs
> under CoMutex).  They are fixed by patches 1-6.
>=20
> The following drivers must be changed to use CoMutex to protect internal
> data: qed (patches 7-9), sheepdog (patch 10).
>=20
> The following driver must be changed to support I/O from any AioContext:
> ssh.  It is fixed by patch 11.
>=20
> Paolo
>=20
> Paolo Bonzini (11):
>   qcow2: call CoQueue APIs under CoMutex
>   coroutine-lock: add qemu_co_rwlock_downgrade and qemu_co_rwlock_upgrade
>   vdi: make it thread-safe
>   vpc: make it thread-safe
>   vvfat: make it thread-safe
>   nbd: make it thread-safe
>   qed: move tail of qed_aio_write_main to qed_aio_write_{cow,alloc}
>   block: invoke .bdrv_drain callback in coroutine context and from AioCon=
text
>   qed: protect table cache with CoMutex
>   sheepdog: add queue_lock
>   ssh: support I/O from any AioContext
>=20
>  block/io.c                 |  42 +++++++---
>  block/nbd-client.c         |  30 +++----
>  block/qcow2.c              |   4 +-
>  block/qed-cluster.c        |   4 +-
>  block/qed-l2-cache.c       |   6 ++
>  block/qed-table.c          |  24 ++++--
>  block/qed.c                | 195 +++++++++++++++++++++++++++------------=
------
>  block/qed.h                |  11 ++-
>  block/sheepdog.c           |  21 ++++-
>  block/ssh.c                |  24 ++++--
>  block/vdi.c                |  48 +++++------
>  block/vpc.c                |  20 ++---
>  block/vvfat.c              |   8 +-
>  include/block/block_int.h  |   2 +-
>  include/qemu/coroutine.h   |  19 +++++
>  util/qemu-coroutine-lock.c |  35 ++++++++
>  16 files changed, 326 insertions(+), 167 deletions(-)
>=20
> --=20
> 2.13.0
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pMCBjikF2xGw87uL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOUiPAAoJEJykq7OBq3PI+j0H+gOV8rWxkZluIc8ynn4l072P
wYYmFtznwhzSRjrhBJ89hfV7fngHnkTNeobfyyMjBzBzvERo/1KfkDayoBSLrP+z
sEf/rzkVy4rzgmgx2EmsOjniJ+ZUbJLRiuJi+NTPpbKTqQDsIpX+7ZRDeo9lIbCg
m9ze09PTEfIqpql11VZzvE3G1zFXiYmz6YnkH8l0otlC6zsQuoIa4wzpc7pGvjdr
udz/MPkxPL1hKxS7OIO2WbW1F+r6eWjXlfODl7roBIlh0NldELCBA8xts+xm89v8
P7iMA7B5sxFDm8QkefQSYSMNzJrQeucTIIPgxkPLNpQIS0plAVcR//y7HcICOJ0=
=lFky
-----END PGP SIGNATURE-----

--pMCBjikF2xGw87uL--
