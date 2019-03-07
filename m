Received: from eggs.gnu.org ([209.51.188.92]:49216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1uCR-000620-VH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1uCQ-0001wl-UL
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:40:43 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:36048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1h1uCQ-0001sX-LV
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:40:42 -0500
Received: by mail-wm1-x334.google.com with SMTP id j125so9526851wmj.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 06:40:42 -0800 (PST)
Date: Thu, 7 Mar 2019 14:40:39 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190307144039.GG2843@stefanha-x1.localdomain>
References: <20190306115532.23025-1-peterx@redhat.com>
	<20190306115532.23025-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Content-Disposition: inline
In-Reply-To: <20190306115532.23025-5-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] iothread: push gcontext earlier in
 the thread_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 06, 2019 at 07:55:31PM +0800, Peter Xu wrote:
> +    /*
> +     * We should do this as soon as we enter the thread, because the
> +     * function will silently fail if it fails to acquire the
> +     * gcontext.
> +     */
> +    g_main_context_push_thread_default(iothread->worker_context);

I have a hard time understanding this comment.  The mention of how it
fails makes me think "we'll never find out about failures anyway, so how
does it help to call this early?".

I suggest sticking to the point that this function must always be called
first:

  /*
   * g_main_context_push_thread_default() must be called before anything
   * in this new thread uses glib.
   */

Now people will think before moving this function call.

Stefan

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgS1nAAoJEJykq7OBq3PIwQ0H/j98bNklG91RyMTwSsXFAqg0
C/wtc6zCPbGfA7lCVV4e5CIxExgx+5WMWEFjacUq5+ZHMGWHlaanRhO8GvukRhcf
cVe/5qKSBvaVSYq0emUacqqWF2386XIu3YKR96+YHhmhhTUVSy8uYVb7s5aNO0Di
SiS/T07Ssg1x9XtBs0qElyMHyNSKOprWAF9Ayf+VsriaIFOFDqvrA5lt9qIb3U1T
/1cfllSSheO3VzNl6hEnoedruiFAbwlmkEuNUQjb0tt1RrsxSZ/IjiOMScC296aS
gcxYaqXnaOHyCg28jDm6aiV6o9FkGT9+qP3ZTrkLjIvIoYBYZvjnHQI9btXHgLY=
=qZXY
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--
