Received: from eggs.gnu.org ([2001:4830:134:3::10]:48919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fhafR-00030j-M5
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fhafN-0005BT-61
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:14:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fhafM-0005As-VV
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:14:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 402D940241CC
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 13:14:20 +0000 (UTC)
Date: Mon, 23 Jul 2018 14:14:18 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180723131418.GB20596@stefanha-x1.localdomain>
References: <20180717101944.11691-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20180717101944.11691-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] trace/simple: fix hang in child after
 fork(2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2018 at 11:19:44AM +0100, Stefan Hajnoczi wrote:
> The simple trace backend spawns a write-out thread which is used to
> asynchronously flush the in-memory ring buffer to disk.
>=20
> fork(2) does not clone all threads, only the thread that invoked
> fork(2).  As a result there is no write-out thread in the child process!
>=20
> This causes a hang during shutdown when atexit(3) handler installed by
> the simple trace backend waits for the non-existent write-out thread.
>=20
> This patch uses pthread_atfork(3) to terminate the write-out thread
> before fork and restart it in both the parent and child after fork.
> This solves a hang in qemu-iotests 147 due to qemu-nbd --fork usage.
>=20
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v3:
>  * Hold trace_lock across fork() to prevent possibility of another
>    thread holding it and disappearing [Paolo]
>=20
>  trace/simple.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 71 insertions(+), 9 deletions(-)

Thanks, applied to my tracing tree for 3.0:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbVdSqAAoJEJykq7OBq3PIu1gH/jahwXe21Dd3IpjDFB89aDdc
r2eFN6Sh8eSoM4XaM2ap8zVDM9JnD+8XJvRoYBWnyHNgPRu78W16AbPYZ5iZk4jr
MBlsYda4+0mfkJI7GGLA1kKkJ9U+9XLffGyZRiG8pJfhnVwH3VIHBXFjdib/Fqvf
/dqY+sy9tc1d7aAyuTSbArAcTx0QZAXvGPj/tQn+ZMdUldh+cGiqNZJzkt33f+fN
yfzRSmnh5j4ySM91w8CeMTPj4lGX4C9yo0ei955/3pCeYotuKoAOTnPYQSOqM18j
UW+DmG7NsLYzCY/UjgOlWQJmb7cYAJDzcj5abo7jh1u9gaSSFQhod4lJCOT1Ctk=
=hsdx
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
