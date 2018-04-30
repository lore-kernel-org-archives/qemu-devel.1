Received: from eggs.gnu.org ([2001:4830:134:3::10]:44793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fD5YO-0003gz-Hd
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fD5YL-0005HH-DB
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:57:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fD5YL-0005Gz-7f
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:57:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3CFE4023457
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 09:56:57 +0000 (UTC)
Date: Mon, 30 Apr 2018 10:56:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180430095649.GC4002@stefanha-x1.localdomain>
References: <20180418090239.13090-1-peterx@redhat.com>
	<20180418090239.13090-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <20180418090239.13090-2-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] monitor: rename out_lock to mon_lock
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


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2018 at 05:02:37PM +0800, Peter Xu wrote:
> The out_lock was only protecting out buffers.  In the future the monitor
> code will start to run in multiple threads.  We turn it into a bigger
> lock to protect not only the out buffer but also all the rest.  We split
> this lock until necessary.  So far I don't see a reason to complicate
> lock usage for monitors.
>=20
> Since at it, arrange the Monitor struct a bit.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 39 ++++++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 21 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index 39f8ee17ba..c93aa4e22b 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -202,20 +202,17 @@ typedef struct {
> =20
>  struct Monitor {
>      CharBackend chr;
> +    /* We can't access guest memory when holding the lock */
> +    QemuMutex mon_lock;

Please document which field this lock protects.  For example, outbuf and
out_watch need a comment.

>      int reset_seen;
>      int flags;
>      int suspend_cnt;            /* Needs to be accessed atomically */
>      bool skip_flush;
>      bool use_io_thr;
> -
> -    /* We can't access guest memory when holding the lock */
> -    QemuMutex out_lock;
>      QString *outbuf;
>      guint out_watch;

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa5uhhAAoJEJykq7OBq3PIwC4H/A0ISQFk6Dkoh0Rcg2goEqHX
F90prjBaV/2Tc7x8vUjqZWrrbs06Hr0sTt/y8rSW2c2vbBAhxufAvjFU+sOMBw6e
KB9HXHOaLKPXwxSDUKSGtnLPWRyw45SFm0bm64uQseQIZeuY2u83//gSgZ/UjC1s
/g7jboU7rxZ8/W8AbEbYh5Hmotnh6ZqsjIvHbb5VW6LCNy5jzCulwb1rmjSif7A0
NQW1vlq3LKFefusv/GiOqPwgzV2dMvOBUcIGY6dPa9SpXLdKGc6LOlsR6aIYaV7O
N3Gk08o2TW6aB5y2zHn1OQwe9h6jIR38oxHvdVfhZZpiHg8rv/XGrvWaDQwpQ9M=
=sv7Z
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
