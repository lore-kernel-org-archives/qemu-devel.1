Received: from eggs.gnu.org ([2001:4830:134:3::10]:46733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ejS1h-0002B5-Ac
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ejS1g-0003zp-DT
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:52:49 -0500
Date: Wed, 7 Feb 2018 15:52:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180207155222.GB1446@stefanha-x1.localdomain>
References: <20180201110708.8080-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20180201110708.8080-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] vl: pause vcpus before stopping
 iothreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2018 at 11:07:08AM +0000, Stefan Hajnoczi wrote:
> Commit dce8921b2baaf95974af8176406881872067adfa ("iothread: Stop threads
> before main() quits") introduced iothread_stop_all() to avoid the
> following virtio-scsi assertion failure:
>=20
>   assert(blk_get_aio_context(d->conf.blk) =3D=3D s->ctx);
>=20
> Back then the assertion failed because when bdrv_close_all() made
> d->conf.blk NULL, blk_get_aio_context() returned the global AioContext
> instead of s->ctx.
>=20
> The same assertion can still fail today when vcpus submit new I/O
> requests after iothread_stop_all() has moved the BDS to the global
> AioContext.
>=20
> This patch hardens the iothread_stop_all() approach by pausing vcpus
> before calling iothread_stop_all().
>=20
> Note that the assertion failure is a race condition.  It is not possible
> to reproduce it reliably.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Add comment explaining rationale for this ordering and why it's safe.
>    [Kevin]
>=20
>  vl.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaeyC2AAoJEJykq7OBq3PIHXsIAJbcSlPYJ8TqRJGWIwbvfaSu
BFBZupfDLfX7clzNyrPWiW7UIDt1Fa4oCFNq5gc1/X18DJwBt+L5IgsSwF+01ibs
2tibQMc7AIHU8SFDgdLqYaHQock4FqVN5/zveJVMhw2ypy8Eq+c2dvNirURjVYmo
YWLsumYJX1ECkUe6myanyxCeT75vCRbGY1wD4SFyAAnJ2TpZddVsnqF6A5XinHm2
2xASMBuyVyfgTQ1mAcG8wpoNU4rWuD8pSfrNJ0d4+qtRyPLK5B7FF7lRMY7RadQ9
wydIlRNdKVcs1R6e21620+hOX130EorLS9lbmPtRh22PQ8tH/cYJMGltUeTZ1a0=
=3Mp6
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
