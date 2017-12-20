Received: from eggs.gnu.org ([2001:4830:134:3::10]:54644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRh6f-0002Yc-VG
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRh6d-0007Fu-A9
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:20:33 -0500
Date: Wed, 20 Dec 2017 16:20:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171220162021.GF12566@stefanha-x1.localdomain>
References: <1513690383-27269-1-git-send-email-sochin.jiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DEueqSqTbz/jWVG1"
Content-Disposition: inline
In-Reply-To: <1513690383-27269-1-git-send-email-sochin.jiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH]  virtio-blk: notify guest directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "sochin.jiang" <sochin.jiang@huawei.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, eric.fangyi@huawei.com, Ming Lei <tom.leiming@gmail.com>


--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 09:33:03PM +0800, sochin.jiang wrote:
> From: "sochin.jiang" <sochin.jiang@huawei.com>
>=20
>  Till now, we've already notify guest as a batch mostly, an
>  extra BH won't decrease guest interrupts much, but cause a
>  significant notification loss. Generally, we could have 15%
>  or so performance lost in single queue IO models, as I tested.

I have CCed Ming Lei, who originally implemented batched notifications
in commit 5b2ffbe4d99843fd8305c573a100047a8c962327 ("virtio-blk:
dataplane: notify guest as a batch").  The original commit mentions a 13K
interrupt/sec reduction, which is significant.

Which host storage device are you benchmarking and what is the benchmark
configuration?

How many interrupts/sec does the guest report (cat /proc/interrupts)
before and after this patch?

In the past I've noticed performance can vary significantly depending on
QEMUBH ordering in the AioContext->first_bh list.  Can you measure the
latency from virtio_blk_data_plane_notify() to aio_bh_poll() and compare
against the latency from virtio_blk_data_plane_notify() to
notify_guest_bh()?

> @@ -75,7 +67,12 @@ static void notify_guest_bh(void *opaque)
>      }
>  }
> =20
> -/* Context: QEMU global mutex held */

Please keep this doc comment for virtio_blk_data_plane_create().

--DEueqSqTbz/jWVG1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaOo3FAAoJEJykq7OBq3PInNkH/RxHOFmBOKcBzJZY445rk3rx
esoRlq7mqzQF2FuWA8/uknyg1MvtdGIr4u9TVWOlO218734QKFIjbGnSAejPiFLr
BTDmwjpuh1BHnn+eUX2AAk2+Ga/gAbA9YQGhLKv7pL6aRSUVFsq7pIGdgyJ8k9iA
SQf5u9D4DNwnckjt+EmojSs8G6ebBiXywNga7B6f1huoCTeudCBJSlP/4hEFuR/r
HGDMtmV0W1xeUQWg+OLNlKCsQmFuNzGqFALdgL+zCO/UcAPBbMx9cEroo+2FN4Tz
EQWW8Wpjb4NKzLtgATppKXxP8s19QlNgZen+xt4U4qqcuz8lvQ8Q8VfxmWDBMeY=
=a1SN
-----END PGP SIGNATURE-----

--DEueqSqTbz/jWVG1--
