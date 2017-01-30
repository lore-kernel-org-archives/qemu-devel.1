Received: from eggs.gnu.org ([2001:4830:134:3::10]:44180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYEEE-0000Pc-Mf
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYEEB-0002rl-Lc
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:50:50 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYEEB-0002rI-EY
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:50:47 -0500
Received: by mail-wm0-x241.google.com with SMTP id c85so77941879wmi.1
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:50:47 -0800 (PST)
Date: Mon, 30 Jan 2017 15:50:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130155044.GP2118@stefanha-x1.localdomain>
References: <20170120164322.21851-1-pbonzini@redhat.com>
	<20170120164322.21851-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pleSNuEbvnUYtMxG"
Content-Disposition: inline
In-Reply-To: <20170120164322.21851-8-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/17] nbd: convert to use qio_channel_yield
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com


--pleSNuEbvnUYtMxG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 05:43:12PM +0100, Paolo Bonzini wrote:
> +        aio_co_wake(s->recv_coroutine[i]);
> =20
> -    qemu_coroutine_enter(nbd_get_client_session(bs)->send_coroutine);
> +        /* We're woken up by the recv_coroutine itself.  */
> +        qemu_coroutine_yield();

This relies on recv_coroutine() entering us only after we've yielded -
otherwise QEMU will crash.  The code and comments don't make it obvious
why this is guaranteed to be safe.

--pleSNuEbvnUYtMxG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYj2DUAAoJEJykq7OBq3PIwNcH/37af6wwRzIeyT3UkHFvMkIu
k/j/oT/UolPUUzoNCVp/7PG0VvpOOiXVv4C1ng2n1K9DLcbAoh3GqIl1akznPbTo
bMZPh1qRd53rEcP4CRI9zsVxBsdtVhfS+pgDWVZasxU4EhiwCo8i/sqJ7jIhQckQ
aYaDzW4i6KU38dC0dsVB3zkT78pg7l5KHYo4P9o7R8zOiCs2fkmym0lirNPC+umB
EVc7Y0JpPBlCmzPWzHjIxr/3wj5EAVEhu9wWtVi3DKUrX1ymGwiyxDfhEsm14J31
aQDUhQXjfsFpqzQJxcdI1Ag/16MPVuXx33WtePvNVkKPRbVnjYTZfaQJAh+JtVY=
=NOeS
-----END PGP SIGNATURE-----

--pleSNuEbvnUYtMxG--
