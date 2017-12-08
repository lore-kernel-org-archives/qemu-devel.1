Received: from eggs.gnu.org ([2001:4830:134:3::10]:60782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eNKeC-0006Cy-6b
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eNKeB-0006ux-3i
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:33:08 -0500
Date: Fri, 8 Dec 2017 15:32:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171208153255.GE8998@stefanha-x1.localdomain>
References: <20171206144550.22295-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <20171206144550.22295-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/9] blockdev: fix QMP 'transaction'
 with IOThreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 02:45:41PM +0000, Stefan Hajnoczi wrote:
> v2:
>  * Use StrOrNull for x-blockdev-set-iothread iothread argument [eblake]
>=20
> (This is for QEMU 2.12 because this bug is not -rc4 critical)
>=20
> Previously AioContext was held across QMP 'transaction' in an attempt to
> achieve bdrv_drained_begin/end() semantics.  Nowadays we have
> bdrv_drained_begin/end() and the AioContext lock just protects state.
> Therefore there is no reason to hold AioContext across
> .prepare/.commit/.abort/.clean() anymore.
>=20
> Besides being cleanup-worthy, holding AioContext also exposes a bug:
> BDRV_POLL_WHILE() doesn't support recursive AioContext locking and will h=
ang if
> depth > 1.  This is easy to trigger by submitting a transaction with 2 ac=
tions
> that touch two drives assigned to an IOThread.  The IOThread's AioContext=
 will
> be locked twice and BDRV_POLL_WHILE() will hang.
>=20
> BDRV_POLL_WHILE() is best fixed by eliminating the AioContext lock entire=
ly in
> favor of fine-grained locking.  I discussed some fixes for BDRV_POLL_WHIL=
E()
> with Paolo but we came to the conclusion that it will just add complexity=
 when
> we really want to stop using AioContext locking.
>=20
> Summary:
>=20
>  * Patch 1 fixes missing AioContext lock protection
>=20
>  * Patches 2-6 clean up excessive AioContext locked regions in QMP
>    'transaction' to solve the hang
>=20
>  * Patches 7-9 add a qemu-iotests test case and the necessary infrastruct=
ure
>=20
> Stefan Hajnoczi (9):
>   blockdev: hold AioContext for bdrv_unref() in
>     external_snapshot_clean()
>   block: don't keep AioContext acquired after
>     external_snapshot_prepare()
>   block: don't keep AioContext acquired after drive_backup_prepare()
>   block: don't keep AioContext acquired after blockdev_backup_prepare()
>   block: don't keep AioContext acquired after
>     internal_snapshot_prepare()
>   block: drop unused BlockDirtyBitmapState->aio_context field
>   iothread: add iothread_by_id() API
>   blockdev: add x-blockdev-set-iothread testing command
>   qemu-iotests: add 202 external snapshots IOThread test
>=20
>  qapi/block-core.json       |  36 +++++++
>  include/sysemu/iothread.h  |   1 +
>  blockdev.c                 | 258 +++++++++++++++++++++++++++++++++------=
------
>  iothread.c                 |   7 ++
>  tests/qemu-iotests/202     |  95 +++++++++++++++++
>  tests/qemu-iotests/202.out |  11 ++
>  tests/qemu-iotests/group   |   1 +
>  7 files changed, 339 insertions(+), 70 deletions(-)
>  create mode 100755 tests/qemu-iotests/202
>  create mode 100644 tests/qemu-iotests/202.out
>=20
> --=20
> 2.14.3
>=20

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKrCnAAoJEJykq7OBq3PIEAgH/iJo2yKomjgVCHMTpkh7j3SF
/wJL4QFTGfhAwuHa2e1CoMS0mDlAUa46xuFdezuSYyNCNhLU5G6a84FQYOo1kq5x
iW5zsGWtXszBvTKu5d5qyxJdnUk7n7m5nRkF8pIBpqMN/80bMtXRDxjNqidZdI/3
zSKkybvHM7mlAHzS6XY7y2NUmajIRh8yRctS/DegdXViDRjLPq/5W5H5FdnsA9Mm
81rFU0+LHDWwhKLsYncfyuWztY0AFxt+QiCyvecSjcNhlxvYRZ2nclYygg1lsmzB
SIpbpJWJAlZavW+eaAUMibBeIWXB7yz8sl09qVMRDqndAboFSkuo5OAo0IjWJIo=
=gsw8
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
