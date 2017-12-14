Received: from eggs.gnu.org ([2001:4830:134:3::10]:40300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePTo7-0005Fm-0V
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePTo1-0004By-3l
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:44:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePTo0-0004BC-So
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:44:09 -0500
Date: Thu, 14 Dec 2017 13:43:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214134359.GJ14433@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-22-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2uG6jHjFLimDtBY"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-22-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 21/26] qmp: isolate responses into io
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


--J2uG6jHjFLimDtBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:55PM +0800, Peter Xu wrote:
> @@ -4429,6 +4515,13 @@ void monitor_cleanup(void)
>       */
>      iothread_stop(mon_global.mon_iothread);
> =20
> +    /*
> +     * After we have IOThread to send responses, it's possible that
> +     * when we stop the IOThread there are still replies queued in the
> +     * responder queue.  Flush all of them.
> +     */
> +    monitor_qmp_bh_responder(NULL);

This doesn't work because monitor_qmp_bh_responder() does not guarantee
that the full response has been written when it returns.

When qemu_chr_fe_write() returns EAGAIN then qemu_chr_fe_add_watch() is
used to register an event loop callback when the chardev becomes
writable again.  But you stopped the event loop using iothread_stop() so
we will never complete the write.

I suggest draining the monitor while the IOThread is still running
(that way the AioContext and GMainContext are still operational).  You
can:
1. Suspend the monitor so new commands will not be read.
2. Wait until all responses and outbuf are empty.

Another option is moving the chardev back to the main loop but I'm not
sure if the chardev subsystem supports that.

--J2uG6jHjFLimDtBY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMoAfAAoJEJykq7OBq3PIVW4H/A+4VuFlZ6Uc7HLirap39E9W
2qoS3AKVOrL1l2sHA5O6ByN9U0QwEBiLJU6RimcjlHUzg7z0BG4rKc0U/N8I/LpC
VQzA5P+5DgJBwKs0vCPeowpo5z1ovKK1WthAVH7boQ/7hfcyMRp2+7f31WI3vLim
eyVHRi84ahES1wPSUiIhIqxZGRbG5SeXadPLdbWYR3u/myY7tVHG1rENHhRrmy3b
165b7mgfc9DrYTZxFxllp7NjDQZa5pCuSDhfveBXEzbrWe/wBMBqYHDIPHfKOzBv
HJRbFNkq7WXCo+krAozZxNJ9+VV1bwqbPb51A5y9cnoJtvSMWs7m0fHQpjTavnA=
=+pvI
-----END PGP SIGNATURE-----

--J2uG6jHjFLimDtBY--
