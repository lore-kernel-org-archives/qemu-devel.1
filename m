Received: from eggs.gnu.org ([2001:4830:134:3::10]:60764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fih6P-0007vF-FB
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fih6M-0002Dx-EX
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:18:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59874 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fih6M-0002Dl-81
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:18:46 -0400
Date: Thu, 26 Jul 2018 15:18:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180726141843.GA438@stefanha-x1.localdomain>
References: <20180724142504.15092-1-stefanha@redhat.com>
	<20180724142504.15092-2-stefanha@redhat.com>
	<20180724143551.GK19167@redhat.com>
	<20180724144101.GL19167@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20180724144101.GL19167@redhat.com>
Subject: Re: [Qemu-devel] [PULL for-3.0 1/1] trace/simple: fix hang in child
 after fork(2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2018 at 03:41:01PM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Jul 24, 2018 at 03:35:51PM +0100, Daniel P. Berrang=E9 wrote:
> > On Tue, Jul 24, 2018 at 03:25:04PM +0100, Stefan Hajnoczi wrote:
> > > The simple trace backend spawns a write-out thread which is used to
> > > asynchronously flush the in-memory ring buffer to disk.
> > >=20
> > > fork(2) does not clone all threads, only the thread that invoked
> > > fork(2).  As a result there is no write-out thread in the child proce=
ss!
> > >=20
> > > This causes a hang during shutdown when atexit(3) handler installed by
> > > the simple trace backend waits for the non-existent write-out thread.
> > >=20
> > > This patch uses pthread_atfork(3) to terminate the write-out thread
> > > before fork and restart it in both the parent and child after fork.
> > > This solves a hang in qemu-iotests 147 due to qemu-nbd --fork usage.
> >=20
> > I'm not convinced this is safe, as it looks like it has a window in
> > which both the parent and child processes will be doing write-out to
> > the same file.
> >=20
> > In particular in the main QEMU system emulators it means that any
> > time we fork() in QEMU, eg for spawning commands with migration
> > exec: URI, or TAP devuce ifup scripts, etc, we'll be starting a
> > write-out thread in the child.
>=20
> I'd be more inclined to have the pthread_atfork() handle simply terminate
> the tracing process, reversing all effects of trace_init_backends(). Then
> after qemu-nbd has called fork(), it can simply call trace_init_backends()
> explicitly to start it running again. This avoids unecessarily starting
> tracing in child processes that are not requiring/expecting it.

Good point.

NACK

Stefan

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbWdhDAAoJEJykq7OBq3PIX6wH/jxPik6nih5rQC8SsUyW+9GA
KD90XxfWoy8A8+2VaT5M/ndnZydqtX2/SMVY3sTzHmko/jgguTbDxZNlpAXOwXLv
mbvX876u4cYvinlG6KERfKXasGGlTtBRrxAtAMc5NqeEQBk1sWGc5nI02g2nxdke
X2OBG8WRsLSrc4lWlPLoq6Uet7eln4piufR627f9wIQzv+wQaHqnbNkuU6P8JeZJ
d58qW9y8BjZgt3j/sk9kwKxcDC7S2dYk7lm0R0o3xBOBsaxNrtpdwQ2Vij4tE12K
YF3jPoDJRcCjV18O/jzrQKO7v2NC+HZTsMzHmy/mi7ZYhExwDjnaXYvAxRXw/II=
=odFy
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
