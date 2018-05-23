Received: from eggs.gnu.org ([2001:4830:134:3::10]:49676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fLV1w-0004iJ-KI
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fLV1t-0001s3-Fs
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:46:20 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:45446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fLV1t-0001re-A6
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:46:17 -0400
Received: from player791.ha.ovh.net (unknown [10.109.105.31])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 5B25AB1888
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 16:46:15 +0200 (CEST)
Date: Wed, 23 May 2018 16:46:10 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180523164610.09ec083b@bahia.lan>
In-Reply-To: <20180518153246.GE31915@stefanha-x1.localdomain>
References: <152646971421.34839.18198173866060880395.stgit@bahia.lan>
	<20180518153246.GE31915@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/bbzB5yjupMWTg1=+a1ZD+U9";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] block: fix QEMU crash with scsi-hd and
 drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

--Sig_/bbzB5yjupMWTg1=+a1ZD+U9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 18 May 2018 16:32:46 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Wed, May 16, 2018 at 01:21:54PM +0200, Greg Kurz wrote:
> > Removing a drive with drive_del while it is being used to run an I/O
> > intensive workload can cause QEMU to crash.
> >=20
> > An AIO flush can yield at some point:
> >=20
> > blk_aio_flush_entry()
> >  blk_co_flush(blk)
> >   bdrv_co_flush(blk->root->bs)
> >    ...
> >     qemu_coroutine_yield() =20
>=20
> I'm surprised you didn't hit another crash later on with this patch
> applied.  What happens to this completion after you've set blk->root =3D
> NULL?
>=20

bdrv_co_flush() takes a BDS argument, so I don't see how it would be
affected by blk->root being set to NULL. Then blk_co_flush() returns
to blk_aio_flush_entry(), and the next user of blk->root is....

> > and let the HMP command to run, free blk->root and give control
> > back to the AIO flush:
> >=20
> >     hmp_drive_del()
> >      blk_remove_bs()
> >       bdrv_root_unref_child(blk->root)
> >        child_bs =3D blk->root->bs
> >        bdrv_detach_child(blk->root)
> >         bdrv_replace_child(blk->root, NULL)
> >          blk->root->bs =3D NULL
> >         g_free(blk->root) <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D b=
lk->root becomes stale
> >        bdrv_unref(child_bs)
> >         bdrv_delete(child_bs)
> >          bdrv_close()
> >           bdrv_drained_begin()
> >            bdrv_do_drained_begin()
> >             bdrv_drain_recurse()
> >              aio_poll()
> >               ...
> >               qemu_coroutine_switch()
> >=20
> > and the AIO flush completion ends up dereferencing blk->root:
> >=20
> >   blk_aio_complete()
> >    scsi_aio_complete()
> >     blk_get_aio_context(blk)
> >      bs =3D blk_bs(blk)
> >  ie, bs =3D blk->root ? blk->root->bs : NULL

... here and the completion ends in the main loop context.

> >             ^^^^^
> >             stale
> >=20
> > The solution to this user-after-free situation is is to clear
> > blk->root before calling bdrv_unref() in bdrv_detach_child(),
> > and let blk_get_aio_context() fall back to the main loop context
> > since the BDS has been removed. =20
>=20
> QEMU should drain I/O requests before making block driver graph changes.
> I think the drained region in blk_remove_bs() needs to begin earlier so
> that requests are completed before we begin to change things.
>=20

This looks better indeed. The drained section currently begins in
bdrv_close(), which happens much later than bdrv_detach_child(),
which actually change things.

Maybe change bdrv_root_unref_child() to ensure we don't call
bdrv_close() with pending I/O requests ?

 void bdrv_root_unref_child(BdrvChild *child)
 {
     BlockDriverState *child_bs;
=20
     child_bs =3D child->bs;
+    bdrv_drained_begin(child_bs);
     bdrv_detach_child(child);
+    bdrv_drained_end(child_bs);
     bdrv_unref(child_bs);
 }


> Stefan


--Sig_/bbzB5yjupMWTg1=+a1ZD+U9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsFfrMACgkQcdTV5YIv
c9absBAAo+pDOeCVApr7Yzn5pEPuRFfFgqNzAO831r5/Y4mQpnbEKz8Gl7xdISR6
xQjQfMBdHsOylOWGvU3eYDfToxANtggF+/rZH3ccEDLECLkE0/2OydPaFKu8Lnrv
NuqZOFKxE/VNenTufpMW2oL5/Ui1SK8kXuaYJCsGUhZUdi7y4f1FmwDqz/QJmGYR
IxY5RRDXxafOS8x8Hwm9Nl007l9QWapJR/eUuXskJPjk5fMbkEmOYtZyuqAxwpPQ
lZ+r12og+mUrP1CblKUPVIdZlcQBM0bonBhJO1lVhRzwDv2kGnV2Kt9DiWiaE5yi
KStXzmW7CXEk4jYeI8Aq/EbPlixjmjhPg14V6DDRSNYTutRZQPsTmJZElCezElCm
UxPyBF0zOTYtLlsVNeriP56mklpAv6y7K+QBZiWjEQ4TSV8Nsdo3GKZHXo2o3R6V
Tq2qfkCDGlnZdRHQt/HrR3LQyJHH/e5a/4FZ7+olfHhOu7BqWd3FULN++mjYm91p
WtAh2B8fwT8sYXeOwrsgQieJiEk03Se8bcBqCThD3gIgs4LLP9tx1u4yEVONS/Bj
plt37IfeSBt6UqyVJwnCKTQ3mS6+8y9Jey9mgzD4i9o/dkxcoWnu5HaKIAUamsi6
i0wdXWXbYQ87Wtg9hMzrUCz/dX/gSWhwWkwMf40FtNoopUi8Dg4=
=DKoq
-----END PGP SIGNATURE-----

--Sig_/bbzB5yjupMWTg1=+a1ZD+U9--
