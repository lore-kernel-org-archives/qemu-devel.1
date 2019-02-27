Received: from eggs.gnu.org ([209.51.188.92]:51018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gz164-0004cv-Ms
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gz163-00017X-NX
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:26:12 -0500
References: <20190214064312.44794-1-mahaocong_work@163.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f335dd82-1944-d367-b845-29dcc01e2f3e@redhat.com>
Date: Wed, 27 Feb 2019 16:25:51 +0100
MIME-Version: 1.0
In-Reply-To: <20190214064312.44794-1-mahaocong_work@163.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9305LHyHOjAT6JIDU8d3Mi1Srgd4MxzXa"
Subject: Re: [Qemu-devel] [PATCH RESEND v4] drive-mirror: add incremental
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mahaocong <mahaocong_work@163.com>, qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>, kwolf@redhat.com, qemu-devel@nongnu.org, mahaocong <mahaocong@didichuxing.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9305LHyHOjAT6JIDU8d3Mi1Srgd4MxzXa
From: Max Reitz <mreitz@redhat.com>
To: mahaocong <mahaocong_work@163.com>, qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>, kwolf@redhat.com, qemu-devel@nongnu.org,
 mahaocong <mahaocong@didichuxing.com>
Message-ID: <f335dd82-1944-d367-b845-29dcc01e2f3e@redhat.com>
Subject: Re: [PATCH RESEND v4] drive-mirror: add incremental mode
References: <20190214064312.44794-1-mahaocong_work@163.com>
In-Reply-To: <20190214064312.44794-1-mahaocong_work@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

CC-ing John because of the keyword "incremental".

On 14.02.19 07:43, mahaocong wrote:
> From: mahaocong <mahaocong@didichuxing.com>
>=20
> This patch adds possibility to start mirroring with user-created-bitmap=
=2E
> On full mode, mirror create a non-named-bitmap by scanning whole block-=
chain,
> and on top mode, mirror create a bitmap by scanning the top block layer=
=2E So I
> think I can copy a user-created-bitmap and use it as the initial state =
of the
> mirror, the same as incremental mode drive-backup, and I call this new =
mode
> as incremental mode drive-mirror.
>=20
> A possible usage scene of incremental mode mirror is live migration. Fo=
r maintain
> the block data and recover after a malfunction, someone may backup data=
 to ceph
> or other distributed storage. On qemu incremental backup, we need to cr=
eate a new
> bitmap and attach to block device before the first backup job. Then the=
 bitmap
> records the change after the backup job. If we want to migration this v=
m, we can
> migrate block data between source and destionation by using drive-mirro=
r directly,
> or use backup data and backup-bitmap to reduce the data should be synch=
ronize.
> To do this, we should first create a new image in destination and set b=
acking file
> as backup image, then set backup-bitmap as the initial state of increme=
ntal mode
> drive-mirror, and synchronize dirty block starting with the state set b=
y the last
> incremental backup job. When the mirror complete, we get an active laye=
r on destination,
> and its backing file is backup image on ceph. Then we can do live copy =
data from
> backing files into overlay images by using block-stream, or do backup c=
ontinually.
>=20
> In this scene, It seems that If the guest os doesn't write too many dat=
a after the
> last backup, the incremental mode may transmit less data than full mode=
 or top
> mode. However, if the write data is too many, there is no advantage on =
incremental
> mode compare with other mode.
>=20
> This scene can be described as following steps:
> 1.create rbd image in ceph, and map nbd device with rbd image.
> 2.create a new bitmap and attach to block device.
> 3.do full mode backup on nbd device and thus sync it to the rbd image.
> 4.severl times incremental mode backup.
> 5.create new image in destination and set its backing file as backup im=
age.
> 6.do live-migration, and migrate block data by incremental mode drive-m=
irror
>   with bitmap created from step 2.
>=20
> Signed-off-by: Ma Haocong <mahaocong@didichuxing.com>
> ---

So one important point about incremental backups is that you can
actually do them incrementally: The bitmap is effectively cleared at the
beginning of the backup process (a successor bitmap is installed that is
cleared and receives all changes; at the end of the backup, it either
replaces the old bitmap (on success) or is merged into it (on failure)).
 Therefore, you can do the next incremental backup by using the same bitm=
ap.

How would this work with mirroring?  Instead of clearing the bitmap at
the start of the process, it'd need to be cleared at the end (because we
reach synchronization between source and target then).  But how would
error handling work?

I suppose the named bitmap would need to be copied to act as the dirty
bitmap for the mirror job (at the start of the job).  If a failure
occurs, the copy is simply discarded.  On success, the named bitmap is
cleared when the job is completed.  Hm, that seems to make sense.  Did I
forget anything, John?

In any case, I don't think this patch implemented anything to this
regard...?  So it doesn't really implement incremental mirroring.
However, I think it should, if possible.

Max


--9305LHyHOjAT6JIDU8d3Mi1Srgd4MxzXa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlx2q/8ACgkQ9AfbAGHV
z0Ax9gf8Cz8pchfT5vOdt8LadkmQenlTtkFXoebMaSN3AtTC62Gm3K556LNvU5D/
MLb3TQrcdxGc2Wa4OrK1/y+t4cKCwsyZuCkvCmFkei0riZQtNth7ltRKm1SCUp6e
bWuAEmChxPKfr6uDB5M2rALH7sv/Y/ukFI0InV3lIGY4XXSzgE5vUQDjdAwPHs4J
qYNDO3keKLDSNQzxTGxsPX1Tk8S8X42pqMMvmFpKWNa83kw/zGqA2CZc+oryZnbQ
V4pHuEtCKbUvLMJTTmQwa77ag2kVO5KfnLsq7JxX5szG8fQANgOuPwVj2GVRgfmi
iCKXwIToIzSZdZ5RmCTuP6VpFzCRaQ==
=22mX
-----END PGP SIGNATURE-----

--9305LHyHOjAT6JIDU8d3Mi1Srgd4MxzXa--
