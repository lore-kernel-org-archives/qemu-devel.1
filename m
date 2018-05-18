Received: from eggs.gnu.org ([2001:4830:134:3::10]:37141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fJhNE-00049t-TG
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fJhNA-0006C8-Rf
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:32:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fJhNA-0006Br-M7
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:32:48 -0400
Date: Fri, 18 May 2018 16:32:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180518153246.GE31915@stefanha-x1.localdomain>
References: <152646971421.34839.18198173866060880395.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EXKGNeO8l0xGFBjy"
Content-Disposition: inline
In-Reply-To: <152646971421.34839.18198173866060880395.stgit@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--EXKGNeO8l0xGFBjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 01:21:54PM +0200, Greg Kurz wrote:
> Removing a drive with drive_del while it is being used to run an I/O
> intensive workload can cause QEMU to crash.
>=20
> An AIO flush can yield at some point:
>=20
> blk_aio_flush_entry()
>  blk_co_flush(blk)
>   bdrv_co_flush(blk->root->bs)
>    ...
>     qemu_coroutine_yield()

I'm surprised you didn't hit another crash later on with this patch
applied.  What happens to this completion after you've set blk->root =3D
NULL?

> and let the HMP command to run, free blk->root and give control
> back to the AIO flush:
>=20
>     hmp_drive_del()
>      blk_remove_bs()
>       bdrv_root_unref_child(blk->root)
>        child_bs =3D blk->root->bs
>        bdrv_detach_child(blk->root)
>         bdrv_replace_child(blk->root, NULL)
>          blk->root->bs =3D NULL
>         g_free(blk->root) <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D blk=
->root becomes stale
>        bdrv_unref(child_bs)
>         bdrv_delete(child_bs)
>          bdrv_close()
>           bdrv_drained_begin()
>            bdrv_do_drained_begin()
>             bdrv_drain_recurse()
>              aio_poll()
>               ...
>               qemu_coroutine_switch()
>=20
> and the AIO flush completion ends up dereferencing blk->root:
>=20
>   blk_aio_complete()
>    scsi_aio_complete()
>     blk_get_aio_context(blk)
>      bs =3D blk_bs(blk)
>  ie, bs =3D blk->root ? blk->root->bs : NULL
>             ^^^^^
>             stale
>=20
> The solution to this user-after-free situation is is to clear
> blk->root before calling bdrv_unref() in bdrv_detach_child(),
> and let blk_get_aio_context() fall back to the main loop context
> since the BDS has been removed.

QEMU should drain I/O requests before making block driver graph changes.
I think the drained region in blk_remove_bs() needs to begin earlier so
that requests are completed before we begin to change things.

Stefan

--EXKGNeO8l0xGFBjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa/vIeAAoJEJykq7OBq3PI1t8H/R9PFVIUEIhDpPDvhL8fn5QQ
K82LIemrPKxd4i1+0YW1HWodndc0DUniiUg4M/T3YWfGK8SvrRmvSwAjmVpuzc9m
XtTSmgXT5O2NOkKaggdz/LS/5GO/iI27A28LME0zPagFwHwhZorg7nKsXm+402sA
/n39FzlG1dkTdmZ6bYTjW4dsCSqMKVohQEZXzOvTWhBCyfR0xYryipVdKLh9R5Fa
bkpO95XFKy4F20fRO/SqGo4fAfZzPrwgRlnzSfyrOw5jPnBil1wPF8tKHALNiGba
5JKtSFJRA/V7ewIp/W5QAwES1P7uHyJtyMVjNUr4rSfAokpUJjOFDWAU8aL+fhU=
=RNXx
-----END PGP SIGNATURE-----

--EXKGNeO8l0xGFBjy--
