Received: from eggs.gnu.org ([2001:4830:134:3::10]:51519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTRtW-0007MA-KL
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTRtV-0004mz-EZ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:25:42 -0500
Date: Tue, 17 Jan 2017 11:25:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170117112531.GG4265@stefanha-x1.localdomain>
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1480926904-17596-3-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UKNXkkdQCYZ6W5l3"
Content-Disposition: inline
In-Reply-To: <1480926904-17596-3-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 2/6] replication: add shared-disk
 and shared-disk-id options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, wency@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>


--UKNXkkdQCYZ6W5l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 04:35:00PM +0800, zhanghailiang wrote:
> @@ -85,6 +99,9 @@ static int replication_open(BlockDriverState *bs, QDict=
 *options,
>      QemuOpts *opts =3D NULL;
>      const char *mode;
>      const char *top_id;
> +    const char *shared_disk_id;
> +    BlockBackend *blk;
> +    BlockDriverState *tmp_bs;
> =20
>      ret =3D -EINVAL;
>      opts =3D qemu_opts_create(&replication_runtime_opts, NULL, 0, &error=
_abort);
> @@ -119,6 +136,25 @@ static int replication_open(BlockDriverState *bs, QD=
ict *options,
>                     "The option mode's value should be primary or seconda=
ry");
>          goto fail;
>      }
> +    s->is_shared_disk =3D qemu_opt_get_bool(opts, REPLICATION_SHARED_DIS=
K,
> +                                          false);
> +    if (s->is_shared_disk && (s->mode =3D=3D REPLICATION_MODE_PRIMARY)) {
> +        shared_disk_id =3D qemu_opt_get(opts, REPLICATION_SHARED_DISK_ID=
);
> +        if (!shared_disk_id) {
> +            error_setg(&local_err, "Missing shared disk blk");
> +            goto fail;
> +        }
> +        s->shared_disk_id =3D g_strdup(shared_disk_id);
> +        blk =3D blk_by_name(s->shared_disk_id);
> +        if (!blk) {
> +            g_free(s->shared_disk_id);
> +            error_setg(&local_err, "There is no %s block", s->shared_dis=
k_id);
> +            goto fail;

Please move the g_free() to the fail label to prevent future code
changes from introducing a memory leak.

--UKNXkkdQCYZ6W5l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYff8rAAoJEJykq7OBq3PI6h8IALHVtUtrUoaEJ7IA+5V82ubc
I1JHlVIKshOUNJwuTYNGbPnoqYUu18aEk7cJHOH5qDl2gsPdDuvoTLxUl01pyQlH
O/mx2CrRSZ3qbVmYHf+5+vAXskBlNS9SS6429m5E8ITvzplgZL28MhbgH8kNTw7L
QWAClSDkgxGnAvR1PDYhGxjoVamSOa/qysgWtTevAAUujj/v+++kJUaDRoQi3+mN
Ex+BfvL04rzNBlQeTAt1BZXEOT0LPeIdw6MjXaH/ZuZ5+5C5inEsDHQ5p//7krd8
OODayw4CmiVTnUUuJKmao2G0NZ2ypBaSg3HWjviRPdlv7f6RDhMXn4gw68Wikeo=
=MtvW
-----END PGP SIGNATURE-----

--UKNXkkdQCYZ6W5l3--
