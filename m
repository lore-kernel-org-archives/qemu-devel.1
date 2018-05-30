Received: from eggs.gnu.org ([2001:4830:134:3::10]:39661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO44y-0001LQ-C6
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO44t-0001lR-Fd
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:36:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fO44t-0001ks-Ao
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:35:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9A70400E9BA
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:35:58 +0000 (UTC)
Date: Wed, 30 May 2018 17:35:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530163552.GG5973@stefanha-x1.localdomain>
References: <20180529055755.12404-1-peterx@redhat.com>
	<20180529055755.12404-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Content-Disposition: inline
In-Reply-To: <20180529055755.12404-6-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 5/7] monitor: remove event_clock_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29, 2018 at 01:57:53PM +0800, Peter Xu wrote:
> Instead, use a dynamic function to detect which clock we'll use.  The
> problem is that the old code will let monitor initialization depends on
> qtest_enabled().  After this change, we don't have such a dependency any
> more.

There is a hidden dependency:

  monitor_get_clock() returns the wrong value before main() has
  processed command-line arguments.

Where is the guarantee that monitor_get_clock() is never called too
early?

At the least, monitor_get_clock() should call abort(3) if invoked too
early.  Even better would be an interface that cannot be used
incorrectly.

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDtLoAAoJEJykq7OBq3PIpx0H/RFYKh7xZcZOYxIkFLbhgNui
Yg8kXuuC7myMVakBiq31xbVrWe6FKRgPzegEfkFMT7+wp1+g846nQQFDYt+moOXu
JGZ6T+i4VcN02ntBx3u3lfXnvalTuYMEilDC5DAnd/guGo61jpk9tyl6q3E0oby7
Cidpeefa7EScLkCHomNb1vcyRlQerepHhTr9BcUfGa84nZW0XoFTdoYMUVIpeI3B
fANOCsAsyen4XtTXjuB0MZ/5swZpemxit+BQ+6+HdEOpbBT9zqiwJCuLLF2Huwjq
n0uyUArKZYsyBYiofWJe4t3MflvLaYwaHj2mtwVl+0QJ59fCFGXfeqRTIwyZUGE=
=yFpg
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
