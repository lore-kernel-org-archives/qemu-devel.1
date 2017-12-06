Received: from eggs.gnu.org ([2001:4830:134:3::10]:39763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMXvr-0006Wm-TI
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMXvq-0007tP-Sl
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:32:07 -0500
Date: Wed, 6 Dec 2017 11:31:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171206113155.GB12584@stefanha-x1.localdomain>
References: <20171205104141.28882-1-stefanha@redhat.com>
	<20171205104141.28882-2-stefanha@redhat.com>
	<f69659d6-0bae-b510-3cd5-435e8fd4838a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <f69659d6-0bae-b510-3cd5-435e8fd4838a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/9] blockdev: hold AioContext for
 bdrv_unref() in external_snapshot_clean()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 08:36:32AM -0600, Eric Blake wrote:
> On 12/05/2017 04:41 AM, Stefan Hajnoczi wrote:
> > bdrv_unref() requires the AioContext lock because bdrv_flush() uses
> > BDRV_POLL_WHILE(), which assumes the AioContext is currently held.  If
> > BDRV_POLL_WHILE() runs without AioContext held the
> > pthread_mutex_unlock() call in aio_context_release() fails.
> >=20
> > This patch moves bdrv_unref() into the AioContext locked region to solve
> > the following pthread_mutex_unlock() failure:
> >=20
> >   #0  0x00007f566181969b in raise () at /lib64/libc.so.6
> >   #1  0x00007f566181b3b1 in abort () at /lib64/libc.so.6
> >   #2  0x00005592cd590458 in error_exit (err=3D<optimized out>, msg=3Dms=
g@entry=3D0x5592cdaf6d60 <__func__.23977> "qemu_mutex_unlock") at util/qemu=
-thread-posix.c:36
> >   #3  0x00005592cd96e738 in qemu_mutex_unlock (mutex=3Dmutex@entry=3D0x=
5592ce9505e0) at util/qemu-thread-posix.c:96
> >   #4  0x00005592cd969b69 in aio_context_release (ctx=3Dctx@entry=3D0x55=
92ce950580) at util/async.c:507
> >   #5  0x00005592cd8ead78 in bdrv_flush (bs=3Dbs@entry=3D0x5592cfa87210)=
 at block/io.c:2478
> >   #6  0x00005592cd89df30 in bdrv_close (bs=3D0x5592cfa87210) at block.c=
:3207
> >   #7  0x00005592cd89df30 in bdrv_delete (bs=3D0x5592cfa87210) at block.=
c:3395
> >   #8  0x00005592cd89df30 in bdrv_unref (bs=3D0x5592cfa87210) at block.c=
:4418
> >   #9  0x00005592cd6b7f86 in qmp_transaction (dev_list=3D<optimized out>=
, has_props=3D<optimized out>, props=3D<optimized out>, errp=3Derrp@entry=
=3D0x7ffe4a1fc9d8) at blockdev.c:2308
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  blockdev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> I know the series is too big/late for 2.11, but is this one patch worth
> having?

This fix is not critical for 2.11.  The bug shouldn't be triggered under
normal circumstances.

The bug was exposed while developing qemu-iotests 202, which uses
unconventional commands (blockdev-add to create BDSes with no -drive or
BlockBackend).

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJ9UrAAoJEJykq7OBq3PIJw8IAKnz2CfgKBUkSLr1aE4BdytX
c1KmpcSTCU+q8gqFI0/5xpaLBfvpdLZR4x6dKxZ5JXDZG2eYQlzTeC0atGkvzpAB
+4imK/65G7f7mzPqjlTnIhQmPCWRULyA5Syq7IeNXfN/py2/Lw4Z4dOSraqkhGPf
lyKHbk9CmYgWGTqs+nyKILSR1cbKuWK5HILqcDkcvJZU0x3ngoB8bIusYs6dxpDE
MOpNrbb/absAV2yfO4UFSJAoLZFWEEOr53pPGF2bwvGAYC0EOZddjv51WnSxjMNT
wcGeFVSRUvVXU0r91mx2SyH6XfDrZSpM3XnTVleAWmpzhIU5Hg5CJiwX8LHdL00=
=ngn3
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
