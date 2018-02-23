Received: from eggs.gnu.org ([2001:4830:134:3::10]:39752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epF8J-0000vx-3P
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epF8H-0007BV-W5
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:19:35 -0500
Date: Fri, 23 Feb 2018 16:19:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180223151915.GB3470@localhost.localdomain>
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-20-kwolf@redhat.com>
	<16106599-7a8b-016f-c778-7b94ad5f94df@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <16106599-7a8b-016f-c778-7b94ad5f94df@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 19/36] rbd: Factor out qemu_rbd_connect()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 23.02.2018 um 00:10 hat Max Reitz geschrieben:
> On 2018-02-21 14:53, Kevin Wolf wrote:
> > The code to establish an RBD connection is duplicated between open and
> > create. In order to be able to share the code, factor out the code from
> > qemu_rbd_open() as a first step.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/rbd.c | 100 ++++++++++++++++++++++++++++++++++++----------------=
--------
> >  1 file changed, 60 insertions(+), 40 deletions(-)
> >=20
> > diff --git a/block/rbd.c b/block/rbd.c
> > index 27fa11b473..4bbcce4eca 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -544,32 +544,17 @@ out:
> >      return rados_str;
> >  }
> > =20
> > -static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int fla=
gs,
> > -                         Error **errp)
> > +static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
> > +                            char **s_snap, char **s_image_name,
> > +                            QDict *options, bool cache, Error **errp)
>=20
> Bikeshedding ahead:  Maybe this should be called qemu_rados_connect()?
> I don't know anything about this, but there seems to be a distinction
> between rados_* functions and rbd_* functions -- the former work on the
> pool, the latter on the single block device.
>=20
> Since this function only connects to the pool and not to a single device
> within, I think it should be called qemu_rados_connect() instead of
> qemu_rbd_connect().
>=20
> (Also because qemu_rbd_connect() seems so similar to qemu_rbd_open().)

I think librados is the lower level interface, and librbd builds a
higher level interface on top of it. But I don't know anything about the
details either.

However, for functions in the block driver, qemu_rbd_* is the only
prefix used, there is no qemu_rados_* function. So I assume the prefix
comes from the block driver name 'rbd' rather than which library it
accesses, and that it would be better to keep qemu_rbd_connect().

> Up to you:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Thanks.

Kevin

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJakDDzAAoJEH8JsnLIjy/WCfUQAMQes7qeM/2kWn39otwiNHQm
+NHGm2//wt9Mew99tynp7lERkeXJqNMZ7KdxPLRh6q95gF+svQBa4AmOpFp3lv33
S5oGb8JRjSWJRmjEOe0r3FQOSrtDlYem6mXO3UIrCIjCnmvK38ygbz9dahYfaz4/
IremwKNT0KevD29gVGwOLXkYPmbk8qApPrSbakFvYxsdDzN0vYt6kr/iG9sUa1qn
Apr6tky4oDkkXvqmf2Y4SjTYqmn4Wz4FCqLmj9EqxKy1ODnbfRy3Vh0PvOHyZnQk
IOipkrT/fUrHwd3xC4nxDT6jvVjm1q43UEffSa7eIpDWKNimg4fkaykCYwBJqvki
lkDmFHrxCo1lABETm0t9jqEfphhuuKTjyHu1nuoi8BWbyjsRvkT4uD5dYAZ26QWG
/3cUmkg9toANXsuNo4ly9hFsQllnT4fG/tziH8vZeia9BbQqfytoGRrVWquZ87dj
269eTmQFAqvnZmKHvBuKsgXOZd6veAEYI3BYY1Y9yMOqU39LKtL1bbID12MAlZV4
pm6jipumUi6Qu/wgSnoOrDg+2Gv3gSG9QpMECE1xkDGxXh5NCSnRBoJoxiNjeFyb
Mz33s6a915ybbrk8VMtgAJaBcT7qlDtUOs+bqKjWBqzTgF9HgBe+wsTmpXY1i2fT
vnWn7IpQQUEfK4AS2MWN
=Jmtx
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
