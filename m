Received: from eggs.gnu.org ([2001:4830:134:3::10]:53091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fXNOK-0002Pr-LD
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fXNOF-0001ld-3x
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:02:32 -0400
Date: Mon, 25 Jun 2018 10:02:13 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180625090213.GB29002@stefanha-x1.localdomain>
References: <20180621170657.27542-1-kwolf@redhat.com>
	<20180621170657.27542-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20180621170657.27542-2-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] block: Convert
 .bdrv_truncate callback to coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 21, 2018 at 07:06:56PM +0200, Kevin Wolf wrote:
> bdrv_truncate() is an operation that can block (even for a quite long
> time, depending on the PreallocMode) in I/O paths that shouldn't block.
> Convert it to a coroutine_fn so that we have the infrastructure for
> drivers to make their .bdrv_co_truncate implementation asynchronous.

block/commit.c:commit_run() invokes blk_truncate() outside of a drained
region.  I haven't looked for other instances, but this patch opens the
door for races with other I/O requests.  Are you sure it's safe to make
this asynchronous without request serialization?

Stefan

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbMK+VAAoJEJykq7OBq3PIM3MIAKfJwx64RFPRmdBTdj4JFRYO
6PtH0aLl3Y3BMYSLTyoUd65dlZI5jKe4SRM9Hk/QMn3a3CCJWH2GrI05AOdbiu+X
0UCGhmhLykYaNjlbOuiGOxkEav4NuPA6QmC2wP9CRyN4DNNQSjpxL5feh+MBQRvI
85gEgwPFOKjq+HGjsW5CO087TiQo4rftU4sDb+Mi7zMdxkqlcuxn1tzSVpGbV8BB
zCBjysiWCQFQMsY3PsZJRbTYEak4yThF2rfyX102sPVg+xjRA2TXmB5vWcOXmVaN
2bOLsIiLP9ZqYfGfHGkS7x8I/aCV5hqi4X6eHsS0YxOcsXdkFz54tiueNOdeGos=
=soV3
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
