Received: from eggs.gnu.org ([2001:4830:134:3::10]:59585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emFpI-0000jV-ME
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:27:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emFpF-0002Hg-Cs
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:27:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1emFpF-0002H8-6X
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:27:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E1DF40FB64F
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 09:27:32 +0000 (UTC)
Date: Thu, 15 Feb 2018 09:27:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180215092730.GA23321@stefanha-x1.localdomain>
References: <20180213142102.14450-1-stefanha@redhat.com>
	<20180213142102.14450-2-stefanha@redhat.com>
	<73eb771d-ddcd-42e6-5895-23e6024ccc80@redhat.com>
	<20180214140647.GC7545@stefanha-x1.localdomain>
	<8894e9fa-8e3d-ecfe-07f4-61a465f4bf57@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <8894e9fa-8e3d-ecfe-07f4-61a465f4bf57@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block: extract AIO_WAIT_WHILE()
 from BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 04:31:45PM -0600, Eric Blake wrote:
> On 02/14/2018 08:06 AM, Stefan Hajnoczi wrote:
> > On Tue, Feb 13, 2018 at 10:01:06AM -0600, Eric Blake wrote:
> > I hope this explains things!  The main issue that raised these questions
> > was that aio_context_in_iothread() has a misleading name.  Shall we
> > rename it?
>=20
> Maybe, but that's a separate patch.  What name would we bikeshed, maybe
> aio_context_correct_thread() (we are the correct thread if we are the
> iothread that owns ctx, or if we are the main thread and have properly
> acquired ctx)=20

Having acquired the AioContext does not make this function return true.
The semantics are:
1. Current thread is the IOThread that runs the AioContext
2. Current thread is the main loop and the AioContext is the global
   AioContext.

The function tests whether the current thread is the "native" or "home"
thread for this AioContext.  Perhaps we could also call it the "poller"
thread because only that thread is allowed to call aio_poll(ctx, true).

  if (aio_context_in_native_thread(ctx)) {
      ...
  } else {
      ...
  }

What do you think?

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJahVKCAAoJEJykq7OBq3PI2qEIALsOIcVdEEq1j/xk6SMAn5PX
V8HJASDshsNhq86Ov1Tsi5rjGAaJn9XQ/43yi4/igVNDKKHCwZjHpQYZ9AxMQJx8
am/ukwJ7cgmwvoWkGIHB1NCeAxJjYDo6mRTlGeTIAZ6cK+w2xQNkASUxT8v+Jdvs
yiRVInQ1yvxu3UEk9bW2wbYE/h2xvFs1G72p2YASTR1xhZ6YJRq5XRkOpACuo656
QhtLnFEbfamqbSYLjCUmfw8kkiQGFgXFVCPPxUr8HNVZ9bLjpknjqPR4bXWLSbzV
5FFqXQKb4F3Txg7raj8E7pLCxWlzqD6RvNPvmDVANM8GkB84GlBWa3tRtulsMC4=
=Xou3
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
