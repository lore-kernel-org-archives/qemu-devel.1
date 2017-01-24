Received: from eggs.gnu.org ([2001:4830:134:3::10]:59804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0b0-0001zG-SW
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0aw-0006et-Vc
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:53:10 -0500
Date: Tue, 24 Jan 2017 12:53:03 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170124125303.GJ17221@stefanha-x1.localdomain>
References: <1485244792-11248-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2uG6jHjFLimDtBY"
Content-Disposition: inline
In-Reply-To: <1485244792-11248-1-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] migration: re-active
 images while migration been canceled after inactive them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, amit.shah@redhat.com


--J2uG6jHjFLimDtBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 03:59:52PM +0800, zhanghailiang wrote:
> commit fe904ea8242cbae2d7e69c052c754b8f5f1ba1d6 fixed a case
> which migration aborted QEMU because it didn't regain the control
> of images while some errors happened.
>=20
> Actually, there are another two cases can trigger the same error reports:
> " bdrv_co_do_pwritev: Assertion `!(bs->open_flags & 0x0800)' failed",
>=20
> Case 1, codes path:
> migration_thread()
>     migration_completion()
>         bdrv_inactivate_all() ----------------> inactivate images
>         qemu_savevm_state_complete_precopy()
>             socket_writev_buffer() --------> error because destination fa=
ils
>                 qemu_fflush() ----------------> set error on migration st=
ream
> -> qmp_migrate_cancel() ----------------> user cancelled migration concur=
rently
>     -> migrate_set_state() ------------------> set migrate CANCELLIN
>     migration_completion() -----------------> go on to fail_invalidate
> 	if (s->state =3D=3D MIGRATION_STATUS_ACTIVE) -> Jump this branch
>=20
> Case 2, codes path:
> migration_thread()
>     migration_completion()
>         bdrv_inactivate_all() ----------------> inactivate images
>     migreation_completion() finished
> -> qmp_migrate_cancel() ---------------> user cancelled migration concurr=
ently
>     qemu_mutex_lock_iothread();
>     qemu_bh_schedule (s->cleanup_bh);
>=20
> As we can see from above, qmp_migrate_cancel can slip in whenever
> migration_thread does not hold the global lock. If this happens after
> bdrv_inactive_all() been called, the above error reports will appear.
>=20
> To prevent this, we can call bdrv_invalidate_cache_all() in qmp_migrate_c=
ancel()
> directly if we find images become inactive.
>=20
> Besides, bdrv_invalidate_cache_all() in migration_completion() doesn't ha=
ve the
> protection of big lock, fix it by add the missing qemu_mutex_lock_iothrea=
d();
>=20
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
> v2:
>  - Fix a bug introduced by commit fe904 which didn't get big lock
>    before call bdrv_invalidate_cache_all. (Suggested by Dave)
> ---
>  include/migration/migration.h |  3 +++
>  migration/migration.c         | 15 +++++++++++++++
>  2 files changed, 18 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--J2uG6jHjFLimDtBY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYh04vAAoJEJykq7OBq3PIb78IAIzNohyYJQv0uLhrowK7IYSp
Ombdv636B8oZrYDG76CK2vOJZLSVs1HxR9Q6w8EwPARry5zakvZv2Re72v4Wl3al
w++tRXyJ1Vi6Fvv3aMmLekQmxrtVQtkOgqBV8jm9Ijifhgdf+ehRAlt3PANuhUgT
JElRi1E8hhDUZJADswjloM8mz79pNABfaB47HW8nRSyAYJkw86xHO98U2arq/+CS
FtACDlAv60b8d0Cf+xpBsSoXB0M0D4yiR1UJ6SjG9TU1dePClDb51wWSOXID/fp5
H+pkzyWzl5SoiKnGEKfiomcnfQfNDkw5nAyqo/XS5Bp5kr4yypw/zEPVy3qxKcM=
=pe5p
-----END PGP SIGNATURE-----

--J2uG6jHjFLimDtBY--
