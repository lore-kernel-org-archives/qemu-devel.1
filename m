Received: from eggs.gnu.org ([2001:4830:134:3::10]:45025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcq2X-0004A7-Cd
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcq2W-0004IU-J4
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:34:05 -0400
Date: Wed, 2 Aug 2017 10:33:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170802093355.GB5531@stefanha-x1.localdomain>
References: <20170801134907.31253-1-el13635@mail.ntua.gr>
	<20170801134907.31253-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <20170801134907.31253-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 1/3] block: add options parameter to
 bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2017 at 04:49:05PM +0300, Manos Pitsidianakis wrote:
> diff --git a/block.c b/block.c
> index 37e72b7a96..886a457ab0 100644
> --- a/block.c
> +++ b/block.c
> @@ -1149,16 +1149,26 @@ free_and_fail:
>      return ret;
>  }
> =20
> +/*
> + * If options is not NULL it is cloned (which adds another reference to =
the
> + * option entries). If the call to bdrv_new_open_driver() is successful,=
 the
> + * caller should unref options to pass ownership.
> + * */

Please follow the ownership convention for the options argument.
Existing block.c function take ownership of options:

  * options is a QDict of options to pass to the block drivers, or NULL for=
 an
  * empty set of options. The reference to the QDict belongs to the block l=
ayer
  * after the call (even on failure), so if the caller intends to reuse the
  * dictionary, it needs to use QINCREF() before calling bdrv_open.

>  BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *nod=
e_name,
> -                                       int flags, Error **errp)
> +                                       int flags, QDict *options, Error =
**errp)

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgZyDAAoJEJykq7OBq3PI7wcH/i2SyYZyzZbCpFi4cQOoxkMo
bF3JFzzuSnh9KuDUoniG+u2ZhhUG1mBhysSYH123Ap41VnvIke194XQeBp/Kmva3
7svNEoJnI5gcD8EP3JlObWe+rgA7kYp9v+iWofePexVaJqV8ND78D29Tlx5KOTDb
5/3pTOgexvNC7UXnhuWDizN9fZcMkRcdGVv/5JRmzE+WQATXzP50fZfAfPeJG9Ut
dM+Q+nnuy23v0z6ri0+I5rzEWkoJ+fX0WobrdFypKEC+yubbHb4EaK+MbsXIgnfF
azjjmdFErSDqZbicmPmarMlErrrC+dZtkZFULeCdzqKfyk+4XguGxxw+2kr7yFw=
=70lK
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
