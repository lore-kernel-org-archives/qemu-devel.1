Received: from eggs.gnu.org ([2001:4830:134:3::10]:48817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTTfZ-0005lI-5L
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:19:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTTfY-0003eJ-8R
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:19:25 -0500
Date: Tue, 17 Jan 2017 13:19:16 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170117131916.GJ4265@stefanha-x1.localdomain>
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1480926904-17596-6-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bWEb1MG/o7IKOlQF"
Content-Disposition: inline
In-Reply-To: <1480926904-17596-6-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 5/6] replication: Implement block
 replication for shared disk case
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


--bWEb1MG/o7IKOlQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 04:35:03PM +0800, zhanghailiang wrote:
> @@ -663,8 +695,12 @@ static void replication_stop(ReplicationState *rs, b=
ool failover, Error **errp)
> =20
>      switch (s->mode) {
>      case REPLICATION_MODE_PRIMARY:
> -        s->replication_state =3D BLOCK_REPLICATION_DONE;
> -        s->error =3D 0;
> +        if (s->is_shared_disk && s->primary_disk->bs->job) {
> +            block_job_cancel(s->primary_disk->bs->job);

Should this be block_job_cancel_sync()?

> +        } else {
> +            s->replication_state =3D BLOCK_REPLICATION_DONE;
> +            s->error =3D 0;
> +        }
>          break;
>      case REPLICATION_MODE_SECONDARY:
>          /*
> --=20
> 1.8.3.1
>=20
>=20

--bWEb1MG/o7IKOlQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfhnUAAoJEJykq7OBq3PIEHQH/2q4wkhVYV9nI4HX5cno7jPC
0F83Tjkd7XfSyQ1w+t9Y4R1bXoWjO12RVAxGj6tTWHzA+c39ScLHq+kxcgnY1CtD
+fdzbt67U96Elkzslt5KM8MTmmkVxcOkGE7AJU7EHmsn3DAToTze5osGWWjqwHfv
ZetEC7pSBg+kpi3y8ZpBwawLOjxSC8RwyGybtXcqbSZlix/yf6QLVi6YvfFB0nPy
/yOgB6YZU7N+xZ84YPdCvGn6zL0jU7jkPG8mZQYwqutmauhURLGr3tSFIuxYnEX3
xZHO4o+/jLVMUhcUhjrUZRhx2f2KAbYMgOfB8HOdxAjFGJo47e3yWseAPov9F28=
=1H7b
-----END PGP SIGNATURE-----

--bWEb1MG/o7IKOlQF--
