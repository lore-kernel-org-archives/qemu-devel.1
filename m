Received: from eggs.gnu.org ([209.51.188.92]:55902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEEwS-0002LW-NG
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEEkl-00050g-Nf
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:03:08 -0400
Date: Wed, 10 Apr 2019 16:03:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190410150303.GC11035@stefanha-x1.localdomain>
References: <20190409122823.12416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <20190409122823.12416-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0?] aio-posix: ensure poll mode is
 left when aio_notify is called
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2019 at 02:28:23PM +0200, Paolo Bonzini wrote:
> With aio=3Dthread, adaptive polling makes latency worse rather than
> better, because it delays the execution of the ThreadPool's
> completion bottom half.
>=20
> event_notifier_poll() does run while polling, detecting that
> a bottom half was scheduled by a worker thread, but because
> ctx->notifier is explicitly ignored in run_poll_handlers_once(),
> scheduling the BH does not count as making progress and
> run_poll_handlers() keeps running.  Fix this by recomputing
> the deadline after *timeout could have changed.
>=20
> With this change, ThreadPool still cannot participate in polling
> but at least it does not suffer from extra latency.
>=20
> Reported-by: Sergio Lopez <slp@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@gmail.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <1553692145-86728-1-git-send-email-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: use qemu_soonest_timeout to handle timeout =3D=3D -1
>  util/aio-posix.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrgWnAAoJEJykq7OBq3PIjywIAIYjMKHjVNwEQGlLNJRHLlSQ
PHejF26dHEYZxCCQkOl8VNrugqewMktEsLiyKpNMClgnWAy+mSyMGr5jFk02v2WB
Up0Ulyh8mCHNlRDWHkbJ/68Bwu5IEYJG9VsmKvMVsAsp8JfghUnaZk1EX77xEC5V
ET2koBSudiReu3UvV1HJiNrUP0eFMrpQgmaIzJS7Dyi0cL7RC7zSF+wQ04xYbTlp
iQ3AylU0CbC3cTo9s7OZbCzLaYcdG7isL1ZIcPCBhMIxydyOgmhVsZ0MiK4XvJUs
EYoBFMUcZIROqcqtGpr3L0EhE1nSV5NsCQ05ZDEYfQI9TiJs90sRNwqT9vfJuBU=
=bF7p
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
