Received: from eggs.gnu.org ([2001:4830:134:3::10]:55587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXNeN-0007cc-Lt
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXNeM-0002ch-Nt
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:19:07 -0400
Date: Mon, 25 Jun 2018 11:18:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180625091857.GC5024@localhost.localdomain>
References: <20180621170657.27542-1-kwolf@redhat.com>
	<20180621170657.27542-3-kwolf@redhat.com>
	<20180625085631.GA29002@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20180625085631.GA29002@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] file-posix: Make
 .bdrv_co_truncate asynchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.06.2018 um 10:56 hat Stefan Hajnoczi geschrieben:
> On Thu, Jun 21, 2018 at 07:06:57PM +0200, Kevin Wolf wrote:
> > +    RawPosixAIOData *acb =3D g_new(RawPosixAIOData, 1);
> > +    ThreadPool *pool;
> > =20
> > -out:
> > -    if (result < 0) {
> > -        if (ftruncate(fd, current_length) < 0) {
> > -            error_report("Failed to restore old file length: %s",
> > -                         strerror(errno));
> > -        }
> > -    }
> > +    *acb =3D (RawPosixAIOData) {
> > +        .bs             =3D bs,
> > +        .aio_fildes     =3D fd,
> > +        .aio_type       =3D QEMU_AIO_TRUNCATE,
> > +        .aio_offset     =3D offset,
> > +        .prealloc       =3D prealloc,
> > +        .errp           =3D errp,
> > +    };
> > =20
> > -    g_free(buf);
> > -    return result;
> > +    /* @bs can be NULL, bdrv_get_aio_context() returns the main contex=
t then */
> > +    pool =3D aio_get_thread_pool(bdrv_get_aio_context(bs));
> > +    return thread_pool_submit_co(pool, aio_worker, acb);
>=20
> Where is acb freed?

At the end of aio_worker(). This is why I even need to malloc it here.

Once my other patch is in that removes the callback-based paio_submit(),
we could allocate the acb on the stack for all callers instead.

Kevin

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbMLOBAAoJEH8JsnLIjy/WScYP/iaT5faV9TC4ANYWm2IpEyO6
7IF+tNHVYCHYzPnX6FKko6MpJVii9xX4W16VE1MA/wMFBqZ2hjIqWAvtCiUaTH4w
yB7Lv9qLheAmr5euxHO5bKkd8/KDdMamm8gKDliDMc+HUlAI/ACD/dbOj8WhStx9
eEc2CrVcxnFDOT4dTUlTAqXQah4e68OvKUqx6+S+Iyje+fHvckSJf6LRIXB/riQa
YRTmZQnkpH0Ccf5K/UFyBZS9d5pUBbhPHT9R6+XI5o2hLK/iUpzmstePhM1tEpXh
V6dllKk4hTFDPRXh9Hx8GzDfhFB7ZOAFhBVOYrj+V+mdJGrTX1gj7QjF6TdOOnMR
cUX0v6klQQoMq8KMIHyCblWfgkMk3O4ccSo2o3hiIjfQUO2tflUClmBaUdmBOCkT
d+boRQMC83QbPXrQZiAFIDDINb/xtsymQatbd8B5Vdn9xVPvq0YqpMDcKkPPsGQI
/aah5jqAB1cb5pRNXzcJmVpV7nR7Xf/MQW/sqljVaCgkUucXxwko9n1i6W1hdhPC
RHrMxHrFLInnWydYUFZwAwg282hHkpzbqhTzSorFbe7Y3DLYqRFY5IYf2ho21ls4
6ZIkhSjB9Z1I/R/Z2+7fKHtLJpUDur6VJaARBFPuh/UaeXohzbx6il2xlkgrjV9t
ck45yO1TNMEy6EqmEoV2
=L2dW
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
