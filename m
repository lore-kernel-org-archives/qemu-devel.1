Received: from eggs.gnu.org ([2001:4830:134:3::10]:49924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoYRc-0006zA-0s
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoYRY-00085F-TN
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:44:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36520 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eoYRY-00084t-PG
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:44:36 -0500
Date: Wed, 21 Feb 2018 17:44:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180221174419.GK21436@stefanha-x1.localdomain>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-20-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/rDaUNvWv5XYRSKj"
Content-Disposition: inline
In-Reply-To: <20180124053957.29145-20-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 19/23] qmp: isolate responses into io
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--/rDaUNvWv5XYRSKj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 01:39:53PM +0800, Peter Xu wrote:
> For those monitors who have enabled IO thread, we'll offload the
> responding procedure into IO thread.  The main reason is that chardev is
> not thread safe, and we need to do all the read/write IOs in the same
> thread.  For use_io_thr=3Dtrue monitors, that thread is the IO thread.
>=20
> We do this isolation in similar pattern as what we have done to the
> request queue: we first create one response queue for each monitor, then
> instead of replying directly in the main thread, we queue the responses
> and kick the IO thread to do the rest of the job for us.
>=20
> A funny thing after doing this is that, when the QMP clients send "quit"
> to QEMU, it's possible that we close the IOThread even earlier than
> replying to that "quit".  So another thing we need to do before cleaning
> up the monitors is that we need to flush the response queue (we don't
> need to do that for command queue; after all we are quitting) to make
> sure replies for handled commands are always flushed back to clients.
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 95 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/rDaUNvWv5XYRSKj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaja/zAAoJEJykq7OBq3PIViEIAJ3xxyOk3y+rGGbCokIeQNEo
ygSCV8W2jLOUNpZt6qm8/wg4sq7qGZ6MCC6epeHyjJ+VIwvuH0l5a2u+YNwNfAyM
HWiLknMmoQRF4u5t9NxtgJLvsapcQzgS8thYw1uS2dfp+MTcXKOW6gGoBEW2W4Uo
JeptphvAEsAZF1adlQDC2LKwwEpBmkSz3W0ZXB58QxCRZTektfkONzwj+Tmisp35
AJMsJU1m4n01rErTMkpe1mPMuqpORBXiN9/n9T+jtTlKXB/zp0eIdeAElZAUV64H
jUP7e3R49/kWkqmQ0scDx9/NAed3N4T8vDTy5yox7vWATpzAs8wRMfBH9690amk=
=ky+U
-----END PGP SIGNATURE-----

--/rDaUNvWv5XYRSKj--
