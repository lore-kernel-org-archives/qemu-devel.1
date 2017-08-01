Received: from eggs.gnu.org ([2001:4830:134:3::10]:44305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcWrx-0005Uu-O2
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcWrs-0000CS-UB
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:05:53 -0400
Date: Tue, 1 Aug 2017 14:05:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170801130544.GA22017@stefanha-x1.localdomain>
References: <20170726120255.14292-1-maozy.fnst@cn.fujitsu.com>
	<20170726120255.14292-5-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20170726120255.14292-5-maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH 4/6] hw/block: Fix the return type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 08:02:53PM +0800, Mao Zhongyi wrote:
> When the function no success value to transmit, it usually make the
> function return void. It has turned out not to be a success, because
> it means that the extra local_err variable and error_propagate() will
> be needed. It leads to cumbersome code, therefore, transmit success/
> failure in the return value is worth.
>=20
> So fix the return type of blkconf_apply_backend_options(),
> blkconf_geometry() and virtio_blk_data_plane_create() to avoid it.
>=20
> Cc: John Snow <jsnow@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  hw/block/block.c                | 21 ++++++++++++---------
>  hw/block/dataplane/virtio-blk.c | 16 +++++++++-------
>  hw/block/dataplane/virtio-blk.h |  6 +++---
>  include/hw/block/block.h        | 10 +++++-----
>  4 files changed, 29 insertions(+), 24 deletions(-)
>=20
> diff --git a/hw/block/block.c b/hw/block/block.c
> index 27878d0..717bd0e 100644
> --- a/hw/block/block.c
> +++ b/hw/block/block.c
> @@ -51,8 +51,8 @@ void blkconf_blocksizes(BlockConf *conf)
>      }
>  }
> =20
> -void blkconf_apply_backend_options(BlockConf *conf, bool readonly,
> -                                   bool resizable, Error **errp)
> +int blkconf_apply_backend_options(BlockConf *conf, bool readonly,
> +                                  bool resizable, Error **errp)

I'm not a fan of these changes because it makes inconsistencies between
the return value and the errp argument possible (e.g. returning success
but setting errp, or returning failure without setting errp).

If you really want to do this please use bool as the return type instead
of int.  int can be abused to return error information that should
really be in the Error object.

Stefan

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgHyoAAoJEJykq7OBq3PIynsIAKBbY94OXyFgQC1h9ttzKK6N
0hZfPR53oG+hQHibSfYjToQ0HX3oQIXbpHB3+bc6vGcpWdAMcpGmLSApM5gFZsGb
07GRCkqrDt7WbGrp7uRQDHkPVT36QAHEv4nkgzzgEm23UMtgo3jMhq43hMdRRmlC
avNx2ToVb3Nan2nrCJvY9mZEGJ9I2hK1q0tTgCqKv3vLYOJCb/65mzx5jptIyBtU
C+FZrI0I+MbiR6/yv/Eu5GrinZDNPK+ck8uyzGoPRBhBCv9RyfxOlIkbKT3n9VyR
dPL16KzPzgZGYbJE7jkYg/k+csXhyYwyzGub39XrWhVEnssdd2Qx9dFvAXl3yrQ=
=Y+Jn
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
