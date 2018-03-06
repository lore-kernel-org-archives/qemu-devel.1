Received: from eggs.gnu.org ([2001:4830:134:3::10]:58068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etB82-0004ZC-0A
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:51:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etB81-0004E3-6W
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:51:34 -0500
Date: Tue, 6 Mar 2018 11:51:24 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180306115124.GG31045@stefanha-x1.localdomain>
References: <7b01ba4b-7f5f-30c7-d6d8-3c22f2774e7e@kamp.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2NLGdgz3UMHa/lqP"
Content-Disposition: inline
In-Reply-To: <7b01ba4b-7f5f-30c7-d6d8-3c22f2774e7e@kamp.de>
Subject: Re: [Qemu-devel] [Qemu-block] Limiting coroutine stack usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--2NLGdgz3UMHa/lqP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 06:04:02PM +0100, Peter Lieven wrote:
> I remember we discussed a long time ago to limit the stack usage of all f=
unctions that are executed in a coroutine
> context to a very low value to be able to safely limit the coroutine stac=
k size as well.
>=20
> I checked through all functions in block/, migration/ and nbd/ and there =
are only very few larger or unbound stack
> allocations that can easily be fixed.
>=20
> Now my question: Is there an easy way to add a cflag like -Wstack-usage=
=3D2048 to all objects in a given directory only?
> I tried to add a llimit to the whole project, but fixing this will be a l=
arger task.

2KB is fine for QEMU code but actual coroutine stack sizes will have to
be at least 8KB, I guess, in order for third-party libraries to work
(e.g. curl, rbd).  PATH_MAX is 4KB on Linux.

Nested event loops in QEMU code can also result in deep call stacks.
This happens when aio_poll() invokes an fd handler or BH that also
invokes aio_poll().

Stefan

--2NLGdgz3UMHa/lqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanoC8AAoJEJykq7OBq3PIc2UH/2ZGwWJsqojVbkMJV2UV+KYt
4F1GaZ+zQMXSyw2CX3USzcT/tDwMz+35UQp1yJMjJkwwRvbR6/6dOdU7/ymfuTIL
GuNmL/+VZ3doTRdyca2caIWgZFJPtPExIvmQTRiyOb3Z5QGemTdx5b+bUX7WIPeX
eWsX8TmibQyfZQ1lue60hzG0aeYEsJTNlz+AsdkkDKcF4lpdo2RVuUxgPcvMFn/p
8nnWgFe8xSrIdlWQRxu5LTzCU5j0llasrpDtD891hGM/2ty03TGwmnW897xNPG9e
+Gijl28M6IjSXeKzZ2vBjTTqRVm7ZHYc2zQaAD/1lIYGBHAy/PEjDrFSUK7Tc4E=
=EOZO
-----END PGP SIGNATURE-----

--2NLGdgz3UMHa/lqP--
